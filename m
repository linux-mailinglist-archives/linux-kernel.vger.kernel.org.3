Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA56459CD23
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiHWAUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbiHWAUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:20:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E835F66
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661214030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ard+XQ2JmpaoV1Zy66Z597OHMvsCkwrAtFiswd3hAns=;
        b=idORdc7/R+z5TgUgrJLOQSZHbjDBs0IlV57TlOz5kbGopV596L06n5DC0X3MUWqUAOdjy4
        lDUBi0yAoJ7c0/DeqXlNIlerSRAamoBBheFSE6UCQ+UqnFenNNPTAWaOLf8WiHMYplQQ/J
        poqEBwfFY/Wo5g2pICUlLm8pmQ7hYiE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-POZqojPkPHyzqJX0OrHRVw-1; Mon, 22 Aug 2022 20:20:27 -0400
X-MC-Unique: POZqojPkPHyzqJX0OrHRVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EDC0B1C19762;
        Tue, 23 Aug 2022 00:20:26 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27F45401B54F;
        Tue, 23 Aug 2022 00:20:25 +0000 (UTC)
Date:   Tue, 23 Aug 2022 08:20:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Message-ID: <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/22 at 06:25am, Christophe Leroy wrote:
> 
> 
> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> > In some architectures, there are ARCH specifici io address mapping
> > handling when calling ioremap() or ioremap_prot(), e.g, arc, ia64,
> > openrisc, s390, sh.
> > 
> > In oder to convert them to take GENERIC_IOREMAP method, we need change
> > the return value of hook ioremap_allowed() and iounmap_allowed().
> > Meanwhile, rename them to arch_ioremap() and arch_iounmap() to reflect
> > their current behaviour.

Thanks for reviewing.

> 
> Please don't just say you need to change the return value. Explain why.

The 1st paragraph and the sentence 'In oder to convert them to take
GENERIC_IOREMAP method' tell the reason, no?


> 
> And why does it need a name change ? The new name suggests that what was 
> simply a check function becomes now a function doing the job. Is that 
> the intention ?

Yes, it's not a simple checking any more. It could do io address mapping
inside arch_ioremap(), and could modify the passed in 'phys_addr' and
'prot' in patch 2. The ioremap_allowed() isn't appropriate to reflect
those.

> 
> 
> > 
> > ===
> >   arch_ioremap() return a bool,
> 
> It is not a bool. A bool is either true or false.

Thanks, I forgot to update this accordingly.

> 
> >     - IS_ERR means return an error
> >     - NULL means continue to remap
> >     - a non-NULL, non-IS_ERR pointer is returned directly
> >   arch_iounmap() return a bool,
> 
> Same here, not a bool either.

And this place.
> 
> >     - 0 means continue to vunmap
> >     - error code means skip vunmap and return directly
> > 
> > This is taken from Kefeng's below old patch. Christoph suggested the
> > return value because he foresaw the doablity of converting to take
> > GENERIC_IOREMAP on more architectures.
> >   - [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
> >   - https://lore.kernel.org/all/20220519082552.117736-5-wangkefeng.wang@huawei.com/T/#u
> > 
> > While at it, the invocation of arch_ioremap() need be moved to the
> > beginning of ioremap_prot() because architectures like sh, openrisc,
> > ia64, need do the ARCH specific io address mapping on the original
> > physical address. And in the later patch, the address fix up code
> > in arch_ioremap() also need be done on the original addre on some
> > architectures.
> > 
> > This is preparation for later patch, no functionality change.
> 
> No functionnal change, really ?

You mean the new arch_ioremap() owning different definition or the
invocation of arch_ioremap() moved up is functional change? Now I am
not sure about the latter one, may need update my knowledge base.

Thanks
Baoquan

