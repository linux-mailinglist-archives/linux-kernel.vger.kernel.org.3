Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8D2527DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbiEPGrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiEPGrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:47:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CE0DF5D
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HXtrLe4wM5KnGNLV8EoRoh8NQPYMk6Ja6GmCeJwbR1o=; b=pm9p47qiR0Z1/We4vfX2K/b5yy
        i90lk9fZff/yQaULCXj3baGA1FhA816A83ADVFJ+j8Hh9jUIOM8G9q2vpgu0IsM43UkYqubvOlsiC
        +O8aLGDzPkALwrSObhkMaZyaEpq07F3vvDWA1AePb/MSfBCJmvuRSzmtuMWvB9TpKYQsNdp4sGxQ0
        fpNkuZe5i4LVeJgWooKNtNeY/7PsQ5dYA/FOinfdi6PBAZl8kIQGxDP6ih9P6zYw8iIKlsVH6uCG/
        gUNTFzoC+PeNgo/c9o+OhyKlUTtgZDYZIGlwIX9L5h4JXT26WnzEEJOqikv1S3IJJ+biLWWnhYRhw
        KgyLK0CA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqUWB-006FNR-3B; Mon, 16 May 2022 06:47:47 +0000
Date:   Sun, 15 May 2022 23:47:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: Re: [PATCH v10 05/16] riscv: Add has_vector/riscv_vsize to save
 vector features.
Message-ID: <YoHzkxDmMegp5oOz@infradead.org>
References: <cover.1652257230.git.greentime.hu@sifive.com>
 <221f72a2ee62cd5350edb5d6a7e8ebb17a7bc321.1652257230.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221f72a2ee62cd5350edb5d6a7e8ebb17a7bc321.1652257230.git.greentime.hu@sifive.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:31:15AM +0000, Greentime Hu wrote:
> +#ifdef CONFIG_VECTOR
> +#include <asm/vector.h>
> +EXPORT_SYMBOL(rvv_enable);
> +EXPORT_SYMBOL(rvv_disable);
> +#endif

As far as I can tell these are not used by any modular code, just by
the later added kernel mode vector enable helpers.

Even if they were used this would need to be EXPORT_SYMBOL_GPL.

> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + * Copyright (C) 2017 SiFive
> + * Copyright (C) 2019 Alibaba Group Holding Limited
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */

No need for all the GPL boilerplate text when you have an SPDX tag.
