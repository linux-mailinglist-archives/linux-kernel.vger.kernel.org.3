Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D0512B05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 07:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiD1Foi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiD1Fog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:44:36 -0400
X-Greylist: delayed 3396 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Apr 2022 22:41:21 PDT
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574E5EDF0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 22:41:20 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 23S4iiUx031241;
        Thu, 28 Apr 2022 13:44:44 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Thu, 28 Apr 2022 13:44:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.2] (125.90.232.153.ap.dti.ne.jp [153.232.90.125])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 23S4ihJD031236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 28 Apr 2022 13:44:43 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Message-ID: <d2d0ac77-e8bc-dd69-0a8a-470e42276d8c@katsuster.net>
Date:   Thu, 28 Apr 2022 13:44:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: rk3328: fix disabling mclk on pclk probe failure
Content-Language: en-US
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220427172310.138638-1-frattaroli.nicolas@gmail.com>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
In-Reply-To: <20220427172310.138638-1-frattaroli.nicolas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nicolas,

Oh, indeed. Thanks for fix.

Reviewed-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>


On 2022/04/28 2:23, Nicolas Frattaroli wrote:
> If preparing/enabling the pclk fails, the probe function should
> unprepare and disable the previously prepared and enabled mclk,
> which it doesn't do. This commit rectifies this.
> 
> Fixes: c32759035ad2 ("ASoC: rockchip: support ACODEC for rk3328")
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>   sound/soc/codecs/rk3328_codec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
> index 758d439e8c7a..86b679cf7aef 100644
> --- a/sound/soc/codecs/rk3328_codec.c
> +++ b/sound/soc/codecs/rk3328_codec.c
> @@ -481,7 +481,7 @@ static int rk3328_platform_probe(struct platform_device *pdev)
>   	ret = clk_prepare_enable(rk3328->pclk);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to enable acodec pclk\n");
> -		return ret;
> +		goto err_unprepare_mclk;
>   	}
>   
>   	base = devm_platform_ioremap_resource(pdev, 0);

