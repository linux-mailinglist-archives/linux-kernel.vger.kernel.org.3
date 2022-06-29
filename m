Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93645560727
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiF2RO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiF2RO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:14:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A4E3C710;
        Wed, 29 Jun 2022 10:14:54 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TGv3Ea032114;
        Wed, 29 Jun 2022 17:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=9WOghiGYjmTOE9cfm27FAgUV1NRqxvLgAiknvneQ3DQ=;
 b=aeOP5NpD4lWxt2YjPH1qcfdYIb0q6B7oQ9UD3SSdBm5XmRqtWMAmNySf0gtU9a34IMBX
 Q0yKdi6yPFNhM7ZCT0woLd/NpTlgHAmvNW1kpzMcAUH+JKvhnhtXxPYS8QkC5xJirzRa
 yhvIZcze1x66YPkjLsbX0x+9Yl6CAtXm3vV7wSIyHA52BnhysWm5TAFZsVT5yr7abYF2
 N7hLMqAG3t4kueAg9vGwcuLFu0U97r9FRaQVUCCe3d5day/G+KljVQVTeB1A4VOxV6R6
 hokYZKaLMJUlM+tKET/UkGVgAyIhfsXT6dW5bpwjkVkmh98qbGwpUrwszsdeA2MstEDg iw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0tnj0pr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 17:14:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25TH6FZg019425;
        Wed, 29 Jun 2022 17:14:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3gwt095468-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 17:14:49 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25THEkap21561740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:14:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53D2F11C050;
        Wed, 29 Jun 2022 17:14:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E360311C04A;
        Wed, 29 Jun 2022 17:14:45 +0000 (GMT)
Received: from osiris (unknown [9.145.11.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 29 Jun 2022 17:14:45 +0000 (GMT)
Date:   Wed, 29 Jun 2022 19:14:44 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [RFC PATCH] s390: Autoload uvdevice module based on CPU feature
Message-ID: <YryIhAN7qd4isgc6@osiris>
References: <20220629153741.195789-1-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629153741.195789-1-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pe7o9eHQz2WHNlAQFgs_pTXeNLxAndKE
X-Proofpoint-ORIG-GUID: pe7o9eHQz2WHNlAQFgs_pTXeNLxAndKE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_18,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=564 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 05:37:41PM +0200, Steffen Eiden wrote:
> With this patch the uvdevice will be automatically loaded when the
> facility 158 is present. This is accomplished by using
> ``module_cpu_feature_match`` and adding HWCAP_UV
> connected to to facility 158.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/asm/elf.h  | 2 ++
>  arch/s390/kernel/processor.c | 5 +++++
>  drivers/s390/char/uvdevice.c | 5 ++---
>  3 files changed, 9 insertions(+), 3 deletions(-)

Please split this into two patches: one which adds the hwcap bit, and
one which makes use of it.

Also please make sure the subject contains (nearly) always a
component, which would be "s390/hwcaps: ..." in this case.

> +	/* IBM Secure Execution (Ultravisor) support */
> +	if (test_facility(158)) {
> +		elf_hwcap |= HWCAP_UV;

Just keep the comment short like all other one and take the PoP as
reference. I would have expected something like:
"ultravisor-call (secure execution)"

Besides that, everything looks ok as far as I can tell.
