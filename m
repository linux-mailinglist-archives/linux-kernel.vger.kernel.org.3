Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A557F5E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiGXPyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiGXPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8BDFD2D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8BB61151
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 15:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B4C3411E;
        Sun, 24 Jul 2022 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658678085;
        bh=/UIhFasVDsu284cyUeg7xTTVzwT3e9W7ftFk8kfS56s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V1hr/UNinQvJiEBZ4rYIIgce1UdeQD0du5OQbHSvKh3PhYvMLnXb4q7rOgeB0ihdf
         DZZWUVn4DYRM/ROA3DhKFQrigI4pTTBeEWAPJ+T9z+7zF0wlYlhvVL5xFeTWSyjdyo
         Cm4EqGshnNXKe3ReBXEgmf3ygOeWn5n5iI2tldiY=
Date:   Sun, 24 Jul 2022 17:54:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Ensure $Extend is a directory
Message-ID: <Yt1rQ8Ft5klOOENg@kroah.com>
References: <20220724132107.1163-1-soumya.negi97@gmail.com>
 <Yt1NVQEOC6Ki3eUI@kroah.com>
 <20220724153448.GA2608@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724153448.GA2608@Negi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 08:34:48AM -0700, Soumya Negi wrote:
> On Sun, Jul 24, 2022 at 03:47:01PM +0200, Greg KH wrote:
> > On Sun, Jul 24, 2022 at 06:21:07AM -0700, Soumya Negi wrote:
> > > Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
> > > https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
> > > 
> > > Check whether $Extend is a directory or not( for NTFS3.0+) while loading
> > > system files. If it isn't(as in the case of this bug where the mft record for
> > > $Extend contains a regular file), load_system_files() returns false.
> > 
> > Please wrap your changelog text at 72 columns like your editor asked you
> > to when writing this :)
> 
> I will correct the changelog(Don't think I can wrap the bug report
> link. Checkpatch will still give a warning. Is that okay?).

Yes, do not wrap links.

> > > Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
> > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > 
> > What commit caused this problem?  What Fixes: tag should go here?
> 
> I don't think this was caused by any specific commit.The $Extend
> directory check is not present in any previous releases. Syzbot has
> also not been able to produce a cause bisection for the bug. So no fixes
> tag(please correct me if I am wrong).
> 
> > Should it go to stable kernels?  If so, how far back?
> 
> Since the NTFS extension file was new to NTFS 3.0, perhaps the patch 
> should apply all the way back to the first release with NTFS3.0 support?

Yes, mark it there.

thanks,

greg k-h
