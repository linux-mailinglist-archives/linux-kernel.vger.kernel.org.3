Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4009490335
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237737AbiAQHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:54:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02275C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 23:54:53 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5C75F1F43428;
        Mon, 17 Jan 2022 07:54:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642406086;
        bh=Ruxz52GcOQAu6AptUfv1ReGiDTTFDcgWyb0TxyTLhh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e84ZFONaA5ZPi7C+AabqaK/tr/OISWLE0uiysgtphJOcc+fuEEM3tOfx1XZun9Xgz
         6SJrJjFuga7QU/XWXd51VhbMNauqOmJ1V2sxNs5KpkZMuG/CaffomsK5LWuHVAySXT
         3qoUlqWbSwP40h9iWPslRwza6g5VsWDY7/66jD4cnyFAgU8Z480hL3TDqC7oEzV7wi
         ABhCGtBgsL9XHhBfzcRdC6urNRnRs5TlYHMX533v2bKzMpOXhjfDIl+bJUCSorokIL
         MknKDYMGN2GtWXc9mULCLXAa3JG6tK5Yo7t9fUFN2elRIA4ZpJbW/4zsvM0mZKOJcu
         9BeNu0b47IzCQ==
Date:   Mon, 17 Jan 2022 08:54:42 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: protect access to rawnand devices while
 in suspend
Message-ID: <20220117085442.7f19182e@collabora.com>
In-Reply-To: <20220117074339.ctuaxnetz47j45z4@skn-laptop.hadsten>
References: <20211220130015.3630975-1-sean@geanix.com>
        <20220117074339.ctuaxnetz47j45z4@skn-laptop.hadsten>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 08:43:39 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Dec 20, 2021 at 02:00:15PM +0100, Sean Nyekjaer wrote:
> > Prevent rawnend access while in a suspended state.
> > 
> > Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> > rawnand layer to return errors rather than waiting in a blocking wait.
> > 
> > Tested on a iMX6ULL.
> > 
> > Fixes: 013e6292aaf5 ("mtd: rawnand: Simplify the locking")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---  
> 
> Hi Boris and Miquel,
> 
> I know the kernel test robot is complaining a bit about uninitialized
> values.
> But is this OK? If I fix the unitialized values?

With the 'uninitialized ret' issue fixed, it looks good to me:

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

But you probably want to add a Cc:stable tag.
