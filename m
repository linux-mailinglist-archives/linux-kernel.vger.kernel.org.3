Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8552F524
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 23:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiETVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiETVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 17:30:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800513F2D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 14:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 004B661D7C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:30:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC681C385A9;
        Fri, 20 May 2022 21:30:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CB/1pDR3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653082247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pmBMBGXgmXyQQy/pnJy74akwJf92VbRGk9cwJ61pYSg=;
        b=CB/1pDR3+piliz/FxznxJ+VFNj/d6kSrImfOmESUOD9K0jNFFD2qSwRkzsdQ6nhP2sGkpQ
        Pa6to3MkezqQpTHK9x8wBfnObX4A9w9ft/dbhGTcm6eUAtPvwmPh6l3FnitGC84V95sR7b
        p4xmIXhU/mKx3l7DJnOHbnL/FliMF4c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5bcd7da0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 21:30:46 +0000 (UTC)
Date:   Fri, 20 May 2022 23:30:43 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fs: prefer read_iter over read and write_iter over write
Message-ID: <YogIg9FG7C/f98bf@zx2c4.com>
References: <20220520135103.166972-1-Jason@zx2c4.com>
 <39ed6917f2e64a07bad8dad63f8dceb4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39ed6917f2e64a07bad8dad63f8dceb4@AcuMS.aculab.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, May 20, 2022 at 09:24:50PM +0000, David Laight wrote:
> From: Jason A. Donenfeld
> > Sent: 20 May 2022 14:51
> > 
> > Most kernel code prefers read_iter over read and write_iter over write,
> > yet the read function pointer is tested first. Reverse these so that the
> > iter function is always used first.
> 
> There will be a measurable performance hit for the xxx_iter versions.

Indeed. We now have the misfortune of a 3% hit on random.c, per this
sub-thread:

   https://lore.kernel.org/lkml/Yoey+FOYO69lS5qP@zx2c4.com/

The hope is that it eventually becomes faster... :-\

Jason
