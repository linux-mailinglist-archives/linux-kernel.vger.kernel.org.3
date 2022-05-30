Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE29053890F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 01:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiE3XC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiE3XC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 19:02:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04824F3E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 16:02:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A2E160FC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B34C385B8;
        Mon, 30 May 2022 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653951744;
        bh=xT7SaWtqN0EyC8Ek+r//2xD54BrdZFRp3T/MnlYFo6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JsZKHYbTdUBqgiZITdHz43jCUoLaE3I/SSm4wI2HJRLGm1NJ5/7VTODYUHsdpw9JH
         zr04i6bh+G97yzowRs1GvfypPXgTbSyL8xHtoxSh912xauWbamHe/28g/GAFgRyemA
         rnbkL9VL0omoNo9JFAddoxEomXdl6+iR724ATj0c=
Date:   Mon, 30 May 2022 16:02:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
Message-Id: <20220530160223.63ae3bdef7420f252d7366ed@linux-foundation.org>
In-Reply-To: <20220527092626.31883-2-linmiaohe@huawei.com>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
        <20220527092626.31883-2-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 17:26:24 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> security_vm_enough_memory_mm() checks whether a process has enough memory
> to allocate a new virtual mapping. And total_swap_pages is considered as
> available memory while swapoff tries to make sure there's enough memory
> that can hold the swapped out memory. But total_swap_pages contains the
> swap space that is being swapoff. So security_vm_enough_memory_mm() will
> success even if there's no memory to hold the swapped out memory because
> total_swap_pages always greater than or equal to p->pages.
> 
> In order to fix it, p->pages should be retracted from total_swap_pages
> first and then check whether there's enough memory for inuse swap pages.

User-visible impact?

If I'm understanding correctly, there's a risk that this fix will cause
existing setups to newly fail when attempting swapoff()?



