Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F728572ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbiGMHMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiGMHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:12:31 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9BEA9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:12:29 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id D5617C01F; Wed, 13 Jul 2022 09:12:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657696347; bh=c5Xq6MAbIOWGs66QYYBt/zBq3dTbFAGujt8LMl/IQ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylDrCMaXjdknDbl8tiJxwUWGLbHD9Y+QgMYZTO8qqA42RDSO/LfEANT6k5Or1ySLg
         +kqWTV4Wo8HHjErYfWBcUj6QyHVKnSHOThUOOyIDf2t1LZRkHpgulmsq5pA1Ztjkdw
         hVv+KhbtwQIKMfuD9iiw3vWDg5aaytjAaY69o1qZ6qu/mpQQywDiKjCMPYsNm6I1Qj
         2HjpVGDRGeLB5h42XeEjuUUH8ixPofN7lvMjDaHnYh0r6xuZjnVAL0rriuDCKZLfby
         zrQnNrKEqeZhVv3NMLns2EqnJU8n7CPUcBpMk+aQCavUJ+V69oeW1JDK11F6359mp/
         mfY62ysGnCOaQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id DE484C009;
        Wed, 13 Jul 2022 09:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657696347; bh=c5Xq6MAbIOWGs66QYYBt/zBq3dTbFAGujt8LMl/IQ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylDrCMaXjdknDbl8tiJxwUWGLbHD9Y+QgMYZTO8qqA42RDSO/LfEANT6k5Or1ySLg
         +kqWTV4Wo8HHjErYfWBcUj6QyHVKnSHOThUOOyIDf2t1LZRkHpgulmsq5pA1Ztjkdw
         hVv+KhbtwQIKMfuD9iiw3vWDg5aaytjAaY69o1qZ6qu/mpQQywDiKjCMPYsNm6I1Qj
         2HjpVGDRGeLB5h42XeEjuUUH8ixPofN7lvMjDaHnYh0r6xuZjnVAL0rriuDCKZLfby
         zrQnNrKEqeZhVv3NMLns2EqnJU8n7CPUcBpMk+aQCavUJ+V69oeW1JDK11F6359mp/
         mfY62ysGnCOaQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 75c57f87;
        Wed, 13 Jul 2022 07:12:20 +0000 (UTC)
Date:   Wed, 13 Jul 2022 16:12:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [RFC PATCH] 9p: forbid use of mempool for TFLUSH
Message-ID: <Ys5wRdSwtTeLF6nc@codewreck.org>
References: <12950409.o0bIpVV1Ut@silver>
 <20220713041700.2502404-1-asmadeus@codewreck.org>
 <0aa8323d-9461-a861-ac35-6952e7aeaf93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0aa8323d-9461-a861-ac35-6952e7aeaf93@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Overstreet wrote on Wed, Jul 13, 2022 at 02:39:06AM -0400:
> On 7/13/22 00:17, Dominique Martinet wrote:
> > TFLUSH is called while the thread still holds memory for the
> > request we're trying to flush, so mempool alloc can deadlock
> > there. With p9_msg_buf_size() rework the flush allocation is
> > small so just make it fail if allocation failed; all that does
> > is potentially leak the request we're flushing until its reply
> > finally does come.. or if it never does until umount.
> 
> Why not just add separate mempools for flushes? We don't have to allocate
> memory for big payloads so they won't cost much, and then the IO paths will
> be fully mempool-ified :)

I don't think it really matters either way -- I'm much more worried
about the two points I gave in the commit comment section: mempools not
being shared leading to increased memory usage when many mostly-idle
mounts (I know users who need that), and more importantly that the
mempool waiting is uninterruptible/non-failible might be "nice" from the
using mempool side but I'd really prefer users to be able to ^C out of
a mount made on a bad server getting stuck in mempool_alloc at least.

It looked good before I realized all the ways this could hang, but now I
just think for something like 9p it makes more sense to fail the
allocation and the IO than to bounce forever trying to allocate memory
we don't have.

Let's first see if you still see if you still see high order allocation
failures when these are made much less likely with Chritisan's patch.

What I intend to push this cycle is in
https://github.com/martinetd/linux/commits/9p-test
up to 'net/9p: allocate appropriate reduced message buffers'; if you can
easily produce them I'd appreciate if you could confirm if it helps.

(just waiting for Chritian's confirmation + adjusting the strcmp for
rdma before I push it to 9p-next)
--
Dominique

