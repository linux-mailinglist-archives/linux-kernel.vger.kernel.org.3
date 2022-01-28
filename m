Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DB44A029A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242880AbiA1VT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiA1VTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:19:54 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F1C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:19:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ah7so20130122ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lZ8ffNlvdrvmT96h8/DlPx1/riHLrWMluhYkp5LYp8=;
        b=WPJyhTdgPV3Sykuapr6GtS6LgbfAH6PC27FjN8jYgQuo5QUlp5+ug2+Hk+fIo5DI3z
         HCvaadpIgU4KhTvB0y4Hu++cXJ01Y24EI+Ie6Tk0xUInrFr3ceYyGbzHUm6vO/pinP84
         ntLGJcYZ6ZSJ2VGZ6Tzo3Nn/jjHF2Cd1iIQDRT4gmkKcEKNMQzqcfgRxMBWfnphibPVp
         xR7e0PL3WO5a62HRLkPc9nXuAo/JubYtcwQjubNwfLz84R2vjQ8hQhfhbvectYh5ZQmS
         MW40oNJ331TtmVOns2bXlhFJPnaipOppQR9I5MbWuxmqPH+6CrBxgozpjXDC02Wt2JDL
         xq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lZ8ffNlvdrvmT96h8/DlPx1/riHLrWMluhYkp5LYp8=;
        b=C6YUxKUaUI4RYmCvSm2p0gi2dBFa2FKhliMit7FUApeS+WXv/rjSXwNMuyiqst0UY2
         OeEzp+7fvSgyvmbar2m7+uxQlIg2KM5cjolFqMrq9zFlGMUCrJ+MeWQ6MAuOedzoCYYH
         DVjHYwVE4b9/NxHWJ3qFKoqNEFGoIiDEQXeTIlnhvMU2Zg6i9yIQueDd9yByL39fAByZ
         /54zgP1xzKJwWyotQCAXhI5uT817QjaPp8bP8su7Yy4qCBNM0/sGh6Tn84JY46lGTaAv
         dAeETNolEkKeWdqGQ2iHaDzeiXCfT9lC87MAqHBTb82Q5anZ9YKJLwFVu7HcIEabyQuw
         91jQ==
X-Gm-Message-State: AOAM533XSOJWoTt9Jun/wog7HPYiIthycfdfQJtx9xcflaD+OFaXILUi
        2TSg9DcsSA3u6+eHqTnOwcYNfUdyvA54yV6rip2YIg==
X-Google-Smtp-Source: ABdhPJyN4c24gPx4RQUkT1Ozabx/C+LhtygJLfsnEItjLywNDAiXGe/yWuDotYfPg/j+EYuUbmeLcSEcxwToKLQZBKQ=
X-Received: by 2002:a17:906:794f:: with SMTP id l15mr8720055ejo.75.1643404792858;
 Fri, 28 Jan 2022 13:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20211013191320.2490913-1-dlatypov@google.com> <CAFd5g47=aO3e8d4_GGcgY9BK43Z0Oo6SGD-2e5rJDp5r3k4XXQ@mail.gmail.com>
 <CAGS_qxoziNGNVpsUfvUfOReADY0PdriV2gJJ7+LUzzd+7BU-Ow@mail.gmail.com> <0f85025124359304c8a2a97d007b66d5655645c1.camel@codeconstruct.com.au>
In-Reply-To: <0f85025124359304c8a2a97d007b66d5655645c1.camel@codeconstruct.com.au>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 28 Jan 2022 13:19:41 -0800
Message-ID: <CAGS_qxpvX74vnAGhC=TAxFy1NT3mXB0S3AHUZvK2FA59hDijxA@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: flatten kunit_suite*** to kunit_suite** in executor
To:     Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 6:55 PM Jeremy Kerr <jk@codeconstruct.com.au> wrote:
> Resulting in the .kunit_test_suites section just being a set of
> contiguous pointers to struct kunit_suite. We get the number of suites
> from the section size.

<snip>

>
> That was my thinking, anyway. I think it probably makes sense to do that
> cleanup after the section patch, as that means we don't need any
> post-processing on the suites arrays.

To be honest, I'm actually tempted to pay the cost of postprocessing
and proposing a change like this for real.
Going from kunit_suite*** to ** shaves off a lot of code from the unit
test and the filtering code path.

Specifically I'm thinking this can go into the kunit branch,
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
Then when we have the series reworking modules, one of two things can happen.
1. if we get to kunit_suite** with null-terminated arrays, fixing the
executor just means dropping the post-processing step.
2. If we get to kunit_suite* as mentioned above, then there'll be a
bit more work, but not as much.

Alternatively, I can wait and send you an updated version of this
patch to include at the start of your series like
PATCH 1/x: this patch with post-processing, using either * or **
...
PATCH x/x: final rework, and drop the postprocessing

It's just that the prospect of submitting a patch that reduces so much
code makes me eager to try and get it submitted :)
Brendan and David seem ok with paying the bit of runtime overhead for
post-processing, esp. if we time it so this patch lands in the same
Linux release as the module rework.
But I can hold off if it'll make your life more difficult.

>
> Cheers,
>
>
> Jeremy
