Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549752EEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350588AbiETPE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345687AbiETPEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:04:55 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059B16D4B4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4cNdTLR0+sVu59nm7omJEvZjYUlwAhbNp7TATU5QFOg=; b=aytaTsI1Dl7vVRBhQNHxtOn3pY
        xOrhyxm3Hy2BdYqfWuQvRVTQDYY2k8SsI5oxAD/TChIKkxOKz5iBpEeaGLm6xyCkiSYfTd6kmu+mN
        t+F59OOW0ghSZi5v7Zr5PjdkcRBcYD1MEuXgKUbprFoQk7KM9n+YLrPIVxg4E+kRG7VORPwE6Y4Go
        lmD1ysMtPVf165GJ/UhYRFmY6PoM8vIarTOIGbYi9rWingjmQAD+aoPuTRfd4D8nFVOKKbc65Psvi
        D+vbgzk4TL7jjC7oky4WFKnxy+WgEEsjxQEVgu1TliFu7UPsiH3CtehkDnah5LwC7xje7dg1WPaeP
        vvi3Hjbw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ns4BN-00GcsM-W7; Fri, 20 May 2022 15:04:50 +0000
Date:   Fri, 20 May 2022 15:04:49 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: prefer read_iter over read and write_iter over write
Message-ID: <YoeuEXzGFdnCZIVs@zeniv-ca.linux.org.uk>
References: <20220520135103.166972-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520135103.166972-1-Jason@zx2c4.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 03:51:03PM +0200, Jason A. Donenfeld wrote:
> Most kernel code prefers read_iter over read and write_iter over write,
> yet the read function pointer is tested first. Reverse these so that the
> iter function is always used first.

NAK.  There are some weird devices (at the very least, one in sound)
where data gets interpreted differently for write() and writev().
There are several degrees of messiness:
	1) packet-like semantics, where boundaries of iovecs are
significant; writev() is equivalent to loop of write() calls, but
*NOT* to write() on a single concatenated copy.  _Any_ short write
on any segment (due to ->write() instance ignoring the rest of data
as well as due to unmapped page halfway through) terminates writev().
	2) similar, but more extreme - write() reports consuming all
the data it's been given (assuming the damn thing parses) and
ignores the excess.  writev() is equivalent to iterated write() on
all segments, as long as each is valid.  Not uncommon, sadly...
	3) completely unrelated interpretations of input for write()
and for writev().  writev() is *NOT* equivalent to a loop of write()
there.  Yes, such beasts exist.  And it's a user-visible ABI.
Example: snd_pcm_write() vs. snd_pcm_writev().  Not a chance to
retire that one any time soon, and the difference in semantics is
that writev() is "feed several channels at once; the chunks for
individual channels are covered by elements of iovec array".
Worse one: qib_write() and qib_write_iter().  There we flat-out
have different command sets for write() and for writev().  That,
at least, might be possible to retire someday.

IIRC, for pcm the readv() vs. read() differences are same as for
writev() vs. write() - parallel reads from different channels,
each to its own iovec.

It's a bad userland ABI design, but we are stuck with it - it's a couple
of decades too late to change.
