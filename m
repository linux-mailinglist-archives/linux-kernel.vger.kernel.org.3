Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD36A56C1FC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiGHThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiGHThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:37:50 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5BF6B247;
        Fri,  8 Jul 2022 12:37:50 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id n74so9770917yba.3;
        Fri, 08 Jul 2022 12:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tWvLnk25eVFmRuWXyIo+J+soKWBo63spsgNtK5YUIQ=;
        b=YEIuMvqrCWh9avfsBKVkeH2FW/O+6w97DxyT3T2h6qjSu06Gj/u8bYU6LvnQFZgqEf
         xZ9xPh/nKRlnJdYlep0x0RLmKBmnv0iwV/ifXDoGmdIJOnBVpuzXshRVA5NyrWbqPzuB
         UZ9KY3c92yr4rbBJPNehlD51Je5+hK/OzlN90kyIomwWTbMUPutwFyhhTTMgxlMPs6Se
         5r2Tmm9iSIx3Y8Xk4WyGsHim4gWql8LMMBuPY42XtWxWnN/O5rvLysnC5xoqFTE5RcXU
         ataJgWHidWh1yj/DQpcM0MtAGVdylJ3tFcWvLT6mO1HOBg6IGYbmXiHhYWvDq5mi57w5
         kRZg==
X-Gm-Message-State: AJIora9c06N3Vr9gZBf6S1Qmkyh+eLBevWcgwDhJ+wUZc/ophDFW9a9M
        LksCBJ+UQrJZmiv1Nna5vAUq4CGJ4GZd0IvQ0vcQM7dJza8=
X-Google-Smtp-Source: AGRyM1t+PY0RF7EEcVDON1w058h7z0P79ITz2m4IhhHNHX23kUJDigbFkpHqqwqg2LO3luDC7W1mDTJ4aEZuhu4V14w=
X-Received: by 2002:a05:6902:1108:b0:66e:a9b1:3e48 with SMTP id
 o8-20020a056902110800b0066ea9b13e48mr5593293ybu.153.1657309069484; Fri, 08
 Jul 2022 12:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220608153120.303070-1-ulf.hansson@linaro.org> <YqhuB4ayHZY42SBN@atomide.com>
In-Reply-To: <YqhuB4ayHZY42SBN@atomide.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jul 2022 21:37:38 +0200
Message-ID: <CAJZ5v0iLGY-qoj7+p8mQqgEs6_TZkH6934qq+xs7EJSgUObyQQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Extend support for wakeirq for force_suspend|resume
To:     Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 1:16 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [220608 15:26]:
> > A driver that makes use of pm_runtime_force_suspend|resume() to support
> > system suspend/resume, currently needs to manage the wakeirq support
> > itself. To avoid the boilerplate code in the driver's system suspend/resume
> > callbacks in particular, let's extend pm_runtime_force_suspend|resume() to
> > deal with the wakeirq.
>
> Looks good to me:
>
> Reviewed-by: Tony Lindgren <tony@atomide.com>

Applied (as 5.20 material), but there is still a quite fundamental
problem with pm_runtime_force_suspend|resume() which is using
RPM_GET_CALLBACK() in these functions, because that macro returns a
middle-layer PM-runtime callback, so any bus type or PM domain
implementing meaningful generic power management ends up calling its
own PM-runtime callback from its system-wide PM callback which is
super-confusing at best.

Another problem with them is that they are generally not suitable for
devices that can wake up the system from sleep.
