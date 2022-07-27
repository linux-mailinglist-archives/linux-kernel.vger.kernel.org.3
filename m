Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E9858273C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiG0NAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiG0NAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:00:32 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A334AB7FB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:00:30 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id b11so8276264qvo.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6b1aqsIK88pylFiOISBY0ELZL9Xn38SDDWKXVWVdB4=;
        b=mxeEHVKroQaEoNkoAbosEAI+dwFaB8qB8NsFaQPj5VYhC75/7PYl6GD/R0zO3TyA1o
         nBoj0AqdsPWFpokMFX7xH1L99L/Wt5B3Vhap0k0fS0Wvpxa4tOtPicKtinbNQMNuutQ/
         YMVBISTb6VDgAqg17inYCaUofGhW7ywH/m9nNmo/oAm55BIbDT+vkFKe9oij5crJdKPZ
         yc3QzeBkdujnDYXXN2sg9rxjjeXVghNgNJffb03vGdBSiCc8kfoJzJNXPTdAQPi0o/oD
         LJgEWF4gM6XX9sS8R+p8R9tweLfFEPPDS3fyv1LmunM9vr+l6K6rj3qoJCRwHUS/nD0V
         wf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6b1aqsIK88pylFiOISBY0ELZL9Xn38SDDWKXVWVdB4=;
        b=rOPYVrJc4cy1haiQ65RQWTdCzfOs+f/O2nsMzadfPFPvZCVsBIi3zX3YrEFxSO43Ur
         WoUWn7yW5VU3jb2HoC26ADLtxfaXNv+AlcvYirf9Lb7XwtLUBM+3gMZBIfV/93z8bqfG
         kuJVdPfNSYz+Q2w1RDLTIopBsPNppwXv46iV0QWY5SI5tosEMkg6VxCWZ5NPI+7KqYAF
         TEqVqwX69JKkDQvoBFECp1IpXDv8oNhUHx0WBr3W5B2s82pb4Y4eFP/mqtxEGKmZnmcU
         vXOQf9SMRVVOZp7CY3V8t5gkXvB0p6ZImLNQzwc3AoYTVVdnlcD/NOnBOWOJCy6oD6+S
         WSmA==
X-Gm-Message-State: AJIora/tPutQ5gQodl2YCL0yBOZ0vgzHqkuKYXtga/n5sSRRcLphWX+C
        b8P1WWobsc6j2pm4wXfbVOixGA==
X-Google-Smtp-Source: AGRyM1tQlxdrNIeWa4eutKhbk2YT1/mYsEXphAU0xZQV+RpGi7NGdgSIVDLz7QE85q7UyjWbQXje1w==
X-Received: by 2002:a05:6214:f0b:b0:474:11dd:177d with SMTP id gw11-20020a0562140f0b00b0047411dd177dmr18192068qvb.111.1658926829378;
        Wed, 27 Jul 2022 06:00:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id l25-20020a37f919000000b006b61b2cb1d2sm1985419qkj.46.2022.07.27.06.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:00:28 -0700 (PDT)
Date:   Wed, 27 Jul 2022 09:00:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Message-ID: <YuE26+jMjnE4GZZ2@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-10-zhouchengming@bytedance.com>
 <Yt7gOhbqYzIKyhfv@cmpxchg.org>
 <5f91e194-439a-12c0-4987-5dea0e68a60a@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f91e194-439a-12c0-4987-5dea0e68a60a@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 07:28:37PM +0800, Chengming Zhou wrote:
> On 2022/7/26 02:26, Johannes Weiner wrote:
> > I think we can remove the NR_CPU task count, which frees up one
> > u32. Something like the below diff should work (untested!)
> 
> Hi, I tested ok, would you mind if I put this patch in this series?
> 
> Subject: [PATCH] sched/psi: remove NR_ONCPU task accounting
> 
> We put all fields updated by the scheduler in the first cacheline of
> struct psi_group_cpu for performance.
> 
> Since we want add another PSI_IRQ_FULL to track IRQ/SOFTIRQ pressure,
> we need to reclaim space first. This patch remove NR_ONCPU task accounting
> in struct psi_group_cpu, use TSK_ONCPU in state_mask to track instead.

Thanks for testing it, that sounds good.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>

Since you're handling the patch, you need to add your own
Signed-off-by: as well. And keep From: Johannes (git commit --author).

Thanks!
