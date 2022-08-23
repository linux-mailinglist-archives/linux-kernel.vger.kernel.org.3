Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180D259E6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244393AbiHWQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbiHWQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFA3AE55
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661257970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFZpUrH9edUOuu2AArKyngbcz1gI3F8tDFjZRMkRQFs=;
        b=Ui+eZfqHhvNr5Nv3x+b5NMJVXJCILL/clpbEKfGwsdFqA6TiPc5zWbyvMK/4DJsR177nyz
        Rc1KAEiwygrI8mUk6lRCtZiq06lFa5FUlS/pn1m1IRlzq1uqp0YYKQxUuY6pmyByXebRnR
        qy+kSNpYyDMQoByBtrKwN4INyS3GuOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-cQTcaUiDMyaszofSEUWFVQ-1; Tue, 23 Aug 2022 08:32:47 -0400
X-MC-Unique: cQTcaUiDMyaszofSEUWFVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C03918E5341;
        Tue, 23 Aug 2022 12:32:47 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F022940C141D;
        Tue, 23 Aug 2022 12:32:45 +0000 (UTC)
Date:   Tue, 23 Aug 2022 20:32:42 +0800
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
Message-ID: <YwTI6jAjY68QK5h6@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
 <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
 <YwQrC3X3PHa0pNDy@MiWiFi-R3L-srv>
 <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b7afcc-056d-7f33-6858-d451a3222c70@csgroup.eu>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/22 at 05:33am, Christophe Leroy wrote:
> 
> 
> Le 23/08/2022 à 03:19, Baoquan He a écrit :
> > On 08/22/22 at 06:30am, Christophe Leroy wrote:
> >>
> >>
> >> Le 20/08/2022 à 02:31, Baoquan He a écrit :
> >>> On some architectures, the physical address need be fixed up before
> >>> doing mapping, e.g, parisc. And on architectures, e.g arc, the
> >>> parameter 'prot' passed into ioremap_prot() need be adjusted too.
> >>>
> >>> In oder to convert them to take GENERIC_IOREMAP method, we need wrap
> >>> the address fixing up code and page prot adjusting code into arch_ioremap()
> >>> and pass the new address and 'prot' out for ioremap_prot() handling.
> >>
> >> Is it really the best approach ? Wouldn't it be better to have helpers
> >> to do that, those helpers being called by the ioremap_prot(), instead of
> >> doing it inside the arch_ioremap() function ?
> > 
> > This is suggested too by Alexander during his v1 reviewing. I tried, but
> > feel the current way taken in this patchset is better. Because not all
> > architecutres need the address fix up, only parisc, and only few need
> > adjust the 'prot'. Introducing other helpers seems too much, that only
> > increases the complexity of of ioremap() and the generic GENERIC_IOREMAP
> > method for people to understand and take.
> 
> I can't understand. Why is it difficult to do something like:
> 
> #ifndef ioremap_adjust_prot
> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> {
> 	return flags;
> }
> #endif
> 
> Then for arc you do
> 
> static inline unsigned long ioremap_adjust_prot(unsigned long flags)
> {
> 	return pgprot_val(pgprot_noncached(__pgprot(flags)));
> }
> #define ioremap_adjust_prot ioremap_adjust_prot

My thinking is we have four things to do in the added hookers.
1) check if we should do ioremap on ARCHes. If not, return NULL from
ioremap_prot();
2) handling the mapping io address specifically on ARCHes, e.g arc,
ia64, s390;
3) the original physical address passed into ioremap_prot() need be
fixed up, e.g arc;
4) the 'prot' passed into ioremap_prot() need be adjusted, e.g on arc
and xtensa.

With Kefeng's patches, the case 1) is handled with introduced
ioremap_allowed()/iounmap_allowed(). In this patchset, what I do is
rename the hooks as arch_ioremap() and arch_iounmap(), then put case 1),
2), 3), 4) handling into arch_ioremap(). Adding helpers to cover each
case is not difficult from my side. I worry that as time goes by, those
several hooks my cause issue, e.g if a new adjustment need be done,
should we introduce a new helper or make do with the existed hook; how 

When I investigated this, one arch_ioremap() looks not complicated 
since not all ARCHes need cover all above 4 cases. That's why I finally
choose one hook. I am open to new idea, please let me know if we should
change it to introduce several different helpers.

> 
> 
> By the way, could be a good opportunity to change ioremap_prot() flags 
> type from unsigned long to pgprot_t

Tend to agree, I will give it a shot.

