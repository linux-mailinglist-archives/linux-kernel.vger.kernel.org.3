Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5805550DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358849AbiFVQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358136AbiFVQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:08:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B081915A26
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:08:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ay16so15922645ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AplRqfnN0oWkS+2VNQi8ZStoPrmgxPvXHgqZuEE6ulA=;
        b=RjrOyWJQLKFLoF69Y4cw8jPAZQd/5a73i8kXm9/eqxT4hqXK39Co8UGdIrRTlokSAF
         LdKTNyP83Rc4J+75iaPsPpCji4Sc36JQRHgHEvJyiTS7qBTq5n4ELSWPbP4ibEDb5vh+
         WEgDhWOy38aHbqmCKRCMRkcgJB88OKHWthfFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AplRqfnN0oWkS+2VNQi8ZStoPrmgxPvXHgqZuEE6ulA=;
        b=g8S3XgJNxNLvVsjg8T07aRGXpE53smmaufGPcrAknH7dMH8G+cb/OVe6IKAVyUpmFv
         pBqKtNHSNxvlalF6RT7VTw1j+xnU1IwQKMPhBWDJegDwSj3qRrlquYW7o0ow5Q9z9j1V
         lpi41Dlmf3Nkh0W41DefC4z4InRPMTGpMrsUaO3Z6saCXFHJ9GJaKvrq1MZjtIRrlWyg
         t1E6EFStSeds3f+K05EHkPEQF/qAv6Iyn6Kc5HbX0DhnNl/ClRNUqKyYINZwcabnpk40
         h+mWrXqN2HetkqbfB0uA8odhGrqzsknbimQl5WudDOWb5zMTDi5/2FizoZXw+iQcad+j
         ZqaA==
X-Gm-Message-State: AJIora96jAAn9ilngxjyL3YOu1ddxsg4jos37wCV3bK3yvDh+yZmvuTT
        M1vdUHecmcpIRioZnRoncmNMb6XkhDQXliX0
X-Google-Smtp-Source: AGRyM1sIhU2l/09O2MmMEEU9YYLFOkpOlSvyBUsYWvsuuxneOBoPXSHv9s8lLK4bAGOAub2m3XSf7w==
X-Received: by 2002:a17:906:a57:b0:718:bd7e:e45b with SMTP id x23-20020a1709060a5700b00718bd7ee45bmr3803061ejf.204.1655914079051;
        Wed, 22 Jun 2022 09:07:59 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170907784300b00722e8827c53sm2240766ejc.208.2022.06.22.09.07.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 09:07:58 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id w17so24071192wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:07:57 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr3983380wrs.97.1655914076974; Wed, 22 Jun
 2022 09:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <YrLtpixBqWDmZT/V@debian> <CAHk-=wiN1ujyVTgyt1GuZiyWAPfpLwwg-FY1V-J56saMyiA1Lg@mail.gmail.com>
 <YrMwXAs9apFRdkVo@debian> <CAHk-=wjmREcirYi4k_CBT+2U8X5VOAjQn0tVD28OdcKJKpA0zg@mail.gmail.com>
 <YrM8kC5zXzZgL/ca@debian>
In-Reply-To: <YrM8kC5zXzZgL/ca@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jun 2022 11:07:40 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjdjrx_bORk3Th+rk66Rx-U2Zgoz1AOTE_UwVtCpD3N1A@mail.gmail.com>
Message-ID: <CAHk-=wjdjrx_bORk3Th+rk66Rx-U2Zgoz1AOTE_UwVtCpD3N1A@mail.gmail.com>
Subject: Re: mainline build failure due to 281d0c962752 ("fortify: Add Clang support")
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:00 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> imho, there is no check for 'i' and it can become more than MAX_FW_TYPE_NUM and
> in that case it will overwrite.

No. That's already checked a few lines before, in the

        if (fw_image->fw_info.fw_section_cnt > MAX_FW_TYPE_NUM) {
                .. error out

path. And fw_section_cnt as a value is an unsigned bitfield of 16
bits, so there's no chance of some kind of integer signedness
confusion.

So clang is just wrong here.

The fact that you can apparently silence the error with an extra bogus
check does hopefully give clang people a clue about *where* clang is
wrong, but it's not an acceptable workaround for the kernel.

We don't write worse source code to make bad compilers happy.

My "use a struct assignment" is more acceptable because at least then
the source code doesn't get worse. It arguably should have been done
that way the whole time, even if 'memcpy()' is the traditional C way
of doing struct assignments (traditional as in "_really_ old
traditional C").

               Linus
