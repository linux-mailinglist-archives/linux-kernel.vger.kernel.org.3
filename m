Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC45A40C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 03:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiH2Bkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 21:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH2Bki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 21:40:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993AA192A5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661737234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0vCF2MFLwabeNCUHxCLBI4UWY8z6BpyfJcEettVVvuc=;
        b=EpZgxBT9LcyHIx4A85HcZ4xyPZZAjCBhsoTIqMSy/rt+KrDjrOlSM3kqXxzBBFyPo6GntN
        Heu5u6QydNsyL0yl0gtJWLS5scbXngLrf5E58UP379aBFJ5hPg2Dz3gGoQuvnu8/bjVdVB
        4ALzbmC/bbRqeeDOQzsD8NwL4Zudq88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-LevrZ2iyNZi2Fkpakragqg-1; Sun, 28 Aug 2022 21:40:29 -0400
X-MC-Unique: LevrZ2iyNZi2Fkpakragqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 092B3101A54E;
        Mon, 29 Aug 2022 01:40:29 +0000 (UTC)
Received: from localhost (ovpn-12-153.pek2.redhat.com [10.72.12.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EDB34010FCC;
        Mon, 29 Aug 2022 01:40:27 +0000 (UTC)
Date:   Mon, 29 Aug 2022 09:40:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwwZCO279Vh/cXGW@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
 <YwHYx0eXouIWnN8Z@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHYx0eXouIWnN8Z@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/22 at 12:03am, Christoph Hellwig wrote:
> > +	if (unlikely(!mem_init_done)) {
> >  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> > +			return IOMEM_ERR_PTR(ret);
> >  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> >  		fixmaps_used += (size >> PAGE_SHIFT);
> >  
> > +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
> >  			fixmaps_used -= (size >> PAGE_SHIFT);
> > +			return IOMEM_ERR_PTR(ret);
> > +		}
> > +
> > +		return (void __iomem *)(offset + (char *)v);
> >  	}
> 
> This code needs to go away, and all very early boot uses of ioremap
> need to switch to use early_ioremap insted.

Makes sense. On openrisc, the thing is I didn't find one place where
ioremap() is called in arch code. I can cut the early ioremap out and
wrap into a separate early_ioremap() function, however I don't know
where to put it. Not sure if I miss anything or openrisc doesn't really
need early ioremap.

