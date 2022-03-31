Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0204ED4FC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiCaHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiCaHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:48:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46C1D97C4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:46:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F318121900;
        Thu, 31 Mar 2022 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648712814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MClpEQCEqNuvlVug+pSR2PKBVfdIgjYBgqwIpn2O7Gg=;
        b=EiSTzvcBcwyt5d21/dSJyyFfU8OvvcT2KgT0DDTSOTwqTFtPB+VgnitdY9jIyVhlxRCI/d
        AjKiThObJcEEVZ+GMmERBez8Z0qd3Dpkk5E71Z/UOTV+ZekG/Qm4Sl9Gz+agwV55lcHM37
        bKv4SA1mfRBLGqhkjuf7XJwdK1aZ9KY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 52242A3B82;
        Thu, 31 Mar 2022 07:46:48 +0000 (UTC)
Date:   Thu, 31 Mar 2022 09:46:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in
 memcg_reparent_list_lru_node()
Message-ID: <YkVcbElWjomA7ofF@dhcp22.suse.cz>
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
 <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev>
 <20220331063956.5uqnab64cqnmcwyr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331063956.5uqnab64cqnmcwyr@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-03-22 06:39:56, Shakeel Butt wrote:
> On Wed, Mar 30, 2022 at 07:48:45PM -0700, Roman Gushchin wrote:
> > 
> > 
> [...]
> > 
> > 
> > But honestly, I’d drop the original optimization together with
> > the fix, if only there is no _real world_ data on the problem and
> > the improvement. It seems like it has started as a nice simple
> > improvement, but the race makes it complex and probably not worth
> > the added complexity and fragility.
> 
> I agree with dropping the original optimization as it is not really
> fixing an observed issue which may justify adding some complexity.

Completely agreed. The patch as it is proposed is not really acceptable
IMHO and I have to say I am worried that this is not the first time we
are in a situation when a follow up fixes or unrelated patches are
growing in complexity to fit on top of a performance optimizations which
do not refer to any actual numbers.
-- 
Michal Hocko
SUSE Labs
