Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407A050EB07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245662AbiDYVK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 17:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245536AbiDYVKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B81364714
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3882B81ABE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE22C385AD;
        Mon, 25 Apr 2022 21:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650920832;
        bh=FUgTUOPnsMOK1t9DbQ97PLfCozZyYYNmyOz2nN7u9Y4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wu7wMltOw21eeo6E7iDI9gldtm4ZPCJuYkj4Ecn13FlzfQQkab/LeuGTSMbQwhpBc
         dqiZ06ywMjAEAE59QfSC60bLjEEjveUsX6rwJd86cqTd/Gn0viwch5HuMvVVpmRnvb
         wKETYf9o10pmkt69eKG9vAvz7cssUUlgpbgS5O8Y=
Date:   Mon, 25 Apr 2022 14:07:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <ying.huang@intel.com>, <iamjoonsoo.kim@lge.com>, <hch@lst.de>,
        <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] mm/vmscan: activate swap-backed executable
 folios after first usage
Message-Id: <20220425140711.0c1898862fc817135bbbc56e@linux-foundation.org>
In-Reply-To: <20220425111232.23182-4-linmiaohe@huawei.com>
References: <20220425111232.23182-1-linmiaohe@huawei.com>
        <20220425111232.23182-4-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 19:12:29 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> We should activate swap-backed executable folios (e.g. tmpfs) after first
> usage so that executable code gets yet better chance to stay in memory.

Does this not erase the intended effect of Joonsoo's b518154e59a
("mm/vmscan: protect the workingset on anonymous LRU")?
