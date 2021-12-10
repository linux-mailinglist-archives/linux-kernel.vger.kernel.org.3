Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1513470EBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243686AbhLJXil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 18:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbhLJXik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:38:40 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA73C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:35:05 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id q72so12096417iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6QJ20M3nxOHhc4R0qveSgmz/rniLYt7DfPOg8sRQIf8=;
        b=rrCfTEHy0Sza6kwofNY9pYQjnJGnUT5EPxAln3g3orsrmTX5xCPVMbt4TaQtyyz6sf
         ybbCHwy9DKxx00uUHb/+/dDXVCRO8cXXPU4iwV4T1lj8jLTiOPmga3DLE71SdpIqGT0o
         dL9AA3wwMBaEWQoJCnRfN9Fwav/adMOneKAJODyy93MTqblwPDPw+eJbfNquOa1vxY4V
         g+kzShsjmMohhEABPCAx5aPp0i6zJ/RFm4jZUTRhX6jdQxlXRMn/XfCqlrQ40KOuxGbE
         t4xRN6ZRMIXU1Uj7avN4VtbgrTEORxlKsO1V+dq1pImbsF40H3kNaFscgMCmv4ETFFhV
         A0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6QJ20M3nxOHhc4R0qveSgmz/rniLYt7DfPOg8sRQIf8=;
        b=vC7+e09rqXRSuUapSSI1Qq9AEYvawvDBhAmyoYkKyopZ0G6dFt4X6uKNySdxW4whA7
         GPQEgmoTxmjU0uaSC7gQDgQGaTVq5sSpzMb22EeaUtOWcHe5Qhfh5c5BPrzdOcTYWh2C
         5ghQs+ihvz7GQFtnhU0kd42fFBsR0+p73YdHRxehTBccorn8GucGWCuP9kMb8tQtzy1V
         HJP1DPoGKb7tALmkVnCRFjRq96gHV47r4hARVs/da2+URoLlDB3gP38Np9TnTpYpJ9pa
         BCnbxOXbG0A/wIVCt5qcXaI29KMJe7XNXf/PS2CUl4VTY75fJaguIrHUc/HHPnvfy/dW
         vIlQ==
X-Gm-Message-State: AOAM5335HxarEa0PUTBz9UbgwEaY3XEIP8zyjypwLmx1gLvGdD7qNuQE
        3Sb9Y2vacf3oO92IFFufcuv0Sw==
X-Google-Smtp-Source: ABdhPJwN5+sithcuVL1r0Md3aO3vE7jZYF/cLvv6tzplQZQkyyxTZcFKfO/LBD8WzsRRjeh8klwvrw==
X-Received: by 2002:a5e:861a:: with SMTP id z26mr23583887ioj.134.1639179304040;
        Fri, 10 Dec 2021 15:35:04 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id q4sm2900399ilj.7.2021.12.10.15.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 15:35:03 -0800 (PST)
Message-ID: <0ce9cde4-de94-856b-329c-d75929799bb2@linaro.org>
Date:   Fri, 10 Dec 2021 17:35:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: fix stack size warning
 with UBSAN
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, linux-staging@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20211209195141.1165233-1-nathan@kernel.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20211209195141.1165233-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 1:51 PM, Nathan Chancellor wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about excessive stack usage in this driver when
> UBSAN is enabled:
> 
> drivers/staging/greybus/audio_topology.c:977:12: error: stack frame size of 1836 bytes in function 'gbaudio_tplg_create_widget' [-Werror,-Wframe-larger-than=]
> 
> Rework this code to no longer use compound literals for
> initializing the structure in each case, but instead keep
> the common bits in a preallocated constant array and copy
> them as needed.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1535
> Link: https://lore.kernel.org/r/20210103223541.2790855-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [nathan: Address review comments from v1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This looks good to me and it seems the switch statement
becomes much more concise.

One thing I would suggest is that you somehow capture
in comments the fact that you're manually assigning the
widget name and in a couple spots the "sname" (I don't know
what that represents).

Someday these SND_SOC_DAPM*() macros could be changed,
and it would be helpful to have a little guidance around
this code to explain what was done here.

This isn't critical, but would improve maintainability.

We can see what others think, but either way:

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
> 
> v1 -> v2: https://lore.kernel.org/r/20210103223541.2790855-1-arnd@kernel.org/
> 
> * Use NULL for name field in SND_DOC_DAPM_* in gbaudio_widgets (Alex).
> 
> * Do not eliminate *dw assignment within the switch cases, as invalid
>    enum values in-between valid enum values (such as snd_soc_dapm_demux)
>    would not be handled properly by the "if value is greater than the
>    array size" check (Alex). This addresses a few other comments by Alex
>    and Dan because w->type is not checked against the array's size.
> 
> Arnd, if you disagree with this approach, please let me know so that we
> can get this fixed in a way that everyone is happy with.
> 
>   drivers/staging/greybus/audio_topology.c | 92 ++++++++++++------------
>   1 file changed, 45 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index 1e613d42d823..7f7d558b76d0 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -974,6 +974,44 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
>   	return ret;
>   }
>   
> +static const struct snd_soc_dapm_widget gbaudio_widgets[] = {
> +	[snd_soc_dapm_spk]	= SND_SOC_DAPM_SPK(NULL, gbcodec_event_spk),
> +	[snd_soc_dapm_hp]	= SND_SOC_DAPM_HP(NULL, gbcodec_event_hp),
> +	[snd_soc_dapm_mic]	= SND_SOC_DAPM_MIC(NULL, gbcodec_event_int_mic),
> +	[snd_soc_dapm_output]	= SND_SOC_DAPM_OUTPUT(NULL),
> +	[snd_soc_dapm_input]	= SND_SOC_DAPM_INPUT(NULL),
> +	[snd_soc_dapm_switch]	= SND_SOC_DAPM_SWITCH_E(NULL, SND_SOC_NOPM,
> +					0, 0, NULL,
> +					gbaudio_widget_event,
> +					SND_SOC_DAPM_PRE_PMU |
> +					SND_SOC_DAPM_POST_PMD),
> +	[snd_soc_dapm_pga]	= SND_SOC_DAPM_PGA_E(NULL, SND_SOC_NOPM,
> +					0, 0, NULL, 0,
> +					gbaudio_widget_event,
> +					SND_SOC_DAPM_PRE_PMU |
> +					SND_SOC_DAPM_POST_PMD),
> +	[snd_soc_dapm_mixer]	= SND_SOC_DAPM_MIXER_E(NULL, SND_SOC_NOPM,
> +					0, 0, NULL, 0,
> +					gbaudio_widget_event,
> +					SND_SOC_DAPM_PRE_PMU |
> +					SND_SOC_DAPM_POST_PMD),
> +	[snd_soc_dapm_mux]	= SND_SOC_DAPM_MUX_E(NULL, SND_SOC_NOPM,
> +					0, 0, NULL,
> +					gbaudio_widget_event,
> +					SND_SOC_DAPM_PRE_PMU |
> +					SND_SOC_DAPM_POST_PMD),
> +	[snd_soc_dapm_aif_in]	= SND_SOC_DAPM_AIF_IN_E(NULL, NULL, 0,
> +					SND_SOC_NOPM, 0, 0,
> +					gbaudio_widget_event,
> +					SND_SOC_DAPM_PRE_PMU |
> +					SND_SOC_DAPM_POST_PMD),
> +	[snd_soc_dapm_aif_out]	= SND_SOC_DAPM_AIF_OUT_E(NULL, NULL, 0,
> +					SND_SOC_NOPM, 0, 0,
> +					gbaudio_widget_event,
> +					SND_SOC_DAPM_PRE_PMU |
> +					SND_SOC_DAPM_POST_PMD),
> +};
> +
>   static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>   				      struct snd_soc_dapm_widget *dw,
>   				      struct gb_audio_widget *w, int *w_size)
> @@ -1052,77 +1090,37 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>   
>   	switch (w->type) {
>   	case snd_soc_dapm_spk:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_SPK(w->name, gbcodec_event_spk);
> +		*dw = gbaudio_widgets[w->type];
>   		module->op_devices |= GBAUDIO_DEVICE_OUT_SPEAKER;
>   		break;
>   	case snd_soc_dapm_hp:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_HP(w->name, gbcodec_event_hp);
> +		*dw = gbaudio_widgets[w->type];
>   		module->op_devices |= (GBAUDIO_DEVICE_OUT_WIRED_HEADSET
>   					| GBAUDIO_DEVICE_OUT_WIRED_HEADPHONE);
>   		module->ip_devices |= GBAUDIO_DEVICE_IN_WIRED_HEADSET;
>   		break;
>   	case snd_soc_dapm_mic:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_MIC(w->name, gbcodec_event_int_mic);
> +		*dw = gbaudio_widgets[w->type];
>   		module->ip_devices |= GBAUDIO_DEVICE_IN_BUILTIN_MIC;
>   		break;
>   	case snd_soc_dapm_output:
> -		*dw = (struct snd_soc_dapm_widget)SND_SOC_DAPM_OUTPUT(w->name);
> -		break;
>   	case snd_soc_dapm_input:
> -		*dw = (struct snd_soc_dapm_widget)SND_SOC_DAPM_INPUT(w->name);
> -		break;
>   	case snd_soc_dapm_switch:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_SWITCH_E(w->name, SND_SOC_NOPM, 0, 0,
> -					      widget_kctls,
> -					      gbaudio_widget_event,
> -					      SND_SOC_DAPM_PRE_PMU |
> -					      SND_SOC_DAPM_POST_PMD);
> -		break;
>   	case snd_soc_dapm_pga:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_PGA_E(w->name, SND_SOC_NOPM, 0, 0, NULL, 0,
> -					   gbaudio_widget_event,
> -					   SND_SOC_DAPM_PRE_PMU |
> -					   SND_SOC_DAPM_POST_PMD);
> -		break;
>   	case snd_soc_dapm_mixer:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_MIXER_E(w->name, SND_SOC_NOPM, 0, 0, NULL,
> -					     0, gbaudio_widget_event,
> -					     SND_SOC_DAPM_PRE_PMU |
> -					     SND_SOC_DAPM_POST_PMD);
> -		break;
>   	case snd_soc_dapm_mux:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_MUX_E(w->name, SND_SOC_NOPM, 0, 0,
> -					   widget_kctls, gbaudio_widget_event,
> -					   SND_SOC_DAPM_PRE_PMU |
> -					   SND_SOC_DAPM_POST_PMD);
> +		*dw = gbaudio_widgets[w->type];
>   		break;
>   	case snd_soc_dapm_aif_in:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_AIF_IN_E(w->name, w->sname, 0,
> -					      SND_SOC_NOPM,
> -					      0, 0, gbaudio_widget_event,
> -					      SND_SOC_DAPM_PRE_PMU |
> -					      SND_SOC_DAPM_POST_PMD);
> -		break;
>   	case snd_soc_dapm_aif_out:
> -		*dw = (struct snd_soc_dapm_widget)
> -			SND_SOC_DAPM_AIF_OUT_E(w->name, w->sname, 0,
> -					       SND_SOC_NOPM,
> -					       0, 0, gbaudio_widget_event,
> -					       SND_SOC_DAPM_PRE_PMU |
> -					       SND_SOC_DAPM_POST_PMD);
> +		*dw = gbaudio_widgets[w->type];
> +		dw->sname = w->sname;
>   		break;
>   	default:
>   		ret = -EINVAL;
>   		goto error;
>   	}
> +	dw->name = w->name;
>   
>   	dev_dbg(module->dev, "%s: widget of type %d created\n", dw->name,
>   		dw->id);
> 
> base-commit: 42eb8fdac2fc5d62392dcfcf0253753e821a97b0
> 

