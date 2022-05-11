Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408495234EE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiEKODH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244312AbiEKODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:03:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E51133
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652277783; x=1683813783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T8ct8MaxuAq9oRdiITvm+NoWseyVHyvo8hOAG6x7BvU=;
  b=XFyre/ztqqx0RqCCJ1C+9WzDdZkzCsMlSVzUeZqYD7KIcdMxL6Jmog46
   zVQFd98xzM144FzKyek08/v+nnGJnZcrZJEty4mC3yHucM+KE6G0KOMu+
   8/RPNHUhvaXdqLDnbaQDiXljl3nmSnSiJmdQsPAOO/LYFJInz2PMFGSEd
   6Ezsqrqlsf5KltDqvUQEMhHfpyENz/AIRAf/xLpW7/IFKN+TPZWxzXFGV
   5Q0xe+RaqvcPqTcLsM7b6enBrDxTz+BI5xiGoC/wncI+6xrehZM0oZmZy
   JzuEXj5PXQ2wFuFJ/xL45F0k8EPs2n673sGWRji0WwjQDLYrDnOIyP0xL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="267293026"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="267293026"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 07:03:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="658171262"
Received: from naydenov-mobl.amr.corp.intel.com (HELO [10.209.48.198]) ([10.209.48.198])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 07:02:59 -0700
Message-ID: <a71c4a2c-06f9-faa7-07ee-783ee7f136ec@linux.intel.com>
Date:   Wed, 11 May 2022 09:02:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] [v2] ASoC: Intel: sof_cs42l42: adding support for ADL
 configuration and BT offload audio
Content-Language: en-US
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>
Cc:     alsa-devel@alsa-project.org, cezary.rojewski@intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        brent.lu@intel.com, cujomalainey@chromium.org,
        Sean Paul <seanpaul@chromium.org>, casey.g.bowman@intel.com,
        Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>,
        vamshi.krishna.gopal@intel.com, Mac Chiang <mac.chiang@intel.com>,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20220510104829.1466968-1-terry_chen@wistron.corp-partner.google.com>
 <190c9add-7fa4-8e76-bfcb-43d30f22f8d9@linux.intel.com>
 <CAMmR3bFad5ODKYUCg8Tp8GVk__AdaQHcpLnRmFyAGXu8Wpycog@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAMmR3bFad5ODKYUCg8Tp8GVk__AdaQHcpLnRmFyAGXu8Wpycog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/22 01:33, Terry Chen wrote:
> Hi Pierre-Louis
> 
>> @@ -522,6 +578,14 @@ static struct snd_soc_dai_link *sof_card_dai_links_create(struct device *dev,
>>                               goto devm_err;
>>                       }
>>                       break;
>> +             case LINK_BT:
>> +                     ret = create_bt_offload_dai_links(dev, links, cpus, &id, ssp_bt);
>> +                     if (ret < 0) {
>> +                             dev_err(dev, "fail to create bt offload dai links, ret %d\n",
>> +                                     ret);
> 
> For this point, we just follow Intel member to write for this coding
> style. The other component also was the same style.

the magic of copy-paste, eh? Please update this, thanks.

>     > @@ -384,6 +384,14 @@ struct snd_soc_acpi_mach
>     snd_soc_acpi_intel_adl_machines[] = {
>     >               .sof_fw_filename = "sof-adl.ri",
>     >               .sof_tplg_filename = "sof-adl-cs35l41.tplg",
>     >       },
>     > +     {
>     > +             .id = "10134242",
>     > +             .drv_name = "adl_mx98360a_cs4242",
>     > +             .machine_quirk = snd_soc_acpi_codec_list,
>     > +             .quirk_data = &adl_max98360a_amp,
>     > +             .sof_fw_filename = "sof-adl.ri",
> 
>     This  also was the same style with others.

No, it's not a matter of style but rather that this field was *REMOVED*,
this cannot possibly compile.

see commit a6264056b39ee ("ASoC: soc-acpi: remove sof_fw_filename
")

If you had submitted this patch through the SOF tree, you would have
seen a compilation error.

> 
>     > +             .sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",
> 
>     Why would you refer to a topology that uses a different codec?
> 
> 
>  Because Intel college use the same naming style for the same audio codec.

It's bad practice to use the same topology name for different platforms
based on different codecs. One evolution of the topology would impact an
unrelated platform. Please use a symlink or duplicate the topology with
a different name, this is not future-proof and will be problematic for
releases.
