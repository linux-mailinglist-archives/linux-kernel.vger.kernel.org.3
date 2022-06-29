Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFA55FEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiF2Liu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiF2Lis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 07:38:48 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3738BE;
        Wed, 29 Jun 2022 04:38:47 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4A0C42000E;
        Wed, 29 Jun 2022 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656502725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQXoqYCgE7EIU42/zVADHV9fDPsxC+PutcvlEANepEU=;
        b=SfTLG3E+wEsfzL0Rw0KxGQptxA0ZkMjSeOj50QLWd1IHA+fIQpXH6hqJNcnj4/GdTBfrBY
        rElrXwP3avkncWwuTdDQ/yeJ/hunIJBcNv26lnzjwXQV0qwLA/+p2C66Hx58UWGePGKQFg
        0I/BJvEhy4VCR0NqNVFikj3gkWHpGEOz5/q4Y/LhrU6BjUHmpxH4AdXzHZQunHiOTArtgD
        hi3KgDoFywlbdS3APWu2bt6ckhN9s1AS4GnrCll6c+0GI7Lj/0jMe66kiCnWRF7SksOh9I
        ZlNragQsLwETXTzc60g2FHYlUbYaROG5YzpKXbSKN4jZ4u6JJCiyg239mnAIUQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?b?77+9ZWNraQ==?= <rafal@milecki.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] mtd: core: introduce of support for dynamic partitions
Date:   Wed, 29 Jun 2022 13:38:43 +0200
Message-Id: <20220629113843.283665-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622010628.30414-4-ansuelsmth@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ad9b10d1eaada169bd764abcab58f08538877e26'
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

On Wed, 2022-06-22 at 01:06:28 UTC, Christian Marangi wrote:
> We have many parser that register mtd partitions at runtime. One example
> is the cmdlinepart or the smem-part parser where the compatible is defined
> in the dts and the partitions gets detected and registered by the
> parser. This is problematic for the NVMEM subsystem that requires an OF
> node to detect NVMEM cells.
> 
> To fix this problem, introduce an additional logic that will try to
> assign an OF node to the MTD if declared.
> 
> On MTD addition, it will be checked if the MTD has an OF node and if
> not declared will check if a partition with the same label / node name is
> declared in DTS. If an exact match is found, the partition dynamically
> allocated by the parser will have a connected OF node.
> 
> The NVMEM subsystem will detect the OF node and register any NVMEM cells
> declared statically in the DTS.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
