Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9977D4BF525
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiBVJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBVJxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:53:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7462D10B8;
        Tue, 22 Feb 2022 01:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FE9EB8187E;
        Tue, 22 Feb 2022 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B471AC340E8;
        Tue, 22 Feb 2022 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645523588;
        bh=dcLPqQqzFfwhFwJ9Kn/RubyJyNfK8yswScv0W6K2bpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=CqexYHz+BllH8K7Fc97pdhI+aS+BB4l4VG/ur/7rHWWW82c5F5KntSVsGV6h7oRrI
         WhAMIW1hnkD5gai7s9k6PfuMgElbaf2s5ELrUgQZW/TxmLc5tdJ5O3cPufdr2ppBNH
         LjJ5lfLwvnQ6mDVZzGLcX2H288n9FxCvC51hjnhvs7PKiGNgQAvw2KJ5uIXZ2Yfnk6
         XHg+GIMuzKeODORR4nZycBCzc8du9e9aoOPQanBb1QVF1doPEOzHgoJf1dXNtKYBX5
         VyDu7z+V/hLgtJPxxXqr48MXzB2ALbYVlK/GVsdYc6n7/CgrTRTs7IcBPPdnTMU0ad
         T469gBrvdu45A==
From:   SeongJae Park <sj@kernel.org>
To:     Jonghyeon Kim <tome01@ajou.ac.kr>
Cc:     akpm@linux-foundation.org, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/3] Rebase DAMON_RECALIM for NUMA system
Date:   Tue, 22 Feb 2022 09:53:02 +0000
Message-Id: <20220222095302.7859-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218102611.31895-1-tome01@ajou.ac.kr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonghyeon,

On Fri, 18 Feb 2022 19:26:08 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:

> 
> Current DAMON_RECALIM is not compatible with the NUMA memory system. To
> proactively reclaim memory, DAMON_RECLAIM kernel thread(kdamond) has to wake up
> before kswapd does reclaim memory. However, the current watermark for proactive
> reclamation is based on entire system free memory. So, though the one memory
> node is fully used, kdamond is not waked up.
> 
> These patches clarify watermarks of DAMOS and enable monitoring per NUMA node
> proactive reclamation on DAMON_RECLAIM.

The high level concept of this patchset looks good to me.  Nevertheless, maybe
there is some rooms for improvement.  I left some comments on patches.


Thanks,
SJ

> 
> Jonghyeon Kim (3):
>   mm/damon: Rebase damos watermarks for NUMA systems
>   mm/damon/core: Add damon_start_one()
>   mm/damon/reclaim: Add per NUMA node proactive reclamation by
>     DAMON_RECLAIM.
> 
>  include/linux/damon.h |   3 +
>  mm/damon/core.c       |  39 +++++++++--
>  mm/damon/reclaim.c    | 147 ++++++++++++++++++++++++++++++------------
>  3 files changed, 140 insertions(+), 49 deletions(-)
> 
> -- 
> 2.17.1
