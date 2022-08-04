Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E706E589D91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239791AbiHDOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiHDOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:36:20 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2332060
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:36:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z187so9615239pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=q+k2/oQCg1jExDf3V4wAMLxe+YHu3Cav2Cj1hEhSNaI=;
        b=hE/oiEFnClv6y9rBHS2KMK6uuYGV0bVD21qZwtxdqZZmyh8k38w/J6Qot3ihBwHCsr
         +9bjT8zHi1y2HAOFKWIAT0cE2At/qgXJNxJMte7A2oqMd7MD9csFv3Hi4a75c5HMJ2iA
         GtwMS+oGPYOklrpW7S0botKdD3HBD3wXtRpXfjlQYKeW+mGGBCAJjfGk0Jfbgih5+NLr
         pD+VnyUgWZ2lTvRKRodcgEjHjACT105SBfJGerMo6oqdwY6tfVz7XNgUK6YEX5wtZ1vk
         vCcHZ9gczAibbdkDA+LGnxCrdEt+13gYZhYXchttcZhGXn+L38dkEeV0oZvFKdNWgy4H
         n+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=q+k2/oQCg1jExDf3V4wAMLxe+YHu3Cav2Cj1hEhSNaI=;
        b=HtpDxB+SHuplgxNdYTBSxezKCDKRI1RRU35kPeAarCk5pD+6cfeYKdPP4l6EsSVah3
         hJ2IHv6eCWCh+QE50mk36H/sOQ6NF0GvcgXVJ2eOHrzB8sbfOMa6WwKGknTPkvI5nWcC
         EJ4uhLSoobJP3St+B1R+lIZahP94qz5xZvjomeLQgAPooilyA2pG0v+PJI+YCLYLPWHk
         RpRz26RaPZrPaTrPXn0dPudAXXg+IOLeuG4Tz7dCkeb3MuNVCKMfGLLLPZhA8W0epJSw
         3R6b+p0b7PiKqzlT+LbglevN0sLMJytAaqaGV09l5xM0EniuT6UHfIFhJktLbx3+MGn0
         M73w==
X-Gm-Message-State: ACgBeo1B/0o0Q+QD+Rb+TZch57eg+bJlIkUDJ2HXXhU27ai7wQdRjTFr
        ZiJXBL+0uEuHAOPJKA7L/y8GAQ==
X-Google-Smtp-Source: AA6agR7McvvMMvvmO1Lg8S2YS4nUVsullv7y6a/2XZIXBqXo7EJcpWXdQpN/AKwj5X+DJQwZRxS8eg==
X-Received: by 2002:a63:82c2:0:b0:41b:c0f3:39b3 with SMTP id w185-20020a6382c2000000b0041bc0f339b3mr1878157pgd.86.1659623778954;
        Thu, 04 Aug 2022 07:36:18 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090300cc00b0016d2db82962sm1084731plc.16.2022.08.04.07.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 07:36:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     paul@paul-moore.com, yepeilin.cs@gmail.com, eparis@redhat.com,
        asml.silence@gmail.com
Cc:     linux-audit@redhat.com, peilin.ye@bytedance.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220803222343.31673-1-yepeilin.cs@gmail.com>
References: <20220803050230.30152-1-yepeilin.cs@gmail.com> <20220803222343.31673-1-yepeilin.cs@gmail.com>
Subject: Re: [PATCH v2] audit, io_uring, io-wq: Fix memory leak in io_sq_thread() and io_wqe_worker()
Message-Id: <165962377794.930556.772272743019429536.b4-ty@kernel.dk>
Date:   Thu, 04 Aug 2022 08:36:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 15:23:43 -0700, Peilin Ye wrote:
> From: Peilin Ye <peilin.ye@bytedance.com>
> 
> Currently @audit_context is allocated twice for io_uring workers:
> 
>   1. copy_process() calls audit_alloc();
>   2. io_sq_thread() or io_wqe_worker() calls audit_alloc_kernel() (which
>      is effectively audit_alloc()) and overwrites @audit_context,
>      causing:
> 
> [...]

Applied, thanks!

[1/1] audit, io_uring, io-wq: Fix memory leak in io_sq_thread() and io_wqe_worker()
      commit: f482aa98652795846cc55da98ebe331eb74f3d0b

Best regards,
-- 
Jens Axboe


