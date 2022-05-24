Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAEA53338A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiEXWaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 18:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbiEXWaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 18:30:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA09635855
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:30:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ck4so33873591ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UoL8UouejxI345jMXPVubIHv74eQbvQqgzHXEHWV0Bw=;
        b=bVAfAmfQZrFwKusE/UDZf5VLi4/7Q4AYN/Crlhf+AalFHGbJ39jaE09Y65EIvpnsY/
         SzrEHsXxPp7TYD2nPlsE1UzawIHmWgEcBDL6yhGt0BJuX7PzHtjD3qHoKKb6ObTW2aYA
         1IGjY3efPWV/VlRFnXm8r2LOneJc03/SwsCjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UoL8UouejxI345jMXPVubIHv74eQbvQqgzHXEHWV0Bw=;
        b=jHiI8jDCEttrMZ4fQvP9MJJGrQF6Ba/yE6IsZUYwTkmOy2ijlEZtc3ZZD/e18fMDMk
         V/XeAYcoMcwkMccxQb0GUXVkHkFR/QG181RmGX2IpYFT789s5k1vtyIylLIwisrOX0ET
         7pUFeq/v8jYgaFZDrbPngwfyr3AKw4AkHPbWEgdefTeWu39bMZ7kkJoGaaAdd0K4mdaD
         RIYX+82e4sKOmCQFilUWl1JW2OaDMMVwqxJbNSZAZFvE5zkq0Q+0hvWBJK/8XcqN9UTi
         PnDKguIMauEBOxCy5qyTso/4EQn22Il0DHXMzqHHctFyN2UBQcLM5T3QJDxNFKlAO2iq
         GymQ==
X-Gm-Message-State: AOAM532qKuFfLYaaTgiX7BXINqed6I0YGwYe/fS5vZtT6j6ylSZGhMTx
        qFa2WXcS4UkGfI9a1WfhHzp4/RmM1ZKkQO7D
X-Google-Smtp-Source: ABdhPJypvZxCEF4hRkp9vpQAVizYhnaZg1kuw6MNdE4eyOchTm+JZvaXjobXChSLm6HMUo2IdtSCfg==
X-Received: by 2002:a17:906:a186:b0:6fe:8a06:849b with SMTP id s6-20020a170906a18600b006fe8a06849bmr26223142ejy.635.1653431398974;
        Tue, 24 May 2022 15:29:58 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id zd20-20020a17090698d400b006fe960c5c5asm6339652ejb.126.2022.05.24.15.29.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 15:29:58 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso318779wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 15:29:58 -0700 (PDT)
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id
 m17-20020a7bcb91000000b0039732250244mr5664550wmi.68.1653431397793; Tue, 24
 May 2022 15:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2205241107530.28985@cbobk.fhfr.pm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 May 2022 15:29:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh91nMR037ps4B=AUOEemZVr_UKDdUmpSTpYGtV2909kw@mail.gmail.com>
Message-ID: <CAHk-=wh91nMR037ps4B=AUOEemZVr_UKDdUmpSTpYGtV2909kw@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 5.19
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
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

On Tue, May 24, 2022 at 2:11 AM Jiri Kosina <jikos@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022052401

I've pulled this as you can tell from the pr-tracker-bot reply, but
please improve your merge messages.

Some of them are fine (eg that uclogic merge has explanation of what
it does), but others really only say "Merge branch xyz into for-linus"
with no actual information about what the branch does.

Please?

                  Linus
