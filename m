Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E52E87D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbiETJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiETJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 05:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C313C1E2
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 02:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0848A61B9C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C023CC385AA;
        Fri, 20 May 2022 09:14:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jHiEczQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653038091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZxLeQP280HvIinkfhrGen/yfJsBCLWYeNWFg+K8k64=;
        b=jHiEczQRzDJATOw45S9amLoCxvnNXHpp0NKrnc/8+cestKWtfdwfByxaB19+zTofNgkasn
        k2MYn9DlnQ7j34hS0EyOlXP9ucB/OB6p3mmv6JwavsoDYBeXrT04oKQ/Y32i6QFECuJKOo
        gbeO7SLqTCuMMLDLCidZFPQcKlIQjxo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7b893b7a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 20 May 2022 09:14:51 +0000 (UTC)
Date:   Fri, 20 May 2022 11:14:49 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, tytso@mit.edu, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Message-ID: <YodcCV96t13O0Trl@zx2c4.com>
References: <20220519233137.20415-1-axboe@kernel.dk>
 <20220519233137.20415-2-axboe@kernel.dk>
 <YocGyl8mmG84tQD4@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YocGyl8mmG84tQD4@zeniv-ca.linux.org.uk>
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

On Fri, May 20, 2022 at 03:11:06AM +0000, Al Viro wrote:
> >  SYSCALL_DEFINE3(getrandom, char __user *, ubuf, size_t, len,
> >  unsigned int, flags) { +	struct iovec iov = { .iov_base = ubuf };
> >  +	struct iov_iter iter;
> 
> 	import_single_range(READ, ubuf, len, &iov, &iter)
> 
> (note, BTW, that this'll cap len)

I'll incorporate this and send a v4. import_single_range does an
access_ok(), but I would hope that copy_to_iter() also does similar
checks. Does that make this less efficient?

Jason
