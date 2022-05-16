Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893F952868A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbiEPOKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiEPOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:10:22 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC23B001
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:10:20 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id c19-20020a4a3813000000b0035ea4a3b97eso4020657ooa.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3L9ucVaR/Ejc1j0lbTxJ50RjR5DDft1mXnfjZbe8XHI=;
        b=kAT+QhfzSE4Rv08p4UM1CjKAom7zKObZf2OKcy5fXfLNxtuRPYKKwYChwNtwR4Aqce
         YgYMx7SOIRE6dF0bgdXbmewYbRR0B+MoL0E8fCjvpX5MNFsp1hsUY4lGVYuG09gelIGn
         p/U41VzFdduU/yYeT2g6XzrPQHrKxNuQW8eXweG6qYsUCtI9hIzkeTtxXZlnUW7TjQG8
         YLMjUZdJw17HouZps03Qo2ZJeR+UyX/uL+X+zoDH957b0E8IuMax5dazbUcfyb0Nannv
         dR4S2vD9ss7OwjfmzGmG5lxLFgc8yDJOA1X1ij4oZoTSrXnlIFW39tmGV4yUHYHX8PfV
         f8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3L9ucVaR/Ejc1j0lbTxJ50RjR5DDft1mXnfjZbe8XHI=;
        b=Fyr2FbSD+9FtVWYxzevieSuRiWztKutNK+M+2iThWnnFVl3vsoEjrr+1vPq6qF3eeQ
         sBV5TBUX9l11/lxxz2epI7VN0rTJEV7Z6RnBJCSZmelPlCsi/FxBEt1LrKc96hqGmvfv
         brkeDXqQ4+SJUbNrVDkgTTLRd+kdarLXKMcDPYj0zg2YoWCmbVkTryPtuydaYQ/iacpQ
         rGqARUyWzUN/asyG5AorZvdNKUYN6t45YE+BDr/sq1p9azziLHBCnvR4zfysBKiKIGv+
         uxoOrpbgahJfJRw4P9WySEIymr0ySDBu7ZAxz+wGpt1dIvGshvwtBT37UCQa7MmEDSnX
         bBNw==
X-Gm-Message-State: AOAM532Z7pqTMvJuRMlW/OkpUiH7nOns01HETl4mI8V7PaKa1kd6j2lF
        IuCJHmcrFq0sx5ECn/EFntldRbpyLHZD+7joiyk=
X-Google-Smtp-Source: ABdhPJyqMj2s7jfJDLnF/x95jeeMc9LMg+uGl/fQSL/8oDUhl/dYxxYmMXphzX9sA5hJ+jbtT7eycyWH/Ms4xPQo0L8=
X-Received: by 2002:a4a:8c41:0:b0:362:19a7:7529 with SMTP id
 v1-20020a4a8c41000000b0036219a77529mr6055010ooj.38.1652710219915; Mon, 16 May
 2022 07:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220414143426.723168-1-gch981213@gmail.com> <20220414143426.723168-2-gch981213@gmail.com>
 <05966ece-65c8-ff7c-cb44-55c4d5a5542e@kontron.de>
In-Reply-To: <05966ece-65c8-ff7c-cb44-55c4d5a5542e@kontron.de>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Mon, 16 May 2022 22:10:08 +0800
Message-ID: <CAJsYDVJ=WRT270mj2jNc+yy0v_XRpyH8N+GOmkNJv1zAh76rDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spinand: add support for detection with param page
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, May 16, 2022 at 3:38 PM Frieder Schrempf
<frieder.schrempf@kontron.de> wrote:
>
> Hi Chuanhong,
>
> Am 14.04.22 um 16:34 schrieb Chuanhong Guo:
> > SPI-NAND detection using chip ID isn't always reliable.
> > Here are two known cases:
> > 1. ESMT uses JEDEC ID from other vendors. This may collapse with future
> >    chips.
> > 2. Winbond W25N01KV uses the exact same JEDEC ID as W25N01GV while
> >    having completely different chip parameters.
>
> I think they share the same first byte of the JEDEC ID, but the second
> byte actually differs and would allow to differentiate between them, right?

No. For the 128M version, all 3 bytes are the same between
W25N01GV and W25N01KV.

>
> I have this patchset [1] that I didn't manage to send upstream yet which
> adds support for the W25N02KV. I added the second ID byte to detect them.
>
> Still your approach using the ONFI data is more flexible of course and
> probably a better way to handle this. I will see if I can find some time
> to add support for the W25N02KV based on your patches.

Don't do that. I abandoned this patchset because I later found that
some early W25N01GV doesn't contain a parameter page at all,
which means detecting W25N01GV/KV using only the parameter
page is unreliable.
I think what Boris proposed earlier in v1 (use parameter page
just to distinguish the two chips) is the correct way to go.

BTW I was making this patchset for a potential future ID conflict
between ESMT and GigaDevice, and I don't actually need to
deal with the W25N01GV/KV nonsense now, so I don't have a
plan for send a new version of this atm.

-- 
Regards,
Chuanhong Guo
