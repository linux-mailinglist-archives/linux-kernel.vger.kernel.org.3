Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316BD5425EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382654AbiFHCTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443347AbiFHCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 22:02:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E0345B73F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 15:11:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so24733185eda.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfycHacPY5P1y/1m0oCpwnDJwtHXoUWrUFXkPYiy2lw=;
        b=Tov7X2dnwSkw2/BPXfCsLem8R5BtxbPWjnRcb5I5neISNNssoSXmPYxcZJuN7aRuLD
         ziSy0wBW1fgXRVrkRU8YnG4qS4LQCnBfulhISKENZ3UsFzRZ95+wvNwSBIQfPRtlrQVh
         DRSz1SOqUnOqQn7VILe87XHifzet2YmzByYac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfycHacPY5P1y/1m0oCpwnDJwtHXoUWrUFXkPYiy2lw=;
        b=ct04Btnncyw3Te8QpqdNMD092oLyBVIokr9SKMMjSLb2/HUPbowOe9bMTQYR+KPN3D
         O4La/oDGNJ75n7k7g5lWiYLZfheeOGBf/YQBGqTHfeyUUDbAIzqzBEhLUdZ9TuaaCDG6
         Th5Tp0VrAIT/LBF0Ak+0I84qwzhbyg9yvLJj2vaKlcymncVDmOWlj+aBWSIntymvpmAG
         ajeD+gIyG/AUCBWWEdBunhX7t1FpvNjGy9hCAvC/ngV7SGLIdZrgOG3cf+Ob3/TLeQ7U
         hv7zIzfbTWLVFnWWvaosljpcVGLOJ9c75ZnGHW4bbQe08JnkAJwjRLAQiLjLurAkTdAv
         HXnQ==
X-Gm-Message-State: AOAM530XsL4dlg5qxR0Rn0yjgipL6ASRn+cavbUm0Wd5KCWyS7V5irO8
        AndrCifvAd2noii2mijRFCCQ95bMe2IRMdOC0cQ=
X-Google-Smtp-Source: ABdhPJw0zpHAoN4VAQKr3P/Kwh8okNpkhnr8ub6ST8om7xboEze3nU9jdA0NEg0HiYoAvUin1eNTqw==
X-Received: by 2002:aa7:d143:0:b0:42d:ca9c:aa76 with SMTP id r3-20020aa7d143000000b0042dca9caa76mr36654032edo.163.1654639884081;
        Tue, 07 Jun 2022 15:11:24 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id v4-20020a170906488400b006fea2035036sm8223713ejq.86.2022.06.07.15.11.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 15:11:23 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h5so25964563wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 15:11:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr29434919wrz.281.1654639883077; Tue, 07
 Jun 2022 15:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <Yp/AGMpXXnx9lW6j@google.com>
In-Reply-To: <Yp/AGMpXXnx9lW6j@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 15:11:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcC15LsPS1Nj-e5nC-hR3oGVy+bQumyLD9vz4HzaDWAg@mail.gmail.com>
Message-ID: <CAHk-=wjcC15LsPS1Nj-e5nC-hR3oGVy+bQumyLD9vz4HzaDWAg@mail.gmail.com>
Subject: Re: [git pull] Input updates for v5.19-rc1
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
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

On Tue, Jun 7, 2022 at 2:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
>         git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc1

I don't know why pr-tracker-bot hasn't reacted to me pulling this and
pushing out, so I'll do it manually.

Maybe pr-tracker-bot is just taking a quick nap, and will be back
shortly. Or maybe it had some odd issues with this pull request. I
don't know.

                      Linus
