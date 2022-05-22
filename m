Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DE6530612
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbiEVVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiEVVJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:09:18 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2AA1C13F;
        Sun, 22 May 2022 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=2Jd8D6LlVwyQIF5MhwULEnlbv5yF/fdM6oUbi3IJ0cw=; b=3iGTtByKIRA7QyvS4dd4AshWPX
        1BC4lTnpddbu2zGBwNdw09nGQvmUNNJhuWqzavPYKh3K1r9tdFXG9hJ5WpToeBg2FIexobk3+TJmV
        HL8a40cW8UorB6vX8Cwfm8+Ir857J7zE0sRIsL2cJB9JCj9iH27aD4xPc5T1W0QsBEP1nbl7rIk9P
        hjbEHT1njK2K01moXaSkSp4SCTlOZVahdfDm5alJL8O7LPdYsj5aPdo7U4ZY1fj+kWp4y/6zBnYul
        JuaCgWoZ8FLsJK1EKYC6TE/MffJHSpl9HzIEGe1cdvWQwTFt0m3EDaU/PHlQPwzG2nB1ym6txQQp2
        buzRIWz22Y1kLR9gvMqi30r3PubKKu1la/gaoeALsa8kQvp6WASVOzEEZjwYoBgjfzrK+mm13Q9SD
        WGRPULme67H0md10yj6jl/VUqraZZZILLDSbUjWzgvsB6+kwxGQnwW0hv2YU4wghhehjLpGWC0exC
        Hctnre+3BLlvv7nyEWyvrXOj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1nssp7-0022cK-HA; Sun, 22 May 2022 21:09:13 +0000
Message-ID: <679693c4-8c4c-85b0-e4f2-7f34be3bad12@samba.org>
Date:   Sun, 22 May 2022 16:09:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH -next] cifs: Return true/false (not 1/0) from bool
 functions
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220504130634.101239-1-yang.lee@linux.alibaba.com>
From:   Steven French <sfrench@samba.org>
In-Reply-To: <20220504130634.101239-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you remember which patch caused this? Perhaps one of Dave Howell's 
iov_iter cifs patches that was temporarily in for-next? I don't see it 
anymore

On 5/4/22 08:06, Yang Li wrote:
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> functions. This fixes the following warnings from coccicheck:
>
> ./fs/cifs/file.c:4764:9-10: WARNING: return of 0/1 in function
> cifs_release_folio() with return type bool
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   fs/cifs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 580a847aa8b5..a9123cefd84f 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -4761,7 +4761,7 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
>   static bool cifs_release_folio(struct folio *folio, gfp_t gfp)
>   {
>   	if (folio_test_private(folio))
> -		return 0;
> +		return false;
>   	if (folio_test_fscache(folio)) {
>   		if (current_is_kswapd() || !(gfp & __GFP_FS))
>   			return false;
