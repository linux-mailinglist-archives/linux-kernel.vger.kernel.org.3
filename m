Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A1650FA68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348858AbiDZK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349233AbiDZK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:29:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4AD954BB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:04:15 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23Q8MC0f012876;
        Tue, 26 Apr 2022 10:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MIfTqTubI3eUOBVRbakpYFXdix2XEmWeLsX8jRsOeLc=;
 b=pgS4TjHWCePl0HOOc0/JRy1u2HVLfouFSHSnzQgZUPwrU6duLuweoIwnuTywI/MKPCbu
 WJ2s52BuDbvJWFQRCpD8qmg2T2ZSDpRGbL8xCT+VEiTWvwb5RjZ61tlwDd/d6iBzpDJg
 5T329UoDhkFo2WmSN99zUiHhcx5NA4KEiX6jOPV66oZICvG3E+Q4be24Yp2dKJ8U3+89
 cWgOle/Hh5u6IsXHAzYCzS27c+CZzOGO0S8qmgq7ZtJllu/1yT5XiPlXvFt9ScUXesZT
 MZlTt9D5A/4yqfRC6wVrCKS0vOIHreOeThwPJBQvaoTqt4br/M3bSLsfbtRyx4azfiQS dQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fp8eepvdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 10:04:06 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23Q9wwZA023777;
        Tue, 26 Apr 2022 10:04:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938u8x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Apr 2022 10:04:04 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23QA41V828705218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 10:04:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C464611C050;
        Tue, 26 Apr 2022 10:04:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC97B11C04A;
        Tue, 26 Apr 2022 10:03:59 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.82.112])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 26 Apr 2022 10:03:59 +0000 (GMT)
Date:   Tue, 26 Apr 2022 15:33:52 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool
Message-ID: <YmfDiO6KSRzo8C6e@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220426064001.14241-1-jvgediya@linux.ibm.com>
 <Yme97bRH3hLcqGfC@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yme97bRH3hLcqGfC@alley>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HDRg4Mgq9WKwq5rvOyFEnyiO-EWJka0A
X-Proofpoint-ORIG-GUID: HDRg4Mgq9WKwq5rvOyFEnyiO-EWJka0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_02,2022-04-25_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204260062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:39:57AM +0200, Petr Mladek wrote:
> On Tue 2022-04-26 12:10:01, Jagdish Gediya wrote:
> > At many places in kernel, It is necessary to convert sysfs input
> > to corrosponding bool value e.g. "false" or "0" need to be converted
> > to bool false, "true" or "1" need to be converted to bool true,
> > places where such conversion is needed currently check the input
> > string manually, kstrtobool can be utilized at such places but
> > currently kstrtobool doesn't have support to "false"/"true".
> >
> > Add "false"/"true" support to kstrtobool while string conversion
> > to bool. Modify existing manual sysfs conversions to use kstrtobool().
> 
> It looks reasonable. I would just do it slightly other way, see
> below.
> 
> > This patch doesn't have any functionality change.
> 
> This is not true. All kstrtobool() callers will react differently
> on the "true"/"false" input.

how? Is it related to performance as more characters are compared?
otherwise semantic wise they will get the expected response, correct?

> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > ---
> > change in v2:
> > Modified kstrtobool to handle "false"/"true". Removed
> > new function sysfs_strbool introduced in v1.
> > 
> >  lib/kstrtox.c   | 7 +++++++
> >  mm/migrate.c    | 6 +-----
> >  mm/swap_state.c | 6 +-----
> >  3 files changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/lib/kstrtox.c b/lib/kstrtox.c
> > index 886510d248e5..3a5e29557838 100644
> > --- a/lib/kstrtox.c
> > +++ b/lib/kstrtox.c
> > @@ -377,6 +377,13 @@ int kstrtobool(const char *s, bool *res)
> >  		}
> >  		break;
> >  	default:
> > +		if (!strncmp(s, "true", 4)) {
> > +			*res = true;
> > +			return 0;
> > +		} else if (!strncmp(s, "false", 5)) {
> > +			*res = false;
> > +			return 0;
> 
> It should be enough to check the first letter like we do in
> the other cases. I mean to set true when s[0] is 'T' or 't'
> and false when s[0] is 'F' or 'f'.

For "on" and "off", 2 characters are matched, so is it good enough
to compare only single character for strings "true" and "false"?

> Also please update comment above the function definition.
> 
> 
> > +		}
> >  		break;
> >  	}
> >  
> 
> Best Regards,
> Petr
> 
