Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0927595831
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbiHPK16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbiHPK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A1140399
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 365CC61029
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 08:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F213C433D7;
        Tue, 16 Aug 2022 08:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660638436;
        bh=nd7XrfWW5VTyg8CmThVCU5gCXi7zDbey5kxwNLdc4iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2CzO7q9yAZpDeAAYd+SubkFwrskEPUWhivezYekuhFXWRFLZ/LP/qsydSsdYeSj/
         FDra6jnB9tXexpEd2rue2hm3mBQvJoV3VwzOLVgeFO28G+12S0bsaaSFfo7UJ+jo0e
         SFhERawMb8Vb3E5wSnBJpl8zI6jax1Bfv0yJ3vCE=
Date:   Tue, 16 Aug 2022 09:15:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     mawupeng <mawupeng1@huawei.com>
Cc:     rppt@linux.vnet.ibm.com, hughd@google.com, aarcange@redhat.com,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        willy@infradead.org
Subject: Re: [PATCH stable 4.14,4.19 1/1] mm: Fix page counter mismatch in
 shmem_mfill_atomic_pte
Message-ID: <YvtEBv35OUEtDsAj@kroah.com>
References: <20220802013251.3022141-1-mawupeng1@huawei.com>
 <09129cd3-7363-3079-bd57-dde9c73684f1@huawei.com>
 <YvsruBZBP+KpEBdb@kroah.com>
 <b7468bcc-4b75-1190-5eae-9796d35b048c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7468bcc-4b75-1190-5eae-9796d35b048c@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:04:08PM +0800, mawupeng wrote:
> 
> 
> On 2022/8/16 13:31, Greg KH wrote:
> > On Tue, Aug 16, 2022 at 11:27:08AM +0800, mawupeng wrote:
> >> Cc Greg
> > 
> > Cc Greg for what?  I have no context here at all as to what you want me
> > to do..
> 
> We found a bug related to memory cgroup counter in stable 4.14/4.19.
> shmem_mfill_atomic_pte() wrongly called mem_cgroup_cancel_charge() in "success"
> path, it should mem_cgroup_uncharge() to dec memory counter instead.
> mem_cgroup_cancel_charge() should only be used if this transaction is
> unsuccessful and mem_cgroup_uncharge() is used to do this if this transaction
> succeed.
> 
> Commit 3fea5a499d57 ("mm: memcontrol: convert page cache to a new mem_cgroup_charge() API")
> in v5.8-rc1 change is charge/uncharge/cancel logic so don't have this
> problem.
> 
> This counter will underflow to negative maximum value and trigger oom to kill all
> process include sshd and leave system unaccessible.
> 
> The reason cc you is that we want to merge this bugfix into stable 4.14/4.19.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
