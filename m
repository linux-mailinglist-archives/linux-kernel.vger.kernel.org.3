Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367214B4E7C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351831AbiBNLdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:33:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352889AbiBNLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:32:01 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B24553B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:18:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu29so24630558lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7lnMhtpi0tedfFeaMFYKaQ71qw/HvwjAz4fhdXBH9Yc=;
        b=GmIVfeBVHFoj2YipuxdPvmcHpJKJ5UqQJdD8lrN7iLIxX7C/Jk27HNQtBZbsbnUpp7
         3Fya2xulzvXorMJOya4wQofhyNaVxz8NZJvqvScB0HfqNzq3NQebWapLsmZuVldqY0XD
         HMvdfGibYpIpl/3bXD88L9k+BTSpX8EYbvS1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7lnMhtpi0tedfFeaMFYKaQ71qw/HvwjAz4fhdXBH9Yc=;
        b=kW0Nqj0gNY6anJJwCEUs406XP9Ue11yQCI6gyCduG7KUFc4s2hq0fblIJGtu90eDqE
         X4HRKEa+34wIapDBJlcwMGOq4epJXySqABf3e2KLpLl/jU+SjjStYnMvl1fNNY/oxkxX
         Sz55vnAaIRD++hSS2yQhtM3/7x/TyfeW5KcIJ6LhOHazNe0m6/+p61WGxORUaTBX4/AU
         buLivP+9PhDvxN4OK3HkQ9NUJNVOh351jlY8fdMQM5k61terbFjr1PExTrqsgMrvfPvc
         aIFRHWV+LCjvt7Ue9Gezg4W38OFF3HHCA3wuKBhpWh7ekDO8JmZ984CIa8XHIfTAZN95
         dVsw==
X-Gm-Message-State: AOAM5330Fth95ZPwtHHIwgP4AO81qHpKTHbItcziFoW9Nb0lU9o0V/3u
        0x3bf+/HvPGuBO2cWuzRq+ecAw==
X-Google-Smtp-Source: ABdhPJzSDp0H18d5H8r0FNVwaPQJ2g+FcKDiACv/T0F5hHOqnzy5wXWf2xbE3lV0tdzzKb+18LuMYw==
X-Received: by 2002:a19:385a:: with SMTP id d26mr10711937lfj.220.1644837495267;
        Mon, 14 Feb 2022 03:18:15 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id o17sm527233lfr.240.2022.02.14.03.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 03:18:14 -0800 (PST)
Date:   Mon, 14 Feb 2022 12:18:12 +0100
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl
Message-ID: <Ygo6dNsVn1Y6c3PJ@larwa.hq.kempniu.pl>
References: <20220125104822.8420-1-kernel@kempniu.pl>
 <20220125104822.8420-5-kernel@kempniu.pl>
 <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at>
 <20220203104654.6cb43ea3@xps13>
 <340602071.12640.1643883222200.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340602071.12640.1643883222200.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> If mtd->erasesize is large (which is not uncommon these days) you might
> >> request more from kmalloc() than it can serve.
> >> Maybe kvmalloc() makes more sense?
> > 
> > Mmmh, I would really like these buffers dma-able.
> > 
> > I just discovered mtd_kmalloc_up_to(). Would this work?
> 
> mtd_kmalloc_up_to() makes sense to be more friendly to the system.
> It tries to get memory without forcing write-back and such.
> But if we're out of continuous memory it won't help much. 
> 
> Regarding dma-able, as soon you use something like UBI/UBIFS ontop of it
> the mtd driver has to be able to deal in any way with vmalloc()'ed memory.

Note that the MEMWRITE ioctl is affected by the same issue.  Judging
from the discussion above, I assume a separate patch is in order to turn
kmalloc() calls in mtdchar_write_ioctl() into kvmalloc() calls?

> Another option would be not working on full erase blocks.

Right, the approach proposed in this patch series and also previously in
commit f6562bca84d22525f792305e3106571f8714d057 ("mtdchar: prevent
unbounded allocation in MEMWRITE ioctl") is a trade-off.  I followed a
suggestion I heard earlier:

https://lists.infradead.org/pipermail/linux-mtd/2021-September/088485.html

-- 
Best regards,
Michał Kępień
