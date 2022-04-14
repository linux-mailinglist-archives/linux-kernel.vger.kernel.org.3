Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ED4500CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiDNMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiDNMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:09:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DC51DA58;
        Thu, 14 Apr 2022 05:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 600206163B;
        Thu, 14 Apr 2022 12:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7A1C385A5;
        Thu, 14 Apr 2022 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938002;
        bh=qFfEbid8LWyjCwhjnpS76Z2p0jd43Ov/ADIyhc6xcVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgU2eOCYycgZIyeybAPmWunIF82xCCEGRFouV1+nugY3S7bk0xO5w9FfiEzxbM4ix
         DbXvzqwe/jCTS30VeMjT4ldNzJ1zUWmJXkPlHx4iuo0zkoHXWp75ADcxhKArgJG29q
         Qek46lLqVkVJd0JUwgzxLRg8SGc5cd29+B7WdoR9pp6+NhIOsj5jSviGtJ9x8/xflA
         34lZd3xG/CmLLdIV5mAaGvl8xSjK/yY1LSh83aI3O3LiHVDDR4VuUAHL8Od37Pl8Dj
         F926i3whtulzfw6wQfV09vgjpg1CA9HZlFr4XFUA2L5obDzaCTKIZ2IPF4hGDv1ClY
         YAYy7s7QlLLrA==
Date:   Thu, 14 Apr 2022 15:05:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] keys: remove __user annotation from function prototype
Message-ID: <YlgODY1MIQU9W11A@kernel.org>
References: <20220406014453.32091-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406014453.32091-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 06:44:53PM -0700, Randy Dunlap wrote:
> Remove a missed __user annotation from the prototype for
> keyring_read(). This cures a sparse warning when it complains about
> the difference in the prototype and the function definition.
> 
> security/keys/keyring.c:481:13: sparse:    long static [signed] [toplevel] keyring_read( ... )
> security/keys/keyring.c:81:13: sparse:    long static [addressable] [signed] [toplevel] keyring_read( ... )
> 
> Fixes: 796e46f9e2cb ("keys: Remove outdated __user annotations").
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: keyrings@vger.kernel.org
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> ---
> v2: rebase/resend; add more Cc:s
> 
>  security/keys/keyring.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -79,7 +79,7 @@ static void keyring_revoke(struct key *k
>  static void keyring_destroy(struct key *keyring);
>  static void keyring_describe(const struct key *keyring, struct seq_file *m);
>  static long keyring_read(const struct key *keyring,
> -			 char __user *buffer, size_t buflen);
> +			 char *buffer, size_t buflen);
>  
>  struct key_type key_type_keyring = {
>  	.name		= "keyring",

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

David, can you pick this?

BR, Jarkko
