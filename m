Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1C59CC91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbiHVXzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiHVXzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B60B56B8A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661212532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96UuXTm67Lu9/orI0Lgpr5EQeDdGY9QYj2tu9iaXGWY=;
        b=ZE2THHX11YENUI4ukbJkojtT2ZGpnNw+vJzDFM6nCpP7bmx9KKwCsw5mBRRQNnsyrZeo7y
        ARp+LU4Omo9/3PtUBZU3VMu/tcz2fFY6LH6WFIJ3o3acj0nos4OyTqOKI/0YxkKFb69Xfc
        BuqowRAdutnFgoFkktj4khNeVRBExHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-2nYVoJ_GNMSeaEkDB4toXA-1; Mon, 22 Aug 2022 19:55:31 -0400
X-MC-Unique: 2nYVoJ_GNMSeaEkDB4toXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBAEB801585;
        Mon, 22 Aug 2022 23:55:30 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC2091121315;
        Mon, 22 Aug 2022 23:55:29 +0000 (UTC)
Date:   Tue, 23 Aug 2022 07:55:26 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] mm/ioremap: change the return value of
 io[re|un]map_allowed and rename
Message-ID: <YwQXbspuRgLH3Gxw@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <YwHWfa/97BJ5EAbe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHWfa/97BJ5EAbe@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/22 at 11:53pm, Christoph Hellwig wrote:
> On Sat, Aug 20, 2022 at 08:31:15AM +0800, Baoquan He wrote:
> > +void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot);
> 
> Please avoid the overly long lines.

Thanks for reviewing. Will break the line.

> 
> I also wonder if we just want a common definition with a __weak default
> instead of duplicating it in many arch headers.

Seems __weak symbol is not suggested any more in kernel. Please see
below thread.

[PATCH] kexec_file: Drop weak attribute from arch_kexec_apply_relocations[_add]
https://lore.kernel.org/all/20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com/T/#u

> 
> > +	ioaddr = arch_ioremap(phys_addr, size, prot);
> > +	if (IS_ERR(ioaddr))
> > +		return NULL;
> > +	else if (ioaddr)
> > +		return ioaddr;
> 
> No need for the else here.

Do you mean changing it like this? It's fine to me if I get it
correctly.

	ioaddr = arch_ioremap(phys_addr, size, prot);
	if (IS_ERR(ioaddr))
		return NULL;
	if (ioaddr)
		return ioaddr;

Thanks
Baoquan

