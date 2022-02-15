Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB84B63ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiBOHFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:05:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiBOHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:05:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E8171C80;
        Mon, 14 Feb 2022 23:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MhVjaD6fKKFUY3syRqRUXpYiG3rg2FDHC/gPL4/YajA=; b=vWKYZDkh2ThhdOCMRvpK9z90I4
        lcJmP7/B4jG3SY1wyw3GDvh04rdqqWYt7chLNi3fHbvH3E5nOBuB2aNaPPRuDtZEs7hDrWg40Yxf8
        IzGHL0rdLvnDbQkqFscF+TxSyHN6rb7yfCsaXjWZiLhSxxufr8p9XvOwak3b/p+SE7w/kTmEC9IC+
        U1pEc/Oko7RjsKNEnnp6BNBFMMNChUoDENX7BKF1JQfcZm4FHYlNWiT/iXQlqVZIn+2mdFI65CGYL
        unwY/xFFEAT5x/U8kcDanVdXcv7+aZ2p9gV5i//GgKmgRcY7ws+6Af+J2cbZdpgrA0w12LyLBdSOs
        zrdT+lXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJrtK-000yjI-L4; Tue, 15 Feb 2022 07:04:50 +0000
Date:   Mon, 14 Feb 2022 23:04:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
Message-ID: <YgtQkjRe7fbXI/lS@infradead.org>
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> ===================================================================
> --- linux-macro.orig/arch/arm64/include/asm/Kbuild
> +++ linux-macro/arch/arm64/include/asm/Kbuild
> @@ -3,6 +3,7 @@ generic-y += early_ioremap.h
>  generic-y += mcs_spinlock.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
> +generic-y += parport.h

Instead of adding generic-y just ad a mandatory-y in
include/asm-generic/Kbuild.
