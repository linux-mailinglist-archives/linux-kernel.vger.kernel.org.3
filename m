Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97304ECFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351667AbiC3Wfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiC3Wft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:35:49 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DA2F383
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648679643; x=1680215643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vN678j8+lGQHG6+BC7HU2l7qEDTv5FwFrbQPKj7VLPs=;
  b=MEt6H+cud4J4S9iEKZVyh/k+1l12eEctKP+KKpYQgFQJU1BCQj0ctpSD
   JbQvlavWxVNZAZ7KNL0xnAg+A6Cn7qB1BK108TYoHEHnHgTvAuI8cOHp+
   bMEZ2OAJl8dZVhuC2Y+1NAKBCYIZs+N7KOkvHyB8feFy9ruRxCkm4wvxx
   qQ06emqCylJusy2yMIhytROYy0Iv2keHgaF+llylWZpwVa9dpKFplOSPV
   +UDYp65O6pC8+tZufAyhldbCqw/iithHSRzSVROrG5V4CNZ1cs1mve6TA
   AW+SI3m/TfpBOZlwF9qegBKzWwwxYLSd+KhQSvgUaaGJkeFF+tEhf5cJR
   A==;
X-IronPort-AV: E=Sophos;i="5.90,223,1643644800"; 
   d="scan'208";a="195559778"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2022 06:34:02 +0800
IronPort-SDR: aJb68MMyve/w9Xz/+XiwPniu2FZVI5Ku1Vk0bD8dgXZiOySck8dHB7DnJB0u+fmCTYpzQhTvr4
 AeVlPNfPc/KtDd5sw3d0qrfHpXJ7B7z3EgjGD9rVgGwjQ3Di+KzW3IN+50rc30RoFzq3GFiBZ+
 BCafZJJwQ82ju38jwdMFTlD3htgjQqKFURwZfC20TLGwfs0OCIlrjisFHynncXHAdtTQIXvW1V
 HUDmf1gV84gHzsqajsC3PPxQ8JHep3Kv6xHGK+qb8jGdVjo/17R+dtR1u1x4ZdzkYrtipReJw/
 MhA3Ix4WDuLdVifnaA4EPOSb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 15:04:51 -0700
IronPort-SDR: sy4Z8T6u+cWAyNxu1tHO46HYcxKnl2nEUFXuuMr+hAyHSLxx8ATs4VcqxlJtktx+026XsGwHFe
 4yEEP/S6/SRkJszxhi509zz9uSNFiRi6CKngERD7nifS4Cmg0AwxDoZcnRmBEhdvwDAgAKZJw1
 +9UyS44+T27pP9tx8P0OlJFI/8O3Q4TxrA+o45FjYhoFrztaw8cFyQSWnQIbgiVheWDMFMkgbB
 rfUy5mcp3ziW46PRa0QYgxoCddyviosVaHt/9LiWT1i45AvSK8lf75aXnG90Q0R/MIZ2WY6plj
 +yk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2022 15:34:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KTLnj2rkWz1SHwl
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:34:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648679640; x=1651271641; bh=vN678j8+lGQHG6+BC7HU2l7qEDTv5FwFrbQ
        PKj7VLPs=; b=fwQc1Q3Gbs+KZL3VYfZyM3DmZrjPI/D9DDxAwxv3WANICbDOIsv
        cHr2L5cVdeYp2BTv1MRV1RVAF3xv/fo9ETy9R6rGktf4tJb2ouBgU62ymA3qurCA
        Q3B5C3B6Oq27l02THM16d66wICOLBoZJLr9iCstmfczsaWNPbTm40WMqCsqT/omW
        IKe01d+Q5r4m7+EASguhSIvvwyLZiQsG8G+A98I5U5dQQal+1uBKN8zHYw+QB8DT
        cK406kfneia7CZeQMsdx7s3cUwzWEysXq9G68XZnvbH+zMJZ5B60G57utepMiFJh
        JHDg0eJ6pIAT50kxYFnmbf86AKLbfcYyv1A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wcwq6rqZKOoY for <linux-kernel@vger.kernel.org>;
        Wed, 30 Mar 2022 15:34:00 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KTLng07XLz1Rvlx;
        Wed, 30 Mar 2022 15:33:58 -0700 (PDT)
Message-ID: <98afa9c9-28d1-1147-2538-e8c0dfeadde4@opensource.wdc.com>
Date:   Thu, 31 Mar 2022 07:33:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] riscv: Ensure only ASIDLEN is used for sfence.vma
Content-Language: en-US
To:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu
Cc:     linux-kernel@vger.kernel.org, anup@brainfault.org,
        atishp@rivosinc.com, guoren@kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
References: <20220330214358.3409766-1-alistair.francis@opensource.wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220330214358.3409766-1-alistair.francis@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 06:43, Alistair Francis wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When we set the value of context.id using __new_context() we set both
> the asid and the current_version with this return statement in
> __new_context():
> 
>     return asid | ver;
> 
> This means that when local_flush_tlb_all_asid() is called with the asid
> specified from context.id we can write the incorrect value.
> 
> We get away with this as hardware ignores the extra bits, as the RISC-V
> specification states:
> 
> "bits SXLEN-1:ASIDMAX of the value held in rs2 are reserved for future
> standard use. Until their use is defined by a standard extension, they
> should be zeroed by software and ignored by current implementations."
> 
> but it is still a bug and worth addressing as we are incorrectly setting
> extra bits.
> 
> This patch uses asid_mask when calling sfence.vma to ensure the asid is
> always the correct len (ASIDLEN). This is similar to what we do in
> arch/riscv/mm/context.c.
> 
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  arch/riscv/mm/context.c  | 2 +-
>  arch/riscv/mm/tlbflush.c | 2 +-
>  include/linux/mm_types.h | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..4329fe54176b 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>  
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> -static unsigned long asid_mask;
> +unsigned long asid_mask;
>  
>  static atomic_long_t current_version;
>  
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..ef701fa83f36 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -42,7 +42,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>  	/* check if the tlbflush needs to be sent to other CPUs */
>  	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>  	if (static_branch_unlikely(&use_asid_allocator)) {
> -		unsigned long asid = atomic_long_read(&mm->context.id);
> +		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;

It would be a lot nicer and less error prone to have a small helper
function for this, no ?

>  
>  		if (broadcast) {
>  			sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8834e38c06a4..5fa7cc0af853 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -666,6 +666,8 @@ struct mm_struct {
>  
>  extern struct mm_struct init_mm;
>  
> +extern unsigned long asid_mask;
> +
>  /* Pointer magic because the dynamic array size confuses some compilers. */
>  static inline void mm_init_cpumask(struct mm_struct *mm)
>  {


-- 
Damien Le Moal
Western Digital Research
