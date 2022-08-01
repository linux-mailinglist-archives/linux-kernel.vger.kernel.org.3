Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936D586E58
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiHAQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiHAQM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:12:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E63120AC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:12:27 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x21so1673943edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=o7YLDWp/HQ8+VIdGGoWwDf5GNDP+fMQa77PB0KY66Kg=;
        b=G1+XdKeRi6JeiafbwektiTaln+hCPgsiBzIhFmoZNxV24Bc9UoFyWrjaqrUDS/t8FX
         111SSjnhyb/fOxmWnqbCxVC+tfzcu9VRnZe0m2FIEidys9FshZnMUmifrNsJCJ/8vOmR
         VBwtICzkqhLPss6QW4P6o9AHz4AuYhJGzfp6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o7YLDWp/HQ8+VIdGGoWwDf5GNDP+fMQa77PB0KY66Kg=;
        b=7mleWlDqMFf6sM2j8fqD7aZCrcJp4BJLm+SxocqHHxKAFmkz6Ig0oMjVzj9zFeduRu
         owAE+IYE7U4XZWQcW5aU57m8Fon9naCubL2/NZ4u2Kpf065PhJNHkY0P+n5/UFnpFyep
         ZKC0ltMPCKV0li8/aEj9gtCswSNfGtOh14OigJG6qr7YfmsED2YExig2G2HTtpaBefGZ
         BJnzsV39ArpI9qU2P54Wv/o4MBjdLHvMciHaxTrHfwcYcNl8WN7SQWFIYeDJfq490hqm
         PdOSOdOK22Qz/DwMdHIRT5T7OSyw++kL7tQPFIKdCW5+SD9wSRTFZYGnhkG7jL+ufKLQ
         Y8Jg==
X-Gm-Message-State: AJIora9VlJE2GqYRN2EG6Eatczj9wcLwfaHuW4vxdfbmJ7/oKwbHRGJW
        4rwU6FH1rP1TeHJo6SPPAhAN6P+nHUs48yAF72s=
X-Google-Smtp-Source: AGRyM1sMKhgM9w/I11NRk6pox6dlGJ3xwdILCd0jAHNMmWTahc8ycBiJuvJ0x78VFWBlCqtdgyRskQ==
X-Received: by 2002:a05:6402:e93:b0:43b:6a49:7e88 with SMTP id h19-20020a0564020e9300b0043b6a497e88mr16969360eda.132.1659370345418;
        Mon, 01 Aug 2022 09:12:25 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id o24-20020a170906769800b0073061212425sm2516049ejm.179.2022.08.01.09.12.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:12:24 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id j1so6365979wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:12:24 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr80096wru.193.1659370344396; Mon, 01 Aug
 2022 09:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220801145520.1532837-1-brauner@kernel.org>
In-Reply-To: <20220801145520.1532837-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 09:12:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfZgtQgW6Nd1BLdY5G7PTVmEjs6Qe-JFn4NMjNzTGMdg@mail.gmail.com>
Message-ID: <CAHk-=wjfZgtQgW6Nd1BLdY5G7PTVmEjs6Qe-JFn4NMjNzTGMdg@mail.gmail.com>
Subject: Re: [GIT PULL] acl updates for v5.20/v6.0
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
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

On Mon, Aug 1, 2022 at 7:55 AM Christian Brauner <brauner@kernel.org> wrote:
>
> What follows is an optional excursion into posix acls which provides a wider
> background. But the pull request message can be cut off here if not useful.

I actually would have loved to have it, but honestly, it would make
"git log" somewhat unwieldy for people who aren't directly involved
and interested.

So I put a link to this extended background info in the commit message instead.

               Linus
