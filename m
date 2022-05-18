Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B628C52B195
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiEREjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiEREjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:39:00 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167221AF36
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Frr7iq1y+UJhPlYAY8KhVNFf095C/C0t0IbalkW0Sw4=; b=emH+mRQZHfdEYo6gjHiNujimgV
        E9d/R/zY97B073xnLjHsXcUKqvHZqeT/v9eDWVn++VOL6BxlH9pcG9hfv6tGX5/s6rf20WnG8cERj
        CGy83QUUHBvNVkoSZOrJN92LU1wx1RB7GyzNeSNDKrK/8v+4mn0cPcFt0PiWm98OMrtoKPK+KKTkK
        PKzyYgin1wnFEb8TcKZ/7HoxrnJttI9gXmkjjsKQgo5A+V9Nr2OyRFKwDI7V+xTJrgyGAUfmA93v2
        FhepXARl0Iu77IjClaPFVMpYMRuvVLWErdeO4TO7/DpuexqgWo/I7PK0POa9bF/NWESkln6kwA7Yb
        fwP8d3RA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrBSX-00FvtZ-Ry; Wed, 18 May 2022 04:38:54 +0000
Date:   Wed, 18 May 2022 04:38:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoR4XSN2fn2BjkXw@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
 <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
 <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
 <YoRS0L0ywSZkflq7@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoRS0L0ywSZkflq7@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:58:40AM +0000, Al Viro wrote:
> On Wed, May 18, 2022 at 01:10:20AM +0000, Al Viro wrote:
> > On Wed, May 18, 2022 at 12:59:46AM +0000, Al Viro wrote:
> > > On Tue, May 17, 2022 at 10:58:15PM +0000, Al Viro wrote:
> > > > On Tue, May 17, 2022 at 03:49:07PM -0700, syzbot wrote:
> > > > > Hello,
> > > > > 
> > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > WARNING in mntput_no_expire
> > > > 
> > > > Obvious question: which filesystem it is?
> > > 
> > > FWIW, can't reproduce here - at least not with C reproducer +
> > > -rc7^ kernel + .config from report + debian kvm image (bullseye,
> > > with systemd shite replaced with sysvinit, which might be relevant).
> > > 
> > > In case systemd-specific braindamage is needed to reproduce it...
> > > Hell knows; at least mount --make-rshared / doesn't seem to suffice.
> > 
> > ... doesn't reproduce with genuine systemd either.  FWIW, 4-way SMP
> > setup here.
> 
> OK, reproduced...

FWIW, it smells like something (cgroup?) fucking up percpu allocation/freeing.
Note that struct mount has both refcount and writers count held in percpu;
replacing the refcount with atomic_t gets rid of seeing negative refcount
in mntput_no_expire(), but leaves negative writers count caught in
cleanup_mnt(); turn that from WARN_ON into printk and we get past that,
only to see
	percpu ref (css_release) <= 0 (-4294967294)
immediately afterwards.

IOW, it looks like we are getting not messed refcounting on either side,
but same refcount physically shared by unrelated objects.
