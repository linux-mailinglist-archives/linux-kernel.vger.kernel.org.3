Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACC59BE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 13:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbiHVLaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiHVLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 07:30:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607123334B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 04:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5PcSssONmYM3nGWZ6RybkrMzsWV43+5Lu+oPjbsK9zI=; b=Aed23r0BX7Hj140U9k0lKyJGR8
        Piw3zgTmPGsDamksZWnfXohz+mJqQOE8Faq0OpNVqaVGRnemNwYYe2HFgFEHn8KfF1Pg9ERojir1x
        7V7Tp8SJivsdTaTkWWupTE9k6QnGrFTZikAa7n5N3zptDcEgyq8yXin3HRPlC5pHeyiT3gQoAbVhm
        qkOhqJlZwlkYwv/RdH4F0fnune1YpcADQ5RwEVTBAFgqqd4GW8q2VzdMhlc00au8nclJHynTpzkDX
        iKkT1tTOFSHQ+WrIoFyZjEv/eAaEYtog9XIuIaTaeAUNCdjS0fYV6BsQ2Dv1zYH6O59I3zLjZKjhz
        DdyyUBzA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ5d7-008FXQ-Tk; Mon, 22 Aug 2022 11:30:05 +0000
Date:   Mon, 22 Aug 2022 04:30:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
Message-ID: <YwNovfuf3pDBh2Zk@infradead.org>
References: <20220819210112.7924-1-rdunlap@infradead.org>
 <87o7wdkkt4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7wdkkt4.fsf@mpe.ellerman.id.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 01:40:23PM +1000, Michael Ellerman wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> > drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> > This is an inline function on powerpc which references
> > cpu_smallcore_map.
> >
> > Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
> > Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")
> 
> That 2nd commit is not in mainline, only linux-next.
> 
> I don't mind merging this fix preemptively, but is that SHA stable?

I really do not think this has any business being exported at all.

kfd_queue_work is not something that should be done in a driver.
Something like this belongs into the workqueue core, not in an
underdocumented helper in a random driver.

Drm guys:  once again, please please work with the maintainers instead
of just making up random stuff in the drivers.
