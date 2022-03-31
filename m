Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045874ED752
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiCaJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCaJxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:53:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69752016BC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 02:52:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D117D68AA6; Thu, 31 Mar 2022 11:51:55 +0200 (CEST)
Date:   Thu, 31 Mar 2022 11:51:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Stuebner <heiko@sntech.de>
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
Subject: Re: [PATCH v8 01/14] riscv: prevent null-pointer dereference with
 sbi_remote_fence_i
Message-ID: <20220331095155.GA23422@lst.de>
References: <20220324000710.575331-1-heiko@sntech.de> <20220324000710.575331-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324000710.575331-2-heiko@sntech.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 01:06:57AM +0100, Heiko Stuebner wrote:
> The callback used inside sbi_remote_fence_i is set at sbi probe time
> to the needed variant. Before that it is a NULL pointer.
> 
> Some users like the flush_icache_*() functions suggest a generic
> functionality, that doesn't depend on a specific boot-stage but
> uses sbi_remote_fence_i as one option to flush other cpu cores.
> 
> So they definitely shouldn't run into null-pointer dereference
> issues when called "too early" during boot.
> 
> So introduce an empty function to be the standard for the __sbi_rfence
> function pointer until sbi_init has run.
> 
> Users of sbi_remote_fence_i will have separate code for the local
> cpu and sbi_init() is called before other cpus are brought up.
> So there are no other cpus present at the time when the issue
> might happen.

I don't really understand this changelog.  If flush_icache_* or
other routines using SBI calls are called too early they won't
do what they are asked to do, which implies a bug in the code.

So crashing absolutely is the right thing to do here as we don't
really have any other error reporting method available.

So unless I'm totally misunderstanding what you are saying here:

Nacked-by: Christoph Hellwig <hch@lst.de>
