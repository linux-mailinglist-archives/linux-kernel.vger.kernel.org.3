Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37B85884E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiHBXrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiHBXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:47:14 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E8C54673;
        Tue,  2 Aug 2022 16:47:14 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id u9so18237550oiv.12;
        Tue, 02 Aug 2022 16:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1r7BMu+e52KMvTlTlsEeBScPSgTDXdrzxQKCaN3tXo4=;
        b=XVCcSxO3BZdIRw4f2nvR2JflUa7kglCJoL2GSedsRetwLgzVEDh5EzKXXRNEeV0XT1
         m4bgsDJX8j/FcIjsuMQEC5Yjp3sJgJpsFfkpP8WoYpWIMAh8Y4ZB/upSMKLuUrkvdads
         Wkzm8w0F+nbBcKlbl0rsUMrEgPj7L8YTioNCtF2cOlJiwVn+dHgnWdRf/82vATVw9QOg
         Dt2MtyXjPDUBmcFaDKqWsCpLEoByoyDDm+aN98LEV6V3deKyvUT5g7TqMiFUtrqJMp/l
         B77O9+AbfJma94wV6x4XbnnWghvLJQWUB1TmKYHjg+v10WKJ2RpUXfHmqCH+aPpgXC+X
         n/vg==
X-Gm-Message-State: ACgBeo1ySmKGfKBeQODHSJzEOSrrM5sz950vwYUUfpA2wbZLKJwPAb99
        1zxWexi5lUH82Xzsw5Y8agPWNGmzyf8rZ75qOws=
X-Google-Smtp-Source: AA6agR5x52u8VYhoCIElD40vDyBxJ/TgfmRg47KshUBAkgN+Tu5P0Fy1+73Yiz32f52GD4qI1QyVBFQibNauTtPwZks=
X-Received: by 2002:a05:6808:1492:b0:33a:7448:8b98 with SMTP id
 e18-20020a056808149200b0033a74488b98mr736688oiw.92.1659484033343; Tue, 02 Aug
 2022 16:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220802191004.347740-1-namhyung@kernel.org> <YumRXcxc5XIUwlBO@kernel.org>
In-Reply-To: <YumRXcxc5XIUwlBO@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 2 Aug 2022 16:47:02 -0700
Message-ID: <CAM9d7choD8v8Bxu3w4V1Q3M1i7SwP2W+pY5ZWLqUqr89O2PLOQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf lock: Introduce struct lock_contention
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <songliubraving@fb.com>,
        Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:04 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Tue, Aug 02, 2022 at 12:10:02PM -0700, Namhyung Kim escreveu:
> > The lock_contention struct is to carry related fields together and to
> > minimize the change when we add new config options.
>
>
> Thanks, applied. Forgot the cover letter? :-)

Thank you!

I thought it's a small change that doesn't require a cover letter.
But if you prefer seeing it for small changes too, I'd write a
short letter next time.

Thanks,
Namhyung
