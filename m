Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC77C50F93E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345003AbiDZJrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbiDZJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:46:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686931E273D;
        Tue, 26 Apr 2022 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650963691; x=1682499691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q0wsFRNig3tKzog0D3raZMVGJ+/3YHHpj8P4YRAyqKQ=;
  b=hcfALOi1OxbEqdtodSz4m5R9e6waEV0VLZMmjdvPsvxf7zcHSVcHvyhy
   iAdnYI2Q8PKYJIVdMpNylWPai6sF6AwhFwaf6bS/RyeHjpijyHpgC/h4G
   vUe4aDfvliLmjSeNV41Ta2kOfoxKfttFxJNs0BvhixkcHm86jAsnocbBv
   oTkYu20JAQ2fmPhD6BmXnSUKOvul0RZ4x5cLCRcPklEQHM8EulI3yuX9z
   kyCIT5rXp//CaHst3zub7mqe3HCTEvrMYon69BH3y5a0lVnWUtPbidEGu
   WNxacuFqLlPcgHdBqswzznKBoM/yZRFB3a7DWtiXfZv6eA+LHfTZ8dNgk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325995819"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="325995819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:01:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579780688"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.209]) ([10.99.241.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:01:20 -0700
Message-ID: <9a1299a4-873c-b3f8-c7c7-6f3fcfee0d5f@linux.intel.com>
Date:   Tue, 26 Apr 2022 11:01:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220426183048.5f1cb899@canb.auug.org.au>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220426183048.5f1cb899@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2022 10:30 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> sound/soc/intel/avs/path.c: In function 'avs_copier_create':
> sound/soc/intel/avs/path.c:186:31: error: invalid use of undefined type 'struct nhlt_specific_cfg'
>    186 |                 data = ep_blob->caps;
>        |                               ^~
> sound/soc/intel/avs/path.c:187:36: error: invalid use of undefined type 'struct nhlt_specific_cfg'
>    187 |                 data_size = ep_blob->size;
>        |                                    ^~
> sound/soc/intel/avs/path.c:210:31: error: invalid use of undefined type 'struct nhlt_specific_cfg'
>    210 |                 data = ep_blob->caps;
>        |                               ^~
> sound/soc/intel/avs/path.c:211:36: error: invalid use of undefined type 'struct nhlt_specific_cfg'
>    211 |                 data_size = ep_blob->size;
>        |                                    ^~
> 
> Caused by commit
> 
>    274d79e51875 ("ASoC: Intel: avs: Configure modules according to their type")
> 
> I have applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 26 Apr 2022 17:49:37 +1000
> Subject: [PATCH] fixup for "ASoC: Intel: avs: Configure modules according to their type"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   sound/soc/intel/avs/path.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
> index 3d46dd5e5bc4..6f47ac44de87 100644
> --- a/sound/soc/intel/avs/path.c
> +++ b/sound/soc/intel/avs/path.c
> @@ -9,6 +9,7 @@
>   #include <sound/intel-nhlt.h>
>   #include <sound/pcm_params.h>
>   #include <sound/soc.h>
> +#include <sound/intel-nhlt.h>

This fix seems weird, as same include is 3 lines earlier?

>   #include "avs.h"
>   #include "path.h"
>   #include "topology.h"

