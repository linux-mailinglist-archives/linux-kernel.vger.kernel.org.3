Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBA258DCA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245195AbiHIQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245185AbiHIQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:59:16 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F1C23BFB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:59:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e13so15852991edj.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wd497S56+K95g5FaqzrmxaFzjMGRAlDYX8elVPh1XVU=;
        b=BU2X6qpa/x075cReLXeIooVs+K5g3X+YtWLif1Vi9M9uo8Jntz/7IsCFIT4sdxTUKC
         k/DJVSY3ZerzpUWGkUpXFuRKGKexKRZ5Rrlmkl6WVL5OXhP+58+DzkLrRROI9V5iprRB
         VwWszW99AuOHZBNx6muATlWHDRvNuDi3fumVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wd497S56+K95g5FaqzrmxaFzjMGRAlDYX8elVPh1XVU=;
        b=F8Sx86sF+PflwoFZY66U0sTcCf0FgZMR2uRLejc3l4Nqxvhb9nuBQ1XVcPTyZCwJyJ
         XMfxhch/tAyn0xDhOaSqWWnVE8QZRRB+Lgqsz5zaS7yshqVZdjuTciAeeWRGSMsRzIAh
         Gk25rdTRWE9TF5Ier4ZJ1A73npppmQ57f/IgIjgcKGp8pqZXOx1cV/fxG8y06TCeTG4Q
         N7yRpsfP2J5bOZ1OlnQ/5NYKfGambEqBfjqF3HSs2lLbBhPUtcUaoy6kdGtXDJBqQGwl
         R7fMPf5OL1WG/XX/Jjaagg6tcgVfv5OuVhtlF2YE+g2wZR6Iv6IzE2PiMzMXkdlMQlwT
         FYdg==
X-Gm-Message-State: ACgBeo1QAhUjSK0rtpTAc39uwpOJiCTiN6BhdEGjUBifCedvu1Jos6gN
        RGjCVRajGtRhMn27T3XE7qvBe1G+zKXL21s3
X-Google-Smtp-Source: AA6agR5qy6WTn4pdOygOSl/ffyl1q++6cxaJ2rz3d3J81/3mm9NN6atBTkI3xt6MGNz1Fzqi66Eb8A==
X-Received: by 2002:a05:6402:888:b0:43c:fce0:2f0e with SMTP id e8-20020a056402088800b0043cfce02f0emr22548844edy.247.1660064353701;
        Tue, 09 Aug 2022 09:59:13 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906314400b007309a570bacsm1300524eje.176.2022.08.09.09.59.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 09:59:12 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id l4so14954974wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 09:59:12 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr14642883wrw.281.1660064352374; Tue, 09
 Aug 2022 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220809103957.1851931-1-brauner@kernel.org>
In-Reply-To: <20220809103957.1851931-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Aug 2022 09:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5pHi37dk0Ru93yvmJYU-FpcTpJ6tRcOQqO83SDkgMeQ@mail.gmail.com>
Message-ID: <CAHk-=wi5pHi37dk0Ru93yvmJYU-FpcTpJ6tRcOQqO83SDkgMeQ@mail.gmail.com>
Subject: Re: [GIT PULL] setgid inheritance for v5.20/v6.0
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
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

On Tue, Aug 9, 2022 at 3:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> Finally a note on __regression potential__. I want to be very clear and open
> that this carries a non-zero regression risk which is also why I defered the
> pull request for this until this week because I was out to get married last
> week and wouldn't have been around to deal with potential fallout:

.. excuses, excuses.

Congratulations.

              Linus
