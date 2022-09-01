Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB85A99EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiIAOR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiIAORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:17:08 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6C13FA3E;
        Thu,  1 Sep 2022 07:16:53 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n4so10934968qvt.7;
        Thu, 01 Sep 2022 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V+Wdqn+r+v5TFLSkRMrWFuMqlFa2XyPgAU9tNu/FTow=;
        b=cQ2P1h28DCXYhrmZVF2N994ohjHyhw4Mm66xoT9X/CNB3qPV0CzlhdKS9ot2nod9MW
         h4as+HQ2i3WQxyxp52q9yWeoKaF9vTHAjUZXRzHUOCKcYwHUHS8lfuXsFGjEbnOJE5j3
         OzPca7lwqBTzSDLOfp2BMXu8mlpQwL4XLb2VpxYsy9y1NfK3kdEcJu50kk63Ej+6482c
         PWCrAKhL4jBwVfpnHw8MJNsznD+y8XxmJbbbbjD3/PyQwLNiUwEel/No7HCcQ6ESswoU
         gP8XiNCaqKj7j9qPQUnPtEK5VbrigPbprlSDNWRQ80Ml1gRvCCJbz307q5PRyZiMpBic
         CIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V+Wdqn+r+v5TFLSkRMrWFuMqlFa2XyPgAU9tNu/FTow=;
        b=EeZ7fblAGjuem5e7KnhC4DTAfMcNqTq/NpQZaIopVYRF1bgmuFnWhk0SKg8G2smrde
         EJS1WZKgApw2/wvf0rS0osa4pmKv/MyXx+SyIvGXb61P1kLiWQZQMdU3OhCst/aJh30e
         Mh0AI7dUiLy96babKmGs++LJvuTbrTK+9uTyMdvuaG/DLtxmLfPt2jOXcwqCAg4epChS
         V23kJmIypSuH82x4B3DNCd46sinx9HXhwNraiTbERSp237pdY2pBz4kL0kc7m5U8KbBs
         AOJPqc0hPhxidMjNnohVuFSFClTaXAe0l7NGMYhKvEHa5CyMYa2fhTAvnLHVhFpDzsrF
         3G/A==
X-Gm-Message-State: ACgBeo3Ii3A31J8QkY52xFxdPpwDEHZotjGfXeXJZBENwThcQ8o+FGNw
        VXYZZ1I0Q60KMxvB/xU7LZkK3cxPzeapqHDmNpBV7H103VI=
X-Google-Smtp-Source: AA6agR45hLKVRW+mWjgq3KpM3B6UGl+clQ2OhvXALe7vfgCcNnsrpCk0D7mKHUR2OY9lI6gssFbXOtLx1xFJcRibXSo=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr15340440qvb.82.1662041812037; Thu, 01
 Sep 2022 07:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220830193938.56826-1-andriy.shevchenko@linux.intel.com> <CACRpkdZa5bP_aJQ61B_SUBc-kAOfWTvp6h-Ek5_=9=3mhXPHLw@mail.gmail.com>
In-Reply-To: <CACRpkdZa5bP_aJQ61B_SUBc-kAOfWTvp6h-Ek5_=9=3mhXPHLw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 17:16:16 +0300
Message-ID: <CAHp75VeYj+EvNysAUWjskKbovm4z1G5zjpymE-M+Oyg90C1itw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: pistachio: Switch to use fwnode instead
 of of_node
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Thu, Sep 1, 2022 at 5:14 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Aug 30, 2022 at 9:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > GPIO library now accepts fwnode as a firmware node, so
> > switch the driver to use it.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Patch looks all right but I don't understand the compile error from
> the kernelbot... device_get_named_child_node() isn't available
> on arc? No idea what's wrong here :(

No, it's simple as I used dev when there is no such variable defined
and for some reason I missed a compilation on my side. In any case
there is a v2 of it which compiles at least on x86.

-- 
With Best Regards,
Andy Shevchenko
