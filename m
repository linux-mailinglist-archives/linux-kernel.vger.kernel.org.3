Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AFE59F481
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiHXHou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbiHXHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:44:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45783B5;
        Wed, 24 Aug 2022 00:44:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D443922534;
        Wed, 24 Aug 2022 07:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661327083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CVLEu5X5W558Mdwud6PEFNhZNUWDtayqH7r9TTDZuA=;
        b=Lz/ACUxILC+R3yz2Ui0SJh6CaW4tttXbYGqKExsC2hkoEsZCegFXYFc22ajQzGRvdjEryQ
        3CotfVecb7dxD8/WETOSvYRosDVKGJM3RkXu2/Cz96AiSW7ON9ujL0feO/uL9jEDd7Zl+h
        Ba3bmdinRxLW6ofOfbyC0I3KWkqj9FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661327083;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CVLEu5X5W558Mdwud6PEFNhZNUWDtayqH7r9TTDZuA=;
        b=tl3Xm9YZ2vhlGUbXJNfule+zMvT2R4ylbRHH+Q3QSBJF/vfQm60/mcW6ZWE/UtUCRMNmGt
        ZBO5wTmc8lAY3PBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B707713AC0;
        Wed, 24 Aug 2022 07:44:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id elupLOvWBWPhUgAAMHmgww
        (envelope-from <iivanov@suse.de>); Wed, 24 Aug 2022 07:44:43 +0000
Date:   Wed, 24 Aug 2022 10:44:43 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Phil Elwell <phil@raspberrypi.org>,
        kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3] clk: bcm2835: Round UART input clock up
Message-ID: <20220824074443.nvrnqhpvqrtn72p4@suse>
References: <20220527102900.144894-1-iivanov@suse.de>
 <20220823230842.AB8BAC433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823230842.AB8BAC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-23 16:08, Stephen Boyd wrote:
> Date: Tue, 23 Aug 2022 16:08:40 -0700
> From: Stephen Boyd <sboyd@kernel.org>
> To: Albert Ou <aou@eecs.berkeley.edu>, Broadcom internal kernel review list
>  <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
>  <f.fainelli@gmail.com>, "Ivan T. Ivanov" <iivanov@suse.de>, Michael
>  Turquette <mturquette@baylibre.com>, Nicolas Saenz Julienne
>  <nsaenz@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
>  <paul.walmsley@sifive.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
>  <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>
> Cc: "Ivan T. Ivanov" <iivanov@suse.de>, Phil Elwell <phil@raspberrypi.org>,
>  kernel test robot <lkp@intel.com>, linux-clk@vger.kernel.org,
>  linux-rpi-kernel@lists.infradead.org,
>  linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
>  linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v3] clk: bcm2835: Round UART input clock up
> Message-Id: <20220823230842.AB8BAC433C1@smtp.kernel.org>
> 
> Quoting Ivan T. Ivanov (2022-05-27 03:29:00)
> > It was reported that RPi3[1] and RPi Zero 2W boards have issues with
> > the Bluetooth. It turns out that when switching from initial to
> > operation speed host and device no longer can talk each other because
> > host uses incorrect UART baud rate.
> > 
> > The UART driver used in this case is amba-pl011. Original fix, see
> > below Github link[2], was inside pl011 module, but somehow it didn't
> > look as the right place to fix. Beside that this original rounding
> > function is not exactly perfect for all possible clock values. So I
> > deiced to move the hack to the platform which actually need it.
> > 
> > The UART clock is initialised to be as close to the requested
> > frequency as possible without exceeding it. Now that there is a
> > clock manager that returns the actual frequencies, an expected
> > 48MHz clock is reported as 47999625. If the requested baud rate
> > == requested clock/16, there is no headroom and the slight
> > reduction in actual clock rate results in failure.
> > 
> > If increasing a clock by less than 0.1% changes it from ..999..
> > to ..000.., round it up.
> > 
> > [1] https://bugzilla.suse.com/show_bug.cgi?id=1188238
> > [2] https://github.com/raspberrypi/linux/commit/ab3f1b39537f6d3825b8873006fbe2fc5ff057b7
> > 
> > Cc: Phil Elwell <phil@raspberrypi.org>
> > Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> > ---
> 
> This is waiting for someone like Stefan to review. It's customary to
> include previous reviewers on new versions of patches.

Thanks for fixing me mistake.

Regards,
Ivan

