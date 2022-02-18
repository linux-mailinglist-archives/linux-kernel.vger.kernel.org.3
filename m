Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4994BC2FD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiBRXqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:46:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiBRXqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:46:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793822BDC3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7370061F1B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 23:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90654C340E9;
        Fri, 18 Feb 2022 23:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645227983;
        bh=Nf4QWHJQf6uMYeqUXDUKolXQIDg74FWqWkoKRg8EeRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rz7jPVerk5V3ozJNYK+1G0lFwI7OHwQibB57qbd/3lYLBpf5zVMpECQ0OkN3v2gzs
         PhbYL3SES+sxuboenAfJFiNcfjBlU54dVYWi2Wi4wLA4Vjy8KhhGDaZzDW20NnXVM4
         d0lnj5b+wmWMYOSRWuyvAMBaZMBDELpldDT+I7zmomwHOx/cItN3fzjdKvc/Fu7wz2
         I7cDcm6tBTlefJ77THO1X4X1m/kmIsOCI2tKBdnEmJVppeWPFsoOJ5Lt750EnKsP3j
         e+ki2oHlkMdRb5zrwuEc5aX9RxQmK3j9LfcH4/2vn5xANxWlTQg5fTBIgR7AleZrP0
         PSnZniAT+XGIg==
Date:   Sat, 19 Feb 2022 00:46:18 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
        linux-kernel@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Huajun Li <huajun.li@intel.com>, tiwai@suse.de,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 0/1] sound: add quirk for Huawei D15
Message-ID: <20220219004618.07cb69a9@coco.lan>
In-Reply-To: <c17173cb-290c-9ecd-54e3-b74f9d4e9061@linux.intel.com>
References: <cover.1640351150.git.mchehab@kernel.org>
        <164519450743.1836505.3912962145996830275.b4-ty@kernel.org>
        <c17173cb-290c-9ecd-54e3-b74f9d4e9061@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 18 Feb 2022 12:11:59 -0600
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> escreveu:

> On 2/18/22 08:28, Mark Brown wrote:
> > On Fri, 24 Dec 2021 14:09:48 +0100, Mauro Carvalho Chehab wrote:  
> >> Based on my tests, Huawei D15 (Intel) uses SSP0 on es8336.
> >>
> >> Add a quirk for it.
> >>
> >> Please notice that, currently, only the internal speaker is working.
> >> The topology for the internal microphone and for the headphones
> >> is wrong. Enabling/disabling the other two quirks (GPIO and/or DMIC)
> >> doesn't cause any audible results, nor change the devices listed
> >> on pavucontrol (tested with pipewire-pulse).
> >>
> >> [...]  
> > 
> > Applied to
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> > 
> > Thanks!
> > 
> > [1/1] ASoC: Intel: sof_es8336: add quirk for Huawei D15 2021
> >       commit: ce6a70bfce21bb4edb7c0f29ecfb0522fa34ab71  
> 
> I'll probably revert this change in my next update [1], I have a set of
> changes where we can detect which SSP is used by parsing the NHTL
> information in platform firmware.

Mark,

Yeah, I tested Pierre-Louis pull request from:

	https://github.com/thesofproject/linux/pull/3338

and indeed this quirk is not needed anymore for the speaker to work.

So, once his new update gets merged upstream, feel free to revert
this one.

Pierre-Louis,

When you submit your next update from PR#3338, feel free to add:

Tested-by: Mauro Carvalho Chehab <mchehab@kernel.org>

and my Acked-by at the revert patch:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> 
> I am still trying to figure out how to detect which MCLK is used, and
> once this is done I'll send the patches upstream.
> 
> [1] https://github.com/thesofproject/linux/pull/3338



Thanks,
Mauro
