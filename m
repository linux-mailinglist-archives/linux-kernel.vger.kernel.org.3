Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43895A3E34
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 17:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiH1PIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiH1PI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 11:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52B32B88
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661699305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8neMr6g7eV8otY6VIAU2DNTfHwU5LClkKQL29JabBA=;
        b=EgP09V2kGHWufGBeeExTy+cQOZV1m53bJR+lLCUT0O0pLUsSn8M+rhaAFLrgpouthTrGCO
        NN0bbkKsrTl/Y+Gyw1htctkJpk8ZAOyFUOloAbi9IO0EVqZ40dGVx3RdB1QFWxnuyFpdRc
        sYvV218I/NjR5meJz232XwveImjwkNo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-tS76eEUuM7ibrrU6cUhUgw-1; Sun, 28 Aug 2022 11:08:22 -0400
X-MC-Unique: tS76eEUuM7ibrrU6cUhUgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78D65101A54E;
        Sun, 28 Aug 2022 15:08:21 +0000 (UTC)
Received: from localhost (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B41D2166B26;
        Sun, 28 Aug 2022 15:08:20 +0000 (UTC)
Date:   Sun, 28 Aug 2022 23:08:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Message-ID: <YwuE4O/NnRADyrC+@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
 <YwHX98KBEnZw9t6e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwHX98KBEnZw9t6e@infradead.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/22 at 12:00am, Christoph Hellwig wrote:
> On Sat, Aug 20, 2022 at 08:31:19AM +0800, Baoquan He wrote:
> > With it, the old ioremap() and iounmap() can be perfectly removed
> > since they are duplicated with the standard functions.
> 
> Can you write a somewhat better commit message explaining that it
> switches to the generic code that has equivalent functionality?

OK, I will rephrase like below. Please check if it's OK.
==
By taking GENERIC_IOREMAP method, the generic ioremap_prot() and
iounmap() are visible and available to arch. Arch only needs to
provide implementation of arch_ioremap() or arch_iounmap() if there's
arch specific handling needed in its ioremap() or iounmap(). This
change will simplify implementation by removing duplicated codes with
generic ioremap() and iounma(), and has the equivalent functioality
as before.

> 
> > +#define ioremap_uc(addr, size) ioremap((addr), (size))
> 
> This is wrong and hexagon should use the asm-generic version of
> ioremap_uc that returns NULL.

I don't follow. Do you mean the function verion, but not a macro? Or
define it like below?

#define ioremap_uc(addr, size)  \
        ioremap_prot((addr), (size), _PAGE_IOREMAP)

