Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73540494992
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359256AbiATIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:34:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241086AbiATIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:34:12 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20K8UTjp030775;
        Thu, 20 Jan 2022 08:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OsxXYYpnpnKEZcPtYMguiYwQkUhE07ZUhxDGK55P3u0=;
 b=L2jZbi1cSRzBx21Jkn7Wt0lSib1gleQcBHssi0wNYSiANThNHMNUdWXO6XoMZs/bt5KW
 uH2v1DKTfrDmYFh529rb9rR59sAunzT7I24CA7sqyNAoTduVDTg+RCku/xyPHyYCT8tg
 UUm4KFnkTpJ3xZRH0SPgTgmtGzl6NUMudxA076tghiohbmUsjX6h9YvHuGBDN2LuL+fO
 V5PVmeJSGxh7V7reBy2v3NJqsmU0ezyBuQTJX2+j0O7lmQW87GqbpC95CdpclUg8R8HT
 fpSJ496YG+YXo2tE8zGodtin8azCvZHNKGe5kNa0PnuM8WLxjuKTHexBYtZVLbwAJzTL OQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq0rduu1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 08:34:12 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20K8XvEL031328;
        Thu, 20 Jan 2022 08:34:10 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3dknw9vxhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 08:34:09 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20K8Y6tv46399836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 08:34:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56B7E11C050;
        Thu, 20 Jan 2022 08:34:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0222411C069;
        Thu, 20 Jan 2022 08:34:06 +0000 (GMT)
Received: from [9.171.35.3] (unknown [9.171.35.3])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 08:34:05 +0000 (GMT)
Message-ID: <dbfec527-b995-e382-dafa-c3459e1e45ed@linux.ibm.com>
Date:   Thu, 20 Jan 2022 09:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH v1 01/10] s390/uaccess: Add storage key checked access
 to user memory
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118095210.1651483-1-scgl@linux.ibm.com>
 <20220118095210.1651483-2-scgl@linux.ibm.com> <YefeakONMN4PLlml@osiris>
 <422595a5-b24b-8760-ff0e-112322142de7@linux.ibm.com>
 <YegQCTqEsiFTUZ2R@osiris>
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
In-Reply-To: <YegQCTqEsiFTUZ2R@osiris>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1C0e0_hKvi77xjgtN13nOzw2G_QP7Gut
X-Proofpoint-ORIG-GUID: 1C0e0_hKvi77xjgtN13nOzw2G_QP7Gut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=560 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/22 14:20, Heiko Carstens wrote:
> On Wed, Jan 19, 2022 at 12:02:34PM +0100, Janis Schoetterl-Glausch wrote:
>>> That's a lot of code churn... I would have expected that the existing
>>> functions will be renamed, get an additional key parameter, and the
>>> current API is implemented by defines which map copy_to_user() &
>>> friends to the new functions, and add a zero key.
>>
>> I don't think I understand you. I can implement raw_copy_from/to_user
>> in terms of raw_copy_from/to_user_with_key, which does save a few lines,
>> but that's it, isn't it?
> 
> Right you are. I only looked at your patch, and forgot about that all
> the wrapping is nowadays done in common code.
> 
> So what I really don't like about this approach is that we get an arch
> specific copy_to_user() implementation back. This means that all those
> extra calls like might_fault(), instrument_copy_to_user(), and friends
> now have to be kept in sync by us again, if new instrumentation or
> security options are added to common code.
> 
> Given that this is manual work / monitoring I'm sure this will not
> work in the mid or long term, like it has been proven several times in
> the past for other features. We need something better, which works
> out-of-the-box wrt common code changes / enhancements.

What are our options?

1. Tooling
   1.1 Automatic monitoring
   1.2 ?
2. Implementation changes
   2.1 Modify common code
   2.2 Don't modify common code, pass key argument via well known location
   2.3 ?

Neither of 2.1 and 2.2 seem great.
How might 1.1 work? A build error if they are out of sync?
