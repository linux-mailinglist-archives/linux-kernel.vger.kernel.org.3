Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3957756BBA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238426AbiGHOOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbiGHOOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:14:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3762714D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657289689; x=1688825689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mZw4zJhnWLu6q25nq6HwCIlugQZ35aroc8hQi8XIXbM=;
  b=MKWCoa6MdBYI4liHb2/1GvGiqBkd6/zcvbraJ1xtuyhXqTCyhHvw1If6
   cW/sTbfoISH2XrER51LitrtKYSLpElQ04L+LXcggvG4hHZSWu+7u839wG
   Rwd2YGxDf6hnuqnOspVNnF1NbCIODVWsuugRPPHA6/KGeiucwfXxs0KWQ
   8mGoO9iYO5BVOj5EKAJz2lOB2ktFPpYaafYfIhJqu9kkCG7Dg1uk27w6+
   WCgoIOUwUIg9MdTNJTWYseDaCQnHM6gvL63oftXnffl1DbL8nUVVgqObH
   xAGJghuNNMhmgJVEKf5uuarjurnvs1oZddU9rHVaXMKq5jxeTqkZCawzG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="264068714"
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="264068714"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:14:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,255,1650956400"; 
   d="scan'208";a="626714088"
Received: from gcisnero-mobl.amr.corp.intel.com (HELO [10.212.87.49]) ([10.212.87.49])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 07:14:47 -0700
Message-ID: <4fd78c53-2294-0f19-1551-39bafe87d94c@linux.intel.com>
Date:   Fri, 8 Jul 2022 09:11:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH v8 0/2] ASoC: Intel: sof_cs42l42: adding support for ADL
 configuration and BT offload
Content-Language: en-US
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        linux-kernel@vger.kernel.org, Rander Wang <rander.wang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Muralidhar Reddy <muralidhar.reddy@intel.com>,
        David Lin <CTLIN0@nuvoton.com>
References: <20220708110030.658468-1-brent.lu@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220708110030.658468-1-brent.lu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/22 06:00, Brent Lu wrote:
> 1. Add BT offload fetch to cs42l42 machine driver
> 2. Support cs42l42+max98360a on ADL platform
> 
> V8 Changes:
> - split the V7 patch into two patches; one for BT offload feature, the other for new board config
> - change topology name to sof-adl-max98360a-cs42l42.tplg
> - remove useless variable 'ret' in create_bt_offload_dai_links
> 
> Brent Lu (2):
>   ASoC: Intel: sof_cs42l42: support BT offload audio
>   ASoC: Intel: sof_cs42l42: add adl_mx98360a_cs4242 board config

LGTM, thanks Brent

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
