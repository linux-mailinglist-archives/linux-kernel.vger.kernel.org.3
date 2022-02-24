Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F9D4C3043
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiBXPpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiBXPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:45:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723237EA02
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645717522; x=1677253522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9+DVXx/isU6uWI6/XyBC0Lnisob2NuO5FXAXMzKIKQQ=;
  b=WBsP2n9bNrkP9pFry6jEh1+v2K8hyyU9aGn2TAtmb5dYtcSu9RI2g0z6
   G09Yak9efLf04yCdoy3hZPJUyWxUwnZcsvREkFQt5/R03tB0kbFosqSwN
   bcK9CiFovVzEdV0DDqC1zCkz1u2UmnW4hoyjp2IWwQ5nMe7yC2BkMcdUc
   VRzoxEJgwhk5nXvlku6U8LypIq5UUC3JRrhjESiuQywkeMlCIDm1wt7A3
   yB3+MRPkDXjallKxxjCTNGuso/118aSgGES2/AK3+c9ov9J35XWe62cqV
   MhNgCz7WfsC0tbpfL94rkaQzu2xHRmi4Q1Kl7wKo9926BdTdAG7UiHpk9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239663581"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239663581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:45:04 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533178468"
Received: from ronakmeh-mobl1.amr.corp.intel.com (HELO [10.212.97.131]) ([10.212.97.131])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:45:04 -0800
Message-ID: <522ab282-ecc2-4186-2d77-f6241e255109@linux.intel.com>
Date:   Thu, 24 Feb 2022 09:29:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2 14/16] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com
References: <20220224111718.6264-1-srinivas.kandagatla@linaro.org>
 <20220224111718.6264-15-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220224111718.6264-15-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/22 05:17, Srinivas Kandagatla wrote:
> WSA881x codecs can not cope up with clk stop and requires a full reset after suspend.
> WSA SoundWire Controller connected to this instances do a full soft reset on suspend.

is it the manager or peripheral that cannot cope with clock stop?

> @@ -1124,6 +1136,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>  	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
>  	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
>  	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
> +	pdev->prop.simple_clk_stop_capable = true;

here it's pretty clear the peripheral is capable of supporting clock
stop, no?

Something's not clear between the commit message and the code.
