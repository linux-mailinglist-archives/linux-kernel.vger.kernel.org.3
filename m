Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652634749E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbhLNRmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:42:49 -0500
Received: from www381.your-server.de ([78.46.137.84]:41418 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhLNRmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=GPK+n5MrkQApeMJaTshLG0e3f9wJqeaDHXMDdFU7TnA=; b=HKNIvUv/1EC+gP9WQ6c0DAVZL8
        TylVc4nUagecMUQwnb+8poxSNqa9EEkYpbzvgasT92ghjmNYLPfqExTRGUMCaYINfgSXKRjm7BPFm
        8ml/uYCl75Rx3hq30vGzpKVUPglV+SgJPCfRVKhuFgCemI8gp8XY8aZVyYKihKqSzMU8dDoL2RNsC
        IcaYmPYn3a8U60Q2zKwoije0m0aEGH58euhC4ItefKMhWO9j606XM6YXpziqtzLhgOSQPnHkJQNsD
        Dys49QHIEzdMqK2jfO7PSD1HuET+1FF7cyWFsrt86wd/evmJxdvD48H5JHRH0uAjK/8ZdwpAYS3Me
        tCUAKPhw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mxBp6-0003ky-Aa; Tue, 14 Dec 2021 18:42:44 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mxBp6-0007SG-0y; Tue, 14 Dec 2021 18:42:44 +0100
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
Message-ID: <03a2bb9d-972d-b481-f03b-d50bab422f78@metafoo.de>
Date:   Tue, 14 Dec 2021 18:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211214152530.23767-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Thinking a bit more about it, this is wrong. The source string is 
shorter than 15 character. So with this change you are copying past the 
end of the string, which depending on where in memory the string is 
placed can cause undefined behavior.

