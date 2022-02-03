Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409D4A8221
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350031AbiBCKNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 05:13:45 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:38198 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiBCKNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:13:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23CB1613AFDF;
        Thu,  3 Feb 2022 11:13:43 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DCn2Sc0aGa12; Thu,  3 Feb 2022 11:13:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A46B9614E2C9;
        Thu,  3 Feb 2022 11:13:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N62xb5yN6wDW; Thu,  3 Feb 2022 11:13:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6B45D613AFAE;
        Thu,  3 Feb 2022 11:13:42 +0100 (CET)
Date:   Thu, 3 Feb 2022 11:13:42 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <340602071.12640.1643883222200.JavaMail.zimbra@nod.at>
In-Reply-To: <20220203104654.6cb43ea3@xps13>
References: <20220125104822.8420-1-kernel@kempniu.pl> <20220125104822.8420-5-kernel@kempniu.pl> <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at> <20220203104654.6cb43ea3@xps13>
Subject: Re: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdchar: add MEMREAD ioctl
Thread-Index: hZNaN/vnabP7CZbdubDi1iosoXSpeQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> If mtd->erasesize is large (which is not uncommon these days) you might
>> request more from kmalloc() than it can serve.
>> Maybe kvmalloc() makes more sense?
> 
> Mmmh, I would really like these buffers dma-able.
> 
> I just discovered mtd_kmalloc_up_to(). Would this work?

mtd_kmalloc_up_to() makes sense to be more friendly to the system.
It tries to get memory without forcing write-back and such.
But if we're out of continuous memory it won't help much. 

Regarding dma-able, as soon you use something like UBI/UBIFS ontop of it
the mtd driver has to be able to deal in any way with vmalloc()'ed memory.

Another option would be not working on full erase blocks.

Thanks,
//richard
