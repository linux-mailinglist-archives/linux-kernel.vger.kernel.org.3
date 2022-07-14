Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1A5750AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiGNOXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiGNOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:23:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801BB6555E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CRDY2exPjh1T2K9wEFk+/SJJqoS2n8ZJiSND6BQFZ2U=; b=Q/9iMrIZg4Kh9k8X7T0T6kPCUd
        KYcMe1EelV9E3SYrVnNeDPWn87SuQbhS2K++jXbeeWWwtZbHSAbQGWeyhighG19wB02wKmdZ/A9Yb
        Azg4xaIfmkOqLAm4FKPA6FQHVxFbvgYSTk9UDHtr6BLxSENrPTFzFgTfxNKU1/lZ0QV3pLDTPkBjv
        lqu4IX7KsVx36tWiVfV/PrIgdgj4+7NdvY0iDiPcQbfUpHu0RzRzv3+VRFOKVbvlbNjE8JT7LZ+Oz
        Cg+A0exp75CT6UgOPhHIPEzIlrh55mk1xrh39R90+DH0/HhhyMjM3tq3LJp9WH8cisFiv+YUEYd/6
        dG9D7HAg==;
Received: from [177.139.47.106] (helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oBzkU-00GSoU-H4; Thu, 14 Jul 2022 16:23:26 +0200
Message-ID: <120a8dc1-7e5c-85da-e087-10d21fedbf20@igalia.com>
Date:   Thu, 14 Jul 2022 11:23:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
Content-Language: en-US
To:     Matthieu CHARETTE <matthieu.charette@gmail.com>
Cc:     tzimmermann@suse.de, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <WKTLER.NFH5CX2O259Q@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <WKTLER.NFH5CX2O259Q@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

Thanks for your patch.

Às 11:58 de 06/07/22, Matthieu CHARETTE escreveu:
> Loading an EDID using drm.edid_firmware parameter makes resume to fail
> after firmware cache is being cleaned. This is because edid_load() use a
> temporary device to request the firmware. This cause the EDID firmware
> not to be cached from suspend. And, requesting the EDID firmware return
> an error during resume.
> So the request_firmware() call should use a permanent device for each
> connector. Also, we should cache the EDID even if no monitor is
> connected, in case it's plugged while suspended.
> 
> Signed-off-by: Matthieu CHARETTE <matthieu.charette@gmail.com>
> ---
> drivers/gpu/drm/drm_connector.c | 9 ++++
> drivers/gpu/drm/drm_edid_load.c | 81 ++++++++++++++++++++++++++++-----
> include/drm/drm_connector.h | 12 +++++
> include/drm/drm_edid.h | 3 ++
> 4 files changed, 94 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c
> b/drivers/gpu/drm/drm_connector.c
> index 1c48d162c77e..e8819ebf1c4b 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -31,6 +31,7 @@
> #include <drm/drm_privacy_screen_consumer.h>
> #include <drm/drm_sysfs.h>
> 
> +#include <linux/platform_device.h>
> #include <linux/uaccess.h>
> 
> #include "drm_crtc_internal.h"
> @@ -289,6 +290,9 @@ int drm_connector_init(struct drm_device *dev,
> 
>  drm_connector_get_cmdline_mode(connector);
> 
> + connector->edid_load_pdev = NULL;
> + drm_cache_edid_firmware(connector);
> +
>  /* We should add connectors at the end to avoid upsetting the connector
>   * index too much.
>   */
> @@ -473,6 +477,11 @@ void drm_connector_cleanup(struct drm_connector
> *connector)
>   connector->tile_group = NULL;
>  }
> 
> + if (connector->edid_load_pdev) {
> + platform_device_unregister(connector->edid_load_pdev);
> + connector->edid_load_pdev = NULL;
> + }
> +

The indentation of your patch is wrong in different places, like in this
if here. It should be like

+ if (connector->edid_load_pdev) {
+ 	platform_device_unregister(connector->edid_load_pdev);
+ 	connector->edid_load_pdev = NULL;
+ }

./scripts/checkpatch.pl can help you detect those issues for your v2

Thanks,
	André
