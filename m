Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD858717C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiHATeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiHATd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:33:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040A2AC79
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:33:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pm17so6011621pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIQ7+JXrdrYLGN1q1Me7ktsamcvlQkAKgR1msuyzHp8=;
        b=Zr9xGgvQLIKPtoSceEYLxu5ZliuYXjZj3RFMXkvfZ/B0BFaOM5vQYIEvB41bbnX+cr
         o7YN3FzdeFZalSlV/4DHmba+2BK2VARCE5gqHEdMXEnutMdi0nnHTjUvQ79plndttEhB
         4qer4oLGY8DCUhbK5ryGtSG5BGKGoa9HFgTpI8ApvWw/01XqkV+yeemz1E5uQGXjlQUA
         SMzOq+sJVSuIE2dt4TKyO81oDrl2UD8FyfF1qACaQvk/Io2s1+3aHwJK6Etam4MPs6c0
         Pl42u7aXWgeqWiCWRQU+8+kDmrGXKM+CT1cEI6Oau2DXJsnWyrifHqZrj5E/IGjG1Wc0
         RABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIQ7+JXrdrYLGN1q1Me7ktsamcvlQkAKgR1msuyzHp8=;
        b=BW/fsZxiOSFpWtfP4/HIPKDEzcj0abh1B4W/8r35VjMDSchIAy6rzRaDmXpmJqaUd6
         tej252/ZBOf1XQ6ZTELLZc+GblzARG6dwHkbtZ+yatn/2s9D8Gp6Ela+x2+pmnAsrn16
         jehinLR1bbWaeazMs4+TPYSGVPeQVNNZ4mcmp/0H6Km1FNksyx6XSRjFfapY5s+/Pmef
         w5OL2deKE7yb5F4QBox2EKtw9wwkyAxniNP8rtFodp+I6J93s32yF5Ejgl2XHJdILIea
         d3Hrq+DQ6BTvm6ZJ3CdmfCaG86+jb+c7L7ZP2i1pJfShSGoJtcVb5FYDaRCP5csI9HTJ
         ECuQ==
X-Gm-Message-State: ACgBeo2N6gueO1DBxJh3j3vnVCb+SbMNwjyMfRmsTzJiJQ+coz1T3RmD
        w4W65+BiAC7zG6VFEwkSXsy5BK9P0kk42ahv5R8=
X-Google-Smtp-Source: AA6agR4HQvry5Ajx3Fy5wnVubksCNbRGhac65TsiimXdjc0WsMnwPaEhe2wa5OYqmd3KK9fti3CX7kBQ0qQcSjmvQzM=
X-Received: by 2002:a17:902:bc49:b0:16d:ac99:f96f with SMTP id
 t9-20020a170902bc4900b0016dac99f96fmr18038776plz.130.1659382436065; Mon, 01
 Aug 2022 12:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
In-Reply-To: <CAHCN7xJ=N1vWVTBjArskJ59fyaLzmAGWfc0E=_iGizrDNR_Udw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 1 Aug 2022 16:33:43 -0300
Message-ID: <CAOMZO5BAheG4r1Umnd7bLhOqezsxJgE0x1c-858EcabbpPm6Pg@mail.gmail.com>
Subject: Re: imx8mm lcdif->dsi->adv7535 no video, no errors
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
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

Hi Adam,

On Sat, Jul 30, 2022 at 12:16 PM Adam Ford <aford173@gmail.com> wrote:
>
> Hey all,
>
> I am trying to test Jagan's patch series [1] to add support for the
> samsung dsim bridge which is used on the imx8mm to output DSI video.
> The DSIM gets the video from the mxsfb, and in my case, the DSI is
> sent to the adv7535 for connecting to HDMI.

I had to add some extra patches on top of Jagan's imx8mm-dsi-v3 to get
HDMI output functional on a imx8mm-evk via ADV7535:

https://github.com/fabioestevam/kernel/commits/imx8mm-dsi-v3

Does it work on your board?
