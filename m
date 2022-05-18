Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C438952AFAA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiERBLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiERBKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:10:35 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CC454037
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cLufi8C/pq1tC35Pcp/4ka+TGfK85l6KoqVAtPpSvf4=; b=UUgPsBo7H8EQXUiXLMMgVdFODt
        R+qLt6G/xo3toa9DRsheJZ7XCypnVf0M5oiHiqVSfqFSxTqeEnHTfTevPqcPZgqfaoBj0VmZofA5E
        KCGVmctdp7Z17cq2ori14obWPglUN+r9uXPy1r9vZl6VK7IW/L+CFgZrXPhSTHe3XFRfJ6njo+YEK
        orEQczb/TilzQTsbYr7qUrusWB3MN/4Bmz92D7sqjAK4WiKHN5Y2nZHF+PPtMf+z+1CMvAeo6ed4H
        hVyV5rlLjlyEr8UjnnBlrZjqFnX+J1im86n0PLCZbmyI50/n17VpK7+gHJPITn7UiXHpMRwT0JVc2
        hR2zsigg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr8Ci-00FtLQ-S6; Wed, 18 May 2022 01:10:20 +0000
Date:   Wed, 18 May 2022 01:10:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
 <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 12:59:46AM +0000, Al Viro wrote:
> On Tue, May 17, 2022 at 10:58:15PM +0000, Al Viro wrote:
> > On Tue, May 17, 2022 at 03:49:07PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > WARNING in mntput_no_expire
> > 
> > Obvious question: which filesystem it is?
> 
> FWIW, can't reproduce here - at least not with C reproducer +
> -rc7^ kernel + .config from report + debian kvm image (bullseye,
> with systemd shite replaced with sysvinit, which might be relevant).
> 
> In case systemd-specific braindamage is needed to reproduce it...
> Hell knows; at least mount --make-rshared / doesn't seem to suffice.

... doesn't reproduce with genuine systemd either.  FWIW, 4-way SMP
setup here.
