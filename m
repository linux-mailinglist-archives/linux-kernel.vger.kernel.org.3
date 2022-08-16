Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8088F596483
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237516AbiHPVSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiHPVSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:18:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E375FDC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:18:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id k14so10425748pfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=fhV/1U3GhNNgulBJ9xirmL3fwWqaXvUvFbe/ujelsgY=;
        b=DbXtpIbuwj37q2l/Aj7lYp+S/c4c9yFKZhfUabHr5Z5kvTdFKccikLmjCisW2Yu5g9
         Jmcdjr556JP6LJlXVwkfWy3AeJVZ3KsbLNXepDMH93CIfSmeAUviKoFKUF3HxnuZZ1m2
         ST2CGF8ykU+fjekLcPZi6/JtNCmZViE0DdYBqENUVCMpgvQQQHJ2GvMAH2tssLSoy7U4
         4tUm1YDFs5IhRgNOuDeT916kOyu6DvsDzIAXbhXkT1n/wOZjjWoz0MxuFjdlok/DdCAF
         y2zEMpg2zmhoj2PjuDLodbxlpfgMeYDWbzfC1Ge+5jHHlDl2TUiYsh2EeTfwnwPM2g9S
         LEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=fhV/1U3GhNNgulBJ9xirmL3fwWqaXvUvFbe/ujelsgY=;
        b=BgAynjOFxUNAgqPyGUtAK9e6yfEhy0EjYhB4txLDYb/j9fENZaew+xOKO5MO1YNayq
         GZL/+kCnMPn0KQp+GWO1UuUe1O2T75HOlx8ZnzlT/V5iJXr8dkGpdav6/oYUtBuhMDIJ
         9Q3Pa0Wf03EvkFbYfrQqVXqJ216X5jZff9pOh9OE34Rq1M5bkxPgdHqWDpxusytciZJj
         ZOYwV2/5XV4AWKhMxXKV0mxkLhpkmopihxqraaD0nCZPjM93TPWuvsRIMiNs3N+sy96M
         2b84/1ZMtE6nCIJlDCMArPXDq3hb02xa5ddJd36CMSIELsG0+0HC7mWi4lAXl2l7cVoo
         jjLQ==
X-Gm-Message-State: ACgBeo08RYdTzDfJl9BcDIKxJfEUIFoOnYWYQoVj9YWPOlk2t1RyrMHY
        hA5bw7/fRTNNjNPBWsn6ymY=
X-Google-Smtp-Source: AA6agR7mZNoFrIFZq4gRQn9zwdBznvWl384/wI0Cb5sqM6uD/G+BzUsvh3dNkKA2QluZl7zS9m4S9g==
X-Received: by 2002:a05:6a00:428d:b0:52e:6305:14c with SMTP id bx13-20020a056a00428d00b0052e6305014cmr22442980pfb.10.1660684725085;
        Tue, 16 Aug 2022 14:18:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7229])
        by smtp.gmail.com with ESMTPSA id k15-20020a170902c40f00b0016dd6929af5sm9562237plk.206.2022.08.16.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:18:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 16 Aug 2022 11:18:43 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>, Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH 1/8] workqueue: Unconditionally set cpumask in
 worker_attach_to_pool()
Message-ID: <YvwJs66gR71UAHi8@slm.duckdns.org>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
 <20220804084135.92425-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804084135.92425-2-jiangshanlai@gmail.com>
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

cc'ing Waiman.

On Thu, Aug 04, 2022 at 04:41:28PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> If a worker is spuriously woken up after kthread_bind_mask() but before
> worker_attach_to_pool(), and there are some cpu-hot-[un]plug happening
> during the same interval, the worker task might be pushed away from its
> bound CPU with its affinity changed by the scheduler and worker_attach_to_pool()
> doesn't rebind it properly.
> 
> Do unconditionally affinity binding in worker_attach_to_pool() to fix
> the problem.
> 
> Prepare for moving worker_attach_to_pool() from create_worker() to the
> starting of worker_thread() which will really cause the said interval
> even without spurious wakeup.

So, this looks fine but I think the whole thing can be simplified if we
integrate this with the persistent user cpumask change that Waiman is
working on. We can just set the cpumask once during init and let the
scheduler core figure out what the current effective mask is as CPU
availability changes.

 http://lkml.kernel.org/r/20220816192734.67115-4-longman@redhat.com

Thanks.

-- 
tejun
