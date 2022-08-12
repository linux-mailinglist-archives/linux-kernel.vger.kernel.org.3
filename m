Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00C3591216
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiHLOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiHLOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 10:18:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A788DEE
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 07:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75279611F3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 14:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFECC433C1;
        Fri, 12 Aug 2022 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660313934;
        bh=LKSX97qIpVp1SoIQq8FuEbRs7glpftMTG5SDJwbiRRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLy6Ga5NCs8KJ1DyouPpdSmXKHe6AD/x2Ak9/dfV7GiW2WT1enm/hwQ8mJMPH0Sur
         yKvE86TrV7TEEgX+UP0sF6ohR1WSU0DadSbzXAhKU8lMyxThI6B5yTsNYD2gbBjChB
         BfHCrf3xfYxn7FSTVgaccqqkGe3SFz97NqvHTFcsBbpQPrQczYc1PIXMvNic2Qk727
         NRks6WRjrWcf2cK7HAsjfwxPufkVjwKEqDQBJiG1L1YEqp4xTKbULzrWE4P2r8N3JH
         HGP+NBY4aNkL/tAsvPD2mAXs4egJTre21YBZBxRoaJPAxUXMI5FVDJt1r0VU19wsQI
         9ao5BpmPK4gmw==
Date:   Fri, 12 Aug 2022 16:18:49 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: binderfs: fix memory leak in binderfs_fill_super
Message-ID: <20220812141849.nhwpvg6vte22lg2s@wittgenstein>
References: <20220812132124.2053673-1-dzm91@hust.edu.cn>
 <20220812134138.gpu7274yahlvr6hr@wittgenstein>
 <CAD-N9QWSwoLw9nvaQieUCPZoAYXyNTymUVOzKOTUOfC38FkXnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD-N9QWSwoLw9nvaQieUCPZoAYXyNTymUVOzKOTUOfC38FkXnA@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 09:48:40PM +0800, Dongliang Mu wrote:
> On Fri, Aug 12, 2022 at 9:41 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Aug 12, 2022 at 09:21:24PM +0800, Dongliang Mu wrote:
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > In binderfs_fill_super, if s_root is not successfully initialized by
> > > d_make_root, the previous allocated s_sb_info will not be freed since
> > > generic_shutdown_super first checks if sb->s_root and then does
> > > put_super operation. The put_super operation calls binderfs_put_super
> > > to deallocate s_sb_info and put ipc_ns. This will lead to memory leak
> > > in binderfs_fill_super.
> > >
> > > Fix this by invoking binderfs_put_super at error sites before s_root
> > > is successfully initialized.
> > >
> > > Fixes: 095cf502b31e ("binderfs: port to new mount api")
> > > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> >
> > Seems right but where's the full syzbot link to the issue?
> > Also, wouldn't (untested) sm like the below be better?:
> 
> I originally would like to change the order to object initialization,
> but I am not sure if they can be exchanged since many *_fill_super are
> ended with d_make_root.
> 
> If you are sure about this exchange, I can resubmit a v2 patch.

I think we should just always clean up the allocated memory in
binderfs_fill_super() when d_make_root() fails and before via a goto
block after the successful return. So we keep the cleanup in
binderfs_fill_super() consistent and restricted to a single location.
