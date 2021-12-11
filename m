Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E86471722
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 23:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhLKWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 17:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLKWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 17:21:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DEBC061714;
        Sat, 11 Dec 2021 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OR7MJxyz9yi9GRif0LyRjFc5JufWB/LgEct4g0DHtRo=; b=NdISd7c+CE9Cr1M5d12kS3JQaJ
        GpciRXX48yuTdNDcC5lu8PnyY6AFiaMODdiCLCOU0kg/fCLhKoy3Mfuuh6W0gW8iWyagG5vH+VWT3
        IC75pxmdvGiPCL0HuJKVRNW0+ryiUUJecsHgHef3cx/ytlNUF5GiJEwqDSZYuCmXPWkwirz5DzbHZ
        02KUCm6PXtoi9kYl7joby42noUw0WnyQthGL8mcOyGqS/iwlUXEOilZlNSIjhmdFaSLs68VDUCfLw
        lRHvX1HsdWppQ2V02FAJJlq+b1TORWzdFQU0yOwmIOqP++a8OD4QMiK2Q2u+HxiBcJ0vg00w0fAd/
        79NarRhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwAkQ-00BWe5-6j; Sat, 11 Dec 2021 22:21:42 +0000
Date:   Sat, 11 Dec 2021 22:21:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] docs/vm: clarify overcommit amount sysctl behavior
Message-ID: <YbUkdvFBayRwV6ax@casper.infradead.org>
References: <20211211194159.3137362-1-anssi.hannula@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211194159.3137362-1-anssi.hannula@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 09:41:59PM +0200, Anssi Hannula wrote:
> Documentation/vm/overcommit-accounting.rst says that the overcommit
> amount can be set via vm.overcommit_ratio and vm.overcommit_kbytes.
> 
> Add a clarification that those only take effect in overcommit handling
> mode 2 ("Don't overcommit"), i.e. they do not act as an "additional"
> limit that is always enforced.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> ---

Simple and clear improvement, IMO.  Cc'ing linux-mm to get more eyes on
it.

> I've had to look this one up in the code enough times already :)
> 
> 
>  Documentation/vm/overcommit-accounting.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/vm/overcommit-accounting.rst b/Documentation/vm/overcommit-accounting.rst
> index 0dd54bbe4afa..1addb0c374a4 100644
> --- a/Documentation/vm/overcommit-accounting.rst
> +++ b/Documentation/vm/overcommit-accounting.rst
> @@ -34,7 +34,8 @@ The Linux kernel supports the following overcommit handling modes
>  The overcommit policy is set via the sysctl ``vm.overcommit_memory``.
>  
>  The overcommit amount can be set via ``vm.overcommit_ratio`` (percentage)
> -or ``vm.overcommit_kbytes`` (absolute value).
> +or ``vm.overcommit_kbytes`` (absolute value). These only have an effect
> +when ``vm.overcommit_memory`` is set to 2.
>  
>  The current overcommit limit and amount committed are viewable in
>  ``/proc/meminfo`` as CommitLimit and Committed_AS respectively.
> -- 
> 2.31.1
> 
