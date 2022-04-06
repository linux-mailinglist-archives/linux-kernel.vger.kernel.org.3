Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925054F6936
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiDFSMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbiDFSMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:12:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51E1CEA70;
        Wed,  6 Apr 2022 09:49:03 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236GmoeX027503;
        Wed, 6 Apr 2022 16:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=J/ySBrEZ3U6k45cbB8swX7zNGgUHrk7eH1vaVC17t0E=;
 b=R1ucG1yEV2i7PrPyCyty1ruD/yff32pWEpfM73aDX1zBi/69radN+wD36jomZsp4OLPT
 QxN8sSV4axzfSMkQ9ZwGhm2ilffpq3lSFI7L2z2sqoytkK96xashtXsNtQS5AeJAcMTn
 pT/bWisvWMuFfwhPgMdz2D+1u/K8MdEfyLSEFzDLi3mCmCCeh1c8230X2bByVRY1+3Sw
 Y6OKJf4gEkczXnH0e7fKi0Mm/PkohCshh8kdv6PcIxxGgemW/1BqEMsXO9gGPBZ7VNOr
 AD/yWSTLFOFUvZJ6quO8td4PabOE5kvMv0XuHVBUentjDaeZzKXqDjmyOiuHFDVx3uaN bg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f8txywub8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 16:48:56 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236GhGI1007164;
        Wed, 6 Apr 2022 16:44:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3f6e48xrrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 16:44:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236Gikui45285744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 16:44:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 008A14C052;
        Wed,  6 Apr 2022 16:44:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FCE64C044;
        Wed,  6 Apr 2022 16:44:38 +0000 (GMT)
Received: from [9.145.170.20] (unknown [9.145.170.20])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Apr 2022 16:44:38 +0000 (GMT)
Message-ID: <6208840a-bb97-6b45-7b8e-80ad79849129@linux.ibm.com>
Date:   Wed, 6 Apr 2022 18:44:37 +0200
Subject: Re: [PATCH V2] s390: Simplify the calculation of variables
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Ykq2H+POaGs0GHVU@osiris>
 <1649212651-32038-1-git-send-email-baihaowen@meizu.com>
 <Yk1TOpjLnmUcRQt3@osiris>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <Yk1TOpjLnmUcRQt3@osiris>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -zcfcv6cSSOWPx79FCW8EweoJJnrqR7M
X-Proofpoint-ORIG-GUID: -zcfcv6cSSOWPx79FCW8EweoJJnrqR7M
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_09,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.2022 10:45, Heiko Carstens wrote:
> On Wed, Apr 06, 2022 at 10:37:31AM +0800, Haowen Bai wrote:
>> Fix the following coccicheck warnings:
>> ./arch/s390/include/asm/scsw.h:695:47-49: WARNING
>>  !A || A && B is equivalent to !A || B
>>
>> I apply a readable version just to get rid of a warning.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
>> ---
>> V1->V2: apply a readable and simple version as suggestion.
>>
>>  arch/s390/include/asm/scsw.h | 47 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> [full quote below]
> 
> Vineeth, Peter, could one of you please Review and or ACK the patch
> below?

This patch changes scsw->cmd access to scsw->tm access, which is
incorrect, so I cannot ACK them as is.

Also I'm somewhat torn on the general question if these functions should
be changed:

- the current implementation is unreadable => change it
- the current implementation works => keep it
- improvement patches like this one seem to appear regularly and consume
  time in reviewing => change it

If there was a new version that really improved readability, this would
be really welcome. The problem is that the definition of readability is
special for these functions: each of these functions implement a
validity check based on text from the s390 Principles of Operations
(PoP) document [1]. "Readable" for myself would mean: I can easily
correlate the code to the text from the PoP so that I can spot errors or
adjust code to changed text.

I'm adding some examples how that could look like below. My question to
the original author would be, if this is something they could implement,
or if we'd rather do that at some point in time in the future by ourselves.

>> diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
>> index a7c3ccf681da..b7e65f96de3c 100644
>> --- a/arch/s390/include/asm/scsw.h
>> +++ b/arch/s390/include/asm/scsw.h
>> @@ -508,9 +508,13 @@ static inline int scsw_cmd_is_valid_zcc(union scsw *scsw)
>>   */
>>  static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
>>  {
>> -	return (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
>> -	       !(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) &&
>> -	       (scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS);
>> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
>> +		return 0;
>> +	if (scsw->tm.stctl & SCSW_STCTL_INTER_STATUS)
>> +		return 0;
>> +	if (scsw->tm.stctl & SCSW_STCTL_ALERT_STATUS)
>> +		return 1;
>> +	return 0;
>>  }

Here's the PoP text that is the base for this function (note ECTL=E):

"The E bit is meaningful whenever the subchannel is status pending with
alert status either alone or together with primary status, secondary
status, or both."

A readable version for me would therefore contain code that can easily
be matched against that text, e.g. something like:

/* Must be status pending. */
if (!(scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND))
  return 0;

/* Must have alert status. */
if (!(scsw->cmd.stctl & SCSW_STCTL_ALERT_STATUS))
  return 0;

/* Must be alone or together with primary, secondary or both,
 * => no intermediate status. */
if (scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS)
  return 0;

return 1;

>>  /**
>> @@ -522,10 +526,15 @@ static inline int scsw_cmd_is_valid_ectl(union scsw *scsw)
>>   */
>>  static inline int scsw_cmd_is_valid_pno(union scsw *scsw)
>>  {
>> -	return (scsw->cmd.fctl != 0) &&
>> -	       (scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND) &&
>> -	       (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS) ||
>> -		  (scsw->cmd.actl & SCSW_ACTL_SUSPENDED));
>> +	if (!scsw->tm.fctl)
>> +		return 0;
>> +	if (!(scsw->tm.stctl & SCSW_STCTL_STATUS_PEND))
>> +		return 0;
>> +	if (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS))
>> +		return 1;
>> +	if (scsw->tm.actl & SCSW_ACTL_SUSPENDED)
>> +		return 1;
>> +	return 0;
>>  }

Here's the associated PoP text for this function (note: PNO=N)

"The N bit is meaningful whenever the status-control field contains any
of the indications listed below and at least one basic I/O function is
also indicated at the subchannel:
- Status pending with any combination of primary, secondary, or alert
  status
- Status pending alone
- Status pending with intermediate status when the subchannel is also
  suspended"

Again a readable version could look like:

/* Must indicate at least one I/O function. */
if (!scsw->cmd.fctl)
  return 0;

/* Must be status pending. */
if (!(scsw->cmd.stctl & SCSW_STCTL_STATUS_PEND))
  return 0;

/* Can be status pending alone, or with any combination of primary,
 * secondary and alert => no intermediate status. */
if (!(scsw->cmd.stctl & SCSW_STCTL_INTER_STATUS))
  return 1;

/* If intermediate, must be suspended. */
if (scsw->cmd.actl & SCSW_ACTL_SUSPENDED)
  return 1;

return 0;

The _tm_ functions below should be changed in the exact same way, while
accessing the corresponding data fields in scsw->tm instead of scsw->cmd.

>>  static inline int scsw_tm_is_valid_ectl(union scsw *scsw)
>>  static inline int scsw_tm_is_valid_pno(union scsw *scsw)

[1] https://www.ibm.com/support/pages/zarchitecture-principles-operation

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D
