Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5269C53E5E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiFFQ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbiFFQ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:28:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ABC309793
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ySO04BQMERNCntShqOb8/rNfxsKhEd7ILgGbDAOV4w0=; b=H6WifuO0/6N7vAHH54RYwAlnqo
        Hyluy/Ch1n37hU2m3hG5j12KRTvuxPdcJQTeCPU29Du3eK2gP5gOm/bzEhTS0PrPzmAwq1HfeQZkY
        qBsSPwSDwoa7IdAQocgBFZZvqw60famOZ426duHRmHEhwZTmghgOExqFS1jMPz/6eCQvlyh/sKUZ+
        CViWhH7nEU7NVedIywrkFR/H2ZyG57V4ex5PtkgV1ADfrK8WA52ayevSsY8O7NPSdvvPTFfrrai3J
        FvN67L5wuD+tPVtOYfMfsWogMK0836TJvomfeAmHv3EAgIKi3RdKpecNtzIoihMedyOg1ClCjfuDd
        p/sSeGsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyFaM-0022H0-HN; Mon, 06 Jun 2022 16:28:10 +0000
Date:   Mon, 6 Jun 2022 09:28:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, anshuman.khandual@arm.com
Subject: Re: [PATCH v4 5/6] arm64: mm: Convert to GENERIC_IOREMAP
Message-ID: <Yp4rGsj0eFcGRMmC@infradead.org>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
 <20220606074815.139265-6-wangkefeng.wang@huawei.com>
 <Yp2yoRkHLuONDO9y@infradead.org>
 <7a8f19b5-f22e-83be-0f9a-63cef6152812@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a8f19b5-f22e-83be-0f9a-63cef6152812@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 09:28:22PM +0800, Kefeng Wang wrote:
> As commit bdc48fa11e46  ("checkpatch/coding-style: deprecate 80-column
> warning") increased
> 
> the limit to 100 columns，so I don't get warning when using checkpatch, and
> it is not a hard limit,

No, it did not increase the general limit, just for exception cases.
Block comments certainly don't fall under that, and while the mileage
on the defineѕ may vary it generally is more readable to have them
on the next line.

checkpath is unfortunately totall broken these days :(

> 
> but if this is a mandatory requirement, I will resend them with break lines.
> 
> > > +#define ioremap_cache(addr, size) ({							\
> > > +	pfn_is_map_memory(__phys_to_pfn(addr)) ?					\
> > > +	(void __iomem *)__phys_to_virt(addr) : ioremap_prot(addr, size, PROT_NORMAL);	\
> > > +})
> > And this really should be an inline function.
> 
> We still need a define, see kernel/iomem.c,

You can just define it to the same name after the inline.
