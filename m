Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B65915C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiHLTGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237856AbiHLTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:06:36 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D84183F2C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:06:35 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1B4571C000B; Fri, 12 Aug 2022 21:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1660331193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QJgRfvIpZnynJdWuRXNSUiG+jDqoYFliXMFXCfhwRU=;
        b=HeMLp/tr+Zr1tt3v59W9Z8SpAd/dUIWX0QQ7Te8bWFamWrkcVk1dsN4u6Mj/grGp+kEGzO
        vCLqQ5uVPqBZgoyHxIuiZvKExbfFY7WTXjZ/ORf9iNrkYYEKKoILx90f/aJM2Ur74UiaXU
        k4aSOA8NiAI4SnQaMqpOVbU/kiwsxWQ=
Date:   Fri, 12 Aug 2022 21:06:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Yu-Jen Chang <arthurchang09@gmail.com>
Cc:     andy@kernel.org, akinobu.mita@gmail.com, jserv@ccns.ncku.edu.tw,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Optimize memchr()
Message-ID: <20220812190631.GA1347@bug>
References: <20220710142822.52539-1-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220710142822.52539-1-arthurchang09@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patche series optimized "memchr()" and add a macro for 
> "memchr_inv()" so that both funtions can use it to generate bit mask.
> 
> The original implementaion of "memchr()" is based on byte-wise comparison,
> which do not fully use 64-bit or 32-bit register in CPU. We implement a
> word-wise comparison so that at least 4 bytes can be compared at the same
> time. The optimized "memchr()" is nearly 4x faster than the original one
> for long strings. In Linux Kernel, we find that the length of the string

Well... how much slower is it for short strings?

> searched by "memchr()" is up to 512 bytes in drivers/misc/lkdtm/heap.c.
> In our test, the optimized version is about 20% faster if the target
> character is at the end of the string when going through a 512-byte
> string.

"What is the average length passed to memchr" would be more useful question.

Best regards,
								Pavel
