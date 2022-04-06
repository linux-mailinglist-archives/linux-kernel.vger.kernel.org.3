Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86C44F665D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiDFRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiDFRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:05:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC094961EF;
        Wed,  6 Apr 2022 07:28:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x131so4288564ybe.11;
        Wed, 06 Apr 2022 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWGBhe0y17ZGKEMMFNK4TgCxFrYuz+yYjVH0ivmesbU=;
        b=Wewxm6kuaQIIestTyYJsbvHlcSb+EuQogSkWQmGy6MRpVAa8WEkbwxjWnr6qT+UHZv
         Cux7NeoLhdkGwELAm2mXZhTmlpMHioecxgBnEt3jVaqN5f8PQr6mi/p2Rqks5oyqZYEw
         hTw18/z9rjRRvDEpNKSIpHmRTUDjfW0YYgb7UxQkwvmbwQzbl+IGapyTKNTqhKzpG6Vg
         /QanJOfjpviprgYMTt3U7d0myoKf2Xoch6711oe4KvipoeNONnBssYAa7LD6LtgrB2Il
         caYnpRDfJl5t/j4LS7cQZfU6alCZp8tR4nZFjQ14wzHuSq2eLelHzJogFkKTBt5G00jc
         1j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWGBhe0y17ZGKEMMFNK4TgCxFrYuz+yYjVH0ivmesbU=;
        b=2x5OWmTtKe3v5YKQr95s69+Xt7kiVfu4j6UUZmw2ELmZz7lSHTvzGs/FemMLBnYlKt
         3pRVAMFSd3kgFWBl9TLJzG+gn6FHN2EBYUw2tCQBIexSpV88dwrOuiv5IrRQvOUXqGB0
         AhmWREuJF+WI1dhR2FNwk74GdF87vjgrvIw2V3b5kqwU89TXmGoUVUmtLjMkyM0ePdAP
         LLSRsErWCe8wIn6+N/HCSDZpDXc8JYxOlr/HEH+Tk3QoCmPjMYiAbhCFk04k5qIRU6f+
         /z15X0/iY7r5+SFrOurAkicSjw6aT40Jlb3S4QlNhUAnrJ6B5w50PVTeS/Y4MMYRkv//
         VvVg==
X-Gm-Message-State: AOAM531hmah1OhgScHJIvp/qTn7d2UkE7AxtW0sRJHhUbTZWz/DgwS7Y
        zF2Pp+BG9in6Uj9HLuOKdSSJ+TFBlEdQvcsByik=
X-Google-Smtp-Source: ABdhPJyWQNHD73IT3aENCY5tKAld09c6yDrZ28pv5REeDfxmLHeRzcyKqxmfC++2g6okN8GwbFf5rlsa4iY1JMxiroo=
X-Received: by 2002:a25:374d:0:b0:63d:84a2:237d with SMTP id
 e74-20020a25374d000000b0063d84a2237dmr6699654yba.417.1649255303691; Wed, 06
 Apr 2022 07:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Yk2cTwmYqAZf4sCz@robh.at.kernel.org>
In-Reply-To: <Yk2cTwmYqAZf4sCz@robh.at.kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 6 Apr 2022 15:27:57 +0100
Message-ID: <CA+V-a8sVSsO8MArj6gcBhktB-Bi=oFUOoBVk86TZKjn357V02g@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     Rob Herring <robh@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 2:57 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 16, 2022 at 08:06:33PM +0000, Lad Prabhakar wrote:
> > Now that all the DT drivers have switched to platform_get_irq() we can now
> > safely drop the static setup of IRQ resource from DT core code.
> >
> > With the above change hierarchical setup of irq domains is no longer
> > bypassed and thus allowing hierarchical interrupt domains to describe
> > interrupts using "interrupts" DT property.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >
> > Sending this as RFC as couple of more drivers need to hit -rc yet with
> > the platform_get_irq() change while that is in progress I wanted to get
> > some feedback on this patch.
>
> I've applied this now and it is in today's linux-next. Keep an eye out
> for any regression reports. There's one for i.MX8 in kernel-ci, but I
> don't think it is related.
>
Thanks for the heads up, sure I will keep an eye on it.

Cheers,
Prabhakar
