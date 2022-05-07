Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10351E4AD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445680AbiEGGuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350941AbiEGGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:50:04 -0400
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 23:46:17 PDT
Received: from mail-m17669.qiye.163.com (mail-m17669.qiye.163.com [59.111.176.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784B5A2CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:46:17 -0700 (PDT)
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m17669.qiye.163.com (Hmail) with ESMTPA id 363254600F5;
        Sat,  7 May 2022 14:39:26 +0800 (CST)
Message-ID: <45058759-13dd-aa43-ac88-2a7c60baa22b@rock-chips.com>
Date:   Sat, 7 May 2022 14:39:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] drm/rockchip: Fix Kconfig dependencies
Content-Language: en-US
To:     Ren Zhijie <renzhijie2@huawei.com>, hjc@rock-chips.com,
        heiko@sntech.de, airlied@linux.ie, daniel@ffwll.ch,
        lyude@redhat.com, tzimmermann@suse.de
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220507010039.117310-1-renzhijie2@huawei.com>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20220507010039.117310-1-renzhijie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWRlKQklWS0NLHRlCQk
        4eHkoYVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nk06Izo6LD0rDA1PPzEtPgkU
        LCwwCT5VSlVKTU5KQktOTk1NQ0pKVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSE5PSjcG
X-HM-Tid: 0a809d3e971dda59kuws363254600f5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhijie:

On 5/7/22 09:00, Ren Zhijie wrote:
> If CONFIG_ROCKCHIP_ANALOGIX_DP is not set, the rockchip drm driver
> will fail to link:
>
> drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_connector_mode_valid':
> cdn-dp-core.c:(.text+0x1e1): undefined reference to `drm_dp_bw_code_to_link_rate'
> cdn-dp-core.c:(.text+0x1f4): undefined reference to `drm_dp_bw_code_to_link_rate'
> drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_pd_event_work':
> cdn-dp-core.c:(.text+0x138e): undefined reference to `drm_dp_channel_eq_ok'
> drivers/gpu/drm/rockchip/cdn-dp-reg.o: In function `cdn_dp_train_link':
> cdn-dp-reg.c:(.text+0xd5a): undefined reference to `drm_dp_bw_code_to_link_rate'
>
> The problem is that the DP-helper module has been replaced by the display-helper module.
> So the driver have to select it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1e0f66420b13("drm/display: Introduce a DRM display-helper module")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>   drivers/gpu/drm/rockchip/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 5afab49dc4f2..eb9ffa9e357d 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -47,6 +47,8 @@ config ROCKCHIP_ANALOGIX_DP
>   config ROCKCHIP_CDN_DP
>   	bool "Rockchip cdn DP"
>   	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
> +	select DRM_DISPLAY_HELPER
> +	select DRM_DISPLAY_DP_HELPER


There are two dp(ANALOGIX_DP and CDN_DP) at rockchip drm mainline,

for a totally cleanup and alignment, I think it's better to remove 
"select DRM_DISPLAY_HELPER if ROCKCHIP_ANALOGIX_DP" under DRM_ROCKCHIP  
at the head,

and separately add the select for ROCKCHIP_ANALOGIX_DP and ROCKCHIP_CDN_DP.

>   	help
>   	  This selects support for Rockchip SoC specific extensions
>   	  for the cdn DP driver. If you want to enable Dp on
