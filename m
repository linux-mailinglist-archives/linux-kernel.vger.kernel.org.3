Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CECE54D380
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349899AbiFOVRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349884AbiFOVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:17:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1A25537B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7931061587
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BFCC3411B;
        Wed, 15 Jun 2022 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655327837;
        bh=xhSdpAucRXuerlPjRWPUTE1HVOkTXDQj6Q+PfEZmTuY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cGv6SdOgur/PagiSY+q8+ssxzsRt+xu/SKG8tE5ddOE1XQw4f5PYjaiTTwueAU/n7
         rn/ORd1yrz1m4OGihBwvcHe3am8x6JHfxebtDw5mjBfhseKoernTfj7Mvgkf8OG9uS
         zyCku+A05OPKuWpbB+mSO40sYhj6CpOZm+AisKGYGb67yhaJkbH+W5Xh3PxzecQ1U2
         tWOy6OoEuZt2XXjq4FveEuZea0+119AA7NMKP+x2sw1JNkVnF4VxXwF1LKEKIz1Tsh
         /fZqpHfW1twIqA3UKEZrq9BRFdTO5oBl6yeYRTUDDRSqmGKhuYjX7wsIYNEdyPGYtK
         WIQE252MvlmYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 769AC5C027A; Wed, 15 Jun 2022 14:17:17 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:17:17 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, elver@google.com, dvyukov@google.com
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a
 133/140] vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to
 __kasan_check_read() leaves .noinstr.text section
Message-ID: <20220615211717.GA972937@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202206160411.v3iL3YC0-lkp@intel.com>
 <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 01:40:39PM -0700, Paul E. McKenney wrote:
> On Thu, Jun 16, 2022 at 04:26:16AM +0800, kernel test robot wrote:
> > tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
> > head:   0ba7324b44282870af740a5a121add62c7f5f730
> > commit: db21b02f8044e812f8a5e3811f602409290e3ede [133/140] context_tracking: Convert state to atomic_t
> > config: x86_64-randconfig-r003-20220516 (https://download.01.org/0day-ci/archive/20220616/202206160411.v3iL3YC0-lkp@intel.com/config)
> > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://github.com/ammarfaizi2/linux-block/commit/db21b02f8044e812f8a5e3811f602409290e3ede
> >         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
> >         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
> >         git checkout db21b02f8044e812f8a5e3811f602409290e3ede
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
> > >> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section
> 
> Marco, Dmitry, my guess is that this is due to the ct->active check in
> both functions.  Are we supposed to do something to make this sort of
> thing safe for KASAN?

This time actually CCing Marco and Dmitry...

							Thanx, Paul
