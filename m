Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74A7591D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 02:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbiHNAjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 20:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiHNAje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:39:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BBE31200
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:39:34 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so5494096edi.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wnDNfE9RbpplWt9K+hUgd+FEnAuo2qI606ZZ01nKEW8=;
        b=hb1eEUp6mJ8boevTR2EMZfGw1A9rJsvBnvgvb17p6GXmf+NJr+PDy+J+HVQJeneMQA
         PeRFK7sTKiFP2pDFdpeP/C4n/YKyFwICBvM2Rf6/1LedAcixAZ9sBxiDAEP6XlAAZt0f
         ByJeyGt3inviUVQGNC2l/oWD090cduU/aagmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wnDNfE9RbpplWt9K+hUgd+FEnAuo2qI606ZZ01nKEW8=;
        b=5FM7ECXISpgKLCruvw/E/TR5V35iPLvpZt4VS1wuArMNMt17wnmbRnB3SUFTbuJ7eB
         B5arSdc4EqilZEhIiQ8OzItSl177kY3fQNLnVJtmKRbgxBRyIwmmM3Z0bBCi/E0yWI5J
         a/VBKGiXCJr3KvxLnLykfz271N84gAbupE2ISISDaLc4ABR/pNwNN1lOsYrH2/9erIzq
         RePIhgTh9xl3rxFJeBO1tmFb8//RdrUk8pCtgpA0CYRhCzrpXPKcWBAIqzehx8BF3yNm
         XefZPznnNyQP0WnKYVclG6+vHcihv4hVFjAndjXUhE+KVBud1dZ9AslvM3YtneknIoTW
         wgRw==
X-Gm-Message-State: ACgBeo0pPQTkQm6VSM87A7MczlbSU1Gc/o9CKOz5gAL73g4uVnwea6e9
        MUsjKHWum4Lcj9hmJNrmViFWJ6Z1H+Yupqwu
X-Google-Smtp-Source: AA6agR6S1BEY7vZjThn1XC9KUcQgdU1M5smJOBk21/6qqwjPtTrHQoZv9t5KBpdsfS22S05PNx6eqw==
X-Received: by 2002:a05:6402:4441:b0:43d:5bcf:afa0 with SMTP id o1-20020a056402444100b0043d5bcfafa0mr8936648edb.91.1660437572418;
        Sat, 13 Aug 2022 17:39:32 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7dd58000000b0043d742104efsm3783128edw.19.2022.08.13.17.39.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 17:39:32 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v3so5099840wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 17:39:31 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr5333411wru.193.1660437571585; Sat, 13
 Aug 2022 17:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <YvhAZYm1T4ni+y01@ZenIV>
In-Reply-To: <YvhAZYm1T4ni+y01@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Aug 2022 17:39:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwCrp6Mok6fccY1uXQQEUCcyPSjNvsHYrnaaL90-85sw@mail.gmail.com>
Message-ID: <CAHk-=whwCrp6Mok6fccY1uXQQEUCcyPSjNvsHYrnaaL90-85sw@mail.gmail.com>
Subject: Re: [git pull] vfs.git #work.misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Sat, Aug 13, 2022 at 5:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>       vfs: escape hash as well

That didn't parse at all for me - when talking about hashes in the
kernel, we basically never talk about the hash _character_ ('#'), and
your pull request message just made me go all "Whaa?"

Next time, can we agree to talk about either 'hash character' or just say '#'?

Just to avoid the confusion with all the normal hashing we do in the kernel.

            Linus
