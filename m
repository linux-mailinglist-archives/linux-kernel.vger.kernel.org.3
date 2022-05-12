Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9726652513C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355922AbiELP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350445AbiELP1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:27:06 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B31A66F8E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:27:04 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0C2561BF20E;
        Thu, 12 May 2022 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652369223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7NNT92k26CJgW/8BeDWNQkG7ssrSCWKv0a9u8U2/8M=;
        b=P8I5f/YpC9U1TfQ8e9YGjttd53tWVniAp7/SiGkzeOOeFKIVX4v2JFxT9U/p9sDxbbkGUH
        /jOrPdPANq+XVQ1uJ/JpDKgkg6wDlwuDECjIPVkQxhIKRXZ3wPKL8F1hlB1g5Jq60yFNel
        yVruQCQEfcvV1Z8HwpV3mjC0avNxT1bTzMtVsTn267dlrAESD1ls6eRBReag0vs199sCww
        m5kspJGdlrM4bL6U7sda3FBdZ9eCM2BgyLAiQGhtViKluoScyAEM9q8rWK2U7QTRy/2wNb
        /RJ5X13tKs3/87v1a8x6wYjTHtcTKg8HjdnA8KPxLmaoYfUsprOHoKL0OYOZRA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     kernel@axis.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: phram: Allow cached mappings
Date:   Thu, 12 May 2022 17:27:01 +0200
Message-Id: <20220512152701.244667-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220510151822.1809278-1-vincent.whitchurch@axis.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9a7459fd9be4968721ba7a4c6c7eae2f01da2b32'
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

On Tue, 2022-05-10 at 15:18:22 UTC, Vincent Whitchurch wrote:
> Currently phram always uses ioremap(), but this is unnecessary when
> normal memory is used.  If the reserved-memory node does not specify the
> no-map property, indicating it should be mapped as system RAM and
> ioremap() cannot be used on it, use a cached mapping using
> memremap(MEMREMAP_WB) instead.
> 
> On one of my systems this improves read performance by ~70%.
> 
> (Note that this driver has always used normal memcpy/memset functions on
> memory obtained from ioremap(), which sparse doesn't like.  There is no
> memremap() variant which maps exactly to ioremap() on all architectures,
> so that behaviour of the driver is not changed to avoid affecting
> existing users, but the sparse warnings are suppressed in the moved code
> with __force.)
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
