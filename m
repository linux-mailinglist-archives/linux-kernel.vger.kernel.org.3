Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A55B1013
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIGW6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIGW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:57:58 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC49D13E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:57:57 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so14970354pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 15:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=10mgHT7D1JugXcpwZyQXkkVRtSTijPUHWCXzbe4O+Ls=;
        b=JcTX9Q9/VzeI3zJcRVb9BMhFG96+5e2glSlZ3ZEcQXzGdOs4cuaFR2ORaO8oIGH5Ri
         FSN9sZiAwTSx9EWoUH/2Qs0923FRJVXJpKmlLXLN5rTyQ5PkcUsrQz0kSE8C3cuBkELL
         pnax4RkKXV2+CKD2gMhW3hyJbN9WjgzGidM4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=10mgHT7D1JugXcpwZyQXkkVRtSTijPUHWCXzbe4O+Ls=;
        b=cmt0FEhwvKh9ExZZGPqJGd0sECvanRjVZd6akPm0T5YwRmAZn6SXGUvc8jYBY0GrTq
         6WLOlqN7CYArhaqlyjl3ricoFsuc7A3grS7YYQO94C8SC0mfNufwle641GbhqZ+QwLRk
         jeMSCqMwWBQke0rt+9MlELi7Sk3D6GgTez0cexAW5pzz4iqrPVOelOmtoZvmrAE008nw
         UHeXtKCenPVX5ZM5Np6ypLwra5IBjq9Txp+gbBvNKNxdNCPT3+m3uSJxsdHosloMmJzo
         w48bMRP8n06QFj2oFOeH4GfCy3J3togvSyjX+iUt958zpBENhXB0qxWRuI4zIjSAf4mc
         GFUA==
X-Gm-Message-State: ACgBeo156uQO70rG9ybJaCfcTtHzoYoK+AQVU+sINowvf7pdf6Ziq+/9
        QpvEW9UbeYIlgapgc8Z8yDc0ag==
X-Google-Smtp-Source: AA6agR6W0ILjfeSoqjoWZDM510pNCKy5+3P3n+/9F0y2Gk5Vo2ggvijQIReupjh1p3Ilysj7LTuA6A==
X-Received: by 2002:a63:5007:0:b0:42a:29:2780 with SMTP id e7-20020a635007000000b0042a00292780mr5278391pgb.45.1662591477041;
        Wed, 07 Sep 2022 15:57:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11-20020a17090a528b00b001fd6066284dsm197002pjh.6.2022.09.07.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:57:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     bvanassche@acm.org
Cc:     Kees Cook <keescook@chromium.org>, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, isabbasso@riseup.net
Subject: Re: [PATCH] lib: Improve the is_signed_type() kunit test
Date:   Wed,  7 Sep 2022 15:57:52 -0700
Message-Id: <166259146995.69125.7877600733909106911.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907180329.3825417-1-bvanassche@acm.org>
References: <20220907180329.3825417-1-bvanassche@acm.org>
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

On Wed, 7 Sep 2022 11:03:29 -0700, Bart Van Assche wrote:
> Since the definition of is_signed_type() has been moved from
> <linux/overflow.h> to <linux/compiler.h>, include the latter header file
> instead of the former. Additionally, add a test for the type 'char'.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] lib: Improve the is_signed_type() kunit test
      https://git.kernel.org/kees/c/9d684f6d2d87

-- 
Kees Cook

