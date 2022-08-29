Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF90D5A5466
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiH2TRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiH2TR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:17:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A24861CC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:17:29 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id 142so9134605pfu.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LqiSQtiYuVL1ecXee8OUOZdp37JPK7bP8P9AZBcEbkg=;
        b=gmykxVysfm0PCJsyeiiVv8HQmm2DfyR3whf2iTrx8/Wefg2dJYJH070OT4pxr7poye
         YZ7afeUPoDrO0ifShSYLo9rWHAolwFW3284rKb8kqr0DEyXxdp/g+ZDlk8fHjqvGSeQ/
         m0KyyxXSDA3ZbvJMXXZwlvRAvFtn+ZTM5TSMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LqiSQtiYuVL1ecXee8OUOZdp37JPK7bP8P9AZBcEbkg=;
        b=HbCsQR4VXfdfAFzE4y8QSlzFbW+K0jShYEJ3qtsUtwrUzCVoYGnzdcpuxMg/Q4iQ8C
         3gGK6iRxDgaDGPqe32gYRrt6YTf9v5iR/IZDYwSNXvb0KVu8epdCde4SGLe3Ma4/vqSn
         29zSprUW/KFAFIgoKFKP2CJE9CQ28VM+ky2fwBEuLzl8+KUc2KbmIItEUhCiURdohJSM
         PrztGD4v5rMCWgt6sSEFpTX3H2Juni74hCC97pxe2Erdv4Cui4E6l6HK6JAhilU69337
         ngofLMN+rdfMuQWTTJCZe4GthFeqla3PfYlhCviQWd82xg0mjVsMxyRxYinIc3jCNf/i
         ZYow==
X-Gm-Message-State: ACgBeo3qt2E6fP11riFJy1T0OBz6iaVY3k/dDnrY4IBL2lkHWBRMKg6o
        3Ujnm4hLd5b8yDuVdNrdjcIsMQ==
X-Google-Smtp-Source: AA6agR55WB9B1KbGgkrObbUtotJ4LSnqj4D9RgZOumlYEm9jEzQBP2J3CSEiQYdmCFNnwTQI1SkJkg==
X-Received: by 2002:a63:e401:0:b0:42b:6394:f72 with SMTP id a1-20020a63e401000000b0042b63940f72mr15521402pgi.572.1661800648965;
        Mon, 29 Aug 2022 12:17:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mi6-20020a17090b4b4600b001f1acb6c3ebsm7140643pjb.34.2022.08.29.12.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:17:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     luto@amacapital.net, kuniyu@amazon.com, wad@chromium.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        ayudutta@amazon.com, brauner@kernel.org, kuni1840@gmail.com,
        syzbot+ab17848fe269b573eb71@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] seccomp: Move copy_seccomp() to no failure path.
Date:   Mon, 29 Aug 2022 12:17:19 -0700
Message-Id: <166180063676.3312920.11804502368990110703.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220823154532.82913-1-kuniyu@amazon.com>
References: <20220823154532.82913-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 08:45:32 -0700, Kuniyuki Iwashima wrote:
> Our syzbot instance reported memory leaks in do_seccomp() [0], similar
> to the report [1].  It shows that we miss freeing struct seccomp_filter
> and some objects included in it.
> 
> We can reproduce the issue with the program below [2] which calls one
> seccomp() and two clone() syscalls.
> 
> [...]

Applied to for-linus/seccomp, thanks!

[1/1] seccomp: Move copy_seccomp() to no failure path.
      https://git.kernel.org/kees/c/6d17452707ca

-- 
Kees Cook

