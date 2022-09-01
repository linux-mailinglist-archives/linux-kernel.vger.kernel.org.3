Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEDF5A9237
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiIAIjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiIAIjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE512D52C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:39:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B52F261E23
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF23C433D7;
        Thu,  1 Sep 2022 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662021580;
        bh=dKW6pyi6fNs6xsnowh1r49EDqBQtnisThBT9SEDWOIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1v5Jkf8blSP8TAPo7RuyFPqHyLrgEZpWBSMOlS7kPk6mf30uNNxv9QnteuOYozWn
         X3kNKoFhspq16S+vE2cd233AY/X+PawKAh0gCItRq2qCQ4tUqkBb4D14Aql7UDeW5D
         NPt4Wranq5r3DPnCgZGYYAiR3cVNxuzyfv+cdd2A=
Date:   Thu, 1 Sep 2022 10:39:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     kernel test robot <lkp@intel.com>,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [stable:linux-5.15.y 9126/9999] ERROR: modpost:
 "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
Message-ID: <YxBvyDBxtP57MULl@kroah.com>
References: <202209011256.zvBzxcpP-lkp@intel.com>
 <20220901080017.fe4bx2ywuafry6ie@houat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901080017.fe4bx2ywuafry6ie@houat>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:00:17AM +0200, Maxime Ripard wrote:
> On Thu, Sep 01, 2022 at 12:51:57PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> > head:   1ded0ef2419e8f83a17d65594523ec3aeb2e3d0f
> > commit: 3d722c01d628d17a37cf2820195f15cfc9a6a332 [9126/9999] drm/vc4: Use of_device_get_match_data()
> > config: parisc-randconfig-c034-20220831 (https://download.01.org/0day-ci/archive/20220901/202209011256.zvBzxcpP-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=3d722c01d628d17a37cf2820195f15cfc9a6a332
> >         git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> >         git fetch --no-tags stable linux-5.15.y
> >         git checkout 3d722c01d628d17a37cf2820195f15cfc9a6a332
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> ERROR: modpost: "devm_drm_of_get_bridge" [drivers/gpu/drm/vc4/vc4.ko] undefined!
> 
> I think this is due to stable having backported 87ea95808d53 and
> a43dd76bacd0, but missing 59050d7838482

I see no such commit as "59050d7838482" in Linus's tree, what are you
referring to exactly here?

thanks,

greg k-h
