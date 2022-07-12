Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98189572160
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiGLQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiGLQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:50:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A21BFAF3;
        Tue, 12 Jul 2022 09:50:28 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CG7AnM003488;
        Tue, 12 Jul 2022 16:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=GZziBP99d0vDibe9zAPx6o4FeLdVbvYp/D9HCbjpcG8=;
 b=djogIvN39cUUtTRlXrH+B7F4zs3xN80mrXgRU/aEZu+dh5qcmv/Mvspj/Gxiz8TALk/b
 Pdw+18vdaHNbn6TZcoJnVqtZUzmz7QA2P/PacUzrAozli1yUxEIcAL6eZ59ec96A+XL6
 4OdO84oJoTyZtq9RuBZmD65rFT+XlPBG1FNVJWZDjoSwMPN6e0mVCz6sxBki3NMe5ZZF
 leMY/h+kewZT8h5YEZdG/xpVjqBin/vTf+Ql2s4E+oP875OmNmU5o6ZgZPcTkiqR7Zn7
 K8gXVEzUnFfUz+ybh47qmsJTjzlM6LXYRhnI7ZcBx7cA3qrVRwYC+wL3BdZrpj/X8w71 JQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h99hh609r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:50:27 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CGLuBT025283;
        Tue, 12 Jul 2022 16:50:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3h99s78644-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:50:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CGoWwU25231860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 16:50:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27ACE42047;
        Tue, 12 Jul 2022 16:50:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9A5942042;
        Tue, 12 Jul 2022 16:50:21 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.61])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 16:50:21 +0000 (GMT)
Date:   Tue, 12 Jul 2022 18:50:13 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 2/3] s390/cpufeature: allow for facility bits
Message-ID: <20220712185013.3f9320eb@p-imbrenda>
In-Reply-To: <20220712105220.325010-3-seiden@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
        <20220712105220.325010-3-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bDkWKpek6FtOzfHNDJZooSSUhq3x4H-y
X-Proofpoint-GUID: bDkWKpek6FtOzfHNDJZooSSUhq3x4H-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=953
 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 12:52:19 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> From: Heiko Carstens <hca@linux.ibm.com>
> 
> Allow for facility bits to be used in cpu features.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/kernel/cpufeature.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
> index ea4bbfd855db..e70b29804db4 100644
> --- a/arch/s390/kernel/cpufeature.c
> +++ b/arch/s390/kernel/cpufeature.c
> @@ -10,6 +10,7 @@
>  
>  enum {
>  	TYPE_HWCAP,
> +	TYPE_FACILITY,
>  };
>  
>  struct s390_cpu_feature {
> @@ -54,6 +55,8 @@ int cpu_have_feature(unsigned int num)
>  	switch (feature->type) {
>  	case TYPE_HWCAP:
>  		return !!(elf_hwcap & (1UL << feature->num));
> +	case TYPE_FACILITY:
> +		return test_facility(feature->num);
>  	default:
>  		WARN_ON_ONCE(1);
>  		return 0;

