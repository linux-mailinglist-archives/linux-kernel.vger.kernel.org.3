Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2955ED15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiF1Syo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiF1Sym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:54:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74622BD3;
        Tue, 28 Jun 2022 11:54:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 348BEB81F21;
        Tue, 28 Jun 2022 18:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1812C3411D;
        Tue, 28 Jun 2022 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656442478;
        bh=u8hEW7vux9iWZsA17pwpC0Xoyc2INnxaQpwJS9+5oLU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aut/A4GTMw3jzzC61HvV4Pxub63Yl3zq1QD/P6hCp9Odn+bJBnqwbhJc1wO812UBG
         9GN86SmtgztNokhvz+GV7j4zHrYA97eQVl+zEa7MuNNK9DQNv3x8ztCFnW7laCPHY0
         Mj0gx40mMyh/ymF9hpdAoINHsMpzBsBNiEAHQHvlsxiEZViaFDrAhN8Ec58WZ8wnQh
         b9qEVAXZhD3+zLdQU5zMmtZs9AyAQRwCiononG+SwYvjpwQZwRT3SN7vBE/tEcGStS
         JSG4tuHyhF/MOJSS+ItO9iWfSLBJlPTM6G3R/LaKMcEmx+d+6B0BTxDmuW/LD4DBMu
         RZyiNpwXXEmYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BC78C5C0458; Tue, 28 Jun 2022 11:54:37 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:54:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     rcu@vger.kernel.org, urezki@gmail.com, uladzislau.rezki@sony.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
        Theodore Ts'o <tytso@mit.edu>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        amd-gfx@lists.freedesktop.org
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1656357116.rhe0mufk6a.none.ref@localhost>
 <1656357116.rhe0mufk6a.none@localhost>
 <20220627204139.GL1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656379893.q9yb069erk.none@localhost>
 <20220628041252.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656421946.ic03168yc3.none@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656421946.ic03168yc3.none@localhost>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:02:40AM -0400, Alex Xu (Hello71) wrote:
> Excerpts from Paul E. McKenney's message of June 28, 2022 12:12 am:
> > On Mon, Jun 27, 2022 at 09:50:53PM -0400, Alex Xu (Hello71) wrote:
> >> Ah, I see. I have selected the default value for 
> >> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT, but that is 20 if ANDROID. I am not 
> >> using Android; I'm not sure there exist Android devices with AMD GPUs. 
> >> However, I have set CONFIG_ANDROID=y in order to use 
> >> ANDROID_BINDER_IPC=m for emulation.
> >> 
> >> In general, I think CONFIG_ANDROID is not a reliable method for 
> >> detecting if the kernel is for an Android device; for example, Fedora 
> >> sets CONFIG_ANDROID, but (AFAIK) its kernel is not intended for use with 
> >> Android userspace.
> >> 
> >> On the other hand, it's not clear to me why the value 20 should be for 
> >> Android only anyways. If, as you say in 
> >> https://lore.kernel.org/lkml/20220216195508.GM4285@paulmck-ThinkPad-P17-Gen-1/,
> >> it is related to the size of the system, perhaps some other heuristic 
> >> would be more appropriate.
> > 
> > It is related to the fact that quite a few Android guys want these
> > 20-millisecond short-timeout expedited RCU CPU stall warnings, but no one
> > else does.  Not yet anyway.
> > 
> > And let's face it, the intent and purpose of CONFIG_ANDROID=y is extremely
> > straightforward and unmistakeable.  So perhaps people not running Android
> > devices but wanting a little bit of the Android functionality should do
> > something other than setting CONFIG_ANDROID=y in their .config files.  Me,
> > I am surprised that it took this long for something like this to bite you.
> > 
> > But just out of curiosity, what would you suggest instead?
> 
> Both Debian and Fedora set CONFIG_ANDROID, specifically for binder. If 
> major distro vendors are consistently making this "mistake", then 
> perhaps the problem is elsewhere.
> 
> In my own opinion, assuming that binderfs means Android vendor is not a 
> good assumption. The ANDROID help says:
> 
> > Enable support for various drivers needed on the Android platform
> 
> It doesn't say "Enable only if building an Android device", or "Enable 
> only if you are Google". Isn't the traditional Linux philosophy a 
> collection of pieces to be assembled, without gratuitous hidden 
> dependencies? For example, [0] removes the unnecessary Android 
> dependency, it doesn't block the whole thing with "depends on ANDROID".
> 
> It seems to me that the proper way to set some configuration for Android 
> kernels is or should be to ask the Android kernel config maintainers, 
> not to set it based on an upstream kernel option. There is, after all, 
> no CONFIG_FEDORA or CONFIG_UBUNTU or CONFIG_HANNAH_MONTANA.
> 
> WireGuard and random also use CONFIG_ANDROID in a similar "proxy" way as 
> rcu, there to see if suspends are "frequent". This seems dubious for the 
> same reasons.
> 
> I wonder if it might be time to retire CONFIG_ANDROID: the only 
> remaining driver covered is binder, which originates from Android but 
> is no longer used exclusively on Android systems. Like ufs-qcom, binder 
> is no longer used exclusively on Android devices; it is also used for 
> Android device emulators, which might be used on Android-like mobile 
> devices, or might not.
> 
> My understanding is that both Android and upstream kernel developers 
> intend to add no more Android-specific drivers, so binder should be the 
> only one covered for the foreseeable future.

Thank you for the perspective, but you never did suggest an alternative.

So here is is what I suggest given the current setup:

config RCU_EXP_CPU_STALL_TIMEOUT
	int "Expedited RCU CPU stall timeout in milliseconds"
	depends on RCU_STALL_COMMON
	range 0 21000
	default 20 if ANDROID
	default 0 if !ANDROID
	help
	  If a given expedited RCU grace period extends more than the
	  specified number of milliseconds, a CPU stall warning is printed.
	  If the RCU grace period persists, additional CPU stall warnings
	  are printed at more widely spaced intervals.  A value of zero
	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
	  seconds to milliseconds.

The default, and only the default, is controlled by ANDROID.

All you need to do to get the previous behavior is to add something like
this to your defconfig file:

CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000

Any reason why this will not work for you?

> > For that matter, why the private reply?
> 
> Mail client issues, not intentional. Lists re-added, plus Android, 
> WireGuard, and random.

Thank you!

							Thanx, Paul

> Thanks,
> Alex.
> 
> [0] https://lore.kernel.org/all/20220321151853.24138-1-krzk@kernel.org/
