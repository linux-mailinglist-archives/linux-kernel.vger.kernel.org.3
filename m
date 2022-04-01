Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FF34EF86C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349818AbiDAQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350373AbiDAQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:54:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F28A1CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:50:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p10so5926347lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luJj4KxFKmBTkLspMbSvyuPZv8Dkm0lFcSWy4HmQZis=;
        b=Peuvx5N4W5SP8SZZ1FljaHqobq5N2Y8E5+jr3IR/SLI0XgCsiqJT4lNfJVJYQ36xfr
         1PkzzDVLmLoemm1XKNLmG1O2R0Q+iskRlMlTGQFh1Nfu3laGnl7iXDzye9itDnrRyzXp
         nyBb8dfODDODYXQJZ83eRiZmuVegiQPrbGUL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luJj4KxFKmBTkLspMbSvyuPZv8Dkm0lFcSWy4HmQZis=;
        b=pJjskroRjY4vId8ENRHkrqUZJFw0GTMcJgkyr2Ie8O7x02OS8QwDCvI+fnZZSDEMJ9
         +Y9nW3OMnud9pxFJJzKIJqQzqDZP1yKGW4g7caCyCy8O6h2cWoPoxnYBmbS7VxNZZCdL
         ji1FcNi9efsgFvn1naY/6FsFbNojNTeRU3A+5xWL4PeaHFcSPR623XM9sTLqsEvthwbb
         4J2qm8XCYGv41Y4QGFUcD7WJQWzGHdPqi6J3GpB+DSNu7s61ibtlolhdweCHBxwDPW8z
         Pucjn4pqZwg7aIQEHlplgB4uPk2rGkGtIPAH0h6vIjlf02R+D+X1EbxaQY4a+CgRUNBu
         bNlg==
X-Gm-Message-State: AOAM533xJlnsiYwlDT+9fl8QsXz+jhdCT6IDmdCXkSa34P05diOiFyEp
        gQjYF9BznELGPTCWD7EcOCTXGnSWqi8M0agPcbc=
X-Google-Smtp-Source: ABdhPJwslgkCaW+tNsBKM35bycGMP2mhGOgtQUFUqhpynPjrNMLiTvEMQxMDpNj4gFlYY9HClbOpaA==
X-Received: by 2002:a05:6512:b9d:b0:44a:52a6:3ae6 with SMTP id b29-20020a0565120b9d00b0044a52a63ae6mr14652552lfv.351.1648831847574;
        Fri, 01 Apr 2022 09:50:47 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p7-20020ac24ec7000000b00443d65ea161sm283763lfr.291.2022.04.01.09.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 09:50:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d5so5938938lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:50:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr14433392lfb.435.1648831846722; Fri, 01
 Apr 2022 09:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <YkYpfK5ubwafd+Rw@mail.local>
In-Reply-To: <YkYpfK5ubwafd+Rw@mail.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 09:50:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuUZWMeUaTGtfivNQYeuqsQb2C4HnbbPLe+qFXU5Y70Q@mail.gmail.com>
Message-ID: <CAHk-=wjuUZWMeUaTGtfivNQYeuqsQb2C4HnbbPLe+qFXU5Y70Q@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 5.18
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
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

On Thu, Mar 31, 2022 at 3:21 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Here is the RTC subsystem pull request for 5.18. The bulk of the patches
> are about replacing the uie_unsupported struct rtc_device member by a
> feature bit.

Hmm.

I've pulled this, but I don't see the point of the ALARM_RES_2S bit.

In particular, I don't see it used anywhere, and the two drivers that
now set it clear both the UPDATE_INTERRUPT and ALARM features.

So what's the point of that feature bit?

                Linus
