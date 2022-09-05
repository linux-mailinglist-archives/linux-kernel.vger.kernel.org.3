Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1995ADA0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbiIEUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiIEUHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 16:07:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C521EEEF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 13:07:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21A2601BD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 20:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5BEC433D6;
        Mon,  5 Sep 2022 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662408449;
        bh=ysM9awpw0A2M34q5JF3n3+0RW+KGU1zgTfvVfudH32Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oecxaYBa382HbPtWr3k1hVeYfFE3D4Ang+wYKMylmV+PLsjYj5BzbU7EvmMU4rVg6
         PvuoEB5byW/91Ca1yoXE1cSyPQHCKUKSSeMoT5aF+Z1JIAvR5W3C53Vy422ZjIDm8g
         eB1YPrhQWOFcCtyKaGWaHt9BWFb6X2n6qA660nwQ=
Date:   Mon, 5 Sep 2022 13:07:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC increased
 twice
Message-Id: <20220905130728.1e814d185b189faece6f2c2f@linux-foundation.org>
In-Reply-To: <20220905133813.2253703-1-liushixin2@huawei.com>
References: <20220905133813.2253703-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 21:38:13 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> If two or more threads call get_huge_zero_page concurrently, THP_ZERO_PAGE_ALLOC
> may increased two or more times. But actually, this should only count
> as once since the extra zero pages has been freed.

Well, for better of for worse,
Documentation/admin-guide/mm/transhuge.rst says

thp_zero_page_alloc
	is incremented every time a huge zero page is
	successfully allocated. It includes allocations which where
	dropped due race with other allocation. Note, it doesn't count
	every map of the huge zero page, only its allocation.

If you think this interprtation should be changed then please explain
why, and let's be sure to update the documentation accordingly.

