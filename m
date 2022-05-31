Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D742538B37
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbiEaGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiEaGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:13:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8059583A9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=oP50eN9t5yv5xEkcX81jIxpm+e6cTYAZZRL3L9ecqxQ=; b=drNBkxIlcJDrmNbdmpUMLoFukQ
        7sbvyNSJ4GkYzu0I9UJvqx312tkh/3gImrxTdJFBBho7FzOr2ktiAEslARXKAMCrr7G+gDBv3kg8f
        +d3K98Uc8JRZrDM0vxkKvQ+gC9h5dxUfcJaN0jT6UbeDhw0imIchkgicMYPgcEwTIzHev7mPdEquU
        g3CR4ty5Lr+ShC7HxRHDean2DrXFvzYkuQ8lQs3lb4K0idcrbLFU+0BK3FpH9sCCRXDOHoUVtfYd2
        LBS4VZxej795sXwUyXySbz5FYYQNa+vgXONrMT60fNUACnMuYrvbxQZ0M8TQPdPGp0EOlXiYJ+VCk
        WpRJ8fYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvv7n-009WFA-1w; Tue, 31 May 2022 06:13:03 +0000
Date:   Mon, 30 May 2022 23:13:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Message-ID: <YpWx7w01ySsqECmE@infradead.org>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
 <20220519082552.117736-5-wangkefeng.wang@huawei.com>
 <CAK8P3a1DbNY6NzcwzjVFvd9yw6L3YBHQos_hmE=nG=6cuv1DAg@mail.gmail.com>
 <4c848b48-6ddf-664a-6296-d85ab49a694d@huawei.com>
 <CAK8P3a19S8CFxJKQo_8UXSKA0L8J40DsjL+u649oDhqUPHSW7A@mail.gmail.com>
 <f9bbfe38-ce1d-b4c4-6acf-4b81e6587e2d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9bbfe38-ce1d-b4c4-6acf-4b81e6587e2d@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 10:53:54PM +0800, Kefeng Wang wrote:
> Christoph  suggested in the first version,
> 
> https://lore.kernel.org/linux-arm-kernel/Ymq2uX%2FY15HlIpo7@infradead.org/

Yeah, mostly to eventually also covers mips.  But if this causes
problems now please just dumb it down and we can revisit the interface
when actually needed.
