Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6118509758
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384750AbiDUGU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352817AbiDUGU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1060BB1EA;
        Wed, 20 Apr 2022 23:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3nuk+6NoBdtVDU30B8xv3yTjDDxz6fvKeYkyapH1HZs=; b=psiolZ4R3tgOZls6GBGGYCul5O
        56m3V1k5y4gpLWtGhY0URNdsvFzp1TMrCSO99JgW8RJ4ZrdQLPoa+LLg4O8E6PTW8nkSKEVtIAnoS
        /rPHQxfhC5omIgTjnH2BknVlg/uf1k4jwFeFvXXZKlPapBFqJ97TgIKJ4EMysZ8oyzedVhyT894iq
        hed5II8AMlswdMCXRm2/M2laYlvwkkne3ib4oB1HMO5VFrwrxRJfRsurURtvOpHd/bOO1ric1/V6W
        GuutZa07pAvxIXcP1goyOHH6stzTodj01afEGItHe0qRxMnGaKwhoBw4DzGWDLnVDtf9h6UPVdW8F
        vDA1AWLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhQ8I-00BfFf-Fj; Thu, 21 Apr 2022 06:17:38 +0000
Date:   Wed, 20 Apr 2022 23:17:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v2 09/12] md/raid5: Keep a reference to last stripe_head
 for batch
Message-ID: <YmD3Ao1lLH3LakZx@infradead.org>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420195425.34911-10-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:54:22PM -0600, Logan Gunthorpe wrote:
> When batching, every stripe head has to find the previous stripe head to
> add to the batch list. This involves taking the hash lock which is
> highly contended during IO.
> 
> Instead of finding the previous stripe_head each time, store a
> reference to the previous stripe_head in a pointer so that it doesn't
> require taking the contended lock another time.
> 
> The reference to the previous stripe must be released before scheduling
> and waiting for work to get done. Otherwise, it can hold up
> raid5_activate_delayed() and deadlock.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
