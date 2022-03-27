Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183734E864A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 08:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiC0Ghs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 02:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiC0Ghp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 02:37:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7373CFC3;
        Sat, 26 Mar 2022 23:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=d3KR8Rc1AINo2B0ZxpxbVflKal9A0i+al9XwlVMQf3o=; b=lK+UVv7psfLbi4Im3IoW2Sol5P
        NoY7DmHxcEFGg9K3QDtqIMJISBPhy8xMwSDNt4zmqO20Ekt99GgCABz6oTBh3LTKLR5GPv7wHDLau
        rnDJNeR4woSz98h43jSLziTB7UuWDzEzKzTNXMuitH++eMVyshozrh6T/86O4UKiQCndhFqGdSh2F
        tUqwxt4UbuGpmpa62OqOuUevh+tutlsi1x20+UHchk1mc6jL9Vre70/JnQJgSQSw74326xoWT2b6w
        FblmaIYThU2TjnJ3EljSwRP1+Uga97CioOIfY7tGtTnHUal48hI3sLZP/hBgSPavoWP3aONzLyLBQ
        4qVPykwQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYMVQ-004zWY-Iv; Sun, 27 Mar 2022 06:36:05 +0000
Message-ID: <129d2cd4-729a-8b7f-a536-fae6b8758cec@infradead.org>
Date:   Sat, 26 Mar 2022 23:35:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] keys: remove __user annotation from function prototype
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org
References: <20220122201516.13547-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220122201516.13547-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.

On 1/22/22 12:15, Randy Dunlap wrote:
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
> ---
>  security/keys/keyring.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20220121.orig/security/keys/keyring.c
> +++ linux-next-20220121/security/keys/keyring.c
> @@ -79,7 +79,7 @@ static void keyring_revoke(struct key *k
>  static void keyring_destroy(struct key *keyring);
>  static void keyring_describe(const struct key *keyring, struct seq_file *m);
>  static long keyring_read(const struct key *keyring,
> -			 char __user *buffer, size_t buflen);
> +			 char *buffer, size_t buflen);
>  
>  struct key_type key_type_keyring = {
>  	.name		= "keyring",

-- 
~Randy
