Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413AF53F1C8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbiFFVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbiFFVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2AC63514
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68FB961423
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 21:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C892C385A9;
        Mon,  6 Jun 2022 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654551278;
        bh=4pZAYpwL1o6QGQv6UYh6ppBBuj4+Hz9W0scDPKxlZu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujiPq0WMDaHcR5ZNZQYFa2EerJsX79bn1BQ2COnT4RAmeTPbjqa1U/ELivqk1hB1B
         SGlbFJLW/+p6fslKRA6IHW4313Suf7R/iTGeaM+xKXWwtXkvahrPbSmqcXXARX4AuU
         o5wCwzoiC+wWgQNcraQ6yqjQ23eRA6Ug1rcSRAnDtTOBC8FJ7qoiM6/ow9I10lE4zG
         aLPDRigT5IRv9u/NCfEZjdLsL9zu2QoHmaQjbnH2E9rMZ+hSnO+cyPSBjgXeddcjmP
         P2fddzpiqAvvjEKdP8qlVgHnbvpe8PqI9LP4rI0QavO7bz8T43qJSBkwNbauKR1j7x
         vtzu1TJe3zoeA==
Date:   Mon, 6 Jun 2022 14:34:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [syzbot] WARNING in register_shrinker_prepared
Message-ID: <Yp5y7NoNP9WF6vCS@sol.localdomain>
References: <000000000000db448c05e0caa5ba@google.com>
 <20220606122302.dc265509ca896073e98049a3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606122302.dc265509ca896073e98049a3@linux-foundation.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 12:23:02PM -0700, Andrew Morton wrote:
> (cc Roman)
> 
> On Mon, 06 Jun 2022 10:17:34 -0700 syzbot <syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    1cfd968b58a1 Add linux-next specific files for 20220603
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f7b6b3f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7da8386e3742814f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=300d27c79fe6d4cbcc39
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103e5177f00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13545057f00000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+300d27c79fe6d4cbcc39@syzkaller.appspotmail.com
> > 
> > loop0: detected capacity change from 0 to 20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 3694 at mm/vmscan.c:681 register_shrinker_prepared+0x119/0x150 mm/vmscan.c:681
> 
> That's
> 
> 	WARN_ON_ONCE(shrinker_debugfs_add(shrinker));
> 
> I assume that debugfs_create_dir() failed.  Please see the NOTE: in
> that function's kerneldoc.
> 

The call to ida_alloc() can fail too.

register_shrinker_prepared() is not allowed to fail; anything that can fail must
happen in prealloc_shrinker().  So either this new debugfs registration code
needs to be moved to prealloc_shrinker(), or errors from it need to be ignored
(which might be appropriate since it is just debugfs).

- Eric
