Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6707A5105F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbiDZR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244713AbiDZR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:56:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1806113E8A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:53:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv2so3778650pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNBpegmlEb8lPElw5+RDYmYOOWqbIDI2DwiLAWeIw7U=;
        b=OeOXi3uSULB9EIP3d8f5Ia0fNoK6bP4qdUq2yHmlvn5M/fiNqn9SlyndfbcYjNh2pS
         uxwuyYo4wCtJKikiMN3o7fkSfN10D0wS8yxUaVRe3By02qt7ClwdhLWNa8P4+h6LMQ8R
         cenPKLXDlCvwyt09dLZ7JjQHmo5AcOSO1SoAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNBpegmlEb8lPElw5+RDYmYOOWqbIDI2DwiLAWeIw7U=;
        b=Xb/nR3UFN4MyYhx3bOnuVycIQ6DQ94CjQ65KQpZuc0abheDm3Fqfjtl2kz3npgtPjc
         /sh9j7mIeczBZQ/6eY0TJCZX0mMpd7MMDQ7u8ANSXQghW13F20Q/KS2MzyCnOau4lEQR
         gHR0vJACEUjlo9UllCa+bSEYqMp7V6qb8C4A1kGq8YT3Io+3LtPHOXfdhKgkJwNSKaw4
         bhk2nzy/Tp1n/dIJRU7+f/FPbQ9mGgaJe/WgGkWscBujymzX/vbTiyiH1IW9NWQ3CeMr
         cd3Wh27Y+d3JedcoIIzV5iPV+CjC4hGuSW7wwi/kz+ffP8HgoTB/4YoQPmiigaioL7IR
         UjpQ==
X-Gm-Message-State: AOAM532uhty+2n+Gmm5XlO16vNwnWQ6I/s/fhyvPL7OoBTiXf1oVtbFq
        2Dee7EA6mplOEKb0+wVFyFA1gQ==
X-Google-Smtp-Source: ABdhPJwhYYoupIid129Fuln8m6ZL7hFV/cbFMriZO1n71iloLpLHkBUTZunjtuVzrz4OMcipUYIVsA==
X-Received: by 2002:a17:902:d70a:b0:158:7f07:e7c9 with SMTP id w10-20020a170902d70a00b001587f07e7c9mr24469482ply.109.1650995587582;
        Tue, 26 Apr 2022 10:53:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm17727854pfl.148.2022.04.26.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 10:53:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com
Cc:     Kees Cook <keescook@chromium.org>, catalin.marinas@arm.com,
        luto@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        will@kernel.org, alex.popov@linux.com
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Date:   Tue, 26 Apr 2022 10:51:00 -0700
Message-Id: <165099545363.893398.5975919098164892758.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220425115603.781311-1-mark.rutland@arm.com>
References: <20220425115603.781311-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 12:55:55 +0100, Mark Rutland wrote:
> This series reworks the stackleak code. The first patch fixes some
> latent issues on arm64, and the subsequent patches improve the code to
> improve clarity and permit better code generation.
> 
> I started working on this as a tangent from rework to arm64's stacktrace
> code. Looking at users of the `on_*_stack()` helpers I noticed that the
> assembly generated for stackleak was particularly awful as it performed
> a lot of redundant work and also called instrumentable code, which isn't
> sound.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/8] arm64: stackleak: fix current_top_of_stack()
      https://git.kernel.org/kees/c/b9f8167d08e9
[2/8] stackleak: move skip_erasing() check earlier
      https://git.kernel.org/kees/c/b7d6315d1d7c
[3/8] stackleak: rework stack low bound handling
      https://git.kernel.org/kees/c/1f4f72d1d99e
[4/8] stackleak: clarify variable names
      https://git.kernel.org/kees/c/52a2aa794e0a
[5/8] stackleak: rework stack high bound handling
      https://git.kernel.org/kees/c/83301ac044c9
[6/8] stackleak: remove redundant check
      https://git.kernel.org/kees/c/0cd7ee6880c7
[7/8] stackleak: add on/off stack variants
      https://git.kernel.org/kees/c/9bb0b174fd2b
[8/8] arm64: entry: use stackleak_erase_on_task_stack()
      https://git.kernel.org/kees/c/6a5927e73497

-- 
Kees Cook

