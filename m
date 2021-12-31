Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D37482393
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 12:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhLaLJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 06:09:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:39112 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhLaLJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 06:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640948960; x=1672484960;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=s6e0usEdmNX8PYb7FJZB0qWYjeLu2DtzLROFA90ONG0=;
  b=f0il+1+AGBae/+JvM+lFgS75yeWZY09S/lzixJh8N1NfgXv+1UAPNVKo
   6owSzoRgun5AT5bVfQ3mOlBBTCgYUTAIwfWPVf5WiGensNWFxPnX0bc0N
   BhaNe5unj106f8VQ/brO+7d5A8xqUKVyzl1x2yKRWX1Ik5JjR3TreUP8D
   +VaJkA7bgqfaunCO2iSQH+zPqYZhqUnKbGgY83ClFni2qa4hRDnCTNGEX
   Zro0+cDmE9/VmjA5325BeL41Srp4EtwmDe7XggXuGdiKCt52MoiatFQB8
   MnU1ahKCEKST6AE3ix8sifQYRw6xSiw60HmUA5l6Hj+Se8OCe6ZxNminv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="241600825"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="241600825"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 03:09:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="470925579"
Received: from arudakov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.25.42])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 03:09:16 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Bernard Zhao <bernard@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Subject: Re: [PATCH] gpu/drm: fix potential memleak in error branch
In-Reply-To: <20211116124751.31181-1-bernard@vivo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211116124751.31181-1-bernard@vivo.com>
Date:   Fri, 31 Dec 2021 13:09:13 +0200
Message-ID: <87zgohhvza.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021, Bernard Zhao <bernard@vivo.com> wrote:
> This patch try to fix potential memleak in error branch.

Please elaborate.

BR,
Jani.

>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index f3d79eda94bb..f73b180dee73 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -5501,7 +5501,10 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  				 int max_lane_count, int max_link_rate,
>  				 int conn_base_id)
>  {
> -	struct drm_dp_mst_topology_state *mst_state;
> +	struct drm_dp_mst_topology_state *mst_state = NULL;
> +
> +	mgr->payloads = NULL;
> +	mgr->proposed_vcpis = NULL;
>  
>  	mutex_init(&mgr->lock);
>  	mutex_init(&mgr->qlock);
> @@ -5523,7 +5526,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	 */
>  	mgr->delayed_destroy_wq = alloc_ordered_workqueue("drm_dp_mst_wq", 0);
>  	if (mgr->delayed_destroy_wq == NULL)
> -		return -ENOMEM;
> +		goto out;
>  
>  	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
>  	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
> @@ -5539,18 +5542,18 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	mgr->conn_base_id = conn_base_id;
>  	if (max_payloads + 1 > sizeof(mgr->payload_mask) * 8 ||
>  	    max_payloads + 1 > sizeof(mgr->vcpi_mask) * 8)
> -		return -EINVAL;
> +		goto failed;
>  	mgr->payloads = kcalloc(max_payloads, sizeof(struct drm_dp_payload), GFP_KERNEL);
>  	if (!mgr->payloads)
> -		return -ENOMEM;
> +		goto failed;
>  	mgr->proposed_vcpis = kcalloc(max_payloads, sizeof(struct drm_dp_vcpi *), GFP_KERNEL);
>  	if (!mgr->proposed_vcpis)
> -		return -ENOMEM;
> +		goto failed;
>  	set_bit(0, &mgr->payload_mask);
>  
>  	mst_state = kzalloc(sizeof(*mst_state), GFP_KERNEL);
>  	if (mst_state == NULL)
> -		return -ENOMEM;
> +		goto failed;
>  
>  	mst_state->total_avail_slots = 63;
>  	mst_state->start_slot = 1;
> @@ -5563,6 +5566,13 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  				    &drm_dp_mst_topology_state_funcs);
>  
>  	return 0;
> +
> +failed:
> +	kfree(mgr->proposed_vcpis);
> +	kfree(mgr->payloads);
> +	destroy_workqueue(mgr->delayed_destroy_wq);
> +out:
> +	return -ENOMEM;
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_init);

-- 
Jani Nikula, Intel Open Source Graphics Center
