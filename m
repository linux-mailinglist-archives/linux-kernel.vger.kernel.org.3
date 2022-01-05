Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42376485588
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiAEPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:13:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51674 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiAEPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:13:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F4A61796;
        Wed,  5 Jan 2022 15:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56238C36AE3;
        Wed,  5 Jan 2022 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641395591;
        bh=csHd2/XILH40OtDlIaymp0IPflgaFvIcWeXacWTGf88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIm66gBBLhBxMefhANoTb1PxtN7iaJ8FKqlY0bi88E2irezQd9yT6f26Xth+cC8dp
         Lej17FBhU8KKBDCE+PQdCdVnQQW+1aJS5wOR06l76gXG3b7x7MdxEtgswElM7eZXuB
         pQ8ee1pUlmh3Wf65OXlQyoXfIXAk1noEqLrfxEa0=
Date:   Wed, 5 Jan 2022 16:13:08 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, surenb@google.com, kaleshsingh@google.com,
        tjmercier@google.com, keescook@google.com
Subject: Re: [PATCH] dma-buf: Move sysfs work out of DMA-BUF export/release
 path
Message-ID: <YdW1hPRvKYjfORvp@kroah.com>
References: <20220104235148.21320-1-hridya@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104235148.21320-1-hridya@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:51:48PM -0800, Hridya Valsaraju wrote:
> Recently, we noticed an issue where a process went into direct reclaim
> while holding the kernfs rw semaphore for sysfs in write(exclusive)
> mode. This caused processes who were doing DMA-BUF exports and releases
> to go into uninterruptible sleep since they needed to acquire the same
> semaphore for the DMA-BUF sysfs entry creation/deletion. In order to avoid
> blocking DMA-BUF export/release for an indeterminate amount of time
> while another process is holding the sysfs rw semaphore in exclusive
> mode, this patch moves the per-buffer sysfs file creation/deleteion to
> a kthread.
> 
> Fixes: bdb8d06dfefd ("dmabuf: Add the capability to expose DMA-BUF stats in sysfs")
> Signed-off-by: Hridya Valsaraju <hridya@google.com>
> ---
>  drivers/dma-buf/dma-buf-sysfs-stats.c | 343 ++++++++++++++++++++++++--
>  include/linux/dma-buf.h               |  46 ++++
>  2 files changed, 366 insertions(+), 23 deletions(-)

Crazy, but if this works in your testing, it looks ok to me.  Nice work.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
