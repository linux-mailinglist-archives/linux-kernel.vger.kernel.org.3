Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB71D48EF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 18:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbiANRzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 12:55:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:55617 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244048AbiANRzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 12:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642182936; x=1673718936;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=doUB/pKBDJqy6j6WmEvX+v/9LR0IPAN2M5yEKEe05ak=;
  b=Pl1Mr5feFB3MS7mM5ByRh1SRL1jO/xbXpbFfRDASLUOtt5lpzk39NJjs
   Y/F62gln7+GDSkDGcz4P6gOKB1SLoHMQyxtqzgQh0mL9jd/KXgiPlgZZH
   xXcAZBSG96Yefwv78wqPl0j9b7KBPYHz7I8qEb8TVly0aWp8LgJmFY46n
   +LTKEtsMWa2QI9MuvzKBT89PTGyoINYGFcVa/aWnbpbwh/Z25Kby/6rqz
   U4BCcudN5naqKXY2bSh/dBPd00lPiuA68fI+YJ+xOwZ4wOO7eQrX9Ce3s
   1xIMrvINjmDRU+UFD+6cHXO8aHa0DtFKdvrC2VtASqkAq1mJba8GZFTq0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="305026674"
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="305026674"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:55:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,289,1635231600"; 
   d="scan'208";a="624426987"
Received: from dsubasic-mobl.amr.corp.intel.com (HELO [10.212.67.37]) ([10.212.67.37])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 09:55:32 -0800
Subject: Re: [PATCH] ASoC: SOF: compr: Add compress ops implementation
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
References: <20220113161341.371345-1-daniel.baluta@oss.nxp.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9b3d28f3-aa2b-ade9-4160-752b349bdeab@linux.intel.com>
Date:   Fri, 14 Jan 2022 11:55:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220113161341.371345-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for starting this work Daniel.

> +int sof_compr_get_params(struct snd_soc_component *component,
> +			 struct snd_compr_stream *cstream, struct snd_codec *params)
> +{
> +	return 0;
> +}

You should probably add a statement along the lines of:

/* TODO: we don't query the supported codecs for now, if the application
asks for an unsupported codec the set_params() will fail
*/

.get_codec_caps is also missing, it should be documented as something we
want to add.

> +static int sof_compr_pointer(struct snd_soc_component *component,
> +			     struct snd_compr_stream *cstream,
> +			     struct snd_compr_tstamp *tstamp)
> +{
> +	struct snd_compr_runtime *runtime = cstream->runtime;
> +	struct sof_compr_stream *sstream = runtime->private_data;
> +
> +	tstamp->sampling_rate = sstream->sample_rate;
> +	tstamp->copied_total = sstream->copied_total;

Humm, this doesn't return any information on how many PCM samples were
generated (pcm_frames) or rendered (pcm_io_frames).

I don't think the existing SOF firmware has this level of detail for
now, you should at least document it as to be added in the future.

In addition, the .pointer callback can be used at different times, and
for added precision the information should be queried from the firmware
via IPC or by looking up counters in the SRAM windows.

I don't think it's good enough to update the information on a fragment
elapsed event. It will work for sure in terms of reporting compressed
data transfers, but it's not good enough for an application to report
time elapsed.

> +struct sof_compr_stream {
> +	unsigned int copied_total;
> +	unsigned int sample_rate;
> +	size_t posn_offset;
> +};

do you need an SOF-specific definition? This looks awfully similar to
snd_compr_tstamp:

struct snd_compr_tstamp {
	__u32 byte_offset;
	__u32 copied_total;
	__u32 pcm_frames;
	__u32 pcm_io_frames;
	__u32 sampling_rate;
}
