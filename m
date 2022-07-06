Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DD556824C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiGFJAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiGFJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:00:33 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0671B1658B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 02:00:30 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id b125so10540726qkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+A5o8tUrRNDtNylm0pOuZuXmTXA18iZkAubQygVne4=;
        b=ktQSztUoRKB+qdv5EeIGoLTSMMQdx2NlwFvQIuYLQXuwaz3+x/zVaj+Hz81s7AC1AY
         8l116GzNcsQQfSQmdhJH7f0xo3pMA8bexqJwBbl6BikJ1riQoSciomS7D7dN7JHvB/X9
         YzyCoGSkWZx1htimOab1wiYYbqvM0ieCKTndq74wYSJYmw2KGtnmslZtF8+so7KEiyfP
         SnJW7wxhHhl0hES1rcjekenESIYQjJcSOersRUcxTLveXu80YAb5dUykj79hF6LrvPAn
         Y7vJTmlL89bPgkWx9N1TJITyN+ImuWooqQ+K/rD1jM6nXCFoLDOUIiYC5O6hFSExdu+c
         RyYQ==
X-Gm-Message-State: AJIora/TzsfjU2nH38cZ7Vqj7n6jOQATMDcxBSrfy/IcQ81t9s4dulLZ
        wwcRtxweg+pdGKEtfLmn7WXZPpmT3dJ1XQ==
X-Google-Smtp-Source: AGRyM1t9a1yjKoKjgRjEquB8cMasLZH0JofQcx1LWYxmoDPQzF0oRKxFwXp0rsZ8t5tCoSex8Gixiw==
X-Received: by 2002:a05:620a:2408:b0:6b2:3000:3c39 with SMTP id d8-20020a05620a240800b006b230003c39mr23136524qkn.730.1657098028851;
        Wed, 06 Jul 2022 02:00:28 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id ay4-20020a05622a228400b002f39b99f69csm23094383qtb.54.2022.07.06.02.00.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 02:00:28 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ef5380669cso133086257b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 02:00:28 -0700 (PDT)
X-Received: by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP id
 i4-20020a815404000000b0031cc24d94b0mr9877031ywb.502.1657098028124; Wed, 06
 Jul 2022 02:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <Yrg6BzpKIJBTAVmO@zx2c4.com> <20220626111509.330159-1-Jason@zx2c4.com>
In-Reply-To: <20220626111509.330159-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jul 2022 11:00:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3WH6ixwGjit6-z8iWe2-9ukeExDc5YWu1degJzcGKzw@mail.gmail.com>
Message-ID: <CAMuHMdX3WH6ixwGjit6-z8iWe2-9ukeExDc5YWu1degJzcGKzw@mail.gmail.com>
Subject: Re: [PATCH v2] m68k: virt: use RNG seed from bootinfo block
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 1:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Other virt VMs can pass RNG seeds via the "rng-seed" device tree
> property or via UEFI, but m68k doesn't have either. Instead it has its
> own bootinfo protocol. So this commit adds support for receiving a RNG
> seed from it, which will be used at the earliest possible time in boot,
> just like device tree.
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

> --- a/arch/m68k/include/uapi/asm/bootinfo-virt.h
> +++ b/arch/m68k/include/uapi/asm/bootinfo-virt.h
> @@ -13,6 +13,13 @@
>  #define BI_VIRT_VIRTIO_BASE    0x8004
>  #define BI_VIRT_CTRL_BASE      0x8005
>
> +/* A random seed used to initialize the RNG. Record format:
> + *
> + *   - length       [ 2 bytes, 16-bit big endian ]
> + *   - seed data    [ `length` bytes ]

", padded to preserve 2-byte alignment"

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch with the above fixed.
No need to resend.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
