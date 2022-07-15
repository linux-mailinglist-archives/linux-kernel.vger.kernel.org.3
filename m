Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA2575941
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 03:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiGOBym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiGOByl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:54:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC1F24F36;
        Thu, 14 Jul 2022 18:54:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e16so3412972pfm.11;
        Thu, 14 Jul 2022 18:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ukuk4UUTau+M7hloRbOEtJ/RljdTGD7URDkjl7/1nZU=;
        b=VmP0wFGqB1AlcvqLtcnfEFilpp7NXdUTh85ygKrSB4mi1CoCUviCJrePqN9O4C8Hwn
         RY7Ag0QHziv3kcjWF1gdK+eM8cbHxb6Z/SuoHNDMotG9NodgdKL9gV57bbqzMNimRS5F
         jUV/FZ8N5hVF27UiMZdS9vZH0xeXonRwilVzduHIpST4BnLIuBrxbsTmHWhx3jcYfY8G
         OKImIBYNlMD8JPLY2Nb17ml9sKzFEtYYh5gzTEaSVZz58SygCYp0+1WV5u4t+Bsq4bTe
         +38T+OWb6okMBKTsSS74u99i9SMfb6+T8ooJGehACGwhjvaYP90USD6pGFa7bRGVWoWT
         sL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ukuk4UUTau+M7hloRbOEtJ/RljdTGD7URDkjl7/1nZU=;
        b=ZX9mLcYUxGKSFLJFTJTaIwKVxiiHccmTLK8kUs7iWmYQs97w4PmDpqToavJXz1n8iE
         Ze8FCvdC/8vD+bl+b3P1ky2MynyU1hC4v/YEz9tPJ7aR6RVVI7R24j/TEhmMY8fGPLFL
         UnqFvAScG0yh1ECufhDWDh30SS1iZcdsI7Lm1npZyvtYquKhZI52QZ4G9bp7VbqA2dy0
         IyNe/l4POQz3a2YYzbgHknan8BnWNUQee05Xyd8dNxsd29Vrw1mPfcD6T37C2f2XrYNI
         p3HfO+DubBWLT0xHYMgiuOaXLuWvt/L+DUJTTihdzReHIYxQ9XdxmRwhpJkFHHn7MlV9
         r0wg==
X-Gm-Message-State: AJIora9cIPoPyBp0qNwMeqfbkQi7O+KpyRBzDC6WyT5Oxo++iUuhTH7k
        m9/wiiZcvIUeIYsT4dK+gV8vjmX6OtK8fDEhS8b5s5t050sbxRs=
X-Google-Smtp-Source: AGRyM1vrifDFY3bikPBsvz7LwbrJQoyRLXnB1BpXInbo4fN0lh0lOVCEejbSFgkMQh0indMvihZC2h4bQadUMDUGzns=
X-Received: by 2002:a05:6a02:113:b0:412:a7c0:da8e with SMTP id
 bg19-20020a056a02011300b00412a7c0da8emr10350315pgb.113.1657850079268; Thu, 14
 Jul 2022 18:54:39 -0700 (PDT)
MIME-Version: 1.0
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 15 Jul 2022 09:54:28 +0800
Message-ID: <CAMhUBj=bs8rbiPGX1qOv9FSU8m=TdRZqqJGvRcynKbaWwf_A-A@mail.gmail.com>
Subject: [BUG] media: cx88-alsa: Found a bug at the probe time
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a bug in the driver cx88-alsa.

When the driver fails in the function snd_cx88_create() at the probe
time, it will cause a UAF bug as follows:

[   24.343899] Trying to free already-free IRQ 0
[   24.344815] WARNING: CPU: 7 PID: 389 at kernel/irq/manage.c:1895
free_irq+0x3a4/0x7c0
[   24.348448] RIP: 0010:free_irq+0x3a4/0x7c0
[   24.356716] Call Trace:
[   24.357124]  snd_cx88_dev_free+0x71/0x100 [cx88_alsa]
[   24.358008]  release_card_device+0x7d/0x190
[   24.358699]  device_release+0x97/0x1c0
[   24.359022]  kobject_put+0x144/0x1c0
[   24.359329]  snd_card_free+0xec/0x150
[   24.360078]  cx88_audio_initdev+0x8f4/0xce0 [cx88_alsa]

Since I'm not familiar with the driver, could you please give me some
hints to fix it?

regards,

Zheyu Ma
