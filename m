Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C4B52AF87
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbiERA7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiERA7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:59:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C253E27
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LgIjDtBQpFBrENj6VbFyHMMW2z501ieHPJxwW4vt6IY=; b=AXM7nRw0MND0XtX8DC8rzTYHC5
        MprcANc1zlhlySUUGasV5ViOpIn8Gmg8dR4u+BC5LjK8sh+WhLj7CoVHSjW0sXxq0GEA0A1LjidL8
        ulkJptXi0hRFQsq8k0qShNsenPm6Q/4JUUxswAXRgk7L3MtLGx4fFcRimeCpQwV/flH43yjoLji5v
        EjF6g5SoQVcxUYKTph5Buii/p+drObuVOr3tT6FDvyJmIBiMKALzUcDMTUDV9yVO8HoYYBCeOD6ue
        KN2Ye+siSYZCYHKa87C9pba5CWiOQtznXVlxGhPqJ6LcrdEYX75bgKK9mtGSXHtBwlJUvWbZ1RYfD
        QQ0swnTg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr82U-00FtEn-RP; Wed, 18 May 2022 00:59:46 +0000
Date:   Wed, 18 May 2022 00:59:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     syzbot <syzbot+5b1e53987f858500ec00@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in mntput_no_expire (3)
Message-ID: <YoRFAoe99ob/YzD5@zeniv-ca.linux.org.uk>
References: <20220517223806.2299-1-hdanton@sina.com>
 <000000000000be329205df3cf252@google.com>
 <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoQohxAFD3EPujRC@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 10:58:15PM +0000, Al Viro wrote:
> On Tue, May 17, 2022 at 03:49:07PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > WARNING in mntput_no_expire
> 
> Obvious question: which filesystem it is?

FWIW, can't reproduce here - at least not with C reproducer +
-rc7^ kernel + .config from report + debian kvm image (bullseye,
with systemd shite replaced with sysvinit, which might be relevant).

In case systemd-specific braindamage is needed to reproduce it...
Hell knows; at least mount --make-rshared / doesn't seem to suffice.
