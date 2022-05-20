Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865852E2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbiETDBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiETDBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:01:15 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE8254BF2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8/KSrrkS71qCzWEpdPtjhelKr+xhsmEdogCE37/L13g=; b=SBIeb/nfGNhn3VenDx7+zdOsIn
        PN9sQ/ZHPnEoq4yAHzcdzMlLqTCXZKROHcp4zoKaLVySav93kNTuGc23cEnndnyAOpJt5xO/lZoPM
        0Qj/x/BVy/q+R9/zcao8WRY9Ugv3+niCQu/D8TvL1WK/5/qJGqk1U7xlsrOBTJMGBSbHExnlRJlkk
        plHzVOr0uLt+oVB3cJJawt/TocwXJkc0D2wr5ykaF2QuU1nhwQ2KuqwYLJMD/QFbcZffIhBqXYxo8
        Q2fxfiaD5rsIbKklseTtOS5DxoUCFBggl0RofHQwjORzXVeVsnZk5DaOA82emNUNVHAmq5AyB8+td
        cKB7aQuw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrst3-00GTso-Ip; Fri, 20 May 2022 03:01:09 +0000
Date:   Fri, 20 May 2022 03:01:09 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Message-ID: <YocEddeThi8VUcKb@zeniv-ca.linux.org.uk>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 05:43:15PM -0600, Jens Axboe wrote:

> -static int write_pool(const char __user *ubuf, size_t len)
> +static size_t write_pool(struct iov_iter *iter)
>  {
>  	size_t block_len;
>  	int ret = 0;
>  
> -	while (len) {
> -		block_len = min(len, sizeof(block));
> -		if (copy_from_user(block, ubuf, block_len)) {
> -			ret = -EFAULT;
> +	while (iov_iter_count(iter)) {
> +		block_len = min(iov_iter_count(iter), sizeof(block));
> +		if (!copy_from_iter(block, block_len, iter)) {
> +			if (!ret)
> +				ret = -EFAULT;
>  			goto out;
>  		}

Feed it a buffer with only 1 byte mapped, watch it'll pass to mix_pool_bytes().
And see how much of 'block' has been used uninitialized...

And why bother with that min thing, anyway?

	ssize_t ret = 0;

	while (iov_iter_count(iter)) {
	  	u8 block[BLAKE2S_BLOCK_SIZE];
		size_t copied = copy_from_iter(block, sizeof(block), iter);
		if (!copied) {
			if (!ret)
				ret = -EFAULT;
			break;
		}
		mix_pool_bytes(block, copied);
		ret += copied;
	}
	return ret;

and be done with that...

> @@ -1382,11 +1378,16 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>  			return -EINVAL;
>  		if (get_user(size, p++))
>  			return -EFAULT;
> -		retval = write_pool((const char __user *)p, size);
> +
> +		iov.iov_base = p;
> +		iov.iov_len = size;
> +		iov_iter_init(&iter, WRITE, &iov, 1, size);

That'd be
		import_single_range(WRITE, p, size, &iov, &iter);
