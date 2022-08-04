Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F3589A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiHDJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiHDJvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:51:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17A161D45
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:51:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5DFC120E1A;
        Thu,  4 Aug 2022 09:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659606713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nsJKgzrKUYTFEYR/s+B+vppfN7Ux9/9bNVvETvtuWg=;
        b=hyI0F/n5p9Bi3RL3QWCDGmshv/0uLUhUnZ7cvEM+R7dSv/6pMYOKN1iFqKx6gq3S1uy2tg
        DPDdx+MBHc8OId6wZ6XD497c2r96fyISJjmNok+CbjPrWy9tdqYcjsdcwGZMo2cj/ppEbD
        kRVLKxpGsTh0SZjJYNLcn54zvaKVbAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659606713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/nsJKgzrKUYTFEYR/s+B+vppfN7Ux9/9bNVvETvtuWg=;
        b=fRNXxYYns8TENO7k4Br5NTPs1e6oOrTKAGnOSf/6zHi5xmPJ0bO8QMSzhwm0cnxw+5HsYa
        VjJK2o8NBWkISIDQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2551A2C146;
        Thu,  4 Aug 2022 09:51:47 +0000 (UTC)
Date:   Thu, 4 Aug 2022 10:51:50 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Libo Chen <libo.chen@oracle.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        tim.c.chen@linux.intel.com, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Message-ID: <20220804095150.GG3493@suse.de>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com>
 <YufUj4klPKmKNj26@gmail.com>
 <82620137-5aa5-6cf1-f7aa-6a298e2f7856@oracle.com>
 <Yuo9Y4KvQQvvLC/r@gmail.com>
 <a9d666ae-0aa4-d79e-aac2-02573577b530@oracle.com>
 <YuuJcFkUVUfDvcYB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YuuJcFkUVUfDvcYB@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 10:55:12AM +0200, Ingo Molnar wrote:
> 
> * Libo Chen <libo.chen@oracle.com> wrote:
> 
> > Oh yes, I have no issue with holding the patch back until the regression 
> > is fully understood. I was just a little confused on your reference to 
> > Mel's comments. [...]
> 
> Yeah, that was just me getting confused about which change Mel was 
> referring to, as I was looking for external confirmation saying what I was 
> thinking about the patch: in_task()/in_interrupt() heuristics rarely do 
> well. ;-)
> 

Even though I was referring to something else, the reported regression
is still a regression.  Prateek's report and what I brought up in
https://lore.kernel.org/all/20220715100738.GD3493@suse.de/ are both simply
examples where changes to affine wakeup can have surprising results.

-- 
Mel Gorman
SUSE Labs
