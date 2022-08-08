Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC96158C24F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 06:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiHHERb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 00:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiHHER3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 00:17:29 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F2311A05
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A4RtxbAqeBnUIxMXF4XlPWBMt/xyvevjMbPuIHGM/1c=; b=PkVGVmd1YUw8qnNn52lXdq7Pjy
        4Mv6h6473hhsT9Dp/H5PVVUbH9SxopjTg3xfQGYZouZsv2qxRWUpMeJgQv0PdaZPWdi0JgEhktN18
        1V6qLiFSlWPzOPX2FfNFGYtmpGDSFBgceHTJRvaRyZ3qrhBNK9dliAoLn4nWt4a+8I04AOxkZVydg
        25jLyp6QRTi9aRCS4iaeX07jBzdNyT0i+NDtEw5xCKPGE08C3KuOjPziFJz6kZqgfIqyMyTUuC82X
        xvKwfjBxnqsBV3HUTlAnSXV3CrtOlBkWUd6vIxBxNJ+ecP0K/wV0WicY17XTV6R2ba/BerzZea6LW
        6HFPnUUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oKuCi-002LOS-Dq;
        Mon, 08 Aug 2022 04:17:24 +0000
Date:   Mon, 8 Aug 2022 05:17:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 29/32] d_path: prt_path()
Message-ID: <YvCOVGdlGqRVlZwL@ZenIV>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-30-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808024128.3219082-30-willy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 03:41:25AM +0100, Matthew Wilcox (Oracle) wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This implements a new printbuf version of d_path()/mangle_path(), which
> will replace the seq_buf version.
> 
> Part of what we're trying to do with printbufs is standardizing a
> calling convention so they don't have to live in lib/vsprintf.c, and can
> instead with the code for the types they're printing - so this patch
> adds prt_path() to d_path.c, another patch will switch vsprintf.c to use
> it.

To use it for *what*?  If you mean replacing %pd with it - forget about that.
Not going to happen.

There's a hard requirement for printk - it should be safe to call in any
locking environment.  d_path() isn't, and that's impossible to avoid.
