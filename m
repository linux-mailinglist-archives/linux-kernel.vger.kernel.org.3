Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64A34D9EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349600AbiCOP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349599AbiCOP2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:28:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD0950E06
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 08:27:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5BAEC1F397;
        Tue, 15 Mar 2022 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647358054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGKIFDA+teOKkrtKp4Xkol4kV67X0eZCC5YsrJbOYXE=;
        b=FLzXPnahQQRNoRgqVRipDoxwZzkFUF+LmeTEji/nuoW0TMtofZpWLtiWMYrBYRhni3kvNE
        5n9Y6GNVovBsjUCmVHwpR3jkYcvYzAjOSfnaZVLae88qr+5LXI4ecgdrhN8mcRDnZSjIR3
        VdYOKtIDP+ZwkBYfS12j4W778NR71Zo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0BB06A3B87;
        Tue, 15 Mar 2022 15:27:33 +0000 (UTC)
Date:   Tue, 15 Mar 2022 16:27:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com,
        mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix potential mpol_new leak in
 shared_policy_replace
Message-ID: <YjCwYpTbGzAj9kmg@dhcp22.suse.cz>
References: <20220311093624.39546-1-linmiaohe@huawei.com>
 <Yi9w7TCYbj+OLGXJ@dhcp22.suse.cz>
 <26577566-ae1e-801c-8c64-89c2c89a487d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26577566-ae1e-801c-8c64-89c2c89a487d@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-03-22 21:42:29, Miaohe Lin wrote:
> On 2022/3/15 0:44, Michal Hocko wrote:
> > On Fri 11-03-22 17:36:24, Miaohe Lin wrote:
> >> If mpol_new is allocated but not used in restart loop, mpol_new will be
> >> freed via mpol_put before returning to the caller. But refcnt is not
> >> initialized yet, so mpol_put could not do the right things and might
> >> leak the unused mpol_new.
> > 
> > The code is really hideous but is there really any bug there? AFAICS the
> > new policy is only allocated in if (n->end > end) branch and that one
> > will set the reference count on the retry. Or am I missing something?
> > 
> 
> Many thanks for your comment.
> IIUC, new policy is allocated via the below code:
> 
> shared_policy_replace:
> 	alloc_new:
> 		write_unlock(&sp->lock);
> 		ret = -ENOMEM;
> 		n_new = kmem_cache_alloc(sn_cache, GFP_KERNEL);
> 		if (!n_new)
> 			goto err_out;
> 		mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
> 		if (!mpol_new)
> 			goto err_out;
> 		goto restart;
> 
> And mpol_new' reference count will be set before used in n->end > end case. But
> if that is "not" the case, i.e. mpol_new is not inserted into the rb_tree, mpol_new
> will be freed via mpol_put before return:

One thing I have missed previously is that the lock is dropped during
the allocation so I guess the memory policy could have been changed
during that time. Is this possible? Have you explored this possibility?
Is this a theoretical problem or it can be triggered intentionally.

These details would be really interesting for the changelog so that we
can judge how important this would be.
-- 
Michal Hocko
SUSE Labs
