Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCF54EA13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378212AbiFPTXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378216AbiFPTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:23:30 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B6C563BF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 12:23:29 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 1v5RovI1qEhCQ1v5RofLi0; Thu, 16 Jun 2022 21:23:28 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 16 Jun 2022 21:23:28 +0200
X-ME-IP: 90.11.190.129
Message-ID: <29bce31d-f186-ae41-e154-e7451d185bae@wanadoo.fr>
Date:   Thu, 16 Jun 2022 21:23:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/connector: Remove usage of the deprecated
 ida_simple_xxx API
Content-Language: fr
To:     Bo Liu <liubo03@inspur.com>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220616051829.4071-1-liubo03@inspur.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220616051829.4071-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2022 à 07:18, Bo Liu a écrit :
> Use ida_alloc_xxx()/ida_free() instead of
> ida_simple_get()/ida_simple_remove().
> The latter is deprecated and more verbose.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>   drivers/gpu/drm/drm_connector.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 1c48d162c77e..e3484b115ae6 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -250,7 +250,7 @@ int drm_connector_init(struct drm_device *dev,
>   	connector->funcs = funcs;
>   
>   	/* connector index is used with 32bit bitmasks */
> -	ret = ida_simple_get(&config->connector_ida, 0, 32, GFP_KERNEL);
> +	ret = ida_alloc_max(&config->connector_ida, 31, GFP_KERNEL);
>   	if (ret < 0) {
>   		DRM_DEBUG_KMS("Failed to allocate %s connector index: %d\n",
>   			      drm_connector_enum_list[connector_type].name,
> @@ -262,7 +262,7 @@ int drm_connector_init(struct drm_device *dev,
>   
>   	connector->connector_type = connector_type;
>   	connector->connector_type_id =
> -		ida_simple_get(connector_ida, 1, 0, GFP_KERNEL);
> +		ida_alloc_min(connector_ida, 1, GFP_KERNEL);
>   	if (connector->connector_type_id < 0) {
>   		ret = connector->connector_type_id;
>   		goto out_put_id;
> @@ -322,10 +322,10 @@ int drm_connector_init(struct drm_device *dev,
>   	connector->debugfs_entry = NULL;
>   out_put_type_id:
>   	if (ret)
> -		ida_simple_remove(connector_ida, connector->connector_type_id);
> +		ida_free(connector_ida, connector->connector_type_id);
>   out_put_id:
>   	if (ret)
> -		ida_simple_remove(&config->connector_ida, connector->index);
> +		ida_free(&config->connector_ida, connector->index);
>   out_put:
>   	if (ret)
>   		drm_mode_object_unregister(dev, &connector->base);
> @@ -479,10 +479,10 @@ void drm_connector_cleanup(struct drm_connector *connector)
>   	list_for_each_entry_safe(mode, t, &connector->modes, head)
>   		drm_mode_remove(connector, mode);
>   
> -	ida_simple_remove(&drm_connector_enum_list[connector->connector_type].ida,
> +	ida_free(&drm_connector_enum_list[connector->connector_type].ida,
>   			  connector->connector_type_id);

Hi,

Nitpick: the code should be aligned with "&drm_connector_enum_list" now

>   
> -	ida_simple_remove(&dev->mode_config.connector_ida,
> +	ida_free(&dev->mode_config.connector_ida,
>   			  connector->index);

Same here, but I guess that it fits one one line now.

>   
>   	kfree(connector->display_info.bus_formats);

