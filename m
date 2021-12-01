Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CAE464F24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349903AbhLANyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349711AbhLANxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:53:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0F5C061759
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 05:49:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B00A2B81F4C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 13:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E967EC58324;
        Wed,  1 Dec 2021 13:49:51 +0000 (UTC)
Date:   Wed, 1 Dec 2021 14:49:48 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, christian@brauner.io, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org, kernel-team@android.com,
        avakj45@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/4] binder: fix handling of error during copy
Message-ID: <20211201134948.iq4tcgz6r4e2tus7@wittgenstein>
References: <20211130185152.437403-1-tkjos@google.com>
 <20211130185152.437403-2-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130185152.437403-2-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:51:49AM -0800, Todd Kjos wrote:
> If a memory copy function fails to copy the whole buffer,
> a positive integar with the remaining bytes is returned.
> In binder_translate_fd_array() this can result in an fd being
> skipped due to the failed copy, but the loop continues
> processing fds since the early return condition expects a
> negative integer on error.
> 
> Fix by returning "ret > 0 ? -EINVAL : ret" to handle this case.
> 
> Fixes: bb4a2e48d510 ("binder: return errors from buffer copy functions")
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Todd Kjos <tkjos@google.com>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
