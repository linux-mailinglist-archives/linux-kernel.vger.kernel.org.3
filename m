Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464534F9E25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiDHU32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiDHU3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:29:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A1B1D917D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:27:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x17so7803508lfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nQFVlwllC4YnO25+yufuwuGbhqunVpmbD2hguCYOvy4=;
        b=gWK+aFb/GaZFlvfNwH34Q366kaZ1QLSjm8LMPraJtyTtSOP3uKID/gRWIip6eNC0eL
         4bRNqWUu7nJKvVRcA8UVg4XFmEEFuJ+OUae9PxIfeS2hl2xtHUxkrRP27d9lDzRnOrvs
         fg81B8sMB87WkbZF9zuv4XoJXV+zgAyTDQEKep2V4yFWaJWXBiN6VvjC3wqltYPuQa+6
         /3vlLj2aBEDyVBuZk3J/POGzeXJQv+HzAi5IlCtoAcSM1/JHolNCNGYjzsgoOdaNJxCf
         2J29txGALCTVyPdW8SNgGSlCG9XxiSaUM0uMEJhePlYgD207TTDonFrPR9Y4rdDPjQOG
         5VPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQFVlwllC4YnO25+yufuwuGbhqunVpmbD2hguCYOvy4=;
        b=xXx+XPlEqQXFEPMxn4oYa2t1GWK/TVjjB57omgWRts4MtJ9Z9fA8+CR7XzCe6oMRz2
         J4mQgQx48jvSkp91U9wj5EY/7JItMAjvGFHwX8MsryJBHQXX7leOyaYABBRrGsL/S8Xh
         618WblZ8AVkEisQcPJWOeTeGogfSfQibRK3d0oRqcsJ5gVzSHQ8dtxEk0qbmmpE1eqDm
         KBudz2/xN3fr4Wg2HnFZXNxl8YwbGl7R5mwzSQuDAH4mMq15sL+PJLvO6dGu3MzOGfPP
         Bjv5Y3Nix6cCJP0ZyfemNoNaRxJP4TG3seNMkjAhldX4et9Vqurty2aPWh6b9WjO8v2z
         qYww==
X-Gm-Message-State: AOAM533xiMkyfTzsnTAqf05QlG80TVK6ZiF1ikCCf5LY79p7Eos/EpQW
        nPUc92yqZEsO9bz/NM88n3ocWuHXzDWhx9eYnNh/hw==
X-Google-Smtp-Source: ABdhPJy1buaZxT58htvnHFpW1VHCKRzCOuuekg5axqM58M9plO2OfHYEUC21WYU7xlWQwG0z2bFELCJwjSwn/k+ArK0=
X-Received: by 2002:a05:6512:3da1:b0:44a:2aeb:28e4 with SMTP id
 k33-20020a0565123da100b0044a2aeb28e4mr13355498lfv.579.1649449636724; Fri, 08
 Apr 2022 13:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
In-Reply-To: <7fad83ecde03540e65677959034315f8fbb3755e.1649434832.git.jpoimboe@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Apr 2022 13:27:05 -0700
Message-ID: <CAKwvOdkKkCjt+a51mQk8+76uYyzvYSPVkNrmK1KW2w1Fk5yfog@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Remove CONFIG_DEBUG_SECTION_MISMATCH
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, x86@kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 9:23 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> So it's basically a debug (non-production) option, which has the goal of

So I think I agree that seeing it used in defconfigs is curious to me;
I'm kind of in favor of removing its use in defconfigs.  I wish the
defconfigs for more architectures were something closer to what a user
should reasonably start with; I don't think we'd want to encourage
people to actually ship kernels built with this option enabled.
-- 
Thanks,
~Nick Desaulniers
