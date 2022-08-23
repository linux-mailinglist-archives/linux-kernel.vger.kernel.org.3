Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338959CDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbiHWBN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHWBNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:13:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C46631C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661217201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfh06TyG5c34D7x1kaHxF6+hr4mEnE7ZvWBsUHmo9JM=;
        b=En5V0LvoWKag493UQcTTYPxn6jKGXQv+R246OITink9xk6zGq6Y/87+3T5no7+HYbzIksY
        8vzXfrMvKbBtaQEMET5MP71k61UeTqQLsex9B635vP6igr2KIzXnGMu0Zs7ph0ECX1FztX
        vj+tG8OSmojSlEvkfUJ885kAffFOsws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-q_SzlhyIMgiW9KpYE3iyUA-1; Mon, 22 Aug 2022 21:13:17 -0400
X-MC-Unique: q_SzlhyIMgiW9KpYE3iyUA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47F38811E75;
        Tue, 23 Aug 2022 01:13:17 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 978112026D4C;
        Tue, 23 Aug 2022 01:13:16 +0000 (UTC)
Date:   Tue, 23 Aug 2022 09:13:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Message-ID: <YwQpqTlsMx0mX26a@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <YwHWvjoZF1V4FSlW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHWvjoZF1V4FSlW@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/22 at 11:54pm, Christoph Hellwig wrote:
> > -void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> 
> It seems a bit odd to do this in two steps vs just doing the entire
> change in the first patch.  Any good reason for that?

I will merge patch 1~2 or 1~3 into patch 1. Earlier, I wrote the reason
as below paragraph in cover letter of v1 post. Now it seems not so hard
to tell and understand.

====
For patch 1~3, I don't merge them because I made them in different
rounds of changing. And splitting them makes me easily describe the
intention and make review easier. I can merge them after v1 reviewing
if anyone thinks they should be merged.
====

