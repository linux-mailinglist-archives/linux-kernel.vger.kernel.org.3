Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1D4CA7F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbiCBOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiCBOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:25:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5954FB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:25:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 755261F37E;
        Wed,  2 Mar 2022 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646231099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkitiNRAXPXA41Tw0EpxO8Dg4MOHGDvtJ7D54K0fJ0s=;
        b=tFUsNE5F9vD88aKepoWoMqpzIWRj3ldyArGelKorFa0ftNPzsB+GldHOCf4o6M72ZI/ZAv
        S6B4iWj6rtUWDJdU7hoaCOAe56qZ7jt+tFYsBoeTyLR4Hk8lN5NlobbnNEHONnogNRuRn3
        aemX0OnokuAMrX3aBo5s9/kwIPbT378=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 438E5A3B81;
        Wed,  2 Mar 2022 14:24:59 +0000 (UTC)
Date:   Wed, 2 Mar 2022 15:24:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jsavitz@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved
 robust futex
Message-ID: <Yh9+O/xqNLnV1jmA@dhcp22.suse.cz>
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
 <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
 <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
 <118fc685-c68d-614f-006a-7d5487302122@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118fc685-c68d-614f-006a-7d5487302122@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this has slipped through cracks.

On Mon 14-02-22 15:39:31, Nico Pache wrote:
[...]
> We've recently been discussing the following if statement in __oom_reap_task_mm:
> 	if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED))
> 
> Given the comment above it, and some of the upstream discussion the original
> RFC, we are struggling to see why this should be a `||` and not an `&&`. If we
> only want to reap anon memory and reaping shared memory can be dangerous is this
> statement incorrect?
> 
> We have a patch queued up to make this change, but wanted to get your opinion on
> why this was originally designed this way in case we are missing something.

I do not really see why this would be wrong. Private file backed
mappings can contain a reapable memory as well. I do not see how this
would solve the futex issue.
-- 
Michal Hocko
SUSE Labs
