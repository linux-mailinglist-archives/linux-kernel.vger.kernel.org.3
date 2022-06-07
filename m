Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6423541D23
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382365AbiFGWIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379813AbiFGVG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:06:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2321110F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:50:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bg6so17196790ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxgwqXrTE5CS81OOTZfgrmr4rRv5j2bUa4aaRbpCvDQ=;
        b=UIn4bvZhXW7AF2rT52jP/vHIPjI8XyKoA3dn2Q+Bi0s2HH11YyOvGVEVe86JVSoGKI
         BaaWsQh6OrE4aTrQmY6fkIGKtAYybadmY8CgsBkfKkdrn9/E2Hw2YgipoxbbIFvguJ8i
         wugGZSlCqni+gcqC9Yso1tIQl10wVmmIOsHm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxgwqXrTE5CS81OOTZfgrmr4rRv5j2bUa4aaRbpCvDQ=;
        b=08u5zEVxSIYwFNoAdPnywnEzHOLG0uSLi1hg7XS/yQ7HkA6KBSUzde6CirNDF/Mx7K
         aEy7toveV/lDYaveBaZYHbFDwSZ+55zGA4/n5nM2uJ/XIM3/Mio3kAnJ7ksqIe7i2vnd
         bGVTEi1OGQgq+SJZlOmykx+Oxzw//TdlDNRfI71QpVf4xHXAyIsfC0hWq7Qh/zWoCAyl
         MpNqHNm3pJ5eLilJqK/IC00Ne+hsduALAu8WU/oK7H0bqaKdzvUQvXgCjNbJ3duTEJAh
         +h+32RuzOrS+KIE6WvzZQD5E+4O/O1Jm5/PFeaegt/GhKyTZkb6D2suNyGe0JYsyhs5Q
         dzSw==
X-Gm-Message-State: AOAM533ROkZhzIn1V9v3E1EHvzmgX9EtF4xon/Dx+obI5xZESYWvlqKv
        D3w/NLD+Ua45umk4hrF0Zg6xGkcuwZgC3hDSHUI=
X-Google-Smtp-Source: ABdhPJwCpSrPk7PXgXlO65PYgzwn0dW99k0EymupWGqkCJbmkBpFx02J5QdaEkeko+YGoY2vtwNeWQ==
X-Received: by 2002:a17:906:9751:b0:711:e80e:fcb with SMTP id o17-20020a170906975100b00711e80e0fcbmr2994093ejy.74.1654627815733;
        Tue, 07 Jun 2022 11:50:15 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906270300b00704a5c530ccsm8140850ejc.162.2022.06.07.11.50.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 11:50:14 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id u8so21038247wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:50:13 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr28815309wrz.281.1654627813569; Tue, 07
 Jun 2022 11:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
 <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
 <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
 <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com> <CABBYNZJfqAU-o7f9HhLCgTmL46WfwNQbM5NsCACsVVDLACMLYw@mail.gmail.com>
In-Reply-To: <CABBYNZJfqAU-o7f9HhLCgTmL46WfwNQbM5NsCACsVVDLACMLYw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 11:49:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcV=BE6bkyd50eZZnggaczKdpU_PevFRWw_hjJS72UPw@mail.gmail.com>
Message-ID: <CAHk-=whcV=BE6bkyd50eZZnggaczKdpU_PevFRWw_hjJS72UPw@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: fix erroneous use of bitmap_from_u64()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Guo Ren <guoren@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 11:00 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Right, thanks for fixing it. About some of the changes perhaps we
> should use BIT when declaring values in enum hci_conn_flags?

That sounds sane, although with just two flag values I'm not sure it matters.

But I guess it would document the fact that it's a bitmask, not an
ordinal value, and it looks like that header is already using BIT()
elsewhere so there are no new header file dependencies..

              Linus
