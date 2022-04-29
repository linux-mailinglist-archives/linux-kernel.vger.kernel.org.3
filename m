Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DA55153FE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbiD2Sxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380038AbiD2Sxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:53:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1CFD3A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:50:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id b12so7890049plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1HmvvieFlCfkGXvK05S5+zMzYlMfV0Veo9KAjtkzYQ=;
        b=mG+54AZfWbeW2iOtvNrKonJxh9Y6EHLlz4NF6ODAGEoXEFRaDwOfhLeMdp1rIQpQfE
         mLxZTl81cHPvVkWpS02N/atA4xBKvH29QbPVJxa7X3D4LPsCOeyL5L84ZpRn36+dMFpQ
         zl4k7cpRzsJJfPRt5F2Etc3fm9an44E3ehbSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1HmvvieFlCfkGXvK05S5+zMzYlMfV0Veo9KAjtkzYQ=;
        b=rAfb8RlYOVnjCAWCPxgveCL5cUT4kkZND2F4nn4U04He9VZLsuiJxVr0BNqzeX3ouN
         TTMfFASPj3uWNPQXc3BjnOUzNJNhKTJBPybt4t4Tn5wao9R+evMHA4jwna8Ru0xu6u16
         ggBOCSFaU8qfWQ0YFnRl3qOKarGc+jSjCNJPPgMgWIDiyWoPMDo3xQoqA9P9rQnkzCOq
         kPgbOqFuCDi6AN7KfL9e2nEZGHlmZDxlZuBe00QKPRtcS49CrNILbeZ8HwKXceh1fLgV
         fp3M+pcZZ/BxVO/Augq4gEXxno8IzWeO1Uv8vxJ3PdnHcFHEOg9Dr8wp/a3gFYfFiTTC
         +pZg==
X-Gm-Message-State: AOAM5326/sqPboDcAm00w6dz2vicLnNhIIY6fUA6iTOCpsVPNlZ3DX1y
        yCSX+iySS0YOmDTzaqZ3pW8lYA==
X-Google-Smtp-Source: ABdhPJxqp89qRTzazuzJHEtLuCjuwXdbP+xCW34JcdB3W2yXFK+N3EAnuzcBz5kG9jCcqCz5gznw/w==
X-Received: by 2002:a17:90a:a82:b0:1da:3763:5cf5 with SMTP id 2-20020a17090a0a8200b001da37635cf5mr514716pjw.55.1651258226674;
        Fri, 29 Apr 2022 11:50:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j189-20020a62c5c6000000b0050d59986dcdsm3866310pfg.208.2022.04.29.11.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 11:50:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, sargun@sargun.me, luto@kernel.org,
        tycho@tycho.pizza
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 1/2] seccomp: Use FIFO semantics to order notifications
Date:   Fri, 29 Apr 2022 11:50:00 -0700
Message-Id: <165125819819.3692727.9306925856353932810.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428015447.13661-1-sargun@sargun.me>
References: <20220428015447.13661-1-sargun@sargun.me>
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

On Wed, 27 Apr 2022 18:54:46 -0700, Sargun Dhillon wrote:
> Previously, the seccomp notifier used LIFO semantics, where each
> notification would be added on top of the stack, and notifications
> were popped off the top of the stack. This could result one process
> that generates a large number of notifications preventing other
> notifications from being handled. This patch moves from LIFO (stack)
> semantics to FIFO (queue semantics).
> 
> [...]

Applied (which comment typo fix) to for-next/seccomp, thanks!

[1/2] seccomp: Use FIFO semantics to order notifications
      https://git.kernel.org/kees/c/4cbf6f621150
[2/2] selftests/seccomp: Ensure that notifications come in FIFO order
      https://git.kernel.org/kees/c/662340ef9218

-- 
Kees Cook

