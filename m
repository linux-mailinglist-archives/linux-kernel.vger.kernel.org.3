Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211C946DCD7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhLHUSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbhLHUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:17:56 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7657BC0617A1;
        Wed,  8 Dec 2021 12:14:24 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id de30so3141051qkb.0;
        Wed, 08 Dec 2021 12:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G4fw5Ti+UiQ7w487HEijjtWOqTKfd35S+RNoGzr9i00=;
        b=hrA4ap9XEaDLu5eGSHQlnNrEn/7JriXX+yCZeOFr7mliIEELzNB/DmCiVgQnM+XO3u
         j6laJEu8MVWVOKVAHSFrN7Ur/18/DaUzu9TROrMxjfdpQFTJ1sw4R6fu5Tfz4WmUxCAw
         HJAlaINerqMtVWX6nVcuKgquffxN0WhYjlcLTLxK2KtIm6hN5FmbbK/5ZfdtNbEit6CZ
         TQA5f2ZcpV2jsIrCZ1EVFHYM6gv9E8lzZukMGCjl9M+y90xrcqLjIVDdljv2nICW/Jff
         q48o2I3veMGsTU3r6Y0BXu3NooeDCi9BGjVO0grBeoZ6nzkiwH6GyEto+nuVPlWElTGS
         Vuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G4fw5Ti+UiQ7w487HEijjtWOqTKfd35S+RNoGzr9i00=;
        b=ydEebVa4aJS6stXT4z7V1ug26IWguO/Ty1Ikk+jwNlb6DDto12rN5fQw+PD+GFc5pt
         +5UHkbjfctvxnGHv31YSyRnimwvJYZh6HjXyZhibuKM3KFRJg1zT2Yy7OE8+wFqBfE6B
         oAdktqgkAh+N3F1gCGl5Bz7HmKc5bE3ChwajGjq+ytN33Rv7x+Lh5mLSuZEIXSdgJhse
         H26tJyv+Tu06tb/uZgpefVLJ5uTtlFO+62WrINlqq6u2+QTtmhY1hCvMIVqWAnCZUAYK
         NPdrLzxk01KFrHMVnhaiXb6OzWeo5JWArC7UlCTvDymUfbq8t8uY0uiFhZmRIv1KhJoH
         4/3A==
X-Gm-Message-State: AOAM53124BFSjAHJA+lIz3ilNvRVbS0P44To0oATWNnPCaIWOcJ2mkRv
        7x434Hx48YBmumC/rXhzBv0=
X-Google-Smtp-Source: ABdhPJyY7TpHyM8KPoVtv7UOZEBgaJzFHx7KfS6n7ACkDd1e/yHkA4Nd/tt5YJclxi/SrZGHcIubKg==
X-Received: by 2002:a05:620a:44c1:: with SMTP id y1mr8994932qkp.647.1638994463591;
        Wed, 08 Dec 2021 12:14:23 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id r20sm2125847qkp.21.2021.12.08.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 12:14:22 -0800 (PST)
Date:   Wed, 8 Dec 2021 15:14:20 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com, paulus@ozlabs.org,
        Joel Stanley <joel@jms.id.au>,
        Stafford Horne <shorne@gmail.com>,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YbESHK06Tpw3typS@errol.ini.cmu.edu>
References: <20211204204121.2367127-1-gsomlo@gmail.com>
 <20211204204121.2367127-4-gsomlo@gmail.com>
 <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXh6YfRdGi8gYc4hJuTwogme6+Esn9Mf1vr9MFO=f8mAg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

I did *some* of this for v3, but since figured out how to use `pahole` :)

On Mon, Dec 06, 2021 at 11:07:56AM +0100, Geert Uytterhoeven wrote:
> > +struct litex_mmc_host {
> > +       struct mmc_host *mmc;
> > +       struct platform_device *dev;
> > +
> > +       void __iomem *sdphy;
> > +       void __iomem *sdcore;
> > +       void __iomem *sdreader;
> > +       void __iomem *sdwriter;
> > +       void __iomem *sdirq;
> > +
> > +       u32 resp[4];
> > +       u16 rca;
> > +
> > +       void *buffer;
> > +       size_t buf_size;
> > +       dma_addr_t dma;
> > +
> > +       unsigned int freq;
> > +       unsigned int clock;
> > +       bool is_bus_width_set;
> > +       bool app_cmd;
> > +
> > +       int irq;
> > +       struct completion cmd_done;
> 
> You may want to reorder the members to avoid implicit gaps
> (i.e. structs first, followed by integral types in decreasing size).

So, for v4, I'll have it looking like this, which `pahole` says is
optimally packed:

struct litex_mmc_host {
	struct mmc_host *          mmc;                  /*     0     8 */
	struct platform_device *   dev;                  /*     8     8 */
	void *                     sdphy;                /*    16     8 */
	void *                     sdcore;               /*    24     8 */
	void *                     sdreader;             /*    32     8 */
	void *                     sdwriter;             /*    40     8 */
	void *                     sdirq;                /*    48     8 */
	void *                     buffer;               /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	size_t                     buf_size;             /*    64     8 */
	dma_addr_t                 dma;                  /*    72     8 */
	struct completion          cmd_done;             /*    80    32 */
	int                        irq;                  /*   112     4 */
	unsigned int               ref_clk;              /*   116     4 */
	unsigned int               sd_clk;               /*   120     4 */
	u32                        resp[4];              /*   124    16 */
	/* --- cacheline 2 boundary (128 bytes) was 12 bytes ago --- */
	u16                        rca;                  /*   140     2 */
	bool                       is_bus_width_set;     /*   142     1 */
	bool                       app_cmd;              /*   143     1 */

	/* size: 144, cachelines: 3, members: 18 */
	/* last cacheline: 16 bytes */
};


Thanks again,
--Gabriel
