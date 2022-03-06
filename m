Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039D4CED9B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiCFUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCFUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:09:19 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBD81081
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 12:08:25 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r22so2182332ljd.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 12:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIpfskYDgcFODfiuHy5xsQZFuiq8ouv2UTmXjx3iVTQ=;
        b=IZUn9UPSuFjmh/kMEpILS4YBGvZgmc4IZsdhTS547kJGgafsBn5bdbMRhm/hrQcK8b
         sER+YpjVbkFNFkGvqxYnq0/pLCcWENbAgitSz9D7qDy3nlhORnSZMnUa8qQlfUpvTQOP
         2uTf16Egx4bYob+VrMdJjShbE7Jc3pkEN99y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIpfskYDgcFODfiuHy5xsQZFuiq8ouv2UTmXjx3iVTQ=;
        b=7c0oxfGjzoO3oAggo0nCdFW0VJ6dq/L/93RfbIZ2mkCZXdz7vPVKB0YDlH9VhXg2tU
         Hpzaygq7IuREWao15KF8iSl+F8x8KF3Z9UUvGs52NMruw/VtUNlWfT2w2ymqrC247YG0
         hlp+Zu+BeQj1fr1XyDrX5O0o/9+C87lxVScAZqF5u/8MSvU3FsZTbED8DRq3IrH6Qhx4
         8COi/+N3qZoJSG0Mq2iXnLA4p+vZUpxnv1dRpK+Jl4PlQhlMaLphjv3WU5xLFpKaUWeS
         YYa7lR2u8D9OzPiFycbTh4D33xqRuRWs4Tdi6HAdEpvjNSXmPs3lMwKhi6kjzNE8IFEO
         PaYw==
X-Gm-Message-State: AOAM532hxNBhZsBfN30XT53sU2T7DnKuB+OqYQH4FQL106Mr7/f6ub8a
        GdP2ITsIb7fo03QGeW2fyTIX+Zhc0DmSUSTlkQE=
X-Google-Smtp-Source: ABdhPJw0uUF9pfbE1zjRco8ifOAAm2ppqyYXhr6umrETMc+CW/Un+AexwFIAsE3f2FdQHnGZtydk1Q==
X-Received: by 2002:a2e:a270:0:b0:245:f51f:354 with SMTP id k16-20020a2ea270000000b00245f51f0354mr5810788ljm.497.1646597303918;
        Sun, 06 Mar 2022 12:08:23 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h42-20020a0565123caa00b0044396c9d14esm2436056lfv.62.2022.03.06.12.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 12:08:22 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id r7so7233441lfc.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 12:08:21 -0800 (PST)
X-Received: by 2002:a19:e048:0:b0:448:2caa:7ed2 with SMTP id
 g8-20020a19e048000000b004482caa7ed2mr2578038lfj.449.1646597300996; Sun, 06
 Mar 2022 12:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20220218153617.016a905a@xps13>
In-Reply-To: <20220218153617.016a905a@xps13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Mar 2022 12:08:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjweAonv54h4rxFPVReKS5qZkVCGfB80GUDPNKbo-uEqQ@mail.gmail.com>
Message-ID: <CAHk-=wjweAonv54h4rxFPVReKS5qZkVCGfB80GUDPNKbo-uEqQ@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Fixes for v5.17-rc5
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
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

I'm about to release rc7, and I still don't have the build fix for MTD
that has been pending in the mtd tree since Feb 19.

I'm talking about commit 7cf1de957a98 ("mtd: rawnand: omap2: Actually
prevent invalid configuration and build error"). The lack of which
still causes build errors on at least sparc64, and has since rc4.

This is getting quite frustrating. These are basic errors that fail
some very basic issues, have fixes, and the fixes for some
inexplicable reason aren't actually propagated up.

Why?

                Linus
