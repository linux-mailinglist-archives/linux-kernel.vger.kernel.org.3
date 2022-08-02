Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706F58754E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiHBBzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiHBByw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:54:52 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9102D1CFEE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:53:21 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so11154327pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 18:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E+nFDuqb/3L3s8wauxeMyHMnw6kIA98zqSTPhFde1Xo=;
        b=OXeOBqhN27K1q55bj/9ziz5oDI7brJcrrdW72DC6DKhgZx2Lw8980pqF2JcxtCLRMc
         l7tDfDT24K1abcYSdhkOD8lGRySQl/oRLGpHCsIREC6yPDU4LQYWqfUIIqMiKJNuwMJ1
         lFAq+eMrLrwfXX5Ut9pZOPI1LrPTuPMwn1E7sbGGAt6Ojt0HrBqHtNMmcJDGkl//Juqy
         ahEfd0x1Im4Fok3MYOpVuQghrLxkbp4U3yh7sT8kiWFJ5QPlpobnR9tmuTOn2huWwfHj
         8TI8X4knOz/1/5ySLu1wgifT4eotif+eOVsj+QvqbCmGB+2/75qb14O8laCdswXYcAWE
         7DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E+nFDuqb/3L3s8wauxeMyHMnw6kIA98zqSTPhFde1Xo=;
        b=ajFKtJK7eqX/uSNguEuKDq0MkifoPX3wLk5t6AX+a5m+CQCJSY2V0VJEg3ro3KHTvK
         VcHBwTdLaxr1753ryK6+Ax0zu84gX1oVe4cJ2KCuzymjvsCLSay3I1NWv/6cLBNrzduS
         ohBSlYNeDvHAmo9PvYdn3tLKpf7WSLPYagu/1l1UB2NfUywc9ueTB0sBRNA3oaNTodtY
         h23EdgxnEVf8f/v9CelAyyoUER0dpLhEtPQCSlHhWn2KAYCId9jaROR3/x0g8J2DxqED
         J1/nzxwFe9qg91ry8T9Bte50fNPWVWmXuwq/ZNa8biINq/LdIPsm1NbhNZtrYUSqT+3R
         y+zw==
X-Gm-Message-State: AJIora8rtHUnIxEtGrSYhZb3dgqruL3ODncGc3k4GTb86Qv8eciYpE5U
        XWdkXmm07S8XNfGx9wcyz1iZnUTGQ+0tWhBaabA=
X-Google-Smtp-Source: AGRyM1uWk4c/nkRR5Ax2LSzSL8qPEKj6xGzBHmLhIRTO9RMYha61jOqtjFM1V3CcJ1fJOR7M3O0hMclVZX1L6/xS9Q8=
X-Received: by 2002:a63:cc0b:0:b0:41b:51ae:541f with SMTP id
 x11-20020a63cc0b000000b0041b51ae541fmr15883103pgf.50.1659405200775; Mon, 01
 Aug 2022 18:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
 <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
 <20220801225538.qtdb5zd66g6ipewz@pengutronix.de> <CAOMZO5DUTxQKbpTVOgaVC0V7hPqJG77sgmkW8p=aNpG8th-aLw@mail.gmail.com>
 <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com>
In-Reply-To: <CAHCN7xL2w7a=SeXbwcNNxqb3kpRV9Bs0AbK0Nmjbj+dm0NDaVA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 1 Aug 2022 22:53:07 -0300
Message-ID: <CAOMZO5BQWnUj4Ouq3=vhqq55zN8otO_9vPX8ht+muFM_5pg9Fg@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Adam Ford <aford173@gmail.com>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <robert.foss@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Jagan Teki <jagan@amarulasolutions.com>, robert.chiras@nxp.com,
        laurentiu.palcu@nxp.com
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

On Mon, Aug 1, 2022 at 10:39 PM Adam Ford <aford173@gmail.com> wrote:

> I managed to get my HDMI output working. I had the lanes set to 2
> instead of 4.  Once I switched to 4-lanes, the monitor came up in
> 1080p.  I haven't yet been able to get other modes to work.

Ok, good. On another thread, you mentioned that you were also trying
to get LVDS to work via SN65DSI83.

Does LVDS work for you on this branch?
