Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B47151ADA5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355969AbiEDTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355757AbiEDTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:21:38 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F113C289A5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:18:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id fv2so2079848pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RJ458gvu2KUZx9lG1pwBIKjP4BeRT8/YIZK4NnO4oyY=;
        b=Do0dXlMZ4W1vfBUdX+92o+0GKgu3uZLI4e2tkj5rlC3VvfGAyHGWK/Pu5A2p7fYCxb
         oiW4Q4iqZKHFmqTWa048UX7j3XctoQko0msUJJfFVhjAUQHsIW5Xro3txi6Ohw3ll2nI
         MxcVDocMB8aR2vBZ1Uqw8GU9MJhFbGq1JLSt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RJ458gvu2KUZx9lG1pwBIKjP4BeRT8/YIZK4NnO4oyY=;
        b=JrlOiGs/PrrPNcGuTNWbQRFTxUqY10or+2RFC8a3aPF6mWoOsLqjV0fmsUmFBoTAlk
         TEA+N2+hTGVunfOgFg72OptZlp5dCq56yWQMx01UbkqSADVhiSkZa8er0FrD8i2IqdHX
         D6omYt27qUuKosWGKw+WxhEbRR03Y6wolKw54N8N4/Wp2lZBCQd7j/wQFVHoVvh3D6zP
         skA9/A9mqICx8obmTYGbbMXgd+gEi936LvDURq06uymKgnMcqDJXXtnF9Qhvh1hKjs2L
         FZBxLCoja0MsOy2FZwRD8kN40XfdjXD8OxU0sohrhb14lR61XwFffwzevvPQZRFTJIet
         qn+w==
X-Gm-Message-State: AOAM533bR++7hDLT18Gv9bSKh/AHgnQWC9PkdwPgyWm0aENlj2BuShFw
        11p6/50TcSYipF1KWh5Ya/vocA==
X-Google-Smtp-Source: ABdhPJyd7mM+gd2ZuEYZdG+GHYfvr+RtBaQAY8PDsZhflxdnGLnhNLiCBzak8qO7cO0iccf+TcC7Sw==
X-Received: by 2002:a17:902:e851:b0:15e:d129:fb20 with SMTP id t17-20020a170902e85100b0015ed129fb20mr1993458plg.140.1651691881297;
        Wed, 04 May 2022 12:18:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b0015e8d4eb1besm6984785plg.8.2022.05.04.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:18:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, alex.popov@linux.com
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        catalin.marinas@arm.com, will@kernel.org, luto@kernel.org
Subject: Re: [PATCH v2 00/13] stackleak: fixes and rework
Date:   Wed,  4 May 2022 12:16:55 -0700
Message-Id: <165169181293.405194.8374667346806721563.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220427173128.2603085-1-mark.rutland@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
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

On Wed, 27 Apr 2022 18:31:15 +0100, Mark Rutland wrote:
> This is the vs I promised. Since Alexander wanted to look at this in
> more detail (and since this is subtle and needs review), I'm assuming
> that Kees will pick this up some time next week after that's happened,
> if all goes well. :)
> 
> This series reworks the stackleak code and the associated LKDTM test.
> The first patch fixes some latent issues on arm64, and the subsequent
> patches improve the code to improve clarity and permit better code
> generation. Patches 8-10 address some latent issues in the LKDTM test
> and add more diagnostic output.
> 
> [...]

I fixed some small commit log typos, but otherwise this looks great. If
anything new comes up we can adjust it.

Applied to for-next/hardening, thanks!

[01/13] arm64: stackleak: fix current_top_of_stack()
        https://git.kernel.org/kees/c/4c849d27b729
[02/13] stackleak: move skip_erasing() check earlier
        https://git.kernel.org/kees/c/e98a7c56d73c
[03/13] stackleak: remove redundant check
        https://git.kernel.org/kees/c/e45d9f71deea
[04/13] stackleak: rework stack low bound handling
        https://git.kernel.org/kees/c/cbe7edb47d3c
[05/13] stackleak: clarify variable names
        https://git.kernel.org/kees/c/e9da2241ed85
[06/13] stackleak: rework stack high bound handling
        https://git.kernel.org/kees/c/cfef4372a4b7
[07/13] stackleak: rework poison scanning
        https://git.kernel.org/kees/c/ff5f6d37e5bc
[08/13] lkdtm/stackleak: avoid spurious failure
        https://git.kernel.org/kees/c/23fd893fa0d7
[09/13] lkdtm/stackleak: rework boundary management
        https://git.kernel.org/kees/c/f4cfacd92972
[10/13] lkdtm/stackleak: prevent unexpected stack usage
        https://git.kernel.org/kees/c/c393c0b98d75
[11/13] lkdtm/stackleak: check stack boundaries
        https://git.kernel.org/kees/c/b6bf5a354eca
[12/13] stackleak: add on/off stack variants
        https://git.kernel.org/kees/c/96c59349a56c
[13/13] arm64: entry: use stackleak_erase_on_task_stack()
        https://git.kernel.org/kees/c/d46ac904fd35

-- 
Kees Cook

