Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E01C5138FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349619AbiD1Pt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349611AbiD1PtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:49:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EED939FF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=H8t3i1Ilo0TsM4g1vXvltMjUgO5KYNHNYngAHD4WDa0=; b=rfhN9PZLACHZ4LhiiVnE+Rumfm
        fq8WiCT2P2F6C18PE0vD1csAJKP1ZOnry5Mbcscy1AmrKHq0gyrctYuoG38DUaUspoiQvoWBszq9H
        6DP2CKgyushXlZfDCqCv05gBVyNBijQnD3gdjTYX44BXc5Zwru6Xc6tLnGcE6u9ySieym1iq3d/0+
        mlHEiGsJ7GRrgjSaPjQXQ37qFBnv755Z/ajUBFiZr95aoYxosXE6CU8W3GRsf01MeHzRfskxAjZ3D
        9SOJGtcL5+mwMMeCFuZrwOXjSYJLdSmBzPBKv7VKv7YGhZWU0W4p6aV2vtTr7ZLARjMjbPhiscvKg
        xCOQYFQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk6LB-007iRi-Db; Thu, 28 Apr 2022 15:46:01 +0000
Date:   Thu, 28 Apr 2022 08:46:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
Message-ID: <Ymq2uX/Y15HlIpo7@infradead.org>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
 <20220427121413.168468-3-wangkefeng.wang@huawei.com>
 <20220427100411.8eaf54c51767c3e2b0b070a5@linux-foundation.org>
 <8d5c41a6-0478-bd5c-a37b-06a37101fc31@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d5c41a6-0478-bd5c-a37b-06a37101fc31@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 02:16:39PM +0800, Kefeng Wang wrote:
> > Pet peeve.  The word "check" is a poor one.  I gives no sense of what
> > the function is checking and it gives no sense of how the function's
> > return value relates to the thing which it checks.
> > 
> > Maybe it returns 0 on success and -EINVAL on failure.  Don't know!
> > 
> > Don't you think that better names would be io_remap_ok(),
> > io_remap_valid(), io_remap_allowed(), etc?
> 
> Will use arch_ioremap/unmap_allowed(), and I'd like to keep return bool
> 
> for now if there is no special requirements.

Actually, there are a few architectures that can successfully ioreamp
without setting up new ptes, e.g. mips.

So I think I'd name them just arch_ioremap and arch_iounmap, and
return a "void __іomem *" from arch_ioremap, where:

 - IS_ERR means return an error
 - NULL means continue to remap
 - a non-NULL, non-IS_ERR pointer is directly returned.
