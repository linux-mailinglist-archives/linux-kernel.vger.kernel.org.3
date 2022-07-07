Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB3B56A3A8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiGGN30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbiGGN3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992EE2CCB4;
        Thu,  7 Jul 2022 06:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34E8C62039;
        Thu,  7 Jul 2022 13:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D64C3411E;
        Thu,  7 Jul 2022 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657200561;
        bh=RfVt62RPQam+7duiaNm7NJAvinYhlayfk2ThiTDJKAA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UgEqLqgE3QhLQjrwY65XSjtSHcK/yUdSkE48ywULCNnlr3Hgo7d9bfUROaIokGl1n
         /LI2+ysz3JomTHI+lU13uPJdUhWSAm5w0U76cpQfctP+vDBMGiyTij2OE75SjihzQd
         q10L9DHA4Br1TfMwerLaPVOGQ1KWulMLbpAW5IwvtzSVWncLJwKgQIPwyJTFB4ZSDV
         GHEf4XQ7H7Ae5gR9nsYLj1UEKguqFq5GfyTx6lbT+p3reACG0o3i2Ga8Wt/wtK/QtN
         pDuG5+5TLzWuUCOF87bmrT3cQkkIHgvl/m6VHyUmUNqDgNs+tSFAY2ucONn09fQV5N
         RoYrOP7yNDuwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 301995C0458; Thu,  7 Jul 2022 06:29:21 -0700 (PDT)
Date:   Thu, 7 Jul 2022 06:29:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        wireguard@lists.zx2c4.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Suren Baghdasaryan <surenb@google.com>, rcu@vger.kernel.org,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Theodore Ts'o <tytso@mit.edu>, alexander.deucher@amd.com,
        Todd Kjos <tkjos@android.com>, uladzislau.rezki@sony.com,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: CONFIG_ANDROID (was: rcu_sched detected expedited stalls in
 amdgpu after suspend)
Message-ID: <20220707132921.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <1656421946.ic03168yc3.none@localhost>
 <20220628185437.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <1656443915.mdjoauhqe0.none@localhost>
 <YrtgeSmwLmpzN/zw@pc638>
 <79c6ad70-47d9-47fe-4bb4-33fcf356dd37@amd.com>
 <YsXK5A0MiVgHd8Je@pc638.lan>
 <20220706175836.GI1790663@paulmck-ThinkPad-P17-Gen-1>
 <YsXP7ZwHh/GvWM82@pc638.lan>
 <20220706204202.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <fbf83d60-67d3-698d-e2d2-02dc8d7e49c4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbf83d60-67d3-698d-e2d2-02dc8d7e49c4@amd.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 09:30:39AM +0200, Christian König wrote:
> Am 06.07.22 um 22:42 schrieb Paul E. McKenney:
> > On Wed, Jul 06, 2022 at 08:09:49PM +0200, Uladzislau Rezki wrote:
> > > On Wed, Jul 06, 2022 at 10:58:36AM -0700, Paul E. McKenney wrote:
> > > > On Wed, Jul 06, 2022 at 07:48:20PM +0200, Uladzislau Rezki wrote:
> > > > > Hello.
> > > > > 
> > > > > On Mon, Jul 04, 2022 at 01:30:50PM +0200, Christian König wrote:
> > > > > > Hi guys,
> > > > > > 
> > > > > > Am 28.06.22 um 22:11 schrieb Uladzislau Rezki:
> > > > > > > > Excerpts from Paul E. McKenney's message of June 28, 2022 2:54 pm:
> > > > > > > > > All you need to do to get the previous behavior is to add something like
> > > > > > > > > this to your defconfig file:
> > > > > > > > > 
> > > > > > > > > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=21000
> > > > > > > > > 
> > > > > > > > > Any reason why this will not work for you?
> > > > > > sorry for jumping in so later, I was on vacation for a week.
> > > > > > 
> > > > > > Well when any RCU period is longer than 20ms and amdgpu in the backtrace my
> > > > > > educated guess is that we messed up some timeout waiting for the hw.
> > > > > > 
> > > > > > We usually do wait a few us, but it can be that somebody is waiting for ms
> > > > > > instead.
> > > > > > 
> > > > > > So there are some todos here as far as I can see and It would be helpful to
> > > > > > get a cleaner backtrace if possible.
> > > > > > 
> > > > > Actually CONFIG_ANDROID looks like is going to be removed, so the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT
> > > > > will not have any dependencies on the CONFIG_ANDROID anymore:
> > > > > 
> > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2022%2F6%2F29%2F756&amp;data=05%7C01%7Cchristian.koenig%40amd.com%7C8b36bcb4fe61475c0eb708da5f8ffce8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637927369274030797%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=eaK66spsbWVi2uRhcFK7eu4usgkHFZCSvErZxB%2F2npM%3D&amp;reserved=0
> > > > But you can set the RCU_EXP_CPU_STALL_TIMEOUT Kconfig option, if you
> > > > wish.  Setting this option to 20 will get you the behavior previously
> > > > obtained by setting the now-defunct ANDROID Kconfig option.
> > > > 
> > > Right. Or over boot parameter. So for us it is not a big issue :)
> > Specifically rcupdate.rcu_exp_cpu_stall_timeout, for those just now
> > tuning in.  ;-)
> 
> I was just about to write a response asking for that :)
> 
> Thanks, I will suggest to our QA to add this parameter while doing some
> tests.

Very good!  Please let me know how it goes.

							Thanx, Paul
