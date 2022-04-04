Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521684F1005
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377689AbiDDHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiDDHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:35:47 -0400
X-Greylist: delayed 152 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Apr 2022 00:33:51 PDT
Received: from resdmta-a1p-077302.sys.comcast.net (resdmta-a1p-077302.sys.comcast.net [IPv6:2001:558:fd01:2bb4::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51C4E07
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:33:50 -0700 (PDT)
Received: from resomta-a1p-077245.sys.comcast.net ([96.103.145.236])
        by resdmta-a1p-077302.sys.comcast.net with ESMTP
        id bH8DnruG6HzlAbHBFnAef7; Mon, 04 Apr 2022 07:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1649057477;
        bh=fEm/vE2z2BEzMcXW0PFgggG5I90y9tWWUTabwLNrL2I=;
        h=Received:Received:Message-ID:Date:MIME-Version:To:Subject:From:
         Content-Type;
        b=UcI0wVZze9zZT7l3g0eH5gQjzowNgBX+wm+e6yVGmwoJxhaJmRm5bgb2dxN4z1P9/
         +xAoU29qDi7QKlpxaNjxY2sTBe5DrI29/96JPHfpqXZ+xmGH8aplQs0IYzfLKsV5ak
         QGrWVgTbfnxgDrKeciFz/ZnHJanQJmWEeMEcf8ZPFLwYv321BwF39eypK8R2RAHpz3
         vLJk7PMGfkWfAiHqXlSRCQuaMJk72TVkSEYVdazpGSOb1QShht0lv/d4na+W3B4Me7
         0AlbbF/tj5wOoxlPTFQnE8xMBl0yCXtwae+5G2/F8cUp8ADl1WqxURDuSnrcXWjqe/
         IKeY9zrxflGFw==
Received: from [IPV6:2601:647:4700:284:7bc2:74ff:50ae:144]
 ([IPv6:2601:647:4700:284:7bc2:74ff:50ae:144])
        by resomta-a1p-077245.sys.comcast.net with ESMTPSA
        id bHAqnd2ZeJWAXbHArnyMpD; Mon, 04 Apr 2022 07:30:55 +0000
X-Xfinity-VMeta: sc=0.00;st=legit
Message-ID: <c66d704d-4cd9-31a7-b94b-ff60f176c076@comcast.net>
Date:   Mon, 4 Apr 2022 00:30:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
To:     linux@roeck-us.net
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        jslaby@suse.cz, linux-kernel@vger.kernel.org, ogabbay@kernel.org,
        torvalds@linux-foundation.org
References: <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
Subject: Re: Linux 5.18-rc1
Content-Language: en-US
From:   Ron Economos <w6rz@comcast.net>
In-Reply-To: <aba387bd-9799-e0b5-40e3-1bcb552ac74c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 4/3/22 20:29, Linus Torvalds wrote:
> > On Sun, Apr 3, 2022 at 7:22 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> In function '__nat25_add_pppoe_tag',
> >>      inlined from 'nat25_db_handle' at drivers/staging/r8188eu/core/rtw_br_ext.c:479:11:
> >> arch/alpha/include/asm/string.h:22:16: error: '__builtin_memcpy' forming offset [40, 2051] is out of the bounds [0, 40] of object 'tag_buf' with type 'unsigned char[40]'
> >>
> >> Exposed by commit e6148767825c ("Makefile: Enable -Warray-bounds").
> >> Fix at https://lore.kernel.org/lkml/20220403123628.3113382-1-linux@roeck-us.net/
> > 
> > Funky. Apparently nobody else does that pppoe_tag thing, and this
> > driver does it wrong on little-endian, which is the common thing to
> > test.
> > 
> > Your email that you point to is a bit confused, though, in how it says
> > "when building the driver on a big endian system such as alpha".
> > 
> > Alpha is little-endian, not big-endian.
> > 
>
> Oops. Sorry, I thought it was big endian. No idea why. I'll update
> subject and description and resend.
>
> > Now, why it apparently only warns on alpha, I have absolutely no idea.
> > It should warn on other things too afaik, since that
> > 
> >          tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
> > 
> > should be visible not just on alpha.
> > 
> Maybe htons() and ntohs() are modeled differently on other architectures,
> and the compiler doesn't see the context ?
>
> > Weird. But your patch looks correct.
This warning also appears on RISC-V RV64 with gcc 11.2.0. The patch 
works good.

Ron

