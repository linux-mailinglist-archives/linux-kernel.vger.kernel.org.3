Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94701591D26
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 01:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiHMX2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 19:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiHMX2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 19:28:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044089822
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 16:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A50EAB80920
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8A8C433D6;
        Sat, 13 Aug 2022 23:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660433320;
        bh=/nd0iG9fLC7CgVX6HvULDZV4QNZrX4MQtqqRHeB/XCY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y8HUp8Mxi0d6URADjUtO3p26TwUAoTrvTRrKMv0VLOEqO9dI7WQmvMImQXnU4wpTh
         8UnMSrANJHAeQDNJvbv9rImyRCsEhBQMRMJx2mw3qQbSq9mmHaAn/gEYRdOkWAtOZK
         Mlq8Gv6WSLhwz1ZPAQJzXpfmVJFvmKuoTQ4nzCCM=
Date:   Sat, 13 Aug 2022 16:28:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Haiyue Wang <haiyue.wang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        linmiaohe@huawei.com, ying.huang@intel.com,
        songmuchun@bytedance.com, naoya.horiguchi@linux.dev
Subject: Re: [PATCH v1] mm: migration: fix the FOLL_GET failure on following
 huge page
Message-Id: <20220813162837.cc20e208e7a9d65fd2e7dc14@linux-foundation.org>
In-Reply-To: <20220812084921.409142-1-haiyue.wang@intel.com>
References: <20220812084921.409142-1-haiyue.wang@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2022 16:49:21 +0800 Haiyue Wang <haiyue.wang@intel.com> wrote:

> Not all huge page APIs support FOLL_GET option, so the __NR_move_pages
> will fail to get the page node information for huge page.

Which ones need fixing?

What are the user-visible runtime effects of this bug?

Is a -stable backport warranted?

> This is an temporary solution to mitigate the racing fix.
> 
> After supporting follow huge page by FOLL_GET is done, this fix can be
> reverted safely.
> 

