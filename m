Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9351468E54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 01:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbhLFAj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 19:39:58 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:46066
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241716AbhLFAj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 19:39:57 -0500
Received: from [192.168.0.108] (unknown [123.112.66.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9B4841BCE;
        Mon,  6 Dec 2021 00:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638750988;
        bh=+JERJC850BGNubSbxA1O3CGXSSEWr0IXlQLLn70HOqI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Ds8sh2OB0yLnHcMSRMWRwEutKzvLBuNI1xMiZZt01sbDA6pobr8Ao1tEXWLcb9f+y
         UOPiaUVfmX1rRxdemLj+apV2hHWuicsqjOsmtXDNwQcsGCSxk9eCGj6KW6OLIl0lpX
         7XNZZt15ZDaVRCd8jbLxElxcFbcuLvHNywGTvaD9iGG7snbfnJICDTrhwWes2nPwM2
         2wv2Vlgn2mMeCj5gKR7XVFOGvkXHMogEhpaaZ3QEgCOLzN434cQC2Gy2C9OoY9btRf
         7rTFVqTqQWxlq+WHjyKsFdvTasuUGrSg9n1HMhGiKfhPEPU3sri4By/oZRqc40MuGr
         cHQDbRq+WTeBQ==
Subject: Re: [PATCH] ASoC: SOF: Intel: move CODEC_PROBE_RETRIES definition
To:     Arnd Bergmann <arnd@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bard Liao <bard.liao@intel.com>,
        sound-open-firmware@alsa-project.org
References: <20211204174529.1122697-1-arnd@kernel.org>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <4a1427ac-bae3-f339-828e-1f9a0229803c@canonical.com>
Date:   Mon, 6 Dec 2021 08:36:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211204174529.1122697-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd, and Kai Vehmanen already sent a fix for this building 
failure: 
https://mailman.alsa-project.org/pipermail/alsa-devel/2021-December/193313.html

On 12/5/21 1:44 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The macro is defined in an #ifdef but used outside:
>
> sound/soc/sof/intel/hda-codec.c: In function 'hda_codec_probe':
> sound/soc/sof/intel/hda-codec.c:132:42: error: 'CODEC_PROBE_RETRIES' undeclared (first use in this function)
>    132 |         } while (resp == -1 && retry++ < CODEC_PROBE_RETRIES);
>        |                                          ^~~~~~~~~~~~~~~~~~~
>
> Move it to a place where it can be seen unconditionally.
>
> Fixes: 046aede2f847 ("ASoC: SOF: Intel: Retry codec probing if it fails")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/sof/intel/hda-codec.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
> index 13cd96e6724a..4324178b3ca6 100644
> --- a/sound/soc/sof/intel/hda-codec.c
> +++ b/sound/soc/sof/intel/hda-codec.c
> @@ -20,9 +20,10 @@
>   #include "../../codecs/hdac_hda.h"
>   #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
>   
> +#define CODEC_PROBE_RETRIES 3
> +
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
>   #define IDISP_VID_INTEL	0x80860000
> -#define CODEC_PROBE_RETRIES 3
>   
>   /* load the legacy HDA codec driver */
>   static int request_codec_module(struct hda_codec *codec)
