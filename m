Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8C57B046
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 07:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiGTFV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 01:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGTFVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 01:21:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349349B41;
        Tue, 19 Jul 2022 22:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=boLfVd9fuge8AsSo8Lqc9AK2r41spPeym0X+T4qNK8s=; b=OFEfSVymQy+fOVmh65guw0pXoC
        1eTebu4gM8/j24oy06KL6H8IgxRUBjauXyA3dsueRnULP35ZR247w20DMM19Wzor8n6H0GDtKaVUi
        BtnvjBQs/lq/lGwtFjIBmr1I/OKIbuzzMiSHLrKbNS0VnPV6aq/X3n8+B3wGPRMDME3KEbz2RCroV
        lHAU8uoHi+BG7o2rrhd+XsI5453DOyi4upJUj5wvemnXj5hfd1t5Q66mB3FDlv3zpbOj5LlAqVtQA
        pELv3+fQe6+VXFsFobeL6/C8/JBsDf8XrkOfCrZ04uZd/LXEnokYLgs2kgfXTo/DUf3iHioGd1bpU
        1YOUnQcg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oE29Z-000UlQ-Ro; Wed, 20 Jul 2022 05:21:45 +0000
Date:   Tue, 19 Jul 2022 22:21:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree - Remove a useless dma_supported() call
Message-ID: <YteQ6Vx2C03UtCkG@infradead.org>
References: <ef6f884ef144390f152c34d2f549b1f50303b7b1.1658262447.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6f884ef144390f152c34d2f549b1f50303b7b1.1658262447.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:27:50PM +0200, Christophe JAILLET wrote:
> There is no point in calling dma_supported() before calling
> dma_set_coherent_mask(). This function already calls dma_supported() and
> returns an error (-EIO) if it fails.
> 
> So remove the superfluous dma_supported() call.
> 
> While at it, fix the name of the function reported in a dev_err().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I guess that the whole while loop could be removed, but I don't remind the
> thread with the corresponding explanation, so leave it as-is :(

The loop should go away.  Setting a larger DMA mask will never fail when
setting a smaller one will succeed.

Also after this patch dma_supported can be marked static (Yay!)
