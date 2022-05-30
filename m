Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715B653879B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiE3S6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 14:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiE3S6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 14:58:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558E14F46D
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:58:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p8so11212153pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FFd5J9hlrCh2QSfJ0U9Wq/vsfh13pMH0ZkFo1eZIXtA=;
        b=G2A0nuMRKJztXPtT1GUrPx85rUqGPGHpsq6URvVAWa2fAqIkqlfU4RngPrGYBoa1Ni
         M6NJlw8gvJTBgkCc39LSTpamjbz9roIDkZlQnC9RO7k8Rc/xTX31a3GgYujadTBpfIga
         JQwSMuZ1HKoUjn6bSrBPFJvBaAnJAoYYH3EqEdZ9ex71cFuQ884I0tNEZG45hvUsKFSe
         SdW5ZEoZd6rbSNFsE45uC0UD8kqMIeKOTMqVLl/EmGGsbxPQhZqogmDjAeWQ19R+ngDM
         5BxwPho/sCen5YkWBuTX+8h/WXJiDTTq1gmrRwjtIax6oHnLs3pgInlqG/tnWA3am8JP
         E8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FFd5J9hlrCh2QSfJ0U9Wq/vsfh13pMH0ZkFo1eZIXtA=;
        b=vjeH4g3XP1IEvaqYMDBw0DwRxgQoZNUebja9rnkREcPsDdxAfDgrjhZfJMKHrEDlZE
         GZKmbJRqy88sPQKjxWbsdp9p8aSFuS0EcNcBuh4PPomZWT0J4jZvT3UHLjOE/MsAIdN4
         rta2lp0u9pHCJWIEW8LVPfyDkSTffK9c1laP1W6e2pBiw//5woWpfdZkT7vZjzyrfrXR
         az3SDixCk8OjalUSt9GoKf36R/Urmy0x1j/gjsVF4Pq/YkGRaC0tPTgwx3ATUP7hZXkE
         zS+Zwvrq7sg5i3mX8QJnSI5ZHGUI2+8/ovUIj0vgXK8E4rlzhZA0n12uYbUh+KYccUNR
         08sw==
X-Gm-Message-State: AOAM530kiiQB47LQ/LfLsQnVcXTV5+jd03xmz5gwtw0jnu106AWssiH+
        at5xCRyPOUqP4L6MbO2Lsa0jKg==
X-Google-Smtp-Source: ABdhPJxxJ8lgOI/t/BS91nMmuF/AA3XEFbCsJdbzVlMXQCjM93kfvxRGwUywbXar5ejrleDbO2A5Hg==
X-Received: by 2002:a63:2026:0:b0:3fa:cefb:e408 with SMTP id g38-20020a632026000000b003facefbe408mr25103264pgg.57.1653937096823;
        Mon, 30 May 2022 11:58:16 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79050000000b00518c6887217sm9107889pfo.58.2022.05.30.11.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 11:58:16 -0700 (PDT)
Date:   Mon, 30 May 2022 11:58:16 -0700 (PDT)
X-Google-Original-Date: Mon, 30 May 2022 11:58:13 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Prepare dropping week attribute from arch_kexec_apply_relocations[_add]
In-Reply-To: <20220530074202.pydmbbgvbtaugw5j@pengutronix.de>
CC:     lizhengyu3@huawei.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
        Bjorn Topel <bjorn.topel@gmail.com>, guoren@linux.alibaba.com,
        jszhang@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mick@ics.forth.gr, Paul Walmsley <paul.walmsley@sifive.com>,
        penberg@kernel.org, sunnanyong@huawei.com,
        wangkefeng.wang@huawei.com, christophe.leroy@csgroup.eu,
        liaochang1@huawei.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        kernel@pengutronix.de, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, lizhengyu3@huawei.com
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     u.kleine-koenig@pengutronix.de
Message-ID: <mhng-5872aea0-6f64-4685-8f8d-fdeb42e4c972@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 00:42:02 PDT (-0700), u.kleine-koenig@pengutronix.de wrote:
> Without this change arch/riscv/kernel/elf_kexec.c fails to compile once
> commit 233c1e6c319c ("kexec_file: drop weak attribute from
> arch_kexec_apply_relocations[_add]") is also contained in the tree.
> This currently happens in next-20220527.
>
> Prepare the RISC-V similar to the s390 adaption done in 233c1e6c319c.
> This is safe to do on top of the riscv change even without the change to
> arch_kexec_apply_relocations.
>
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
> Looks-good-to: liaochang (A) <liaochang1@huawei.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>
> On Mon, May 30, 2022 at 09:43:26AM +0800, liaochang (A) wrote:
>> > I can confirm that doing
>> > 
>> > diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
>> > index 206217b23301..eee260e8ab30 100644
>> > --- a/arch/riscv/include/asm/kexec.h
>> > +++ b/arch/riscv/include/asm/kexec.h
>> > @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>> >  
>> >  #ifdef CONFIG_KEXEC_FILE
>> >  extern const struct kexec_file_ops elf_kexec_ops;
>> > +
>> > +struct purgatory_info;
>> > +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> > +				     Elf_Shdr *section,
>> > +				     const Elf_Shdr *relsec,
>> > +				     const Elf_Shdr *symtab);
>> > +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> >  #endif
>> >  
>> >  #endif
>> 
>> LGTM, you could send a fixup patch to riscv, thanks.
>> 
>> > 
>> > on top of 838b3e28488f results in a compilable tree. And when merging
>> > 233c1e6c319c into this, it is still building.
>> > 
>> > I'm not enough into kexec (and riscv) to judge if this is sensible, or
>> > create a useful commit log but the obvious way forward is to apply the
>> > above patch to the riscv tree before it hits Linus' tree.
>
> Ok, here comes a patch with a generic commit log. 
>
> @riscv people: If you prefer, squash it into 838b3e28488f.

Sorry, just saw this after I sent my version of the fix.  They're the 
same, but do you mind sending a full-on patch so I can merge it?

>
> Best regards
> Uwe
>
>  arch/riscv/include/asm/kexec.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 206217b23301..eee260e8ab30 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops elf_kexec_ops;
> +
> +struct purgatory_info;
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>  #endif
>  
>  #endif
>
> base-commit: 838b3e28488f702e2b5477b393f009b2639d2b1a
> -- 
> 2.36.1
>
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |
