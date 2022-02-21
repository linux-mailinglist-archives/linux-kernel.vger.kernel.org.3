Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F258C4BD7CF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbiBUIe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:34:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343766AbiBUIe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:34:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832B338BA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:34:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2123861092
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A6DC340E9;
        Mon, 21 Feb 2022 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645432474;
        bh=IKI9WWMJHEiavYMge8WuMDWwtJYvSFU+zJwbidZuFiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJOiCM5UviX81tnAIjmZpDNZTXvSjQ8Qzpbpkn29ZAJqrqojOqXPkiEvfVlobvOUf
         D8G+nQzCbCJFQnKMSEnVq1MVW4n1keegCKB5EQEXzN6PVXsYAkLq5l0oKWTrfpp2yk
         OllWhjePF8GcBTXTTQQFqO3W4K2zQ9UbKScvTSrGwW56Q2qMJ7aIjbOg1/3YNrALpW
         XS3+CJfAi76HtPAH/nmIvRaUDeqbTe//QO9E0gfSwfRKNzjwuPzW8A0uisYX7N1N0T
         Zq6SgIC6W1vdKvKEjMWX1I4owZXmEkQobpoyHF792EV15XUiN7K80AZSGDn+toaLmW
         EE0n/YzKlK51w==
Date:   Mon, 21 Feb 2022 16:34:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH] bus: imx-weim: add DT overlay support for WEIM bus
Message-ID: <20220221083429.GT2249@dragon>
References: <20220205055006.23447-1-i.bornyakov@metrotek.ru>
 <20220205055006.23447-2-i.bornyakov@metrotek.ru>
 <20220221072529.GP2249@dragon>
 <20220221080244.bd7wankcdsiwzum4@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221080244.bd7wankcdsiwzum4@x260>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:02:44AM +0300, Ivan Bornyakov wrote:
> On Mon, Feb 21, 2022 at 03:25:29PM +0800, Shawn Guo wrote:
> > On Sat, Feb 05, 2022 at 08:50:06AM +0300, Ivan Bornyakov wrote:
> > > Add OF reconfiguration notifier handler for WEIM bus to setup Chip
> > > Select timings on runtime creation of child devices.
> > > 
> > > However, it is not possible to load another DT overlay with conflicting
> > > CS timings with previously loaded overlay, even if the first one is
> > > unloaded.
> > 
> > Are we doing anything if that happens?
> > 
> 
> On device removal there is no access to device node properties, thus it
> is not possible to find out which of CS timings was configured for this
> device to clear theirs 'is_applied'.
> 
> So, if we apply one DT overlay, configure some CS timings, remove this
> overlay, apply another with conflicting timings, we will fail here
> 
> static int weim_timing_setup(...)
> {
> 	...
> 
> 	for (reg_idx = 0; reg_idx < num_regs; reg_idx++) {
> 		...
> 
> 		/* prevent re-configuring a CS that's already been configured */
> 		cst = &ts->cs[cs_idx];
> 		if (cst->is_applied && memcmp(value, cst->regs,
> 					devtype->cs_regs_count * sizeof(u32))) {
> 			dev_err(dev, "fsl,weim-cs-timing conflict on %pOF", np);
> 			return -EINVAL;
> 		}
> 		...
> 	}
> 	...
> }

Ah, right, thanks for clarifying, Ivan!

Shawn
