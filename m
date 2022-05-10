Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF76521304
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiEJLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbiEJLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:04:45 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55D625F8;
        Tue, 10 May 2022 04:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13D30CE1DE4;
        Tue, 10 May 2022 11:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03059C385C6;
        Tue, 10 May 2022 11:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652180440;
        bh=KGn/TH6jy9oduWBq+vUyZA4hXFzpFADN7M2aHHBomVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q9ZSbEHxwZJxQeNu7bI2Robwy7il5VzTxxOECL3cPkvfGe0WN0mtjG8zRwMIzCYl7
         ZSjjbchKlOnplbqU313WHo2QStErWJ5w9+fD1HGuwsty8QL6b/jahAo6Oc4gOtv4Sm
         0c4ydpG14hkHmQ9WMfvQ2BcFulY993U/4gdpQ1W8=
Date:   Tue, 10 May 2022 13:00:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, tjmercier@google.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmabuf: ensure unique directory name for dmabuf stats
Message-ID: <YnpF1XP1tH83uBlM@kroah.com>
References: <1652178212-22383-1-git-send-email-quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652178212-22383-1-git-send-email-quic_charante@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:53:32PM +0530, Charan Teja Kalla wrote:
> The dmabuf file uses get_next_ino()(through dma_buf_getfile() ->
> alloc_anon_inode()) to get an inode number and uses the same as a
> directory name under /sys/kernel/dmabuf/buffers/<ino>. This directory is
> used to collect the dmabuf stats and it is created through
> dma_buf_stats_setup(). At current, failure to create this directory
> entry can make the dma_buf_export() to fail.
> 
> Now, as the get_next_ino() can definitely give a repetitive inode no
> causing the directory entry creation to fail with -EEXIST. This is a
> problem on the systems where dmabuf stats functionality is enabled on
> the production builds can make the dma_buf_export(), though the dmabuf
> memory is allocated successfully, to fail just because it couldn't
> create stats entry.

Then maybe we should not fail the creation path of the kobject fails to
be created?  It's just for debugging, it should be fine if the creation
of it isn't there.

> 
> This issue we are able to see on the snapdragon system within 13 days
> where there already exists a directory with inode no "122602" so
> dma_buf_stats_setup() failed with -EEXIST as it is trying to create
> the same directory entry.
> 
> To make the directory entry as unique, append the inode creation time to
> the inode. With this change the stats directory entries will be in the
> format of: /sys/kernel/dmabuf/buffers/<inode no>-<inode creation time in
> secs>.

As you are changing the format here, shouldn't the Documentation/ABI/
entry for this also be changed?

And what's to keep the seconds field from also being the same?

thanks,

greg k-h
