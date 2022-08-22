Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564F859C11A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiHVN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiHVN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:57:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476B339BB1;
        Mon, 22 Aug 2022 06:57:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1065200FF;
        Mon, 22 Aug 2022 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661176649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71TnH4RT2fUjEqj3RkfsczNh1UmPe/8C6pOyd7oEEzY=;
        b=ZGnh1FJ24HiH7e7/hF84/We3t9g6ffYpRd/fECYXHWNFXOojCviOBbyyp8AeQOaYsg9da/
        yz0Nop53/MaYXbVtVOf+u85KORvmW0fdPdigcwUEM/Cj9ksgxHOuUyS3GAQV9VQvKqPL9r
        kTUlRX3fwfIYK18DFr41vKQ8+OJwS28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661176649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71TnH4RT2fUjEqj3RkfsczNh1UmPe/8C6pOyd7oEEzY=;
        b=2H2Z4+GKLOxYkcpgHnPG0oNfHaf5L5SmPDwfMtbdTgFPameQGF7uURicuHi5hDDTdpr2L6
        ZAtu6d0JiJ+HyrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE47413523;
        Mon, 22 Aug 2022 13:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xg/zKEmLA2M5cAAAMHmgww
        (envelope-from <ddiss@suse.de>); Mon, 22 Aug 2022 13:57:29 +0000
Date:   Mon, 22 Aug 2022 15:57:34 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Stanislav Goriainov <goriainov@ispras.ru>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] ovl: Fix potential memory leak
Message-ID: <20220822155734.0a188325@echidna.suse.de>
In-Reply-To: <20220822115257.7457-1-goriainov@ispras.ru>
References: <20220822115257.7457-1-goriainov@ispras.ru>
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

On Mon, 22 Aug 2022 14:52:57 +0300, Stanislav Goriainov wrote:

> ovl: Fix potential memory leak in ovl_lookup()
> 
> If memory for uperredirect was allocated with kstrdup()
> in upperdir != NULL and d.redirect != NULL path,
> it may be lost when upperredirect is reassigned later.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Stanislav Goriainov <goriainov@ispras.ru>
> ---
>  fs/overlayfs/namei.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index 69dc577974f8..226c69812379 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -1085,6 +1085,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
>  			.mnt = ovl_upper_mnt(ofs),
>  		};
>  
> +		kfree(upperredirect);
>  		upperredirect = ovl_get_redirect_xattr(ofs, &upperpath, 0);
>  		if (IS_ERR(upperredirect)) {
>  			err = PTR_ERR(upperredirect);

This probably deserves a:
Fixes: 0a2d0d3f2f291 ("ovl: Check redirect on index as well")

Looks fine otherwise.
Reviewed-by: David Disseldorp <ddiss@suse.de>
