Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768658A353
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 00:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240069AbiHDWhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 18:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240047AbiHDWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 18:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F45A25C64
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 15:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0F1614DA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 22:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A60C433D7;
        Thu,  4 Aug 2022 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659652638;
        bh=IiLFKcasXXCr0CUdK9gkYeioVvsa5PwqF04icaA/D+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=viG5SIdZHiNQGekOfLicfrZM/1C2/h5PaH2CKzkJNsnXyDUseGxBL48u/vDZ7eKLb
         FZ41llPmOt67YM9qDPY5Ucl5DV8CGoCenqs9sm8ejNwE2714hCBbCiTajfkE70THzq
         iegMsUFfbvJfVhFDKC8fZWvYtTjNbIFCakWVcpgM=
Date:   Thu, 4 Aug 2022 15:37:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Dave Hansen <hansen.dave@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: add dedicated func to get 'allowed'
 nodemask for current process
Message-Id: <20220804153717.eea592a171accd245a0cc7d8@linux-foundation.org>
In-Reply-To: <YuvLcBp34Ac6Pd7a@dhcp22.suse.cz>
References: <YuuitMLOYqBcXMR3@dhcp22.suse.cz>
        <20220804130342.63355-1-feng.tang@intel.com>
        <YuvLcBp34Ac6Pd7a@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2022 15:36:48 +0200 Michal Hocko <mhocko@suse.com> wrote:

> On Thu 04-08-22 21:03:42, Feng Tang wrote:
> > Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
> > in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> > [1], the policy_nodemask_current()'s semantics for this new policy
> > has been changed, which returns 'preferred' nodes instead of 'allowed'
> > nodes, and could hurt the usage of its caller in hugetlb:
> > allowed_mems_nr().
> 
> The acutal user visible effect description is missing here. AFAIU it
> would be this.
> 
> With the changed semantic of policy_nodemask_current a taks with
> MPOL_PREFERRED_MANY policy could fail to get its reservation even though
> it can fall back to other nodes (either defined by cpusets or all online
> nodes) for that reservation failing mmap calles unnecessarily early.
> 
> The fix is to not consider MPOL_PREFERRED_MANY for reservations at all
> because they, unlike MPOL_MBIND, do not pose any actual hard constrain.

And is this Fixes: b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY
for multiple preferred nodes")?
