Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22652EF9F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351059AbiETPqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351246AbiETPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:46:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DDB1839B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB516B82B7A
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61A5C385A9;
        Fri, 20 May 2022 15:46:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fl734sbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653061566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VtMRsdPfyvbU5olGyw26zck2MdnJ++h9nOButSQcsk=;
        b=fl734sblmkgGs5PhGRjogR8pJ94wIwLpHt8n72WVFaVI6xOM68LoSgHS45tuhzBgCu80ab
        pr3smUcl96rCt01A34GLgzLZng9BUDh6yyiTa5ObtY0aEdz7sgPbAhB6Lb/tOeYx7AxDTi
        iofbx40Wvk7KnKLJJxecsDdYGSIbE3w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8aae780f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 15:46:06 +0000 (UTC)
Date:   Fri, 20 May 2022 17:46:04 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Message-ID: <Yoe3vFmqx4Yua0a1@zx2c4.com>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com>
 <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, May 20, 2022 at 09:34:46AM -0600, Jens Axboe wrote:
> On 5/20/22 9:25 AM, Jason A. Donenfeld wrote:
> > Are we sure we really want to do this and need to do this?
> 
> I'm very sure, otherwise we're just accepting that we're breaking real
> world applications.

Would we really? I always thought splice() and copy_file_range() and
sendfile() were all kind of "special" in that they mostly do not work
for many things, and so all userspaces need fallback code. And the state
of "mostly not working" has always just been the norm. So broken today,
working tomorrow, broken next week would be par for the course? I might
be *super* wrong here, so feel free to say so, but this has been my
general impression.

Anyway, I do like the idea of supporting splice() and sendfile(). The
performance hit is just kind of sad.

Jason
