Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351804ACB99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242640AbiBGVty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiBGVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:49:52 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DDC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:49:51 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b37so23945489uad.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOK7ZFbX6M/yFlHUYZwVYyYTn3CE2+Syg/ppv2ftUNA=;
        b=FiK4f6J1Q9WgJIZvkcQQ78p/JcVE8F9PLU2GLMwde+dY56wtNnxdN82eUW6gaOEfg2
         K8nerIR/pQN5xeAMbYa0Gn0B9/FpABaHG4Xg0NnWFvXOmNVMM/x/V7aeCuqpDsZxFo0F
         hijltBdU/BfDxjmnEa7nDa1+ht2j/7dD3s3bzrgpsOxZHH990ILXAvEpDG0/e45Vn47a
         IWZztrq0Ptc3oTGoSOLC5o3gJ9KzF0ImHPAgOh3ELn+o6I1zCboDjeHoffdaVLM6HPYe
         ErI1GGP83fLApcl+ECeZC/wD5o3JCkfxBYPs+khBzWIxvbhixuEFV5Lq1GUwt2VhPqvX
         6M5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOK7ZFbX6M/yFlHUYZwVYyYTn3CE2+Syg/ppv2ftUNA=;
        b=Pbun9xobLNB5ovEvBihK/6jYxp+dVU1H6GGLAjMX01qdSDJUT6bmMCNoSvIsXZzX4g
         un380mfQzAA9tQ8IDrgm1kwBoZvQwn7h/zcitg6NxPm64jkjVf42vlU/mLiYlvXgquB1
         9ZgNe6RRUPE+3nAjY2Vn1CIqQz0CVgf8Bf1rqXVfWMhrJoeB7EydhVPjNezNA2S5kSLE
         s5ae7ZbJHRnJ4FaS1rWdKMrRdKZmh/UYqVqqkYYGGBVj8Fz8FNg23tl9twnmaNGX02tt
         jZZcDy3MpOrm+u/wFtL/vrAJICdf7szAOAwHXmxw3x69ZqGuVzltgeL3uvLbbYrfFZt8
         cVmw==
X-Gm-Message-State: AOAM530A/Eej1IUILZbNpHHM8XyEMVxQu8maq0Io6LeBEOUV3xlL8frd
        Foa0gaMaOwyTzmgP/GC6xKDUfVctYWab/EQgeLy5LA==
X-Google-Smtp-Source: ABdhPJyJnuf9KurdM0an3YYeK6GZ2Cpq0BPn4OfJwD6/qDHKeD+yGqsyWb2OtEiwcRmxZ5Dw8BejN0470v7H/iPnQkk=
X-Received: by 2002:ab0:43a6:: with SMTP id l35mr29540ual.12.1644270590671;
 Mon, 07 Feb 2022 13:49:50 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de> <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
In-Reply-To: <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 7 Feb 2022 22:49:24 +0100
Message-ID: <CAG48ez17i5ObZ62BtDFF5UguO-n_0qvcvrsqVp4auvq2R4NPTA@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     pmenzel@molgen.mpg.de, "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+KCSAN people

On Mon, Feb 7, 2022 at 7:42 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Thanks for the report. I assume that this is actually an old bug. Do
> you have a vmlinux or a random.o from this kernel you could send me to
> double check? Without that, my best guess, which I'd say I have
> relatively high confidence about,

Maybe KCSAN should go through the same instruction-bytes-dumping thing
as normal BUG() does? That might be helpful for cases like this...
