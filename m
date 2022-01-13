Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13C48DDD8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiAMSrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:47:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:2420 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237622AbiAMSrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642099642; x=1673635642;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=szWIdMEQGwG7a5XPFaaKP+mai32KTKLbDqKzV+LlJXU=;
  b=cKBuxQGVqDP8xmMsgvfhOZhYzP4YVDepf9PxyiPdCuasSVmotLhTyhKr
   gmQnSmGFeyEhY3J+NpYaqBDC89I4vhyjtwtbJ4N9RglkDCxTT0quUmDQo
   +MK3A/GHniTDZU7cbV5HDUz8CxYJDfFj8mCHCo9OYQ3ycZ7DYgZxqx/yG
   GkHAXF6SBYu/siFQSk4+6hg00o5nyRCcyQpsP1yTiQMdfwCWO6YybPYPV
   LtH6qw2fOSl59oifoZoeIVjVzubFUxphfuReTzi2fvCkHrYjNEblHAOna
   eXsxmGkRatXWNw2ZMmcmNzPloLPqyLXwtNxSVhEAWHW2VFWVRv6hde2vl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307432809"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="307432809"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:47:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="620702034"
Received: from ypchen-mobl.amr.corp.intel.com (HELO [10.212.66.70]) ([10.212.66.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 10:47:20 -0800
Subject: Re: [PATCH v13 2/2] mailbox: mediatek: add support for adsp mailbox
 controller
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        cujomalainey@google.com, Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20220113082103.27911-1-allen-kh.cheng@mediatek.com>
 <20220113082103.27911-3-allen-kh.cheng@mediatek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c876eda8-1fde-6c40-117a-12dde042780d@linux.intel.com>
Date:   Thu, 13 Jan 2022 12:47:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113082103.27911-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> +static int mtk_adsp_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_adsp_mbox_priv *priv;
> +	const struct mtk_adsp_mbox_cfg *cfg;
> +	struct mbox_controller *mbox;
> +	int ret, irq;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mbox = &priv->mbox;
> +	mbox->dev = dev;
> +	mbox->ops = &mtk_adsp_mbox_chan_ops;
> +	mbox->txdone_irq = false;
> +	mbox->txdone_poll = true;
> +	mbox->of_xlate = mtk_adsp_mbox_xlate;
> +	mbox->num_chans = 1;
> +	mbox->chans = devm_kzalloc(dev, sizeof(*mbox->chans), GFP_KERNEL);
> +	if (!mbox->chans)
> +		return -ENOMEM;
> +
> +	priv->va_mboxreg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->va_mboxreg))
> +		return PTR_ERR(priv->va_mboxreg);
> +
> +	priv->cfg = of_device_get_match_data(dev);

question: is any error handling needed here? some drivers do, others
don't, but that function can return NULL.

> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_threaded_irq(dev, irq, mtk_adsp_mbox_irq,
> +					mtk_adsp_mbox_isr, IRQF_TRIGGER_NONE,
> +					dev_name(dev), mbox->chans);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_mbox_controller_register(dev, &priv->mbox);
> +}

