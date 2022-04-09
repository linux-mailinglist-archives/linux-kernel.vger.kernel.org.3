Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6904FA4FA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiDIFQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiDIFQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:16:25 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E160369D5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:14:19 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id d4so7175719iln.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Jm5k1O0ZeZqd8MeZ2OXXiUTadUaS2iqPnz3zX1P9dJ0=;
        b=VdumWYMSMHXHPzqhKgM2QguXKGHpjCspmt9ZajAMKYWkR7qaIhoZYOOoZt3LpT1t0t
         od0W2wY9wJXXfl9j3B3r43mJ6nUWEPP/kxqsSU5u8cb2wVlZUJbVyY0LUKJdaVWLkDdw
         W5N8n0rtZVfkVXcYNpoSxUwuR7liE9sKGylDpATugD0v+n5XV20oU4zEPVA+rxPcDigC
         V8RpLnp6I9CDOKWpYYmsUwI5CrHPY48YARRzoaH2qpslMNN96NvM3XiAkSkOKCeeIXla
         OX4kqBSG7/DWzWi/F5gTUcCrBJVMcf/zA+IVcnzefALZs/Qrj5kRUAOGhooR5GgcET38
         ipcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Jm5k1O0ZeZqd8MeZ2OXXiUTadUaS2iqPnz3zX1P9dJ0=;
        b=jOCDSQEdhMV6pOECjiV6xQrdaVSIyrNaH82iZkw/T4oXK49Xh0tcyqGH3zyZY4nU01
         4KdJCTj/NvinMOmCUzF/i+9Q/wW09L35Q4f8BKVsi3FX8noBMwTmXMsI2BNzLBdywWvR
         flXQDzikSlJYaASE94V8PzbBm1yug2WZzrR+zViAgUEwxUdtbgU46pPhA5iMgtMoVV9R
         qRTKOcheYPLAESqjH69GuduGJtX1RSfCVJaPfPE4MMqboaTwCIgTPOAJPVZZtXkdH5KW
         5L176CWp4mI7IDD11voTy33z4FkdAzaNovKv9RDRcSGyep4BYEyuCBUpmmTp5mzpnHbw
         DMmw==
X-Gm-Message-State: AOAM533qI/ZWktKQO2Vf95yc3kEg4QOmGJgYU/3s0qGmwlMgHE+zeFuo
        ILyXSgjsQs/YVOGq+HibBtg2hwVbM4l7pfCrXGQ=
X-Google-Smtp-Source: ABdhPJxyb0VSxkPRCzucL6+7ah35z1gL825BphoporD9eRi1bwf/QqsOJDu9qqdiXe44nyqtrsFOIzZt8WVOQ0Fg+D8=
X-Received: by 2002:a92:cda6:0:b0:2c8:8289:c31 with SMTP id
 g6-20020a92cda6000000b002c882890c31mr9152461ild.245.1649481258794; Fri, 08
 Apr 2022 22:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <YktYX2OnLtyobRYD@kernel.org> <Ykto1FgmPMMCysbI@dev-arch.thelio-3990X>
 <YkxWcYzph5pC1EK8@kernel.org> <CA+icZUVMtrqRA-a3k8N0fVcszm=Sn2Jb9nMfF8mXqvSTu2HUhw@mail.gmail.com>
 <Ykyfzn6Z8Wkf1Ccl@kernel.org> <Yky4TjOLiVvOcLYN@kernel.org>
 <YlBLh6Y0WWEVuN1F@kernel.org> <CA+icZUUnj-CjG3AsypSdJ3szx93mx49uD7MaBCeSbHqa50QYuw@mail.gmail.com>
In-Reply-To: <CA+icZUUnj-CjG3AsypSdJ3szx93mx49uD7MaBCeSbHqa50QYuw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 9 Apr 2022 07:13:42 +0200
Message-ID: <CA+icZUVAAfwet87Du60EBode-byot4w9z52aeEGffXViqw8nzA@mail.gmail.com>
Subject: Re: Build perf with clang, failure with libperf
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fangrui Song <maskray@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Keeping <john@metanate.com>, Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> P.S.: I requested to bump perl to version 5.34.1 (see [2]) plus diff from [3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/urgent
> [2] https://bugs.debian.org/1009170
> [3] https://bugs.debian.org/1009149

OK, new perl package shipping the fix.

perl (5.34.0-4) unstable; urgency=medium

 * Refresh cross build support files for all architectures.
 * Fix massively parallel builds by first making 'depend'.
   (Closes: #996953)
 * Backport upstream patch to perl.h fixing build warnings on clang.
   (Closes: #1009149)

-- Niko Tyni <ntyni@debian.org>  Fri, 08 Apr 2022 20:12:38 +0300

- Sedat -

- Sedat -
