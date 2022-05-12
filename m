Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEA1524CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353740AbiELMan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353746AbiELMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:30:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D521F218
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:30:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 69A631F460;
        Thu, 12 May 2022 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652358628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DoM2S+8jiCWaZnDZKbaWw6MEK0h9xXTciJ7KPHK3e+g=;
        b=xhG1swfamE+GSab+AKwK+gq3d6fYDdraOp9xCEgGeH0/FKxebsRYhxbKZ5dNqJDfJanrFY
        y7Gb28crUwl+XNY3MrXYuoRO3rbMP/Yk7imczzF63gGsXF9SZkCY4NWG7fNq9dmThnUd42
        qyjgSkuyhZTFtB0jzCrYQbvI5qaj8HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652358628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DoM2S+8jiCWaZnDZKbaWw6MEK0h9xXTciJ7KPHK3e+g=;
        b=NNn8/t8R75BS2bAgRQcNY47L651YbitkKtJ4dfgyxMyCtAsjRvbb8GkWQ1oMr8DyGGcBzh
        1Se+nA5Uo/2NgwAw==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 03BE22C141;
        Thu, 12 May 2022 12:30:25 +0000 (UTC)
Date:   Thu, 12 May 2022 13:30:21 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Wonhyuk Yang <vvghjk1234@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baik Song An <bsahn@etri.re.kr>,
        Hong Yeon Kim <kimhy@etri.re.kr>,
        Taeung Song <taeung@reallinux.co.kr>, linuxgeek@linuxgeek.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [Patch v2] [PATCH] mm/page_alloc: Fix tracepoint
 mm_page_alloc_zone_locked()
Message-ID: <20220512123021.GP20579@suse.de>
References: <20220512025307.57924-1-vvghjk1234@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220512025307.57924-1-vvghjk1234@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 11:53:07AM +0900, Wonhyuk Yang wrote:
> Currently, trace point mm_page_alloc_zone_locked() doesn't show
> correct information.
> 
> First, when alloc_flag has ALLOC_HARDER/ALLOC_CMA, page can
> be allocated from MIGRATE_HIGHATOMIC/MIGRATE_CMA. Nevertheless,
> tracepoint use requested migration type not MIGRATE_HIGHATOMIC and
> MIGRATE_CMA.
> 
> Second, after Commit 44042b4498728 ("mm/page_alloc: allow high-order
> pages to be stored on the per-cpu lists") percpu-list can store
> high order pages. But trace point determine whether it is a refiil
> of percpu-list by comparing requested order and 0.
> 
> To handle these problems, make mm_page_alloc_zone_locked() only be
> called by __rmqueue_smallest with correct migration type. With a
> new argument called percpu_refill, it can show roughly whether it
> is a refill of percpu-list.
> 
> Cc: Baik Song An <bsahn@etri.re.kr>
> Cc: Hong Yeon Kim <kimhy@etri.re.kr>
> Cc: Taeung Song <taeung@reallinux.co.kr>
> Cc: linuxgeek@linuxgeek.io
> Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
