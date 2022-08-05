Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3258AE99
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiHEREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiHEREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:04:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234F970E74;
        Fri,  5 Aug 2022 10:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2C88B8298F;
        Fri,  5 Aug 2022 17:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F893C433D7;
        Fri,  5 Aug 2022 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659719044;
        bh=eWXE1meMC5J4xw9qLbR0+CRDPLl8AbWzFX2rkav8pDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYnzAx8WxgRBoyJFbNtuXWnffj6Lo/eXGY7dLJ9qkyfD1vLZ0DFNTpUfCzkWVUfhs
         BFkfZRkVpQ1RzGtR1Vj+71L9+LfUH/a8Mjvsk1NDVAnuHlEP7YTfss93nI5govJ4h9
         ur1XURW5L+3omchEpDsaV2hCosgpjm65dePHqhvT2Hb+r4sbcIVAqtDAFz0qwLlw4F
         rayh/p5WUb2mdf6xaBSUsrc0aGxwATc2na08QmWWQfwVIONVNmFb6tM/Cn1vQYEjov
         F0f0UsYAmsCRLzAJ8PhfvYcKssd4W60LoTbqtQNE+YJL9Rh6DaCtNe0nx/nuJoqb/c
         QnagmjM5c3zGg==
Date:   Fri, 5 Aug 2022 10:04:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     alexandre.belloni@bootlin.com
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-rtc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] rtc: zynqmp: initialize fract_tick
Message-ID: <Yu1Ngjr5Ux+CN1Nn@dev-arch.thelio-3990X>
References: <20220727100018.3301470-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727100018.3301470-1-alexandre.belloni@bootlin.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 12:00:18PM +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> fract_tick is used uninitialized when fract_offset is 0
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Is this going to be applied soon? This is one of the warnings breaking
allmodconfig with clang right now:

    drivers/rtc/rtc-zynqmp.c:223:7: error: variable 'fract_tick' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                    if (fract_offset > (tick_mult / RTC_FR_MAX_TICKS)) {
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/rtc/rtc-zynqmp.c:238:6: note: uninitialized use occurs here
            if (fract_tick)
                ^~~~~~~~~~
    drivers/rtc/rtc-zynqmp.c:223:3: note: remove the 'if' if its condition is always true
                    if (fract_offset > (tick_mult / RTC_FR_MAX_TICKS)) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/rtc/rtc-zynqmp.c:218:6: error: variable 'fract_tick' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
            if (fract_offset) {
                ^~~~~~~~~~~~
    drivers/rtc/rtc-zynqmp.c:238:6: note: uninitialized use occurs here
            if (fract_tick)
                ^~~~~~~~~~
    drivers/rtc/rtc-zynqmp.c:218:2: note: remove the 'if' if its condition is always true
            if (fract_offset) {
            ^~~~~~~~~~~~~~~~~~
    drivers/rtc/rtc-zynqmp.c:206:26: note: initialize the variable 'fract_tick' to silence this warning
            unsigned char fract_tick;
                                    ^
                                    = '\0'
    2 errors generated.

> ---
>  drivers/rtc/rtc-zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 1dd389b891fe..c9b85c838ebe 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -203,7 +203,7 @@ static int xlnx_rtc_set_offset(struct device *dev, long offset)
>  	struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>  	unsigned long long rtc_ppb = RTC_PPB;
>  	unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
> -	unsigned char fract_tick;
> +	unsigned char fract_tick = 0;
>  	unsigned int calibval;
>  	short int  max_tick;
>  	int fract_offset;
> -- 
> 2.36.1
> 
> 
