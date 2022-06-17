Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1554F10D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380305AbiFQGbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiFQGbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:31:37 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111C85401B;
        Thu, 16 Jun 2022 23:31:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 71BB5C0009;
        Fri, 17 Jun 2022 06:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655447492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f8tXznjMvYmeHTU3FtjUVkstIS/LPI1XXnIM1Arfyjk=;
        b=YyzmBzQ/mA9+hQrDOGXRaXbKPmUqe93b5UpijnHVL+c7TTJLW4oUt6s0cbYFx+E5qboLqa
        YRZcoNWkMMoGuL/qW0vKk1U+O+XORvj6u1pezHBwYpLYF1EdWsiIg1nSgDnbZMwbxLJ/B6
        jSQTRl2eAJGAQVF0JsqN+4Wh7gWV2onmvqAYYCKsgaZsVY6E9wF5DJKSIGNitNOwzWIE44
        uhYssYfkgE9KXn7o0z679oXR0RyDo3ylNBlWwCPXyMVabS/EXZM85KJMRfQebSVsxKbXL1
        xIv6JeMJThE14HDIhgX2KwHfcysW9Us1RcGw32vmHgC6bpmh4M3mJLApUZUFvg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/3] mtd: nand: raw: qcom_nandc: add support for unprotected spare data pages
Date:   Fri, 17 Jun 2022 08:31:29 +0200
Message-Id: <20220617063129.446718-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616001835.24393-3-ansuelsmth@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'862bdedd7f4b8aebf00fdb422062e64896e97809'
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

On Thu, 2022-06-16 at 00:18:34 UTC, Christian Marangi wrote:
> IPQ8064 nand have special pages where a different layout scheme is used.
> These special page are used by boot partition and on reading them
> lots of warning are reported about wrong ECC data and if written to
> results in broken data and not bootable device.
> 
> The layout scheme used by these special page consist in using 512 bytes
> as the codeword size (even for the last codeword) while writing to CFG0
> register. This forces the NAND controller to unprotect the 4 bytes of
> spare data.
> 
> Since the kernel is unaware of this different layout for these special
> page, it does try to protect the spare data too during read/write and
> warn about CRC errors.
> 
> Add support for this by permitting the user to declare these special
> pages in dts by declaring offset and size of the partition. The driver
> internally will convert these value to nand pages.
> 
> On user read/write the page is checked and if it's a boot page the
> correct layout is used.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
