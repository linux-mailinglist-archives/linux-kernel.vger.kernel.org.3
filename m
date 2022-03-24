Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B4F4E68FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352810AbiCXTEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245360AbiCXTEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:04:45 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C20BC00
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:03:12 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u103so10098496ybi.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mgPVpHbND8gUFzVe4KUlurzT51Ye9xkif3P/Fm8gbk=;
        b=OfERbWwNjpodHGQlIYwwf5FHwgTMG66XGYD8AVU9N37kRJJlHTI3aaiGN1g3dbvxWc
         IYeknDHXvqPVniI0IucfObQAVe/CCcfIM9yFSsmpGNQQ3ixNsW2348kLPnugRBU+pRaY
         dCrhhP1Cl6WPT1gE86A1Xq2zvGW0/P7vYtDazmwCKDtUM7wdKJxE/bcTZbCHEQK0PuYX
         9cfXADb8XxXkWNfvsTdQEKHyb/PyiHKePusrUkGUDFJ6+dIZxIYv2Kj60SFogcZ8p/YE
         Ry8NFZg5nociLEMN+QKOUSCiJ2IjAGJI+rI1O4UjpxerBtfZTmmq+G38N8ZMp0H5F7Yh
         QaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mgPVpHbND8gUFzVe4KUlurzT51Ye9xkif3P/Fm8gbk=;
        b=ZYWyZI+uq1pZgDQRrVojWEMlyYwgr9Tjzj2gef+CPB83cLUPwBmmSYuNiOUSjSVrvv
         0kt5V7K8bKHpkI+bpS+nOq40fISDygSDiAjexJymEDAt0hTTYQ/PI7Xbg0WcTSk6UPSf
         OLl5itz77L39zvZW+BIBisSiRkiBw6760bbfoADk2zUrA6qZUBpGhgNvN1P/4QL/1Wa/
         +dGM+AnN0UHfj9y3NlBv5F80hRfGyxoVcBr0dZXDZsRygoQdROUfpD4GJoaxZCCsjKx8
         Z8Dz8ENbzhoPR9t2CQMEAEsALYnFbabr83nBUZHCYxB/uJlxeUQ6otTc3v3dl9EgnsAZ
         vRpg==
X-Gm-Message-State: AOAM5330j7muykTa8qZbZYkSbEIouIFzt4lXbXlNv2eZ0NBICA0lBUuI
        kWNbChhQV22la3CY4kAF0cK3GjpA/MtmKuYkD90+ig==
X-Google-Smtp-Source: ABdhPJxDrpkXC04Erjrpat6hw36zHFoZoPec97VLzBKw3LLwFDozXekWVmYcliTR6Bgj50B1XoSXrsMaaaLJnxoO8VI=
X-Received: by 2002:a5b:dc5:0:b0:624:f16d:7069 with SMTP id
 t5-20020a5b0dc5000000b00624f16d7069mr6024939ybr.295.1648148591551; Thu, 24
 Mar 2022 12:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220324175417.1014562-1-f.fainelli@gmail.com> <20220324175417.1014562-3-f.fainelli@gmail.com>
In-Reply-To: <20220324175417.1014562-3-f.fainelli@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Mar 2022 20:02:59 +0100
Message-ID: <CACRpkdbJcmLOZ9PxZ_KMdSqj=WEw60-zwD6kNWUF4_2XhMJgrQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Clamp MAX_DMA_ADDRESS to 32-bit
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 6:54 PM Florian Fainelli <f.fainelli@gmail.com> wrote:

> MAX_DMA_ADDRESS is a virtual address, therefore it needs to fit within a
> 32-bit unsigned quantity. Platforms defining a DMA zone size in
> their machine descriptor can easily overflow this quantity depending on
> the DMA zone size and/or the PAGE_OFFSET setting.
>
> In most cases this is harmless, however in the case of a
> CONFIG_DEBUG_VIRTUAL enabled, __virt_addr_valid() will be unable to
> return that MAX_DMA_ADDRESS is valid because the value passed to that
> function is an unsigned long which has already overflowed.
>
> Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
> Fixes: 2fb3ec5c9503 ("ARM: Replace platform definition of ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
