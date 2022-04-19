Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4D506D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349864AbiDSNKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDSNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:10:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9962B18B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650373681; x=1681909681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i7kopf3YArKvjboCT3liagNNqNzvCwqxIhyPrNCjFeU=;
  b=GEv7cr/ARIDonaJd/1WdnhStCep/zoCGWPoO645fbB//9UmGG8civ6bV
   ea57FHgJ6YcV2ds96k4y+5BXUKDpyBnez5RitzUD0C7N5ErYIErDe186E
   r7X52lC48fsPnY+xDIieZb4Xkwt0r//AjEcUBL4Uz/uorD8p69zKTNmhv
   LgkBKvE3QuW8C8b46dJT2EzYPEGzQO5pKZ5RRKs1ZzlND5jSwSdKUz9cd
   s7+n0t+3LKk7jhJXzCh6elJOWmfX9KOJ6nuHmVJcklgoKpbYoniAAk/HT
   HmXjA/NFbFdOz4kxJUN8U3+uJmF+g60Q+DPCnPsj8/4rgbGbsEgu5i1qv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262618207"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="262618207"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:08:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554720563"
Received: from kkho1-mobl3.amr.corp.intel.com (HELO [10.209.54.209]) ([10.209.54.209])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 06:07:59 -0700
Message-ID: <e31ff7c4-7cdc-fdaf-b12c-fc1e51798a1b@linux.intel.com>
Date:   Tue, 19 Apr 2022 08:07:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: out-of-bounds access in sound/soc/sof/topology.c
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        sound-open-firmware@alsa-project.org
References: <Ylk5o3EC/hyX5UQ0@google.com>
 <8eeb08ec-4836-cf7d-2285-8ed74ccfc1cb@linux.intel.com>
 <8986a1c6-b546-7a66-a778-048487624c95@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <8986a1c6-b546-7a66-a778-048487624c95@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 06:50, Péter Ujfalusi wrote:
> Hi Sergey, Pierre,
> 
> On 15/04/2022 19:00, Pierre-Louis Bossart wrote:
>> Thanks Sergey for this email.
>>
>> On 4/15/22 04:23, Sergey Senozhatsky wrote:
>>> Hi,
>>>
>>> I'm running 5.10.111 LTS, so if this has been fixed already then we definitely
>>> want to cherry pick the fix for -stable.
> 
> I'm afraid, that this is still valid as of today, but in real life I
> don't think it can happen.
> 
>>> Anonymous union in this struct is of zero size
>>>
>>> /* generic control data */
>>> struct sof_ipc_ctrl_data {
>>>         struct sof_ipc_reply rhdr;
>>>         uint32_t comp_id;
>>>
>>>         /* control access and data type */
>>>         uint32_t type;          /**< enum sof_ipc_ctrl_type */
>>>         uint32_t cmd;           /**< enum sof_ipc_ctrl_cmd */
>>>         uint32_t index;         /**< control index for comps > 1 control */
>>>
>>>         /* control data - can either be appended or DMAed from host */
>>>         struct sof_ipc_host_buffer buffer;
>>>         uint32_t num_elems;     /**< in array elems or bytes for data type */
>>>         uint32_t elems_remaining;       /**< elems remaining if sent in parts */
>>>
>>>         uint32_t msg_index;     /**< for large messages sent in parts */
>>>
>>>         /* reserved for future use */
>>>         uint32_t reserved[6];
>>>
>>>         /* control data - add new types if needed */
>>>         union {
>>>                 /* channel values can be used by volume type controls */
>>>                 struct sof_ipc_ctrl_value_chan chanv[0];
>>>                 /* component values used by routing controls like mux, mixer */
>>>                 struct sof_ipc_ctrl_value_comp compv[0];
>>>                 /* data can be used by binary controls */
>>>                 struct sof_abi_hdr data[0];
>>>         };
>>> } __packed;
>>>
>>> sof_ipc_ctrl_value_chan and sof_ipc_ctrl_value_comp are of the same
>>> size - 8 bytes, while sof_abi_hdr is much larger - _at least_ 32 bytes
>>> (`__u32 data[0]` in sof_abi_hdr suggest that there should be more
>>> payload after header). But they all contribute 0 to sizeof(sof_ipc_ctrl_data).
>>>
>>> Now control data allocations looks as follows
>>>
>>> 	scontrol->size = struct_size(scontrol->control_data, chanv,
>>> 				     le32_to_cpu(mc->num_channels));
>>> 	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);
>>>
>>> Which is sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)
>>>
>>> For some reason it uses sizeof(sof_ipc_ctrl_value_chan), which is not
>>> the largest member of the union.
>>>
>>> And this is where the problem is: in order to make control->data.FOO loads
>>> and stores legal we need mc->num_channels to be of at least 4. So that
>>>
>>>    sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)
>>>
>>>                 92           +        4         *            8
>>>
>>> will be the same as
>>>
>>>    sizeof(sof_ipc_ctrl_data) + sizeof(sof_abi_hdr).
>>>
>>>                 92           +           32
>>>
>>> Otherwise scontrol->control_data->data.FOO will access nearby/foreign
>>> slab object.
>>>
>>> And there is at least one such memory access. In sof_get_control_data().
>>>
>>> 	wdata[i].pdata = wdata[i].control->control_data->data;
>>> 	*size += wdata[i].pdata->size;
>>>
>>>
>>> pdata->size is at offset 8, but if, say, mc->num_channels == 1 then
>>> we allocate only 8 bytes for pdata, so pdata->size is 4 bytes outside
>>> of allocated slab object.
>>>
>>> Thoughts?
> 
> Your analyzes are spot on, unfortunately. But...
> 
> As of today, the sof_get_control_data() is in the call path of
> (ipc3-topology.c):
> 
> sof_widget_update_ipc_comp_process() -> sof_process_load() ->
> sof_get_control_data()
> 
> sof_widget_update_ipc_comp_process() is the ipc_setup callback for
> snd_soc_dapm_effect. If I'm not mistaken these only carries bin payload
> and never MIXER/ENUM/SWITCH/VOLUME.
> This means that the sof_get_control_data() is only called with
> SND_SOC_TPLG_TYPE_BYTES and for that the allocated data area is correct.
> 
> This can explain why we have not seen any issues so far. This does not
> renders the code right, as how it is written atm is wrong.


Sergey's results with KASAN show that there's a real-life problem though. I also don't understand how that might happen.

Could it be that these results are with a specific topology where our assumptions are incorrect?

