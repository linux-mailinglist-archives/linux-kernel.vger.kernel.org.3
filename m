Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB1487F8A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiAGXoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiAGXod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:44:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BDC061574;
        Fri,  7 Jan 2022 15:44:33 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F4D86202C;
        Fri,  7 Jan 2022 23:44:33 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 954D760F02;
        Fri,  7 Jan 2022 23:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1641599072;
        bh=mFW9jLRAhoR62vEi6kr1oh7XBJ3e/Fq1hbvzXDZvlLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nHw662ABuBwKSE/w8YwQ4aHlfxmBHcel3EpKDjR0hDdcq8ZqESZci3HUpXqpdr7hP
         AlXKItDDJNzQA1oPGh75YW61s5Y8ufJm8KOy0HSQoTZCfIFI8DbAtItb+vJOsmRjYg
         OxYhSiOPyTSjxBATYpqwU35R1vB6KcccIGRxiubo=
Date:   Fri, 7 Jan 2022 15:44:30 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH] usercopy: Do not fail on memory from former init
 sections
Message-Id: <20220107154430.1bd6252e66baada7d84bdd6c@linux-foundation.org>
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

This sounds like it might have very serious runtime effects?

Please always fully describe a bug's runtime effects when fixing that bug.

> Fixes: 98400ad75e95 ("parisc: Fix backtrace to always include init funtion names")

So is this a must-have for 5.16?

