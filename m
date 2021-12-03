Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4C46788A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381259AbhLCNks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:40:48 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:45471 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352522AbhLCNkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:40:47 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 8F904240009;
        Fri,  3 Dec 2021 13:37:21 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Date:   Fri,  3 Dec 2021 14:37:20 +0100
Message-Id: <20211203133721.1449880-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211130113149.21848-1-kernel@kempniu.pl>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ab14a0c836f88996e4151381a06b632e1524cec7'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-11-30 at 11:31:49 UTC, =?utf-8?b?TWljaGHFgiBLxJlwaWXFhA==?= wrote:
> In the mtdchar_write_ioctl() function, memdup_user() is called with its
> 'len' parameter set to verbatim values provided by user space via a
> struct mtd_write_req.  Both the 'len' and 'ooblen' fields of that
> structure are 64-bit unsigned integers, which means the MEMWRITE ioctl
> can trigger unbounded kernel memory allocation requests.
> 
> Fix by iterating over the buffers provided by user space in a loop,
> processing at most mtd->erasesize bytes in each iteration.  Adopt some
> checks from mtd_check_oob_ops() to retain backward user space
> compatibility.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
