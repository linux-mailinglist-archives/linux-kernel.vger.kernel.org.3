Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA924F0C79
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbiDCUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiDCUO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:14:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429134667;
        Sun,  3 Apr 2022 13:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87FE3B80C94;
        Sun,  3 Apr 2022 20:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA249C340F2;
        Sun,  3 Apr 2022 20:13:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LPTgZF7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649016778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MUat7NN72n+1zNfT5Ubj8KrEJni2YmnkaBwnTSYmZJY=;
        b=LPTgZF7Mp+FUNUaaqY7cDkLb+gfLO+8vbd/CEeOJxkkh1l5x3lkGr1tdVeqvks4y601pAG
        7WR6lQBwh06MbBwmoI8EX3ORnt+qC7zcDMB424pSyhJgcvoiyWt4zKMUqgmbDyQsujsE4Y
        PNzJhSRawkgJvEEaK3qGAPY2QN5he38=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id acb88c5b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 3 Apr 2022 20:12:58 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2eb543fe73eso20319437b3.5;
        Sun, 03 Apr 2022 13:12:58 -0700 (PDT)
X-Gm-Message-State: AOAM532lR0yxJOei6Mz0JRmyEekwUrrUZLnbyQ73t82IfgJStn2k7E+e
        QGGV1tYWw6XJS/4FFzT9vv4WaiKa5/iegZI9C+c=
X-Google-Smtp-Source: ABdhPJxZ0vwM8euCclIQ3J2DyAMZdXkR1F+uZs+VMAJjNe8IosQGzizLc+DKMceleXoYjbp2miH6G13Hxz4Foi0E4L8=
X-Received: by 2002:a0d:e8c6:0:b0:2eb:1a8e:19c4 with SMTP id
 r189-20020a0de8c6000000b002eb1a8e19c4mr14783144ywe.404.1649016777885; Sun, 03
 Apr 2022 13:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220401001325.281220-1-Jason@zx2c4.com>
In-Reply-To: <20220401001325.281220-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 3 Apr 2022 22:12:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9otYi4pCzZwSGnK40dp1QMRVPxp+DBysVuLXUKkXinAxg@mail.gmail.com>
Message-ID: <CAHmME9otYi4pCzZwSGnK40dp1QMRVPxp+DBysVuLXUKkXinAxg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: latent_entropy: use /dev/urandom
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Please don't apply this yet. It breaks -frandom-seed, so I need to do
a bit of digging and send a v2 or abandon this all together.

Jason
