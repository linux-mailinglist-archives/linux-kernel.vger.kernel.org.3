Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE351A512
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353153AbiEDQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353138AbiEDQRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:17:35 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5228E24
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:13:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i19so3816601eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NyjmBJU8zwTbLFeMwf6TGdRUSj+gIVdGN0MnXtRxNME=;
        b=iooNSkkR7Aqz7W+uJ0MJ8Uti1DfVcaen4bDeWBvpAqFsRxTiqdQ4v3XvoWcHnhYxG0
         HNWo8IZTH/pgsK83CFU4E5QmZxJWGGDJTwvCw8BYUbu3a8xh/JPmV4fWLNa6TL8d2d3H
         1rr9YlshCBh1mIv/M+HGKBTwAU8yj6O3qCUgKBuTuJ5Y5K2Mm21kYiHbu4T+Sa56p58J
         6rcJNjDJUsJDF8iGjS1piRwVWCTWCdI/V0WqBrZxgw01MRHD+wORoUWJgg7W4z28l6BF
         VIDSnQDApm8l+9jByCqoQi9OpIxJaan1hzD4oEQ29/P2HjxYTfvH3M7eJjhb13RIUe9Y
         1UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NyjmBJU8zwTbLFeMwf6TGdRUSj+gIVdGN0MnXtRxNME=;
        b=1laePGboSMeYR8a32EA6Q5Lf2Gqh3z0H8FwaOl8241WVqHFxra1nRQkiyVDEw05FSy
         XFmMa//LPei0QgmG1oaqKmuhjHqfhuuTj4c2U7rNy2kCXAs8fPFZEdn+c6nbdnAVFSXl
         XQkvoiY3IR6edrKkmEr8jtWULNj1GvoCb2/N2XXXZcQ8wieUKONpgJR4w2qg6TlmS3dk
         iE39lb6/ox8v8Xa00JqpAYgXf4PvIiAz4RuzAmQ4LrK4duzwvFwlZsbq1Z+ENYpuHqhA
         9oVxcxg+0G4Y46RgHuJXjsEaF7R545NIiNnVmJDreeDm8pGXKIJuTLbtzXsF7oi2WJnq
         bDng==
X-Gm-Message-State: AOAM532Kf8p29acECbbeyXHFiRd2rRyrQk8JrvqJW0ZwNZ0LK2PEmtPd
        lF16p5NvXtqYn/b02L3YZUIfEuR0t8PDhVyXtdnkbU6xuH/tOA==
X-Google-Smtp-Source: ABdhPJzTzZjF8d8y15pFit7/BGCLoRIZyUuJnVQCKerpKhqCTiyIkOmDr+rNqX8bbNzNnQkIDkqqu6ffi/sIFLK4lcU=
X-Received: by 2002:a17:907:9726:b0:6f4:c0e:40ce with SMTP id
 jg38-20020a170907972600b006f40c0e40cemr20324048ejc.170.1651680837175; Wed, 04
 May 2022 09:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com>
In-Reply-To: <20220504070941.2798233-1-elver@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 4 May 2022 11:13:46 -0500
Message-ID: <CAGS_qxq504dLbF_MWaJwNqLobjPAdZ2HOBFAiivpDE_WDYN+zA@mail.gmail.com>
Subject: Re: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
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

On Wed, May 4, 2022 at 2:09 AM Marco Elver <elver@google.com> wrote:
>
> Use the newly added suite_{init,exit} support for suite-wide init and
> cleanup. This avoids the unsupported method by which the test used to do
> suite-wide init and cleanup (avoiding issues such as missing TAP
> headers, and possible future conflicts).
>
> Signed-off-by: Marco Elver <elver@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Adding '-smp 16' and CONFIG_KCSAN_REPORT_ONCE_IN_MS=100 as you
suggested below, I was able to get it running under kunit.py with the
following results:
Testing complete. Passed: 168, Failed: 0, Crashed: 0, Skipped: 1, Errors: 0
Elapsed time: 92.642s total, 0.003s configuring, 4.592s building,
88.009s running

Nice!
