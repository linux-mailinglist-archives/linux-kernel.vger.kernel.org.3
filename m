Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34A5519007
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241154AbiECV0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbiECV0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:26:20 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273954161C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 14:22:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id iq10so16469115pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6A2AVhB3i38hjuJtf8B4kMF2LM5SwI8v95owoTGlIsU=;
        b=UC8VXG9FGdX/1g+XOAF13irYs/uk+mdl7nSt8x98nbXKE0wpWdXE6gYGpBwNpWxu98
         jMjyJU4+N/hc/02fCPsPrCvuAOssY4pwc24mkepgMOTYXM3RLqsFzJ09JHMeol3bbdmw
         zOlPc9Q/5bpqP5fW5PD4OMa10kxdUMtmzK3mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6A2AVhB3i38hjuJtf8B4kMF2LM5SwI8v95owoTGlIsU=;
        b=Pt49tSiGoQccKDOuDN57bCLykhPBKm0tfa5k3e9RYjCsLAewpK2yTTqL2qTKurX1AW
         MtLntgbdftZ6cemva6Gzwh+qCuGQZriUU2RF9Dv6gOR8G4K67Ng7mUOfYBs8uG1uVlKW
         TLjMUVY4QxTItKaQ0bbbIvKZGk6xcM3MsuB3tHfbyxi55y5dsNkojT+wWPpbDiVDMPIx
         oF7jdNNM9A2nlSjMhFra+d53/o55IsRyBRX/rrIFHWGmdlvUfhrN5KIKw7PIhPtb9Bae
         7qujpwYTK9i9mwgRG6SqG5N+WXU2g1boVP97eHvs1gSAo7jmQBZN5L2IaES28lhIGi0B
         yrIw==
X-Gm-Message-State: AOAM532SZ6/ji/IXOZfQS/2gxIc0GeVGoYNwjHniXkOm3s8na5izFBX7
        88JWh+PgimJrLYh8HzSWkyUPzQ==
X-Google-Smtp-Source: ABdhPJwH9lF9KQCbmuD8slVOXedC8OmP9j4blY1Jned8m/4YkGG9MTBcrnge2aG6a+EkUXBBDPEPvA==
X-Received: by 2002:a17:903:248:b0:155:e8c6:8770 with SMTP id j8-20020a170903024800b00155e8c68770mr17930962plh.129.1651612966688;
        Tue, 03 May 2022 14:22:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g20-20020aa78194000000b0050dc762818fsm6786947pfi.105.2022.05.03.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 14:22:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, sargun@sargun.me,
        containers@lists.linux.dev
Cc:     Kees Cook <keescook@chromium.org>, wad@chromium.org,
        rodrigo@kinvolk.io, gscrivan@redhat.com, luto@amacapital.net,
        alban@kinvolk.io, tycho@tycho.pizza,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 0/3] Handle seccomp notification preemption
Date:   Tue,  3 May 2022 14:22:30 -0700
Message-Id: <165161294755.3926933.6572056353019699340.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503080958.20220-1-sargun@sargun.me>
References: <20220503080958.20220-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2022 01:09:55 -0700, Sargun Dhillon wrote:
> This patchset addresses a race condition we've dealt with recently with
> seccomp. Specifically programs interrupting syscalls while they're in
> progress. This was exacerbated by Golang's[1] recent adoption of
> "Non-cooperative goroutine preemption", in which they try to interrupt any
> syscall that's been running for more than 10ms. During certain syscalls,
> it's non-trivial to write them in a reetrant manner in userspace (mount).
> 
> [...]

Applied to for-next/seccomp, thanks!

[1/3] seccomp: Add wait_killable semantic to seccomp user notifier
      https://git.kernel.org/kees/c/c2aa2dfef243
[2/3] selftests/seccomp: Refactor get_proc_stat to split out file reading code
      https://git.kernel.org/kees/c/922a1b520c5f
[3/3] selftests/seccomp: Add test for wait killable notifier
      https://git.kernel.org/kees/c/3b96a9c522b2

-- 
Kees Cook

