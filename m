Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A852037F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiEIRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiEIRZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:25:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB34052528
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:21:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq17so28166001ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NbKadAlbEuv9SCL4clueu9SSBtV1FA6IQDblzg5FTkc=;
        b=VhLWVfy7VuAnawsLFBmFlKuhHwfBkHheP2GCjLRi0YYeGJiosDj1ZiqdhTw0COwHlL
         oyAC748yRG+xi07STBQBggoNnarsQtg82LQ2wAmMCse/7vNdZan7c8GM+wPCCL33stzb
         zsXIFmfxn4Can6ZOtEq58A3aSqYgMGqCetzAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbKadAlbEuv9SCL4clueu9SSBtV1FA6IQDblzg5FTkc=;
        b=NhqDx0xKGeBCzddWb+jrT0p+0ZVe7Fcr7oDUVcEqmYNwxkvLkFtUveqpX3e1T2Lj+N
         yROfXXcmDro9jkLaFIkrlX7LiNt6Ggw4uaQ3mVRmiqieXbRNNoCgiRfhpRuR8F4SyeUq
         5dsjoitFFFTunOeOfm5XMNk+IeeN/YzKt4yEF5gNq6UEMrik0tqyJCOyY6DpscyrFEXG
         nN4cMZEHyrOYTWskZtRyI5XNJelbJMOEjflzYcUi17KUFgChdjL7tNMwIStWys7K4d7q
         pWMmo5NIRsLfw2WNoq/H33SS4GIc4XexBs97/wDatpHALM4iXwV/C4SxG9kkJ+WWgD+D
         aA1w==
X-Gm-Message-State: AOAM530lwPauwbLHxMvDOFX4WP7v84hAYKH8fy7gRc8ingtC6H1H+LmV
        aGwIs/TOY6KCuNEzGMAoU121X8lcliqtSSP5
X-Google-Smtp-Source: ABdhPJzbO4HD5EwEH3Txhbe3813oTZkY844NaZLSyfHpUKGD/rCBYGKKPdMH8YyNrT5iosVfIXkKtQ==
X-Received: by 2002:a17:906:dc8a:b0:6f9:13e9:4c87 with SMTP id cs10-20020a170906dc8a00b006f913e94c87mr8807123ejc.729.1652116876103;
        Mon, 09 May 2022 10:21:16 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id g34-20020a056402322200b0042617ba63b7sm6397679eda.65.2022.05.09.10.21.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 10:21:15 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id k126so8770049wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:21:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4f06:b0:394:836b:1552 with SMTP id
 l6-20020a05600c4f0600b00394836b1552mr11550087wmq.145.1652116874604; Mon, 09
 May 2022 10:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi0vqZQUAS67tBsJQW+dtt89m+dqA-Z4bOs8CH-mm8u2w@mail.gmail.com>
 <165209064657.193515.10163777181547077546@leemhuis.info>
In-Reply-To: <165209064657.193515.10163777181547077546@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 May 2022 10:20:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
Message-ID: <CAHk-=wj0gHsG6iw3D8ufptm9a_dvTSqrrOFY9WopObbYbyuwnA@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-05-09] (was: Linux 5.18-rc6)
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
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

On Mon, May 9, 2022 at 3:47 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi Linus! Here's a quick compilation of open reports about regressions in
> 5.18-rc that I'm currently aware of; most of the reports are quite
> recent and there afaics is nothing that looks particularly worrisome.

Well, the Intel GPU issue seems likely to cause problems for lots of people:

> [ *NEW* ] drm/i915: BYT rendering broken due to "Remove short-term pins from execbuf, v6"
> -----------------------------------------------------------------------------------------
> https://linux-regtracking.leemhuis.info/regzbot/regression/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
> https://lore.kernel.org/dri-devel/1366349e-f96a-3f2c-3094-f5cd1a6fa31f@redhat.com/
>
> By Hans de Goede; 0 days ago; 2 activities, latest 0 days ago.
> Introduced in b5cfe6f7a6e1 (v5.18-rc1)
>
> Recent activities from: Tvrtko Ursulin (1), Hans de Goede (1)

Although it looks possible that it mainly affects old chipsets (ie the
two reports are for a Bay Trail chip and a Core 2 Duo chip - I have no
idea how they compare).

That probably means there are a lot of machines out there, but likely
not the kind that most kernel developers will be testing, so not a ton
of reports until it hits distro kernels etc.

It looks like Maarten is already involved.

                    Linus
