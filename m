Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD459CEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbiHWCm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 22:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238943AbiHWCmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17315C364
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661222573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YgbO8iFV6P0Cia6+3yhw+UCHidRLj9zT3dgvk0gufSI=;
        b=StAsM2OZzPqoI83hBNGKIFcsc4RLzI/vq955buAhx1A9g20Zwx7rdLfTiMJekc27zp8o+x
        mAgs1LodJfyD66T6aogdv2flSBbtRA9lnuxg2I5a0zEQWB/MhLEZuSu8u8LyFcVYCU9v6I
        tTSkuBugcfPO5Kdel0ZJyuiokdVESKU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-h3Fs69brOC2KXtLqff6kzw-1; Mon, 22 Aug 2022 22:42:50 -0400
X-MC-Unique: h3Fs69brOC2KXtLqff6kzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 283A13C01E12;
        Tue, 23 Aug 2022 02:42:50 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5017D492C3B;
        Tue, 23 Aug 2022 02:42:48 +0000 (UTC)
Date:   Tue, 23 Aug 2022 10:42:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 03/11] mm: ioremap: allow ARCH to have its own ioremap
 definition
Message-ID: <YwQ+pBNMGuHq2s+V@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-4-bhe@redhat.com>
 <YwHXWdycBZr+bluG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHXWdycBZr+bluG@infradead.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/22 at 11:57pm, Christoph Hellwig wrote:
> On Sat, Aug 20, 2022 at 08:31:17AM +0800, Baoquan He wrote:
> > Architectures like xtensa, arc, can be converted to GENERIC_IOREMAP,
> > to take standard ioremap_prot() and ioremap_xxx() way. But they have
> > ARCH specific handling for ioremap() method, than standard ioremap()
> > method.
> 
> Do they?
> 
> For arc, the arc_uncached_addr_space case can be easily handled by
> arch_ioremap, and the xtensa case looks very similar to that.

I am worried it will impact ioremap_prot(). Arc has selected
HAVE_IOREMAP_PROT in Kconfig. Putting arc_uncached_addr_space() calling
into arch_ioremap() will change ioremap_prot(), right?

And I have the same about xtensa. You can see ioremap() and
ioremap_cache() will return different value since they take
XCHAL_KIO_BYPASS_VADDR and XCHAL_KIO_CACHED_VADDR differently. I haven't
figured out a way to handle them in arch_ioremap() differently.

static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
{
        if (offset >= XCHAL_KIO_PADDR
            && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
                return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_BYPASS_VADDR);
        else
                return xtensa_ioremap_nocache(offset, size);
}

static inline void __iomem *ioremap_cache(unsigned long offset,
                unsigned long size)
{
        if (offset >= XCHAL_KIO_PADDR
            && offset - XCHAL_KIO_PADDR < XCHAL_KIO_SIZE)
                return (void*)(offset-XCHAL_KIO_PADDR+XCHAL_KIO_CACHED_VADDR);
        else
                return xtensa_ioremap_cache(offset, size);
}

> 
> I'd really like to kill off arch definitions of ioremap going
> forward, as they should just be a special case of ioremap_prot
> by definition.

