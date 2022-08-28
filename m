Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489E5A3FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiH1VTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiH1VTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 17:19:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB8140BF
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:19:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5B18336D6;
        Sun, 28 Aug 2022 21:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661721555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOd4SF9+WxwSf+rmjgx2IXFrWkQjg4vdSqxMOkL2dFM=;
        b=ui33izMngA6n5b37T/VaGRz3aRpRfID4NGB0usWwvtGL82j3ynAVASwDAVuM6+dk1lJIQu
        7zIresaplELFhcQkEBvGlHcQaLuA1mb3pQqEO3ryXAjCJ0J63HL+yz077SPW08B7Dh9GgV
        ARKo4EC7VjIM9dxuqHOZF2JvD6SdVxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661721555;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rOd4SF9+WxwSf+rmjgx2IXFrWkQjg4vdSqxMOkL2dFM=;
        b=9Cnq3Iq0iMf9suhqU/WijDbCsBUgp0sQ/85MpdU/KrpLT+sDtbGfWQ/36zFrz5jxwQlYim
        0Fz8cEGschQNrUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DDD813A65;
        Sun, 28 Aug 2022 21:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 11FAGdPbC2P3RgAAMHmgww
        (envelope-from <ddiss@suse.de>); Sun, 28 Aug 2022 21:19:15 +0000
Date:   Sun, 28 Aug 2022 23:19:22 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     wuchi <wuchi.zero@gmail.com>
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org, mwilck@suse.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] initramfs: mask my_inptr as __initdata
Message-ID: <20220828231922.38d09ecd@echidna.suse.de>
In-Reply-To: <20220827071116.83078-1-wuchi.zero@gmail.com>
References: <20220827071116.83078-1-wuchi.zero@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Aug 2022 15:11:16 +0800, wuchi wrote:

> As my_inptr is only used in __init function unpack_to_rootfs(),
> mark it as __initdata to allow it be freed after boot.
> 
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> ---
>  init/initramfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index 18229cfe8906..2f5bfb7d7652 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -482,7 +482,7 @@ static long __init flush_buffer(void *bufv, unsigned long len)
>  	return origLen;
>  }
>  
> -static unsigned long my_inptr; /* index of next byte to be processed in inbuf */
> +static unsigned long my_inptr __initdata; /* index of next byte to be processed in inbuf */
>  
>  #include <linux/decompress/generic.h>
>  

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>
