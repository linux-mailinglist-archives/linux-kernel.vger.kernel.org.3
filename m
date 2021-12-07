Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8644F46C451
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241172AbhLGUWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241161AbhLGUWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:22:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB11C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:18:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso2787776pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTMrDvwfzQGiaJPQBFbEv4AszPseMtF5ZS7lGyIY7c0=;
        b=YIBjOIRpVgxjMP9m6+2jWvLhIaDPgkFfxcvfB1utoJSHen4TVt3SyVmAUAau1ATvYm
         ysdxw3n48rlYfYHm2pmHsa+n8em0zUYn2Zkp1C6LkrcgckiDPz6iYQv4W1tZfzLCwKTK
         NIsqWSg5oxPnb0UpocpT/qA0fh75qjupob5TrlMtLK+Ygdxv4A5TvezolrS1236uieMi
         94koD/D3GZxmstngqH6wk74+z93GK2aeQzif30UPWcnsTAr9cIYu0+tNLCEnWDfKHuFg
         XZQRJ/nLjfduDM923bulQ6xKpnoRSNVAQgG5hv/gG6FpeVQaERGK3Bl3JKgJVtC1OBZm
         nfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTMrDvwfzQGiaJPQBFbEv4AszPseMtF5ZS7lGyIY7c0=;
        b=OrtRubxOMSnWkKSIF+dpBNMg5yHiCzQc7xeUlL+hXplz7CEGwrKp0JVdTPx3boxHEx
         PX6skTKy75NXjvJ3Rg8mziU5xVUsJaj3GLAGUC1klzkPWvH6SK7nCq2Q1oB40soLK5FJ
         aYNBMEDykkY3pI/p1M1ToIPFdSUhIQ1HLlgvE7dhEXZFM9bnOiY76TNnaaRNPEpIpA3R
         y1dzLwyZHntl3SoeKl7IOx/l2i81Alp3Mz/igWXMiNtkiBe0PmNie+iI2Cb/cQNrSfov
         N5S0j5ejPPqqGgzccc9+IMfI2Sd+HXVJapExgpXc5iZ8hzWXga06xcLa/Je5IoSLmYzK
         CQCA==
X-Gm-Message-State: AOAM532ZWdrYpU6OwnFnpSoA6H3cq8PSwAWQSH5vIA+4vxA+ArTQnC4s
        4kn3M9pGimZqSIjsxySdNXz/Fq2LDK1G75/c/t3hUg==
X-Google-Smtp-Source: ABdhPJzePolHYX+66SBsdghr9hv6MwgUMIieXN+1tZFLIjYVMl5V0gVFXx/3j64aFOuGS+eaRbDNvHLmOOoyqM+B+Cs=
X-Received: by 2002:a17:902:e852:b0:142:19fe:982a with SMTP id
 t18-20020a170902e85200b0014219fe982amr55086358plg.13.1638908324024; Tue, 07
 Dec 2021 12:18:44 -0800 (PST)
MIME-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com>
In-Reply-To: <20211102073014.2901870-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:18:32 -0500
Message-ID: <CAFd5g458aB5kML4TioAVF--aXwK1AiHcBi1vXVJM_cK6w8NKEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] kunit: tool: Do not error on tests without test plans
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmr167@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 3:30 AM David Gow <davidgow@google.com> wrote:
>
> The (K)TAP spec encourages test output to begin with a 'test plan': a
> count of the number of tests being run of the form:
> 1..n
>
> However, some test suites might not know the number of subtests in
> advance (for example, KUnit's parameterised tests use a generator
> function). In this case, it's not possible to print the test plan in
> advance.
>
> kunit_tool already parses test output which doesn't contain a plan, but
> reports an error. Since we want to use nested subtests with KUnit
> paramterised tests, remove this error.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
