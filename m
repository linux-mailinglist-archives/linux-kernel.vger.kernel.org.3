Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E5E55DD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiF0HhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiF0HhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:37:11 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DF060CF;
        Mon, 27 Jun 2022 00:37:10 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id v6so6337764qkh.2;
        Mon, 27 Jun 2022 00:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVGtxzki9dy1889GY4WyHn537lHIj+Cle3Or0kD345o=;
        b=zHgpr+1oJlxmxNpISzb+ghzjzeIUdYbLGetnsNnjXuDnbOa5O822Ov3X4E4JZhGvkX
         tZtdcMLBWSTlfvWNxieyTGo3IOp3Vb5R4/hEhCC33twVxLJeEk1GDbUzlrDwME8DoMjh
         yoB53riKC/pCXyPNzDWvz3c84bEeWHQULOShjWGdFzh8OQUMyBCBLH0MvEHs63DU4dcd
         /87IFn/FZdmSE/CsuwXmxqvWSNt31M0zE0tXywjA9cUN1p/7PvJzSvVx0we8roFT5w36
         jCmOGWS1aJoa8CtIpo/jfKdBEoqIiJmdmx1k/IQbvrCnN97ih3dQwDYrNk2X8jOU9xdP
         5qZA==
X-Gm-Message-State: AJIora9faioRpYRBW9tzFqZuuBwbzf3Vd3EE4AZy28bnil4TZTH7BqqA
        tMA4N+EH9JdoOOttUvqpCJbmifBIOpTeeQ==
X-Google-Smtp-Source: AGRyM1vZIw5gS3nkTb1L3s4zJo4iswp62f++zJzVk3Qyx4LtYbQb+zfyWJPk/7/pLHYRzZFuAn6Ylg==
X-Received: by 2002:a05:620a:2587:b0:6a7:ee6f:bf2a with SMTP id x7-20020a05620a258700b006a7ee6fbf2amr7228946qko.542.1656315429287;
        Mon, 27 Jun 2022 00:37:09 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a151300b006a91da2fc8dsm8342789qkk.0.2022.06.27.00.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 00:37:08 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3177e60d980so76476647b3.12;
        Mon, 27 Jun 2022 00:37:08 -0700 (PDT)
X-Received: by 2002:a81:4fc9:0:b0:318:b0ca:4b13 with SMTP id
 d192-20020a814fc9000000b00318b0ca4b13mr13550203ywb.502.1656315428350; Mon, 27
 Jun 2022 00:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNARjq-x+8rdXfkVt2YEoJsjnZNntxurYTwOqEaAX71m04w@mail.gmail.com>
 <CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com>
In-Reply-To: <CAHk-=wgcsUU-TNoLS7Q6YF3RCSVAKwNM7gFOwqnPQTiU_oGEWA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 09:36:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX2ym5QVTbFNCbE4Td6yMeG64skYhtqWAHD2AF7ReYdEw@mail.gmail.com>
Message-ID: <CAMuHMdX2ym5QVTbFNCbE4Td6yMeG64skYhtqWAHD2AF7ReYdEw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild fixes for v5.19-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
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

Hi Linus,

On Sun, Jun 26, 2022 at 8:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Now, the only warning that seems to show up for me is about
> tick_nohz_full_setup. Which is only called from housekeeping_setup()
> in kernel/sched/isolation.c if I grepped correctly.

It is also exported as a symbol. Meh...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
