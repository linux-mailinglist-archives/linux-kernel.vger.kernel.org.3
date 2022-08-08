Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE158CBEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiHHQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiHHQNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:13:46 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8C95B6;
        Mon,  8 Aug 2022 09:13:45 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f14so6848603qkm.0;
        Mon, 08 Aug 2022 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RydAc2h1TG1DNQLkGPwhdBQh+OZCJYVbtJqYkQv0eqs=;
        b=lTkujjumqQiRClqVK/7uGOiLol86GKygEm7KB1YnzNtAjcVvg83b5dzIp7yVeX0LD1
         82rfY6UjfYtUeuyeCr4SbTPsrPixb8+3ki0ohTwe3JwooIUb31lZ2PAatCLuaZWZxakJ
         zfUD/2tXgv+WMlBL3tLAJr2aZ2n5K8lHFz8FwdUoTnzOSHwLpLV5oIiNrUj+Z6Z4G/Dj
         2zDjqHI37fsD8r9si8ndG3ZJMblQ7DZmAX/ldd9s5UbLICJFpfN6Oswa2s8wz65f5EY0
         +edsSU/tbEs84GXgFMpsYzcEYK96H59D4l4m574cLmQ/7BmvEIJDQDZTW5NUjIUIHUe0
         uW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RydAc2h1TG1DNQLkGPwhdBQh+OZCJYVbtJqYkQv0eqs=;
        b=AopuPEz9FnLVZUyN3+J8hXL1Kd9j+tTctgh2B9lYjceIzRaEHFg5NOi1WOAfDGZFXZ
         Wy0zg4kK7W8u0ccpFEAayCyrVRV4ylJUp3i5nqo9AiADCeBpjstoZlYGU64UfLoEPV+d
         aviDcw8+PAZkPFRWXSec7jEnG6LRQQIpWLSlJijXdQ0VOBv6xyDHsd8giFliaJOZmV57
         GVK7jutebH7mNx++qxgLZ/xUCkPPwcwhU1TTjinKO7rfYKq08C2LxrSaJHqrW7q0+EVz
         0gMeSfbf35di57AcLuULOzt46EFicTRxe1kO2JxcbMB5IKmy+zX1N1zZ5+1A1P1kWBD1
         jY/Q==
X-Gm-Message-State: ACgBeo0yMjJtMfORNtCN5fco1ZIGEKZvoODDUKvp6GWNRVzsZEtzSar2
        gzhJ2G1MbxhNihsqUBODC2es7AlO91U5vyT0RpY=
X-Google-Smtp-Source: AA6agR7XtKMvsHc14GyMFRB4LH96lb/VxXn/pAY+PTjrqAEQKF7Ovqn1Zp8MAOxfO+fUECjMl1ixyoSN8+RNZ1QRrNs=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr14564064qko.383.1659975224727; Mon, 08
 Aug 2022 09:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220808030420.8633-1-luke@ljones.dev> <20220808030420.8633-6-luke@ljones.dev>
In-Reply-To: <20220808030420.8633-6-luke@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 18:13:08 +0200
Message-ID: <CAHp75VdgGgp2H906sQjhauzEGLp8Mr-2Hj9hKdkF9MPeOOCbLQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] asus-wmi: Convert all attr-show to use sysfs_emit
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 5:08 AM Luke D. Jones <luke@ljones.dev> wrote:
>
> This changes all *_show attributes in asus-wmi.c to use sysfs_emit

We refer to functions as func().

> instead of the older method of writing to the output buffer manually.

...

> -       return sprintf(buf, "%d\n", value < 0 ? -1 : value*100);
> +       return sysfs_emit(buf, "%d\n", value < 0 ? -1 : value*100);

While at it, put spaces around *: 'value * 100'.

-- 
With Best Regards,
Andy Shevchenko
