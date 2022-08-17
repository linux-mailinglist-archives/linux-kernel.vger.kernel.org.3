Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495F3597348
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 17:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237181AbiHQPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiHQPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:48:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F14E860
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 08:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1E8BB81E09
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26772C433C1;
        Wed, 17 Aug 2022 15:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660751314;
        bh=AHeZfy/Nxh85RKgqk8hL9JaiFYeWKnNM/yiUeuArn60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtXfFWzsCJkDcjy2yOzYGhRdcGusJrTQhO8VRzdx5/NBDr4bqcyLOnZm+gVi/kq8R
         7xpEIDDriJXwmkzaJaBW0UfxrqCSA9Cv5jaZ1CFMVlpWKKTWL67YUk5B5xNdDK2llZ
         UGQFwn2z0wli5tDoM2zTwWdzcxCGqLVdB886By5U=
Date:   Wed, 17 Aug 2022 08:48:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH -V3 0/8] migrate_pages(): fix several bugs in error path
Message-Id: <20220817084833.b348d11eab362b2ac5a02259@linux-foundation.org>
In-Reply-To: <20220817081408.513338-1-ying.huang@intel.com>
References: <20220817081408.513338-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 16:14:00 +0800 Huang Ying <ying.huang@intel.com> wrote:

> error-inject.patch, test-migrate.c, and test-migrate.sh are as below.
> It turns out that error injection is an important tool to fix bugs in
> error path.

Indeed, and thanks for doing this.

Did you consider lib/*inject*.c?  If so, was it unsuitable?
