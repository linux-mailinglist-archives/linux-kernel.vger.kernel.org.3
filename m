Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0D59AF58
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiHTSBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiHTSBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:01:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC62A710
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:01:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q2so6993639edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=G+grvKBjCAQ23nLTFvq8USGall6C9xqY2mA86Y/AIhg=;
        b=SYklTh+ZwnMHWr4R06atDe3bNDPz4t2IeKWXhf7HPywfl6qH94d9DSEihQoh0xngE0
         XKWaUMFaQk9rTFuW/5QCgAlRDnxEc2e5l7rgkgu+L9A1qk4JMZv0EYyBB0jYVnvx9jg6
         lKj6YE42n9OLAQdDgjl0d/ayYaY3d/MdB07LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G+grvKBjCAQ23nLTFvq8USGall6C9xqY2mA86Y/AIhg=;
        b=vNCC6dZDu4qp7+efMplqyDri0cyW3y2Zc8Nh+ZozKz7mY2jIS/aZoS6laAkytJHhM7
         cmNN3QuCG/hBQum/t9sKrLieWJTgsnSgWzZrcg9d7vSWl9hS4JQwi1gdLvMeEj7HQxDg
         Zwv8ZC7jelJyb4a6CdRZ95clEs6ywLe3OukeDI5qFL/vjzheSQO5aNwuQ4nOctKqKJeP
         /GHdfotlOXxPUlqqmBeXFIpvC5HJ5rkB+CzUo8JX56kSda3iTdrD7vGYKpj1B1PdcJ/W
         AhWy2IPp+OstBfb5O3s3SyKxUy+zfM3DRVVDKQbZ2uTzuEzeBvKZGNDO6qj0Mfnq6dAG
         Flaw==
X-Gm-Message-State: ACgBeo01n7E5BiioVrqMDoD4KoZMINKBNx2ayR8P4fhNbQexYJAdA4uV
        n34/GLIluW2p8He8ntK6loluSsibzr9xuE9b
X-Google-Smtp-Source: AA6agR5HrotqV9J9b+deO3buxyUeeIGdz6flLVNy78GMXkIu2an4AiuigWZr/XprPfrI1M81yZtiAg==
X-Received: by 2002:a05:6402:5008:b0:440:941a:93c3 with SMTP id p8-20020a056402500800b00440941a93c3mr10331093eda.47.1661018503279;
        Sat, 20 Aug 2022 11:01:43 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id kx26-20020a170907775a00b0073cb0801104sm2870471ejc.147.2022.08.20.11.01.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 11:01:42 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso3964985wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:01:42 -0700 (PDT)
X-Received: by 2002:a05:600c:2195:b0:3a6:b3c:c100 with SMTP id
 e21-20020a05600c219500b003a60b3cc100mr7623351wme.8.1661018502110; Sat, 20 Aug
 2022 11:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <YwBWJYU9BjnGBy2c@ZenIV> <20220820033730.1498392-1-viro@zeniv.linux.org.uk>
 <20220820033730.1498392-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20220820033730.1498392-4-viro@zeniv.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Aug 2022 11:01:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLzPq42K8w8M6u__p8fu-FbN6VwvhE3Vvu9n_Pb0kwUQ@mail.gmail.com>
Message-ID: <CAHk-=wgLzPq42K8w8M6u__p8fu-FbN6VwvhE3Vvu9n_Pb0kwUQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] termios: consolidate values for VDISCARD in INIT_C_CC
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Fri, Aug 19, 2022 at 8:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> However, util-linux still resets it to ^O on any architecture,
> ^O is the historical value, kernel ignores it anyway and finally,
> Linus said "Just change everybody to do the same, nobody cares
> about VDISCARD".

Heh. Grepping for DISCARD_CHAR() shows that there literally doesn't
seem to be any user.

I  guess some user space program could care what the initial value is,
but it seems very unlikely.

                Linus
