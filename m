Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6904D88AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbiCNQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbiCNQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:01:26 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B67457AE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:00:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1C66E200007;
        Mon, 14 Mar 2022 16:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647273609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcTeCSqjA30WWQNMW0gHvtlkhVvj5befvu9dAIyBttU=;
        b=B3nDZWQVGuyP1Y3ap+c4EWjrDmdWvX8VY3+6+D+TakX+BJqXi+ruTobaxoPh89pSmzaNH0
        HRhifMCrSb86dmLoektCYPhJ4Dm3i4NxrjRTtCMhs9zXjIMk9vM4ewaUyU1kAAvxj0au5M
        5rbUeel2PKMPi4nYXEWbdDg6yXQjmrPzsZxN5MGGFwKsldw08gg7azlJqupljA3dFTiLuD
        ryvwCRz4cxxzg5ipzsfitngFji5p1b9ilNDjmsMhf9AjLsTFKRM+0rSYCpwSUTtVo3/13h
        dfdOOE9Y8ps4LSPsSnB+AwFR7/1ejT/q8S4LmQwEU2xATS+nCGBSgg9BGIDczg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Xin Xiong <xiongx18@fudan.edu.cn>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v4] mtd: rawnand: atmel: fix refcount issue in atmel_nand_controller_init
Date:   Mon, 14 Mar 2022 17:00:00 +0100
Message-Id: <20220314160000.77465-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220304085330.3610-1-xiongx18@fudan.edu.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'fecbd4a317c95d73c849648c406bcf1b6a0ec1cf'
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

On Fri, 2022-03-04 at 08:53:32 UTC, Xin Xiong wrote:
> The reference counting issue happens in several error handling paths
> on a refcounted object "nc->dmac". In these paths, the function simply
> returns the error code, forgetting to balance the reference count of
> "nc->dmac", increased earlier by dma_request_channel(), which may
> cause refcount leaks.
> 
> Fix it by decrementing the refcount of specific object in those error
> paths.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Co-developed-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Co-developed-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
