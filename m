Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128A4532C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiEXOQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 10:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiEXOQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 10:16:54 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523724C419;
        Tue, 24 May 2022 07:16:53 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id i74so11763427ioa.4;
        Tue, 24 May 2022 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6SGlowYHrtRFDegHTjmNFDhKSVxwF4/004ZPrVPYsc=;
        b=gF9J4IdP0xoCiyDi83UAUS9lApmwlilAjLoVSO6fmL3vktAkpGWOXo1kmZfbAaishU
         G6dQ7pF6d7m9bvGPdGXZi8il67MB6b7ZRZ//5KaZhhT75VkqJ4va4CYN+uBQoeBHB1QT
         ulO0aZJ+90shfFAfBrQBsx4npX7aHsAlo8WT9ESMYPiB97122F1uXrIbJNaWyAEJ4LGe
         ltlSjpZZDKGCz5iWlZ7tI/1NS9+ayUniNU2pVQW35z+/P13Bpn5InwRKj/mlvQlWWxnM
         SvbsV3bvlIdoqcRK0xIriOcJ6iyjpxa20xSm1pyTU7YbLw+MgOTy8/UJuUbcMy5cbcn+
         bwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6SGlowYHrtRFDegHTjmNFDhKSVxwF4/004ZPrVPYsc=;
        b=5u1w3ISH0TgLllEjW3wUztT2+w7n/ybRxQhcNXSBqvuVStIMklCNvf0KLL9Up31XPo
         6/3aTRGjYEbBGBqY22GRlhpu7Vf5BvbD4vbQzfPtqr6bzHf5hCAHIMhv67Ac5nH9DYC2
         bEuKyHuro4PZbend4sssgrxgpOrM9w3LfP05ceTsdLp67OlGE+R+kEdteSQ5Shs7bnPg
         mXNRJdYv4fOwl95dROO4wOs8n9kjerrETFIY3T/veg3k7ETa/RIhoge95hD5V5OTF2TB
         k7CtINVwGdOh4oaM1yi53SYigmPB619O1pztFTm0pLVbxVj23Wvv8k/848eRNE3NNySZ
         PrDQ==
X-Gm-Message-State: AOAM532uVfrxMj1WQ8GA/4+byxz6P1JCfJ589lWnEbrJIZErgYlGcv95
        1aKbZOJ81QN4Whw3HL6il1Zg2hT/Y0LXIU85ajk=
X-Google-Smtp-Source: ABdhPJxwdv0rv6Uvq71G2pfuM/bF/D02MITsYb66ekSraCXxy0HndJF8nsxaH94TE+rkAMIXnGM9JJZKWdNDHgzD6J8=
X-Received: by 2002:a05:6602:59d:b0:665:7450:16d with SMTP id
 v29-20020a056602059d00b006657450016dmr2056631iox.44.1653401811403; Tue, 24
 May 2022 07:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
 <CAKwvOdneqUvq+Nz_zPmJmuPFfAvWQgnzrw1AJt=WqQF2hThF-A@mail.gmail.com>
In-Reply-To: <CAKwvOdneqUvq+Nz_zPmJmuPFfAvWQgnzrw1AJt=WqQF2hThF-A@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 16:16:39 +0200
Message-ID: <CANiq72kySVvOQ7eqwe0Jzz3V0JTtrcqODHR9Ty4-sfDMdzP6XQ@mail.gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan <dan.carpenter@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
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

On Mon, May 23, 2022 at 8:27 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> As with the Rust series, I'm not a fan of this (or
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3):
> https://lore.kernel.org/lkml/CAKwvOd=7QTUH69+ZbT7e8einvgcosTbDkyohmPaUBv6_y8RfrQ@mail.gmail.com/

I think it should be decided whether we want extra levels or not, and
apply that policy to both the C and Rust sides.

If we don't, then yeah, let's remove them in both sides and just let
users modify `CFLAGS` as needed.

If we do, then having them as config options makes sense so that they
can be kept working.

Cheers,
Miguel
