Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006964EBAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242759AbiC3Gp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242806AbiC3GpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:45:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857D6C92D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:43:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 5so34098242lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhApYI2LhMGRpUg9dbvqs6hE/OBEtlG9wuXkddgwS8s=;
        b=ENqimhI30I1agwzDUDYPRCDpYl5zc0ePCljA3xasBaqRjZvYwvemAE+pwSf26IyNBv
         r0cr09lcgPFqgoYQUgAHxi55Wvl8uj7N0yl8LZ/1gsfWMOgPVKr9SvSiz61x3x5impXj
         R3ffuT0McnEAalObMBRL3KHFYIauMEFYx2Sr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhApYI2LhMGRpUg9dbvqs6hE/OBEtlG9wuXkddgwS8s=;
        b=EBf0wCR8c+3jLdlViAAxL7/pOnzHqhaQp22r4o165rtuFfrX9W01oUhu6csr0T4fXb
         Uq+3cKGExCN6Kk41hGZ039BoHfzZvJbh/UEBLsH5yPzU17sc9YfRqKjvta2WyoGFfjGx
         lB37AvK5z4UAbrxwNA4JtJ28xYOKiMJ4p6CGdJIEW+gwWBUo6WigzgFw/tegugINw63v
         G60v3ovS30KGYO7KamrtVZbs6EfiOeost7TxkJ9gJApprWXSgXlz/bw9zwLXlZZTricL
         iEar3C7XafvjUGDb++COBVdMWIDLj/BTzRAfn3+SXagxqMw7hGgABtoSsTxIZ0H7NVgG
         7RTA==
X-Gm-Message-State: AOAM531w4M44CO123KLXIl38UNcAcmGSuFpLCzHYuaAt7J63oYCaZe9f
        oSaC7G6jBnt844mUkkYXDtF3jllsc2zI5ofr
X-Google-Smtp-Source: ABdhPJwQfmVvyesHfATWL4OUnIjS2Bn/f0oP1eRmJAPXS9vFC3guYal2CIQl69ZgvzJbWZPqKu2X1Q==
X-Received: by 2002:a05:6512:3f0a:b0:44a:e3f:2862 with SMTP id y10-20020a0565123f0a00b0044a0e3f2862mr5724942lfa.397.1648622613415;
        Tue, 29 Mar 2022 23:43:33 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id c21-20020a056512239500b0044aa21dadeasm742821lfv.60.2022.03.29.23.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 23:43:32 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id z12so20303837lfu.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:43:32 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr5682187lfb.435.1648622612260; Tue, 29
 Mar 2022 23:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220326114009.1690-1-aissur0002@gmail.com> <2698031.BEx9A2HvPv@fedor-zhuzhzhalka67>
 <CAHk-=wh2Ao+OgnWSxHsJodXiLwtaUndXSkuhh9yKnA3iXyBLEA@mail.gmail.com>
 <4705670.GXAFRqVoOG@fedor-zhuzhzhalka67> <CAHk-=wiKhn+VsvK8CiNbC27+f+GsPWvxMVbf7QET+7PQVPadwA@mail.gmail.com>
 <CAHk-=wjRwwUywAa9TzQUxhqNrQzZJQZvwn1JSET3h=U+3xi8Pg@mail.gmail.com>
 <YkPo0N/CVHFDlB6v@zx2c4.com> <CAHk-=wgPwyQTnSF2s7WSb+KnGn4FTM58NJ+-v-561W7xnDk2OA@mail.gmail.com>
 <YkP2hKKeMeFrdpBW@zx2c4.com> <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
In-Reply-To: <CAHk-=wgtH+Nq+LSCdjS4v2=XOnL3wtO2FA5wvWu5n5imCsFFCA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Mar 2022 23:43:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjDKYj6VrRyzMDPB593o3oLf2GE9sMDuxMFB3smakbEHQ@mail.gmail.com>
Message-ID: <CAHk-=wjDKYj6VrRyzMDPB593o3oLf2GE9sMDuxMFB3smakbEHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] file: Fix file descriptor leak in copy_fd_bitmaps()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Fedor Pchelkin <aissur0002@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 29, 2022 at 11:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, I'll apply that asap.

Ok, pushed out. This time with no last-minute patch cleanup.

              Linus
