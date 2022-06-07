Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8114453F7AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiFGHxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237996AbiFGHxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E84375799B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654588400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kIeoNALdguR3aN7GKFEd9K9npyp4og2Qegkqr3lDxJQ=;
        b=Ya1jsPoWKA1hNsjlyikiBLTgftNRn5qSlkvz2+jsWq78B61SiCkEi7v5Epphx9Y4pC9/ax
        f75Gdc1PcvflWUwH3GJfdfWa4d7AmxescOWBCVSkPdckSp+Cea1gs0OippiMSG/II7uELk
        aXWqJ1AcsO7Q3cCBggrQsw1GBfnV5QU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-nAeEfYI2Mluw13Zq_E6HMQ-1; Tue, 07 Jun 2022 03:53:15 -0400
X-MC-Unique: nAeEfYI2Mluw13Zq_E6HMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A56A73C0CD44;
        Tue,  7 Jun 2022 07:53:14 +0000 (UTC)
Received: from localhost (ovpn-13-113.pek2.redhat.com [10.72.13.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6B47405D4BF;
        Tue,  7 Jun 2022 07:53:13 +0000 (UTC)
Date:   Tue, 7 Jun 2022 15:53:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     akpm@linux-foundation.org, npiggin@gmail.com, urezki@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] mm: ioremap: rename ioremap_page_range() to
 ioremap_range()
Message-ID: <Yp8D5o0swyqETiDS@MiWiFi-R3L-srv>
References: <20220606083909.363350-1-bhe@redhat.com>
 <20220606083909.363350-6-bhe@redhat.com>
 <Yp7h0Jv6vpgt6xdZ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7h0Jv6vpgt6xdZ@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/22 at 10:27pm, Christoph Hellwig wrote:
> On Mon, Jun 06, 2022 at 04:39:09PM +0800, Baoquan He wrote:
> > Because the current ioremap_page_range() only maps IO address to kernel
> > virtual address, no struct page pointer passed in or page handling related.
> > So rename it here.
> > 
> > The renaming is done with below command:
> > sed -i "s/ioremap_page_range/ioremap_range/g" `git grep -l ioremap_page_range`
> 
> This creates a lot of churn without much of a benefit.  If you want
> to get rid of the name please convert most architectures to the
> generioc ioremap code first so that all these callers go away..

Thanks for checking.

Yeah, I didn't manually adjust those indentation after replacing via
command. While the name of ioremap_page_range() is misleading, relative
to its implementation.

Converting to use generic ioremap code on most of architectures sounds
like a good idea, just like what the arm/arm64 converting patchset is
doing. From a quick look, not all places can take the converting, and
there's one in pci_remap_iospace() under drivers. So what I need to do
is to:

1)take back this pach;
2)convert as many architectures to the generic ioremap code as possible;
3)rename the left places of ioremap_page_range() to ioremap_range().

Please check if this is what you are suggesting.

Thanks
Baoquan

