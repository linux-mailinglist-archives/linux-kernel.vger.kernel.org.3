Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3414BC36A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbiBSAbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:31:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiBSAbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:31:18 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD612E9F8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:31:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v8-20020a17090a634800b001bb78857ccdso11423210pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8aZ16UFG/qN8SDATqq+xbNjeyEK8F2U4AYeI8Q7W9Mw=;
        b=HArcINaTCCHq36tGrqoEk7mWbIGxWYrZtNbvjNwmDNrmBHrKF3eJlEmgsdsTdOVnMq
         gwU0FIiZ3lb3nTu1nqY4vVwwJnHUzAC66FxLehc7wPjjnFMa8nrC2vIKci/NI+cgdx0O
         5mv4Zjt08mwVjFMhablIrVrKKZ0tJ7ZkS+DWkG6oHr8ISvrHErku953L0IAfmJ5H1IwE
         tpcPZ0e+eZl3ta4rPpfIMbwMD/rATwJYXVln33HESHVem5AggYKENrLDu9hCiM6AeD+L
         65Y6x9O5zH7k0GE7uQdIZ4ZIvC3mSThjkE1YaZhLPfx0/4C+JHfEqBOdh+HVxKvriHUS
         0uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8aZ16UFG/qN8SDATqq+xbNjeyEK8F2U4AYeI8Q7W9Mw=;
        b=sL3Y+hLHOQgxCFGhA7SZwLZI7yW/JcusMudiuTvh/lWrBwEkK3LC6AvpVebIU0XfCN
         PXF7F1W5MhxLIgMRAITFeMDZdMIXACP9HS41hKj4GrrLuAGYI90bvOI5QFf8wXvXsGWX
         OmZCZqaofhF+X3vlkDGwMkCkI6aj1KewHBDj2Z5oyYffBBLH31/gdvijwjgx1c6tQ3y1
         nJGIWgo7VGfSIwtssZz3Khe2DucRV+B7nQIQoTP3iIIhjsc09koosFIiAcaD44byTd0p
         hff5GTD3Ghm496RjIiQHnPVyujx6XKte6L7PsH7cI1NnrrBd1eA4urIiSAGlynXVSUnQ
         z1xw==
X-Gm-Message-State: AOAM531U9cNeLoTVqM1FXTEZAuwNW7NV0bTIBugcS9k5bxncWOYyLxy3
        F/IyTMLvcHvw/zzIU5XeJP0Dlxt/50Ksyw==
X-Google-Smtp-Source: ABdhPJzSAZ6U4sxN5IKhc/gevNuxGBEtDf2fuX3iCreS0CIEogpHitT+hzBHDWMZx2JytIHaobdHSg==
X-Received: by 2002:a17:90b:e89:b0:1b9:19d0:432c with SMTP id fv9-20020a17090b0e8900b001b919d0432cmr14919792pjb.154.1645230660174;
        Fri, 18 Feb 2022 16:31:00 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x6sm4127791pfo.152.2022.02.18.16.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:30:59 -0800 (PST)
Date:   Sat, 19 Feb 2022 00:30:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kernel test robot <lkp@intel.com>,
        Vipin Sharma <vipinsh@google.com>, kbuild-all@lists.01.org,
        mkoutny@suse.com, tj@kernel.org, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, dmatlack@google.com, jiangshanlai@gmail.com,
        kvm@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: Move VM's worker kthreads back to the original
 cgroup before exiting.
Message-ID: <YhA6QIDME2wFbgIU@google.com>
References: <20220217061616.3303271-1-vipinsh@google.com>
 <202202172046.GuW8pHQc-lkp@intel.com>
 <3113f00a-e910-2dfb-479f-268566445630@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3113f00a-e910-2dfb-479f-268566445630@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> On 2/17/22 13:34, kernel test robot wrote:
> > > 5859		reattach_err = cgroup_attach_task_all(current->real_parent, current);
> 
> This needs to be within rcu_dereference().

As Vipin found out the hard way, cgroup_attach_task_all() can't be inside an RCU
critical section as it might sleep due to mutex_lock().

My sched knowledge is sketchy at best, but I believe KVM just needs to guarantee
the liveliness of real_parent when passing it to cgroup_attach_task_all().
Presumably kthreadd_task can (in theory) be killed/exiting while this is going on,
but at that point I doubt anyone cares much about cgroup accuracy.

So I think this can be:

	rcu_read_lock();
	parent = rcu_dereference(current->real_parent);
	get_task_struct(parent);
	rcu_read_unlock();

	(void)cgroup_attach_task_all(parent, current);
        put_task_struct(parent);


> >    5860		if (reattach_err) {
> >    5861			kvm_err("%s: cgroup_attach_task_all failed on reattach with err %d\n",
> >    5862				__func__, reattach_err);

Eh, I wouldn't bother logging the error, userspace can't take action on it, and
if the system is OOM it's just more noise in the log to dig through.
