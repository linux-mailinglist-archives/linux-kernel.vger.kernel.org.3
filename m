Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37037576A81
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiGOXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGOXQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904F790D91
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3608761EC7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 23:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDCEC34115;
        Fri, 15 Jul 2022 23:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657926965;
        bh=PQ0OvovNHWNVJ85AlTJ9HsJZHtFm/Fz/eC48nptvWGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dVHsWaaMbB8kKs74a1Ng3goJkI/2IZoWuPWCk2k55eTGRd4Z2/SxFEwZk1ZphJTnf
         0MuLb6PiWnk2Swd4G8LbGPaRVPHnHa5XFSqHoLynIl5fk4Pv7ny4DYi+zQWYlz7fGR
         6/ssD7chfkoii1+588UZ4ot8BcvGEqf22WoRwR68=
Date:   Fri, 15 Jul 2022 16:16:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/mmap: Fix locking issues in vma_expand()
Message-Id: <20220715161604.a0cce6cd71742b38042aa055@linux-foundation.org>
In-Reply-To: <20220715184913.v75xv2na4dgz3ayb@revolver>
References: <20220712144926.4190769-1-Liam.Howlett@oracle.com>
        <20220715184913.v75xv2na4dgz3ayb@revolver>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 18:49:21 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> 
> Andrew,
> 
> I think in my confusing post about ignoring the previous version of this
> patch, you may have missed this completed solution?

Nope, this one is in -mm already. 
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-mmap-use-advanced-maple-tree-api-for-mmap_region-fix.patch
