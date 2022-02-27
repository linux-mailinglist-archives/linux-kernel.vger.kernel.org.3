Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0840C4C5B26
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiB0Mod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiB0Moc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:44:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8BB1DA5C;
        Sun, 27 Feb 2022 04:43:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B38C7B80B55;
        Sun, 27 Feb 2022 12:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F06C340E9;
        Sun, 27 Feb 2022 12:43:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="O2DCIvAg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645965830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PqCJu412vVgY6KdZye7rbvTRG5crZEcN/Zp/j8PEIrM=;
        b=O2DCIvAgqHg2U/BLw8plURVMHyuTZeqpXXzJ4I10r5yIkd8oFSPYgZJ9KqQstEQ13sLiT8
        eqSZbX70558sCwVw2hIGhwmAPJ/rEgQ9HSCCP/8nozAez/E/9t/P4T8WpoNCNboHVGFho4
        LaV9Fgc7cBB17Wj7jdCpZVOgpWUMaAY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cc56f42f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 27 Feb 2022 12:43:50 +0000 (UTC)
Date:   Sun, 27 Feb 2022 13:43:48 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/3] ACPI: allow longer device IDs
Message-ID: <YhtyBHUyFysmZ9bC@zx2c4.com>
References: <20220226220639.1173594-1-Jason@zx2c4.com>
 <20220226220639.1173594-3-Jason@zx2c4.com>
 <0c73d29e-e558-efb9-d0d7-c612b2bb7e90@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c73d29e-e558-efb9-d0d7-c612b2bb7e90@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Sun, Feb 27, 2022 at 12:42:03PM +0100, Alexander Graf wrote:
> > To allow device drivers to match identifiers that exceed the 9 byte
> > limit, this simply ups the length to 16, just like it was before the
> > aforementioned commit. Empirical testing indicates that this
> 
> 
> This is only true for 64bit systems where padding automatically bloated 
> to 9 byte array to 16. I still believe the patch is fine as it is, but 
> there will be minor .rodata overhead on 32bit targets which you may want 
> to quantify in the patch description.

Good point. So I just tried this out with a 32-bit i686 kernel and the
results are the same again for the size of vmlinux. I then ran `objdump
--headers` and looked at the size of the .rodata section, where it's
also the same. I'm not quite sure what to make of this, as it's not what
I was expecting, but I think I tested it right. So maybe we're lucky
here?

Jason
