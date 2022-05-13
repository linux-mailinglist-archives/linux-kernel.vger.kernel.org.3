Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5095E5268D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382699AbiEMR42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiEMR40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:56:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7178131298
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:56:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a21so10862275edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWc83us6iMjMu47b13RkKYsUekDxzLK2yhJp62YG0VE=;
        b=q7PrcJNIn0gW+0mdIBE3Lb2D4x8Zs/S5YjdL0E1Dn5ksSTT7QVqsVTvcjGPk8xd0/6
         /VVIfqBrssRPjaJfhigS2Mh7TvJLp8WF7UtMeywSD+yz5YDwLaiBf2ZCto7RcTO3+LvC
         WvlmIqg+8iw7x517MnsRhr7CGR00/zNi0eZTab2War8/IPEFeHu8SLbs8qyy2Drp5d2c
         ceMsF3S7rfl/HCD0pnof6kzrawMB5e1sNK7wcQmKIGCHHnP7GlbCW5q0kiNojmRmJzLF
         /1XiSwLX6j1cAi+odeyRPbqgTtpxEeS57itFCHzX0TU6mZNxDs0Ohs6o4IFx3+u6O7+4
         MMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWc83us6iMjMu47b13RkKYsUekDxzLK2yhJp62YG0VE=;
        b=SPI4AQZLpiS3R1X5Vya2KvxSVQ9nRODnzaSmBLe3GpV6xHtugehFgRyYgBQy4fg5Kk
         Y3s/zEUKxmIcLCl1ZFtiyixR2l7Jc4e2xPZBi9hSVkpgVarUT7Y0C3YqYihtoIvsUNgx
         EQECeSzBzU+7jVoXG87bPOS22H6l8eOOPyfC2oudRHEBLxIC4DQeqv77QrnyWk77KVFG
         yAFSdm80fmnK/VIHNpyyj9Vhmco65rL0G1S6vEoLI0wfaCCAMLb3lK+59Rw8qVBGkAI/
         gJm1tqrmGygCYxc14mIkU1GJCfzv2UOZJPCGFkTiHtRQaX/aMus/KzwYFqD1pHiFC3j9
         DqPw==
X-Gm-Message-State: AOAM5303SK+P7TZWDvRZbATuyHa2vgkErlkwXy48i4WIZnbAuptCMfLe
        BqjkJcI/hhCqSbSGcczts/c9eKXAF1y7Ozh7NrXkMg==
X-Google-Smtp-Source: ABdhPJztcxFof6vQQCUrj255nWqwJp/jUycfRknzGjGqz8uMM6QrL9A3Sa3lnknkdyMfuxc1tTl6qn42rJ5GZa1y/AI=
X-Received: by 2002:a05:6402:190e:b0:427:bb26:7337 with SMTP id
 e14-20020a056402190e00b00427bb267337mr41640906edz.294.1652464584134; Fri, 13
 May 2022 10:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220513085108.3567310-1-davidgow@google.com>
In-Reply-To: <20220513085108.3567310-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 13 May 2022 10:56:12 -0700
Message-ID: <CAGS_qxpZBd_ViGvWQxmhnThQ1YBb3k1DhmkHcmENzW9SY9hS4w@mail.gmail.com>
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

On Fri, May 13, 2022 at 1:51 AM David Gow <davidgow@google.com> wrote:
>
> We're currently using the x86_64 qemu for i386 builds. While this is not
> incorrect, it's probably more sensible to use the i386 one, which will
> at least fail properly if we accidentally were to build a 64-bit kernel.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Works for me:
[10:55:58] Testing complete. Ran 201 tests: passed: 165, skipped: 36
[10:55:58] Elapsed time: 21.268s total, 0.003s configuring, 4.009s
building, 16.967s running

Side note:
I ran into an unrelated bug where running on QEMU in general seems to
hang when you try to filter to a test suite that doesn't exist.
I've confirmed it happens on i386 before this patch, and it at least
also happens on x86_64.
