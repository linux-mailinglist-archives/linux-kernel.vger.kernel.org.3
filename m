Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700424EB8B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiC3DTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiC3DTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:19:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180EB181B37
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:17:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r7so11424048wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yahRLlo30jvQAyt3gJXuuY7Z0jTOLOnDhv26QzJEO38=;
        b=lmqlUOa1qQ6Iw7MVmz+qNL4Fwwl1YfU4ose4HssQjd+ivqnv5MpjHjEUvenu6+HoRD
         x56O1rmS9kzDqbyZRSxSW7xQuHpv5shI4DvVXOVUJ2diXFZn6xY5f6+HQWAiPJl6gl5A
         h8K4mbAH8rTxQq/9N8m/bUgWdImBxNttzKzBzGftwCdEUga8PcFfuLDbPBugkCGNBqp1
         29Jig2Fdxi7+9q4Xilg2IXp+J5pNM3FmF/Fth2itNUwcVuWMaq+iqNNCX3hAWJ7JE/gP
         0NfQ3RDLoGthZE1gQ2AvrMD3XUsD/xJ41jFbJwtnkwdI/U01VF+Ws3G82+LFAVW1d+2+
         VhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yahRLlo30jvQAyt3gJXuuY7Z0jTOLOnDhv26QzJEO38=;
        b=zML7RL05WI9Nt1bgZWJGQks1ICn9baVhQaBzc4a8Alku0lSEjIHxoxLb37gVGhj+Ty
         0cLT0g5so8elC0Qjsi+U4SUT1oiuyQJIFhqW1v4ExTXxp8fvP5lQiCaAwHNhdaqWc5tm
         B0aXgjAZ7IfRuDy+UF9Gf425tiLO6MH3juLUp5C9RA81hkaQ+aTk/HUgUaPIXTZKh5wz
         bEcOPBlFVJqpWxgBpsrvQjINHgPfjniEIAkdaMvcPcH5ojYLV0ZOmtIpoI8O8zW5dW8A
         p+MnsS8axypd1DsRWJf+5hga3rZEINNibQWSoXdAv6Scu73eazUN5xufUbo10r669Vt9
         FclQ==
X-Gm-Message-State: AOAM532yYnSsGT5fbwR/oANJ3IoBaAqh3G8djLFj2mrQM8kVMZdttgCP
        xVszI24Ga0UUSpdq+Pnk08CW/vDlaVen1eGFmL9DBA==
X-Google-Smtp-Source: ABdhPJyly+YpiCi8k9QHEBXuB5JtVfJXgMCrNsYliTo/GtYcp0o/rLEQG6DjYs9Yioh1vqjLMkA9ipVmmqifgFsP3vU=
X-Received: by 2002:a05:600c:6004:b0:38c:6c00:4316 with SMTP id
 az4-20020a05600c600400b0038c6c004316mr2433107wmb.6.1648610243534; Tue, 29 Mar
 2022 20:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220329214248.1330868-1-dlatypov@google.com>
In-Reply-To: <20220329214248.1330868-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 30 Mar 2022 11:17:12 +0800
Message-ID: <CABVgOS=r1HhBRjKmb6RE9MLbxD3TLfOxvATXH-qLHnr9yjO35g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: print clearer error message when there's no
 TAP output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

On Wed, Mar 30, 2022 at 5:43 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> ...
> [ERROR] Test : invalid KTAP input!
>
> After:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> ...
> [ERROR] Test <missing>: could not find any KTAP output!
>
> This error message gets printed out when extract_tap_output() yielded no
> lines. So while it could be because of malformed KTAP output from KUnit,
> it could also be due to to not having any KTAP output at all.
>
> Try and make the error message here more clear.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

At first I thought that this was "working as intended", but I agree
that it's a bit confusing, so changing it is for the best.
(And there's no sense getting too bogged down in the philosophical
difference between "invalid TAP" and "not valid TAP" :-))

This works fine here, and the code looks sensible. I tested it with
the --json option as well, and the result ("test_cases" being empty)
makes sense to me:
---
{
   "name": "KUnit Test Group",
   "arch": "UM",
   "defconfig": "kunit_defconfig",
   "build_environment": "",
   "sub_groups": [],
   "test_cases": [],
   "lab_name": null,
   "kernel": null,
   "job": null,
   "git_branch": "kselftest"
}
---

So, this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
