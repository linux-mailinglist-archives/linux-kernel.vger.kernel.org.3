Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92BB57E446
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiGVQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiGVQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:23:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D989A74
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:23:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a8-20020a25a188000000b0066839c45fe8so3981909ybi.17
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1v2THhkhdYklOspAmtCEFIjJCUUKeZARMXv38MhEpow=;
        b=UdOoN7qszmGcLnXMR4Ew1xMk2ipFrNQlnWb3XVRdsbye4OO074AP9hVBoaK+o/nqK/
         CwKsZVRH5EgCwsoFrJMaA1WNLMs35xMsQgcbYZN/OGUI1c0YAVZY7U60QZJ0pz/GkYg1
         O53wc4BVKC5ra0Dz2rtYq9nfp8be8Fz1BprUoXtxN1kdcLIcWwcoFHfg5otCLDGgQVeN
         KxJVE/sLDbVrbc17rkla+7UpCEF4GFgUU1vEEoDCBaSF+fDLyzn89cShgYYjgx7BnkNB
         XPBHkIJ6zv2qG5FtDrr9wveeK/ub8/0hS0rM0Wu1atXR494PpbVCtp3fMS5dI5EyK9jU
         wUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1v2THhkhdYklOspAmtCEFIjJCUUKeZARMXv38MhEpow=;
        b=gOUkSVplW5Bg+3bAZuQVpCx1QipIDTijS18bfEQs64M4/tQo2UESnI2LS6ftH2CXEM
         3qxA9d+1wP/C2VNCayLWDKudDAw21vtMvJRs76u9jBYBloICktso5W25hDIt/y01GLA/
         VwReolVDniKo+NrIJws/x02B+T0OKeYx0PSHcIdaxYcv/nCtRVmtf0tWh/zlxoth/aoa
         XYcKA9W7uG9vcLi3sOhkQd/rRYzDaDd/2/NuQihfs+H9ny0EYn494vxPqrmmJP+NE7J/
         M+Jh/m5qFIoCUtk9pmDzSgoXok0EbX01x6bu9dpVh70lsOci+QiOd8jsWAhi07Xd5nYR
         XmfQ==
X-Gm-Message-State: AJIora/+VTDfjOszXKoSS06mAWTuilESa8vNW2YvXJ22dRtBj0VV9F87
        Z8vz2KfCjPPR/dzyA99RMkeP5e67bN8OPw==
X-Google-Smtp-Source: AGRyM1sCNegJrDtUYTOOamWo7IQ6uTZYQOQ02ojmyPBnKh++Q7EWMLoeNc8UwznTaOuo39YXrVrI3Msk2Qp5Zg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:d406:0:b0:66e:c6b3:f11e with SMTP id
 m6-20020a25d406000000b0066ec6b3f11emr692378ybf.354.1658506980198; Fri, 22 Jul
 2022 09:23:00 -0700 (PDT)
Date:   Fri, 22 Jul 2022 16:22:57 +0000
In-Reply-To: <20220722164949.47760-1-jiebin.sun@intel.com>
Message-Id: <20220722162257.bl5zhc7ta6jvuy5e@google.com>
Mime-Version: 1.0
References: <20220722164949.47760-1-jiebin.sun@intel.com>
Subject: Re: [PATCH] mm: Remove the redundant updating of stats_flush_threshold
From:   Shakeel Butt <shakeelb@google.com>
To:     Jiebin Sun <jiebin.sun@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, songmuchun@bytedance.com,
        akpm@linux-foundation.org, tim.c.chen@intel.com,
        ying.huang@intel.com, amadeuszx.slawinski@linux.intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:49:49AM +0800, Jiebin Sun wrote:
> From: jiebin sun <jiebin.sun@intel.com>
> 
> Remove the redundant updating of stats_flush_threshold. If the
> global var stats_flush_threshold has exceeded the trigger value
> for __mem_cgroup_flush_stats, further increment is unnecessary.
> 
> Apply the patch and test the pts/hackbench-1.0.0 Count:4 (160 threads).
> 
> Score gain: 1.95x
> Reduce CPU cycles in __mod_memcg_lruvec_state (44.88% -> 0.12%)
> 
> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/hackbench-1.0.0 Count:4 (160 threads)
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Yes, this makes sense. No need to dirty a cacheline if we are already
over the threshold.

Acked-by: Shakeel Butt <shakeelb@google.com>

