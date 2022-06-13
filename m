Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47623547E90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 06:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiFMEZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 00:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiFMEZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 00:25:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F35FA6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GhvwGtANvQuSTVMPqK7IxNnDhsY33Zq7Pk8pkhDCiJU=; b=YgceE5qD9fGWZa50WxH4nVDPhe
        fwjFxU49mvChJnWW4wrdwRRXEfJi2HwtXiLgK1k0HzYiJYwZZI9KuwdXOFX21Rfeypb51tsWcjEbL
        XY2Kv4IrcJFH9XBsLgqqf425IoJ7JzdGQr6DYASiQgT8PD0P3psj0KTvi/Mpfx8Fe+snctwyGB7lg
        +7XUwFLM8TzuBW+yFjV3bRywZcY/KTYBYFf4U9c6IZ/oIAr19xhLhrH6K8YSMozAb7EB7/xQNEuKE
        E1SLpS78NgZyGwIofPEQYg6HHnziyxoIcjSl54pegWdq7BpPHMUWWOxXvdVi0RML4H6ev6cBxGbaR
        iVGx7AyQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0bdz-006cYj-Hj; Mon, 13 Jun 2022 04:25:39 +0000
Date:   Mon, 13 Jun 2022 04:25:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Joe Damato <jdamato@fastly.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC,iov_iter v2 3/8] iov_iter: add copyin_iovec helper
Message-ID: <Yqa8Q7O0Fmnex8Ev@zeniv-ca.linux.org.uk>
References: <1655024280-23827-1-git-send-email-jdamato@fastly.com>
 <1655024280-23827-4-git-send-email-jdamato@fastly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655024280-23827-4-git-send-email-jdamato@fastly.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2022 at 01:57:52AM -0700, Joe Damato wrote:
> copyin_iovec is a helper which wraps copyin and selects the right copy
> method based on the iter_copy_type.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  lib/iov_iter.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index d32d7e5..6720cb2 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -168,6 +168,15 @@ static int copyin(void *to, const void __user *from, size_t n)
>  	return n;
>  }
>  
> +static int copyin_iovec(void *to, const void __user *from, size_t n,
> +			struct iov_iter *i)
> +{
> +	if (unlikely(iov_iter_copy_is_nt(i)))
> +		return __copy_from_user_nocache(to, from, n);
> +	else
> +		return copyin(to, from, n);
> +}

Just a sanity check - your testing is *not* with KASAN/KCSAN, right?

And BTW, why is that only on the userland side?  If you are doing
that at all, it would make sense to cover the memcpy() side as
well...
