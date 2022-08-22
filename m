Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE03D59CBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiHVW6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiHVW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:58:16 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532FDB4A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:58:14 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so8714570oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=ZQcp0BRRM98lOS/g0KHNAVFcxGrlDNSNcE9n5lyzj74=;
        b=AY3JnAa0u0PCO/OLlstQQme7k5X4CjbQb4LyJxjNuFarcLkWEhPvAXKaWwxdF/n/OH
         iOWPoBasc1WzdUznFH6n2/15y79SvpqRUs0C8WiWV0Y2mCrAlDiW/QDBO8aF/9+2SlKy
         2vJbVtOSadV9XPeuJo7UM/nLUp5U3v1XsXecE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=ZQcp0BRRM98lOS/g0KHNAVFcxGrlDNSNcE9n5lyzj74=;
        b=i+/VVtSy5y61c0qYtzAp+Y9k+ynVC/zf7MW+yqwMV4/MhSwIpzwtYCxG//5aFYCAyz
         yHA27JzI2WVwE8FN7U6fjs2Sbc38xusuojwB6I50dysm4m+fsTjTrIkkjW4v2lEzv0yJ
         djYZ+qoRK3FjkfGxUE1Yi64GoTdzqafKje2YwfDUuzApYrWtEdqEZZDaychs5QlLzojZ
         pb3cws95Tg9Zg25K8ucyX9HQJopj1cpsbfpuBt40r6SxGjAXNbJ+weVAv1l2ZUocSYLq
         CdMsK5GrpvYY3HutREJrThP8rLWMYNTui43Kfarwk8A3+REIht9/6LaVpGE8HORrIgEw
         s37A==
X-Gm-Message-State: ACgBeo0PV9vliUnKtvuDUYNTAYh1phIXvi+im5sNUhneqCax2YA+pUw2
        Ciev3XuBadXuz6MHOpzOspEcdwuc6mpgyKJzf6sfsg==
X-Google-Smtp-Source: AA6agR7P8++dkGVe69xdBJY4hZiKYOYJmykx57SIKThzQUVxO3vkQz9gif5F2unmCzp5cRjkm17S5wP/RnwarP3zDwY=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr8354707otk.73.1661209093673; Mon, 22
 Aug 2022 15:58:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Aug 2022 17:58:13 -0500
MIME-Version: 1.0
In-Reply-To: <20220822144026.v3.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
References: <20220822144026.v3.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 22 Aug 2022 17:58:13 -0500
Message-ID: <CAE-0n53udqQiEjBnB9oO+fuBUbWEvE1NZXBCsBW7qPCTYzK3_A@mail.gmail.com>
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Expose suspend_timeout_ms in debugfs
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2022-08-22 14:40:40)
> In modern Chromebooks, the embedded controller has a mechanism where
> it will watch a hardware-controlled line that toggles in suspend, and
> wake the system up if an expected sleep transition didn't occur. This
> can be very useful for detecting power management issues where the
> system appears to suspend, but doesn't actually reach its lowest
> expected power states.
>
> Sometimes it's useful in debug and test scenarios to be able to control
> the duration of that timeout, or even disable the EC timeout mechanism
> altogether. Add a debugfs control to set the timeout to values other
> than the EC-defined default, for more convenient debug and
> development iteration.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Prashant Malani <pmalani@chromium.org>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

One nit below

> diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
> index 1fe0add99a2a99..66fe915acd739b 100644
> --- a/Documentation/ABI/testing/debugfs-cros-ec
> +++ b/Documentation/ABI/testing/debugfs-cros-ec
> @@ -54,3 +54,25 @@ Description:
>                 this feature.
>
>                 Output will be in the format: "0x%08x\n".
> +
> +What:          /sys/kernel/debug/<cros-ec-device>/suspend_timeout_ms
> +Date:          August 2022
> +KernelVersion: 6.1
> +Description:
> +               Some ECs have a feature where they will track transitions to the

s/to the/of/

> +               a hardware-controlled sleep line, such as Intel's SLP_S0 line,
> +               in order to detect cases where a system failed to go into deep
