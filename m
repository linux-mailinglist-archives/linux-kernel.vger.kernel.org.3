Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3555917E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiHMAwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiHMAwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:52:33 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1476B60EE
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:52:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-32a17d3bba2so24475827b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WbYPnHR9HxWi35dBvBrbYSupoHoVU6IHkJrer8aofZg=;
        b=G36nprOTrr0PmY/r2BwuoDf4i3WasiJ4cZpmd9acCRnpeqyMKO2a6Fbu6B7C9Lp8BN
         JqK+IWDfeW/cPhqLQW8MW2s+9+sK8RYowQwHglCVnXxkWP6Yla7w9T9f8gNmAMhtpArf
         D13lz7D0k0zBYfPP3xccYAUJkJlvOKXVKawXgLHZ/uGJbp04DKf629ue/aX3iZCcMKMU
         0gT1wKrlqfHWG0QUsgPuhcrD8YYbvIsZiJn8SeV0GcSvHaj6kiMpmr0q1C4THEnkSE3N
         75aTb9x1yo2ooD5T2ctqo531ZpQqCzAFDLlXIJCZb1riOg3Flv8EKmVV9ltmbWPPFyve
         ppwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WbYPnHR9HxWi35dBvBrbYSupoHoVU6IHkJrer8aofZg=;
        b=3fu5PPtomv7/BgZNZ+PpwYuQIDCtg7v1x0fau8zfJf1vz9BRv/mKtV+XGfohacp8lV
         JNHn3vQ3W/rUcHnE9eW+4eSd9v/O8GLmXxas/j8NosEDfZtP0b9eRbDyGWEhJPyo04t0
         FOXIZM1xMM9FFtVORLSNFzHzhvnD1BNE3DgfJeFV20y2Vdmxq3tP8Cw89Pc4vRJS5gtG
         Jsl+C+KdIKFfBRH8TICGPkBZCTMhn6HDF6em9qABLbUegrA715ZpjgH2S9cv/7/cbE8S
         n+zYtRSF2PalbNLZmBhxw4hI17p3KimreMgy41MwcUMt4zrt3z1FAKLiQU/eZ3l2Ax3P
         irhA==
X-Gm-Message-State: ACgBeo3sd+YYmuMnnslnxPOZ0UjnMv9qXePwSXFcq3aCWeNK6BsamSMt
        S+L1o6dk4NtS3Bhfx3967JMIyqvPpCxG2jBq4RYfEQ==
X-Google-Smtp-Source: AA6agR6k6YUMLYwWVgKkXkzA9eQcDh7PvZyVqo7+64YRZILB50qMGsLs3wg/aVWSq5qiOyNQ+Uwd8c5jcYUTJUBcQ7k=
X-Received: by 2002:a81:998c:0:b0:326:5dab:df3f with SMTP id
 q134-20020a81998c000000b003265dabdf3fmr6066292ywg.126.1660351951117; Fri, 12
 Aug 2022 17:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220810060040.321697-1-saravanak@google.com> <YvYiF36M09dX9ASm@atomide.com>
In-Reply-To: <YvYiF36M09dX9ASm@atomide.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 12 Aug 2022 17:51:55 -0700
Message-ID: <CAGETcx-t0O0B+5i0FWwm5w2=ccOD5zVAaUvgQoP8PT9SOT_btw@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] fw_devlink improvements
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Fri, Aug 12, 2022 at 2:49 AM Tony Lindgren <tony@atomide.com> wrote:
>
> * Saravana Kannan <saravanak@google.com> [220810 05:54]:
> > Tony,
> >
> > This should handle the odd case of the child being the supplier of the
> > parent. Can you please give this a shot? I want to make sure the cycle
> > detection code handles this properly and treats it like it's NOT a cycle.
>
> Yup, this series works for me, so feel free to add:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

Thanks for testing!

Btw, out of curiosity, how many different boards did you test this on?
IIRC you had an issue only in one board, right? Not to say I didn't
break anything else, I'm just trying to see how much confidence we
have on this series so far. I'm hoping the rest of the folks I listed
in the email will get around to testing this series.

-Saravana

> I have some concerns though on how do we get a working -rc1 with the
> earlier series applied? See the comments in the last patch of this
> series.

I tried to reply, but not sure if it helps. We'll continue the discussion there.

-Saravana
