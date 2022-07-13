Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AA572BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiGMDA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 23:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGMDA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 23:00:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0099D64E2;
        Tue, 12 Jul 2022 20:00:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1451643pjo.0;
        Tue, 12 Jul 2022 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uu7yfJwTmGgJzlT0USq6IvgcHtE1wUeXRQtFy2CZjgI=;
        b=P0+NrwkARt5qtH2d9Ftq9LknLWfeKG5UnhqMbtA4um7o/hgsygqMQA6A1xAKK+L6ZG
         B5dyGjHOt8pWLtlHmWjhWIF7yo4/tcfwbsAO1e1cnP2g7TYDrKCqQeG0aKr9OrVs4kFk
         +zQOr6QcBq0ZMZYUWlH+Xd1eEntXeznrPBJx9GXc6BcPKSAYHgYa1aFzpib43xXG0TrO
         zj+Z8+/XWaXinJ27B8fBwhPikw0rlxiK2dJc3SyQlIxotA8GbQ7f1bMko14coy4TkT+u
         xQR4o7vY0HJ9goahSmCIqoT+KE4jNfTKAgoJpM30oyrmUro8cVuSP9haOOPk5/rzedmb
         pLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=uu7yfJwTmGgJzlT0USq6IvgcHtE1wUeXRQtFy2CZjgI=;
        b=qTjVpKVlmbVk/EHqp/sdfDVrhk5g5HQbHIMoXe83sZBY9iXtA1EOnk3RCioiJdduOX
         MXq4AyTRPwlLO889GFcNXh6NnKCFeFAJeKAe3QXsTlxNVLUk7kfbspuT7RmdWfejogTB
         6p5e7ybr/iwCpEKNg8Bs/WT+8/796MPEyneb5hqfUPpG3ATVfI2Cfb169qO1FlzNdzlm
         p8WkIrbDhN8cqICsT3H1yEkbi1FmnU1YQf3OLML5c+Dz8aWMPrtJI6nKkmzoUdgvKPyQ
         m++TI2BDyf42T0k+g/QYzpihk6oQ9DeRh0JJy6d7B0nnLLIO4t2ZtZR2QYeuql7xH7Fm
         O35g==
X-Gm-Message-State: AJIora+hzz/Sa1V78K77crYndUF71yebbQtzbXObF3mRCFQYMAA7NCeS
        ZT7eMrEFR/NsJn4CVNfJG+g=
X-Google-Smtp-Source: AGRyM1uqTVb6wB6NK+9TJ1fvF12+cIqKGyxPVg39t0hqb8TYaYBust/7uKzyGR11Fr5EY5/VM86dMA==
X-Received: by 2002:a17:902:ec8a:b0:16c:4baa:a50c with SMTP id x10-20020a170902ec8a00b0016c4baaa50cmr1109912plg.62.1657681255327;
        Tue, 12 Jul 2022 20:00:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:9b46])
        by smtp.gmail.com with ESMTPSA id a8-20020aa795a8000000b0051c49fb62b7sm7520173pfk.165.2022.07.12.20.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 20:00:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Jul 2022 17:00:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <Ys41ZF5TmSnLLNRB@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1426573-92a7-9f0d-a6b8-aa612248b9a9@redhat.com>
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

On Tue, Jul 12, 2022 at 10:49:57PM -0400, Waiman Long wrote:
> > Well, the only thing I can think of is always grabbing cpus_read_lock()
> > before grabbing threadgroup_rwsem. Waiman, what do you think?
> 
> That is a possible solution as cpus_read_lock() is rather lightweight. It is
> a good practice to acquire it first.

On a similar note, I think we probably should re-enable percpu operations on
threadgroup_rwsem too by default and allow users who are affected by slower
write path operations to opt-in. After the new CLONE_INTO_CGROUP which
doesn't need the rwsem, we have far fewer write lockers after all.

Thanks.

-- 
tejun
