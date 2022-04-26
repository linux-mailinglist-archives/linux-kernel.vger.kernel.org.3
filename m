Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D22050EF02
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 05:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiDZDHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 23:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiDZDHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2126D389;
        Mon, 25 Apr 2022 20:04:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF3A961795;
        Tue, 26 Apr 2022 03:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D347C385A4;
        Tue, 26 Apr 2022 03:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650942276;
        bh=FHU3gz2xObNv4v3QdrY1AfApsJIy014Fc2X8Re1ythA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DdiccFTHNCalcLmOF0rUxN36iNX9dix6tqX8jGfvQjTgGarN8wBeOzMyQcLzCrChK
         0EBc0c+M87olpqdfm3JdzxQPo8dDIWkQ40NSU9Ty2gJXkucy+MEYgf5gjOB5GZTbvH
         Bw+b6/TG6PZp0X6J5qRQVIm0c7sPAghSqY9LD+gU4pZqhhuobXZV50hQj3JxnkSzK7
         JlmUKPXxgbiAg+4XFkgZkdMpt1QLWzKxQloNtsUFvRBG9/INS4HPCcuglYmLpKFLOp
         XBxgxNtBaEppo4wC20de++2jdxBXDOpL3P7GKJu2IB6MoU4H/sxon4mwWuXHIWF+Wb
         j7z1zg19t90Vg==
Date:   Tue, 26 Apr 2022 11:04:32 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
Message-ID: <YmdhQC6WN/kMnQfD@google.com>
References: <1650874932-18407-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650874932-18407-2-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650874932-18407-2-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:22:10PM +0800, Liu Xinpeng wrote:
>  #define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
> +#define WDAT_TIMEOUT_MIN     1
>  
>  /**
>   * struct wdat_instruction - Single ACPI WDAT instruction
> @@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	wdat->period = tbl->timer_period;
>  	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>  	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
> +	wdat->wdd.min_timeout = WDAT_TIMEOUT_MIN;
>  	wdat->stopped_in_sleep = tbl->flags & ACPI_WDAT_STOPPED;
>  	wdat->wdd.info = &wdat_wdt_info;
>  	wdat->wdd.ops = &wdat_wdt_ops;
> @@ -450,8 +452,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	 * watchdog properly after it has opened the device. In some cases
>  	 * the BIOS default is too short and causes immediate reboot.
>  	 */
> -	if (timeout * 1000 < wdat->wdd.min_hw_heartbeat_ms ||
> -	    timeout * 1000 > wdat->wdd.max_hw_heartbeat_ms) {
> +	if (watchdog_timeout_invalid(&wdat->wdd, timeout)) {

Probably lacking of the context, I failed to see why the checks are
equivalent.  Could you provide more information?
