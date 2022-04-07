Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77144F8761
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243437AbiDGSxB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Apr 2022 14:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347003AbiDGSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:52:56 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79646A02E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:50:53 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ncXDQ-0007Iv-1o; Thu, 07 Apr 2022 20:50:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v8 01/14] riscv: prevent null-pointer dereference with sbi_remote_fence_i
Date:   Thu, 07 Apr 2022 20:50:42 +0200
Message-ID: <2627651.mvXUDI8C0e@diego>
In-Reply-To: <20220331123322.GA26378@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <2260961.n0HT0TaD9V@diego> <20220331123322.GA26378@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. März 2022, 14:33:22 CEST schrieb Christoph Hellwig:
> On Thu, Mar 31, 2022 at 02:28:06PM +0200, Heiko Stübner wrote:
> > so essentially flushes the _local_ icache first and then tries to flush
> > caches on other cores, either via an ipi or via sbi.
> > 
> > The remote-fence callback is set correctly during sbi_init().
> > The other cores are only brought up after sbi-init is done.
> > 
> > So it's not really about error reporting but making sure that flush_icache_all()
> > does something sane even when still running on the first core.
> > As I assume the "all" means on all available cores (which would be the
> > core the system booted on).
> > 
> > Does this make it clearer what this tries to solve?
> 
> A little.  Whatever code calls this early still seems broken to me
> and just just do a local flush, though.

Looking at this again made me realize that we don't need this patch
anymore at all.

In a previous revision the "main" alternatives apply-point was earlier,
triggering the issue when the generic patching-functions wanted to
flush the cache, but with the alternatives getting applied where they
are now, the issue is not triggered anymore.

And the "early" alternatives use a local flush anyway.


