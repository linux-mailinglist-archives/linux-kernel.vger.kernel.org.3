Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA754FB6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiDKJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344035AbiDKJCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:02:51 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B583ED22;
        Mon, 11 Apr 2022 02:00:37 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 74E3E10000F;
        Mon, 11 Apr 2022 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649667636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1b/5r0hiBwYr4bmOdiIkgr/ZliNLKoDFGo5f0X63v8=;
        b=No6A7EikmV/wH3y1TzfZiAGtZX8l7LnFQ25DnT4l1NiYchK/kTAM9lUyQTmi1sD/upFNl4
        k9fsqf+A1aaiA6jNsQJTGLq6KFLmt5XQlm8wYoAD+us6GezgudMNpXmkDCJvXmptL34wLM
        DMLYzItwmerLMkSXTtcs3DMqDyR+5x0RHQr7ChBiRAZgaRAJx45bxzx45uNVr0yi30H6Ng
        fq/5Qq84mJTF/AJ8FDawWCeInwy5WcrvoEd04lrgI46M1/UF2FA7y47V1/SY7vAWz5IlOn
        Q16zBvoqebQg1hAMSd98KPgXhCOO4TxNDrHVRR0MdQnXrRck3+tfGWItuz5uMA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Tom Rini <trini@konsulko.com>, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        =?utf-8?b?UmFmYcWCIE1p?= =?utf-8?b?xYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] mtd: call of_platform_populate() for MTD partitions
Date:   Mon, 11 Apr 2022 11:00:32 +0200
Message-Id: <20220411090032.10999-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406143225.28107-1-zajec5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'68471517e883902cdff6ea399d043b17f803b1a8'
Content-Type: text/plain; charset=UTF-8
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

On Wed, 2022-04-06 at 14:32:24 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Until this change MTD subsystem supported handling partitions only with
> MTD partitions parsers. That's a specific / limited API designed around
> partitions.
> 
> Some MTD partitions may however require different handling. They may
> contain specific data that needs to be parsed and somehow extracted. For
> that purpose MTD subsystem should allow binding of standard platform
> drivers.
> 
> An example can be U-Boot (sub)partition with environment variables.
> There exist a "u-boot,env" DT binding for MTD (sub)partition that
> requires an NVMEM driver.
> 
> Ref: 5db1c2dbc04c ("dt-bindings: nvmem: add U-Boot environment variables binding")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
