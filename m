Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0485B0E64
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiIGUn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIGUnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1CC0B66
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D7E61A4E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1272EC433B5;
        Wed,  7 Sep 2022 20:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662583401;
        bh=FRKdhXGWFNIp4ValMgTEBtAERy/TmsP1c+r60idMAtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GCuThdvvW+ISBXwN7pYF3eReAOVwGG4l8qSRElZF8x/O8rzqjZYgy60xJPEFtQ8om
         DZlGkg5Ynq01RnKTVK2SGLXF4JXtOcdTfvuWUeMvp4/BCPUN9JC9eT3FCGiaTIw9Yl
         lJwGXZ+YPsdqdsvTt9TiNPm9qou3MbrvAkcGLtp4=
Date:   Wed, 7 Sep 2022 13:43:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Sun, Jiebin" <jiebin.sun@intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>, vasily.averin@linux.dev,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        alexander.mikhalitsyn@virtuozzo.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Huang Ying <ying.huang@intel.com>, tianyou.li@intel.com,
        wangyang.guo@intel.com
Subject: Re: [PATCH] ipc/msg.c: mitigate the lock contention with percpu
 counter
Message-Id: <20220907134320.01d1693387bde4af5d3100fb@linux-foundation.org>
In-Reply-To: <a4d10f9e-ab8f-ffad-5eea-48316c436f41@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
        <CALvZod44uUFnwfF4StC24t+d1s_XE10hkmSCgb04FjtTATo6xQ@mail.gmail.com>
        <048517e7f95aa8460cd47a169f3dfbd8e9b70d5c.camel@linux.intel.com>
        <a4d10f9e-ab8f-ffad-5eea-48316c436f41@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 17:39:47 +0800 "Sun, Jiebin" <jiebin.sun@intel.com> wrote:

> I have sent out the patch v4 which use percpu_counter_add_batch. If we use
> a tuned large batch size (1024),

Oh.  Why not simply use a batch size of INT_MAX?

> the performance gain is 3.17x (patch v4)
> vs 3.38x (patch v3) previously in stress-ng -- message. It still has
> significant performance improvement and also good balance between
> performance gain and overflow issue.
