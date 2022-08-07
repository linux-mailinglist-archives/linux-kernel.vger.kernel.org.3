Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C705458B8F3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbiHGBvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiHGBvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E10649FFF
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659837108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSbJjMZU6xQdgnfP8jyChOBFjaT2MZzAgj08eMIJw8M=;
        b=T9yVSsMqFgL6yLz22AA96P5NbZUkEZjKpuBPURroG6SlE80MYmgoT0lHiFDsD+p+CXj/Bx
        itM60auQg11pbWq21o2mlmwqsRM8pUuN63PnZDKcuF2vkwj8Zh0OQY8ryNFJ+uQV4LR7B9
        oe6lIDHEDe45RG6jR2agJSAuYCH/ExE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-DiusD6ewNVul5VZbr8FxMA-1; Sat, 06 Aug 2022 21:51:45 -0400
X-MC-Unique: DiusD6ewNVul5VZbr8FxMA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17A0E801755;
        Sun,  7 Aug 2022 01:51:45 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AFA9492C3B;
        Sun,  7 Aug 2022 01:51:44 +0000 (UTC)
Date:   Sun, 7 Aug 2022 09:51:41 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed
Message-ID: <20220807015141.GB416711@MiWiFi-R3L-srv>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-2-bhe@redhat.com>
 <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <832b38ca-064e-0ab8-cd62-337d0d83d471@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <832b38ca-064e-0ab8-cd62-337d0d83d471@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/22 at 10:29am, Kefeng Wang wrote:
...snip...
> > > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > > index 72974cb81343..d72eb310fb3c 100644
> > > --- a/include/asm-generic/io.h
> > > +++ b/include/asm-generic/io.h
> > > @@ -967,26 +967,27 @@ static inline void iounmap(volatile void __iomem *addr)
> > >   /*
> > >    * Arch code can implement the following two hooks when using GENERIC_IOREMAP
> > >    * ioremap_allowed() return a bool,
> > > - *   - true means continue to remap
> > > - *   - false means skip remap and return directly
> > > + *   - IS_ERR means return an error
> > > + *   - NULL means continue to remap
> > > + *   - a non-NULL, non-IS_ERR pointer is returned directly
> > If ioremap_allowed() returns a valid pointer, then the function name
> > is not as precise anymore.
> 
> Maybe use arch_ioremap/unmap as before, or some better name.

Looks good to me. Or ioremap_check() which is a generic name, and
usually xxx_check() can hanlde many things.

