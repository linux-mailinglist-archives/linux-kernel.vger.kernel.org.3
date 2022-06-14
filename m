Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EC554B3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbiFNOtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiFNOt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:49:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29D1D0FF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+6etGlUiNvgn9hstecvBA3b8FX4JZnQNviSpWGSLA8U=; b=f9NsQX1z7j7m14FV2KxH9c0FDr
        qDMbpC879o4gHZs8o85N03DpHO7o39bGi+KBIoYXQue5h063UNfsHRqFo/gywomm/whKKLxyNWQ/6
        iuPkGmlz+bq/faRanpP/dxLDe8Op/CkOeWZsyBj1gl9oifNuaGU/kKVz0EqsGQ0UOki9vzoGYV7BD
        +dw7gTLjvV3qKROgz75qixYHs5Epd/YwOXan9PGnFC9rsl/6Mp1vJb2cW9qGM+x2wEjp9mUtZsNjt
        hMBCzCwVW2yP4XrUZJpTjmZn3vbuMFxR3Dr/OS2buw3KUAv+c8L1IauSvAC/81gPbaOQsS1Cw0alQ
        GbxQ7AXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o17r1-00A1me-IG; Tue, 14 Jun 2022 14:49:15 +0000
Date:   Tue, 14 Jun 2022 07:49:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Wang Wenhu <wenhu.wang@hotmail.com>, gregkh@linuxfoundation.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc:mm: export symbol ioremap_coherent
Message-ID: <Yqif65sCt9hUEjUf@infradead.org>
References: <20220609102855.272270-1-wenhu.wang@hotmail.com>
 <SG2PR01MB2951EBFD4C4EB2A2519FF4199FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
 <8735g7cym2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735g7cym2.fsf@mpe.ellerman.id.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 08:45:25PM +1000, Michael Ellerman wrote:
> Wang Wenhu <wenhu.wang@hotmail.com> writes:
> > The function ioremap_coherent may be called by modules such as
> > fsl_85xx_cache_sram. So export it for access in other modules.
> 
> ioremap_coherent() is powerpc specific, and only has one other caller,
> I'd like to remove it.
> 
> Does ioremap_cache() work for you?

Chances are that both are the wrong thing and this really wants
memremap, as SRAM tends to have memory and not MMIO semantics.
