Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5292F589E04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 17:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiHDPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiHDPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 11:00:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472251A36
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 323D2B8258F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5ADBC433C1;
        Thu,  4 Aug 2022 14:59:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RJUdSGbh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659625190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GlywDwIYA79HfUqSNMAJ+LFUue5+U5J9GyiTgQoafZc=;
        b=RJUdSGbhsLrWtZZfKWJ2orpGi4YppE6A7Wv9kdZMwbbqVgz3e6Wkmg0gFcBppUVk3Urozr
        bWIQhPnnvYl67cOKb3nj+lc+N/ikDA3GOWCqcmiE/acGbBPmVEaP2eYQgT+6L+9+mLS8AE
        mMZC+Qo0xTDqH6FeurOR2ACmdUmiQ0I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 852c8a41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Aug 2022 14:59:49 +0000 (UTC)
Date:   Thu, 4 Aug 2022 16:59:46 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     bchalios@amazon.es
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu, dwmw@amazon.co.uk,
        graf@amazon.de, xmarcalx@amazon.co.uk, gregkh@linuxfoundation.org,
        mikelley@microsoft.com
Subject: Re: [PATCH 0/2] virt: vmgenid: add generation counter
Message-ID: <Yuve4vuAnU85mdRY@zx2c4.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220803152127.48281-1-bchalios@amazon.es>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babis,

On Wed, Aug 03, 2022 at 05:21:25PM +0200, bchalios@amazon.es wrote:
> From: Babis Chalios <bchalios@amazon.es>
> 
> Linux recently added support for the VM Generation ID mechanism from
> Microsoft. The way this works currently is using the 128-bit blob
> provided by the vmgenid device to re-seed the RNG. While this works it
> has two main issues, (a) it is inherently racy due to the fact that it
> relies on a ACPI notification being delivered and handled and (b) the ID
> is unsuitable for exposing to user-space.
> 
> This patch-set extends the vmgenid device to introduce a generation
> counter, a 32-bit counter which is different every time the unique ID
> changes. The addition to the original implementation in QEMU can be
> found here:
> https://lists.nongnu.org/archive/html/qemu-devel/2022-08/msg00524.html.
> 
> The first patch re-works slightly the current vmgenid driver to add a
> function that parses an object from the vmgenid device and returns the
> physical address of the vmgenid data. The second patch uses that
> function to parse additionally the address of the generation counter
> from the vmgenid namespace. The counter is then exposed to the
> user-space through a misc-device which provides `read` and `mmap`
> interfaces.

First, with regards to your mmap interface, it's more likely that this
kind of thing will be eventually folded into my investigations regarding
the RNG and the vDSO (which would make this kind of thing accessible
without needing the file system).

Regarding the counter itself, I don't want to rush into augmenting the
vmgenid mechanism until we've had some conversations with Microsoft. But
also, it seems like you might have missed the extensive previous
discussion about this. There was some tradeoff in efficiency about
mapping this all the way through, as doing so would require the counter
to be in a totally separate page as the main 128-bit ID, versus just
having the kernel manage a separate counter and incur a potential [maybe
acceptable? unclear] race.

Jason
