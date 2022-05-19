Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE8452D035
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbiESKL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiESKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:11:53 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00EA326FC;
        Thu, 19 May 2022 03:11:52 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DE8F8FF813;
        Thu, 19 May 2022 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652955111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rZ9Rjlc7Xbd+ravkG0dksTMiGwZZSR2Kx4s9fPCqRQQ=;
        b=RsIyGgC8cZlxWMGkU9QJEHK0rgK7nYmLY3FghTDUA2qYLCBc3UTfscwuZE72Kn/1lS6laL
        iHeFNkZiQMqryBFD8uvV0cvcrTFF9SPkwcIUFrkdT3CtuXw6NyweISlNQyPXO2o9PkKzJz
        H1C+ZAIxXbBM3/khdNCnqLgZP1G16eSc/cFV7/w7xdPYw3pWVz3tA13iXkk04YfOJW5UOS
        LLW0mS/jkFhYu7dszQCTufobawtp/AH0Tmorp+jOPtf0MuRRT+6oNAr6/0dXMRiW0tOSto
        2p+k1wZ0M/e1U2aTsuG1TTtXX0AqwUTVPOl1DHTt6w982iYL/FFT5BivGB8HWg==
Date:   Thu, 19 May 2022 12:11:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>
Subject: Re: [PATCH] rtc: ftrtc010: Fix error handling in ftrtc010_rtc_probe
Message-ID: <165295505634.539503.13517357620034192674.b4-ty@bootlin.com>
References: <20220403054912.31739-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403054912.31739-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2022 05:49:12 +0000, Miaoqian Lin wrote:
> In the error handling path, the clk_prepare_enable() function
> call should be balanced by a corresponding 'clk_disable_unprepare()'
> call , as already done in the remove function.
> 
> clk_disable_unprepare calls clk_disable() and clk_unprepare().
> They will use IS_ERR_OR_NULL to check the argument.
> 
> [...]

Applied, thanks!

[1/1] rtc: ftrtc010: Fix error handling in ftrtc010_rtc_probe
      commit: b520cbe5be37b1b9b401c0b6ecbdae32575273db

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
