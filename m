Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48750D6B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbiDYBwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240229AbiDYBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:51:56 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4733AA5C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:48:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y21so9832415edo.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMq90c3EMg7Fo2DoesguV3visvIyItzGt8+NgqwW1jA=;
        b=N0lnR+lEWZ2JpvJDFYtPnAWSABeP6Qu+dzIw6plNSyp/DjwEjP3Of8osZGCMWR0Qiz
         AO3jGmjwm4/zb81Wz6+VsPB0OJbLdcLE2htsbPovDbzBiMlSwTFviIODAPboLtqR9mGz
         5LEGQJFhe0HioZkY/xSlKmgtx1+QZFIMdfibA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMq90c3EMg7Fo2DoesguV3visvIyItzGt8+NgqwW1jA=;
        b=Vozo+Y3kPGRcuZkwOsrpKFuuK3kV7dC/96CinF6tVJu7Ys3y/qS1xqn8cO/7lRX5S0
         /yUvW5lWyPnGkAG37/F+fDF1/THvcZGSy/2JGxpnyEbQ8/rtDYvJUZs1M2xLhl+cnEEa
         yCBekRhyKnwIf/Qa0UC7iXEJEIr7M5iZgOUWIoP7U7nFwEBufQJyHRjxifdfPG1sQUDQ
         /4lHGynQHbig/Vn0suXfJHXsj/dEqPNI30Uh9szX9ITon9cYUXsFwl5Rj2iYtRNhJyDW
         ruCKGukmaRe9xw0/8tGhp9w7Qk7MaftToJYHReDw1ksacupFlRRdSBFxqUkN8tL/KJzw
         8gCQ==
X-Gm-Message-State: AOAM530bhVabl7p5ZI0pXKRMN5CxZVf9kR3gY/kB4vl9UE6vhwq+0/BM
        twWb+ufi3IwdNuH6JFSYOqbFip381w/XiwtVAQ5x2w==
X-Google-Smtp-Source: ABdhPJwZOqrqMruNYx6fZ+JTZUfCJwGibdcad+m1P70jVJs4UKuBc6rZxzI1DBU1HjF8rnWSebMP2c1jAWoVl21Lovk=
X-Received: by 2002:a05:6402:f1c:b0:41d:8bc7:cd26 with SMTP id
 i28-20020a0564020f1c00b0041d8bc7cd26mr16460882eda.47.1650851330313; Sun, 24
 Apr 2022 18:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220422115959.3313-1-avromanov@sberdevices.ru> <YmMPpaseLn4i6MYk@google.com>
In-Reply-To: <YmMPpaseLn4i6MYk@google.com>
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Mon, 25 Apr 2022 10:48:39 +0900
Message-ID: <CA+_sPao6mN5hwFEanGuAM6YeM+RYiKbortwNech3-cLfMsGuDw@mail.gmail.com>
Subject: Re: [PATCH v1] zram: don't retry compress incompressible page
To:     Minchan Kim <minchan@kernel.org>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>, ngupta@vflare.org,
        linux-block@vger.kernel.org, axboe@chromium.org,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        mnitenko@gmail.com, Dmitry Rokosov <ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 5:27 AM Minchan Kim <minchan@kernel.org> wrote:
[..]
> The 2nd trial allocation under per-cpu pressmption has been used to
> prevent regression of allocation failure. However, it makes trouble
> for maintenance without significant benefit.

Agreed.

> I'd like to remove the double compression logic and make it simple.
> What do you think?

I'm all for it.
