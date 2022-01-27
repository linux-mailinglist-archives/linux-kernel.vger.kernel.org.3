Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F449E3EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiA0N4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiA0N4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:56:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55595C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=E9AD+rI9OWKW7gBQjNlVOBV7o12pc2DPP2BjIJ5a0lU=; b=Sy4LpHlXX/F9DEhym1b6Z0CR3S
        v10GUiwrWU1FvDB99woTbeQ5iQmOuEixU8lKbEW9QoKv+3yZZNmmUkXgQffWsdoR+KD/4Ev1bwxMT
        M23P2Kp+z6rzjk0oHl9sDzenaBABKh4Y+9UGwga8G7DS5LISN/MeAbGwqz7m1LVlKlC/NN2DeEkro
        WbJtd/JtgfiGkWnc9sDKRGFodbdRdhdKU6mNbck7cBN4oI1c/2C7hYtVcQuVX01kbNhzIR6hHBC2v
        ku1W88LcrSLyAfrBy08bgozzv3w/hhwhtlP201NYXvy9U8lrW7jIiNV3NVrdyAT5+2StI3Gh50hhH
        Et2Vs09Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nD5GL-005I3G-RO; Thu, 27 Jan 2022 13:56:33 +0000
Date:   Thu, 27 Jan 2022 13:56:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/16] tools/include: Update atomic.h header
Message-ID: <YfKkkRNTA9qCmPTW@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <bbd768fa794c68cda7888182f464411aebb65b7f.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd768fa794c68cda7888182f464411aebb65b7f.1643206612.git.karolinadrobnik@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:21:22PM +0100, Karolina Drobnik wrote:
> Add atomic_long_t typedef and atomic_long_set function so they
>  can be used in testing.
> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  tools/include/linux/atomic.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
> index 00a6c4ca562b..5d2431889606 100644
> --- a/tools/include/linux/atomic.h
> +++ b/tools/include/linux/atomic.h
> @@ -4,6 +4,10 @@
>  
>  #include <asm/atomic.h>
>  
> +typedef atomic_t atomic_long_t;

Given this:

typedef struct {
        int counter;
} atomic_t;

your definition seems wrong.  Why not add atomic_long_t to types.h,
adjacent to atomic_t?
