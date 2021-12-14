Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08949474991
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbhLNRfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:35:52 -0500
Received: from www381.your-server.de ([78.46.137.84]:52118 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhLNRfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=fx0brtaLzlC9ryVIdnbGoXxwD8F3GVdqkl4gyT5mEoA=; b=agE5j1CI6tPVJI2Jm97qtKVwdi
        5tJ/G4sDozsZyvr0TP0G33RWYFYVbGUMtf5/uvGpdXYA0b+PtVYCDohBpDlQEmob9iePaa3k82cVc
        vNR8NpD50B/2OBIl6GxtjekdymZcdnBTbaa2NQ/QhRYx+eSxndjQtfSANkQ60LDaXKXeA9JRGKMv5
        0XN7eNsLeSBm8WYhx/Sw575X704q/n3Tj91/a+wGksRWgDw5wEgd6kZ03XSmRreZoDrixibIVTdBI
        64UBJNVv5StKYFHggJLMzovKPsJodcpd8bwBwKfmnnrewXQ8YAbpTD/PMX7q7l/xT9lzzePMkff7G
        tH2LnDnQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxBiM-0002p5-Lt; Tue, 14 Dec 2021 18:35:46 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxBiM-000Jnk-Aw; Tue, 14 Dec 2021 18:35:46 +0100
Subject: Re: [PATCH] ASoC: wcd934x: Fix a incorrect use of kstrndup
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Banajit Goswami <bgoswami@codeaurora.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20211214152530.23767-1-linmq006@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e7f2ce8d-b9e0-7f36-bff0-d799767c659d@metafoo.de>
Date:   Tue, 14 Dec 2021 18:35:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214152530.23767-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26387/Tue Dec 14 10:33:30 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 4:25 PM, Miaoqian Lin wrote:
> In wcd934x_codec_enable_dec(), widget_name is allocated by kstrndup().
> However, according to doc: "Note: Use kmemdup_nul() instead if the size
> is known exactly." So we should use kmemdup_nul() here instead of
> kstrndup(). It's similar to CVE-2019-12454.
>
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   sound/soc/codecs/wcd934x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index e63c6b723d76..c6677cfbce59 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -5005,7 +5005,7 @@ static int wcd934x_codec_enable_dec(struct snd_soc_dapm_widget *w,
>   	char *dec;
>   	u8 hpf_coff_freq;
>   
> -	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
> +	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
I'm wondering if it isn't better to re-structure the code to not 
allocate any memory.

something like

ret = sscan(w->name, "ADC MUX%d", &decimator);
if (ret != 1)
     ...


