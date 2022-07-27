Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F269583511
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 00:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiG0WFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 18:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiG0WFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 18:05:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283115FAF;
        Wed, 27 Jul 2022 15:05:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ha11so290689pjb.2;
        Wed, 27 Jul 2022 15:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=LiTE1tqkRaXoGmySEYYRcpLO/+mjVSFHJMv7429wZro=;
        b=NHwA96X568WaIEaeAdyZO0/H9EiUstVUoUzwPvi2DW1XeFPSXJM+pno7z20CNEPdfy
         jtpUoD/NG77HMfz2SM4Ew7XWm1yx8KoqX+PI7rWzBicwdqH9eDqFHw2hbPV6fOOzZ8Ap
         uMKQuplFrpNzf5Cb5h/NBlg9o1HDqGzE0Kt/Dwj9q7S2WYHvoSsd2krjCbICCTtH4zt4
         P6E8MSKWyMYt4AwrkdxRnTiJLFDggFyKpRxi9r8belvxHq0vSmVEVCjrOVv2hpHD55dY
         +Oul0/kXpRw8XYWK7OM3ESjaB8h/IKZJICgzzFqdnyU8j2XN04DKgNTmo+Vi/yWLXWn7
         aYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=LiTE1tqkRaXoGmySEYYRcpLO/+mjVSFHJMv7429wZro=;
        b=1JqeiBNk7OjM2DZd2d0orKG/rzWHvdRodeAjTerIyLAtGeGaP1VF6FJL1DhICqtLXC
         7oKnrW+1CNhM8FqT+sddIK56LA4g+yaJBGae6b53BILWgI0zuD0s21LHnndD6I5lf+ty
         ocRwAxVKQ3XII9LrZftPniv3Ca9idnJ1GH+41IZcLLNoZWENyMiJqmbb7D3hWvzXvm3T
         5LkwYd1GTbXzhWGpSs/zG+1jOI6kpETECaSiUfqajA1isvzee/aS7CtTSFdoPE46sLe/
         M9ZSfVhDiPEQRDKP/PBP92Jb/x0lw0lr7KFYxACq/GSjfA+U/0VGgfGsRPcJ/xbTZVvi
         9org==
X-Gm-Message-State: AJIora/n7oo3M8/GZgSQCYibchwkopVfXsiaMl4b0N/cPc1pdeqhTBVk
        u7mxgXzUfP3GPMpc2CunuYU=
X-Google-Smtp-Source: AGRyM1sOnkApFtvoXih9H6FXYdeOtMGZvB9VSQD6m0DxjYnRs64/cCZfh/dSg2k1v8GKt4MWAe1kgQ==
X-Received: by 2002:a17:902:aa89:b0:16b:e514:54d2 with SMTP id d9-20020a170902aa8900b0016be51454d2mr23780612plr.127.1658959544183;
        Wed, 27 Jul 2022 15:05:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5a55])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b0016d785ef6d2sm7302739plg.223.2022.07.27.15.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 15:05:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 27 Jul 2022 12:05:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
Message-ID: <YuG2tU1EoQmRqLjK@slm.duckdns.org>
References: <20220705123705.764-1-xuewen.yan@unisoc.com>
 <20220711174629.uehfmqegcwn2lqzu@wubuntu>
 <YsyO9GM9mCydaybo@slm.duckdns.org>
 <20220712125702.yg4eqbaakvj56k6m@wubuntu>
 <Ys2duuPDNq/q+oOz@slm.duckdns.org>
 <YuG1vwqs1GgE/twg@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuG1vwqs1GgE/twg@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jul 28, 2022 at 12:01:35AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 12, 2022 at 06:13:46AM -1000, Tejun Heo wrote:
> 
> > But now we're failing user-initiated operations randomly. I have a hard time
> > seeing that as an acceptable solution. 
> 
> There (sadly) is precedent for that; grep for "cpu_hotplug_disable".

Yeah, there's another one in cpu cgroup controller attach path. We should
get better at not doing these. Low frequency arbitrary failures are really
difficult to handle reliably downstream.

Thanks.

-- 
tejun
