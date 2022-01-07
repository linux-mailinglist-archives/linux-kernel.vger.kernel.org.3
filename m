Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B64E487693
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347139AbiAGLdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiAGLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:33:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB15AC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 03:33:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86910B825E6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989B4C36AE0;
        Fri,  7 Jan 2022 11:33:02 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:32:54 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, qhjin_dev@163.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] minix: fix bug when opening a file with O_DIRECT will
Message-ID: <20220107113254.bkfpud453zivotov@wittgenstein>
References: <20220106033042.347301-1-qhjin.dev@gmail.com>
 <20220106110028.jxicjy245ypdqejb@quack3.lan>
 <CACL7WEN+eBW2MFGCti-NAzxAZAKXkjJ2F+6=eGqX0UdcAzw8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACL7WEN+eBW2MFGCti-NAzxAZAKXkjJ2F+6=eGqX0UdcAzw8Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:12:39AM +0800, Qinghua Jin wrote:
> On Thu, Jan 6, 2022 at 11:43 PM Jan Kara <jack@suse.cz> wrote:
> 
> > On Thu 06-01-22 11:30:41, Qinghua Jin wrote:
> > > Testcase:
> > > 1. create a minix file system and mount it
> > > 2. open a file on the file system with O_RDWR|O_CREAT|O_TRUNC|O_DIRECT
> > > 3. open fails with -EINVAL but leaves an empty file behind. All other
> > > open() failures don't leave the failed open files behind.
> > >
> > > It is hard to check the direct_IO op before creating the inode. Just as
> > > ext4 and btrfs do, this patch will resolve the issue by allowing to
> > > create the file with O_DIRECT but returning error when writing the file.
> > >
> > > Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
> >
> > The patch looks good. Thanks. Feel free to add:
> >
> > Reviewed-by: Jan Kara <jack@suse.cz>
> >
> > Just out of curiosity: Do you happen to really use minix filesystem or was
> > this just a fallout from some fuzz testing or something like that?
> >
> > Thanks, It's a bug reported by colin.king@canonical.com
> https://bugzilla.kernel.org/show_bug.cgi?id=213041
> I don't include the email because it's not reachable.

Fwiw, Colin's now at Intel:
Colin Ian King <colin.king@intel.com>

(While I'm here:
 Acked-by: Christian Brauner <christian.brauner@ubuntu.com>)
