Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F5580AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 07:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiGZFSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 01:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiGZFSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 01:18:46 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620DC222B4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:18:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 6so23603601ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 22:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6q7692tRTcvxlctWBLa2EQMxtAdhfY0jiQAAp5IstQM=;
        b=ToskS5StynEYtsUReY+Ec7C5qMGMci+PufEwwOQUYBaBTeSSo5BpfHFPOR7FrBaV37
         2I1Yv1AqhVvaxmYQlRrR4193CzR9WIpWgjaYIgpRNPIJSxRnZG83DnxTpudqMYfiahEv
         OE1iNtgwaCkoVhva6n0N/IMlmxGvmY93dubgQb0yoytlniDBOsjr/ZiUjq04v4UdDAhv
         d63k78D52fwFxRJp9JHWhdNRk5rC28Q1c1mXtmPhJd0Zni2NIlbJ9W72dpBBBR7nwnxf
         V/kohW37YcYPCBvE9GniWFIs58PO9sZmwaS9/PuPCFugWUZSwdlvtXWsU6Bg8l9EYyqy
         GQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6q7692tRTcvxlctWBLa2EQMxtAdhfY0jiQAAp5IstQM=;
        b=MoaYHGhxV/pWZ8J+T5LFHwST0ofG5sYgkqkPoyjfr5QbfH97WLk0fDVCiey//1i/cs
         vyfL7C/0BJ9Ofk6Idd5c81O0MwiIqp5MAPYHKk8+VyY6vSCgkp/gzfgRoWSfQ2QkDm5F
         GiUkg+oh6zi17+roGpJiqeLAmJChlIQ6cd7GDyTQ+U7tN4tLV8zG+a5oD8a5brNJRL4t
         7oSS53GUCMA5YKTxi3dR4wXUFFsSqNpsr7eikqg9IG8bANyZJns8gSb2qHcGQIyu5IXK
         QuOlTFh3ohG2lkRkZrbJ0md0pnGEjdjF3J30oFU3m5+3D41gU3S/PqEblV2q5Na3UmT4
         A3aQ==
X-Gm-Message-State: AJIora/0LMzm+Pt1KNb3W9O7A9PHjYRyj+fuuRi9dI+SVu3oLgAVm1a7
        /w3RyEvy99EDrPDqz0IwEmywLzr39ODOC0QH68weIYtpKCM=
X-Google-Smtp-Source: AGRyM1v30EAdPG+A0F3vatNSXI/6ddQM0dTUWWbnA0DK4SjIqiYF4u78c4GkZh+SSLynnq0MX9B1srKy6J6Q6jysSZU=
X-Received: by 2002:a05:6902:114d:b0:66d:9fa6:4bd4 with SMTP id
 p13-20020a056902114d00b0066d9fa64bd4mr11317252ybu.362.1658812724555; Mon, 25
 Jul 2022 22:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220705022032.281665-1-windhl@126.com> <CAFBinCC1x-655H2LbbUhiVGmgXL+tdSRnCPV0a-NJcZKOFJZuw@mail.gmail.com>
 <40b3ed24.b4d.1823814761a.Coremail.windhl@126.com>
In-Reply-To: <40b3ed24.b4d.1823814761a.Coremail.windhl@126.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 26 Jul 2022 07:18:33 +0200
Message-ID: <CAFBinCCzOt1s5ExH5H-BzmJbFLAzMZgkTvBt+vCuRBbL_1QQOg@mail.gmail.com>
Subject: Re: Re: [PATCH] soc: amlogic: meson-pwrc: Hold reference returned by of_get_parent()
To:     Liang He <windhl@126.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, inux-amlogic@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

On Tue, Jul 26, 2022 at 3:18 AM Liang He <windhl@126.com> wrote:
[...]
> I notice the declarations keep the reverse Christmas tree order,
> should I keep that order as the  'parent_np' will become longer than 'np'.
Good catch!
Personally I would move parent_np up (above pwrc) to keep the reverse
Christmas tree ordering, even for new variables.


Best regards,
Martin
