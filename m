Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891E150F0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiDZGNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244905AbiDZGNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:13:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1778A1BC;
        Mon, 25 Apr 2022 23:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30927612C8;
        Tue, 26 Apr 2022 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A1C385A4;
        Tue, 26 Apr 2022 06:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953421;
        bh=XcR2Lx8r+iZ0vMl4j7K1aWlg1o1EJvZBycJ5g10yOcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+YHoCIuUxRQaJjd/Qc8crcdrfKMgDNbx/62zPKofMXlFg+M+ebRwgyOVZXh8OPh6
         RsLT3GGv3aejsHQmNtwNEpnQyrBMPGFD0/G8MeNBJDlmV31i2DjNEF3lRgwB39oW0z
         sCD7u9hZlp9P0c83kVhGqvBVoO1Vjdj6vMP7fMzfWCaobK3vBQE1XvmR/gfKD9ysCd
         u/bt9aLlTMbRF6xknCoKZJW9IGTCiXex/d0HEmGA15k71aRNSpz6eBCetERqdLNYC5
         cvj6gzBMVlUjbIRjT3VfPA2fS652kkiYp1Db+s9YBDZBX7d+kvlrI+tud4ac3iaAsh
         AoczGxFaswpLg==
Date:   Tue, 26 Apr 2022 14:10:18 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] watchdog: wdat_wdg: Using the existed function to
 check parameter timeout
Message-ID: <YmeMyqNqnooVifz1@google.com>
References: <1650944120-30954-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650944120-30954-2-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1650944120-30954-2-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:35:17AM +0800, Liu Xinpeng wrote:
> The module arguement timeout is a configured timeout value.
> “separate minimum and maximum HW timeouts and configured timeout value.”
> (patch v1 is explained by Guenter Roeck)
> 
> So using watchdog_timeout_invalid to check timeout invalid is more justified.

The v3 commit message doesn't help too much for understanding the patch.  You
could see [1] for some reference sentences.  See also [2].

[1]: https://patchwork.kernel.org/project/linux-watchdog/patch/1650874932-18407-2-git-send-email-liuxp11@chinatelecom.cn/#24831418
[2]: https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/watchdog/watchdog-kernel-api.rst#L95

> @@ -14,6 +14,7 @@
>  #include <linux/watchdog.h>
>  
>  #define MAX_WDAT_ACTIONS ACPI_WDAT_ACTION_RESERVED
> +#define WDAT_TIMEOUT_MIN     1

To be consistent, would MIN_WDAT_TIMEOUT be a better name?

> @@ -344,6 +345,7 @@ static int wdat_wdt_probe(struct platform_device *pdev)
>  	wdat->period = tbl->timer_period;
>  	wdat->wdd.min_hw_heartbeat_ms = wdat->period * tbl->min_count;
>  	wdat->wdd.max_hw_heartbeat_ms = wdat->period * tbl->max_count;
> +	wdat->wdd.min_timeout = WDAT_TIMEOUT_MIN;

Does it really need to configure the `min_timeout`?  What if leave it as is
(i.e. 0)?
