Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6436E49E42C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242227AbiA0OJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiA0OJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:09:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=59JKSkvc74DWwVkjK+v6CkrZWKoKtEZ3D8hogGvO6Ww=; b=tppngXPoOUdNU+dDbRM7RdxtuE
        XW0L5l80ljCLF6VtwnI2R3ABbRV5AA6yDo1K6SD49ShJrzDkMcqnL7BL9jzfeDK27gzsdFYo0Ytt3
        WitpVqTRilKwmCqwLXw2dcC6YYZW59Xb5bS0vILDqNWpjTMpUNAC/7nvRH0b3aItnQoVpXNEpVhsn
        KqUjM6zU7o9ra6IEnTnIsrDHJaiokqTAqZ7Z/Usch/woP4abU6HQrgXDka9U4DpXhrkNMYjX1WUS0
        AMgt8a2K622Xrh1lp77YYca99OlPaqMXladND1C4BU1OtSCNzTioVQK8Kx0skBsBmio8RRNL94rlN
        PCPgtrQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD5SS-005If6-Oh; Thu, 27 Jan 2022 14:09:04 +0000
Date:   Thu, 27 Jan 2022 14:09:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
Message-ID: <YfKngOPLeI3rQOn3@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:25PM +0100, Karolina Drobnik wrote:
> Add a dummy io.h header.

Rather begs the question of what memblock.c needs from linux/io.h.
Wouldn't it be better to:

+++ b/mm/memblock.c
@@ -18,7 +18,6 @@
 #include <linux/memblock.h>

 #include <asm/sections.h>
-#include <linux/io.h>

 #include "internal.h"


(allmodconfig on x86-64 builds fine with this; I have not done an
extended sweep of other arches / build options).
