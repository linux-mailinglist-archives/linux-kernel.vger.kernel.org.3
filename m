Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB04BD7D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiBUIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:21:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiBUIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:21:27 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625B1DA58
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=7QBc0WEBLu2ln1764MB4fDjlliPNaheIMyMLRttnsXw=;
        b=FfsFM+55j6jE1hipisrdQZk81jVsUXPCd2hotITo6/IfA3lBXSD4SM/94U5nGmi2hjZ36yJM4g7Y9
         UOsBHbvzr3LLlXpurcQRFkbwpUux24x0Sv1S0iD8PEpjmRyYfe0g+16EXno8nawr8TnYnpAE5ZNumU
         Kr2+gpTKAaO+GeFAQz1JFzumkbllfJs/rc+a66tU2eRHUjJJIF/IN+UHSZFMZetjNUfUgKfdH1V9cR
         4d+eB/Yu2jcuVJaC7hvuOsiagOkM6nMziV/NWp9Xf+1H5BYmQksNkDgwKaIJIxXAW2Efam/XsXnqbB
         keUJeRh9dF9c4V1wc8jeil0GQF2aRGg==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1403, Stamp: 3], Multi: [Enabled, t: (0.000008,0.005762)], BW: [Enabled, t: (0.000022,0.000001)], RTDA: [Enabled, t: (0.062456), Hit: No, Details: v2.25.0; Id: 15.52k7rm.1fsdlslmm.1bdlg; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 21 Feb 2022 11:20:40 +0300
Date:   Mon, 21 Feb 2022 11:02:44 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH] bus: imx-weim: add DT overlay support for WEIM bus
Message-ID: <20220221080244.bd7wankcdsiwzum4@x260>
References: <20220205055006.23447-1-i.bornyakov@metrotek.ru>
 <20220205055006.23447-2-i.bornyakov@metrotek.ru>
 <20220221072529.GP2249@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221072529.GP2249@dragon>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 03:25:29PM +0800, Shawn Guo wrote:
> On Sat, Feb 05, 2022 at 08:50:06AM +0300, Ivan Bornyakov wrote:
> > Add OF reconfiguration notifier handler for WEIM bus to setup Chip
> > Select timings on runtime creation of child devices.
> > 
> > However, it is not possible to load another DT overlay with conflicting
> > CS timings with previously loaded overlay, even if the first one is
> > unloaded.
> 
> Are we doing anything if that happens?
> 

On device removal there is no access to device node properties, thus it
is not possible to find out which of CS timings was configured for this
device to clear theirs 'is_applied'.

So, if we apply one DT overlay, configure some CS timings, remove this
overlay, apply another with conflicting timings, we will fail here

static int weim_timing_setup(...)
{
	...

	for (reg_idx = 0; reg_idx < num_regs; reg_idx++) {
		...

		/* prevent re-configuring a CS that's already been configured */
		cst = &ts->cs[cs_idx];
		if (cst->is_applied && memcmp(value, cst->regs,
					devtype->cs_regs_count * sizeof(u32))) {
			dev_err(dev, "fsl,weim-cs-timing conflict on %pOF", np);
			return -EINVAL;
		}
		...
	}
	...
}

