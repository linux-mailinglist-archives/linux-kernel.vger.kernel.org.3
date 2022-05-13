Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272D52697D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383319AbiEMSmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348518AbiEMSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:42:04 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C459FBE0B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:42:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so17916037ejw.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAQeIBf4PvlO0it5TTCjNPqNomKKAaQVUSfYda6ECZw=;
        b=VC/H6f/7g19TaXnE96fTaD/G7yxQezCnJRFTTuVSlm2tUwzE2nEqWXrhMjxQzFpmks
         eq/SLEbaoFDjS0ArsYXvLXJkPJMBaeCOccMhJdKvsy6UiRJLQWqFo0dxGIntj49n4Xim
         kQHjjezNuUP0xKkwVaAY72dA9uAA1uwTb1ApvYiiDhgO8lx3QjguokP85uLOekK63gGc
         13TnV2fQ27lrj45aGYYwAlFfYoK25BVIRwl6Ndayr8fRK5Vy4UwTtKoiTFXjN4Nc8p35
         CsolvBbY2P1QT6l3VafV6M3tnqqgZbNr6vPxz7/46iy6Z4TrOoNwqf/UzvCx3UcAyiM2
         sYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAQeIBf4PvlO0it5TTCjNPqNomKKAaQVUSfYda6ECZw=;
        b=Ns67iEZVWBLNDozIX+vYkes1LcXn/9wlLug49e63VgOtFohLn1NtG4JLPeYWuh8vvf
         Ej9b5jtwZsMbiTceZQZKQ1Nuf8ePmKbhds6lO2HPFQY13FHOqRZ0OW7z7s6HJHS4Kqpz
         qHac1giilMkGMdExvxSYvnZ8ZjIZ7LIO4Ogf5NvR/BYHJTRa0mHhB3J4Id9dpDsORGvM
         mmX1W0b5j4u/5JT7kCjAxWpEzaZN3hYAjFu7DvJZkpAdfHmYDCcy2KqHhTrivdfjJh0Y
         zuodw7TRgKiveo9/XaFOHK4gZ5NExfuy0bFC3R3uaDy35UreH2PR25xR1NopUZY0vVGE
         mg8A==
X-Gm-Message-State: AOAM533iJgHAyLHbT2WffRu6rrt92SgoO7VjoTDGTcIDGTZ7qJKHTcKJ
        U/od4q/EPkkwpZGMEABI0LqM8JEKkdTfY0pSjmTb4w==
X-Google-Smtp-Source: ABdhPJzcAnNGF5kTV7YNJbqjKzLHe+3AjZK0R519qbPTPUqCf/7lfPt8UJfkm/fKrWAuqWzncPeZbfaDoSgxdJNPKlw=
X-Received: by 2002:a17:906:7309:b0:6f5:ea1:afa with SMTP id
 di9-20020a170906730900b006f50ea10afamr5382431ejc.170.1652467322175; Fri, 13
 May 2022 11:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220513085108.3567310-1-davidgow@google.com> <CAGS_qxpZBd_ViGvWQxmhnThQ1YBb3k1DhmkHcmENzW9SY9hS4w@mail.gmail.com>
In-Reply-To: <CAGS_qxpZBd_ViGvWQxmhnThQ1YBb3k1DhmkHcmENzW9SY9hS4w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 May 2022 11:41:51 -0700
Message-ID: <CAGS_qxp7YrsdMrvpqr0Xy3F8z5HCjt=6Lm2CDTAtqSEOBBO6Tg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Use qemu-system-i386 for i386 runs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, May 13, 2022 at 10:56 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, May 13, 2022 at 1:51 AM David Gow <davidgow@google.com> wrote:
> >
> > We're currently using the x86_64 qemu for i386 builds. While this is not
> > incorrect, it's probably more sensible to use the i386 one, which will
> > at least fail properly if we accidentally were to build a 64-bit kernel.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Tested-by: Daniel Latypov <dlatypov@google.com>
>
> Works for me:
> [10:55:58] Testing complete. Ran 201 tests: passed: 165, skipped: 36
> [10:55:58] Elapsed time: 21.268s total, 0.003s configuring, 4.009s
> building, 16.967s running
>
> Side note:
> I ran into an unrelated bug where running on QEMU in general seems to
> hang when you try to filter to a test suite that doesn't exist.
> I've confirmed it happens on i386 before this patch, and it at least
> also happens on x86_64.

Ah, this "unrelated bug" is my fault, specifically commit a02353f49162
("kunit: bail out of test filtering logic quicker if OOM").
The use of _any_ filter glob is broken on kunit.py + QEMU.

Fix is https://lore.kernel.org/linux-kselftest/20220513183707.97290-1-dlatypov@google.com/
