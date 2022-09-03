Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E695ABD95
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiICHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiICHJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:09:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F960E2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 00:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D9D60DF8
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 07:09:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C84C433D6;
        Sat,  3 Sep 2022 07:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662188952;
        bh=ueEMFEWWKSvzzanb9UMFrgbyr5u8VG1kQiI5ACa52DA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=YgUYogF21/lkl1i//Cly81cVNnaIuca8YgwrcO+RHifw6vdtACGvDliRROsQBczq6
         DU+Fm7iGAGFcn+KZucrzMYDCAg2FhJZkrHvRBMWviypEmneU/VZ3e5jTouJ2P9BIH+
         ZD09kVvdNHXnGec4SbxUJt6EcdHJFMr0g5WXeNIg=
Date:   Sat, 3 Sep 2022 09:09:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [char-misc:char-misc-testing 20/24] kismet: WARNING: unmet
 direct dependencies detected for GPIOLIB_IRQCHIP when selected by
 GP_PCI1XXXX
Message-ID: <YxL9qpQ2YcvC4sjh@kroah.com>
References: <202209031414.Y8YCEjmI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209031414.Y8YCEjmI-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2022 at 02:12:13PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-testing
> head:   4ec7ac90ff399b7d9af81cc8afd430a22786c61b
> commit: 393fc2f5948fd340d016a9557eea6e1ac2f6c60c [20/24] misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.
> config: x86_64-kismet-CONFIG_GPIOLIB_IRQCHIP-CONFIG_GP_PCI1XXXX-0-0 (https://download.01.org/0day-ci/archive/20220903/202209031414.Y8YCEjmI-lkp@intel.com/config)
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?id=393fc2f5948fd340d016a9557eea6e1ac2f6c60c
>         git remote add char-misc https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>         git fetch --no-tags char-misc char-misc-testing
>         git checkout 393fc2f5948fd340d016a9557eea6e1ac2f6c60c
>         # 1. reproduce by kismet
>            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
>            kismet --linux-ksrc=linux --selectees CONFIG_GPIOLIB_IRQCHIP --selectors CONFIG_GP_PCI1XXXX -a=x86_64
>         # 2. reproduce by make
>            # save the config file to linux source tree
>            cd linux
>            make ARCH=x86_64 olddefconfig
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> kismet warnings: (new ones prefixed by >>)
> >> kismet: WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP when selected by GP_PCI1XXXX
>    
>    WARNING: unmet direct dependencies detected for GPIOLIB_IRQCHIP
>      Depends on [n]: GPIOLIB [=n]
>      Selected by [y]:
>      - GP_PCI1XXXX [=y] && PCI [=y]

Ick, I missed this before in review.  Kumaravel, any chance you can make
this a "depends" issue instead of a select one?

thanks,

greg k-h
