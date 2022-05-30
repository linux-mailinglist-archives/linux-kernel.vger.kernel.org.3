Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8F537A25
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiE3LtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiE3Ls4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:48:56 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27B692BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:48:54 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3ABDBA0047;
        Mon, 30 May 2022 13:32:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3ABDBA0047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1653910326; bh=zjOHNt523dbFOX2xDzHhluv4/0kMV+wexiBuakxIphQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZJHLT1qARbd3f64k2TMFvhtn40n0feo6CMHuh2hvI+YggpDXWOsuPKN2+X79dbEt2
         xheVPxLuXhBZj8PQfCENcoXrDVozMqKt6dYFncRRVDZGt94BglqOqAQnl+Pp5/9rCJ
         7xc4sC62joPZ/9Pb00HUqKy9kaQR1HpGdSklKrZU=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 30 May 2022 13:31:59 +0200 (CEST)
Message-ID: <dd0817a9-16f9-a08f-fcde-97788de445d3@perex.cz>
Date:   Mon, 30 May 2022 13:31:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v4 16/17] ALSA: hda: cs35l41: Support Firmware switching
 and reloading
Content-Language: en-US
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Stefan Binding <sbinding@opensource.cirrus.com>
References: <20220525131638.5512-1-vitalyr@opensource.cirrus.com>
 <20220525131638.5512-17-vitalyr@opensource.cirrus.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220525131638.5512-17-vitalyr@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 22 15:16, Vitaly Rodionov wrote:

> This patch adds 2 ALSA Controls for each amp:
> "DSP1 Firmware Load"
> "DSP1 Firmware Type"

...

> +	struct snd_kcontrol_new fw_type_ctl = {
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.info = cs35l41_fw_type_ctl_info,
> +		.get = cs35l41_fw_type_ctl_get,
> +		.put = cs35l41_fw_type_ctl_put,
> +	};
> +	struct snd_kcontrol_new fw_load_ctl = {
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +		.info = snd_ctl_boolean_mono_info,
> +		.get = cs35l41_fw_load_ctl_get,
> +		.put = cs35l41_fw_load_ctl_put,
> +	};

I don't think that those controls should be SNDRV_CTL_ELEM_IFACE_MIXER type. 
The SNDRV_CTL_ELEM_IFACE_CARD seems more appropriate (service controls for the 
sound card).

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
