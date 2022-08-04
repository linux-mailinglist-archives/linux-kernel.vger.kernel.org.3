Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046D5896B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 05:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiHDDrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 23:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiHDDrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 23:47:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A832EDE
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:47:45 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id m4so12877796ejr.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wyof0bkxuLb7l+bW3evuMnDsgT1C3T/ocuCEfridqEI=;
        b=YOlanNtbyFxg8zqgJxqaze8MqqqzS2vIkh+xow7vp8sZud9d5nlNTgg2xBW7zgdIm/
         XkYaoItWl8EKHeep0zfLcRZqJiCm1AhE06/GrhCT8BtqzueQ2TSH6UdgYngjRmtIhtl6
         UKVq2AF4IXgWjr4XtceN65Guj6s45iizfstzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wyof0bkxuLb7l+bW3evuMnDsgT1C3T/ocuCEfridqEI=;
        b=7a3iA93KHz2CXkQ7g29e2wD4aYKZMTnhdc6nptsEK95wEc9VLjBNIjo60URhtwJfvo
         zWS7tU9uCORLpg3UwKEUcALsvSJKjht2WtkaxRCQRAvTKwcdrbCAgBNnOzE36Phc54mn
         lihmvf3njnIAmIKMcgRV6qmLrQc8SFxlR7oQ6/walHMTknkuRdljDxRzpaixqyapn24Z
         tNQCTqco/Yd9F6Q4ceLbwwcc01Io1RqbcWPA9tOay0NM0PG8d5r6we9oy+4lv5D8t/+u
         ZRsGoeb9xyE7e1MrB4PtrfDS55ooLQikXIDt1VByzrCLH/S4rlKmucYjFMoirvIA0YRb
         /hqg==
X-Gm-Message-State: ACgBeo04b2vwQMqNwLGdl+7uWkfCAPRWW10+sbDU+5C8Er0qW36r/vJU
        kWJB8lmFy+D4e4pd1hgh4pKSirevrH9/KKIM
X-Google-Smtp-Source: AA6agR7Dz/WRvBxUvPg3LE0rU+eMyQFtF04LtQk0ORQDmdVMxtvuaK4/R/LZEpYnuD26zvkWgqBqlQ==
X-Received: by 2002:a17:907:a056:b0:730:ce15:842d with SMTP id gz22-20020a170907a05600b00730ce15842dmr341958ejc.275.1659584864113;
        Wed, 03 Aug 2022 20:47:44 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906292900b0071cbc7487e1sm7887520ejd.69.2022.08.03.20.47.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 20:47:43 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id h13so4497556wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 20:47:43 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr7203271wru.193.1659584863178; Wed, 03
 Aug 2022 20:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9twFEv8AcRQG-WXg5owy_Xhxy3DqnvVCFHgtd4TYCcKWEQ@mail.gmail.com>
 <CAHk-=whXSt2N0GcoPC6XxXXLMpXm-34ua+X4AhPsLoqBcF6Xqg@mail.gmail.com>
 <CAHk-=wj8UHvjsVPohpRA1RJo1upyKoSnjcsys+=vbRVbpPvBMg@mail.gmail.com> <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
In-Reply-To: <CAPM=9txsYE1zFDW+ehHQv138DoeT1Fw6hfzfPa4czvXGSjefjw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 20:47:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
Message-ID: <CAHk-=wj+yzauNXiEwHfCrkbdLSQkizdR1Q3YJLAqPo6AVq2_4Q@mail.gmail.com>
Subject: Re: [git pull] drm for 5.20/6.0
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Wed, Aug 3, 2022 at 8:37 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Actually I did miss that so that looks good.

.. I wish it did, but I just actually test-booted my desktop with the
result, and it crashes the X server.  This seems to be the splat in
Xorg.0.log:

  (II) Initializing extension DRI2
  (II) AMDGPU(0): Setting screen physical size to 2032 x 571
  (EE)
  (EE) Backtrace:
  (EE) 0: /usr/libexec/Xorg (OsLookupColor+0x13d) [0x55b1dc61258d]
  (EE) 1: /lib64/libc.so.6 (__sigaction+0x50) [0x7f7972a3ea70]
  (EE) 2: /usr/lib64/xorg/modules/drivers/amdgpu_drv.so
(AMDGPUCreateWindow_oneshot+0x101) [0x7f797207ddd1]
  (EE) 3: /usr/libexec/Xorg (compIsAlternateVisual+0xdc4) [0x55b1dc545fa4]
  (EE) 4: /usr/libexec/Xorg (InitRootWindow+0x17) [0x55b1dc4e0047]
  (EE) 5: /usr/libexec/Xorg (miPutImage+0xd4c) [0x55b1dc49e60b]
  (EE) 6: /lib64/libc.so.6 (__libc_start_call_main+0x80) [0x7f7972a29550]
  (EE) 7: /lib64/libc.so.6 (__libc_start_main+0x89) [0x7f7972a29609]
  (EE) 8: /usr/libexec/Xorg (_start+0x25) [0x55b1dc49f2c5]
  (EE)
  (EE) Segmentation fault at address 0x4
  (EE)
Fatal server error:
  (EE) Caught signal 11 (Segmentation fault). Server aborting

so something is going horribly wrong. No kernel oops, though.

It works on my intel laptop, so it's amdgpu somewhere.

I guess I will start bisecting. Oy vey.

             Linus
