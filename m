Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7E757262D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiGLToD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiGLTnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:43:37 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B67B1DC;
        Tue, 12 Jul 2022 12:25:53 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CIBY6g011538;
        Tue, 12 Jul 2022 19:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JNm0MlW2oldiXzH8OZltzuwYoPN4K2DhqBcxukdMHf0=;
 b=riyo6TLjsh9II/R03nIRtsQGM3FALLUp8EE2I9pS1PVvy/vXylGO20YruTXHYcdJ5bUB
 2kissBqqgydFUM84HZEQAtt8d1pZ/f8ZInWZy0kloWLJ9Mpi/LFgE8zaUdrv4NowqjBf
 sKAQO9r1g7Z4CD99n87GKtCJiuvj4wKk9Scr1zXK7HDWeuTJQT+XedMx4R7N20jVw0Cw
 LZaclhnWUlmdKlLwQPfGMIWmP0qXsz7W+17Yvi1wiN0RmKFuimOXSNZT/UcnyOzsdw25
 jsIb9t26Liy7jXg/klYsrTkgkhm3iFg2pOCRB92c/xg0GEjrD2NIbc63d4enpj6lpwPi +A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9akqygsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 19:25:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CJK8cp015029;
        Tue, 12 Jul 2022 19:25:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3h70xhvm6r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 19:25:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CJPjHm20250944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 19:25:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1DAA42041;
        Tue, 12 Jul 2022 19:25:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AF0842042;
        Tue, 12 Jul 2022 19:25:45 +0000 (GMT)
Received: from osiris (unknown [9.145.52.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jul 2022 19:25:45 +0000 (GMT)
Date:   Tue, 12 Jul 2022 21:25:43 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <Ys3Kt7nG2jtE8H3H@osiris>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-2-seiden@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712105220.325010-2-seiden@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rwykUcAM1w7sDQCPFMPMFACMf6XXEAsK
X-Proofpoint-GUID: rwykUcAM1w7sDQCPFMPMFACMf6XXEAsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_12,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=923
 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207120077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:52:18PM +0200, Steffen Eiden wrote:
> Rework cpufeature implementation to allow for various cpu feature
> indications, which is not only limited to hwcap bits. This is achieved
> by adding a sequential list of cpu feature numbers, where each of them
> is mapped to an entry which indicates what this number is about.
> 
> Each entry contains a type member, which indicates what feature
> name space to look into (e.g. hwcap, or cpu facility). If wanted this
> allows also to automatically load modules only in e.g. z/VM
> configurations.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
...
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corp. 2022
> + * Author(s): Steffen Eiden <seiden@linux.ibm.com>
> + *            Heiko Carstens <hca@linux.ibm.com>

Please don't add my name + email address in source code. I just
recently removed that everywhere since email addresses may change, and
git history is more than enough for me. It's up to you if you want to
keep your name + email address here.

> +static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
> +	[S390_CPU_FEATURE_ESAN3]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ESAN3},
> +	[S390_CPU_FEATURE_ZARCH]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ZARCH},
> +	[S390_CPU_FEATURE_STFLE]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_STFLE},
> +	[S390_CPU_FEATURE_MSA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_MSA},
> +	[S390_CPU_FEATURE_LDISP]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_LDISP},
> +	[S390_CPU_FEATURE_EIMM]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_EIMM},
> +	[S390_CPU_FEATURE_DFP]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_DFP},
> +	[S390_CPU_FEATURE_HPAGE]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_HPAGE},
> +	[S390_CPU_FEATURE_ETF3EH]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ETF3EH},
> +	[S390_CPU_FEATURE_HIGH_GPRS]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_HIGH_GPRS},
> +	[S390_CPU_FEATURE_TE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_TE},
> +	[S390_CPU_FEATURE_VXRS]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS},
> +	[S390_CPU_FEATURE_VXRS_BCD]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_BCD},
> +	[S390_CPU_FEATURE_VXRS_EXT]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_EXT},
> +	[S390_CPU_FEATURE_GS]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_GS},
> +	[S390_CPU_FEATURE_VXRS_EXT2]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_EXT2},
> +	[S390_CPU_FEATURE_VXRS_PDE]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_PDE},
> +	[S390_CPU_FEATURE_SORT]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SORT},
> +	[S390_CPU_FEATURE_DFLT]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_DFLT},
> +	[S390_CPU_FEATURE_VXRS_PDE2]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_PDE2},
> +	[S390_CPU_FEATURE_NNPA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_NNPA},
> +	[S390_CPU_FEATURE_PCI_MIO]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_PCI_MIO},
> +	[S390_CPU_FEATURE_SIE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SIE},
> +};

I only realized now that you added all HWCAP bits here. It was
intentional that I added only the two bits which are currently used
for several reasons:

- Keep the array as small as possible.
- No need to keep this array in sync with HWCAPs, if new ones are added.
- There is a for loop in print_cpu_modalias() which iterates over all
  MAX_CPU_FEATURES entries; this should be as fast as possible. Adding
  extra entries burns cycles for no added value.

Any future user which requires a not yet listed feature, can simply
add it when needed.

> +int cpu_have_feature(unsigned int num)
> +{
> +	struct s390_cpu_feature *feature;
> +
> +	feature = &s390_cpu_features[num];
> +	switch (feature->type) {
> +	case TYPE_HWCAP:
> +		return !!(elf_hwcap & (1UL << feature->num));

Before somebody else mentions it, I could have done better. Nowadays
this should be:

		return !!(elf_hwcap & BIT(feature->num));
