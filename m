Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E25A79A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiHaI7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiHaI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120C29C91
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661936310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IW7RubSZwqNRNbVodwb3pZqFVO6G5hQjn6X5TjkRm1w=;
        b=iJ0cNaxdVg5/CnQLd6AxjtsVoRVAu+YmnB0dUGY0vfv/xCGH/y6QzvoGrvzPh2rPkBdDLR
        cdy8a2NuO/RSVbeNppePMzzFZyWYz2AOIZ/Zm88IDJHPoAPKjjopOIfSH25kFlr/FH0Cvg
        TFnXoQPXlTnRBIQ4MaNZUr8g8CwpCjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-AgF2O633Mp-aThUtOrfFtw-1; Wed, 31 Aug 2022 04:58:27 -0400
X-MC-Unique: AgF2O633Mp-aThUtOrfFtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8993A8517FB;
        Wed, 31 Aug 2022 08:58:23 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 509481454547;
        Wed, 31 Aug 2022 08:58:21 +0000 (UTC)
Date:   Wed, 31 Aug 2022 16:58:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Yw8iqqpIWiK+nycG@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-10-bhe@redhat.com>
 <3a797c5ccde91c7791b3bdd3d81391a8fb38f2c5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a797c5ccde91c7791b3bdd3d81391a8fb38f2c5.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/22 at 05:19pm, Niklas Schnelle wrote:
> On Sat, 2022-08-20 at 08:31 +0800, Baoquan He wrote:
> > Add hooks arch_ioremap() and arch_iounmap() for s390's special
> > operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> > converted to use ioremap_prot() from GENERIC_IOREMAP.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/Kconfig          |  1 +
> >  arch/s390/include/asm/io.h | 26 +++++++++++------
> >  arch/s390/pci/pci.c        | 60 +++++---------------------------------
> >  3 files changed, 26 insertions(+), 61 deletions(-)
> 
> Sorry I missed this mail until now and will still need a bit of time to
> review and test the code as this is indeed pretty special on s390. From
> a first glance this does look like a nice simplification.
> 
> Just out of curiosity, I wonder why get_maintainers.pl didn't add me
> nor Gerald for direct CC despite the bulk of the changes affecting
> arch/s390/pci/*.

I run below script again, it does print you and Gerald's name in the
list. It must be me who made mistake when copying maintainers' name into
Cc. Sorry about that.
./scripts/get_maintainer.pl 0009-s390-mm-Convert-to-GENERIC_IOREMAP.patch

> 
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> ---8<---
> 

