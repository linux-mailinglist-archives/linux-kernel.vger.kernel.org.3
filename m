Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D197C50F0C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245017AbiDZGQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiDZGQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:16:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03958C1CB4;
        Mon, 25 Apr 2022 23:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9640BB81BA9;
        Tue, 26 Apr 2022 06:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC5C385A4;
        Tue, 26 Apr 2022 06:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953620;
        bh=GFpjyTmiYkBRBdDNPRaOg9t7LyIi7H+wRnslzY1RBEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkFxJEj+WXxevKG+MAp+SdhjbIw09AkDXknksn3Ua1TjO3l5mmDf73uvtJMsfEW8I
         Yzy22Wvfoe/t1YpWo9Dcntge6U22ulQAmRVcVUQXJL1inJFzayLHR2ZAAN676EwZ/D
         qNhuS3ehcZG7xtz7zSrQI30n78+NwfAY/hi8J1iyp1Se49oYDErNSmm7bmOt/mjdQD
         gInOXeIsJPJWWTBQDkx/M3/LGTs0ZqkxlsxP3JoOjUt65Bfxv/4yW2vt0irNvE3HSo
         k+UqH/j2YbrsW0WYG+pqBEs+MX9HpncMAbtfiv/IGIrbCnL49XF7KwWfSahqRo1gVW
         9ZJojcN1bBdCA==
Date:   Tue, 26 Apr 2022 14:13:36 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Liu Xinpeng <liuxp11@chinatelecom.cn>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] watchdog: iTCO_wdg: Make code more clearly with
 macro definition
Message-ID: <YmeNkC8B9glPt2S8@google.com>
References: <1650944120-30954-1-git-send-email-liuxp11@chinatelecom.cn>
 <1650944120-30954-5-git-send-email-liuxp11@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650944120-30954-5-git-send-email-liuxp11@chinatelecom.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:35:20AM +0800, Liu Xinpeng wrote:
> @@ -596,7 +596,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  /*
>   * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
>   * the watchdog cannot be pinged while in that state.  In ACPI sleep states the
> @@ -637,20 +636,15 @@ static int iTCO_wdt_resume_noirq(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops iTCO_wdt_pm = {
> -	.suspend_noirq = iTCO_wdt_suspend_noirq,
> -	.resume_noirq = iTCO_wdt_resume_noirq,
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(iTCO_wdt_suspend_noirq,
> +				      iTCO_wdt_resume_noirq)

Thus, iTCO_wdt_suspend_noirq and iTCO_wdt_resume_noirq are possible unused.
Put __maybe_unused attribute to them.
