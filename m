Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A433553DF02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351831AbiFEX5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348738AbiFEX46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:56:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9DB3B3EB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 16:56:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id me5so25400846ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRX+dAaHFYHOMUkkn7e8l97Dwcch2sYAXae8M4f8XjE=;
        b=B+w0Y6o1NT9jGOE9kjSjrSBAJ9eA6U+dI1XGTGNKFUSIW1CGxv58Uvz8TroRpXFL1I
         jOVUYOxXT6wmSLmfjsCY84xZJczlEuYLR0s8LaRgKZd9k2S+h1lWW2reAZZdqlSLPNu4
         ZeJUTW8DlEBxbtUxbl/awnYiB+zDYOwZ9VUro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRX+dAaHFYHOMUkkn7e8l97Dwcch2sYAXae8M4f8XjE=;
        b=s4ytOV8LF/wmxXVSXlxV6DfGt+lixV4G4KXRORUmOD18toznsgvGmuiRu+1aJUa3Mz
         jRonHhfh5o4bjdnEoj2bGZRWGC12S0vytgQyDPOul3m5/KfwTgIWBZuGgiYkXJESYyFT
         VJlruu/H9J+0qVl6dNTtd0pJGs1jR86tgteCpIdz7HbEAD21nBkNuSdJ87G2OLcEr+ON
         v7Qk8QKbfTIQHuc9CuV/Oyotp6scMcxR4/PbDXsOguyue/QEWBuMhK9L5d7RMDY/0m/C
         qCmjkteIixnhYtBrYtdwjL5mXpoWQUl8JXXBpSdrJlg44M1DBE/YtjW8BU0EXvP3AugU
         XuOA==
X-Gm-Message-State: AOAM533cI4xEUI5hA07LWqD3IptfF24K7k/DdSbMy+gPnvJYnudGZ6Ik
        4ejGAXWMEqXLhOLdw/UnxZwKlVP9rY31r5DW528=
X-Google-Smtp-Source: ABdhPJyi+zLpVeuf7BaUT7coRoRikZd4VZaWgP7K4Y2M9SLmWYKGyvjHih6eNm9SMKgJ5bs1/eNsNA==
X-Received: by 2002:a17:907:9483:b0:6ff:b1:467a with SMTP id dm3-20020a170907948300b006ff00b1467amr19101069ejc.683.1654473415292;
        Sun, 05 Jun 2022 16:56:55 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id jg36-20020a170907972400b00701eb600df8sm5886394ejc.169.2022.06.05.16.56.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 16:56:53 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id k16so17737798wrg.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 16:56:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr18555328wrz.281.1654473412987; Sun, 05
 Jun 2022 16:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
 <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com> <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 16:56:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com>
Message-ID: <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: fix erroneous use of bitmap_from_u64()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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

On Sun, Jun 5, 2022 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> *Most* of the accesses to those connection flags seem to be with
> hci_dev_lock() held, and the ones that aren't can't possibly depend on
> atomicity since those things are currently copied around with random
> other "copy bitmaps" functions.

I've committed that patch as commit e1cff7002b71 ("bluetooth: don't
use bitmaps for random flag accesses").

That basically ends up reverting

  a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting
HCI_CONN_FLAG_REMOTE_WAKEUP")
  6126ffabba6b ("Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag")

which did horrible things, and would end up overwriting the end of the
bitmap allocation on 32-bit architectures.

Luiz, if the reason for the change to use a bitmap type was because of
some atomicity concerns, then you can do that by

 (a) change 'hci_conn_flags_t' to be an 'atomic_t' instead of a 'u8'

 (b) change the regular accesses to it to use 'atomic_read/write()'

 (c) change the "bitfield" operations to use 'atomic_or/andnot()'

but honestly, when it used to mix atomic ops
(set_bit/clear_bit/test_bit) with random non-atomic users
(bitmap_from_u64(), bitmap_to_arr32() etc) it was never atomic to
begin with.

Regardless, trying to use bitmaps for this was absolutely not the
right thing to ever do. It looks like gcc randomly started complaining
when 'bitmap_from_u64()' was changed, but it was buggy before that
too.

                 Linus
