Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7A5A3F23
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiH1Slt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiH1Slr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:41:47 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A32FFD9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 11:41:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id og21so11832972ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=9gB7GKo4ZtOkdTHaCKeZUZH/SV1sRdPkXap+dCWBmo0=;
        b=aGoXvHIs4WqNoqTWcJQi0jqHCrwqxS4x9HKureOIIrnWBW2SSYLm2EIVGp4Nwtq6PG
         beJuYG7QqykOnmxg9mx7xbblUzyon9aqVcmedbOQk8H6rN1ZbwKSGIN14YL4p64NifX3
         af+UXxfhYQN9dYiiMTwXBZle8EN1cIHz4XP0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=9gB7GKo4ZtOkdTHaCKeZUZH/SV1sRdPkXap+dCWBmo0=;
        b=emasJoSgrYDeTqKw1nutQTNgcGX7PeQk5Z0KSgCVGka79uPvpDFDv10xbqolP/gNwp
         ZTBR8MvdH+FJyF2SEnvoeQzIFT1i1rCcKzrtgHywLbVGA839yVgGL5aKDTc+q5kyKLSN
         RSx4HVelOUpCD8BytoicMitNoBkbUYZurO7Ije+mAvKXq5CShV7AAatDMKKrhEGva+oP
         ePrcAoQ9Ag0A00KST1cqNM8CH8ilZiIfhBh4k5g741X/1gRX85CZ/t3QToFPCAy1lVo1
         gIGknGCOFguSfjF3rdJlkeqccSTcNE6iWtCz/GYchwBqseut8iwqHxcuENpc7cxsow64
         2rlQ==
X-Gm-Message-State: ACgBeo26LExa8/2YDXouFWJ7loTf06K4ugYWKCEGhB7XIjJ96BbQ2EWE
        ub154i2bEtqPhB4kvQfDWlAD9towY0kaN1AY
X-Google-Smtp-Source: AA6agR6o2zI1UIndE+y2RTZ/Xar5H1E5fUCNm1LEQEoXK7ggwa0ct05IXb/G5AE8CiC5mqEs1xWKhQ==
X-Received: by 2002:a17:907:2895:b0:73d:ddfe:79d9 with SMTP id em21-20020a170907289500b0073dddfe79d9mr9388627ejc.387.1661712104707;
        Sun, 28 Aug 2022 11:41:44 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id bh23-20020a170906a0d700b0073d7e58b1bcsm3472828ejb.157.2022.08.28.11.41.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 11:41:44 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b16so82279wru.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 11:41:44 -0700 (PDT)
X-Received: by 2002:a5d:6248:0:b0:222:cd3b:94c8 with SMTP id
 m8-20020a5d6248000000b00222cd3b94c8mr4686216wrv.97.1661712103682; Sun, 28 Aug
 2022 11:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <166170992386.1651569.17504808724724706636@leemhuis.info>
In-Reply-To: <166170992386.1651569.17504808724724706636@leemhuis.info>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Aug 2022 11:41:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjn-GVDLEN0F+WT0PWysqH7HMD+mBjKUr65DEhav47u3w@mail.gmail.com>
Message-ID: <CAHk-=wjn-GVDLEN0F+WT0PWysqH7HMD+mBjKUr65DEhav47u3w@mail.gmail.com>
Subject: Re: Linux regressions report for mainline [2022-08-28]
To:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 11:23 AM Regzbot (on behalf of Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Not sure, maybe it would have been good if the following fix would have
> found the way into rc3, as it seems more than just one or two people
> already stumbled over the regression fixed by it:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?h=3Dmaster&id a8e0f6b01b14b2e28ba144e112c883f03a3db2
> https://lore.kernel.org/all/?q=C5=93bffc7*

Neither of those links are valid for me.

"a8e0f6b01b14b2e28ba144e112c883f03a3db2" doesn't exist in linux-next.
never mind that that isn't valid link syntax anyway.

The lore.kernel.org link is also just random noise.

So I'm not actually sure what you are trying to say...

           Linus
