Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84CB4F1E66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350059AbiDDWLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiDDVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:30:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD79FEA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:14:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b15so12642052edn.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5JDtmIs58TRR3YM1MH2n9ydceKzu8ZMJYE0EAd1fdA=;
        b=mXu+kbIOllUFvjcA3fMxHjtto4SRHNogC5DNMGt298LCEFBZj/4pCFusAyxJJwXDFE
         aknCc84+LN9asN3z8ABlK1Neu52RGYbDbxQ/x7wMjt8hgDbCi8gC3h63ehV3//RUcjEQ
         uXd8VnYduxNmDzxwkqs5cArm2NvcR5NWQ29lBNGTdYvQoscK7mpNXBKQ0tLJIvZZx8EK
         UHAQPh+V4qvmOeqTkgtiZtN6T1lQfPOOloeTXFuwpCBWe7cbtmQqJ4Ou8yw7CeR2UsF3
         4uTo3/Qh87ML1kHT+0XUbhJ3pDx3kqchZRWH52MVse9/W3tOmLVYxXkyLWDShcPe6WYR
         SzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5JDtmIs58TRR3YM1MH2n9ydceKzu8ZMJYE0EAd1fdA=;
        b=FYo0ptW9J9lodM0KqAEDb2aBZE9Y0gPVMsaf27lai586I+Z9LK6ktU4bVpNMy/iPvK
         ZTiCkU2ZynCl5qGZUUjPQhg+t0KZz+XyHFZh6IfI0FBHGIkfDz6zVJZG6ejN1DjxXRUn
         hzlFq/7p6GNP+fytmaBsVSXt6Fjyg2lKqyAzCchcLfu63wTS2Soq7lOr5TOnO5NcEmNs
         dqAvfrd5LuTT0nYhPBq1xdp1nX/t4wTRDw+jfaI+Tnku8ovKjmpf1CTDkIOGoNZtExom
         PUXNii/ao1p/v4xLomRYTVxOmY7OHGLExwK4oOWm5XngwFIzCJc7rf2vECYPOmY4IDVV
         4+cw==
X-Gm-Message-State: AOAM532BFCyrIAmVUfq52JZPzUKzl5o5f8vm6pl5I1ymnFuXCKp0ZrJ+
        FxCh3aS2OnfaORjPM+78yuUuSdkRIIxfraIz7Z5PEQ==
X-Google-Smtp-Source: ABdhPJyMO0ydKmS0siYdaHdVOwsHoBm4w6Sf5vzl64BwKlS1ZlQJjG/60KDSEZUZzhTTg4BvzwEuDDfUH50t+IgZaN8=
X-Received: by 2002:a05:6402:d0a:b0:418:ec3b:2242 with SMTP id
 eb10-20020a0564020d0a00b00418ec3b2242mr83168edb.229.1649106839033; Mon, 04
 Apr 2022 14:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-3-davidgow@google.com>
In-Reply-To: <20220318021314.3225240-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 4 Apr 2022 16:13:47 -0500
Message-ID: <CAGS_qxqtMpjKX+CMF6eBUWfsc-TKR9-Bk+hYM=PHa0_wUtQQuA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kunit: expose ftrace-based API for stubbing out
 functions during tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Thu, Mar 17, 2022 at 9:13 PM David Gow <davidgow@google.com> wrote:
> +
> +/** KUNIT_STUBBABLE - marks a function as stubbable when stubbing support is
> + * enabled.
> + *
> + * Stubbing uses ftrace internally, so we can only stub out functions when they
> + * are not inlined. This macro eavlautes to noinline when stubbing support is

Just noting a couple typos lest they be forgotten:
*evaluates

> + * enabled to thus make it safe.
> + *

<snip>

> + *
> + *     void replacement_func(int n)
> + *     {
> + *             pr_info("replacement_func() called with %d", n);
> + *             return 42;
> + *     }
> + *
> + *     void example_test(struct kunit *test)
> + *     {
> + *             kunit_active_ftrace_stub(test, real_func, replacement_func);

*activate
