Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD65527289
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiENPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiENPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 11:20:49 -0400
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E92F391
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 08:20:47 -0700 (PDT)
Received: from [192.168.3.48] (unknown [220.250.45.22])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id E939880017B;
        Sat, 14 May 2022 23:20:42 +0800 (CST)
Message-ID: <7ff0ed31-6326-9dc8-6003-0aab8370ad0d@rock-chips.com>
Date:   Sat, 14 May 2022 23:20:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] ASoC: hdmi-codec: Add option for ELD bypass
To:     Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220430134006.v2.1.Ide2a04ad0c123cc6990a63632e6f9bb7d7f9be13@changeid>
 <20220503083852.be2aihvkd3gestdw@houat> <YnGUHcFOYrvcA2Ol@sirena.org.uk>
From:   sugar zhang <sugar.zhang@rock-chips.com>
In-Reply-To: <YnGUHcFOYrvcA2Ol@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlJTU5WSElJGU9PH0tKHk
        xIVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITk9VS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nk06Kxw6Sj05TU0JSzJLFwo8
        HilPCRJVSlVKTU5JTk9KTU9IT0JJVTMWGhIXVQgOHBoJVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlX
        WRILWUFZSUlLVUlOS1VPTlVJSVlXWQgBWUFIQkhONwY+
X-HM-Tid: 0a80c32859c3b03akuuue939880017b
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Maxime,

在 2022/5/4 4:44, Mark Brown 写道:
> On Tue, May 03, 2022 at 10:38:52AM +0200, Maxime Ripard wrote:
>
>> I think some more documentation is needed there to describe how it's
>> going to be used.
>>
>> Like, you mention that it's relevant when the EDID is not valid. But if
>> the EDID is valid, is bypass still allowed or not?
> I'd expect so given that it's explicitly an override and that it's not
> like it's unknown for people to put nonsense in ID information.
>
>>> +static int hdmi_codec_eld_bypass_put(struct snd_kcontrol *kcontrol,
>>> +				     struct snd_ctl_elem_value *ucontrol)
>>> +{
>>> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>>> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
>>> +
>>> +	if (hcp->eld_bypass == ucontrol->value.integer.value[0])
>>> +		return 0;
>>> +
>>> +	hcp->eld_bypass = ucontrol->value.integer.value[0];
>>> +
>>> +	return 1;
>>> +}
>> If the ELD bypass is set, how does it affect the hdmi_codec_params being
>> passed to the codec?
> Presumably we should tell the CODEC what we're trying to play (looks
> like that's what the current code does)?
>
>> Also, what is being returned to the userspace by hdmi_eld_ctl_get once
>> the bypass is enabled?
> My first thought would be that we'd always read whatever is there
> rather than trying to make something up, bypass just says we're not
> enforcing it.
>
>> And shouldn't we call get_eld when we remove the bypass?
> Or given what I just said above should we not change any get_eld() calls
> but instead only change things so that we don't look at the ELD data
> when setting constraints during startup() and during channel map
> operations?  In that case we wouldn't need to read again.

I agree this idea that just don't use it for constraints and channel map 
or something else.

but still do get_eld() as it was. will do in v3.


-- 
Best Regards!
张学广/Sugar
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.

