Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8670E5653DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiGDLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbiGDLit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:38:49 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CDD11443
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rPsfA7FPBrtA8YeRCyzmevDdXCVc3WnjxOgSbxjPq0I=; b=E1m5OMQ8m8WMtt+qBlLM3lelQV
        +Nc8NNplnOZnI1RZK5h5YFyacDOviyxRu7rBJGfMbeqPG+X+duOHbcbuVnrahdABHvB94z//XleJD
        ybAZbU9EanuiTN0LemB2acuFI8MTb3d0FsvU9oln7wTVetrddCjzk6NUz0LIg3TfMWCQCZSOeeWNp
        Ku0P23I6oRLxvCwIpQkgFjAvN1IyJzfrBdVhYmJ089AeA+EaSAMXUS4T0gin+Hh/M5GTM8XlxHLhm
        Sg3Z+oWK22TESjCJOdLJSgNnYCgHuFu/vgpjc7HqQbC06k6XN2TUrOz+XuvSgBmhZl7nJMlLFjcyM
        irHXJq0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33164)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o8KOV-0008OU-Ol; Mon, 04 Jul 2022 12:37:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o8KOU-0002K0-Dv; Mon, 04 Jul 2022 12:37:34 +0100
Date:   Mon, 4 Jul 2022 12:37:34 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsLQ/h/IG0lsuufj@shell.armlinux.org.uk>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
 <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
 <YsKIDqAjg383vGuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsKIDqAjg383vGuk@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:26:22AM +0300, Mike Rapoport wrote:
> I'd go with PMD_ENTRY_ORDER as Russell suggested last year.
> 
> From 6389dfb2e5ae5b040ca1c8f07a071d8da2873b13 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Mon, 4 Jul 2022 09:17:40 +0300
> Subject: [PATCH] ARM: head.S: rename PMD_ORDER to PMD_ENTRY_ORDER
> 
> PMD_ORDER denotes order of magnitude for a PMD entry, i.e PMD entry
> size is 2 ^ PMD_ORDER.
> 
> Rename PMD_ORDER to PMD_ENTRY_ORDER to allow a generic definition of
> PMD_ORDER as order of a PMD allocation: (PMD_SHIFT - PAGE_SHIFT).
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Yes, absolutely.

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I really don't buy the argument that we should not be using "order" here
and we need to make up some other random idiotic term just because Linux
uses "order" *elsewhere* for PAGE_SIZE * 2^n. The Linux kernel doesn't
get to redefine standard terms, and certainly doesn't get to demand that
one has to make up another name for a standard term because it conflicts
with some other usage of that term that's non-standard.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
