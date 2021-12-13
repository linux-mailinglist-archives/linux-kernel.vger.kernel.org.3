Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F61472238
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhLMIQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20722 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhLMIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639383411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+tHNmWsXHqcSXz+1QchJ4aeYMeCytpwxeNZBwI7ZNEo=;
        b=BKS9EP/kQ/JhVeGh+PcwmaH6opleEUJXpBiilpB6K4ZSyOn6ox1fZJgIGvwPiah/G8ygXT
        EC7+jJymd2orHGzqVtpLdmHuAz9mYt6AbYYzqEVrhPjH00adyYcHGQa04YHXYLYECKs707
        mWrgT432EEIQCMYo7fziXbSvHNbsVa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-asbEdHcYM4K4ceBLiPHPCA-1; Mon, 13 Dec 2021 03:16:48 -0500
X-MC-Unique: asbEdHcYM4K4ceBLiPHPCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16627101F000;
        Mon, 13 Dec 2021 08:16:46 +0000 (UTC)
Received: from localhost (ovpn-12-202.pek2.redhat.com [10.72.12.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 511EA18032;
        Mon, 13 Dec 2021 08:16:43 +0000 (UTC)
Date:   Mon, 13 Dec 2021 16:16:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, robin.murphy@arm.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, m.szyprowski@samsung.com,
        John.p.donnelly@oracle.com, kexec@lists.infradead.org
Subject: Re: [PATCH RESEND v2 2/5] dma-pool: allow user to disable atomic pool
Message-ID: <20211213081641.GB29905@MiWiFi-R3L-srv>
References: <20211207030750.30824-1-bhe@redhat.com>
 <20211207030750.30824-3-bhe@redhat.com>
 <20211213074404.GA20758@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213074404.GA20758@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 at 08:44am, Christoph Hellwig wrote:
> On Tue, Dec 07, 2021 at 11:07:47AM +0800, Baoquan He wrote:
> > In the current code, three atomic memory pools are always created,
> > atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
> > specified in kernel command line. In fact, atomic pool is only
> > necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
> > which are needed on few ARCHes.
> 
> And only these select the atomic pool, so it won't get created otherwise.
> What problem are you trying to solve?

This tries to make "coherent_pool=0" behave normally. As you see,
'coherent_pool=0' will behave like no 'coherent_pool' being specified.
This is not consistent with other similar kernel parameter, e.g cma=.

At the beginning, I planned to add a knob to allow user to disable one
or all atomic pool. Later I changed. However I think this patch makes
sense on fixing the a little bizarre behaviour, 'coherent_pool=0' but
still get atomic pool created.

I can drop it if you think it's unnecessary.

