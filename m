Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210B53B42A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiFBHLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiFBHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:11:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76DC5DBCF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654153878; x=1685689878;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=fpjlwrOa7aHxyExEPvIZqTy3mwVCJEL8+LMJCa+H2mk=;
  b=YQXfmWn22qw7fWTYJV+Lcpf1cNvipzreDq2IFSM1w7t4daQhFEINol0B
   0KlgFqkpr1r9kTF7e8V0mrzgaLM0gJeNm/Cv8H46YXX1GnNjuYu7DjF2D
   lpIiNhmEabq86tiZ/7l8DqH3XbVfBHWNwxv3C1zFPM3hpq/e9jt1+84/B
   89i2Bdqrk1KxlQvaom7buVbGR1xBHWEUVVYIIF2jIbXaScyT3BnBXO+NB
   DfToFuJK18k1IG1zECWFj4KIZhhUsloebelfYVEWC1I/n49p4IW1vFsPN
   yUNjU6t9rUZrt98mpnx/RrcAvnG8Q1i/IhFl9+xXu0kZ5I3RcFanXhvcs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="301215193"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="301215193"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:11:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="577366751"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.13.51]) ([10.213.13.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 00:11:13 -0700
Message-ID: <ba8d5d00-0ef7-6133-e609-7942cdbd7c84@intel.com>
Date:   Thu, 2 Jun 2022 09:11:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH] drm/mipi-dsi: Fix error handling in
 mipi_dsi_device_register_full
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220601124024.10137-1-linmq006@gmail.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20220601124024.10137-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01.06.2022 14:40, Miaoqian Lin wrote:
> In mipi_dsi_device_alloc(), it calls device_initialize(&dsi->dev);
> We need to use put_device() instead freeing directly.
>
> Fixes: 068a002 ("drm: Add MIPI DSI bus support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Looks correct.
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej

> ---
>   drivers/gpu/drm/drm_mipi_dsi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index c40bde96cfdf..8cc8deca006f 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -228,7 +228,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>   	ret = mipi_dsi_device_add(dsi);
>   	if (ret) {
>   		drm_err(host, "failed to add DSI device %d\n", ret);
> -		kfree(dsi);
> +		put_device(&dsi->dev);
>   		return ERR_PTR(ret);
>   	}
>   

