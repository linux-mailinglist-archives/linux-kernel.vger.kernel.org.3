Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BE4630A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhK3KKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:10:19 -0500
Received: from smtp2.axis.com ([195.60.68.18]:18570 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240713AbhK3KKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638266818;
  x=1669802818;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-transfer-encoding;
  bh=UCgk7kbDQh7QdhPkOEMiahIQV6+21NZJki0/IukQ16o=;
  b=nvO1QNCh5HIm4GFrWdwvRPa6SDKn03u8vTPaimzGjsLBzHqMOHkHn8Pa
   041jv+4b82Cqf7q0eayTzNBryvLscjztUN0ihhd4Y2insBBqzPxlFiarz
   TYmW16EwOWBLZLBNaFAYPbPjG0z5V+BLhSzFci7C4g4MQZbrgs7vz/+SL
   OJ79gsruWveD8D12nwA9VtX028gar/s+nGDce6xfLOLxcp8FNlvnIyBi8
   1HrHklveDJyGopSc/UL3kuL6tW6XW8p3d+QKg4Hw1BiiTaEv6pWWUlrWb
   571rrNexE93VVEG95+y67iDGNA5h8aUW0UFw2j8nGZtztLs8h1cgKcCbm
   g==;
Date:   Tue, 30 Nov 2021 11:06:52 +0100
From:   Ricard Wanderlof <ricardw@axis.com>
X-X-Sender: ricardw@lnxricardw1.se.axis.com
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: meson: use dev_err_probe
In-Reply-To: <20211130093617.103147-1-jbrunet@baylibre.com>
Message-ID: <alpine.DEB.2.21.2111301104440.30606@lnxricardw1.se.axis.com>
References: <20211130093617.103147-1-jbrunet@baylibre.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail08w.axis.com (10.20.40.14) To se-mail07w.axis.com
 (10.20.40.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Nov 2021, Jerome Brunet wrote:

> Use dev_err_probe() helper function to handle probe deferral.
> It removes the open coded test for -EPROBE_DEFER but more importantly, it
> sets the deferral reason in debugfs which is great for debugging.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  sound/soc/meson/aiu.c               | 17 +++++++----------
>  sound/soc/meson/axg-fifo.c          |  9 +++------
>  sound/soc/meson/axg-pdm.c           |  9 +++------
>  sound/soc/meson/axg-spdifin.c       |  6 ++----
>  sound/soc/meson/axg-spdifout.c      |  6 ++----
>  sound/soc/meson/axg-tdm-formatter.c | 18 ++++++------------
>  sound/soc/meson/axg-tdm-interface.c |  9 +++------
>  sound/soc/meson/meson-card-utils.c  |  4 ++--
>  sound/soc/meson/t9015.c             |  8 ++++----
>  9 files changed, 32 insertions(+), 54 deletions(-)
> 
> diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
> index ba15d5762b0b..37036adf14ce 100644
> --- a/sound/soc/meson/aiu.c
> +++ b/sound/soc/meson/aiu.c
> @@ -219,31 +219,29 @@ static int aiu_clk_get(struct device *dev)
>  
>          aiu->pclk = devm_clk_get(dev, "pclk");
>          if (IS_ERR(aiu->pclk)) {
> -               if (PTR_ERR(aiu->pclk) != -EPROBE_DEFER)
> -                       dev_err(dev, "Can't get the aiu pclk\n");
> +               dev_err_probe(dev, PTR_ERR(aiu->pclk),
> +                             "Can't get the aiu pclk\n");
>                  return PTR_ERR(aiu->pclk);
>          }

A minor thing, but dev_err_probe returns its err argument, so this 
construct can be written more tersely as:

		return dev_err_probe(dev, PTR_ERR(aio->pclk),
                                     "Can't get the aio pclk\n");

and that also seems to be in common usage when browsing existing code.

/Ricard
-- 
Ricard Wolf Wanderlof                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
