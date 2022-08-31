Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097045A7A45
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiHaJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiHaJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:32:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9CCEB1A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 02:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3951DB81F3D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 09:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558B2C433C1;
        Wed, 31 Aug 2022 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661938367;
        bh=QG1DyMGmqSCY6m/qOIfbt61PZ1QMvZ1UY2rmKlptMps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yaiR/2gVKsybGXDd/TqmywNAVa20/rZyQOsrXE3RUKpuC5U7sa4RFgTLm56e0Kyti
         B0Zuoz3i8sIGtmu2B7Zga63uVAPF11Tnif4SCJdrwf1ubGU0LxF8yB2nGgtNcINU1S
         q5hrsNyN9sOtxTSpDv7QLEPe5cw9b1nCTbtYGKe0=
Date:   Wed, 31 Aug 2022 11:32:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        johan@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        zhangxuezhi1@coolpad.com, xyangxi5@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] tty: vt: Add checks after calling kzalloc
Message-ID: <Yw8qu1op37fWTvdi@kroah.com>
References: <20220831090810.2175859-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831090810.2175859-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 05:08:10PM +0800, Jiasheng Jiang wrote:
> On Wed, Aug 31, 2022 at 03:57:42PM +0800, Jiasheng Jiang wrote:
> >>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> >>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> >> +		if (!vc) {
> >> +			console_unlock();
> >> +			return -ENOMEM;
> >> +		}
> >>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
> >>  		tty_port_init(&vc->port);
> >>  		visual_init(vc, currcons, 1);
> >>  		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
> >>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> >> +		if (!vc->vc_screenbuf) {
> >> +			console_unlock();
> >> +			return -ENOMEM;
> >> +		}
> > 
> > This has been attempted many times in the past, sorry.  Unless you can
> > prove that this can actually happen in real life, we are going to leave
> > these as-is.
> > 
> > Please do not just do random changes like this without actually testing
> > to see if it is possible to happen.
> 
> As the harm of vulnerabilities is much higher than the cost of fixing them,
> it is acceptable to add harmless security checks that guarantee the
> vulnerabilities will never be triggered.

No, not always, many times you are adding new bugs by doing this type of
"unneeded fixes".  We have had this happen in the vt code many times in
the past, let's learn from our mistakes please.

And where is the "vulnerability" here exactly?

thanks,

greg k-h
