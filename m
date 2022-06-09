Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7C544CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiFINCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiFINCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:02:36 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30027A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:02:31 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c14so21730931pgu.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=B60BDnYalwcEHOrtlyIymV/tSi/kdzbFSw8jr+MPrjw=;
        b=YZUQ5qNjxEI6HjTitxR9fj/kyUkLhOEzqABDEhquGD0N+9Uj35/EXKO3ivXZFvVO9r
         Q67iXE5igVyAKt67xSXJPd6IkN3vbGoT7jxkqTbpSgOoQI7O1uu4j3okW955TlnGwz/m
         of6p4UtIDP2MJseRW4cQUzaNcPS+NbnMqDNeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=B60BDnYalwcEHOrtlyIymV/tSi/kdzbFSw8jr+MPrjw=;
        b=vLUj3VKFSCc9lA2aucUEnUdB8/hmD3fyVxbEUyzaK9V18aGD2jeqpcw8tVNYpTkiOy
         PQH1z4WI1Gtib1dfxPoGlBH4WmEec9rc4T+v0r5TY0WqNmkQqKZWVghWJ6Wit9IqigjY
         Ke6iOw3upkw/Nr6kO53D5xMv1CcK4JC/ZaatStG2n2KJYCHGIdSJzPCpfOKC86DtKXWn
         An9ZGyqtXhCDBFDD9tC4Ja+OGMeRT9K08ppGTokQN8Lmp0Es65ieEGLoaUjuuQjddL6U
         qOi/zMVnQa32zIlFSQOaAoIqVDmf0UjzR24ssMPn9wrv/5RixrRibIUmkc3UfC260Z+E
         3O4g==
X-Gm-Message-State: AOAM531aPj98iF5EL/VavQIsCdCZUoZPQh6DDwrplVqZ5LJK3jf9MTIE
        3wxHgEV+1E8q3O+qAK71ulGT9sZ8AcLCCQ==
X-Google-Smtp-Source: ABdhPJzddlA+6LhCkNfsl3M7X55X+KAq13daRHejQijSKC8S/APtUFK35mGJVWxZUL55bnpFqOjMvw==
X-Received: by 2002:a63:6985:0:b0:3fe:1929:7d6a with SMTP id e127-20020a636985000000b003fe19297d6amr10595630pgc.292.1654779750571;
        Thu, 09 Jun 2022 06:02:30 -0700 (PDT)
Received: from [127.0.0.1] ([198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b8-20020a631b48000000b003fadd680908sm17210247pgm.83.2022.06.09.06.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 06:02:30 -0700 (PDT)
Date:   Thu, 09 Jun 2022 06:02:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        David Howells <dhowells@redhat.com>
CC:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: disable -Warray-bounds
User-Agent: K-9 Mail for Android
In-Reply-To: <168dbedc634a2994e9ab8f7e33930304da6140a7.camel@pengutronix.de>
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook> <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com> <202206081404.F98F5FC53E@keescook> <CAHk-=wiFn-_OaWKY=nXt3YSiy=obrNoQW_u7zKO7qoArez=GUw@mail.gmail.com> <AEEBCF5D-8402-441D-940B-105AA718C71F@chromium.org> <168dbedc634a2994e9ab8f7e33930304da6140a7.camel@pengutronix.de>
Message-ID: <B392D155-E64C-4EBC-9C6C-4290F637F382@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On June 9, 2022 2:56:47 AM PDT, Philipp Zabel <p=2Ezabel@pengutronix=2Ede>=
 wrote:
>Hi Kees,
>
>On Mi, 2022-06-08 at 17:39 -0700, Kees Cook wrote:
>[=2E=2E=2E]
>> > See the attached patch for
>> >=20
>> > (a) make the s390 "use -Wno-array-bounds for gcc-12" be generic
>> >=20
>> > (b) fix the ipuv3-crtc=2Ec one=2E IMX people?
>> >=20
>> > (c) disable -Wdangling-pointer entirely for now
>>=20
>> I'll take a look; thanks! Should I send them back as a pull request?
>
>Does this refer to the whole patch, including (a) and (b), or am I to
>pick up the ipuv3-crtc=2Ec fix?

Go ahead and grab that one please; that's more "normal" :)

Thanks!


--=20
Kees Cook
