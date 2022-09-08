Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790B95B13D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIHFJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIHFI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:08:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C2C92F55;
        Wed,  7 Sep 2022 22:08:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 198D761B10;
        Thu,  8 Sep 2022 05:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1315CC433C1;
        Thu,  8 Sep 2022 05:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662613737;
        bh=QsZjgBJZJF19qwvAwR531aY4+u0JK0AQgWq2N0eYle4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPVxZnsK0w3qoAmhBJq9Fqt1PaphkFN+MrdHkyRUHvmHY5bU0bY0guGSSvI7UDonC
         XSJrcqUIcH0btVB8msSmTF4cllbLffmD37XJselbSFSuipN/u0RFo17CjzC6dtXVpB
         GzrFRs5+88GQkyB4ix7cdQ8Llnbg3pEtvM+JyzoF8y++uc7uwHVbj25SGlSpvXk32S
         2d8iyZisnR8e+uYxtRZHEt8FieXE0TlygqWItyDl9t29JVVpZztqdM7e9EfPfXCTJz
         LvLNIlrj0mCtWQ7yxTwzmXq6xFtlaegHlIlBQdMVDu2cjSkJXZScWj3c0fOcQm9AHB
         bo8upoWe+l7Xw==
Date:   Thu, 8 Sep 2022 08:08:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH] security/keys: Remove inconsistent __user annotation
Message-ID: <Yxl447f+lYtKjyJb@kernel.org>
References: <20220907121230.21252-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907121230.21252-1-vincenzo.frascino@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 01:12:30PM +0100, Vincenzo Frascino wrote:
> The declaration of keyring_read does not match the definition
> (security/keys/keyring.c). In this case the definition is correct
> because it matches what defined in "struct key_type::read"
> (linux/key-type.h).
> 
> Fix the declaration removing the inconsistent __user annotation.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
> Note: This issue was discovered during the porting of the linux kernel
> on Morello [1].
> 
> [1] https://git.morello-project.org/morello/kernel/linux
> 
>  security/keys/keyring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5e6a90760753..4448758f643a 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -79,7 +79,7 @@ static void keyring_revoke(struct key *keyring);
>  static void keyring_destroy(struct key *keyring);
>  static void keyring_describe(const struct key *keyring, struct seq_file *m);
>  static long keyring_read(const struct key *keyring,
> -			 char __user *buffer, size_t buflen);
> +			 char *buffer, size_t buflen);
>  
>  struct key_type key_type_keyring = {
>  	.name		= "keyring",
> -- 
> 2.37.3
> 

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
