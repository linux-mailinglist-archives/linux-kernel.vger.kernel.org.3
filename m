Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2474EB1FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiC2QoT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Mar 2022 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiC2Qnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386BC260C63
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:42:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEux-0005xu-Ri; Tue, 29 Mar 2022 18:42:03 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEuu-003pAy-2v; Tue, 29 Mar 2022 18:42:02 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEuw-000An1-0m; Tue, 29 Mar 2022 18:42:02 +0200
Message-ID: <b3a71d55124c0610e247bd133bf97bfeac0e9e8d.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-v3: Fix dev_dbg frequency output
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mark Jonas <mark.jonas@de.bosch.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tingquan.ruan@cn.bosch.com
Date:   Tue, 29 Mar 2022 18:42:01 +0200
In-Reply-To: <20220207151411.5009-1-mark.jonas@de.bosch.com>
References: <20220207151411.5009-1-mark.jonas@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2022-02-07 at 16:14 +0100, Mark Jonas wrote:
> From: Leo Ruan <tingquan.ruan@cn.bosch.com>
> 
> This commit corrects the printing of the IPU clock error percentage
> if
> it is between -0.1% to -0.9%. For example, if the pixel clock
> requested
> is 27.2 MHz but only 27.0 MHz can be achieved the deviation is -0.8%.
> But the fixed point math had a flaw and calculated error of 0.2%.
> 
> Before:
>   Clocks: IPU 270000000Hz DI 24716667Hz Needed 27200000Hz
>   IPU clock can give 27000000 with divider 10, error 0.2%
>   Want 27200000Hz IPU 270000000Hz DI 24716667Hz using IPU, 27000000Hz
> 
> After:
>   Clocks: IPU 270000000Hz DI 24716667Hz Needed 27200000Hz
>   IPU clock can give 27000000 with divider 10, error -0.8%
>   Want 27200000Hz IPU 270000000Hz DI 24716667Hz using IPU, 27000000Hz
> 
> Signed-off-by: Leo Ruan <tingquan.ruan@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  drivers/gpu/ipu-v3/ipu-di.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-
> di.c
> index b4a31d506fcc..74eca68891ad 100644
> --- a/drivers/gpu/ipu-v3/ipu-di.c
> +++ b/drivers/gpu/ipu-v3/ipu-di.c
> @@ -451,8 +451,9 @@ static void ipu_di_config_clock(struct ipu_di
> *di,
>  
>                 error = rate / (sig->mode.pixelclock / 1000);
>  
> -               dev_dbg(di->ipu->dev, "  IPU clock can give %lu with
> divider %u, error %d.%u%%\n",
> -                       rate, div, (signed)(error - 1000) / 10, error
> % 10);
> +               dev_dbg(di->ipu->dev, "  IPU clock can give %lu with
> divider %u, error %c%d.%d%%\n",
> +                       rate, div, error < 1000 ? '-' : '+',
> +                       abs(error - 1000) / 10, abs(error - 1000) %
> 10);
>  
>                 /* Allow a 1% error */
>                 if (error < 1010 && error >= 990) {

Thank you, applied to imx-drm/fixes.

regards
Philipp
