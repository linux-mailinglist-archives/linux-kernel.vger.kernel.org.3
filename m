Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08318538B00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbiEaFpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiEaFpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:45:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D11C82176
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 22:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aXbvOx8jAYGA02JcDd8YOIl9eUJrNMJMlFx/ii0oNuQ=; b=jJFyM7WWZHhGufuYtF8xFUisy4
        vf56HOF5FnN9fnDmojXdWNTJDth7FAXmzGt2ZiGNaebxZtsKq3FJVntJfqVWRRKQkATiVJXUzgsNt
        TRmcq8358eXvxv++E4cJfmApY8a1KpPcakKiyBqVlEXLH0IDXOP7tBudyAz2yhINjtNsNgYbl0qfr
        3/+ErzBdAiBtc/SOWGJMiGFMaSUTKubkXm/aw8PHn4MhoHCbPKgZFAgV25GQcdN7P2DNSzEIT1J2e
        SYg2x5pwtAG7swl35WlxOOauKeTZtVEfGvAVcp6PNysZlFnGgITuukX6WqeLQBUig4MtSku36IRWM
        XCGWwIMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvuhC-009Pcg-5Y; Tue, 31 May 2022 05:45:34 +0000
Date:   Mon, 30 May 2022 22:45:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in dma_map_sgtable (2)
Message-ID: <YpWrfnkipIzoWEcd@infradead.org>
References: <00000000000011e14605e03a125d@google.com>
 <20220530144542.4382-1-hdanton@sina.com>
 <20220530151044.GQ2146@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530151044.GQ2146@kadam>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Someohow only the reply from Dan got delivered to me, not the mail
from Hillf he is replying to, so I'm abusing that to reply to the
previous mail..

On Mon, May 30, 2022 at 06:10:44PM +0300, Dan Carpenter wrote:
> > --- y/drivers/dma-buf/udmabuf.c
> > +++ u/drivers/dma-buf/udmabuf.c
> > @@ -273,6 +273,14 @@ static long udmabuf_create(struct miscde
> >  	if (IS_ERR(buf)) {
> >  		ret = PTR_ERR(buf);
> >  		goto err;
> > +	} else {
> > +		struct device *dev = ubuf->device->this_device;
> > +
> > +		if (!dev->dma_mask) {
> > +			ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +			if (ret)
> > +				goto err;
> > +		}
> >  	}

This is compeltely broken.  If the underlying device is ot DMA capable and
we can't just set a random mask and still allow DMA mappings.
