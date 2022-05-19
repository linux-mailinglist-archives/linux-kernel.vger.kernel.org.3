Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66B852DCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbiESS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243895AbiESS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:28:31 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E03CC17B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:28:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q203so6691501iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ND7f0vx9pZeDMhgR5d9yPNpUzi34XU/+i7olrPBQCuY=;
        b=YV/qjkXoecsS2oe33P2wBJVytQp5MTWs64Kic5Q17lfWu1L9Ak2YJdLZ4P4iuiad9K
         COZ9O9ZvugCVGcREEHB0hxB9z3MAuj8zBelSYydaU8xvHymcbQ1ApvBKgSBQsOlLECp0
         LYV+rwYq1hkXaaEcaV8VSICXBFJu5tSmpai+xnirfZDpxVIzdK3jJqPAKQ/E3Tw9ggAR
         gTnZUFQ2xP7XxJWZzk3rG1QNNhxPxCtifvpPdxDKQSp/N9TD497gJv6/8ryHh8wAlkOd
         j2HUGsAoaXnlzXFdWDuKLeu5u86cfsLci1M/EILpIz6ABcmTVZ58cg4Y6ousQOO8+45E
         OtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ND7f0vx9pZeDMhgR5d9yPNpUzi34XU/+i7olrPBQCuY=;
        b=xpNhWM18QMwwwoWcWthHVYLRG8XG3ZL5Efmg8gy8DBJstVTU52Ynbwt/tbiTOc16wV
         2g5r2XTMes8JM/umTRBiJweSCJRBcs7ixK54OdRPB5K4u80JBWUj9vXJc5z6MBCFXQa3
         JKopUmB/IMf2Z0aNfsgzY9NnAE1kV32APmWecKtsTAOZJHAchkbaXQug2LwHb3gwenyz
         woOMiIeNRuQ6lKV1/VyxJSk1M0yJ/IrYf1mIuf/GKzHm1XDR2T84HPUC5b9zGTe8Wo4U
         7c1VjMOgfpRRzGs1xEboMOkPOsK2ZaQHJer5EZbBItkW2BT8+34s9ihJBU17Q6t2OD2I
         tU/g==
X-Gm-Message-State: AOAM532DqqXTH4tI9kpO+QUIJWrtBOf7CrHWsdo5XxhK8t/0S3LoD8jI
        c8Dyjor3Z+mzU8a9ldqar6X3Uw==
X-Google-Smtp-Source: ABdhPJwyRboO1Ja53YC/vxYKpauz0w2zyTeorZnthVC36rGlGpNJwpzh4MC7zHK+OQbTjKDzNmiRGA==
X-Received: by 2002:a05:6638:d87:b0:32b:abdf:5867 with SMTP id l7-20020a0566380d8700b0032babdf5867mr3348125jaj.216.1652984901976;
        Thu, 19 May 2022 11:28:21 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s15-20020a92cb0f000000b002cd7dc16ae4sm1481072ilo.1.2022.05.19.11.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:28:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@infradead.org, Vasily Averin <vasily.averin@linux.dev>
Cc:     rostedt@goodmis.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        mingo@redhat.com, asml.silence@gmail.com
In-Reply-To: <6f009241-a63f-ae43-a04b-62841aaef293@openvz.org>
References: <2eb22fb3-40cc-48f6-8ba9-5faeae0b43ff@kernel.dk> <6f009241-a63f-ae43-a04b-62841aaef293@openvz.org>
Subject: Re: [PATCH v3] io_uring: fix incorrect __kernel_rwf_t cast
Message-Id: <165298490113.98310.14692453666034246336.b4-ty@kernel.dk>
Date:   Thu, 19 May 2022 12:28:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 17:30:49 +0300, Vasily Averin wrote:
> Currently 'make C=1 fs/io_uring.o' generates sparse warning:
> 
>   CHECK   fs/io_uring.c
> fs/io_uring.c: note: in included file (through
> include/trace/trace_events.h, include/trace/define_trace.h, i
> nclude/trace/events/io_uring.h):
> ./include/trace/events/io_uring.h:488:1:
>  warning: incorrect type in assignment (different base types)
>     expected unsigned int [usertype] op_flags
>     got restricted __kernel_rwf_t const [usertype] rw_flags
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix incorrect __kernel_rwf_t cast
      commit: 0e7579ca732a39cc377e17509dda9bfc4f6ba78e

Best regards,
-- 
Jens Axboe


