Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C422158179D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiGZQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiGZQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F12022284
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E34F61596
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 16:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DECC433D6;
        Tue, 26 Jul 2022 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658853621;
        bh=SqugJWMS0G3TH6g4CPPFAQmpuiXRP4YIautk74KGKR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pPEOsM587tS/xIay3ZUHlfGxy9/L4Znb20on1v4gJRiMyCq4/x/GhieD6rjJ8T6EY
         PR2oXMu68VV0nqkMf8HNX03jqgs2xo7+wLhpdmwU9hEzKdvZI7jSKZeVAvFgijQs2S
         lY1BJtR9LE2ByL28lHKroDNXMOtJZZygVa8W4NiA=
Date:   Tue, 26 Jul 2022 18:40:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: Ensure $Extend is a directory
Message-ID: <YuAY82/guMFRnfHu@kroah.com>
References: <20220724132107.1163-1-soumya.negi97@gmail.com>
 <Yt1NVQEOC6Ki3eUI@kroah.com>
 <20220724153448.GA2608@Negi>
 <Yt1rQ8Ft5klOOENg@kroah.com>
 <20220724221745.GB2608@Negi>
 <20220725190656.GA14927@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725190656.GA14927@Negi>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 12:06:56PM -0700, Soumya Negi wrote:
> Hi,
> 
> On Sun, Jul 24, 2022 at 03:17:45PM -0700, Soumya Negi wrote:
> > On Sun, Jul 24, 2022 at 05:54:43PM +0200, Greg KH wrote:
> > > On Sun, Jul 24, 2022 at 08:34:48AM -0700, Soumya Negi wrote:
> > > > On Sun, Jul 24, 2022 at 03:47:01PM +0200, Greg KH wrote:
> > > > > On Sun, Jul 24, 2022 at 06:21:07AM -0700, Soumya Negi wrote:
> > > > > > Fixes Syzbot bug: kernel BUG in ntfs_lookup_inode_by_name
> > > > > > https://syzkaller.appspot.com/bug?id=32cf53b48c1846ffc25a185a2e92e170d1a95d71
> > > > > > 
> > > > > > Check whether $Extend is a directory or not( for NTFS3.0+) while loading
> > > > > > system files. If it isn't(as in the case of this bug where the mft record for
> > > > > > $Extend contains a regular file), load_system_files() returns false.
> > > > > 
> > > > > Please wrap your changelog text at 72 columns like your editor asked you
> > > > > to when writing this :)
> > > > 
> > > > I will correct the changelog(Don't think I can wrap the bug report
> > > > link. Checkpatch will still give a warning. Is that okay?).
> > > 
> > > Yes, do not wrap links.
> > > 
> > > > > > Reported-by: syzbot+30b7f850c6d98ea461d2@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > > > > 
> > > > > What commit caused this problem?  What Fixes: tag should go here?
> > > > 
> > > > I don't think this was caused by any specific commit.The $Extend
> > > > directory check is not present in any previous releases. Syzbot has
> > > > also not been able to produce a cause bisection for the bug. So no fixes
> > > > tag(please correct me if I am wrong).
> > > > 
> > > > > Should it go to stable kernels?  If so, how far back?
> > > > 
> > > > Since the NTFS extension file was new to NTFS 3.0, perhaps the patch 
> > > > should apply all the way back to the first release with NTFS3.0 support?
> > 
> > > Yes, mark it there.
> > 
> > Thanks. I will send v2 of the patch. Just want to make sure that the
> > patch will apply to 2.6.11.y before marking it.
> 
> 2.6.11 is where I think NTFS3.0 support was first present and till where
> the patch should go. But I am not able to build 2.6.11 on my system and
> test the patch. I tried the patch on 4.14 and it works. Should I mark it
> to be backported till 4.14 instead?

Say 4.9 and you will get an email saying it failed to apply there when
it gets merged into Linus's tree, and then you can provide a working
patch for us to add to stable.

thanks,

greg k-h
