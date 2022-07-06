Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA00F569385
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiGFUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiGFUol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:44:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CFB286F6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:44:40 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so29009426ejj.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z3UotlFtUTvslGYUw8cZAVdfuGjI1A/SzFtykXKyRDs=;
        b=XXmST8IjmjKhpKR+8so2eTQlXVr5n4bcdbvCrQR6SsYDKxke/r6gGxBTEs3PzBfUyh
         Gho/qFWBPkNnlvgZsPIcaSiRBSvnUQTjMZclY/lpnE7hoaQUck8+EJDww8z8kDOjxiZv
         eSqdsmEU3zuFO1PAoxfQxKRN4J49RhPgLvgW6F4soy2RKNVzFJpojZ4RhC6KF8lF1Aqb
         HieFtfEJjL/4yCDZtFqlIIqR4T0tEOOb21VGvz9PmnH62LTQe+tbS9DiHvJmIRMm8YKm
         rZ6+8sGp6O3LS6QnsZ0HFLsbdn7cd1jNUe1eGqbgmsT6YH/QfloSLjfYo8pYvcO5vRzK
         E/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z3UotlFtUTvslGYUw8cZAVdfuGjI1A/SzFtykXKyRDs=;
        b=O8G4/zL/9XUMZqwbgdpieSgRWpRIiiGl/vMea3BPNHNmfA4jmwEFxYdYLk8va6wT9j
         gO8nvR4Ze86C/WOyKhwSVfJvGrQN9wFIwMZWrUciN12hy5SsbQYu8RZibEDMoDQBbDk5
         A9BcEDMszMmdZFkqXEuGFcZiLPfuQrM7eNITLeFaeu17M01KjtAuwlscoij98z/kBwGQ
         wE5mhQ4u6naf2UP5HVPbWX1ySyPVOjN9d1+4SL8zpPTOMTZIZS2bbQOF3adFVCSEfwuP
         Q/V8NtgUqZlWiycXud1Fem2oFbrahjAmOjfQt4Lgr2bLfh6q8nZziTOk+6M28v9cK36D
         I7RA==
X-Gm-Message-State: AJIora9GtBMFWqHhNkKB1mvizraet9A3Ot8x+zkUumtGk3D8jDrcuL6M
        9EZ8aHn4OiehK6auKnBHl5eAuyIWTbiWajb99AnBkg==
X-Google-Smtp-Source: AGRyM1vw/CTNjT0hp6sr0FIU1O+7erCuP7vrTl99ZxAX3PeTqVb05P8PgJwW0udPTa4ikFyGunX9tNbx/hXemripKPQ=
X-Received: by 2002:a17:907:3f81:b0:6ff:1a3d:9092 with SMTP id
 hr1-20020a1709073f8100b006ff1a3d9092mr41210405ejc.319.1657140278463; Wed, 06
 Jul 2022 13:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com> <20220702040959.3232874-2-davidgow@google.com>
In-Reply-To: <20220702040959.3232874-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:44:27 -0400
Message-ID: <CAFd5g44UFqEe5WwKurzOMhT2ijUEvv-4R3Eo9W66c_Qruk2jAQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] module: panic: Taint the kernel when selftest
 modules load
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 2, 2022 at 12:10 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Taint the kernel with TAINT_TEST whenever a test module loads, by adding
> a new "TEST" module property, and setting it for all modules in the
> tools/testing directory. This property can also be set manually, for
> tests which live outside the tools/testing directory with:
> MODULE_INFO(test, "Y");
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
