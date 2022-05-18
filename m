Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16F752BD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbiERNkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbiERNjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:39:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43241BE11E;
        Wed, 18 May 2022 06:39:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id o190so2215743iof.10;
        Wed, 18 May 2022 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3wCNJS1xVIXYkjKAZEqtCPgrHMfsRF2KDMYD/Qfh2o=;
        b=G/2T0pKpcaTtQD2cozzEKNQfmpP+fLiCMtg08W6X+S/zAf9leWjqHhH25LLBWj0CA8
         Ys+4s1yVLPpV0OZom7Bp/bOJmTyoGYib8wq/R1ZhdNK8KQ+JALZ/2Cbf6ks0YJ4/GRTT
         NMwmXCN6p9iQz3DBmN7crU3x07urlOqlJ6B+ZSaSqMnCfkxWNlKs+cZeuIM85V3IZq5W
         Wi4zA/VFcUIPTDIh2FUFKVhWtspDr0p56saRRNz5z6OZcA0fg79zzU92QjRS4z61YLdb
         2IZbpttTJQL9BFdWRyaj7mC9f/FHR/NxJXanYVhDJ6jkGU6CDF3Gavj74uCItXvgNBhh
         bDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3wCNJS1xVIXYkjKAZEqtCPgrHMfsRF2KDMYD/Qfh2o=;
        b=e2pyOqlxaM5FS7Q6Fu4EwV0YnDofD2vPJMADnSJKmKNl0ObzdbWbBAVdEgHmV1GXcR
         8VwNK5Cps0crQFVyEEGaQWKxOYr35reRc8I0si+Cn6xTIM84UJGeynBNqf2Cs4v4MncP
         PJZ2sBGPBWLI84DnjXbzz76TteAbOFnzIy2C5YGYiC+uJN3GZTcNROkdTmwYE/qKlCKq
         hXCWPo90H7oDlkFJqijvcVjsPAQS8Wk5xMMm5ejeQZkGGrK2s3dvsN7lO6BPpNoewgkz
         TUk5/k4lmpp6v7Gr5F5bcvGASaKpGlPmS1RZ61WnCXlyI1KgJ9a46VV4PfU42f/+8NY1
         wIiQ==
X-Gm-Message-State: AOAM533766Qkdxx0H4WxugZ3eCeRjqXpRceInfBfOCOG57WR88yniYC9
        2jdKRsSEpjoNIHWEVHxxBKRqgo5DaOVeAnBOD7g=
X-Google-Smtp-Source: ABdhPJz0N+uS74zL79CKwv8mnFznYe60VTPPYBux2feKAib04z3vsvVPYBHfax/sYpXqsz8QdLGlVp3TUgbcCQv9KG4=
X-Received: by 2002:a05:6638:16d2:b0:32b:ebfe:8672 with SMTP id
 g18-20020a05663816d200b0032bebfe8672mr14890357jat.199.1652881193347; Wed, 18
 May 2022 06:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220517102813.10310-1-ojeda@kernel.org>
In-Reply-To: <20220517102813.10310-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 18 May 2022 15:39:42 +0200
Message-ID: <CANiq72=4YKUoUjbs3484mdjsDCXX1V6qf8MrzhW0FN3ZbbDaAg@mail.gmail.com>
Subject: Re: [PATCH v2] binder: convert `BINDER_*` ioctl `#define`s into an `enum`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Li Li <dualli@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

Hi Greg,

On Tue, May 17, 2022 at 12:28 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> bindgen (a tool which generates the "raw" C bindings for Rust) only
> works (so far) with "simple" C `#define`s. In order to avoid having
> to manually maintain these constants in the (potential) Rust side,
> this patch converts them into an `enum`.

Given the discussion in v1's thread [0], I think we should hold on
applying the patch (just letting you know here in v2).

[0] https://lore.kernel.org/lkml/CANiq72=_UAF5DRHCmW4qNt-Wi3yV6vPEjdLhBTijG_ZGgfpaTA@mail.gmail.com/

Cheers,
Miguel
