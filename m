Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD659CA04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiHVUcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHVUcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:32:16 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4D352827
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:32:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id x25so11693308ljm.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gUUJGDZZ7SmwoHkhrT602wMnsCfmfrGrVbXmH2wIM3g=;
        b=Z+tUKeClXChR4jRlQGg41fHbT2bJsJZqVxlH7TSDRnIKVcsWoXGws6FK/hz5EGuT4S
         yPu/tIYvMiV5u9nagc3sJ7K7VFdaJs3UH//tmuGoe95tcbMp5ov4mybmPAqUAwktzqOI
         V0PJNpbtkpzFVVxtumlOm80eN4+ci0qXNJMp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gUUJGDZZ7SmwoHkhrT602wMnsCfmfrGrVbXmH2wIM3g=;
        b=JG3MSxmQE8mV4pq1uywz0vTqmoe/3uApjXhRQ1Q1o2pZd4oHEYF3IxsRoyf4PxLzwy
         niCmvfzdDynNlTQ/LkLH0/w81Y0lcbl25inFpAGk+LgFDYB3MJWbyH7Qd/p59qA+dKjB
         LRJiKuR3pjSBs2+p1heelJcQiErmjlkoQHKN2jc9CAxgLFfKPHm+Zm6jtFEnGs/mK9V6
         WBrdMm3/Asw1jl2OLkwMZEs3Bsan9r9ZGk+KMGqmjkYcocR2/pikBVZXRZx1dtE76rM+
         FvCJRGcv8fCT1E2y/lG/PMAiXVHzbSytoojwoaB1RjMOJpTFe9pPmHTCbgv0hAejUOeq
         upbg==
X-Gm-Message-State: ACgBeo2jUgeOuIvv1YGlNrOAAv+RkCPLy7q0Z4hxyg2fkZrHAVsEDr6U
        HN4HZDy6dK+WsG4JBuzRA/X/dTlWAs3qJ87vATQ=
X-Google-Smtp-Source: AA6agR4WW4Wl7xr7ee6xHDqmzztHmF6kGA17QLUgSbDC/tUww/81C/mBcMR8Vagt+7Ry3/OwKuWsPQ==
X-Received: by 2002:a05:651c:221e:b0:25f:f069:1c13 with SMTP id y30-20020a05651c221e00b0025ff0691c13mr6516675ljq.390.1661200333323;
        Mon, 22 Aug 2022 13:32:13 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k17-20020a05651239d100b0048d076373d0sm2088004lfu.98.2022.08.22.13.32.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 13:32:12 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id d23so12531815lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:32:12 -0700 (PDT)
X-Received: by 2002:a05:6000:1541:b0:222:cf65:18d7 with SMTP id
 1-20020a056000154100b00222cf6518d7mr11504823wry.659.1661200321380; Mon, 22
 Aug 2022 13:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220819221616.2107893-1-saravanak@google.com> <20220819221616.2107893-4-saravanak@google.com>
In-Reply-To: <20220819221616.2107893-4-saravanak@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Aug 2022 13:31:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wrf2k1gY9+B0WW6D2nhvSHNfWAQrW+y4Td=-u08xe+rQ@mail.gmail.com>
Message-ID: <CAD=FV=Wrf2k1gY9+B0WW6D2nhvSHNfWAQrW+y4Td=-u08xe+rQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Revert "PM: domains: Delete usage of driver_deferred_probe_check_state()"
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Peng Fan <peng.fan@nxp.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, iommu@lists.linux.dev,
        netdev <netdev@vger.kernel.org>
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

Hi,

On Fri, Aug 19, 2022 at 3:16 PM Saravana Kannan <saravanak@google.com> wrote:
>
> This reverts commit 5a46079a96451cfb15e4f5f01f73f7ba24ef851a.
>
> Quite a few issues have been reported [1][2][3][4][5][6] on the original
> commit. While about half of them have been fixed, I'll need to fix the rest
> before driver_deferred_probe_check_state() can be deleted. So, revert the
> deletion for now.
>
> [1] - https://lore.kernel.org/all/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/
> [2] - https://lore.kernel.org/all/CM6REZS9Z8AC.2KCR9N3EFLNQR@otso/
> [3] - https://lore.kernel.org/all/CAD=FV=XYVwaXZxqUKAuM5c7NiVjFz5C6m6gAHSJ7rBXBF94_Tg@mail.gmail.com/
> [4] - https://lore.kernel.org/all/Yvpd2pwUJGp7R+YE@euler/
> [5] - https://lore.kernel.org/lkml/20220601070707.3946847-2-saravanak@google.com/
> [6] - https://lore.kernel.org/all/CA+G9fYt_cc5SiNv1Vbse=HYY_+uc+9OYPZuJ-x59bROSaLN6fw@mail.gmail.com/
>
> Fixes: 5a46079a9645 ("PM: domains: Delete usage of driver_deferred_probe_check_state()")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Reported-by: Colin Foster <colin.foster@in-advantage.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Douglas Anderson <dianders@chromium.org>
