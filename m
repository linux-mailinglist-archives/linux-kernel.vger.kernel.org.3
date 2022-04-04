Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BE4F12F4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356949AbiDDKTq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Apr 2022 06:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356886AbiDDKTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:19:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBD633353
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:17:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJmH-00029M-M6; Mon, 04 Apr 2022 12:17:41 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJmI-0010WQ-AD; Mon, 04 Apr 2022 12:17:40 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nbJmG-0006iU-1T; Mon, 04 Apr 2022 12:17:40 +0200
Message-ID: <1459128bf981342c79170f32c95ff09d0fbaa7fa.camel@pengutronix.de>
Subject: Re: [PATCH] reset: tegra-bpmp: Restore Handle errors in BPMP
 response
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Sameer Pujar <spujar@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mperttunen@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 Apr 2022 12:17:39 +0200
In-Reply-To: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
References: <1641995806-15245-1-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2022-01-12 at 19:26 +0530, Sameer Pujar wrote:
> This reverts following commit 69125b4b9440 ("reset: tegra-bpmp:
> Revert
> Handle errors in BPMP response").
> 
> The Tegra194 HDA reset failure is fixed by commit d278dc9151a0
> ("ALSA:
> hda/tegra: Fix Tegra194 HDA reset failure"). The temporary revert of
> original commit c045ceb5a145 ("reset: tegra-bpmp: Handle errors in
> BPMP
> response") can be removed now.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  drivers/reset/tegra/reset-bpmp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/tegra/reset-bpmp.c
> b/drivers/reset/tegra/reset-bpmp.c
> index 24d3395..4c5bba5 100644
> --- a/drivers/reset/tegra/reset-bpmp.c
> +++ b/drivers/reset/tegra/reset-bpmp.c
> @@ -20,6 +20,7 @@ static int tegra_bpmp_reset_common(struct
> reset_controller_dev *rstc,
>         struct tegra_bpmp *bpmp = to_tegra_bpmp(rstc);
>         struct mrq_reset_request request;
>         struct tegra_bpmp_message msg;
> +       int err;
>  
>         memset(&request, 0, sizeof(request));
>         request.cmd = command;
> @@ -30,7 +31,13 @@ static int tegra_bpmp_reset_common(struct
> reset_controller_dev *rstc,
>         msg.tx.data = &request;
>         msg.tx.size = sizeof(request);
>  
> -       return tegra_bpmp_transfer(bpmp, &msg);
> +       err = tegra_bpmp_transfer(bpmp, &msg);
> +       if (err)
> +               return err;
> +       if (msg.rx.ret)
> +               return -EINVAL;
> +
> +       return 0;
>  }
>  
>  static int tegra_bpmp_reset_module(struct reset_controller_dev
> *rstc,

Thank you, applied to reset/fixes.

regards
Philipp
