Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CA755B028
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiFZIFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 04:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiFZIFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 04:05:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9299E08D;
        Sun, 26 Jun 2022 01:05:20 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25Q60EZ4000480;
        Sun, 26 Jun 2022 08:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sVH33KrA8lZ1PN9v0l09LD3biBzBdRqmhLUgDi1z0OQ=;
 b=kCkPgJvi6GSmdOqK7TnAMDMwn99sbo8pf26KDG0F2MZjWVDBuxLLUj8Y4IdhAZdbBYiW
 i/wLELMP2zwZx5er7nUbjMA3rplMctiLcFcdFT54jBzyK6Wqdpv0AJpGAfcMJ2rKUMHX
 PR4FPBOY5wKP8v3qKpV41CTjKbPdv7MniwAcxoDiH2GXL4797o75y5X8LznfgcJRGnop
 Lhuqj6jDY8R38hMiUc6pAeI1VFjOwJ3p2+DP4QxXOPBBTi87NeRujMa4c50OyalgQrBI
 Iu/w0dKkbXSZoGfLHi/3kAp5NhNaOzWDsmzFE02QUclmZIbD/V7g/c2lXqfIFFTMdOBE Vg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gxc9g6v5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 08:05:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25Q7oPra003946;
        Sun, 26 Jun 2022 08:04:58 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gwt08sc42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jun 2022 08:04:58 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25Q84ta313238664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 Jun 2022 08:04:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 566B911C050;
        Sun, 26 Jun 2022 08:04:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B832E11C04A;
        Sun, 26 Jun 2022 08:04:54 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun, 26 Jun 2022 08:04:54 +0000 (GMT)
Date:   Sun, 26 Jun 2022 10:04:53 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 3/3] jump_label: make initial NOP patching the special
 case
Message-ID: <YrgTJdycKz1fZAvj@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220615154142.1574619-1-ardb@kernel.org>
 <20220615154142.1574619-4-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615154142.1574619-4-ardb@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F-Qej8gC4CvDfw9WhmMtp2mvmkHhmBEE
X-Proofpoint-ORIG-GUID: F-Qej8gC4CvDfw9WhmMtp2mvmkHhmBEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-25_11,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=967 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206260029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 05:41:42PM +0200, Ard Biesheuvel wrote:
> Instead of defaulting to patching NOP opcodes at init time, and leaving
> it to the architectures to override this if this is not needed, switch
> to a model where doing nothing is the default. This is the common case
> by far, as only MIPS requires NOP patching at init time. On all other
> architectures, the correct encodings are emitted by the compiler and so
> no initial patching is needed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  Documentation/staging/static-keys.rst |  3 ---
>  arch/arc/kernel/jump_label.c          | 13 -------------
>  arch/arm/kernel/jump_label.c          |  6 ------
>  arch/arm64/kernel/jump_label.c        | 11 -----------
>  arch/mips/include/asm/jump_label.h    |  2 ++
>  arch/parisc/kernel/jump_label.c       | 11 -----------
>  arch/riscv/kernel/jump_label.c        | 12 ------------
>  arch/s390/kernel/jump_label.c         |  5 -----
>  arch/x86/kernel/jump_label.c          | 13 -------------
>  kernel/jump_label.c                   | 14 +++++---------
>  10 files changed, 7 insertions(+), 83 deletions(-)
> 
> diff --git a/Documentation/staging/static-keys.rst b/Documentation/staging/static-keys.rst
> index 38290b9f25eb..b0a519f456cf 100644
> --- a/Documentation/staging/static-keys.rst
> +++ b/Documentation/staging/static-keys.rst
> @@ -201,9 +201,6 @@ static_key->entry field makes use of the two least significant bits.
>  * ``void arch_jump_label_transform(struct jump_entry *entry, enum jump_label_type type)``,
>      see: arch/x86/kernel/jump_label.c
>  
> -* ``__init_or_module void arch_jump_label_transform_static(struct jump_entry *entry, enum jump_label_type type)``,
> -    see: arch/x86/kernel/jump_label.c
> -
>  * ``struct jump_entry``,
>      see: arch/x86/include/asm/jump_label.h
>  
> diff --git a/arch/arc/kernel/jump_label.c b/arch/arc/kernel/jump_label.c
> index b8600dc325b5..70b74a5d047b 100644
> --- a/arch/arc/kernel/jump_label.c
> +++ b/arch/arc/kernel/jump_label.c
> @@ -96,19 +96,6 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);
>  }
>  
> -void arch_jump_label_transform_static(struct jump_entry *entry,
> -				      enum jump_label_type type)
> -{
> -	/*
> -	 * We use only one NOP type (1x, 4 byte) in arch_static_branch, so
> -	 * there's no need to patch an identical NOP over the top of it here.
> -	 * The generic code calls 'arch_jump_label_transform' if the NOP needs
> -	 * to be replaced by a branch, so 'arch_jump_label_transform_static' is
> -	 * never called with type other than JUMP_LABEL_NOP.
> -	 */
> -	BUG_ON(type != JUMP_LABEL_NOP);
> -}
> -
>  #ifdef CONFIG_ARC_DBG_JUMP_LABEL
>  #define SELFTEST_MSG	"ARC: instruction generation self-test: "
>  
> diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
> index 303b3ab87f7e..eb9c24b6e8e2 100644
> --- a/arch/arm/kernel/jump_label.c
> +++ b/arch/arm/kernel/jump_label.c
> @@ -27,9 +27,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  {
>  	__arch_jump_label_transform(entry, type, false);
>  }
> -
> -void arch_jump_label_transform_static(struct jump_entry *entry,
> -				      enum jump_label_type type)
> -{
> -	__arch_jump_label_transform(entry, type, true);
> -}
> diff --git a/arch/arm64/kernel/jump_label.c b/arch/arm64/kernel/jump_label.c
> index fc98037e1220..faf88ec9c48e 100644
> --- a/arch/arm64/kernel/jump_label.c
> +++ b/arch/arm64/kernel/jump_label.c
> @@ -26,14 +26,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  
>  	aarch64_insn_patch_text_nosync(addr, insn);
>  }
> -
> -void arch_jump_label_transform_static(struct jump_entry *entry,
> -				      enum jump_label_type type)
> -{
> -	/*
> -	 * We use the architected A64 NOP in arch_static_branch, so there's no
> -	 * need to patch an identical A64 NOP over the top of it here. The core
> -	 * will call arch_jump_label_transform from a module notifier if the
> -	 * NOP needs to be replaced by a branch.
> -	 */
> -}
> diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
> index 3185fd3220ec..c5c6864e64bc 100644
> --- a/arch/mips/include/asm/jump_label.h
> +++ b/arch/mips/include/asm/jump_label.h
> @@ -8,6 +8,8 @@
>  #ifndef _ASM_MIPS_JUMP_LABEL_H
>  #define _ASM_MIPS_JUMP_LABEL_H
>  
> +#define arch_jump_label_transform_static arch_jump_label_transform
> +
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/types.h>
> diff --git a/arch/parisc/kernel/jump_label.c b/arch/parisc/kernel/jump_label.c
> index d2f3cb12e282..e253b134500d 100644
> --- a/arch/parisc/kernel/jump_label.c
> +++ b/arch/parisc/kernel/jump_label.c
> @@ -42,14 +42,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  
>  	patch_text(addr, insn);
>  }
> -
> -void arch_jump_label_transform_static(struct jump_entry *entry,
> -				      enum jump_label_type type)
> -{
> -	/*
> -	 * We use the architected NOP in arch_static_branch, so there's no
> -	 * need to patch an identical NOP over the top of it here. The core
> -	 * will call arch_jump_label_transform from a module notifier if the
> -	 * NOP needs to be replaced by a branch.
> -	 */
> -}
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> index 20e09056d141..e6694759dbd0 100644
> --- a/arch/riscv/kernel/jump_label.c
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -39,15 +39,3 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	patch_text_nosync(addr, &insn, sizeof(insn));
>  	mutex_unlock(&text_mutex);
>  }
> -
> -void arch_jump_label_transform_static(struct jump_entry *entry,
> -				      enum jump_label_type type)
> -{
> -	/*
> -	 * We use the same instructions in the arch_static_branch and
> -	 * arch_static_branch_jump inline functions, so there's no
> -	 * need to patch them up here.
> -	 * The core will call arch_jump_label_transform  when those
> -	 * instructions need to be replaced.
> -	 */
> -}
> diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
> index d764f0d229ab..e808bb8bc0da 100644
> --- a/arch/s390/kernel/jump_label.c
> +++ b/arch/s390/kernel/jump_label.c
> @@ -80,8 +80,3 @@ void arch_jump_label_transform_apply(void)
>  {
>  	text_poke_sync();
>  }
> -
> -void __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
> -						       enum jump_label_type type)
> -{
> -}
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index 68f091ba8443..f5b8ef02d172 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -146,16 +146,3 @@ void arch_jump_label_transform_apply(void)
>  	text_poke_finish();
>  	mutex_unlock(&text_mutex);
>  }
> -
> -static enum {
> -	JL_STATE_START,
> -	JL_STATE_NO_UPDATE,
> -	JL_STATE_UPDATE,
> -} jlstate __initdata_or_module = JL_STATE_START;
> -
> -__init_or_module void arch_jump_label_transform_static(struct jump_entry *entry,
> -				      enum jump_label_type type)
> -{
> -	if (jlstate == JL_STATE_UPDATE)
> -		jump_label_transform(entry, type, 1);
> -}
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index b1ac2948be79..714ac4c3b556 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -332,17 +332,13 @@ static int __jump_label_text_reserved(struct jump_entry *iter_start,
>  	return 0;
>  }
>  
> -/*
> - * Update code which is definitely not currently executing.
> - * Architectures which need heavyweight synchronization to modify
> - * running code can override this to make the non-live update case
> - * cheaper.
> - */
> -void __weak __init_or_module arch_jump_label_transform_static(struct jump_entry *entry,
> -					    enum jump_label_type type)
> +#ifndef arch_jump_label_transform_static
> +static void arch_jump_label_transform_static(struct jump_entry *entry,
> +					     enum jump_label_type type)
>  {
> -	arch_jump_label_transform(entry, type);
> +	/* nothing to do on most architectures */
>  }
> +#endif
>  
>  static inline struct jump_entry *static_key_entries(struct static_key *key)
>  {

With the follow-up fixup to the common and s390 parts:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

> -- 
> 2.35.1
> 
