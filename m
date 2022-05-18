Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BA652B058
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiERB6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 21:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiERB6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:58:46 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0804F340C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j23IKT8AReeydsEeJtOMrkt6EF8d6kyrYRtSyXUiq64=; b=QiacaCmmX72WLCEwp4mJWLgQkl
        WBDDDMyVrQvQPO3rLcU8gb4rFcX7QDR5SkbU8rt1Z64UqB3PZTuSf8ZCIVioNk3VmJk1426lWv5IA
        Ietp4fomDkXKbdEtiJpvNb9g+qwrG7MVcS6pzH7L6O0iH55JMUq3wxbC83YEXlucJKiUjM0WDUk+W
        bxHl1P/XkNZzmtHRkRktR8dc7FA8m2H+CqrHQ9aCpvIpLWoAxOu6MS8g4alDS4AZWwkScPkTED4BW
        3ONiBlRom1bEO4nwyiNDPHF/sj8xPDJpM5pH9rGHhNyaCYii/XGS98bI+fA4lhRjGBYx2MywdZouL
        hWUB/f3g==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr8xU-00FtoS-Ci; Wed, 18 May 2022 01:58:40 +0000
Date:   Wed, 18 May 2022 01:58:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoRS0L0ywSZkflq7@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
 <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
 <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoRHfB7lEGUwQBGU@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:10:20AM +0000, Al Viro wrote:
> On Wed, May 18, 2022 at 12:59:46AM +0000, Al Viro wrote:
> > On Tue, May 17, 2022 at 10:58:15PM +0000, Al Viro wrote:
> > > On Tue, May 17, 2022 at 03:49:07PM -0700, syzbot wrote:
> > > > Hello,
> > > > 
> > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > WARNING in mntput_no_expire
> > > 
> > > Obvious question: which filesystem it is?
> > 
> > FWIW, can't reproduce here - at least not with C reproducer +
> > -rc7^ kernel + .config from report + debian kvm image (bullseye,
> > with systemd shite replaced with sysvinit, which might be relevant).
> > 
> > In case systemd-specific braindamage is needed to reproduce it...
> > Hell knows; at least mount --make-rshared / doesn't seem to suffice.
> 
> ... doesn't reproduce with genuine systemd either.  FWIW, 4-way SMP
> setup here.

OK, reproduced...
