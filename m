Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACC753087D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiEWEsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiEWEsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:48:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66CA1209C
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 21:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60C27B80EEA
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F39C385AA;
        Mon, 23 May 2022 04:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653281299;
        bh=UAsQaM3XapPuVS8owCcWhOqf2ldnFQUOPTmA49wofLw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hKBgwlySIzKch9x8LZ086v01hxYtPmJ++Xy69xLtC6JNIArX6eTE+GpsIcSDWoaV6
         +/4lok4Z4/LJbdFAHGnHBOC3u83i6dIcKS/iG33d08PDn3zV7lzlcxV+YAiJJJfxFF
         Pn2mjfWGqa601qXuq/F8F1SDgXCbxLb0NMDf44cjAKYABJt17RNkV3+P+89KJtJTrJ
         xTRbHD+ZBGfxZZqE2tHizQ2G7tY8VWiTlVkSTpqljdgRwo9FVRE/yUGWvU0UliML+8
         HT7pzzeb3FvZLkKlQ/NU0X+iLZWO8HmaowwfHcf1fai6TunBVlKt/qOFMe9RJRm4Rn
         WxIKWP8Er6cZg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8AE4D5C033A; Sun, 22 May 2022 21:48:18 -0700 (PDT)
Date:   Sun, 22 May 2022 21:48:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>,
        regressions@lists.linux.dev, riel@surriel.com,
        viro@zeniv.linux.org.uk
Subject: Re: vchiq: Performance regression since 5.18-rc1
Message-ID: <20220523044818.GS1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <20220521234616.GO1790663@paulmck-ThinkPad-P17-Gen-1>
 <bfad3d08-3268-5528-17c1-c17ef3949d96@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfad3d08-3268-5528-17c1-c17ef3949d96@i2se.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 05:11:36PM +0200, Stefan Wahren wrote:
> Hi Paul,
> 
> Am 22.05.22 um 01:46 schrieb Paul E. McKenney:
> > On Sun, May 22, 2022 at 01:22:00AM +0200, Stefan Wahren wrote:
> > > Hi,
> > > 
> > > while testing the staging/vc04_services/interface/vchiq_arm driver with my
> > > Raspberry Pi 3 B+ (multi_v7_defconfig) i noticed a huge performance
> > > regression since [ff042f4a9b050895a42cae893cc01fa2ca81b95c] mm:
> > > lru_cache_disable: replace work queue synchronization with synchronize_rcu
> > > 
> > > Usually i run "vchiq_test -f 1" to see the driver is still working [1].
> > > 
> > > Before commit:
> > > 
> > > real    0m1,500s
> > > user    0m0,068s
> > > sys    0m0,846s
> > > 
> > > After commit:
> > > 
> > > real    7m11,449s
> > > user    0m2,049s
> > > sys    0m0,023s
> > > 
> > > Best regards
> > > 
> > > [1] - https://github.com/raspberrypi/userland
> > Please feel free to try the patch shown below.  Or the pair of patches
> > from Rik here:
> > 
> > https://lore.kernel.org/lkml/20220218183114.2867528-2-riel@surriel.com/
> > https://lore.kernel.org/lkml/20220218183114.2867528-3-riel@surriel.com/
> 
> I tried your patch and Rik's patches but in both cases vchiq_test runs 7
> minutes instead of ~ 1 second.

That is surprising.  Do you boot with rcupdate.rcu_normal=1?  That would
nullify my patch, but I would expect that Rik's patch would still provide
increased performance even in that case.

Could you please characterize where the slowdown is occurring?

							Thanx, Paul

> Best regards
> 
> > 
> > There is work ongoing to produce something better, but ongoing slowly.
> > Especially my part of that work.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  From paulmck@kernel.org Mon Feb 14 11:05:49 2022
> > Date: Mon, 14 Feb 2022 11:05:49 -0800
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > To: clm@fb.com
> > Cc: riel@surriel.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
> > 	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
> > Subject: [PATCH RFC fs/namespace] Make kern_unmount() use
> >   synchronize_rcu_expedited()
> > Message-ID: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
> > Reply-To: paulmck@kernel.org
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=us-ascii
> > Content-Disposition: inline
> > Status: RO
> > Content-Length: 1036
> > Lines: 32
> > 
> > Experimental.  Not for inclusion.  Yet, anyway.
> > 
> > Freeing large numbers of namespaces in quick succession can result in
> > a bottleneck on the synchronize_rcu() invoked from kern_unmount().
> > This patch applies the synchronize_rcu_expedited() hammer to allow
> > further testing and fault isolation.
> > 
> > Hey, at least there was no need to change the comment!  ;-)
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > Not-yet-signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > ---
> > 
> >   namespace.c |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 40b994a29e90d..79c50ad0ade5b 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -4389,7 +4389,7 @@ void kern_unmount(struct vfsmount *mnt)
> >   	/* release long term mount so mount point can be released */
> >   	if (!IS_ERR_OR_NULL(mnt)) {
> >   		real_mount(mnt)->mnt_ns = NULL;
> > -		synchronize_rcu();	/* yecchhh... */
> > +		synchronize_rcu_expedited();	/* yecchhh... */
> >   		mntput(mnt);
> >   	}
> >   }
> > 
