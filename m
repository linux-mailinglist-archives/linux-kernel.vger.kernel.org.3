Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6789D47E0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347570AbhLWJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:47:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33506 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347545AbhLWJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:47:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82F661E17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A91C36AE9;
        Thu, 23 Dec 2021 09:47:45 +0000 (UTC)
Date:   Thu, 23 Dec 2021 10:47:41 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH] binder: fix async_free_space accounting for empty parcels
Message-ID: <20211223094741.gi635t6fhown2unv@wittgenstein>
References: <20211220190150.2107077-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211220190150.2107077-1-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:01:50AM -0800, Todd Kjos wrote:
> In 4.13, commit 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> fixed a kernel structure visibility issue. As part of that patch,
> sizeof(void *) was used as the buffer size for 0-length data payloads so
> the driver could detect abusive clients sending 0-length asynchronous
> transactions to a server by enforcing limits on async_free_size.
> 
> Unfortunately, on the "free" side, the accounting of async_free_space
> did not add the sizeof(void *) back. The result was that up to 8-bytes of
> async_free_space were leaked on every async transaction of 8-bytes or
> less.  These small transactions are uncommon, so this accounting issue
> has gone undetected for several years.
> 
> The fix is to use "buffer_size" (the allocated buffer size) instead of
> "size" (the logical buffer size) when updating the async_free_space
> during the free operation. These are the same except for this
> corner case of asynchronous transactions with payloads < 8 bytes.
> 
> Fixes: 74310e06be4d ("android: binder: Move buffer out of area shared with user space")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
