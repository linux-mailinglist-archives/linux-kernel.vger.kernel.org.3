Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5654EA1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbiC1UuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbiC1UtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:49:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48069AE6A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:47:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 05AD81F85F;
        Mon, 28 Mar 2022 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648500438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIw0OaLe72Ajmxvq86IY/8SlfSXIJSuwPuKfK90ooC4=;
        b=KcGQja8aDu7NcEzQnovhw1pzuuefLyTKxDTzB3aylvRZx9bwyoWB1LCeGFAyVg7H5Pj1su
        qdYWIqg2ntvFfQ7mU0QryoMZ7by2M3mrtoCPZ1YS3/sw9s3M3MGZuJGR+gRgM+dNArfG1X
        k8RiVrDYrLVX8LSiNgSxfH7xRRT/hGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648500438;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIw0OaLe72Ajmxvq86IY/8SlfSXIJSuwPuKfK90ooC4=;
        b=j3WtelO1H7oyKji/Ywki1QlL+4Jk0GfxNZLa4NhX3xgyum7J7Hk4hbh1Ia6PIhuwIA0E27
        5HMkW7jFI9b81SCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7DD01332D;
        Mon, 28 Mar 2022 20:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LdABLtUeQmJsUwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 28 Mar 2022 20:47:17 +0000
Date:   Mon, 28 Mar 2022 22:47:16 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Cyril Hrubis <chrubis@suse.cz>,
        Andrea Cervesato <andrea.cervesato@suse.de>
Subject: Re: [PATCH v2 1/1] lib: Retry safe_clone() on ENOSPC|EUSERS
Message-ID: <YkIe1Kr0w2vXUQuN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220328204554.2528-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328204554.2528-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, wrong list, sorry.

Kind regards,
Petr

> In some tests we are creating the namespaces faster than they are being
> asynchronously cleaned up in the kernel:

> $ sudo ./userns08 -i 10
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:65: TPASS: Denied write access to ./restricted : EACCES (13)
> userns08.c:36: TBROK: clone3 failed: ENOSPC (28)

> Thus retrying the clone() on ENOSPC (or EUSERS for kernel < 4.9).

> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * use TST_RETRY_FN_EXP_BACKOFF() (Cyril)

> NOTE: 0.1s seems to be safe, although using TST_RETRY_FUNC() with 1s
> (the default) would be of course OK.

> Kind regards,
> Petr

>  lib/tst_test.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 384c73e163..2e89d954ec 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -436,6 +436,9 @@ pid_t safe_fork(const char *filename, unsigned int lineno)
>  	return pid;
>  }

> +/* too fast creating namespaces => retrying */
> +#define TST_CHECK_ENOSPC(x) ((x) >= 0 || !(errno == ENOSPC || errno == EUSERS))
> +
>  pid_t safe_clone(const char *file, const int lineno,
>  		 const struct tst_clone_args *args)
>  {
> @@ -444,7 +447,7 @@ pid_t safe_clone(const char *file, const int lineno,
>  	if (!tst_test->forks_child)
>  		tst_brk(TBROK, "test.forks_child must be set!");

> -	pid = tst_clone(args);
> +	pid = TST_RETRY_FN_EXP_BACKOFF(tst_clone(args), TST_CHECK_ENOSPC, 0.1);

>  	switch (pid) {
>  	case -1:
