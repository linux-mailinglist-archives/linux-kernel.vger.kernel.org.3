Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3149C5149F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359594AbiD2Mzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359582AbiD2Mzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:55:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DE7CAB95;
        Fri, 29 Apr 2022 05:52:25 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TCGbI6030219;
        Fri, 29 Apr 2022 12:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Ta1fyNf2U9jHeIRottQ/e61hn8ynFzXkSkb2SGz6/B0=;
 b=RyGh37gAnjuCCJYq3xyCOOUpKY9gP9mR89UyBS+bguTbFTI819tPxrwlmM4VUIJOYFw2
 cmR9FNJ0vvFJ9Z6GiOKFFPZaU0yFiz9XC4OxqFsVMss1Svjs3L0vLquW7ctOu7EQJApS
 5D+6MVtLen/zX+GbGQsvn19LPK3zzQzbMLdJEmfWUdVcZC0ikitvD9VQ9OZlaS0mR9Kp
 VKrGNx6GywA6hzcaYLmwXx7mkgaaV9OglcTrJGsKX5Q8yjLqPmuptcfgVOCqlRM2aqwE
 8Z+vPABnvxqo+OfU+iKz1cxIycirSVy+baS+8hSv1y6zqgwVkTES/ik0VjDt9iMYV3qg Ww== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqtvxkk63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 12:52:20 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23TCl5nm017236;
        Fri, 29 Apr 2022 12:52:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3fm93915dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 12:52:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23TCqFuj42860830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 12:52:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 265B1AE051;
        Fri, 29 Apr 2022 12:52:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0B1DAE045;
        Fri, 29 Apr 2022 12:52:14 +0000 (GMT)
Received: from [9.145.33.84] (unknown [9.145.33.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Apr 2022 12:52:14 +0000 (GMT)
Message-ID: <c1e91fc0-3d0e-979b-358b-01237a677b0a@linux.ibm.com>
Date:   Fri, 29 Apr 2022 14:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, svens@linux.ibm.com
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com, hoeppner@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <yt9dilr539wq.fsf@linux.ibm.com>
 <1650348310-18553-1-git-send-email-baihaowen@meizu.com>
From:   Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH V2] s390/dasd: Use kzalloc instead of kmalloc/memset
In-Reply-To: <1650348310-18553-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QnLeZxH7AmxS8Dv7Tbn-DWKMe5Vj0fJj
X-Proofpoint-GUID: QnLeZxH7AmxS8Dv7Tbn-DWKMe5Vj0fJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_06,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 mlxlogscore=620 adultscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290072
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.04.22 um 08:05 schrieb Haowen Bai:
> Use kzalloc rather than duplicating its implementation, which
> makes code simple and easy to understand.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: also remove the isglobal assigment above, so the whole else block
> could go away

thanks, applied!

