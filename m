Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91548C850
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 17:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355193AbiALQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 11:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240969AbiALQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 11:30:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBEC06173F;
        Wed, 12 Jan 2022 08:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LedAk+GSW1w62gjO8Ys+jc28oKPlr3LVVvS4k8VmYa8=; b=KwPcY8c1shI3PSOnNiN2d+lqKr
        qA8y64I81CVuR8g0ut5JWe4UJQxF39yAFG6d1SqkZHZ7/taOEZcegcCGOV40i3I90nLObJiHlNTxJ
        nDfQ9x77eescnuGrZeOdZI/D7ERklsIRjN2hBt/QEF8qGsbrC4Q4Yn2rnv/SPFShhA1v67dc8PMC8
        h2rFLzlNnTLoXbaq3qe3TdHBoiGANge/KCXq/pHLft9YXlCOPJQSnVu0lNVZNj00ePOw2hZ6/zxn/
        wHctQ2YuVheY+tvmJ1BbRxUBXiAIhx2c3xrI53x+nbQBJVbEkzIPyRUPJG21JHh+7kJn/mkVMgfuA
        4JTNrCCQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7gVg-0035wI-JY; Wed, 12 Jan 2022 16:30:04 +0000
Date:   Wed, 12 Jan 2022 08:30:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     jeyu@kernel.org, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: Re: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin
 modules
Message-ID: <Yd8CDJA0dy0VaXrB@bombadil.infradead.org>
References: <20211216201919.234994-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216201919.234994-1-nick.alcock@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:19:12PM +0000, Nick Alcock wrote:
> /proc/kallsyms is very useful for tracers and other tools that need to
> map kernel symbols to addresses.
> 
> It would be useful

It took me digging on archives to see to *who* this is useful to.
The short answer seeme to be dtrace. Can you work on getting use
of this for something (I don't know, maybe kernelshark?) that does
not taint the kernel? Last I checked using dtrace on linux taints the
kernel.

Without valid upstream users I see no need to add more complexity to the
kernel. And complexity added by tainting modules or not upstream modules
just implies maintaining something for someone who is not working
upstream. I don't want to add more code or "features" to create a
maintenance burden for code not upstream or code that taints the kernel.
module.c is already the second largest file on the kernel/ directory and
I want to ensure we keep it clean, not add fluff for speculated features
which no proper non-taining Linux tool is using.

Without a valid non-taining user being made very clear with a value-add,
I will have to ignore this.

  Luis
