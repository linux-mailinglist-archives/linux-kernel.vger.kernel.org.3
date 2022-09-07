Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E170E5AFCFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiIGHAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIGHAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:00:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1831D32D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:59:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so18298017edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 23:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=qvR1N7BkwDYnsAvrsfaIO11nwQpKCU3X2O+a+Y27DUY=;
        b=JboZiw5UMpW3fLQ7FupCjwd6aK+mUdgjr5hh3TDItIM8ud3MPqItdIZvSBy6At4SrH
         PwHoYA4AU7ZjeZqaYWaA3JMJIRefSwml0t4qwc+ktxSSMu3EjO0DighbDKTn3xqOODKU
         8aA5FL4HALl1QQW2k4T0rKr+B9yknpX5DSbnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qvR1N7BkwDYnsAvrsfaIO11nwQpKCU3X2O+a+Y27DUY=;
        b=JpwodBy9AdpQf+oupVgHjCCcT0swqNAZ1f78FWuih+BarGeKyd9U+LnTtu2VfqOw2X
         BwjNepQq2fQf/t37yMFRZGOo4PLVIYhxLKzCxTHof/OWE4/jRreJETk2AGvHoagQILis
         D2B5nE6c5WQf9XRIxVwKHGbkxBgN22CGGMZvZDvIPq3x6FN2B/5NYy4XvPmzRhmz1D48
         a6sltRpMvi2TzemPZ6o8BYDJESDKjFl8lQpIsVeve423ro5JxEKSqJUNGzhU+TDJB6G4
         YqQ/DBBW4pYgScMAufx8/oREp/6H8LYnm9g9axLd7Jg1FH015xyZV/oQ+CGU6EryAp61
         UPxw==
X-Gm-Message-State: ACgBeo1Mug8pJZ7qcFFWg+4zl3daR2xcIoMr9pLUiv6Vk8UeX5INtT4H
        rS0JOxCqtmr6NAx9I7Nsq8Rqpw==
X-Google-Smtp-Source: AA6agR5JW86JYwYYzN91pflVev5axL6S1Bv3lsKRf4XqvatlwpwQmUIlpWFZiPfqhA85TeaL1Xn6kg==
X-Received: by 2002:a05:6402:5cd:b0:446:5965:f4af with SMTP id n13-20020a05640205cd00b004465965f4afmr1916771edx.12.1662533990421;
        Tue, 06 Sep 2022 23:59:50 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b007081282cbd8sm7824571ejv.76.2022.09.06.23.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:59:49 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:59:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
Subject: Re: [PATCH v6 39/57] dyndbg/drm: POC add tracebits sysfs-knob
Message-ID: <YxhBZLAasKaBPEDT@phenom.ffwll.local>
Mail-Followup-To: Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com
References: <20220904214134.408619-1-jim.cromie@gmail.com>
 <20220904214134.408619-40-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904214134.408619-40-jim.cromie@gmail.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 03:41:16PM -0600, Jim Cromie wrote:
> clone DRM.debug interface to DRM.tracebits: ie map bits to
> drm-debug-categories, except this interface enables messages to
> tracefs, not to syslog.
> 
> 1- we reuse the class-map added previously.
>    this reflects the single source of both syslog/trace events
> 
> 2- add a 2nd struct ddebug_classes_bitmap_param
>    refs 1, reusing it.
>    flags = "T", to enable trace-events on this callsite.
> 
> 3- module_param_cb([2]) - does the sysfs part
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

All the drm patches (excluding nouveau) I haven't commented on:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I think nouveau I'll leave up to nouveau folks.
-Daniel



> ---
>  drivers/gpu/drm/drm_print.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index c50edbf443d3..75d0cecd7e86 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -45,6 +45,9 @@
>  unsigned long __drm_debug;
>  EXPORT_SYMBOL(__drm_debug);
>  
> +unsigned long __drm_trace;
> +EXPORT_SYMBOL(__drm_trace);
> +
>  MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
>  "\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
>  "\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
> @@ -77,6 +80,13 @@ static struct ddebug_class_param drm_debug_bitmap = {
>  	.map = &drm_debug_classes,
>  };
>  module_param_cb(debug, &param_ops_dyndbg_classes, &drm_debug_bitmap, 0600);
> +
> +static struct ddebug_class_param drm_trace_bitmap = {
> +	.bits = &__drm_trace,
> +	.flags = "T",
> +	.map = &drm_debug_classes,
> +};
> +module_param_cb(tracecats, &param_ops_dyndbg_classes, &drm_trace_bitmap, 0600);
>  #endif
>  
>  void __drm_puts_coredump(struct drm_printer *p, const char *str)
> -- 
> 2.37.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
