Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8464A814E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiBCJTB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 04:19:01 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:37448 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiBCJS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:18:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CB4CE614E2C9;
        Thu,  3 Feb 2022 10:18:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ig2hg8HhEsea; Thu,  3 Feb 2022 10:18:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 21F80613AFDF;
        Thu,  3 Feb 2022 10:18:57 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6NhwpoOldHN9; Thu,  3 Feb 2022 10:18:57 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEED3613AFD6;
        Thu,  3 Feb 2022 10:18:56 +0100 (CET)
Date:   Thu, 3 Feb 2022 10:18:56 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at>
In-Reply-To: <20220125104822.8420-5-kernel@kempniu.pl>
References: <20220125104822.8420-1-kernel@kempniu.pl> <20220125104822.8420-5-kernel@kempniu.pl>
Subject: Re: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdchar: add MEMREAD ioctl
Thread-Index: 4v2g4Z4lx0v5vFZ8+gLXLp2J71QhHg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michał,

----- Ursprüngliche Mail -----
> Von: "Michał Kępień" <kernel@kempniu.pl>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> CC: "Boris Brezillon" <boris.brezillon@collabora.com>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 25. Januar 2022 11:48:22
> Betreff: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl

> +	if (req.start + req.len > mtd->size) {

I think this can overflow since both req.start and req.len are u64.
So an evil-doer might bypass this check.

> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
> +	if (datbuf_len > 0) {
> +		datbuf = kmalloc(datbuf_len, GFP_KERNEL);

If mtd->erasesize is large (which is not uncommon these days) you might
request more from kmalloc() than it can serve.
Maybe kvmalloc() makes more sense?

> +		if (!datbuf) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +	}
> +
> +	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
> +	if (oobbuf_len > 0) {
> +		oobbuf = kmalloc(oobbuf_len, GFP_KERNEL);

Same.

Thanks,
//richard
