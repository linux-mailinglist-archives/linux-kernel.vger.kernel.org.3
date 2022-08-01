Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7858641B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiHAGgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHAGgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:36:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C71260D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 23:36:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lx7gB7047z4x1L;
        Mon,  1 Aug 2022 16:36:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659335767;
        bh=KlQQmnUVuaEUxMMjUhKl86RMR9H7Qw3GkPi6RTcciHE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=K0yfJNKMDtGlkyfwvBU+udgax/uri2aoU+kEXhNAHZ42CoOwXoMMmmcxpM3wdTC2u
         OCICfqNBi2CJdP1vgtzvuc5z2BAkpyjInb8fXfcvhTxoJcDYcQI6YmZI4bfX4F+CLt
         S+/UYnC+BwGL/EwJfCU+wqzqMW8lSmqfbi11HkotBeLZlVKmOBpGKbsO8iaqdHeY2r
         HRuk9d9CVX9oZxih7icVm+Zwo+eer2UF83vEmxCuuUs6oZXhZSjUSWGAqVEBH7dUhb
         bWUS0G/YEeJFsqOFlNqt5Fj+9dgOzgcpW9YkRnOVqnXIpteL9cXP2h/+Zl3eeuTJOC
         cMp5leerQUymQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] macintosh:adb:recordmcount:use !E in
 conditional statements
In-Reply-To: <20220801022521.1594464-1-ye.xingchen@zte.com.cn>
References: <20220801022521.1594464-1-ye.xingchen@zte.com.cn>
Date:   Mon, 01 Aug 2022 16:36:06 +1000
Message-ID: <87edy0bhd5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com writes:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Use !E to replace the type of x == 0. This change is just to 
> simplify the code, no actual functional changes.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/macintosh/adb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The subject is wrong, why does it mention recordmcount?

But in general this is very old code which is best left alone unless
there's an actual bug, it doesn't need these sort of style refactorings
done to it IMO.

cheers

> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index 1bbb9ca08d40..368ab25db234 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -673,7 +673,7 @@ static int adb_open(struct inode *inode, struct file *file)
>  		goto out;
>  	}
>  	state = kmalloc(sizeof(struct adbdev_state), GFP_KERNEL);
> -	if (state == 0) {
> +	if (!state) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -- 
> 2.25.1
