Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715F585BA4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiG3SmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiG3SmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 14:42:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C1614015
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:42:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so5549361wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H6EoWK2Xkx5f0BaLXMIdK1U61HtbiW4S6pMAj0sBMEU=;
        b=Cw4Ajigu6wNyUc+igA/HWRNZT0U5EohtvaBtioSfOpz8foDZCRa7z+X0sN4iKX5Bg5
         GxmKNlC2r3PYQRcd7yOKZWZ5cj5NIA+W5aT5Oz9hBo1FICAYThyQNSoQXvHVnbe9gfA9
         Z6CiKWGCVvm2VsTGZP3J6X7m96sustGROUfJW04mXqAOYkMNWAFZ8wc+LsSM6TYazgck
         LAUAquyixb9rnIyVMWaSNemwdSMv2T8kkf8pdIzRX7mHwZ7wK10UdCXXe7sOxEQ+IagD
         KJKDAeOo/OMTw313Mlm7ToIS2g41+szHlHrjcrQ9FDVu5TKdF7QpL9/kb1Hlh/dehltg
         CGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6EoWK2Xkx5f0BaLXMIdK1U61HtbiW4S6pMAj0sBMEU=;
        b=2ZC02nKTa3DN1Fx44vzdxXrUgPW9pEcMpaKOsqf5aH+tKDdNzkNyn9WRj25rLLU/An
         NBUJrw1W99DD8uF93Sdvs5m+rf+4bHaM1w/Db2Fnea/D5lSine03+37qAoXxwSvkMSYq
         aiNyk1VWYpCJoEtekUHnORG3KwwnzEvUSEn+5LKslVdrMIcAjyZ4uZVQGEsJbNjs0mNs
         3iqohXBy7Hc/9eipkoVuXiowGspYJ1z2bQpjMlEMIE75L+BBP7G61717eAXrQvkFJPQZ
         J2SxkVrulcRKGRvBPG96qaVNwuNhwBD5l5bwboTvZRWrILffQt7BFtBSA3/ojwIXTS2O
         9bhw==
X-Gm-Message-State: AJIora/mhKmSBzKiwzWy+QIDfPXXV849YyM6C+OphGE81F9TbSgC47Hb
        3f2s2038TE9Ls0BlzL5tiqhyj9tsJf98BAt2
X-Google-Smtp-Source: AGRyM1ugN3c3dGq+f9D6o1FI6UQAIcaystpn1k69gEtqNAdg4fpJvs76Rd6x4TjvfLnPIy0K7hj2Jw==
X-Received: by 2002:a05:600c:3551:b0:3a3:1d4f:69ed with SMTP id i17-20020a05600c355100b003a31d4f69edmr6204521wmq.188.1659206540118;
        Sat, 30 Jul 2022 11:42:20 -0700 (PDT)
Received: from OEMBP14.local (82-132-226-84.dab.02.net. [82.132.226.84])
        by smtp.gmail.com with ESMTPSA id p15-20020adfce0f000000b0021ee28ff76esm7147601wrn.38.2022.07.30.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 11:42:19 -0700 (PDT)
Date:   Sat, 30 Jul 2022 19:42:17 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        devel@driverdev.osuosl.org, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [staging:staging-testing 54/54]
 drivers/staging/r8188eu/core/rtw_pwrctrl.c:400:6: warning: variable 'ret' is
 used uninitialized whenever 'if' condition is false
Message-ID: <YuV7iR53bBecQKMd@OEMBP14.local>
References: <202207301623.BfMKLfhv-lkp@intel.com>
 <YuURJ8ecN1cN56v/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuURJ8ecN1cN56v/@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 01:08:23PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Jul 30, 2022 at 04:14:57PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git staging-testing
> > head:   f3a76018dd55d8ddcd28cb47049f46ae5c0ce557
> > commit: f3a76018dd55d8ddcd28cb47049f46ae5c0ce557 [54/54] staging: r8188eu: remove initializer from ret in rtw_pwr_wakeup
> > config: hexagon-randconfig-r015-20220729 (https://download.01.org/0day-ci/archive/20220730/202207301623.BfMKLfhv-lkp@intel.com/config)
> > compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?id=f3a76018dd55d8ddcd28cb47049f46ae5c0ce557
> >         git remote add staging https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> >         git fetch --no-tags staging staging-testing
> >         git checkout f3a76018dd55d8ddcd28cb47049f46ae5c0ce557
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/staging/r8188eu/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> drivers/staging/r8188eu/core/rtw_pwrctrl.c:400:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >            if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/staging/r8188eu/core/rtw_pwrctrl.c:409:9: note: uninitialized use occurs here
> >            return ret;
> >                   ^~~
> >    drivers/staging/r8188eu/core/rtw_pwrctrl.c:400:2: note: remove the 'if' if its condition is always true
> >            if (padapter->bDriverStopped || !padapter->bup || !padapter->hw_init_completed) {
> >            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/staging/r8188eu/core/rtw_pwrctrl.c:384:9: note: initialize the variable 'ret' to silence this warning
> >            int ret;
> >                   ^
> >                    = 0
> >    1 warning generated.
> 
> Phillip, can you send a follow-up patch for this issue?
> 
> thanks,
> 
> greg k-h

Yes, of course. It will be a few hours though if that's ok - I've had
to pop out to send this as someone decided to steal some telecoms cabling,
thus knocking out DSL for us and three neighbouring towns :-)

Regards,
Phil
