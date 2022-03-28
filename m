Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720624E9D08
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbiC1RIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiC1RIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:08:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439562BCC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:06:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id e16so25847687lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOAa7WpMNgbqgji3fRQGom5Ba+QYEkdDzROArpIBjvc=;
        b=ENw5v98dathuIv0v3Q532b+NqOLHiJ3fyUjwxxYyseIx+Nx5kyLtsaLjIcefkdeNL9
         IS6mlD38Idl9cNFzUflS7/2bSe2H7jFluyt13j3tgOhoffcXGXLpz23Ge1bsEIbDnUbs
         uddK+qnZk5D44idwiIMTVrkTNlCVx83nc1JIxtSICXQJtfnKuLN4r5aFF3zd4PP2jBR+
         W5DUogc99JJoE1vCVXg6EKYnkXel5NSQI4bV+tkaNEPPGtApavU02ID1WMvX5Qufg8y0
         PzzkYtZ72vpzJUSjqofTtQk6sJM5nkuZBHNUjZ26vrcxREbqZBunnlsTnWE/4lXHcsYR
         zFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOAa7WpMNgbqgji3fRQGom5Ba+QYEkdDzROArpIBjvc=;
        b=ZhoWEQEpu6Tc071Vhz7+kksuHGaCUxdyIiJBwP0Jg+9KXw0k/z3KUE+lJAmwAIXWJO
         8t4wPDadzoo6Mu/LhsGHIfxhmKKktzYRyWgy3R5nTO8VpRupZXJlWjrzhyrb8Xq0H9QF
         +P6SybiYB2xpcqwHcdrADdQLe7eu+lrx+iS9IBuwPgNx3h/DrHx+pGKE8AjK7h1wCIA+
         NqCptXiIkNT00FrJKLDjtXVBbPckyb5/y1U1uDUnBe61pLg2mXFhRY85okTW4Iw41alA
         H1FQ30+5xNSk8+oE8vPh1+agLfb2Lyk54uolQDgc9YbRcUiED7j32kYG9rPzkYsTZlh1
         CfVg==
X-Gm-Message-State: AOAM532DOLyUhOOH2RTKe79sTZw40nwuVHnuYjt6iMBolMyQKTDFRLDr
        9uC6TCM6t/CiG5lX2VaRgMjt4vFZN0Fa+cVa1c4V0dmQscdrhA==
X-Google-Smtp-Source: ABdhPJxr5kjWcCV8tG3lkJMUxSBK+Y8LJ8mhkQigVG3HvLYkVCUYHLrC4mkFAkK1Pl+r45CjbUgT+lgIchcrUtFocJo=
X-Received: by 2002:a17:907:d06:b0:6e0:e2f5:4f55 with SMTP id
 gn6-20020a1709070d0600b006e0e2f54f55mr13018196ejc.618.1648486724923; Mon, 28
 Mar 2022 09:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220326002013.483394-1-dlatypov@google.com> <20220326002013.483394-2-dlatypov@google.com>
In-Reply-To: <20220326002013.483394-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 12:58:33 -0400
Message-ID: <CAFd5g47yH1bOCHS4JDSw0=bzpqj6bECy564=gUKTBzwjXjk-Wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: split resource API impl from test.c into
 new resource.c
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Mar 25, 2022 at 8:20 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> We've split out the declarations from include/kunit/test.h into
> resource.h.
> This patch splits out the definitions as well for consistency.
>
> A side effect of this is git blame won't properly track history by
> default, users need to run
> $ git blame -L ,1 -C13 lib/kunit/resource.c
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
