Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB31356B331
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiGHHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbiGHHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:14:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B277696F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:14:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d16so22956029wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=x34qz42FhihvfQoObpe4CSiQ433WQDwHGcj+lPAh2xE=;
        b=Yo1X6Mk6V8WG/TSpNgICV30gnWIohihphaEfdxX/s4FFU8XuVJj45qtbGbNw9b4Jpj
         a2C9PlPzDHk/VHFOl8rmQyVxw0H6RhLixiOHC/xrYoSFdoA/iU0/JSeLrA3RyDSNOiMv
         gSqsQPK89yCnuEVzgXOBo8pfkEaNu4BUK54AKaUinSG3rZc1BHtB162EDVdp8WBhv8Ux
         +KuGRHghZ9gNa9t+AkDlanErlj5wXoHWKADwtl76kQR1SMinaSKid7kS4QNmiNMJoYlw
         HopWa/CL25UYoAKfatGwONxhdNxUiOqTq6eW7lXXv4E/frS//FoPZo6tyLz0x/9YufVT
         YhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=x34qz42FhihvfQoObpe4CSiQ433WQDwHGcj+lPAh2xE=;
        b=R9Mxt5tMopba3pWYjoc8isprhtYI68gynIFzXra1Li+MMdeD1zRqSsdDEhN++PKosZ
         eckQD7BNyfrBbZRItznlRdXbngujmbAHiGz3A/bVlx8clFvLw4CrXfm6rpuh3fyPRYO9
         3dxoV9cFr14xIoBelBk3IXoQQ0gvHoSHzu4XmC4cyFc6RpdaEnTBhqrQRqMbNxioHQPU
         j5gPdYypiqivo5ylhjYZHNBgJso9w7wyOty314yGR+ZmIKKRupCX/JK7a1r8y+6VO5R6
         yjvSX4Wzd4YQMytxthPuq3wyjn0ah1GzNXDNzxsTf96CzU/TaTB92N20NqtinkPQvTrM
         NAXw==
X-Gm-Message-State: AJIora8NdMdB3TtU3nLBrUcoKb827by368CGBg2W+ORN0GlPEiODr9PF
        ny2NoWTr3yeQPvpnohxnamUxx1qxSGghMA==
X-Google-Smtp-Source: AGRyM1sVHVhR2XTxqKOcFDGLYufO6TJ1vKE+U9Lt+CvqwBNmSICA1WmKF6cu+bIC8AQKle88Ph36NQ==
X-Received: by 2002:a5d:4c85:0:b0:21d:6eed:bcf6 with SMTP id z5-20020a5d4c85000000b0021d6eedbcf6mr1807225wrs.352.1657264446784;
        Fri, 08 Jul 2022 00:14:06 -0700 (PDT)
Received: from fedora ([2a01:e0a:1d2:1f90:be95:f3a2:4d99:a3b3])
        by smtp.gmail.com with ESMTPSA id p18-20020a1c7412000000b003973435c517sm1224988wmc.0.2022.07.08.00.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 00:14:06 -0700 (PDT)
Date:   Fri, 08 Jul 2022 09:14:00 +0200
From:   Matthieu CHARETTE <matthieu.charette@gmail.com>
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
To:     matthieu.charette@gmail.com
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <CFXOER.OW6JFDCNUAT32@gmail.com>
In-Reply-To: <WKTLER.NFH5CX2O259Q@gmail.com>
References: <WKTLER.NFH5CX2O259Q@gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I forgot to add a tag.
---
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2061

On Wed, Jul 6 2022 at 04:58:08 PM +0200, Matthieu CHARETTE 
<matthieu.charette@gmail.com> wrote:
> Loading an EDID using drm.edid_firmware parameter makes resume to fail
> after firmware cache is being cleaned. This is because edid_load() 
> use a
> temporary device to request the firmware. This cause the EDID firmware
> not to be cached from suspend. And, requesting the EDID firmware 
> return
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
>  drm_connector_get_cmdline_mode(connector);
> 
> + connector->edid_load_pdev = NULL;
> + drm_cache_edid_firmware(connector);
> +
>  /* We should add connectors at the end to avoid upsetting the 
> connector
>   * index too much.
>   */
> @@ -473,6 +477,11 @@ void drm_connector_cleanup(struct drm_connector 
> *connector)
>   connector->tile_group = NULL;
>  }
> 
> + if (connector->edid_load_pdev) {
> + platform_device_unregister(connector->edid_load_pdev);
> + connector->edid_load_pdev = NULL;
> + }
> +
>  list_for_each_entry_safe(mode, t, &connector->probed_modes, head)
>   drm_mode_remove(connector, mode);
> 
> diff --git a/drivers/gpu/drm/drm_edid_load.c 
> b/drivers/gpu/drm/drm_edid_load.c
> index 37d8ba3ddb46..5a82be9917ec 100644
> --- a/drivers/gpu/drm/drm_edid_load.c
> +++ b/drivers/gpu/drm/drm_edid_load.c
> @@ -167,6 +167,19 @@ static int edid_size(const u8 *edid, int 
> data_size)
>  return (edid[0x7e] + 1) * EDID_LENGTH;
> }
> 
> +static struct platform_device *edid_pdev(const char *connector_name)
> +{
> + struct platform_device *pdev = 
> platform_device_register_simple(connector_name, -1, NULL, 0);
> +
> + if (IS_ERR(pdev)) {
> + DRM_ERROR("Failed to register EDID firmware platform device "
> + "for connector \"%s\"\n", connector_name);
> + return ERR_CAST(pdev);
> + }
> +
> + return pdev;
> +}
> +
> static void *edid_load(struct drm_connector *connector, const char 
> *name,
>    const char *connector_name)
> {
> @@ -182,18 +195,17 @@ static void *edid_load(struct drm_connector 
> *connector, const char *name,
>   fwdata = generic_edid[builtin];
>   fwsize = sizeof(generic_edid[builtin]);
>  } else {
> - struct platform_device *pdev;
> + struct platform_device *pdev = connector->edid_load_pdev;
>   int err;
> 
> - pdev = platform_device_register_simple(connector_name, -1, NULL, 0);
> - if (IS_ERR(pdev)) {
> - DRM_ERROR("Failed to register EDID firmware platform device "
> - "for connector \"%s\"\n", connector_name);
> - return ERR_CAST(pdev);
> + if (WARN_ON(!pdev)) {
> + pdev = edid_pdev(connector_name);
> + if (IS_ERR(pdev))
> + return ERR_CAST(pdev);
> + connector->edid_load_pdev = pdev;
>   }
> 
>   err = request_firmware(&fw, name, &pdev->dev);
> - platform_device_unregister(pdev);
>   if (err) {
>    DRM_ERROR("Requesting EDID firmware \"%s\" failed (err=%d)\n",
>       name, err);
> @@ -263,11 +275,9 @@ static void *edid_load(struct drm_connector 
> *connector, const char *name,
>  return edid;
> }
> 
> -struct edid *drm_load_edid_firmware(struct drm_connector *connector)
> +static char *edid_name(const char *connector_name)
> {
> - const char *connector_name = connector->name;
>  char *edidname, *last, *colon, *fwstr, *edidstr, *fallback = NULL;
> - struct edid *edid;
> 
>  if (edid_firmware[0] == '\0')
>   return ERR_PTR(-ENOENT);
> @@ -310,8 +320,57 @@ struct edid *drm_load_edid_firmware(struct 
> drm_connector *connector)
>  if (*last == '\n')
>   *last = '\0';
> 
> - edid = edid_load(connector, edidname, connector_name);
> + edidname = kstrdup(edidname, GFP_KERNEL);
> + if (!edidname) {
> + kfree(fwstr);
> + return ERR_PTR(-ENOMEM);
> + }
> +
>  kfree(fwstr);
> + return edidname;
> +}
> +
> +void drm_cache_edid_firmware(struct drm_connector *connector)
> +{
> + const char *connector_name = connector->name;
> + const char *edidname = edid_name(connector_name);
> + struct platform_device *pdev;
> + int err;
> +
> + if (IS_ERR(edidname))
> + return;
> +
> + if (match_string(generic_edid_name, GENERIC_EDIDS, edidname) >= 0) {
> + kfree(edidname);
> + return;
> + }
> +
> + pdev = edid_pdev(connector_name);
> + if (IS_ERR(pdev)) {
> + kfree(edidname);
> + return;
> + }
> + connector->edid_load_pdev = pdev;
> +
> + err = firmware_request_cache(&pdev->dev, edidname);
> + if (err)
> + DRM_ERROR("Requesting EDID firmware cache \"%s\" failed (err=%d)\n",
> + edidname, err);
> +
> + kfree(edidname);
> +}
> +
> +struct edid *drm_load_edid_firmware(struct drm_connector *connector)
> +{
> + const char *connector_name = connector->name;
> + const char *edidname = edid_name(connector_name);
> + struct edid *edid;
> +
> + if (IS_ERR(edidname))
> + return ERR_CAST(edidname);
> +
> + edid = edid_load(connector, edidname, connector_name);
> + kfree(edidname);
> 
>  return edid;
> }
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 3ac4bf87f257..47c84741517e 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1573,6 +1573,18 @@ struct drm_connector {
>   */
>  struct i2c_adapter *ddc;
> 
> + /**
> + * @edid_load_pdev: Platform device for loading EDID via firmware.
> + *
> + * The platform device is registered in drm_connector_init() in case 
> a
> + * custom EDID firmware is used with `edid_firmware` parameter. 
> Otherwise,
> + * it is set to NULL.
> + *
> + * Platform device is unregistered in drm_connector_cleanup() if it
> + * is not NULL.
> + */
> + struct platform_device *edid_load_pdev;
> +
>  /**
>   * @null_edid_counter: track sinks that give us all zeros for the 
> EDID.
>   * Needed to workaround some HW bugs where we get all 0s
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index b2756753370b..b54cea3f1107 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -378,10 +378,13 @@ int drm_av_sync_delay(struct drm_connector 
> *connector,
>         const struct drm_display_mode *mode);
> 
> #ifdef CONFIG_DRM_LOAD_EDID_FIRMWARE
> +void drm_cache_edid_firmware(struct drm_connector *connector);
> struct edid *drm_load_edid_firmware(struct drm_connector *connector);
> int __drm_set_edid_firmware_path(const char *path);
> int __drm_get_edid_firmware_path(char *buf, size_t bufsize);
> #else
> +static inline void
> +drm_cache_edid_firmware(struct drm_connector *connector);
> static inline struct edid *
> drm_load_edid_firmware(struct drm_connector *connector)
> {
> --
> 2.36.1
> 
> 
> 


