Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE9352B607
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbiERJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiERJE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:04:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A513F13CA32
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jeoGfrVB7Bpv0u+w3Y874xRP67KrBby4lHXLwJR1flk=; b=yjEDfPLh9UkgcAuWDWFRi20RbP
        aaKhJK/0YM5ZgzJr3OBWCSlLbB174ui7Bjprt03Wj/L9XOnXfKoJuZ5IZdcNFc5hhqvnxorcnLq7l
        kEjsQjxGQYQK5Y6cXPRwFJqgp7e4vgtsK/TGvoTgrY76s8BMnQQKBQu2M5mMmqQKAPpXQe0KerAOj
        nCqgCEY1cBl1rcTW2ypvqNYye0a+8IhjBcS2cUQnu4TwG6UFs7NG1wSutjaC9ONRZDRRrLGiVKMdu
        VPBnjgqAz7gC0F1B4+BD1Etkp9/0W4ZI9UY1SUjXUISQoK9nLJhkYkuPdmC6vrQtLNgkFRdk8zTUR
        iZc5g1kA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrFbn-000jJx-Ce; Wed, 18 May 2022 09:04:43 +0000
Date:   Wed, 18 May 2022 02:04:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] smp: cross CPU call interface
Message-ID: <YoS2q9a1o123hIGi@infradead.org>
References: <20220517180326.997129-1-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517180326.997129-1-dqiao@redhat.com>
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

I still haven't seen any good rationale for this.  It causes massive
churn just to have more complicated interface (and thus more code)
than before.  What is the benefit?

I'm also not sure what is formal about this interface, or why it
should be formal.  IPIs should be rare, and we'd better off looking
for instances we can remove entirely.
