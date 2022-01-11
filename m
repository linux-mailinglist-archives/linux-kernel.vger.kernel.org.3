Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424AB48B3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343983AbiAKRZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:25:00 -0500
Received: from mga03.intel.com ([134.134.136.65]:11614 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238268AbiAKRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641921875; x=1673457875;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gEUR+PS3VK1rPxJq6WRhpVCCJmBWIol2sYXcM1N0t6I=;
  b=neRQrHkUc5sTOWvdaUnorTxzbtt4sdBqFv7MjMsNG08Ix9HhdBZug1EV
   3/coqG52g1JrJB9GX572WVGQIpz5q+64vPjyfGNnDOa9AQM7hDz6CluRg
   B1v64i/wMh79Ue4tFWxGbjP4iedywa+pNnz2MLW4y52F69uPQagaJLq1f
   /h3jA3QfxpIKa4FDP9h+1rn8X7Xf5AeSP+N1VGWjPXRyBWeX4RR1GhJ/j
   HFlM9e+ztQuK2GykFYb44RCdP+/m0uFsY1fQLNFy1D76/PpvL7W+ae9Sa
   a+dusAHm9m2uywvr9737jW+JH5AGZYWhY2gC3Bgypv63KNvfm2YnTydLQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243497028"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243497028"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 09:23:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="592749789"
Received: from cdoher2x-mobl1.amr.corp.intel.com (HELO [10.212.119.165]) ([10.212.119.165])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 09:23:32 -0800
Subject: Re: [PATCH] firmware: mediatek: add adsp ipc protocol interface
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        cujomalainey@google.com, Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20220111071011.5964-1-allen-kh.cheng@mediatek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <91eef4c9-adda-1921-16b5-af181b30d36e@linux.intel.com>
Date:   Tue, 11 Jan 2022 11:02:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111071011.5964-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +int mtk_adsp_ipc_send(struct mtk_adsp_ipc *ipc, unsigned int idx, uint32_t msg)
> +{
> +	struct mtk_adsp_chan *dsp_chan;
> +	int ret;
> +
> +	if (idx >= MTK_ADSP_MBOX_NUM)
> +		return -EINVAL;
> +
> +	dsp_chan = &ipc->chans[idx];
> +	ret = mbox_send_message(dsp_chan->ch, &msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

this can be simplified a bit without the 'ret' variable

return mbox_send_message(dsp_chan->ch, &msg);

> +}
> +EXPORT_SYMBOL(mtk_adsp_ipc_send);


> +static int mtk_adsp_ipc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_adsp_ipc *dsp_ipc;
> +	struct mtk_adsp_chan *dsp_chan;
> +	struct mbox_client *cl;
> +	char *chan_name;
> +	int ret;
> +	int i, j;
> +
> +	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
> +
> +	dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
> +	if (!dsp_ipc)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> +		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> +		if (!chan_name) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}

in this case with the existing code you will free something that was not
allocated. It's not super elegant, consider using different labels as
suggested below.

> +
> +		dsp_chan = &dsp_ipc->chans[i];
> +		cl = &dsp_chan->cl;
> +		cl->dev = dev->parent;
> +		cl->tx_block = false;
> +		cl->knows_txdone = false;
> +		cl->tx_prepare = NULL;
> +		cl->rx_callback = mtk_adsp_ipc_recv;
> +
> +		dsp_chan->ipc = dsp_ipc;
> +		dsp_chan->idx = i;
> +		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
> +		if (IS_ERR(dsp_chan->ch)) {
> +			ret = PTR_ERR(dsp_chan->ch);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to request mbox chan %d ret %d\n",
> +					i, ret);
> +			goto out;

goto out_free;

> +		}
> +
> +		dev_dbg(dev, "request mbox chan %s\n", chan_name);
> +		kfree(chan_name);
> +	}
> +
> +	dsp_ipc->dev = dev;
> +	dev_set_drvdata(dev, dsp_ipc);
> +	dev_dbg(dev, "MTK ADSP IPC initialized\n");
> +
> +	return 0;
> +
> +out:

out_free:
> +	kfree(chan_name);

out:

> +	for (j = 0; j < i; j++) {
> +		dsp_chan = &dsp_ipc->chans[j];
> +		mbox_free_channel(dsp_chan->ch);
> +	}
> +
> +	return ret;
> +}
> +
> +static int mtk_adsp_ipc_remove(struct platform_device *pdev)
> +{
> +	struct mtk_adsp_ipc *dsp_ipc = dev_get_drvdata(&pdev->dev);
> +	struct mtk_adsp_chan *dsp_chan;
> +	int i;
> +
> +	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> +		dsp_chan = &dsp_ipc->chans[i];
> +		mbox_free_channel(dsp_chan->ch);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mtk_adsp_ipc_driver = {
> +	.driver = {
> +		.name = "mtk-adsp-ipc",
> +	},
> +	.probe = mtk_adsp_ipc_probe,
> +	.remove = mtk_adsp_ipc_remove,
> +};
> +builtin_platform_driver(mtk_adsp_ipc_driver);
> +
> +MODULE_AUTHOR("Allen-KH Cheng <allen-kh.cheng@mediatek.com>");
> +MODULE_DESCRIPTION("MTK ADSP IPC Driver");
> +MODULE_LICENSE("GPL v2");

the v2 here isn't useful, the license information can be found in the
SPDX line.

MODULE_LICENSE("GPL");


