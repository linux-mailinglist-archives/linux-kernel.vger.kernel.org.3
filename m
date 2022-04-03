Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7174F0863
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355499AbiDCIHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiDCIHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700637AB5;
        Sun,  3 Apr 2022 01:05:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3636B80AC3;
        Sun,  3 Apr 2022 08:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D52C340F3;
        Sun,  3 Apr 2022 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648973141;
        bh=opLcU29acddtyzVufVbpjteyPfDjI2D8KSG2MV5cu5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=itvPRJ+VsbzbyFqRiaYrWg4A/np9jYWjHGsUZkd7IZ1bFsDvbIaqgV/6ZYJh09DHr
         RKIIdttb6Zs3cS9BHYUy2REpwnJlaOxpK+QtNLTA7zgivUGx3B+tqpoBJHhyFBR/Bs
         7AeWRX4HyXdLXoKhupHVFPTC+hwE0dX5ZSkslS2cMcgNjGhEdLBkFeEE98JxkNItIl
         K/nDVyxJgiHVXljkdpOIvNi4OMcEbNiDOANdRcSRJmyzox/OKLDI+qHYvlDevKIaMc
         PBU7FhdbZU6j7cONoag7C9SHZxjzY5A2G1bcvjSRTGanHnQsCFQtEoeSwtijirtzWK
         ni6ogFRjzI0og==
Date:   Sun, 3 Apr 2022 11:06:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Michal Orzel <michalorzel.eng@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 3/5] keys: Remove redundant assignments
Message-ID: <YklVm5HRM789++rp@kernel.org>
References: <20220331173358.40939-1-michalorzel.eng@gmail.com>
 <20220331173358.40939-3-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331173358.40939-3-michalorzel.eng@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:33:56PM +0200, Michal Orzel wrote:
> Get rid of redundant assignments which end up in values not being
> read either because they are overwritten or the function ends.
> 
> Reported by clang-tidy [deadcode.DeadStores]
> 
> Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
> ---
>  security/keys/process_keys.c | 1 -
>  security/keys/request_key.c  | 6 ++----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index b5d5333ab330..8bdd6410f79a 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -92,7 +92,6 @@ int look_up_user_keyrings(struct key **_user_keyring,
>  		return PTR_ERR(reg_keyring);
>  
>  	down_write(&user_ns->keyring_sem);
> -	ret = 0;
>  
>  	/* Get the user keyring.  Note that there may be one in existence
>  	 * already as it may have been pinned by a session, but the user_struct
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index 2da4404276f0..ad29023c9518 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -116,7 +116,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
>  {
>  	static char const request_key[] = "/sbin/request-key";
>  	struct request_key_auth *rka = get_request_key_auth(authkey);
> -	const struct cred *cred = current_cred();
> +	const struct cred *cred;
>  	key_serial_t prkey, sskey;
>  	struct key *key = rka->target_key, *keyring, *session, *user_session;
>  	char *argv[9], *envp[3], uid_str[12], gid_str[12];
> @@ -506,9 +506,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
>  			kdebug("cons failed");
>  			goto construction_failed;
>  		}
> -	} else if (ret == -EINPROGRESS) {
> -		ret = 0;
> -	} else {
> +	} else if (ret != -EINPROGRESS) {
>  		goto error_put_dest_keyring;
>  	}
>  
> -- 
> 2.25.1
> 


Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

David: can you pick this?

BR, Jarkko
