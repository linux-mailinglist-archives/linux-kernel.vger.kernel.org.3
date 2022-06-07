Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36E253FA59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiFGJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiFGJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:51:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A69ED783
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V51MCqxi0VdJWmnfuDPQt2vBU7orKrYz4MHoXseJ8Uc=; b=lpBAKPfTbALftwi2xeDgAO3ehh
        89/3lBrHiHenx6805RN9wWVwR3WhentuV2zuMFLZyWzx6wnUf0UcqRmi66uhJGFL6A8zCCbvQ5lm2
        MqIKPjcdNJ2gcBkeKiEj4YQOntFHTsoDxkRaYLNPVjuf+Iki8zNhngnEIW02e0f21yrm51zN19mjK
        PPqfLGM1llNlEftGJkJ9sHwEqnPbaGBWZJ0MtqdZ0XxBfpR4XPlxQygkJ9J6uTXDCgdNBhN4yJpDs
        ZkOtNBLFB8gyoIJqtjHbE4PIR8fRskJgZn8cgxKR54IZUpGY7JQ/+4VX7SLuEXK8BKzWdr3OgoYqH
        oPA5AwcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyVqY-006P3h-8g; Tue, 07 Jun 2022 09:49:58 +0000
Date:   Tue, 7 Jun 2022 02:49:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/5] mm/vmalloc: Extend __alloc_vmap_area() with extra
 arguments
Message-ID: <Yp8fRttJPpZ+0+gu@infradead.org>
References: <20220607093449.3100-1-urezki@gmail.com>
 <20220607093449.3100-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607093449.3100-3-urezki@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 11:34:46AM +0200, Uladzislau Rezki (Sony) wrote:
> It implies that __alloc_vmap_area() allocates only from the
> global vmap space, therefore a list-head and rb-tree, which
> represent a free vmap space, are not passed as parameters to
> this function and are accessed directly from this function.

Yes, which totally makes sense.

> Extend the __alloc_vmap_area() and other dependent functions
> to have a possibility to allocate from different trees making
> an interface common and not specific.

Which seems completely pointless.  Why add argument that are always
passed the same values?
