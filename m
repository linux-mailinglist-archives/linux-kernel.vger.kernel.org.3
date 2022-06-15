Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49C54D2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbiFOUko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbiFOUkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:40:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D268F3FDA7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 13:40:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CE916174B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD047C3411A;
        Wed, 15 Jun 2022 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655325639;
        bh=50wAXgcb120WidSlklAEzrlS+8SKZSfHsTb1U3TbtwI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RW+wGycZ34+c7dEtmDGeMht6ISXHuN02fwykFVweVFzgwSXqVUjoF/LR26svds6aL
         OiJblpkzpGy4IGSswBQq4oGACEnEUfs8/NkIpsgzK3ALMhfYnYkd+DsSCOjU/I7Bij
         5sPPfLQec1gOtjUPrzyaMPSJbWV+2GYXzHqSZwVrjf7I3Lt8y7oojdWrJ8IcECHkDG
         yiR8nekC4QbPJ/UZOoXLinRZWkPu+57pETytdf7Q1E9egpS5hgG2XQIIC25bdLtH2k
         gT0M5u4norycp1ldN8TOTtyEU5OEbvams2qbgfjKAjxeWhKGZsTULvplpvAaKzGjpy
         xjPmV+esk+dkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4766D5C027A; Wed, 15 Jun 2022 13:40:39 -0700 (PDT)
Date:   Wed, 15 Jun 2022 13:40:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:paulmck/linux-rcu/pmladek.2022.06.15a
 133/140] vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to
 __kasan_check_read() leaves .noinstr.text section
Message-ID: <20220615204039.GI1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202206160411.v3iL3YC0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206160411.v3iL3YC0-lkp@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:26:16AM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block paulmck/linux-rcu/pmladek.2022.06.15a
> head:   0ba7324b44282870af740a5a121add62c7f5f730
> commit: db21b02f8044e812f8a5e3811f602409290e3ede [133/140] context_tracking: Convert state to atomic_t
> config: x86_64-randconfig-r003-20220516 (https://download.01.org/0day-ci/archive/20220616/202206160411.v3iL3YC0-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/ammarfaizi2/linux-block/commit/db21b02f8044e812f8a5e3811f602409290e3ede
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block paulmck/linux-rcu/pmladek.2022.06.15a
>         git checkout db21b02f8044e812f8a5e3811f602409290e3ede
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> vmlinux.o: warning: objtool: __ct_user_exit+0x41: call to __kasan_check_read() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: __ct_user_enter+0x7f: call to __kasan_check_read() leaves .noinstr.text section

Marco, Dmitry, my guess is that this is due to the ct->active check in
both functions.  Are we supposed to do something to make this sort of
thing safe for KASAN?

							Thanx, Paul
