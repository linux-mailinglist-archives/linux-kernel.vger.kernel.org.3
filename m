Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7097852D754
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbiESPVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239671AbiESPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:21:40 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F315D5CA;
        Thu, 19 May 2022 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652973694;
        bh=+Y4Z/IQnsX+fk6BLy3bmRjeDws9K8BNXDaa4PLSicwE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CDDuUvSeEW8eoY/l1jUVBZDU5GW3iacxJYIinJeOcJ4/kPftj2I5X6NX3GZOQx+wI
         187SwPpR9pY3jCBnUZghj7XYbX8IGG9AaDtg5aw1qqjbIUfYcY62KwYLPdwSHJNnTR
         NSqkP+MbKvktxDR7NjsOmZmGtavowmw6qws2zC8A=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C92F41280B05;
        Thu, 19 May 2022 11:21:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LrKi1AHY0ytP; Thu, 19 May 2022 11:21:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1652973694;
        bh=+Y4Z/IQnsX+fk6BLy3bmRjeDws9K8BNXDaa4PLSicwE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=CDDuUvSeEW8eoY/l1jUVBZDU5GW3iacxJYIinJeOcJ4/kPftj2I5X6NX3GZOQx+wI
         187SwPpR9pY3jCBnUZghj7XYbX8IGG9AaDtg5aw1qqjbIUfYcY62KwYLPdwSHJNnTR
         NSqkP+MbKvktxDR7NjsOmZmGtavowmw6qws2zC8A=
Received: from [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b] (unknown [IPv6:2601:5c4:4300:c551:a71:90ff:fec2:f05b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9407D128096F;
        Thu, 19 May 2022 11:21:33 -0400 (EDT)
Message-ID: <953c45678dc4b59e9e5de0e5c228e2e8a8ac558a.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] sign-file: Convert API usage to support OpenSSL v3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        keyrings@vger.kernel.org, Adam Langley <agl@google.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Thu, 19 May 2022 11:21:32 -0400
In-Reply-To: <20220518215129.264872-1-keescook@chromium.org>
References: <20220518215129.264872-1-keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-18 at 14:51 -0700, Kees Cook wrote:
> OpenSSL's ENGINE API is deprecated in OpenSSL v3.0, along with some
> other functions. Remove the ENGINE use and a macro work-around for
> ERR_get_error_line().

What answer was there to Eric Biggers' concern about token support in
sign-file?

https://lore.kernel.org/lkml/YVyKc51r2tfMmQuO@gmail.com/

If you're not doing ephemeral keys (as quite a few kernel builder's
aren't) you really need a token to protect the signing key.

The other point was that openssl3 hasn't converted most of its own
engine code to the provider API, so the deprecation is a bit premature
because it will be a while before provider based token libraries
appear.  If the goal is simply to not see the warnings, the compile
flag you need is

-DOPENSSL_API_COMPAT=0x10100000L

James


