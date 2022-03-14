Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEB14D88A9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbiCNQBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiCNQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:01:09 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506545056
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:59:58 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ECB2B40013;
        Mon, 14 Mar 2022 15:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647273597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L5tSI+6s5RfospdOGvGWlFTdtWMCpSRJ+W9UMg05WK0=;
        b=NC5ymPCFEvnqxR8hJH3ASVl5uk2P7GRZOJ/c25w4jm6ZR94yFXJWR3nAZwbkBdi5GvtWuA
        IvHbBe8J7JYNJ9IjbSbdz1VuNmgv0MAZjAkCfaSX3FGvNzGBmXAGY+pG1dpOoG0czbI217
        P2jKkrWH1PcOlk4xZ42BxI8AffUXPFNJ9uJmxO4qRvNSqZUIFZGsq4hOBJSs9jMma0nAxF
        Dd3mfy/5QTbKM8PgYo7DZDkgREWVISjQbiKX4PilAKSpMUXXQj36UiOYw4ttoQVifA0tiN
        kJaye23LrSqnVw/QpdGYHPGlJb9WKnxL2omj+G3d5wOsZ8ILOc2cwoSladcVvg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        david.oberhollenzer@sigma-star.at
Cc:     git@xilinx.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: tests: Fix eraseblock read speed miscalculation for lower partition sizes
Date:   Mon, 14 Mar 2022 16:59:55 +0100
Message-Id: <20220314155955.77400-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220208103905.13354-1-amit.kumar-mahapatra@xilinx.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ad627c3fc7d5acc9114b37a472e1ced217e13dfd'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-08 at 10:39:05 UTC, Amit Kumar Mahapatra wrote:
> While calculating speed during  mtd_speedtest, the time interval
> (i.e., start - finish) is rounded off to the nearest milliseconds by
> ignoring the fractional part. This leads to miscalculation of speed.
> The miscalculation is more visible while running speed test on small
> partition sizes(i.e., when partition size is equal to eraseblock size or
> twice the eraseblock size) at higher spi frequencies.
> 
> For e.g., while calculating eraseblock read speed for a mtd partition with
> size equal to the eraseblock size(i.e., 64KiB) the eraseblock read time
> interval comes out to be 966490 nanosecond. This is then converted to
> millisecond(i.e., 0.966 msec.). The integer part (i.e., 0 msec) of the
> value is considered and the fractional part (i.e., 0.966) is ignored,for
> calculating the eraseblock read speed. So the reported eraseblock read
> speed is 0 KiB/s, which is incorrect.
> 
> There are two approaches to fix this issue.
> 
> First approach will be to keep the time interval in millisecond. and round
> up the integer value, with this approach the 0.966msec time interval in the
> above example will be rounded up to 1msec and this value is used for
> calculating the speed. Downside of this approach is that the reported speed
> is still not accurate.
> 
> Second approach will be to convert the time interval to microseconds
> instead of milliseconds, with this approach the 966490 nanosecond time
> interval in the above example will be converted t0 966.490usec and this
> value is used for calculating the speed. As compared to the current
> implementation and the suggested First approach, this approach will report
> a more accurate speed. Downside of this approach is that, in future if the
> mtd size is too large then the u64 variable, that holds the number of
> bytes, might overflow.
> 
> In this patch we have gone with the second approach as this reports a more
> accurate speed. With this approach the eraseblock read speed in the above
> example comes out to be 132505 KiB/s when the spi clock is configured at
> 150Mhz.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
