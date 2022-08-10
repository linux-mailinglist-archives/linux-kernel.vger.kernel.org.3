Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C873258F034
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiHJQRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiHJQRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:17:15 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30967163
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:17:14 -0700 (PDT)
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id D97111FA5;
        Wed, 10 Aug 2022 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1660148140;
        bh=TS+7ykxS+/RbIUIrMkBZtw+JsrC7IJjJ/ehW21gIdRc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Sni8K2LkW8vrm0wv1vYyOcqiGezy0wbf8/S+RUDwWLMacS8KaZWVYYPzdixnrgOlA
         4t+etfNF7yD93OTw9nvuGnWKrirZ6H4zXaKfWEm5aDEvs0yFwSIacyP2cyY9BfVpnO
         KL2hweUpBdBDtiv6EBkfeUiPNkVp7djmfQbXPk/s=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 10 Aug 2022 19:17:12 +0300
Message-ID: <8a3b479b-dedc-2a73-32fa-5c0440048b7d@paragon-software.com>
Date:   Wed, 10 Aug 2022 19:17:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] fs/ntfs3: Remove unused function wnd_bits
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220721031841.24571-1-jiapeng.chong@linux.alibaba.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
In-Reply-To: <20220721031841.24571-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/22 06:18, Jiapeng Chong wrote:
> Since the function wnd_bits is defined but not called in any file, it is
> a useless function, and we delete it in view of the brevity of the code.
> 
> Remove some warnings found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> 
> fs/ntfs3/bitmap.c:54:19: warning: unused function 'wnd_bits' [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   fs/ntfs3/bitmap.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
> index e3b5680fd516..177c5bc53373 100644
> --- a/fs/ntfs3/bitmap.c
> +++ b/fs/ntfs3/bitmap.c
> @@ -51,11 +51,6 @@ void ntfs3_exit_bitmap(void)
>   	kmem_cache_destroy(ntfs_enode_cachep);
>   }
>   
> -static inline u32 wnd_bits(const struct wnd_bitmap *wnd, size_t i)
> -{
> -	return i + 1 == wnd->nwnd ? wnd->bits_last : wnd->sb->s_blocksize * 8;
> -}
> -
>   /*
>    * wnd_scan
>    *

Applied, thanks!
