Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE27C57A1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiGSOeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiGSOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:34:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BD3263C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 07:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658240697; x=1689776697;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QymwNLTw+r+SLmXB6/1tpXs8q8Yf+hUenOyUMN0/wGM=;
  b=U7jmdEvcDiqW4FKLf1KoUp07zirX1+sSX6ZqrnXzOHPmwyUx3u3hLqNp
   wJHvLBh4lhcqzk6t1a9PPQ5Fjh67ZJKxlNfDEBxL6O2thfBRRUjYBDsEl
   UhggRj/XciCMsNWZYEvxbSYq3iCCt2g5Nz/VpzGwOw3qEoJVAuwjq9ItK
   zlNRGKro1kWLYCqMaTYZzdJgaSTetVsc7yEVwTXVvssksP1N4iZndJubW
   kEKjLQ9bDvb5gDs3nbnL+x5ONhnEBdWvbuAFuCo5XpFNnEfkqffaYLfI/
   2SKKJjeq5XJtEqeDAgYVRxqCbgdH0xQEVrw0R1KIGMBkkHEykvESC9Dsu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="312192946"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="312192946"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:24:57 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="594845495"
Received: from kckollur-mobl1.amr.corp.intel.com (HELO [10.212.118.182]) ([10.212.118.182])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:24:56 -0700
Message-ID: <26e40344-453f-6bdb-cd4b-15431a930497@linux.intel.com>
Date:   Tue, 19 Jul 2022 09:24:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH -next v2] ASoC: Intel: Fix missing clk_disable_unprepare()
 on err in platform_clock_control()
Content-Language: en-US
To:     Zhang Zekun <zhangzekun11@huawei.com>, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, xuqiang36@huawei.com
References: <20220719013628.40153-1-zhangzekun11@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220719013628.40153-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/22 20:36, Zhang Zekun wrote:
> Fix the missing clk_disable_unprepare() before return
> from platform_clock_control() in error handling path.
> 
> Fixes: 9a87fc1e0619 ("ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102")
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> ---
>  sound/soc/intel/boards/bytcr_wm5102.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
> index 45a6805787f5..3e3cdee4b1ce 100644
> --- a/sound/soc/intel/boards/bytcr_wm5102.c
> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
> @@ -111,6 +111,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
>  		ret = byt_wm5102_prepare_and_enable_pll1(codec_dai, 48000);
>  		if (ret) {
>  			dev_err(card->dev, "Error setting codec sysclk: %d\n", ret);
> +			clk_disable_unprepare(priv->mclk);

This change looks legit to me, but you want to CC: maintainers (Mark
Brown, Takashi Iwai), use the alsa-devel mailing list and CC: the
initial contributor Hans de Goede.

>  			return ret;
>  		}
>  	} else {
