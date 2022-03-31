Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9724ED9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiCaMfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiCaMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:35:16 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2482602
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:33:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A77D068AFE; Thu, 31 Mar 2022 14:33:22 +0200 (CEST)
Date:   Thu, 31 Mar 2022 14:33:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
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
Subject: Re: [PATCH v8 01/14] riscv: prevent null-pointer dereference with
 sbi_remote_fence_i
Message-ID: <20220331123322.GA26378@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-2-heiko@sntech.de> <20220331095155.GA23422@lst.de> <2260961.n0HT0TaD9V@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2260961.n0HT0TaD9V@diego>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 02:28:06PM +0200, Heiko Stübner wrote:
> so essentially flushes the _local_ icache first and then tries to flush
> caches on other cores, either via an ipi or via sbi.
> 
> The remote-fence callback is set correctly during sbi_init().
> The other cores are only brought up after sbi-init is done.
> 
> So it's not really about error reporting but making sure that flush_icache_all()
> does something sane even when still running on the first core.
> As I assume the "all" means on all available cores (which would be the
> core the system booted on).
> 
> Does this make it clearer what this tries to solve?

A little.  Whatever code calls this early still seems broken to me
and just just do a local flush, though.

