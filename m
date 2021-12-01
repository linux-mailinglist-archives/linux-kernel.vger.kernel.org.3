Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4C2465115
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243554AbhLAPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbhLAPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:16:29 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF2C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:13:08 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so5341537oto.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 07:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/TJQig8oXy6tycDnyj0TV6wADrRCQncxZIkXq353b8s=;
        b=bJtsabtm8utUQlm1L/OXiWPn6QbVRzwGpsePeCFDAkBHtCI50LMa/76QoOMyQaUJ9U
         /L6bgeyF7+4pZzg/T82qJHh3jKgn9Dm7yrD+5B1mdDvd/SaD/q9A9A0AZev1k01cXjnT
         1Y7kFX6srovS5cyAiVrlomx4vzqT6hIdcqkdgUlV91/NUDiZ5eqTgYNpTWM+nMZu504a
         p+/xck6enG8asZJ9+lbP5Hd6kZgPrkOnzmOdHsyhSQJPn3l1PY829xM/5FsRKzB818bS
         4zM/fQexufqG7TaSKF82dPGwbJoyw22z8px2cHMYy1Ayl0IyrHO5O4SYGiaGqTzzSy4E
         dh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/TJQig8oXy6tycDnyj0TV6wADrRCQncxZIkXq353b8s=;
        b=pv/CHLWEQ9nGmh4N4k2mM+brSBbF4nyILqcoS2IZkJuxfqpfOb9TCxCoZNyRYDtxje
         fepVJRYlF+74bP6Nr1Bfgv8Oh9cj29u+bsSEUD6MzkOHQzc5nz7gQ2QFg5PFcy8rnXd8
         uDQAGHZz7IdIw2+xsrhjMsNOULgjksnBIuUskELlqBl4LkunXJtE/7LAGh2RxPGv9qsA
         jq3wmL88YOSXfe9bYBBn1I0jYtS+RocBcGmF3z+b2tKvCr/ZVX2uPi9qGqJO+y32qZtD
         gMjj0mvSUlEbfpANYA9o50loDZCJmWG7OASdAe2hS2IuVUXqHhphp065remaaDCgYDF9
         NL9A==
X-Gm-Message-State: AOAM531BZSZUVj4zHr8Hi+U0DyNYZ8BQOyUZhMuJoJ57IZpAfJo15KZ0
        4/jSOLRBgz+Qeg+oPFgd14ZeLVwI86iJcQ==
X-Google-Smtp-Source: ABdhPJxTHKffZfky0PlNyrW4xJRCnJFdiTB35Rhb5VWa8XaX25nM+RziFDi+fyGK6UlR39SuJ+9wZA==
X-Received: by 2002:a05:6830:12c3:: with SMTP id a3mr6245067otq.24.1638371587529;
        Wed, 01 Dec 2021 07:13:07 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id be12sm33933oib.50.2021.12.01.07.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 07:13:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     cgel.zte@gmail.com, nks@flawful.org
Cc:     linux-arm-msm@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        agross@kernel.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH] PM: AVS: Use div64_ul instead of do_div
Date:   Wed,  1 Dec 2021 09:12:54 -0600
Message-Id: <163837153033.1905338.11827661967999278324.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211125014311.45942-1-deng.changcheng@zte.com.cn>
References: <20211125014311.45942-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Nov 2021 01:43:11 +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.
> 
> 
> [...]

Applied, thanks!

[1/1] PM: AVS: Use div64_ul instead of do_div
      commit: e07a98b28decb21f7bdbcb05bf2acc58ea03b1e4

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
