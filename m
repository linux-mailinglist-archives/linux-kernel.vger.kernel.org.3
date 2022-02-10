Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0A4B10E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiBJOuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:50:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiBJOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:50:53 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C744EA1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644504654; x=1676040654;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=6RsubzXM+GzN9yvnRsU2F1Ujjq8hUfNBS47UtXZzmA8=;
  b=Q6PTdEtM3Y3KzB0oswCJReww5/sxvtVF9Lli07JWMUPLEavRNgI1nrL4
   PY6N0tAJWmD6cJ41zd4dEaYQN9ykooElhNinQLlEB6P182BZ1DPOTUy2S
   W8k45EaUIsQcH8cDWNEoWcSiQkE+lHEnGga6caFgf71iF0iY2VU1+zKYb
   jAUOZCS2zJncyWCuGAcfpoqXxIAg6+Fojl+x+88VI6eWcourHb1AK5nj9
   bpbQy0hAM9d5hfgk6qsKPQOwDokCTX3P5d/5tc7XOdXUBvXKWM2H6fBXw
   IBvByf90EQdhD8dSAEaN59pUhTgRuiJzaxkmgWv92MsjZV7Fn6sUvOw8q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="335921401"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="335921401"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:50:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="679167899"
Received: from barabano-mobl.ccr.corp.intel.com (HELO [10.252.41.18]) ([10.252.41.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 06:50:51 -0800
Message-ID: <9d1ed0e0-e69e-e725-b820-4a1c04ecdf4c@linux.intel.com>
Date:   Thu, 10 Feb 2022 16:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 9/9] ASoC: SOF: Convert the generic probe support to SOF
 client
Content-Language: en-US
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org,
        tiwai@suse.com, ranjani.sridharan@linux.intel.com,
        lgirdwood@gmail.com, fred.oh@linux.intel.com, daniel.baluta@nxp.com
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
 <20220210105519.19795-10-peter.ujfalusi@linux.intel.com>
 <YgUZKgPacRNrFk/e@sirena.org.uk>
 <cc1598d7-5029-197c-9abc-49043fdc11ed@linux.intel.com>
In-Reply-To: <cc1598d7-5029-197c-9abc-49043fdc11ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2022 16:41, Péter Ujfalusi wrote:
> 
> 
> On 10/02/2022 15:54, Mark Brown wrote:
>> On Thu, Feb 10, 2022 at 12:55:19PM +0200, Peter Ujfalusi wrote:
>>> Add a new client driver for probes support and move
>>> all the probes-related code from the core to the
>>> client driver.
>>
>> This breaks an x86 allmodconfig build:
>>
>> /mnt/kernel/sound/soc/sof/compress.c: In function 'create_page_table':
>> /mnt/kernel/sound/soc/sof/compress.c:87:9: error: implicit declaration of function 'snd_sof_create_page_table'; did you mean 'create_page_table'? [-Werror=implicit-function-declaration]
>>    87 |  return snd_sof_create_page_table(component->dev, dmab,
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>>       |         create_page_table
> 
> Interesting, we have this under constant builds for months and we
> certainly are building things as modules.
> 
> Let me check and fix this.

This patch never got reviewed in SOF:
ASoC: SOF: compr: Add compress ops implementation

and this introduced the use of snd_sof_create_page_table()

I don't sof-compress enabled, only imx and mediatek have it enabled.

Daniel, were there any reason to not send this to sof-dev prior?

-- 
Péter
