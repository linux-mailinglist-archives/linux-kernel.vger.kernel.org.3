Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204584E4463
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiCVQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiCVQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:42:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8435DE70
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:40:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so16082072pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o3rpaN/qyinfx9+vbmrN+Nl3xvluf+KWJ9u60Df0dI0=;
        b=QhaVfmthOFvJjSrnWlkog3LBOWRKOE36iBal/RBM71veF92SS3i5KnHz09/P354ZWl
         fzZJegvx2igVgWyTDdzPNJPxnH3+dhp2x8jpjI0oLC8pfAEX6K14bnrBoT+m4n1oJFD7
         kraI8Tb2fWil7TAnlhEZty7Eq5EogL6rWBY6ai6C0thn2u1RMXpkIAezO6NPTzHLpTKM
         +Guy7ANft5u6Q2/HVwiOwHTsdg7qMSXEfPn9wQnphf1cG3iYOe6gARQh343YvhJsDwq4
         CseUA33ciulReM9O2aG9iEMav/WgwqR/AMZL0QMBu9oWL5L2H1bvyrPuecz5TcOsBevg
         PrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=o3rpaN/qyinfx9+vbmrN+Nl3xvluf+KWJ9u60Df0dI0=;
        b=phkraV1KVMbkAfU22hjEjUldGtcQDJQjD+ws2AXETeS3I/4esqNlHS0FXVM6Bk1IaJ
         fG6GigV8p9BCwPmTDx7KiHsyM6PNNNeCRfORjYUKXpdeCN2DuzWxF9AOzPqyI8nx3zKf
         1ib+WYe/YjwRkNsOIyYebex1Z6LuyAemuuALncceERw8oU4t90EELQNpoM9y0CMGxmen
         Ev1bfWada4eSK3EBA0UFYH0by7Vhy+sqn0DURFSi7aruEp0DY1D/gWSSJ0e/oTEGHcq0
         ScDSO6s/QhQlrjTEhx4nkIPt/BAvrx+gZl2t+vBGNGADSOo91hP5OGafr00jocMdKelb
         dOsA==
X-Gm-Message-State: AOAM533W8MfFOoFWxHgv2e1a3JV6iAWCMPECsA5iR1h2LPcyHqVF5tfJ
        fViCF0DKAWa3YCuijFlvsRk=
X-Google-Smtp-Source: ABdhPJw+ZSxglIa59oM8dqp+OvB4VBQJBGSRrgGNAwPsoMOLR6fskYHNekuYghYCFY+cDr/NQCbZ3A==
X-Received: by 2002:a17:90b:4b0e:b0:1c6:f499:1cc9 with SMTP id lx14-20020a17090b4b0e00b001c6f4991cc9mr6043138pjb.133.1647967248925;
        Tue, 22 Mar 2022 09:40:48 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b0037341d979b8sm17860051pgh.94.2022.03.22.09.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 09:40:48 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Mar 2022 06:40:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@google.com, tim.c.chen@linux.intel.com
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
Message-ID: <Yjn8DohJ8CZ6pEvf@slm.duckdns.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org>
 <Yji0twS4N+0b/Rs9@slm.duckdns.org>
 <CAKfTPtA8g-MJMPRM2R_Bfo9rGSyR3cYAUy_j5UrRM+SAB=Mm7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA8g-MJMPRM2R_Bfo9rGSyR3cYAUy_j5UrRM+SAB=Mm7w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 22, 2022 at 05:10:36PM +0100, Vincent Guittot wrote:
> latency_nice is quite similar to nice. The nice latency is used as an
> index to get a latency weight in the range [-1024:1024].  latency_nice
> is in the range [-20:19] and latency_prio shifts it in the range
> [0:40] . This index is then used to get the latency weight similar to
> how the nice prio is used to get a weight. That being said, the
> latency should probably reflect the latency_weight instead of the
> latency_prio in order to be aligned with the weight and weight.nice
> fields of cgroups.
> 
> As described in patch 5 commit message, the weight is then used to
> compute a relative offset to check whether the waking task can preempt
> the current running task.

So, what I'm trying to say is if it is actually a weight, just use weight
values instead of arbitrary mapped nice values. Nobody can tell how the
latency nice value of -2 compares against, say, 3. If you can define it
clearly in terms of weights (or something else clearly describable), it'd be
a lot better.

Thanks.

-- 
tejun
