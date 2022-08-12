Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F26591433
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiHLQrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiHLQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:47:15 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB63ABF2E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:47:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tl27so2982733ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ap+EfATfK5WAW7Nse79FXsKVqCdZ3dDAXwUOG0IRWgY=;
        b=QR+QwqGBiZe/rTalQNpA9DsMtxdJgRSGXPmc3P5JlvbJjCoCerr9IoTi94AUhmh0VX
         eEd7rXKtW+6TlUkIQ04p4TEe6Y4k5kWHRlxECaGz12aEqwQuzYPyP4cgI4HwfxYLkyi6
         NICesPDGUVTv+5/xM1Ezsu+UdK73Hyjvr4RhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ap+EfATfK5WAW7Nse79FXsKVqCdZ3dDAXwUOG0IRWgY=;
        b=zWyFMbwN2jGkFxz+e6g3x5b0fc0qqiqd2EFnghIReJETuYRis01JyVhvnHZeXhovpp
         91ls/nbp5r59O5MXIWfjFtuFati6EBIL1VNyEFSOPZkNlwk/kpxqnwvP48rjiyLl5GtH
         +bUgfDmw9vBOwNIgQj6pMcr/aWxSEOFQQ3ir2T4B/XmfDCfurVdu4eqH7jwFZes1Npph
         MOTxGhySju1TYbLv6+kMf5a7X7UhqsM5wdBMO/7Ed33M/RSR7ar2LUW44xZdbx043N1Z
         Besu8fANgJua5822RWe2ArVArm1XhuKG0+XBWQMaWTwLnn/c+R15CjWiswcT0X1XNpac
         xRmw==
X-Gm-Message-State: ACgBeo1DAAtADtvP5vl1MgF9kUFWvPyK1bxROZIaESNSUpwefAXAsHI3
        L9BbN8SjPGOTYqcOVhYxkqtbRCe6NgIZZp3+
X-Google-Smtp-Source: AA6agR6fNJlzZg4pkmzECyOL32nOXzMD2l3u21yMhJfuHeiTiEIORvaRVqbIhImJGCfwJ/w7X6pDvw==
X-Received: by 2002:a17:907:1690:b0:731:56b6:fded with SMTP id hc16-20020a170907169000b0073156b6fdedmr3351380ejc.119.1660322830978;
        Fri, 12 Aug 2022 09:47:10 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id b20-20020a170906195400b0072b7d76211dsm950636eje.107.2022.08.12.09.47.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:47:10 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id l22so1777456wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 09:47:10 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr2694621wrv.97.1660322830060; Fri, 12 Aug
 2022 09:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220812072403.3075518-1-chenhuacai@loongson.cn>
In-Reply-To: <20220812072403.3075518-1-chenhuacai@loongson.cn>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Aug 2022 09:46:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgopYkkZxSTCZGP783868VjoyGALMRst_nceA3aH-TW6Q@mail.gmail.com>
Message-ID: <CAHk-=wgopYkkZxSTCZGP783868VjoyGALMRst_nceA3aH-TW6Q@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch changes for v5.20
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 12:24 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> Note: There is a conflict in arch/loongarch/include/asm/irq.h but can
> be fixed simply (just remove both lines from the irqchip tree and the
> loongarch tree).

Hmm. I don't see any conflict, so I assume there is something else in
linux-next that I haven't yet gotten.

             Linus
