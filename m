Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAB5A92B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiIAJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiIAJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:04:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4B2EF3B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA365B824F5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01410C433D7;
        Thu,  1 Sep 2022 09:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662023021;
        bh=+WSA4yGN7RYXom9ljNy6mUaP7mBvrLdE+lYpc2mkIXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hhRC3UNyv9hbKM1ibuyac0QdHYFRHm1LM8hlypVBZeNhAV562+i/6Z1mar/NnRZO2
         HL9YklicGL+dRqhLAO+tNXG3UY60PjF71kPwCnLCev2/Rr0YsgmEFu70TcWMelVWjw
         Mw9NBqi3dFOHa8/L/ZMef+jA00G/pCFLpYzUY5vo=
Date:   Thu, 1 Sep 2022 11:03:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     kernel test robot <lkp@intel.com>,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [stable:linux-5.15.y 9126/9999] ERROR: modpost:
 "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
Message-ID: <YxB1akxCNlu5B2+M@kroah.com>
References: <202209011256.zvBzxcpP-lkp@intel.com>
 <20220901080017.fe4bx2ywuafry6ie@houat>
 <YxBvyDBxtP57MULl@kroah.com>
 <20220901084833.fupxbfutuz6yqoqo@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901084833.fupxbfutuz6yqoqo@houat>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:48:33AM +0200, Maxime Ripard wrote:
> On Thu, Sep 01, 2022 at 10:39:36AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 01, 2022 at 10:00:17AM +0200, Maxime Ripard wrote:
> > > On Thu, Sep 01, 2022 at 12:51:57PM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> > > > head:   1ded0ef2419e8f83a17d65594523ec3aeb2e3d0f
> > > > commit: 3d722c01d628d17a37cf2820195f15cfc9a6a332 [9126/9999] drm/vc4: Use of_device_get_match_data()
> > > > config: parisc-randconfig-c034-20220831 (https://download.01.org/0day-ci/archive/20220901/202209011256.zvBzxcpP-lkp@intel.com/config)
> > > > compiler: hppa-linux-gcc (GCC) 12.1.0
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=3d722c01d628d17a37cf2820195f15cfc9a6a332
> > > >         git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> > > >         git fetch --no-tags stable linux-5.15.y
> > > >         git checkout 3d722c01d628d17a37cf2820195f15cfc9a6a332
> > > >         # save the config file
> > > >         mkdir build_dir && cp config build_dir/.config
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
> > > > 
> > > > If you fix the issue, kindly add following tag where applicable
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > 
> > > > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > > > 
> > > > >> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
> > > 
> > > I think this is due to stable having backported 87ea95808d53 and
> > > a43dd76bacd0, but missing 59050d7838482
> > 
> > I see no such commit as "59050d7838482" in Linus's tree, what are you
> > referring to exactly here?
> 
> Sorry, I meant 59050d783848, I'm not sure how the final 2 ended up there

Ah, that's better, now queued up, thanks!

greg k-h
