Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B81500A45
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbiDNJtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242284AbiDNJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:48:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0964378041;
        Thu, 14 Apr 2022 02:44:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B29571F746;
        Thu, 14 Apr 2022 09:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649929482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bwHZBNR8Br/nOEGyo873hVJQ95GV5dktm7kZJEMdk4=;
        b=X+JA0g9IcMRaqODyc5U8DkQugxHOE/JNTAsZ9dJVA94UsJhuWs8Xj32yna1dpUX594UiJT
        WXG/MTOvT5r2oepjC0qgc8K5VUyMFioNqT4eaC+WR23b/Qmo7vm9B5MVUhZWMscvz13zk9
        NaumvZlpH4C8zWeNzoTgNkLQvw1XXqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649929482;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bwHZBNR8Br/nOEGyo873hVJQ95GV5dktm7kZJEMdk4=;
        b=Bo5pq9NGDk7G73e7w7H1M33GLzmegIkicaqGqS61UNy8hafougd/Oflt82ir7ip7saQxh5
        96HwsXupWRrzdtDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94C0C13A86;
        Thu, 14 Apr 2022 09:44:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GtykIgrtV2KTagAAMHmgww
        (envelope-from <jslaby@suse.cz>); Thu, 14 Apr 2022 09:44:42 +0000
Message-ID: <810ab2b8-4138-1506-fc90-ae5c6ab0522e@suse.cz>
Date:   Thu, 14 Apr 2022 11:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] scripts: dummy-tools, add pahole
Content-Language: en-US
From:   Jiri Slaby <jslaby@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20220414091419.7654-1-jslaby@suse.cz>
 <CAK7LNATn2QrFn0fTixnbtZ-VOtWid2PvFKPmjfX+z_UtZgTMgA@mail.gmail.com>
 <ace87421-eefb-f4f6-307f-cd2990fb25eb@suse.cz>
In-Reply-To: <ace87421-eefb-f4f6-307f-cd2990fb25eb@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 04. 22, 11:42, Jiri Slaby wrote:
> On 14. 04. 22, 11:33, Masahiro Yamada wrote:
>> On Thu, Apr 14, 2022 at 6:14 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>>
>>> CONFIG_PAHOLE_VERSION is a part of a config since the commit below. And
>>> when multiple people update the config, this value constantly changes.
>>> Even if they use dummy scripts.
>>>
>>> To fix this:
>>> * add a pahole dummy script returning v99.99 -> 9999
>>> * call it in Makefile taking CROSS_COMPILE into account.
>>>
>>> The latter happens only if $(CROSS_COMPILE)pahole really exists. This is
>>> because a cross pahole likely exists only in dummy tools now, not in
>>> real cross tools.
>>
>>
>> I do not think this is the right thing to do.
>>
>> (As I said somewhere, I am opposed to checking pahole version in 
>> Kconfig).
> 
> If you ask me, I am all for removal as this causes pain. But it's there, 
> so I cannot do anything about that.
> 
>> Also, $(CROSS_COMPILE)pahole looks insane.
>>
>> You can create a dummy pahole in your local system.
>>
>> $ echo 'echo v99.99' > $HOME/bin/dummy-pahole
>> $ chmod +x  $HOME/bin/dummy-pahole
>> $ make CROSS_COMPILE=scripts/dummy-tools  PAHOLE=dummy-pahole  menuconfig
> 
> Well, the question is how do I that for every kernel developer in SUSE?

IOW it'd be quite easier if the scripts/dummy-tools/pahole part of the 
patch was in the tree. (I don't insist on the Makefile change.)

> thanks,-- 
js
suse labs
