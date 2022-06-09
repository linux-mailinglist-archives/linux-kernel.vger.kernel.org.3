Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B325442D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiFIFFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFIFFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:05:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155722911F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wu8aFObH2hHSMKYcBRx522Iw5QK4xZIvlYeZFEP3Kk8=; b=AGFJ5yCS6ccyDZaWrHTtIENtg2
        ewgk3wbTcgyJwqkGBn/ECO0YkpnGr1nhlzroXQ0e44S3K0rloI9v7JC83sD3Y+DkscyzxXtRq6seC
        5BE4mdWoEqX0Vgn4MxsbbkI6XMr8CcpNWB7qMagiEN2yOqELMm7CRGAWlXy+QVLDeK0tjLXFZUb9J
        JzBYTt0lYEem70Oabsxdet520DwMot9ysqcapl0IQqwDDK88mt0arOXL0CrgBrBZzbntk0nnGmXJG
        u1dvlEEXt4AiKYNPte6f6uIgPw4n1FjwNUbg8QzgaLNbbJ2FvoFqCi6bB/hwjUaqIjVN/4DtjsKn3
        waLCjuCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzALp-00Gmug-RP; Thu, 09 Jun 2022 05:04:57 +0000
Date:   Wed, 8 Jun 2022 22:04:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        m.szyprowski@samsung.com, jgross@suse.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        sstabellini@kernel.org, mpe@ellerman.id.au, konrad.wilk@oracle.com,
        mst@redhat.com, jasowang@redhat.com, joe.jin@oracle.com
Subject: Re: [PATCH RFC v1 1/7] swiotlb: introduce the highmem swiotlb buffer
Message-ID: <YqF/eZE9eozDURWz@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-2-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609005553.30954-2-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:55:47PM -0700, Dongli Zhang wrote:
> @@ -109,6 +109,7 @@ struct io_tlb_mem {
>  	} *slots;
>  };
>  extern struct io_tlb_mem io_tlb_default_mem;
> +extern struct io_tlb_mem io_tlb_high_mem;

Tis should not be exposed.

> +extern bool swiotlb_high_active(void);

And this should not even exist.

> +static unsigned long high_nslabs;

And I don't think "high" is a good name here to start with.  That
suggests highmem, which we are not using here.
