Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1805372FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbiE2Xr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 19:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiE2XrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 19:47:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE20515AC
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 16:47:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0923B80B8B
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 23:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDBFC385A9;
        Sun, 29 May 2022 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653868039;
        bh=ZxuH3VqJUJH1J3jzVH7bIwy/T6x2dAX8M/Zj5GnElfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e62CRT1/Y+gtGZ1y4URtOIZ0WumVsdH/AUKvCzgVQGbnBArb7wk9n2dKBBUUGB1Qx
         a0rMQkZMXjy5Qw8HwejKBuhmH9mMWNJDVyHKfNoT7qt3N+bgevKg37xRCMuv2Zmp/E
         hwV5Nr+aKY4j8QpCBocItMEat3kD80OyiG+GEJj0=
Date:   Sun, 29 May 2022 16:47:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jakub =?UTF-8?B?TWF0xJtuYQ==?= <matenajakub@gmail.com>
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org
Subject: Re: [PATCH v2 2/2] [PATCH 2/2] mm: add merging after mremap resize
Message-Id: <20220529164718.ed1eac7d614804c825fae9fd@linux-foundation.org>
In-Reply-To: <20220527211708.839033-3-matenajakub@gmail.com>
References: <20220527211708.839033-1-matenajakub@gmail.com>
        <20220527211708.839033-3-matenajakub@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 23:17:08 +0200 Jakub Matěna <matenajakub@gmail.com> wrote:

> When mremap call results in expansion, it might be possible to merge the
> VMA with the next VMA which might become adjacent. This patch adds
> vma_merge call after the expansion is done to try and merge.

Thanks.

Would it make sense to add a test case for this in (I assume)
tools/testing/selftests/vm/mremap_test.c?  Maybe parse /proc/self/maps
and check that the merging occurred as expected?

