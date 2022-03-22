Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35F4E3F0A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiCVNDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbiCVNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:03:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C065E75A;
        Tue, 22 Mar 2022 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q3UmGy9gJ4qXtSsXi97sPJvmm7Dxp16jk7JFceH7qMk=; b=XmN2gR/gltwKPSLIxPxGgTpf/S
        vuNKoyLTCWbTtCGlHPOhxtheIQdWVRYEIU2imY/zK1tIv8TnWrPagWUyFaBc6m1wN+R+04l9NruWF
        CipCBKecNZqDEK7lOj4dzIQexgkbTQzT68ygwxtti9kMJWcpaUj+kURSEuAgZIpDrboKkbMNOXaga
        eCmagxK0ascFucUZSqJqkBQLTvTfBaBwHYDx2GA6zM/J7UsEVl82KP3xclRblNkzmhXz+jGMgNCbq
        XGoRzPW2bqUDSsQVwOpx1cdcT+0j4Lsi2nURvg1/osgQqelVDCI5r1nuOaMJTwYQ56EwPBhkH++Gb
        txff5Rdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWe8d-00BbRC-Dz; Tue, 22 Mar 2022 13:01:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F70A30007E;
        Tue, 22 Mar 2022 14:01:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA1392019FD09; Tue, 22 Mar 2022 14:01:26 +0100 (CET)
Date:   Tue, 22 Mar 2022 14:01:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
Subject: Re: [PATCH v2 2/6] perf/core: Introduce percpu perf_cgroup
Message-ID: <YjnIpn/PCM6wKpOC@hirez.programming.kicks-ass.net>
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322120834.98637-3-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
> Although we don't have incosistency problem any more, we can
> have other problem like:
> 
> CPU1					CPU2
> (in context_switch)			(attach running task)
> 					prev->cgroups = cgrp2
> perf_cgroup_sched_switch(prev, next)
> 	cgrp2 == cgrp2 is True
> 

Again, I'm not following, how can you attach to a running task from
another CPU ?
