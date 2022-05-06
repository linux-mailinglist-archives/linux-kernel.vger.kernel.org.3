Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5451E02D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443074AbiEFUhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiEFUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:37:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AC16D4CD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:34:06 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q76so6947324pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZ19ALwGfeHS9iaFuA2ZzP6YyLhWOKvVYrp4nK5KLQc=;
        b=lNEBKjnJDvy0Hq6IRt/ElaWOnKrUKBijImtjmZvZ+t52bUZK5rVDUYNZs2jIL570cZ
         d5DhsEboJAVF0FSgiSit8wLlXX3iqQ4ZTfOJF8tMcVIY+C/6cuswORY6BHHbw1ygSXf9
         pY1c/DTpFr4HMU+MBQJiHMsNZYzok9T5A3WBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZ19ALwGfeHS9iaFuA2ZzP6YyLhWOKvVYrp4nK5KLQc=;
        b=dtQ3cRFpv1pVv7rJSOrbuR/M38GwyEs0Oknce3xwfyi0shEz1RM1DARIkapNqfWGy9
         DPiDmlP7QvBsTFDnMxxsNn7gy37QR5gA2G1aaEUnr5VEKxBqDdv+YF04kpruigd6PI7y
         vti2d0kKcl5sCC8PCXqvAlLvHsc42GmY8Mt4AzWquTYMEUt494qUbo/pqnFDds3UXO7V
         SRnrg8oWJzYTWnxYLWdHUEapIDrrGGeLjgKmW6K99/UVehhDLQ9YX8Hi76MhyGYiWx+O
         T4cZbtzAgzPdBWbOi+Gb4bCoca949lNOhi1xK7CF3DVIOYMYOMrwOs6rKjkFhYH4SOTZ
         seww==
X-Gm-Message-State: AOAM5315V3XjJkY4X40uCIqhRIGgRzR3xyMO8pfXsrJipnBHuQYG3S0Q
        hieS2EL2lYt36YWsMNQEvdxVzQ==
X-Google-Smtp-Source: ABdhPJyAdgaXQye+VmOz2DpnHDLexYJOYwdCsJIjFfTv8l/nHNJH8My91Ib5HYnU4z9MgFeU+lnc+A==
X-Received: by 2002:a65:694c:0:b0:398:fd64:7422 with SMTP id w12-20020a65694c000000b00398fd647422mr4055208pgq.503.1651869246197;
        Fri, 06 May 2022 13:34:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hf21-20020a17090aff9500b001dbe7ccdd4dsm7783441pjb.10.2022.05.06.13.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:34:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>, alex.popov@linux.com
Subject: Re: [PATCH] lkdtm/stackleak: fix CONFIG_GCC_PLUGIN_STACKLEAK=n
Date:   Fri,  6 May 2022 13:33:59 -0700
Message-Id: <165186923712.2156651.13479757595045860724.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220506121145.1162908-1-mark.rutland@arm.com>
References: <20220506121145.1162908-1-mark.rutland@arm.com>
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

On Fri, 6 May 2022 13:11:45 +0100, Mark Rutland wrote:
> Recent rework broke building LKDTM when CONFIG_GCC_PLUGIN_STACKLEAK=n.
> This patch fixes that breakage.
> 
> Prior to recent stackleak rework, the LKDTM STACKLEAK_ERASING code could
> be built when the kernel was not built with stackleak support, and would
> run a test that would almost certainly fail (or pass by sheer cosmic
> coincidence), e.g.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] lkdtm/stackleak: fix CONFIG_GCC_PLUGIN_STACKLEAK=n
      https://git.kernel.org/kees/c/932c12ae7963

-- 
Kees Cook

