Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA2552C18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347500AbiFUHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344693AbiFUHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:31:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B024E65E3;
        Tue, 21 Jun 2022 00:30:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5B2541F9C6;
        Tue, 21 Jun 2022 07:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655796612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4DTymAJzJ+35tPlIxji4RhmkYgZWhkrVnEK1homBN0=;
        b=xDXlEOxSp1VNq0dGCbuV8cBqopmOOBe+A2BB5vgty35t9Pc/P9Zy4i4FWvAzDXkWFKrVsH
        pB3OKphPeQk5Zzg0nAX5T+R8q37T1TUR75oNH/oCzzYq2pELsarXQyJu0C2STfbnRBlrsk
        YcOuN/YP1HGwMUimbind212F/PcAhB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655796612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4DTymAJzJ+35tPlIxji4RhmkYgZWhkrVnEK1homBN0=;
        b=hnBmxj3WK/dvg/U4SLwzrQISzWAXPwW72yyFMPep1j5ut5MiSRm/2ycY7Kw53Tm92v7F1T
        uO3z7yVLSQtDwOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26E8613638;
        Tue, 21 Jun 2022 07:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5lt1CIRzsWIJZwAAMHmgww
        (envelope-from <jslaby@suse.cz>); Tue, 21 Jun 2022 07:30:12 +0000
Message-ID: <14c9839b-c015-69c1-84f0-a99d03877005@suse.cz>
Date:   Tue, 21 Jun 2022 09:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] kbuild: pass jobserver to cmd_ld_vmlinux.o
Content-Language: en-US
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
References: <20220616104541.16289-1-jslaby@suse.cz>
 <CA+icZUW8O-HUSpw-656o6YZOiR2ZiCXjxsJwm2kctT6DHrs=4g@mail.gmail.com>
 <CA+icZUV6bM2_jxyROK5B4XRid6fv8oX6YYNEdHUX8e_1OAdQYA@mail.gmail.com>
 <CA+icZUUSTcrJqZB-gwNYt5objVg1J5+Ous6_hof0_A6eVCM-Kg@mail.gmail.com>
 <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
From:   Jiri Slaby <jslaby@suse.cz>
In-Reply-To: <CAKwvOdmb5xdF70TzNp=4STCpzkGh16FnuKE1KbdzDhHt=OuRFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17. 06. 22, 18:32, Nick Desaulniers wrote:
> On Fri, Jun 17, 2022 at 3:35 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> On Fri, Jun 17, 2022 at 12:53 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> On Thu, Jun 16, 2022 at 4:09 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>>
>>>> On Thu, Jun 16, 2022 at 12:45 PM Jiri Slaby <jslaby@suse.cz> wrote:
>>>>>
>>>>> Until the link-vmlinux.sh split (cf. the commit below), the linker was
>>>>> run with jobserver set in MAKEFLAGS. After the split, the command in
>>>>> Makefile.vmlinux_o is not prefixed by "+" anymore, so this information
>>>>> is lost.
>>>>>
>>>>> Restore it as linkers working in parallel (esp. the LTO ones) make a use
>>>>> of it.
> 
> TBH, I agree with Masahiro. I didn't understand this comment "esp. the
> LTO ones."  Jiri, can you clarify what you mean here?

Sure. clang is not the only compiler/linker that can handle kernel ;). 
So while rebasing gcc-LTO-kernel-patches to 5.19-rc (to upstream them 
later), this broke. See:
https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/lto-wrapper.cc;h=26e06e77be4e0afb2bc3e913062a9c51cab5d205;hb=HEAD#l1336

gcc really parses MAKEFLAGS and looks for "--jobserver-auth=" there, if 
one passes specifies -flto=jobserver.

thanks,
-- 
js
suse labs
