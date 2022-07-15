Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE00457651B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiGOQJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 12:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiGOQJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 12:09:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1306326AEE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:09:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z23so9768451eju.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJX3p7X7GOK9qVv2gnItONL7YBZZiTBUGOlCpJZhZxY=;
        b=eE19BX8P41MJ8LvSqx7a3/EfGqy7aFcAFZcad09sakHSWzOt11snamtSBbG0tzr8fN
         pYAUz904GxuKrfnaZ5fTeksUP8XthihCE66GsE6uqzKjbXCJEePGfxBneo4jtTzkzI7+
         GJdvzo78GF9F6X9KbCQMCswjQhlqAA61cHJW3HpzdbIf1Y/rxXQITjapcxG8w17HtJIA
         kFwl0L1PNNgdcJyekKsSpJOaPN1c0ht0qlyLZEoGVarNg2PARkbVrbMX45+71Ri0ianP
         MnNejcShBBDnMCH1nuG+bR9BCNrN9gK8KpCBbZNelS6Vo/ErQBLg8tv6vLDfBkgpp3OH
         cogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bJX3p7X7GOK9qVv2gnItONL7YBZZiTBUGOlCpJZhZxY=;
        b=dWgIF6pp7daq/xdtLZuTE7fibZy0e9oFDqkhII/Rl/JuKhA3gehhTUWYIJZghu/R9L
         s97Nx96XH/zdy7xFbtiQ+ovjiPNEBLF4ABiHDfjB2h7qyse3gzwP9DHInSv3Ba61CtaK
         gvGhQ57hQ2/E3DoWD3Ek9p8AQkSov+iDvJPGUZYQV8beqCGmrv69moPm8xGrpr0HTetS
         1ykDusQKs5UFby3ZM9tSL3IE5FB70aFOjz7fhgnobbwQ3XsswUM5sF2zJzIaMa8EGKXq
         iqbutGSENRCYQQqBG9WpwxzPRG7+ODTEw5l8k1FvGp5xNPqS8IH3eXTYryS1gfeqHvQt
         IpAg==
X-Gm-Message-State: AJIora8iNoJNrVoRlAXSN11YtmMV3dI4ySsTLOVKnlCW7+0d5eqacwXi
        w7t7Etzj/gP68nUMlSY5pVtBG7oCxLVhbq1UIlUY3Q==
X-Google-Smtp-Source: AGRyM1sROcVO8OSKO7qwFvpaqjCzgRod4XOTl9oCAfqXqI/bNiuw8/q0F3IhK0EVtOw13yHA3z5xh0GJa2L7AQirM9A=
X-Received: by 2002:a17:906:8a45:b0:72b:31d4:d537 with SMTP id
 gx5-20020a1709068a4500b0072b31d4d537mr14666472ejc.170.1657901354531; Fri, 15
 Jul 2022 09:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220715064052.2673958-1-davidgow@google.com>
In-Reply-To: <20220715064052.2673958-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 15 Jul 2022 09:09:03 -0700
Message-ID: <CAGS_qxpMJtuqOvOhqXa-dMzvQX_88hnidCPxZhWFVdedxxSfoQ@mail.gmail.com>
Subject: Re: [PATCH v2] kcsan: test: Add a .kunitconfig to run KCSAN tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 11:41 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a .kunitconfig file, which provides a default, working config for
> running the KCSAN tests. Note that it needs to run on an SMP machine, so
> to run under kunit_tool, the --qemu_args option should be used (on a
> supported architecture, like x86_64). For example:
> ./tools/testing/kunit/kunit.py run --arch=x86_64 --qemu_args='-smp 8'
>                                         --kunitconfig=kernel/kcsan
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> Acked-by: Brendan Higgins <brendanhiggins@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Ran it and everything worked as expected.
[16:06:34] Testing complete. Ran 141 tests: passed: 140, skipped: 1
[16:06:34] Elapsed time: 70.861s total, 0.002s configuring, 3.519s
building, 67.276s running

Ran again with --kconfig_add=CONFIG_KCSAN_STRICT=y
[16:08:29] Testing complete. Ran 141 tests: passed: 141
[16:08:29] Elapsed time: 83.355s total, 1.557s configuring, 24.188s
building, 57.582s running
