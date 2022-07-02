Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA56563D77
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 03:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGBBCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 21:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGBBCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 21:02:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07F13AA69
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 18:02:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d14so4143734pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+QLbq0w+CZfYo6/BgLDLv123MX+VJmesqUpPeKC97pk=;
        b=WOVRwA7HSikldTi++/cqjLgkGyx1K0hCf5nuW4OrFlAXhnRTSF+Y/yNNej6ML6yzcE
         V6nLGsFv65rOYWATYTvQBSr/zmmYpBIMTmmdr5IW1yWU/C9qqD6ZjH2/SBxE8T2AFOnb
         kI4fj3fTeYBB7YR2SCUhm9s0bMSGtNGi6k09c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+QLbq0w+CZfYo6/BgLDLv123MX+VJmesqUpPeKC97pk=;
        b=E/aGpPnlFUacwaew4JAYt74vhgc24qb80AateD4XGVX5KcTgU6BIvvsqnAOqDfxai/
         GMNbhkvfgv58D9tc2H1BXoxCyJ3yAWB/EvyPaQX6MlAFgdd2tGI4NjaqIjDX0qHcMpeL
         PjXaf3D0Hb74ZrHrGUzY5vAGMUjNbfU65Oju+95XnUNKF6lIhjLEcqdC/hNOxHDtMOjn
         cnHv7lk4j4QqmQMZDShHFmyqw4qK/xYTteQNfMohuU8OxaYc5L5gfnUVAWofiBJEzQam
         gpcZa826dFBrnLjV/+zB8OuwnD4qEhwKQq/6oproySYu+KSqjNl5xXhvUX3Joy4792nN
         /T5g==
X-Gm-Message-State: AJIora89wQPHxb+i7wUDEkDL748tgbx0I6PzFcwbuatDJiM3Nfpjetbb
        mggSDuzHtrGqmhyZTxVqHXaPjQ==
X-Google-Smtp-Source: AGRyM1vr8gIh5aKj2l7LLWkGGNi1HXOfn7r3prwi2OEXDiHlxyrQv2BZHDG3gbMUAKS+m12eq68kNQ==
X-Received: by 2002:a17:902:ea07:b0:16a:2833:3207 with SMTP id s7-20020a170902ea0700b0016a28333207mr23231909plg.86.1656723768114;
        Fri, 01 Jul 2022 18:02:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b0016a11b9aeaasm16113169plp.225.2022.07.01.18.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 18:02:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     gongruiqi1@huawei.com, elver@google.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, christophe.leroy@csgroup.eu,
        xiujianfeng@huawei.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] stack: Declare {randomize_,}kstack_offset to fix Sparse warnings
Date:   Fri,  1 Jul 2022 18:02:43 -0700
Message-Id: <165672376092.2486882.1451446093485208376.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629060423.2515693-1-gongruiqi1@huawei.com>
References: <20220629060423.2515693-1-gongruiqi1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2022 14:04:23 +0800, GONG, Ruiqi wrote:
> Fix the following Sparse warnings that got noticed when the PPC-dev
> patchwork was checking another patch (see the link below):
> 
> init/main.c:862:1: warning: symbol 'randomize_kstack_offset' was not declared. Should it be static?
> init/main.c:864:1: warning: symbol 'kstack_offset' was not declared. Should it be static?
> 
> Which in fact are triggered on all architectures that have
> HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET support (for instances x86, arm64
> etc).
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] stack: Declare {randomize_,}kstack_offset to fix Sparse warnings
      https://git.kernel.org/kees/c/375561bd6195

-- 
Kees Cook

