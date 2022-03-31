Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1D4ED9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiCaMaB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 08:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiCaM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:29:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C81921044E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:28:10 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nZtuJ-0000oT-6f; Thu, 31 Mar 2022 14:28:07 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com,
        philipp.tomsich@vrull.eu, Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v8 01/14] riscv: prevent null-pointer dereference with sbi_remote_fence_i
Date:   Thu, 31 Mar 2022 14:28:06 +0200
Message-ID: <2260961.n0HT0TaD9V@diego>
In-Reply-To: <20220331095155.GA23422@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-2-heiko@sntech.de> <20220331095155.GA23422@lst.de>
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

Hi,

Am Donnerstag, 31. März 2022, 11:51:55 CEST schrieb Christoph Hellwig:
> On Thu, Mar 24, 2022 at 01:06:57AM +0100, Heiko Stuebner wrote:
> > The callback used inside sbi_remote_fence_i is set at sbi probe time
> > to the needed variant. Before that it is a NULL pointer.
> > 
> > Some users like the flush_icache_*() functions suggest a generic
> > functionality, that doesn't depend on a specific boot-stage but
> > uses sbi_remote_fence_i as one option to flush other cpu cores.
> > 
> > So they definitely shouldn't run into null-pointer dereference
> > issues when called "too early" during boot.
> > 
> > So introduce an empty function to be the standard for the __sbi_rfence
> > function pointer until sbi_init has run.
> > 
> > Users of sbi_remote_fence_i will have separate code for the local
> > cpu and sbi_init() is called before other cpus are brought up.
> > So there are no other cpus present at the time when the issue
> > might happen.
> 
> I don't really understand this changelog.  If flush_icache_* or
> other routines using SBI calls are called too early they won't
> do what they are asked to do, which implies a bug in the code.
> 
> So crashing absolutely is the right thing to do here as we don't
> really have any other error reporting method available.
> 
> So unless I'm totally misunderstanding what you are saying here:
> 
> Nacked-by: Christoph Hellwig <hch@lst.de>

The function is defined as

void flush_icache_all(void)
{
	local_flush_icache_all();

	if (IS_ENABLED(CONFIG_RISCV_SBI))
		sbi_remote_fence_i(NULL);
	else
		on_each_cpu(ipi_remote_fence_i, NULL, 1);
}

so essentially flushes the _local_ icache first and then tries to flush
caches on other cores, either via an ipi or via sbi.

The remote-fence callback is set correctly during sbi_init().
The other cores are only brought up after sbi-init is done.

So it's not really about error reporting but making sure that flush_icache_all()
does something sane even when still running on the first core.
As I assume the "all" means on all available cores (which would be the
core the system booted on).

Does this make it clearer what this tries to solve?
Heiko


