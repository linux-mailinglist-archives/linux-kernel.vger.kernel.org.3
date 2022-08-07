Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3018858B8F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 03:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiHGB65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 21:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiHGB6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 21:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8009AE00A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659837533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZh/yM6kokaO6+gJeFFxN++jZ3rqj9aWovbwRZ1sZ8g=;
        b=NDP9PnPf084Yg7Xc7LWhI07L0NV5gjgHP2m4DgE96mm/s5J2YZjpDuDdEjHVvgdNA5DGCv
        asVkQ8TTIW1LT5EJa8gKXxUogQEWQ3qWCl5gQbFlGtwsLK27OQau0UulYg7vI63nkioh/T
        6IwoKqlptyo+auss3Y+fwvZ6uxqs2mU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-fRPzZ0wWMdqRwTlrV-o6AA-1; Sat, 06 Aug 2022 21:58:52 -0400
X-MC-Unique: fRPzZ0wWMdqRwTlrV-o6AA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFF6B2800486;
        Sun,  7 Aug 2022 01:58:51 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A39931415116;
        Sun,  7 Aug 2022 01:58:50 +0000 (UTC)
Date:   Sun, 7 Aug 2022 09:58:47 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed
Message-ID: <20220807015847.GC416711@MiWiFi-R3L-srv>
References: <20220801144029.57829-1-bhe@redhat.com>
 <20220801144029.57829-2-bhe@redhat.com>
 <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yuvo9jWGL6VWStDO@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/22 at 05:42pm, Alexander Gordeev wrote:
> On Mon, Aug 01, 2022 at 10:40:19PM +0800, Baoquan He wrote:
> 
> Hi Baoquan,
> 
> > --- a/arch/arm64/mm/ioremap.c
> > +++ b/arch/arm64/mm/ioremap.c
> > @@ -3,19 +3,20 @@
> >  #include <linux/mm.h>
> >  #include <linux/io.h>
> >  
> > -bool ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> > +void __iomem *ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
> >  {
> >  	unsigned long last_addr = phys_addr + size - 1;
> > +	int ret = -EINVAL;
> 
> If ret variable is really needed?

There are two places where -EINVAL need be returned. I can remove
variable ret, and return -EINVAL directly if there's concern.

Thanks again for looking into this series.

