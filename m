Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74B8567068
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiGEOJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiGEOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:33 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2532A1F61D;
        Tue,  5 Jul 2022 07:00:02 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id e80so14725875ybb.4;
        Tue, 05 Jul 2022 07:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqO40ahfFXskUpsKZnggDHc6rPHVEzHIC9njxd0juUo=;
        b=MZh5C7h8F6atBwj0xy9VV1e0OsUVUDv5CC5MYRUnfr8fj1Dc+CUruf0Pu9juFcGH5G
         GKF0YQln5RrNXZjg7CH8hesW0namVwTioNvXK1kc+cJ6IvS2HanXKURuhqR5i7SqmaMN
         t/QDKlVq+Ua5h6zkcJ50d9gD2uUpyY4KvPKJlFmzaYe8FrJRqNz+M+kb14DFIok4e7S/
         xv+kHRUzbifXa53g8SAtvaMzXdpTuAF4xjL5dS3fKJuDGNoGyz07ZWBNE4SNlmvj5VsQ
         Mfgs0ptxLO3zb/dq/CxooFc9HGxU7P3pA1CpuuS2DXCcuT+b64RBCDEWfSw7jSMHZQpq
         qo/w==
X-Gm-Message-State: AJIora/FuWkr76mD+VE/6kEutDnR0ewNCLeKM/58sCslFRl5oX8Ff7Tj
        lJ7SwSmEU5WzaYjKyD5BsVZjSxDOkKbzCyxGNik=
X-Google-Smtp-Source: AGRyM1vMrTF5bN5/JUMq7Ku69BUDRTbiLEbq/s2Tg7IyUD4iXX4jNpwS2m/YEMccE1cg18W5/Qy1Xzi//t0XCDYFo/4=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr39562352ybm.153.1657029601366; Tue, 05
 Jul 2022 07:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-10-daniel.lezcano@linexp.org> <3ec41dbb1e0586841bd7f0ca9ef34d6e4fbbca58.camel@intel.com>
In-Reply-To: <3ec41dbb1e0586841bd7f0ca9ef34d6e4fbbca58.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 15:59:48 +0200
Message-ID: <CAJZ5v0h1u9gkimRxQnjvrtLtaTYhhcRnD2WO+azKLhDfB865hw@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] thermal/core: Register with the trip points
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>
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

On Tue, Jul 5, 2022 at 4:03 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Sun, 2022-07-03 at 20:30 +0200, Daniel Lezcano wrote:
> > As we added the thermal trip points structure in the thermal zone,
> > let's extend the thermal zone register function to have the thermal
> > trip structures as a parameter and store it in the 'trips' field of
> > the thermal zone structure.
>
> Just FYI.
>
> I proposed a small topic for this year' LPC about the
> thermal_zone_device_register() parameters.
> We have more and more parameters introduced, IMO, it's better to use a
> unified structure for registration phase configurations, or reuse
> struct thermal_zone_params.
> In this way, when a new parameter is needed, we only need to introduce
> a new field in the structure, rather than update every caller of this
> API, or introduce new wrapper functions like we did in this patch.

Sounds reasonable to me.
