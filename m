Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E90A582801
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbiG0NxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiG0NxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:53:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D422731908
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:53:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l22so2767830wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=Y58cmTeSEpbZmMj/8Am5lc7mvV2jG//V1Yk3jLMgpT8=;
        b=IIVvUktd+fhAMVppDEl6ROygiaCPpbrIUIinZRcIYpE6cQOyzyUCPyYfT3yz5oV7XJ
         47odIOsNAdPNjD7e71EBcIADeqe+aXd45xYyG2ZAlgrYuROk/lGeJMq6xjA9wkVjy+Di
         uXVnCo1KrRYszv79U1ZEUnDyc4KF+m32O1juCrIABuzr9nMYh8ErUFyNSBXGFgnTHKnZ
         T6YKqqjOeq3sKQcUoRKvCASQTN5nlpr6sbJskHwV91O6QpcWrQI8XIK8cuXj9PNjZ77Y
         O7MK00w6zmtHEiYLiK2T/Q1q4a21EqDTluA6iiN8sxEMtepDwAl0DrFTXOBFFWedqppS
         cKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=Y58cmTeSEpbZmMj/8Am5lc7mvV2jG//V1Yk3jLMgpT8=;
        b=NDlT/GLP4SMfMK7TD9rKGmuEaCkwGt1PIcHKLk3JhmBisvGEN/hm2cHJU2LibrgeNn
         4DzOMrPKWpvLCsWbww9d+mP5n2lKwL/fR2VspQF5jnxm3bcCHizMFn8vj2YH+RPFYkDN
         d3+9J77Gh0Rh9uyhRoAkjkS71Q72r3SeNEWppE53d1JJyT9ZG0PIOvcU1w0aNGbc+BhQ
         gjtsJxOODnu/+L1xP5Bq4AFyGucuWDwpamiQuFceWeVWHn4nbmciJgkjJxQHocYK3+Rg
         GkPDEBu3+p9O2qCZV6dkc9Tg2s1E2QXd5dTO3Kx8POj3Fw5CeOr9ROFVWOeMZqiCTz9J
         zZUQ==
X-Gm-Message-State: AJIora8GDiEwQrE6wVpE9oDRnnirEujJVLnmsXhJVmkBpACtMJKDGIrq
        5z3RiOt115jy+vgTm/q6ILE=
X-Google-Smtp-Source: AGRyM1sQGRlADJbklhkMNmJxREv3YCvcgKpLZeDcEt+a1MozhnbsXlRP0tAMoMJEyjBYdE9xnGeaeQ==
X-Received: by 2002:a05:600c:154a:b0:3a3:2fae:9bae with SMTP id f10-20020a05600c154a00b003a32fae9baemr3310629wmg.23.1658929990250;
        Wed, 27 Jul 2022 06:53:10 -0700 (PDT)
Received: from fedora ([2a01:e0a:1d2:1f90:be95:f3a2:4d99:a3b3])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0039db31f6372sm2741040wmq.2.2022.07.27.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:53:09 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:53:02 +0200
From:   Matthieu CHARETTE <matthieu.charette@gmail.com>
Subject: Re: [PATCH] drm: Fix EDID firmware load on resume
To:     Takashi Iwai <tiwai@suse.de>
Cc:     lkp@intel.com, airlied@linux.ie, andrealmeid@igalia.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Message-Id: <EKMOFR.QQ59KBZUHAHY2@gmail.com>
In-Reply-To: <875yjjotnb.wl-tiwai@suse.de>
References: <202207172035.mtErdlaw-lkp@intel.com>
        <20220727074152.43059-1-matthieu.charette@gmail.com>
        <875yjjotnb.wl-tiwai@suse.de>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Caching the EDID via the firmware API makes the kernel able to reclaim 
the memory in case it's needed. And eventually, the kernel will load it 
again before suspending.
But for 128 bytes, even if we have many monitors it will not make any 
difference.
I don't know if storing a platform device can take more memory than 128 
bytes of data.
I let you decide which option is better. Just tell me if I should cache 
the bytes instead.

Thanks.

Matthieu

On Wed, Jul 27 2022 at 10:18:48 AM +0200, Takashi Iwai <tiwai@suse.de> 
wrote:
> On Wed, 27 Jul 2022 09:41:52 +0200,
> Matthieu CHARETTE wrote:
>> 
>>  Loading an EDID using drm.edid_firmware parameter makes resume to 
>> fail
>>  after firmware cache is being cleaned. This is because edid_load() 
>> use a
>>  temporary device to request the firmware. This cause the EDID 
>> firmware
>>  not to be cached from suspend. And, requesting the EDID firmware 
>> return
>>  an error during resume.
>>  So the request_firmware() call should use a permanent device for 
>> each
>>  connector. Also, we should cache the EDID even if no monitor is
>>  connected, in case it's plugged while suspended.
>> 
>>  Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2061
>>  Signed-off-by: Matthieu CHARETTE <matthieu.charette@gmail.com>
> 
> Can we simply cache the already loaded EDID bytes instead?
> Something like below (totally untested).
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> diff --git a/drivers/gpu/drm/drm_connector.c 
> b/drivers/gpu/drm/drm_connector.c
> index 1c48d162c77e..b9d2803b518b 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -286,6 +286,7 @@ int drm_connector_init(struct drm_device *dev,
>  	connector->status = connector_status_unknown;
>  	connector->display_info.panel_orientation =
>  		DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +	connector->firmware_edid = NULL;
> 
>  	drm_connector_get_cmdline_mode(connector);
> 
> @@ -485,6 +486,7 @@ void drm_connector_cleanup(struct drm_connector 
> *connector)
>  	ida_simple_remove(&dev->mode_config.connector_ida,
>  			  connector->index);
> 
> +	kfree(connector->firmware_edid);
>  	kfree(connector->display_info.bus_formats);
>  	drm_mode_object_unregister(dev, &connector->base);
>  	kfree(connector->name);
> diff --git a/drivers/gpu/drm/drm_edid_load.c 
> b/drivers/gpu/drm/drm_edid_load.c
> index 37d8ba3ddb46..a38fe4e00e4a 100644
> --- a/drivers/gpu/drm/drm_edid_load.c
> +++ b/drivers/gpu/drm/drm_edid_load.c
> @@ -253,6 +253,13 @@ static void *edid_load(struct drm_connector 
> *connector, const char *name,
>  			edid = new_edid;
>  	}
> 
> +	connector->firmware_edid = drm_edid_duplicate((struct edid *)edid);
> +	if (!connector->firmware_edid) {
> +		kfree(edid);
> +		edid = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}
> +
>  	DRM_INFO("Got %s EDID base block and %d extension%s from "
>  	    "\"%s\" for connector \"%s\"\n", (builtin >= 0) ? "built-in" :
>  	    "external", valid_extensions, valid_extensions == 1 ? "" : "s",
> @@ -269,6 +276,12 @@ struct edid *drm_load_edid_firmware(struct 
> drm_connector *connector)
>  	char *edidname, *last, *colon, *fwstr, *edidstr, *fallback = NULL;
>  	struct edid *edid;
> 
> +	/* already loaded? */
> +	if (connector->firmware_edid) {
> +		edid = drm_edid_duplicate(connector->firmware_edid);
> +		return edid ? edid : ERR_PTR(-ENOMEM);
> +	}
> +
>  	if (edid_firmware[0] == '\0')
>  		return ERR_PTR(-ENOENT);
> 
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 3ac4bf87f257..b5d0c87327a3 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1528,6 +1528,8 @@ struct drm_connector {
>  	enum drm_connector_force force;
>  	/** @override_edid: has the EDID been overwritten through debugfs 
> for testing? */
>  	bool override_edid;
> +	/** @firmware_edid: the cached firmware EDID bytes */
> +	struct edid *firmware_edid;
>  	/** @epoch_counter: used to detect any other changes in connector, 
> besides status */
>  	u64 epoch_counter;
> 


