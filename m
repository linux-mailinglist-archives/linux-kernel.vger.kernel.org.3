Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9DD511254
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358756AbiD0H3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236000AbiD0H3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:29:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBF44769
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651044367; x=1682580367;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2/IRGZCMyAEwQk5AnwH4BPYPn0JlnnUPyH5HN+F/tJY=;
  b=DHB6ql2+2SNH33SmmR71FXytjsDzKYx3TMDQP3UE5DMyNl3wpfl1wI8K
   d9bASeQvuD6HynBE2SsxiGwt+swwRLJScuHKcqKGVAJ3I5yUZJwZDUO8C
   gqJCdE+UZjiuI/2UnOmljc2Qn5TtTPaCi4D3TWEJplhNOFgV5hWO6f612
   cSs2ZeM3seSwthYHwdg3Wq4o449psMcsGaM8O++6eh7Iq9d0f//G5YyCt
   Bm69RdHUCI/J3WjiblJA7/d/yQl7wYaMoJEWm93yi5dCWh6lqFjZwcrzZ
   L4aunZfSx12QfRAL7RtkRhxONJU8JhFcHYT3Ylekv//aJ0H8diSZZ4R1w
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264691969"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="264691969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:26:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="705424932"
Received: from rdegreef-mobl1.ger.corp.intel.com (HELO [10.252.32.27]) ([10.252.32.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 00:26:04 -0700
Message-ID: <e349e9ca-7a4f-8d65-3ade-5ac4dfd5700a@linux.intel.com>
Date:   Wed, 27 Apr 2022 10:26:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: out-of-bounds access in sound/soc/sof/topology.c
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        sound-open-firmware@alsa-project.org
References: <Ylk5o3EC/hyX5UQ0@google.com>
 <8eeb08ec-4836-cf7d-2285-8ed74ccfc1cb@linux.intel.com>
 <8986a1c6-b546-7a66-a778-048487624c95@linux.intel.com>
 <e31ff7c4-7cdc-fdaf-b12c-fc1e51798a1b@linux.intel.com>
 <Ymjo1aHD4V6bNHz7@google.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <Ymjo1aHD4V6bNHz7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2022 09:55, Sergey Senozhatsky wrote:
> On (22/04/19 08:07), Pierre-Louis Bossart wrote:
>>> Your analyzes are spot on, unfortunately. But...
>>>
>>> As of today, the sof_get_control_data() is in the call path of
>>> (ipc3-topology.c):
>>>
>>> sof_widget_update_ipc_comp_process() -> sof_process_load() ->
>>> sof_get_control_data()
>>>
>>> sof_widget_update_ipc_comp_process() is the ipc_setup callback for
>>> snd_soc_dapm_effect. If I'm not mistaken these only carries bin payload
>>> and never MIXER/ENUM/SWITCH/VOLUME.
>>> This means that the sof_get_control_data() is only called with
>>> SND_SOC_TPLG_TYPE_BYTES and for that the allocated data area is correct.
>>>
>>> This can explain why we have not seen any issues so far. This does not
>>> renders the code right, as how it is written atm is wrong.
>>
>>
>> Sergey's results with KASAN show that there's a real-life problem though. I also don't understand how that might happen.
>>
>> Could it be that these results are with a specific topology where our assumptions are incorrect?
> 
> Is there anything I can do to help?

I will send a patch shortly, I think it is going to be easy to backport
for you and test it.

-- 
Péter
