Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B37E4D3C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiCIVbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiCIVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:31:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8511C7F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A1F761A91
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B6C340E8;
        Wed,  9 Mar 2022 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646861411;
        bh=6Ug4WPjHsFmglkEyi2rRA7H01NYuecKpr79IHLkSjHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O7unKhH89e3MIf0JVKGuLMfBLZMwb7Lu0cuU6MplWZLCNvOsw3dzGuSO2SmfGy+f6
         KCkpOi1L7oGEBgn6A3nvVoSvvx/DymaIXjUXAroxieROL1u3VIwO0UvUQQ+HqTatyG
         crjBYc4Cayn52nqnhF1vMepqwTKr/gJUaXPEhukw=
Date:   Wed, 9 Mar 2022 13:30:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/hwpoison: set PageHWPoison after taking page lock
 in memory_failure_hugetlb()
Message-Id: <20220309133010.0f04c2ac4939edbdb35723bb@linux-foundation.org>
In-Reply-To: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
References: <20220309091449.2753904-1-naoya.horiguchi@linux.dev>
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

On Wed,  9 Mar 2022 18:14:49 +0900 Naoya Horiguchi <naoya.horiguchi@linux.dev> wrote:

> There is a race condition between memory_failure_hugetlb() and hugetlb
> free/demotion, which causes setting PageHWPoison flag on the wrong page
> (which was a hugetlb when memory_failrue() was called, but was removed
> or demoted when memory_failure_hugetlb() is called).  This results in
> killing wrong processes.  So set PageHWPoison flag with holding page lock,

What are the runtime effects of this?  Do we think a -stable backport
is needed?

Are we missing a reported-by here?  I'm too lazy to hunt down who it was.
