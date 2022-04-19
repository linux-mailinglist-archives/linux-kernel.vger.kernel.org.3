Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3477850632C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348180AbiDSEMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348185AbiDSEMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627732DF1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E72B761183
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCD0C385A7;
        Tue, 19 Apr 2022 04:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650341392;
        bh=pMG4gBqrjUuaVREf5Do0t2y3IdtKoqfe6hpp7ubRJWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zXGb7uOHZhmcOCQpI+rMPu2asgr1XvhwF+5kGkjBB9d2riSOtt5vxSmlTb+Iw2CD3
         p5ZpiVp1gSg1az5NTQwch04E1VEF5dPXdHnve00QJ8PyW9pGABo20K1oCVUkZlDu8z
         xLziZtxICmzhR/k3eaoIOb3qDkn7gMhNLuyhtl2A=
Date:   Mon, 18 Apr 2022 21:09:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <minchan@kernel.org>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
        <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/madvise: fix potential pte_unmap_unlock pte error
Message-Id: <20220418210951.b87743ae8b7c01f883e571ea@linux-foundation.org>
In-Reply-To: <20220416081416.23304-1-linmiaohe@huawei.com>
References: <20220416081416.23304-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2022 16:14:16 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> We can't assume pte_offset_map_lock will return same orig_pte value. So
> it's necessary to reacquire the orig_pte or pte_unmap_unlock will unmap
> the stale pte.

hm, where did you learn this info about pte_offset_map_lock()?

I assume this is from code inspection only?  No observed runtime failures?
