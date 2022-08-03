Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417DC588C85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiHCM4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiHCM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:56:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E62DC5
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:56:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C7304D53C;
        Wed,  3 Aug 2022 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659531405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBjG8dobIZkku1CWQkR/K9igC2Gpo0t0c8G7EPf8X8M=;
        b=V0weYV7JGTmeNz+1PQTWXbPhLVwOzwSmgj9cw1QTp/LuCKl9ek5J9/LRFtGh9pnj+bQ71I
        Ilq0+Q22P68fXmKnVfhFuIdP9FFoh2S9uN6V/dYZVEVrtBGmtOQLdsP/xh6eU8IQngbLcY
        6E2U8fvdpFgvtryeHmh98daEEwklPsY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF84813AD8;
        Wed,  3 Aug 2022 12:56:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xiMdOIxw6mKNbgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 03 Aug 2022 12:56:44 +0000
Date:   Wed, 3 Aug 2022 14:56:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YupwjN6K6e6V3y+Q@dhcp22.suse.cz>
References: <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
 <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
 <Yurd2iYp4XMIYM7T@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yurd2iYp4XMIYM7T@feng-clx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-08-22 04:43:06, Feng Tang wrote:
> On Wed, Aug 03, 2022 at 07:28:59PM +0800, Michal Hocko wrote:
[...]
> > +struct mempolicy *policy_mbind_nodemask(gfp_t gfp)
> > +{
> > +#ifdef CONFIG_MEMPOLICY
> > +	struct mempolicy *mpol = get_task_policy(current);
> > +
> > +	/*
> > +	 * only enforce MBIND which overlaps with cpuset policy (from policy_nodemask)
> > +	 * specifically for hugetlb case
> > +	 */
> > +	if (mpol->mode == MPOL_BIND &&
> > +		(apply_policy_zone(mpol, gfp_zone(gfp)) &&
> > +		 cpuset_nodemask_valid_mems_allowed(&policy->nodes))
> > +		return &mpol->nodes;
> > +#endif
> > +	return NULL;
> 
> I saw the logic is not changed, and it confused me that if there is
> no qualified node, it will still return NULL which effectively equals
> node_states[N_MEMORY], while I think it should return a all zero
> nodemasks.

This is a separate thing and I have to admit that the existing code is
rather non-intuitive or even broken. I guess we do not care all that
much because MBIND with completely non-overlapping cpusets is just a
broken configuration. I am not sure this case is interesting or even
supported.

-- 
Michal Hocko
SUSE Labs
