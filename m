Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6534B5C61
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiBNVQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:16:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiBNVQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:16:29 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79DA111DE7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:16:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c10so5795332pfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CzXZHBrjrvvHPuFEDIUoa2XYSCdiIOC+ZXymIl1Gq0=;
        b=DLytup8/nMFdOQpyOX32iLWswu2Lulci0Fe3QMhFaiTB94l2eFbralSxvQAHWw0Abi
         eMBgf9GgT+3emlXnMtYFbLB8+fCbzYJCtn5FPEK0aM6ahcRxN/pBwtNPTnwicu4pOuMN
         h1eKmzTSyxcEdz8Xf9DJQZvl62kNNYWtiHsrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CzXZHBrjrvvHPuFEDIUoa2XYSCdiIOC+ZXymIl1Gq0=;
        b=3H+b+mrMZxBs5S3d7C5RHIBIQ/Zq4nnqMyQxZ0ciw21TYUA0feQxb7m3TGhMFmACLF
         TiUzV4hx0XXIYgTnEuY/8zNOi8Fkqn+z1vNUMbki7XIdjnQv/CEM5bN5j3YcprK4564E
         2XvirR9E+ALJMGsq7dvN652763eaRhyHUIqCBMXpY16hykmOGTcUqthY4wGhX5HvflxD
         QuOvn8/V/XV3hYDBTxbxoXE5v7qpKoMpP2pSpor6rYxAsR4Ln45cD1QhWJtL4NR+INHj
         Ze/obDcO9gTjCsoUvh/yjoTHTWSPtmWG7PZycLMe0OEg68YBwzdp3C5DyJpQGkGbFlEL
         j3Pw==
X-Gm-Message-State: AOAM532wvDogJZGNiT8x6PcXzhGF6CHdrJTiUdwV7ZqOIejPVOFD4Izk
        HIQx/SRwnHso9uwk4V//B9FX3kl3mCM/5g==
X-Google-Smtp-Source: ABdhPJwEa/+o++xM1jvGn6J4uA1jnNEs+L6LOssFo6u6kFTNXF/whFKH0nAMuVk0P4sIE7mk5RwzkA==
X-Received: by 2002:a65:584d:: with SMTP id s13mr389414pgr.369.1644866055556;
        Mon, 14 Feb 2022 11:14:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id oa10sm12985799pjb.54.2022.02.14.11.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:14:15 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        kasan-dev@googlegroups.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Elena Reshetova <elena.reshetova@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] stack: Introduce CONFIG_RANDOMIZE_KSTACK_OFFSET
Date:   Mon, 14 Feb 2022 11:14:03 -0800
Message-Id: <164486603894.3748820.17377347049312013591.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131090521.1947110-1-elver@google.com>
References: <20220131090521.1947110-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 10:05:20 +0100, Marco Elver wrote:
> The randomize_kstack_offset feature is unconditionally compiled in when
> the architecture supports it.
> 
> To add constraints on compiler versions, we require a dedicated Kconfig
> variable. Therefore, introduce RANDOMIZE_KSTACK_OFFSET.
> 
> Furthermore, this option is now also configurable by EXPERT kernels:
> while the feature is supposed to have zero performance overhead when
> disabled, due to its use of static branches, there are few cases where
> giving a distribution the option to disable the feature entirely makes
> sense. For example, in very resource constrained environments, which
> would never enable the feature to begin with, in which case the
> additional kernel code size increase would be redundant.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] stack: Introduce CONFIG_RANDOMIZE_KSTACK_OFFSET
      https://git.kernel.org/kees/c/8cb37a5974a4
[2/2] stack: Constrain and fix stack offset randomization with Clang builds
      https://git.kernel.org/kees/c/efa90c11f62e

-- 
Kees Cook

