Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8AA505AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiDRPUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345290AbiDRPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:19:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695949FA4;
        Mon, 18 Apr 2022 07:17:14 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks6so27135346ejb.1;
        Mon, 18 Apr 2022 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:to:cc:subject:from:references:in-reply-to:message-id
         :user-agent;
        bh=oCqldMpOoahK1Z20XtKNSbUZVKynuD1kFyXlvJNqAuo=;
        b=HM3eCv1tuUzIpMZ6KMLFisTFgbnRWjQYlkpVkxRQvL/2crtSJpj4AeOvUKyopCklr1
         Q5hO7WNtHkJ8FdrRuAXcVGd1XxFBK3oy0ByVtx53dkoll6UB5Mw7LOalGt0413rMvtVR
         AMkq1ilAqYbwpWSrosgH4i7QlQ9/DIVlOv1eby0Slhek7IACFdGT9K0b1Ho3Ts7eygCF
         IWeeEqgjb50hbCZjFfUOvJNdCSZJ1oa5oXECFeniGy0Q97YEoTNlyQikIQUaDQliXhwI
         8RqavMGnHahnfJacYdCb2gLLZ9Kc9YdXWociE+WbvKwCDPNd2PiUnqmjzV/UHaxjOVB4
         kYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:to:cc:subject:from:references:in-reply-to
         :message-id:user-agent;
        bh=oCqldMpOoahK1Z20XtKNSbUZVKynuD1kFyXlvJNqAuo=;
        b=ulcr4kefhq7YBBUeoQZiFaH9iSSO6LexdNhqAbAj8wkzy/2sVB4iEOHbVHcJLpYNi9
         kAf1Sws0gR+4yeMSHSnFk4qrrbzjBV3qtgPHP0pBMVGAks/e7cp9C06RYEfygiDJstbn
         8lRP6Lzns/d9kQE2N5qSIh4oG3lZTMjn3juGXOs9FmpDZYJPlOyB3+ESXHit78/ugwsi
         l8tlRfLXb0VUcLmURZ0Zf4yw6sXJimXQznU+HMo9X9RScfR6wQzrYzZji47G58LXZXKC
         bi4luQi+vvNOGEFkhx7NlljaZVXdEqEOOrqZ0hAsz9RSLstXZLpsyIT/dbwghe3y6B/D
         kEpQ==
X-Gm-Message-State: AOAM532gINykdyB7hSx/LwKZfZsmbw/aZ1hDCveTxrjgKA4uUewKAk1n
        MxdeEaH7XdccHVkTzR+EdCc=
X-Google-Smtp-Source: ABdhPJy+yE32tVcy+vgKm4oqBRJZrhLh8OSZLQrJJSk4m3RBwafT+xqkfVqxbOpvrLtV+FS/muB1kA==
X-Received: by 2002:a17:907:7204:b0:6e8:c19e:93da with SMTP id dr4-20020a170907720400b006e8c19e93damr9240345ejc.695.1650291432291;
        Mon, 18 Apr 2022 07:17:12 -0700 (PDT)
Received: from localhost ([2a02:169:1e9::acc])
        by smtp.gmail.com with ESMTPSA id fx3-20020a170906b74300b006daecedee44sm4618799ejb.220.2022.04.18.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:17:11 -0700 (PDT)
Date:   Mon, 18 Apr 2022 16:17:11 +0200
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     "Daniel J . Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: deregister home LED when it fails
From:   "Silvan Jegen" <s.jegen@gmail.com>
References: <20220415100432.23453-1-icenowy@aosc.io>
In-Reply-To: <20220415100432.23453-1-icenowy@aosc.io>
Message-Id: <39QNT1MSMJLC1.2M2V40UQZFSEE@homearch.localdomain>
User-Agent: mblaze/1.2-7-g31dd7c5 (2022-03-20)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Icenowy Zheng <icenowy@aosc.io> wrote:
> Some Pro Controller compatible controllers do not support home LED, and
> will fail when setting it. Currently this leads to probe failure.
> 
> Change the code that fails probing to deregistering home LED.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

I don't have a "Nintendo Pro Controller"-compatible controller to test
with but I have compiled a Kernel with this patch applied and can confirm
that the original Nintendo Pro Controller is still probed correctly with
this patch applied.


Cheers,

Silvan
