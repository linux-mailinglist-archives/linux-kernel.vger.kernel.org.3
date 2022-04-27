Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB32B511EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbiD0P3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiD0P3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:29:34 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E910A3528AF;
        Wed, 27 Apr 2022 08:26:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E26F11BF203;
        Wed, 27 Apr 2022 15:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651073177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k9Rf97iebmoDfy15ErOJ4xhdjVjGSFyAVnacL6ziYLY=;
        b=lM9P1GbmTn5Xmb4Sf0bbbpTN1qlRPeRwz35/sn0FJwJcJ9w7esHk+i1kmH5FS9FHy558/i
        FtxYLtpZajg1fHuoWPcjagHEd0AFvm1UOYBU2huxi5Q9Lq5VWPRPdPEn2YsjMbTNe7m3tc
        OP0RTxf8c5UyQwPIJDX/XZRcMueXtAqbioj0Usm4rBK95YorjDdRfNIICmywZ+XqLkkF8W
        FWUJgAY2jvjDqwGnuFKVe2PI9jYWaicTs8AM2aTwt5km5avNMVxtwqcD1jBaFTANmpmhWr
        sZo+wrhVB06/T7GRw1QNPj1hn4itFS1Acmy+tFmXnJTjyhIntt6QWD9w7I/xIg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at
Subject: Re: [PATCH 1/3] mtd: rawnand: cadence: fix possible null-ptr-deref in cadence_nand_dt_probe()
Date:   Wed, 27 Apr 2022 17:26:15 +0200
Message-Id: <20220427152615.101037-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220426084913.4021868-1-yangyingliang@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a28ed09dafee20da51eb26452950839633afd824'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-26 at 08:49:11 UTC, Yang Yingliang wrote:
> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
> 
> Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
