Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20D4544D29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbiFINKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiFINKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:10:24 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB87AEAD01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:10:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 40FC5FF807;
        Thu,  9 Jun 2022 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654780219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITj+D6pf4vtJjIg4YV1QMKa+PIL6lnpS+3b87tjq90M=;
        b=mAkTn72lcLs7xI8y9hbrIHnbX5b18ahqU2B5H+lbYuyxFIdQoaezMhxlGYOqMc5GqppSaX
        wqOnCCaLWC/nPa/NnTnqU1H6GNdll7X8RLDrmc9yOP6VCj8pgDyU0bIOefXuRFzJX8rihP
        ZAIYPo3L08gnZPKBj08D5veCGppkuMjMaBz4IGvfnS94kzCJQoQqawYVEnmbAwvQQhAxDQ
        VkEu4bd2+cV7HXpHP4HyFvMFIUIHP+h946m+wfIoBLUBQSfdmqbTAY0+YJFE/BgtdGhR6S
        6SuVe2ghmdDJORoON1KMf2H4mz/E0xDvs8P1SsNad3Sbw9F7bhqDiZqzObmjmA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtdchar: use kvmalloc() for potentially large allocations
Date:   Thu,  9 Jun 2022 15:10:18 +0200
Message-Id: <20220609131018.293486-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516070601.11428-3-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'83208e106a8e8a859110ebb04a5e927ced911afb'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-16 at 07:06:01 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> mtdchar_write_ioctl() calls kmalloc() with the 'size' argument set to
> the smaller of two values: the write request's data/OOB length provided
> by user space and the erase block size of the MTD device.  If the latter
> is large, kmalloc() may not be able to serve such allocation requests.
> Use kvmalloc() instead.  Correspondingly, replace kfree() calls with
> kvfree() calls.
> 
> Suggested-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> Acked-by: Richard Weinberger <richard@nod.at>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
