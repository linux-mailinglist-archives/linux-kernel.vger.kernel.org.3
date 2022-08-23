Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8C59E9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiHWRgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiHWRez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4B10FC3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661267678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rat9a6NaBolAbjqzAgthWD8czlnUo9KIJObHQLn33Ng=;
        b=SQViAM7ZK4uguTvw+MrPL+2ugZ9UJOCxTckuHi2QqMkReetxgqlE1hkuaGxw5KgmDWYSKI
        qOQML8HVcmWELYMXzmLHvD6o66bFdpmORCd6u3Ch5edGQiS0zRMi8gZq65/S4DDNOV1+e2
        +1lD5E2JpFHK5BkDTWzkNvyFpm1MrwQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-GZqrdkMkP2aOQSYs0DyTYw-1; Tue, 23 Aug 2022 11:14:35 -0400
X-MC-Unique: GZqrdkMkP2aOQSYs0DyTYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7D223C0D85C;
        Tue, 23 Aug 2022 15:14:34 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 009FC2026D4C;
        Tue, 23 Aug 2022 15:14:33 +0000 (UTC)
Date:   Tue, 23 Aug 2022 23:14:30 +0800
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
Message-ID: <YwTu1kzcIUxsTL4j@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-2-bhe@redhat.com>
 <d5272f42-f3e3-b2a8-428e-bd7815cf7518@csgroup.eu>
 <YwQdRg/IS0+3tbNu@MiWiFi-R3L-srv>
 <a4a9ba6f-9891-cc4c-e512-d221141d998f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4a9ba6f-9891-cc4c-e512-d221141d998f@csgroup.eu>
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

On 08/23/22 at 05:24am, Christophe Leroy wrote:
> 
> 
> Le 23/08/2022 à 02:20, Baoquan He a écrit :
> > On 08/22/22 at 06:25am, Christophe Leroy wrote:
> >>
> >>
> >> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> >>> In some architectures, there are ARCH specifici io address mapping
> >>> handling when calling ioremap() or ioremap_prot(), e.g, arc, ia64,
> >>> openrisc, s390, sh.
> >>>
> >>> In oder to convert them to take GENERIC_IOREMAP method, we need change
> >>> the return value of hook ioremap_allowed() and iounmap_allowed().
> >>> Meanwhile, rename them to arch_ioremap() and arch_iounmap() to reflect
> >>> their current behaviour.
> > 
> > Thanks for reviewing.
> > 
> >>
> >> Please don't just say you need to change the return value. Explain why.
> > 
> > The 1st paragraph and the sentence 'In oder to convert them to take
> > GENERIC_IOREMAP method' tell the reason, no?
> 
> What I would like to read is _why_ you need to change the return value 
> in order to convert to GENERIC_IOREMAP

I rephrase the log as below, it's OK to you? Or please help check and
tell what I need to improve to better explain the reason.

====
The current io[re|un]map_allowed() hooks are used to check if the
io[re|un]map() actions are qualified to proceed when taking
GENERIC_IOREMAP way to do ioremap()/iounmap(). Otherwise io[re|un]map()
will return NULL.

On some architectures like arc, ia64, openris, s390, sh, there are
ARCH specific io address mapping to translate the passed in physical
address to io address when calling ioremap(). In order to convert
these architectures to take GENERIC_IOREMAP way to ioremap(), we need
change the return value of hook ioremap_allowed() and iounmap_allowed().
With the change, we can move the architecture specific io address
mapping into ioremap_allowed() hook, and give the mapped io address
out to let ioremap_prot() return it. While at it, rename the hooks to
arch_ioremap() and arch_iounmap() to reflect their new behaviour.
====


> 
> > 
> > 
> >>
> >> And why does it need a name change ? The new name suggests that what was
> >> simply a check function becomes now a function doing the job. Is that
> >> the intention ?
> > 
> > Yes, it's not a simple checking any more. It could do io address mapping
> > inside arch_ioremap(), and could modify the passed in 'phys_addr' and
> > 'prot' in patch 2. The ioremap_allowed() isn't appropriate to reflect
> > those.
> 
> Fair enough, then all this needs to be explained in the commit message.

Sure. After we decide the hooks, I will update the log accordingly.

> 
> > 
> >>
> >>
> >>>
> >>> ===
> >>>    arch_ioremap() return a bool,
> >>
> >> It is not a bool. A bool is either true or false.
> > 
> > Thanks, I forgot to update this accordingly.
> > 
> >>
> >>>      - IS_ERR means return an error
> >>>      - NULL means continue to remap
> >>>      - a non-NULL, non-IS_ERR pointer is returned directly
> >>>    arch_iounmap() return a bool,
> >>
> >> Same here, not a bool either.
> > 
> > And this place.
> >>
> >>>      - 0 means continue to vunmap
> >>>      - error code means skip vunmap and return directly
> >>>
> >>> This is taken from Kefeng's below old patch. Christoph suggested the
> >>> return value because he foresaw the doablity of converting to take
> >>> GENERIC_IOREMAP on more architectures.
> >>>    - [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
> >>>    - https://lore.kernel.org/all/20220519082552.117736-5-wangkefeng.wang@huawei.com/T/#u
> >>>
> >>> While at it, the invocation of arch_ioremap() need be moved to the
> >>> beginning of ioremap_prot() because architectures like sh, openrisc,
> >>> ia64, need do the ARCH specific io address mapping on the original
> >>> physical address. And in the later patch, the address fix up code
> >>> in arch_ioremap() also need be done on the original addre on some
> >>> architectures.
> >>>
> >>> This is preparation for later patch, no functionality change.
> >>
> >> No functionnal change, really ?
> > 
> > You mean the new arch_ioremap() owning different definition or the
> > invocation of arch_ioremap() moved up is functional change? Now I am
> > not sure about the latter one, may need update my knowledge base.
> 
> Both indeed. I understand that this first step is not changing much to 
> the logic, but I think the simple fact to change the arguments and name 
> are some how a functionnal change.

OK, I thought the function interface change is not related to functional
change. I will remove the 'no functionality change' sentence to avoid
misleading. Thanks.

