Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7154542585
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbiFHAeE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Jun 2022 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445942AbiFGXEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:04:30 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF135D46C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 13:23:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7957D61B8B69;
        Tue,  7 Jun 2022 22:23:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9QQEM-g-k7R7; Tue,  7 Jun 2022 22:23:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D08F7608110A;
        Tue,  7 Jun 2022 22:23:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7tquQMvYHDkA; Tue,  7 Jun 2022 22:23:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9CD0D61B8B5A;
        Tue,  7 Jun 2022 22:23:12 +0200 (CEST)
Date:   Tue, 7 Jun 2022 22:23:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1710081060.147491.1654633392520.JavaMail.zimbra@nod.at>
In-Reply-To: <20220516070601.11428-2-kernel@kempniu.pl>
References: <20220516070601.11428-1-kernel@kempniu.pl> <20220516070601.11428-2-kernel@kempniu.pl>
Subject: Re: [PATCH 1/2] mtdchar: prevent integer overflow in a safety check
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdchar: prevent integer overflow in a safety check
Thread-Index: JX134mBLLXSr5mg7slOI+t/fmFEWJA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Michał Kępień" <kernel@kempniu.pl>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Montag, 16. Mai 2022 09:06:00
> Betreff: [PATCH 1/2] mtdchar: prevent integer overflow in a safety check

> Commit 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE
> ioctl") added a safety check to mtdchar_write_ioctl() which attempts to
> ensure that the write request sent by user space does not extend beyond
> the MTD device's size.  However, that check contains an addition of two
> struct mtd_write_req fields, 'start' and 'len', both of which are u64
> variables.  The result of that addition can overflow, allowing the
> safety check to be bypassed.
> 
> The arguably simplest fix - changing the data types of the relevant
> struct mtd_write_req fields - is not feasible as it would break user
> space.
> 
> Fix by making mtdchar_write_ioctl() truncate the value provided by user
> space in the 'len' field of struct mtd_write_req, so that only the lower
> 32 bits of that field are used, preventing the overflow.
> 
> While the 'ooblen' field of struct mtd_write_req is not currently used
> in any similarly flawed safety check, also truncate it to 32 bits, for
> consistency with the 'len' field and with other MTD routines handling
> OOB data.
> 
> Update include/uapi/mtd/mtd-abi.h accordingly.
> 
> Suggested-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Michał Kępień <kernel@kempniu.pl>
> ---
> drivers/mtd/mtdchar.c      | 3 +++
> include/uapi/mtd/mtd-abi.h | 4 ++--
> 2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index d0f9c4b0285c..b2700f8467ff 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -615,6 +615,9 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
> 	if (!usr_oob)
> 		req.ooblen = 0;
> 
> +	req.len &= 0xffffffff;
> +	req.ooblen &= 0xffffffff;
> +

Yeah, I think it is reasonable to limit write requests to 4GiB.

Thanks,
//richard
