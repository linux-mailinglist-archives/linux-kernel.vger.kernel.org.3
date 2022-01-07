Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE7487F8E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiAGXqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:46:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49954 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiAGXqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:46:23 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1768CB827AA;
        Fri,  7 Jan 2022 23:46:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 527C360F3A;
        Fri,  7 Jan 2022 23:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641599180;
        bh=4q0+90zvPIBLHLdx2HHkK1M/CzRQoVeNU0/BZbcDtK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=un+W4+AC5LZXVLLAY9lzVWSjXskTdyy32w+NPCOWV8mveY9VDV4MfWnAqYNNhTW7b
         eVz15R389DlC7qi0toQ++jKOgzlKVsYXeAtKA13P8fPGjPIljXpjpBFkt1SJc6cPbo
         N8xiFFtpAB1IvUp2VOB8sMI/w6lfT9mCXeSGk08k=
Date:   Fri, 7 Jan 2022 15:46:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] usercopy: Do not fail on memory from former init
 sections
Message-Id: <20220107154618.8c34696c07cea62cdd54c5b2@linux-foundation.org>
In-Reply-To: <YdeHDDAP+TY5wNeT@ls3530>
References: <YdeHDDAP+TY5wNeT@ls3530>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 01:19:24 +0100 Helge Deller <deller@gmx.de> wrote:

> On some platforms the memory area between the _stext and the _etext
> symbols includes the init sections (parisc and csky). If the init
> sections are freed after bootup, the kernel may reuse this memory.
> 
> In one test the usercopy checks if the given address is inside the .text
> section (from _stext to _etext), and it wrongly fails on the mentioned
> platforms if the memory is from the former init section.
> 
> Fix this failure by first checking against the init sections before
> checking against the _stext/_etext section.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 98400ad75e95 ("parisc: Fix backtrace to always include init funtion names")
> 

And 98400ad75e95 has cc:stable so we'll want cc:stable on this patch
also, yes?
