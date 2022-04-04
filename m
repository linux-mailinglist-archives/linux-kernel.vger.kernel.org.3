Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039A4F1EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381725AbiDDWIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380077AbiDDSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:55:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FAB10ED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:53:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E625B60DB5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F245FC340F3;
        Mon,  4 Apr 2022 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649098414;
        bh=bYc4+MnhRyUZvvG3xV2Z/0MMfIXFk8Y9boux0z/HsrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZIuIXzk8J8KGwxOyL9hJ1cNBUn/IZ+LRc/Rs24gYR0RFSoypqfqgAAEmPu449Je5/
         WOzKsmRcBu76tozGhdbBzA4TiwWDT+XzuXNjNWxA8E2d2flj88tdbaEU+EcB0lElrJ
         xOOhH3eUgb2DxsqofuPMvzPKtFJn4ERUnNS+Wmdo=
Date:   Mon, 4 Apr 2022 11:53:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Message-Id: <20220404115333.8cf80b9d3a7a55993ed60c57@linux-foundation.org>
In-Reply-To: <20220404092131.751733-1-naoya.horiguchi@linux.dev>
References: <20220404092131.751733-1-naoya.horiguchi@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Apr 2022 18:21:31 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:

> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page.
> The one simple result is that wrong processes can be killed, but another
> (more serious) one is that the actual error is left unhandled, so no one
> prevents later access to it, and that might lead to more serious results
> like consuming corrupted data.

Should this fix be backported into stable kernels?
