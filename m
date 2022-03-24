Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB84E6B31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353876AbiCXXXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbiCXXXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:23:41 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A5996AF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:22:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a9f8600b001c6562049d9so6619437pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zUQM6Pypin5vZWOhYEV9X90LwD1xQrx+yJ4zJatTvzU=;
        b=hbxV8gdzgIyV3gO9KUvn3S+htyp6FU5jF0ude7Oilxhx0TvjIAgKFQ+j4L3uN1sIxx
         PX2ZnJ1RBnKryssJxKeq2SCarsGBbg2NhzkPBTE6ZXNwDmZdfMSc5gZ+EeJDvHteSXAH
         0NUq5ygARKHGIiKSGijVtnaox+ZSM/WXxEfzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUQM6Pypin5vZWOhYEV9X90LwD1xQrx+yJ4zJatTvzU=;
        b=ngC3SglMr2lmw5hxX71M7oNjAHrSNaiCpOHL6+YCYoGWKVifGeXg3fddkyy1MdJSED
         sWptmd2dwwzX675rO6CtacdYjF0u+BLihsQCVpi6P34N4JEkCI8tZyhX8Qdl8LOClrMO
         OSD2KfZtynfuUjjyP6f9/+k4dihFkAUIZtMOdQl/f4M04Vk8T15kkOtAdr1UDUdZE059
         zFQxgYeGEXFal6p9D1XYYscTWTotQ6/uPAXyCliqzPHlbgi0pF8B1PwHIumpPFx5JqZG
         JuoArwGeoM+iwoT2egtJoRbBEJbWjQixOFPIYQJSCbdGWg7ij7axNYmlfmwGy2xXoeyp
         vr6w==
X-Gm-Message-State: AOAM530L3dZebWbRtt3dTgSzRxwfI3pyL9J5zUFKIPL+cEAHPq/rUzA3
        lKywVB/2Ygg0jkmnfS7fh84Ayg==
X-Google-Smtp-Source: ABdhPJwUsZY0aQGLp9G9FARBJjVfQRxKkGmJr1dQNJ/+GoGy0jMa5zpzIzRYohpJyWPktM4ft5NP1Q==
X-Received: by 2002:a17:903:1249:b0:154:c472:de76 with SMTP id u9-20020a170903124900b00154c472de76mr6740429plh.81.1648164128714;
        Thu, 24 Mar 2022 16:22:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 102-20020a17090a0fef00b001c7b8eea25asm3227961pjz.31.2022.03.24.16.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:22:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Will Drewry <wad@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] selftests/seccomp: Don't call read() on TTY from background pgrp
Date:   Thu, 24 Mar 2022 16:21:48 -0700
Message-Id: <164816410448.1364331.9275240397611057038.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220319010011.1374622-1-jannh@google.com>
References: <20220319010011.1374622-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2022 02:00:11 +0100, Jann Horn wrote:
> Since commit 92d25637a3a4 ("kselftest: signal all child processes"), tests
> are executed in background process groups. This means that trying to read
> from stdin now throws SIGTTIN when stdin is a TTY, which breaks some
> seccomp selftests that try to use read(0, NULL, 0) as a dummy syscall.
> 
> The simplest way to fix that is probably to just use -1 instead of 0 as
> the dummy read()'s FD.
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/1] selftests/seccomp: Don't call read() on TTY from background pgrp
      https://git.kernel.org/kees/c/1d27adee48cf

-- 
Kees Cook

