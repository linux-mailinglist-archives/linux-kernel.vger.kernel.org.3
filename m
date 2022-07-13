Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64B573129
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiGMIck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiGMIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:32:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653D71BF8;
        Wed, 13 Jul 2022 01:32:33 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26D88mnb009690;
        Wed, 13 Jul 2022 08:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XthJH8wzL3yWkM9sa0P7yz1BR1xHDRm1vPLyUsDI/hA=;
 b=hlTaPaMD89c7CaSRKFywkxFGrG1p1cbr1vdZfZeBjbWcYxMmJ5CIjQ8LD+WYJgA6x9A8
 Y17mZF8L+wclRaZmyq/n6Em+kYBtdWWbu+GlSPfVHc3Zp0q4QL+Pv3OCUrRWg0n67qT9
 89Vot4kB6ryr0yC+88ZrjkLpm8SK9Vo+rMgt4gVrNyB6Wv/ndR2Kn3dGSZhSbb9o9rVg
 mBSNlMCu0vX/rZVnhu60axJtGPAn6iTrngw6wPoG3g03CecYr/u5kNUeELcR3OVyoOO8
 zRhY8doBIlDqd7y/l75IbViRDLf4vBTWb7pGzkGTjsb9TDFGrZztuIH4rj7+BMwxQ/Ez Gg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9au06j2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 08:32:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26D8K93Z026011;
        Wed, 13 Jul 2022 08:32:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3h71a8wbtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 08:32:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26D8Upuh20709812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 08:30:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C9E42042;
        Wed, 13 Jul 2022 08:32:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD90642041;
        Wed, 13 Jul 2022 08:32:21 +0000 (GMT)
Received: from [9.152.224.153] (unknown [9.152.224.153])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Jul 2022 08:32:21 +0000 (GMT)
Message-ID: <4132ba2a-f5ad-25ba-7f74-72369b8a140b@linux.ibm.com>
Date:   Wed, 13 Jul 2022 10:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only hwcap
 bits
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
References: <20220712105220.325010-1-seiden@linux.ibm.com>
 <20220712105220.325010-2-seiden@linux.ibm.com> <Ys3Kt7nG2jtE8H3H@osiris>
From:   Steffen Eiden <seiden@linux.ibm.com>
Organization: IBM
In-Reply-To: <Ys3Kt7nG2jtE8H3H@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VjTRiqoGWyJs1k1ypXkStQs3wv4BBLNP
X-Proofpoint-ORIG-GUID: VjTRiqoGWyJs1k1ypXkStQs3wv4BBLNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/22 21:25, Heiko Carstens wrote:
> On Tue, Jul 12, 2022 at 12:52:18PM +0200, Steffen Eiden wrote:
>> Rework cpufeature implementation to allow for various cpu feature
>> indications, which is not only limited to hwcap bits. This is achieved
>> by adding a sequential list of cpu feature numbers, where each of them
>> is mapped to an entry which indicates what this number is about.
>>
>> Each entry contains a type member, which indicates what feature
>> name space to look into (e.g. hwcap, or cpu facility). If wanted this
>> allows also to automatically load modules only in e.g. z/VM
>> configurations.
>>
>> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ...
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright IBM Corp. 2022
>> + * Author(s): Steffen Eiden <seiden@linux.ibm.com>
>> + *            Heiko Carstens <hca@linux.ibm.com>
> 
> Please don't add my name + email address in source code. I just
> recently removed that everywhere since email addresses may change, and
> git history is more than enough for me. It's up to you if you want to
> keep your name + email address here.

OK, makes sense.

> 
>> +static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
>> +	[S390_CPU_FEATURE_ESAN3]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ESAN3},
>> +	[S390_CPU_FEATURE_ZARCH]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ZARCH},
>> +	[S390_CPU_FEATURE_STFLE]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_STFLE},
>> +	[S390_CPU_FEATURE_MSA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_MSA},
>> +	[S390_CPU_FEATURE_LDISP]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_LDISP},
>> +	[S390_CPU_FEATURE_EIMM]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_EIMM},
>> +	[S390_CPU_FEATURE_DFP]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_DFP},
>> +	[S390_CPU_FEATURE_HPAGE]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_HPAGE},
>> +	[S390_CPU_FEATURE_ETF3EH]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_ETF3EH},
>> +	[S390_CPU_FEATURE_HIGH_GPRS]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_HIGH_GPRS},
>> +	[S390_CPU_FEATURE_TE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_TE},
>> +	[S390_CPU_FEATURE_VXRS]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS},
>> +	[S390_CPU_FEATURE_VXRS_BCD]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_BCD},
>> +	[S390_CPU_FEATURE_VXRS_EXT]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_EXT},
>> +	[S390_CPU_FEATURE_GS]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_GS},
>> +	[S390_CPU_FEATURE_VXRS_EXT2]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_EXT2},
>> +	[S390_CPU_FEATURE_VXRS_PDE]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_PDE},
>> +	[S390_CPU_FEATURE_SORT]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SORT},
>> +	[S390_CPU_FEATURE_DFLT]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_DFLT},
>> +	[S390_CPU_FEATURE_VXRS_PDE2]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_VXRS_PDE2},
>> +	[S390_CPU_FEATURE_NNPA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_NNPA},
>> +	[S390_CPU_FEATURE_PCI_MIO]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_PCI_MIO},
>> +	[S390_CPU_FEATURE_SIE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SIE},
>> +};
> 
> I only realized now that you added all HWCAP bits here. It was
> intentional that I added only the two bits which are currently used
> for several reasons:
> 
> - Keep the array as small as possible.
> - No need to keep this array in sync with HWCAPs, if new ones are added.
> - There is a for loop in print_cpu_modalias() which iterates over all
>    MAX_CPU_FEATURES entries; this should be as fast as possible. Adding
>    extra entries burns cycles for no added value.
The loop in print_cpu_modalias() was the reason why I added all
current HWCAPs. The current implementation runs through all HWCAPs
using cpu_have_feature() and I feared that reducing to just MSA and
VXRS has effects in the reporting of CPU-features to userspace.

I double checked the output of 'grep features /proc/cpuinfo' and it
stays the same, for 5.19-rc6, 5.19-rc6+this series, 5.19-rc6+this series 
with just the two S390_CPU_FEATUREs. I might have misunderstood what 
happens in that loop in print_cpu_modalias().

Now that I think again over this piece of code my additions do not make
sense at all for me.

I will reduce that array again to the two explicitly needed entries.


> 
> Any future user which requires a not yet listed feature, can simply
> add it when needed.
> 
>> +int cpu_have_feature(unsigned int num)
>> +{
>> +	struct s390_cpu_feature *feature;
>> +
>> +	feature = &s390_cpu_features[num];
>> +	switch (feature->type) {
>> +	case TYPE_HWCAP:
>> +		return !!(elf_hwcap & (1UL << feature->num));
> 
> Before somebody else mentions it, I could have done better. Nowadays
> this should be:
> 
> 		return !!(elf_hwcap & BIT(feature->num));
I'll change it.
