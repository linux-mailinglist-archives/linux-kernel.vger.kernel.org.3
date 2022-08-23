Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5827A59CDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbiHWBTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237907AbiHWBTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0164D266
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 18:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661217555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CW2EFXmVRUt9BFAcUrpKBhy5C51otkLjmqsQzxzTVC0=;
        b=DVbU16sg3NgekwFIz2S2UUJZgha6Ez2T2wLpA3GlAWaof4VJ2HNvDO0sKFOL8tijIrnLSv
        t5VLyWBN+NK8sEiRYxcnUCG5gVvP1IZ7V6mli6ylmp209S3fraRyLF3bkwmzwA6d8qUII5
        IvajZ+nCCN23OKIVnob0P2l8M7/P4s4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-FAm2T8xXOvKveTwz3C7yew-1; Mon, 22 Aug 2022 21:19:14 -0400
X-MC-Unique: FAm2T8xXOvKveTwz3C7yew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83D9D3C01E12;
        Tue, 23 Aug 2022 01:19:13 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AD202026D4C;
        Tue, 23 Aug 2022 01:19:11 +0000 (UTC)
Date:   Tue, 23 Aug 2022 09:19:07 +0800
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
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Message-ID: <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
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

On 08/22/22 at 06:30am, Christophe Leroy wrote:
> 
> 
> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> > On some architectures, the physical address need be fixed up before
> > doing mapping, e.g, parisc. And on architectures, e.g arc, the
> > parameter 'prot' passed into ioremap_prot() need be adjusted too.
> > 
> > In oder to convert them to take GENERIC_IOREMAP method, we need wrap
> > the address fixing up code and page prot adjusting code into arch_ioremap()
> > and pass the new address and 'prot' out for ioremap_prot() handling.
> 
> Is it really the best approach ? Wouldn't it be better to have helpers 
> to do that, those helpers being called by the ioremap_prot(), instead of 
> doing it inside the arch_ioremap() function ?

This is suggested too by Alexander during his v1 reviewing. I tried, but
feel the current way taken in this patchset is better. Because not all
architecutres need the address fix up, only parisc, and only few need
adjust the 'prot'. Introducing other helpers seems too much, that only
increases the complexity of of ioremap() and the generic GENERIC_IOREMAP
method for people to understand and take.

> 
> > 
> > This is a preparation patch, no functionality change.
> 
> Could this be squashed into previous patch ?

Yep, will do. Thanks.

