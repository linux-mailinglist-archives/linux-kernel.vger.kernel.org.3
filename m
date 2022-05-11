Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD2523F39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347997AbiEKVHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347993AbiEKVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:07:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D479802
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:07:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba17so4003506edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kVKJUKY0e+cQ43QKG8tA8Ts0yUQGOsHr9Kzh22Y3Mo=;
        b=AOxXWxawM52NCXw7DMV9Y8SiCoLTKDC1ubtjLFvEh6wOf8r2IJiWTavY4UbIv8V8BS
         c4t28E5ZtmgXYtHNVy2N2vnH5sC+e3FE1jc3K4TIJHZmtBjT9TnVavqBI1K5sIQYiP47
         EJ2XRCH9/F71QUEkwF5tecVg9zjB0xCr06rChN2QuAdf8tYc37uuvjA+8Js+yOsbHRHI
         1iaR6hC6dY1EmE3gnifZMw+wO3iX6Thu2ivke5cyPLbZc9SAw0aE3NPr1FlOEWQ5jayx
         uXM+rRCU9CPvbZTQSYjPfOQD5F5cwc3oBdLNDBgUMIqgboe5EdKB0qRWqr3wM9I/Gyfr
         oY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kVKJUKY0e+cQ43QKG8tA8Ts0yUQGOsHr9Kzh22Y3Mo=;
        b=IthE4VXVioXcCleFcBJUc6witmL1ks1x0bcS8CnKKJ2dMkg9G87VKolAthwuMlExg9
         xZoyjvdibey1ko+r1dDbslZSN0larhgJlDFc2dQt3WoKk/X8FBTiNhUGrmseY3Cvadw+
         xNXGf1Z0WarM9HTQlrLc0oTi/7uP3O95eH924JjHfDMhiKgVD8UCBxcgYhWewL5EyBov
         9iXkCwlmZhH9UEqVS6rsAphShvUQNIsmXgTy84QbdGRd33FRYE11dRWft3+lU10J95TQ
         dhSdIJ0SqC5GThKyycmCOCAi4Z0PwuiAO5mDSqoU+TMSmvZLMITqT27fwvH9PQzNTNGs
         HgwQ==
X-Gm-Message-State: AOAM532adZktYF5TJeW20CGYPGxjZpLCcVftABNoSyms0jE8E/ImQ6Y4
        HmEVCmZgFFX+I/XbO+FzGHdQaKV6mdH4fBdDcWqYYQ==
X-Google-Smtp-Source: ABdhPJw5z/zylvurJ69+rKnIACKIjwvRuCqXEy0EiR9R3MwUQuLMSYjLa/gITaGkzrvjqEeJUn7kfJZGLcaXGph2ZiU=
X-Received: by 2002:aa7:c54d:0:b0:425:d8c9:efc6 with SMTP id
 s13-20020aa7c54d000000b00425d8c9efc6mr31270761edr.48.1652303249575; Wed, 11
 May 2022 14:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220405190619.540177-1-dlatypov@google.com> <06087446-c053-7099-b8f1-40a467781186@redhat.com>
 <CAGS_qxqFqM=4w1xEB_bmznMAh3r19Ou9TjYR8gGetG1ypo7W5A@mail.gmail.com>
In-Reply-To: <CAGS_qxqFqM=4w1xEB_bmznMAh3r19Ou9TjYR8gGetG1ypo7W5A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 17:07:17 -0400
Message-ID: <CAFd5g46zWQRD7YBwR0odeuSYm3zVvHTfSSsFy0Bv5pPevGsR6Q@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
To:     Nico Pache <npache@redhat.com>
Cc:     Daniel Latypov <dlatypov@google.com>, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Mon, Apr 18, 2022 at 2:54 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Apr 18, 2022 at 1:43 PM Nico Pache <npache@redhat.com> wrote:
> >
>
> <snip>
>
> > I have tried posting something similar in the past!
> > https://lore.kernel.org/lkml/f427ed5cbc08da83086c504fbb3ad1bab50340cd.1618388989.git.npache@redhat.com/

Ooops, sorry, we should probably go back and pull those in as well.

Thanks for your fixes, and sorry for not picking them up.

> Aha, so that's why I vaguely thought someone had already done this.
>
> >
> > Reviewed-by: Nico Pache <npache@redhat.com>
> > Acked-by: Nico Pache <npache@redhat.com>
>
> Thanks!
