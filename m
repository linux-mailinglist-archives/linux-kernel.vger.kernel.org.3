Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597E4589A87
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiHDKnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:43:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076DD2AC54
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:43:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BB1A20E9D;
        Thu,  4 Aug 2022 10:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659609804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSiyZjW9ioJq224VNQyTCMBHDlfySwyLJt96GrmgCyg=;
        b=FxG2vQ7yf3Oi1tC0pFA1LYxrYFEtt8SiG4ULKdm3WwjWEFblbaUJ5NCEakAdyCNSlVmbrR
        5prZAR8nwLG7LuOHsVFuel5efS1MLOknIpVTuTfuUOLhLuURsq9mLKRnbTZRgTiTh+sD5+
        p3M1KEzNE72vzbi2gU15LD3D/uM2Uwc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6503E13A94;
        Thu,  4 Aug 2022 10:43:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J95HB8Oi62L9FQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 04 Aug 2022 10:43:15 +0000
Date:   Thu, 4 Aug 2022 12:43:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YuuitMLOYqBcXMR3@dhcp22.suse.cz>
References: <YujoLQt09Js/sSQL@dhcp22.suse.cz>
 <YuoYkPk+YzdPNvmN@feng-snb>
 <YuolieBmdaIzoS3t@dhcp22.suse.cz>
 <Yuqs+BTpfh9/PjtP@feng-clx>
 <Yupb+1mmn9sQ/G8K@dhcp22.suse.cz>
 <Yurd2iYp4XMIYM7T@feng-clx>
 <YupwjN6K6e6V3y+Q@dhcp22.suse.cz>
 <Yurj0sOXgGf40AJE@feng-clx>
 <Yup2UimZJgbgFb3S@dhcp22.suse.cz>
 <YuuC7MBQ1bX3jA0j@feng-clx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuuC7MBQ1bX3jA0j@feng-clx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-08-22 16:27:24, Feng Tang wrote:
[...]
> >From a2db9a57da616bb3ea21e48a4a9ceb5c2cf4f7a2 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Thu, 4 Aug 2022 09:39:24 +0800
> Subject: [PATCH RFC] mm/hugetlb: add dedicated func to get 'allowed' nodemask for
>  current process
> 
> Muchun Song found that after MPOL_PREFERRED_MANY policy was introduced
> in commit b27abaccf8e8 ("mm/mempolicy: add MPOL_PREFERRED_MANY for multiple preferred nodes")
> [1], the policy_nodemask_current()'s semantics for this new policy
> has been changed, which returns 'preferred' nodes instead of 'allowed'
> nodes, and could hurt the usage of its caller in hugetlb:
> allowed_mems_nr().
> 
> Michal found the policy_nodemask_current() is only used by hugetlb,
> and suggested to move it to hugetlb code with more explicit name to
> enforce the 'allowed' semantics for which only MPOL_BIND policy
> matters.
> 
> One note for the new policy_mbind_nodemask() is, the cross check
> from MPOL_BIND, gfp flags and cpuset configuration can lead to
> a no available node case, which is considered to be broken
> configuration and 'NULL' (equals all nodes) is returned.
> 
> [1]. https://lore.kernel.org/lkml/20220801084207.39086-1-songmuchun@bytedance.com/t/
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

LGTM I would just make apply_policy_zone extern rather than making it
static inline in a header which can turn out to cause other header
dependencies.

Thanks!
-- 
Michal Hocko
SUSE Labs
