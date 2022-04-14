Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7430A50068D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbiDNHIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiDNHIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:08:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB83A72D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ae9LbWo+RjgLEmtT+cEXYBgVvEkOVOVVV7WuO2O+Th0=; b=bBSETPTr1w6G0qfAtJ1VsVh8ql
        yqlAj2eCvjzb1zEv5Pizl8PGW3GqtkuVe/3AhmUW6+lszTAnVF+SEsRNJ7MkkxppiEzFEdWLWTMSl
        loIdFb4gICdMbBwusUnrgjlFYpPxPW8Kv/p3cBaXaSnecStbB6kIW+QIh290XM9Kj96JD5F9vfxhB
        mPp2Mc3vnR0mRVv7ClovW9uLCwdRmUH7JMKRI/SBjIIYyC36dzcmUJuQhfIb6JaOk+UUGxpTWdG8t
        iFdYaLFg8UpplVT17h260paBQh017ozzIzxcQQd5azi2z2wO8MsJFuZI1cdS1wjJwfMbM0RYt6p9b
        dGrlIMDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1netY6-004wIn-Bg; Thu, 14 Apr 2022 07:05:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 028E63001AE;
        Thu, 14 Apr 2022 09:05:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3899313544F1; Thu, 14 Apr 2022 09:05:47 +0200 (CEST)
Date:   Thu, 14 Apr 2022 09:05:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 02/18] objtool: Support data symbol printing
Message-ID: <YlfHy011VP2oPFjV@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097057f88605aa67b0e3ec573fcf394ae7ac4d6f.1649891421.git.jpoimboe@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:19:37PM -0700, Josh Poimboeuf wrote:

> @@ -34,8 +37,8 @@ static inline char *offstr(struct section *sec, unsigned long offset)
>  
>  	str = malloc(strlen(name) + 20);
>  
> -	if (func)
> -		sprintf(str, "%s()+0x%lx", name, name_off);
> +	if (sym)
> +		sprintf(str, "%s%s+0x%lx", name, is_text ? "()" : "", name_off);
>  	else
>  		sprintf(str, "%s+0x%lx", name, name_off);

So I like the patch, except that "()" thing is something where we differ
from the kernel's %ps format and I've cursed it a number of times
because I then have to manually edit (iow remove) things when pasting it
in various scripts etc..

That said, it totally makes sense to differentiate between a text and
data symbol this way :/
