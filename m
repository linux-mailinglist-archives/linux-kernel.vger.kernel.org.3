Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478345214E6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbiEJMO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiEJMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:14:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1C4B43C;
        Tue, 10 May 2022 05:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A82AB81A0A;
        Tue, 10 May 2022 12:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2A8C385A6;
        Tue, 10 May 2022 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652184642;
        bh=DpHjuqVa+SSlkOsM/Gej0YHbCu1wZMGTmd4rbhVUBqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6PjO9Ow4kq9o7cWrnq2GFU5qa9QpEuWuWHq1GreqkvmbEABkI24Doocn1CkwAc9t
         bNAOVxVTY/DP5mjRphxpzPQjJenPUkiTIEgYWhRTkAukpn/pTwmJnj/IwEQo+EH7fk
         0GanbfHet/iJ8P9I6jsZp4rvq9ZRWAykdEAYyX28=
Date:   Tue, 10 May 2022 14:10:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        sumit.semwal@linaro.org, daniel.vetter@ffwll.ch,
        tjmercier@google.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmabuf: ensure unique directory name for dmabuf stats
Message-ID: <YnpWNSdAQzG80keQ@kroah.com>
References: <1652178212-22383-1-git-send-email-quic_charante@quicinc.com>
 <YnpF1XP1tH83uBlM@kroah.com>
 <039e1acc-8688-2e06-1b2a-1acbe813b91e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <039e1acc-8688-2e06-1b2a-1acbe813b91e@amd.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:35:41PM +0200, Christian König wrote:
> Am 10.05.22 um 13:00 schrieb Greg KH:
> > On Tue, May 10, 2022 at 03:53:32PM +0530, Charan Teja Kalla wrote:
> > > The dmabuf file uses get_next_ino()(through dma_buf_getfile() ->
> > > alloc_anon_inode()) to get an inode number and uses the same as a
> > > directory name under /sys/kernel/dmabuf/buffers/<ino>. This directory is
> > > used to collect the dmabuf stats and it is created through
> > > dma_buf_stats_setup(). At current, failure to create this directory
> > > entry can make the dma_buf_export() to fail.
> > > 
> > > Now, as the get_next_ino() can definitely give a repetitive inode no
> > > causing the directory entry creation to fail with -EEXIST. This is a
> > > problem on the systems where dmabuf stats functionality is enabled on
> > > the production builds can make the dma_buf_export(), though the dmabuf
> > > memory is allocated successfully, to fail just because it couldn't
> > > create stats entry.
> > Then maybe we should not fail the creation path of the kobject fails to
> > be created?  It's just for debugging, it should be fine if the creation
> > of it isn't there.
> 
> Well if it's just for debugging then it should be under debugfs and not
> sysfs.

I'll note that the original patch series for this described why this was
moved from debugfs to sysfs.

> > > This issue we are able to see on the snapdragon system within 13 days
> > > where there already exists a directory with inode no "122602" so
> > > dma_buf_stats_setup() failed with -EEXIST as it is trying to create
> > > the same directory entry.
> > > 
> > > To make the directory entry as unique, append the inode creation time to
> > > the inode. With this change the stats directory entries will be in the
> > > format of: /sys/kernel/dmabuf/buffers/<inode no>-<inode creation time in
> > > secs>.
> > As you are changing the format here, shouldn't the Documentation/ABI/
> > entry for this also be changed?
> 
> As far as I can see that is even an UAPI break, not sure if we can allow
> that.

Why?  Device names change all the time and should never be static.  A
buffer name should just be a unique identifier in that directory, that's
all.  No rules on the formatting of it unless for some reason the name
being the inode number was somehow being used in userspace for that
number?

thanks,

greg k-h
