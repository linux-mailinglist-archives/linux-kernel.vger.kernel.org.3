Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC565A9068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiIAHg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiIAHg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E3DEA170
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662017815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=esLxAvr9853Thi1a9GlfKlpRrKA5zTCBjO5Czht1ha8=;
        b=OV0rT22UZNT7a4aRGyeZ0l9ey0Pp3EWcXuNm4AyC8vkwE95SJDn2RpFMcQhBU7+brqps7A
        e24cTK8OQ//h3XlZtpcBsJ9osICSeHGnLv6uzvFsX7CGUx3pz+/8uAqICBBOsCmZyBGogs
        jgcc8VubCol/zGlkHOK8ojwKkJwTtTg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-HY9lTAENOau_a90uJaIBJA-1; Thu, 01 Sep 2022 03:36:49 -0400
X-MC-Unique: HY9lTAENOau_a90uJaIBJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BC8B811E81;
        Thu,  1 Sep 2022 07:36:48 +0000 (UTC)
Received: from localhost (ovpn-12-182.pek2.redhat.com [10.72.12.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4952740C141D;
        Thu,  1 Sep 2022 07:36:46 +0000 (UTC)
Date:   Thu, 1 Sep 2022 15:36:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 10/11] sh: mm: Convert to GENERIC_IOREMAP
Message-ID: <YxBhC4UoznAwznoO@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-11-bhe@redhat.com>
 <YwHZgE2RlMaBBhEl@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHZgE2RlMaBBhEl@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/22 at 12:06am, Christoph Hellwig wrote:
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> > +#define arch_ioremap arch_ioremap
> 
> Shouldn't this still be under CONFIG_MMU?

Yeah, you are right, will put them under CONFIG_MMU.

I thought making GENERIC_IOREMAP depend MMU in Kconfig will contain
that. But people can manually set the Kconfig item freely. Thanks for
pointing it out.

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..b63ad4698cf8 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -25,6 +25,7 @@ config SUPERH
        select GENERIC_SCHED_CLOCK
        select GENERIC_SMP_IDLE_THREAD
        select GUP_GET_PTE_LOW_HIGH if X2TLB
+       select GENERIC_IOREMAP if MMU

> 

