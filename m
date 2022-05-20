Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB35F52EF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350791AbiETPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350876AbiETPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FB317857B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4E3A61D78
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 15:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDFEC385A9;
        Fri, 20 May 2022 15:24:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ogE1od45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653060255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zl+f5jOoxKd7ShYN8IvL0llXlidAM53WXdg2b6XqGcs=;
        b=ogE1od45NrXV8WHr447j6CmccLR7m0SQHc5cm5ctbrOLcPuw8G8MuFUFafTt6npziB86Ju
        PtoFTA1TcCh13MGdRnr1EfiyK+mDJZ+ScST+PaxW9hq47IS1JIQQQQQq6e+GBwbjCILMpw
        6iJm6f19+YFfNyM2Y0H/DcN+67c7lsI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 44d898e1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 15:24:14 +0000 (UTC)
Date:   Fri, 20 May 2022 17:24:07 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Message-ID: <Yoeylxfbl9hDI/jE@zx2c4.com>
References: <20220520135030.166831-1-Jason@zx2c4.com>
 <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Fri, May 20, 2022 at 03:09:19PM +0000, Al Viro wrote:
> On Fri, May 20, 2022 at 03:50:30PM +0200, Jason A. Donenfeld wrote:
> > Currently mem.c implements both the {read,write}_iter functions and the
> > {read,write} functions. But with {read,write} going away at some point
> > in the future,
> 
> Not likely to happen, unfortunately.
> 
> > and most kernel code made to prefer {read,write}_iter,
> > there's no point in keeping around the old code.
> 
> Profile and you'll see ;-/

Huh, yea, I lose around 1 GiB/s of perf on my machine sending /dev/zero
into /dev/null.

Jason
