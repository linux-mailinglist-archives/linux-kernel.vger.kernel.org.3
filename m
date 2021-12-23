Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768DA47DE8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 06:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346322AbhLWFTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 00:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhLWFTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 00:19:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB6C061401
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 21:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23CC3B81F75
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 05:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BB0C36AE9;
        Thu, 23 Dec 2021 05:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640236789;
        bh=7zJHmCoxTHJyGHd+FsDCG+BUarl2qNlDg2wAXE0J1/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CuLuhtzoG+n0sPa/rQnBXLgsb4KwfJS8oNo3hce821FZDpb3XShWu0AghSyk9Qjia
         qs+HNtqZe5sTVBmUJIe9je4kpSsfFs/1h8D2JCmKe8WQXhNsXQbGajOLi3hqOnr4Ze
         RUPOzq5+3JWzyqf4PGSym1eHyMVDmmc9LFZMpXIPT0zbo/fxNwaMmn/loM3nkA3eCu
         oP/0oAa8O6CYziRpUud/VQo2/1AQvX6gRp+ui+44hfsUYDiX6CUSLZMkeOADTYZ9uz
         KGmKEjAvS7HteFaM4yjNvuENORD0tFbG7b4HfAgm1Idy14KT7wyZkTyjchdSCb6PPi
         mgvIVclW2P5pg==
Date:   Thu, 23 Dec 2021 10:49:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Liao, Bard" <bard.liao@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
 set_stream() instead of set_tdm_slots() for HDAudio
Message-ID: <YcQG8EjC5J+5721e@matsya>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <YcIYT57YLpHR1+9A@sirena.org.uk>
 <DM6PR11MB40741309EE8E5A7977210EC5FF7D9@DM6PR11MB4074.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB40741309EE8E5A7977210EC5FF7D9@DM6PR11MB4074.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-21, 13:47, Liao, Bard wrote:
> > -----Original Message-----
> > From: Mark Brown <broonie@kernel.org>
> > Sent: Wednesday, December 22, 2021 2:09 AM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: alsa-devel@alsa-project.org; vkoul@kernel.org; vinod.koul@linaro.org;
> > linux-kernel@vger.kernel.org; tiwai@suse.de; gregkh@linuxfoundation.org;
> > srinivas.kandagatla@linaro.org; pierre-louis.bossart@linux.intel.com; Kale,
> > Sanyog R <sanyog.r.kale@intel.com>; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH 0/7] ASoC/SoundWire: improve suspend flows and use
> > set_stream() instead of set_tdm_slots() for HDAudio
> > 
> > On Mon, Dec 13, 2021 at 01:46:27PM +0800, Bard Liao wrote:
> > 
> > > The topics are independent but the changes are dependent. So please
> > > allow me to send them in one series.
> > 
> > What's the plan for getting these merged?  Looks like they're mainly
> > ASoC changes?
> 
> Yes, maybe Vinod can ack and these patches can go through ASoC tree.

I didnt have this series :( and on checking found that gmail tagged
these and bunch of other alsa patches as spam, even my linaro email
seems to have been unsubscribed due to bounces...

Not sure what is going on, will check the patches now...

-- 
~Vinod
