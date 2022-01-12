Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1AA48BD67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348744AbiALCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiALCs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:48:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F28C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 18:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0Ub7h0IlJdXN2WuASt+Fcu9SGBTJlSgUMPIvJ1lZ50M=; b=i10Vfh02Qt1Uk/OPxKN2hTTxxL
        W3G1sHBIaPo6aMb+KSlo6IjI1bvE5Lv0stpZbTmat/0P/5gYOl4BrEZyOgzl4Uf0GuiuW2uxH1DsZ
        6qaTDoxLtiOOa+sDJC46yx1OsFNqMEoeU0Py3L4wCEGOZ6Mq9x39PkS5xfxjlyp3c6mPK7oF3BEHn
        9ICzo3FUbCKxipo690jq29Xc+YhD9QE1CeZ+VKAsYzFs8ShqGwjqP3Q75hbsYbggc48LQMYGCnRKr
        4j2sydhcDk+yQaqHcY6T319icot8dDal9QIMBPcE0VMmnwA6HvWK0KbGF5MvTtTwzEm5DyvI3LQw+
        KjR5E2Yw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7TgW-000x0v-Lz; Wed, 12 Jan 2022 02:48:24 +0000
Date:   Tue, 11 Jan 2022 18:48:24 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] module: add in-kernel support for decompressing
Message-ID: <Yd5BeLNtnsuVEfm5@bombadil.infradead.org>
References: <YdYTwFhmB53l2JVE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdYTwFhmB53l2JVE@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 01:55:12PM -0800, Dmitry Torokhov wrote:
> Current scheme of having userspace decompress kernel modules before
> loading them into the kernel runs afoul of LoadPin security policy, as
> it loses link between the source of kernel module on the disk and binary
> blob that is being loaded into the kernel. To solve this issue let's
> implement decompression in kernel, so that we can pass a file descriptor
> of compressed module file into finit_module() which will keep LoadPin
> happy.
> 
> To let userspace know what compression/decompression scheme kernel
> supports it will create /sys/module/compression attribute. kmod can read
> this attribute and decide if it can pass compressed file to
> finit_module(). New MODULE_INIT_COMPRESSED_DATA flag indicates that the
> kernel should attempt to decompress the data read from file descriptor
> prior to trying load the module.
> 
> To simplify things kernel will only implement single decompression
> method matching compression method selected when generating modules.
> This patch implements gzip and xz; more can be added later,
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, I've merged this into the modules-next tree [0]. If 0-day
and the merge wiht linux-next doesn't barf I'll include it as a part of the
upcoming pull request.

Aaron, just a heads up, your changes will likely have to just wait until
the next kernel release, and this is one slightly intrusive change you
can move to its own file as part of your awesome cleanup.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/

  Luis
