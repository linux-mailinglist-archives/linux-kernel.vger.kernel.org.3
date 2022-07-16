Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C765770B6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 20:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGPSUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGPSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:20:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D0919295
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:20:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sz17so14275544ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28RZoulOfay6yh9clXAok7Vj13FsvDAmN9ITtezZqEg=;
        b=KPlvmWUfhHsy6m9FPymE6vCijl6goCmTjdImiiJQo5KaI2aXpYpRAfyGIFR8uXQ9hG
         y2SS3FQrazUfz3ROsbP2r8c1l/KhAWbYNjJ6GaTyPvzCUPbKcXzxomeHBC7uS5ItLS7N
         QAJnl9UadIl0CvYH8iPINZLil84yHyMLjoXvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28RZoulOfay6yh9clXAok7Vj13FsvDAmN9ITtezZqEg=;
        b=TxB70k8QgpNbxaJ/3eJ8wmp2rKc8aJV2bDP/T+E4APQ7VrN1YfniXPXxYe8MPhbFwg
         5aIcGMaNzTakTFiDJ3gB8bn4R5FFYPTu4+Uj13ep+tkDXWNtiXqXs7UN1+stXXDsgbkS
         DViE+OKQ1kxPQpc4wbYoli/Kq+skN/MXGGjFfqaZAwyhZQ7U9lE1vJhdj0ImEXn3vsEL
         lNeGKdkqX29b5Kkp4mQduSXLS7gAlc1xX8vM5/uCincxhq/Ij+1SkT+qtxSSsQTQOpi0
         8Ytb79u4bJ4vbOFllk8hC2XH0E1YFIC+kO5v6xwGvFrvgyHmPbDAGvgiVRRW/WQ4rNTj
         t9gg==
X-Gm-Message-State: AJIora+SdMYEJt2gIT5P2u5htTsPSdyDIA1yHJ8GQ4eILTnVRkgQHVmS
        RWVjCnqUMeYAmBwV4Ov5rByKsTi/LRP1293d
X-Google-Smtp-Source: AGRyM1s+kjEhcK7TRzP24Q/g82cUSBeYP+7Ry0HfWtOwvk7ZdccfLqPR8jEEimhvSLDs4IIG4UjbaA==
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr18875280ejp.88.1657995648342;
        Sat, 16 Jul 2022 11:20:48 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id b4-20020a17090636c400b0072aa014e852sm3442910ejc.87.2022.07.16.11.20.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jul 2022 11:20:47 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id bu1so11022833wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 11:20:47 -0700 (PDT)
X-Received: by 2002:a05:6000:180f:b0:21d:68f8:c4ac with SMTP id
 m15-20020a056000180f00b0021d68f8c4acmr17595471wrh.193.1657995646637; Sat, 16
 Jul 2022 11:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <YtJZegRfm6IsdY/i@kroah.com>
In-Reply-To: <YtJZegRfm6IsdY/i@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 16 Jul 2022 11:20:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZNSb1BAx9gvU4i-h+11Xgke3Q1XSB96rPw+cDKhL7bg@mail.gmail.com>
Message-ID: <CAHk-=wiZNSb1BAx9gvU4i-h+11Xgke3Q1XSB96rPw+cDKhL7bg@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.19-rc7
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 11:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>         - long time bug in pty_write() that has been reported in the
>           past.

Linus goes crazy on grammar, issue #7911: "longtime" and "long time"
are very different things. They have completely different meaning, and
are different parts of speech (adjective vs noun).

English is a crazy language.

             Linus
