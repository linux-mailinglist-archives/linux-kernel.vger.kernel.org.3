Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D504D76A2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 17:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiCMQK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiCMQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 12:10:27 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6E15A09
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 09:09:19 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 8C82C22CD1;
        Sun, 13 Mar 2022 16:09:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 5777620024;
        Sun, 13 Mar 2022 16:09:17 +0000 (UTC)
Message-ID: <75480288322af54a589539d8296bd9a35a67dbca.camel@perches.com>
Subject: Re: [PATCH] checkpatch: warn that small allocs should be combined
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 13 Mar 2022 09:09:16 -0700
In-Reply-To: <20220313140827.1503359-1-trix@redhat.com>
References: <20220313140827.1503359-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5777620024
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: eixr5h4zgocqe49wscm3k89e96k1p7na
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19lClX5jgKm3XksJ6r3heTujnb7dmwFJG4=
X-HE-Tag: 1647187757-8038
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-03-13 at 07:08 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A memory allocation has overhead.  When a
> small allocation is made the overhead dominates.
> By combining the fixed sized small allocations
> with others, the memory usage can be reduced
> by eliminating the overhead of the small allocs.

This will generate false positives as small allocs are
sometimes required for usb dma.

How many of these "small allocs" _could_ be combined and under
what circumstance?

Can you show me a current example in the kernel where this
is useful?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7076,6 +7076,12 @@ sub process {
>  			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
>  		}
>  
> +# check for small allocs
> +		if ($line =~ /\b(?:kv|k|v)[zm]alloc\s*\(\s*(\d|sizeof\s*\([su](8|16|32)s*\))\s*,/) {
> +			WARN("SMALL_ALLOC",
> +			     "Small allocs should be combined\n" . $herecurr);
> +		}
> +

Couple more comments:

Anyone using vmalloc variants for a small alloc is confused.
What defines "small"?
Why would a single decimal like 8 be small, but say 16 would not be?

checkpatch has a couple of regexes that could be useful here

Maybe instead of sizeof(your regex) use

	sizeof\s*\(\s*(?:\d|$C90_int_types|$typeTypedefs)\s*,

as that will find more "small" uses of individual types like
"unsigned long", __s32, u_int_16, etc...



