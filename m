Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676354AF31E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiBINmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiBINmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:42:13 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECDAC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644414136; x=1675950136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KNOrCxYQ76BbX5W2PuU+ObMnxpkvaWpKKPP8sBWs9fc=;
  b=GQhd+JCrVkjAFMKOE/hEvXHD8LBB/Cg7JGs8HpomjR8C6A9hFDfOA2Yh
   cQkb3ZIdVDjusKNr6bUTpZAwjy1/Vc5THZsx0I6VEJv8ZXMFNfrTghuXe
   T2qlLDJH2MWLa5B01F4o+23ibbKg7N8D729JEpWyTMxqpa6m0//zjuKJQ
   AM4p+qoIsfovExuRvihzhq2ihk90nc1iE0PUnadRI7pUuhAxnNL1t7o/f
   zwf28cTDXzlvs9JcPz/jZcd7Ah06sqt5i9SiD2O9vejZcP0NQyVRhj2pB
   3DjaX+TcAa7ZgvmqRkfx/oeNTq5kEMqggg1sxjsVdxDGdSe2Nxbu8ls+t
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229851755"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="229851755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="678590566"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 09 Feb 2022 05:42:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 09 Feb 2022 15:42:12 +0200
Date:   Wed, 9 Feb 2022 15:42:12 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     syzbot <syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in component_del
Message-ID: <YgPEtCGDlSrqa1fK@kuha.fi.intel.com>
References: <00000000000016f4ae05d5cec832@google.com>
 <000000000000a17f2305d77f4cb7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a17f2305d77f4cb7@google.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 02:37:10AM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 8c67d06f3fd9639c44d8147483fb1c132d71388f
> Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Date:   Thu Dec 23 08:23:49 2021 +0000
> 
>     usb: Link the ports to the connectors they are attached to
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14063168700000
> start commit:   555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16063168700000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12063168700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=266de9da75c71a45
> dashboard link: https://syzkaller.appspot.com/bug?extid=60df062e1c41940cae0f
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15880d84700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de0c77b00000
> 
> Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
> Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I'm guessing the component_add() is failing in this case. So I guess
we need to consider the component_add() failures fatal in
drivers/usb/core/port.c, which is a bit of a bummer. I'll send the
fix.

-- 
heikki
