Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04224520840
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiEIXRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiEIXRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:17:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7C2A4705;
        Mon,  9 May 2022 16:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66ACD61205;
        Mon,  9 May 2022 23:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824D8C385B3;
        Mon,  9 May 2022 23:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652138030;
        bh=4dK3VfombzihJEhoOsxtQumd0/18NJxcFNS6Q1FILXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s68VrmMb9I42RgQylAe6I2UHS7PbVefvxqYqUkTdxAbwRmUBGYlm88kQbjP4p5B93
         bu840ucdXrrL/UB/LypRKnlEd1pSUCiJMw9a7nrt+ewBckJGkg6yR+GUntXl3SEs9E
         GzbxrEg6cgx+pZVVelj4mLIbvyNxtYO4hO7u106EojHs9TMtnJs4N4flPCGgEC72VR
         HCkj0dYSvb0rhS3L/OwOKJ+6r5QirqzJnp7fDgGwV+U6tb0cmBFBhtOwQHQokgU3rW
         G9azWrWdfiVno9MlDqELZGU1cURr1KbN8tYcGDWuK5kUdd6jL0tRT3aGdUKiLe+/Sc
         d9AvZWFfXbj6g==
Date:   Mon, 9 May 2022 16:13:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] big_keys: Use struct for internal payload
Message-ID: <YnmgLLcJfPRKEYuk@sol.localdomain>
References: <20220508175732.2693426-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508175732.2693426-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 10:57:31AM -0700, Kees Cook wrote:
> The randstruct GCC plugin gets upset when it sees struct path (which is
> randomized) being assigned from a "void *" (which it cannot type-check).
> 
> There's no need for these casts, as the entire internal payload use is
> following a normal struct layout. Convert the enum-based void * offset
> dereferencing to the new big_key_payload struct. No meaningful machine
> code changes result after this change, and source readability is improved.
> 
> Drop the randstruct exception now that there is no "confusing" cross-type
> assignment.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c |  2 -
>  security/keys/big_key.c                       | 64 ++++++++++---------
>  2 files changed, 34 insertions(+), 32 deletions(-)

This looks fine to me, although the way that an array of void pointers is cast
to/from another struct is still weird.  I'd prefer if the payload was just
changed into a separate allocation.

A couple nits below if you stay with your proposed solution:

>  void big_key_free_preparse(struct key_preparsed_payload *prep)
>  {
> +	struct big_key_payload *payload = to_big_key_payload(prep->payload);
> +
>  	if (prep->datalen > BIG_KEY_FILE_THRESHOLD) {
> -		struct path *path = (struct path *)&prep->payload.data[big_key_path];
> +		struct path *path = &payload->path;
>  
>  		path_put(path);
>  	}

This could just do:

	if (prep->datalen > BIG_KEY_FILE_THRESHOLD)
		path_put(&payload->path);

>  void big_key_destroy(struct key *key)
>  {
> -	size_t datalen = (size_t)key->payload.data[big_key_len];
> +	struct big_key_payload *payload = to_big_key_payload(key->payload);
>  
> -	if (datalen > BIG_KEY_FILE_THRESHOLD) {
> -		struct path *path = (struct path *)&key->payload.data[big_key_path];
> +	if (payload->length > BIG_KEY_FILE_THRESHOLD) {
> +		struct path *path = &payload->path;
>  
>  		path_put(path);
>  		path->mnt = NULL;
>  		path->dentry = NULL;
>  	}

And similarly:

	if (payload->length > BIG_KEY_FILE_THRESHOLD) {
		path_put(&payload->path);
		payload->path.mnt = NULL;
		payload->path.dentry = NULL;
	}

- Eric
