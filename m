Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F9D4E9BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240503AbiC1P6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241576AbiC1P63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:58:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CE4D252
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:56:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5A8CE210E5;
        Mon, 28 Mar 2022 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648483007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvUhOBKNVj4c+/wwCBVDfk5zh3g+G6cbljMgkZr/JXg=;
        b=Gk6funvwVOS9F2pjFvepF0BbtBDD9+CYVmazkONire6H4chuYzN5rTrFakHHW3B4LJJMqS
        pjhBcEDNowkSlM5gyj/qgS981XeEb2oXwlKlYvsX7mcMpmY7jER3H0Ei3FYIdcAJxbNHpJ
        gMqOOyLrl2Hn3QOJr3b78M3+KIaQb1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648483007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jvUhOBKNVj4c+/wwCBVDfk5zh3g+G6cbljMgkZr/JXg=;
        b=E8bT0r4i1ritJh3olW3zuQ80uaZrVLeU9beMfVv82fzvlXqO+n0YuYf675nxhQaH673frk
        8FOmixGHxOKhosCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E65A13B08;
        Mon, 28 Mar 2022 15:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9zUWE7/aQWI7WQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 28 Mar 2022 15:56:47 +0000
Date:   Mon, 28 Mar 2022 17:56:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RAS updates for 5.18
Message-ID: <YkHaveCqTPTmgGoO@zn.tnic>
References: <YjtZAvQnshp1pZIh@zn.tnic>
 <CAHk-=wgXbSa8yq8Dht8at+gxb_idnJ7X5qWZQWRBN4_CUPr=eQ@mail.gmail.com>
 <Yj4orVIbqcyTQcY7@zn.tnic>
 <87pmm69myo.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmm69myo.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 08:21:51AM -0600, Jonathan Corbet wrote:
> Maybe something that looks like:
> 
>   https://lore.kernel.org/lkml/87wnghd78t.fsf@meer.lwn.net/
> 
> :)

I was just about to scratch something together but it is a good thing
I got distracted by other stuff so that you'll document it a lot more
eloquently than me! :-)

A typo:

"So what is to be done? The best response when confronted with this
situation is to indeed to a merge,"

should be

"... to indeed *do* a merge, ..."

Other than that, very much

Acked-by: Borislav Petkov <bp@suse.de>

Thanks for doing that!

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
