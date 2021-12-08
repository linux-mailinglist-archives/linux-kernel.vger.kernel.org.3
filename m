Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FD46D09D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhLHKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhLHKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:13:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6F6C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 02:09:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F96EB81FFC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 10:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FD2C00446;
        Wed,  8 Dec 2021 10:09:33 +0000 (UTC)
Date:   Wed, 8 Dec 2021 11:09:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Li Li <dualli@google.com>,
        Marco Ballesio <balejs@google.com>,
        Hang Lu <hangl@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: fix pointer cast warning
Message-ID: <20211208100930.undojzgd7ylmnz3i@wittgenstein>
References: <20211207122448.1185769-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207122448.1185769-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:24:42PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> binder_uintptr_t is not the same as uintptr_t, so converting it into a
> pointer requires a second cast:
> 
> drivers/android/binder.c: In function 'binder_translate_fd_array':
> drivers/android/binder.c:2511:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>  2511 |         sender_ufda_base = (void __user *)sender_uparent->buffer + fda->parent_offset;
>       |                            ^
> 
> Fixes: 656e01f3ab54 ("binder: read pre-translated fds from sender buffer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
