Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD7354A308
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235049AbiFNADf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiFNADb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B530F74
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C74C9615AC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE55C3411C;
        Tue, 14 Jun 2022 00:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655165010;
        bh=iyIDkHo2s8/FE2r6fguSYpCuIOod+aXYVpPytIedWV0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kVdA9E2aqs39u4Oay1C3yNWqXr3JbF1IojtqbNsWyFNIaxT9WDO/XvHsUOBGbUfVX
         MJzg0kc+V9Fw/bHK6+hZknc1E5/GfxjinJ8coym372Tk0jv+ik2VGHZS/EUJ+7KbQl
         pcazehgOjWOe7Js9hx1dqZXZpM8VsVYdVS33OCDK58swDuf+4wZlUwyGMhUsCk4OUd
         NSkgsonIQc8wGnwdTC3yqwgKNRkF7pTDUj6IOmtvPlQj2i02w1UvLDFn2+Tn/yT+VL
         y41GY4lGp/SLEyAy7EfuX5j2NeMmXamktmoh1WVL0tJuyMTIyO9S0+sDde/Xji2J97
         wmajTCdtqQXuA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BA0DB5C02F9; Mon, 13 Jun 2022 17:03:29 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:03:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
Message-ID: <20220614000329.GO1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220613233753.GK1790663@paulmck-ThinkPad-P17-Gen-1>
 <202206131639.DBA0A8D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202206131639.DBA0A8D@keescook>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 04:42:07PM -0700, Kees Cook wrote:
> On Mon, Jun 13, 2022 at 10:36:07AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> > 
> > Reported-and-tested-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> 
> Looks like the patch solved the reproducer. :)

For one of the two possible ways to make the bug happen.  ;-)

Still, good on Qiang for identifying one of the paths!  Not just anyone
can do that.

							Thanx, Paul

> > Tested on:
> > 
> > commit:         6d0c8068 Add linux-next specific files for 20220610
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git next-20220610
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12d068eff00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=147f47c8080000
> > 
> > Note: testing is done by a robot and is best-effort only.
> 
> You can see the dashboard link above for testing details...
> 
> -- 
> Kees Cook
