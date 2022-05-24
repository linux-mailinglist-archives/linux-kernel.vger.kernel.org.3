Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2FB53332A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbiEXWBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbiEXWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:01:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5787355D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:01:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rs12so26301845ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VzUpvq1TKMkoLi0+DTKi478LS2776TPp3B2qvzGUXc=;
        b=BJH7ptQma4+xzUDxx9dLH6FM508FrlBjT+qYB1j6ms+Y6tjxh2KR7toa4+JMY/VIav
         6hv2NAEnLjFil5Gtvt1mUhXeBLRFmhtvbSJFZZy1cPXvZYKrvEHRLKW+yP3fYYJLYIOO
         gzwGIQTV2F0iTNHmiU71U1QblHNBY4/2gXubM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VzUpvq1TKMkoLi0+DTKi478LS2776TPp3B2qvzGUXc=;
        b=fnYHmEmtsJVoLnewrdTWBWUOPgmdrE1bNz+ijsDQ5PvS9+TTsCsVEyxXNfEZPAshUA
         yJ0nHWo3V5FpJ53nI9lFjjPg7pIGpWy11vW/uNJWHR0HM1RU2wkg8mXZNh9bgNvQaLXS
         lOf3sjgLFas617idoyVG7i27sVvcvL5u7dqCbxncocZ/JrOYIjrWGpwkPneCbzl7coLj
         zxmTVf70FVXKJtYSGwW2hQyW6iLk8dohH/IQXP1H1EgBsSpWoVsoWiL0t5+rt0O/mg92
         +g3tGsRL3e2UZ2moiKRxEhKanWflAx2XW7zcJpYv7hdSwxQdlser88GvUqmlW6epEUDZ
         gSSw==
X-Gm-Message-State: AOAM532Dkoyq/4E+LXALWM/UQzzO1pGF5LFnLfPLsITcs93bDJW++FCS
        c7HPZC2PRlPq4+S7Xl/b4E2xM5RGEM3kpCDu
X-Google-Smtp-Source: ABdhPJwt4GM26ILHyZ2QiOBxae2HDjxAC1qQB24dzfkaIK2tlFuFd2N0ygb6ixWf3fRIa0FD9ffoqQ==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr25817866ejc.605.1653429658586;
        Tue, 24 May 2022 15:00:58 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id d2-20020a50cd42000000b0042bc54296a1sm256147edj.91.2022.05.24.15.00.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:00:57 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so2235131wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:00:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3d18:b0:397:6531:b585 with SMTP id
 bh24-20020a05600c3d1800b003976531b585mr2314036wmb.38.1653429657300; Tue, 24
 May 2022 15:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220523121836.27442-1-ulf.hansson@linaro.org>
In-Reply-To: <20220523121836.27442-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 15:00:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYh33UCe_sKvLWYY-ptPL6=T4m60b8vCX_t=qvmmOWWg@mail.gmail.com>
Message-ID: <CAHk-=wiYh33UCe_sKvLWYY-ptPL6=T4m60b8vCX_t=qvmmOWWg@mail.gmail.com>
Subject: Re: [GIT PULL] MMC updates for v5.19
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, May 23, 2022 at 5:18 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19

Please stop doing the horrible undocumented merges.

You have three merge commits that have *no* documentation. They say
"Merge branch 'fixes' into next", and that's it.

If you can't be bothered to explain why and what a merge does, then
just don't do it.

It really is that simple.

I've pulled this, but I really want to stop seeing bad merges.

                    Linus
