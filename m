Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C252BC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiEROIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiEROIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:08:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C96D11A2C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B78FFB820E3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 14:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4465C385A5;
        Wed, 18 May 2022 14:08:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LVqMS3jx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652882920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bLeYtCK6G3ymqO+moQ4LY9PCLZcMxZYin7etzLxfMPI=;
        b=LVqMS3jxuGZ5bKY4K0Xlh+3CwrNw8ccBTiS7C8sjZZnwYX8w78u6/vjcO9OmWV2qOzqPaa
        SXCXbcKfwnIi1up1lgbBQJKuQP5KKQMu+7db6lAYKpmGsGoiDxUDGHQw8nqDWd46Letk67
        mAfFdDRe/ts0tuW4lPdqAdTIHq/KEPY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c1e1eaba (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 18 May 2022 14:08:40 +0000 (UTC)
Date:   Wed, 18 May 2022 16:08:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Vadim Galitsin <vadim.galitsyn@oracle.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
Message-ID: <YoT94NOAVt9V43Y7@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <YnKeag3Ulg0NR58Q@zx2c4.com>
 <YoRFjTIzMYZu8Hq8@zx2c4.com>
 <87fsl7j8bh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsl7j8bh.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, May 18, 2022 at 03:09:54PM +0200, Thomas Gleixner wrote:
> In the interest of users we should probably bite the bullet and just
> disable hard interrupt FPU usage upstream and Cc stable. The stable
> kernel updates probably reach users faster.

Considering <https://git.zx2c4.com/linux-rng/commit/?id=e3e33fc2e> is
slated for 5.19, that seems fine, as this will remove what is hopefully
the last hardirq FPU user.

The bigger motivation, though, for removing the hardirq FPU code would
be for just simplifying the FPU handling. The VirtualBox people are
going to have to fix this bug anyway, since it also affects old kernels
they support.

Jason
