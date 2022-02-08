Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A985E4ADA8F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350821AbiBHN6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241623AbiBHN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:58:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716AC03FED0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:58:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c10so120706pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=TWs/pi13W9s3W1BKYFNV7ZvPA+qtn2fXWAaFncVNBc4=;
        b=h1dFK7T+x6tKeDpUl4n3poDM9S+jOvviadfLmhPCX+gbYVpqjzsWT1XlEUG4QMsJtl
         9lA76BKvnt2aj9GqEN2H8rOyxkUUNdU+/dUUKTevvoKT8+jfWnaBF2/N9lOfmBB49IRu
         INHnA2at1qEqhnlZvfA9Tgham9FSWtGzPFQXe8UlN2PxT7J27j9+ZQpcSrm21h3+S23L
         iu7lum6Dkjc0ixmjWSDonMksCILvz+WeAgkkstdkw0tSD9qMtcY5J4Y+JeGOGxdkYiC7
         WCcNcgFAeRN3T20wd3uz706ZzsK+nx8xS4rUXHmxFv/TW+gVHgVu5vod4pGhs91HJB+b
         ZZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=TWs/pi13W9s3W1BKYFNV7ZvPA+qtn2fXWAaFncVNBc4=;
        b=7rECb2AqTIEFvlnbwHjy0JWewEhakNT7tdRtySQCHebNaDksuxtvxD46Mo1HAIhiUR
         vXPNfhwCXUKecrEoAa0NRgK68BRL0+BBSB0Z4b38Mf7mhgAMAxVf1ygeAWdfIZGiRt+L
         cqjm2Y/I7dXBO+u1erwtUFDFhqC6Y+4nUnCpk39G0TWvop7be02RKDSsbdNDuws2HSup
         x/biyFvTmVyE8PnR3mq7bH9LlLQYi4zTZHewrhy6FfPgbXBko8ZyVeipfw+G7ZoZJ5cT
         uF1glq+wL41CPIg8lHbxBm3tHnu2iXkYB47r0Cn1tiZbbFC2qmbALiqtxpIjnAE8yDRr
         2ELQ==
X-Gm-Message-State: AOAM5310K7Cw9NiJtGI3ZaRqprpWlxkiyQgr8795tut200N7iguH+iQ3
        79I/6xtHxL6v3pGVWa0+O8uddg==
X-Google-Smtp-Source: ABdhPJy7q/1xZcvfVJMi6L+HZwmnOXPzp77GcmF1iJM72OVwmKxFxaYTjzQtUQFdpbLTmrwsi3bseQ==
X-Received: by 2002:a62:15c3:: with SMTP id 186mr4589768pfv.59.1644328682188;
        Tue, 08 Feb 2022 05:58:02 -0800 (PST)
Received: from [192.168.1.116] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x33sm17673119pfh.178.2022.02.08.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:58:01 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     io-uring@vger.kernel.org, llvm@lists.linux.dev,
        Usama Arif <usama.arif@bytedance.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
In-Reply-To: <20220207162410.1013466-1-nathan@kernel.org>
References: <20220207162410.1013466-1-nathan@kernel.org>
Subject: Re: [PATCH] io_uring: Fix use of uninitialized ret in io_eventfd_register()
Message-Id: <164432868079.113641.15442485560114247466.b4-ty@kernel.dk>
Date:   Tue, 08 Feb 2022 06:58:00 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2022 09:24:11 -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>   fs/io_uring.c:9396:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>           return ret;
>                  ^~~
>   fs/io_uring.c:9373:13: note: initialize the variable 'ret' to silence this warning
>           int fd, ret;
>                      ^
>                       = 0
>   1 warning generated.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Fix use of uninitialized ret in io_eventfd_register()
      commit: 4c65723081332607ca331072b0f8a90189e2e447

Best regards,
-- 
Jens Axboe


