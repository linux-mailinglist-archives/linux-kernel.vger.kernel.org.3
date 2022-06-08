Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE99554291C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiFHIQ1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Jun 2022 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiFHIPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:15:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75987353B34
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:43:49 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-40-KvQNsg_GNi2gAmxjzgy3lw-1; Wed, 08 Jun 2022 08:43:47 +0100
X-MC-Unique: KvQNsg_GNi2gAmxjzgy3lw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Wed, 8 Jun 2022 08:43:45 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Wed, 8 Jun 2022 08:43:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kevin Locke' <kevin@kevinlocke.name>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] kbuild: avoid regex RS for POSIX awk
Thread-Topic: [PATCH] kbuild: avoid regex RS for POSIX awk
Thread-Index: AQHYehnE8MyxlCD7vU+9QFA+5sTsgK1FIDcA
Date:   Wed, 8 Jun 2022 07:43:45 +0000
Message-ID: <05f8480125584a9caea029b9c3111ef4@AcuMS.aculab.com>
References: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
In-Reply-To: <368129160298161a9eb40ad4f489458be6be3b6f.1654569774.git.kevin@kevinlocke.name>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Locke
> Sent: 07 June 2022 03:43
> 
> In 22f26f21774f8 awk was added to deduplicate *.mod files.

Can't this be done with gmake's $(sort) function?

$(sort list)

    Sorts the words of list in lexical order, removing duplicate words.
    The output is a list of words separated by single spaces.

...
>  # To make this rule robust against "Argument list too long" error,
>  # ensure to add $(obj)/ prefix by a shell command.
> -cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
> -	$(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
> +cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
> +	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@

I think the above only works because 'printf' is (usually) a
shell builtin - so the kernel's argv[] limit doesn't apply.
So the comment isn't really right.

But I think:

cmd_mod = $(addprefix $(obj)/,$(sort $(call real-search, $*.o, .o, -objs -y -m))) >$@

will have the required effect.
Without forking and execing multiple processes.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

