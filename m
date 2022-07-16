Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7E576DED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiGPMdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiGPMdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:33:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA741EC4A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 05:33:22 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id b2so5295197plx.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 05:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=o4csOc+rtB7OUTKym0l3RxG2wfhS0254EiN6uhE/JmQ=;
        b=2/NMJ6WlCAOj0nNYy32FujAraP5+NrISPHGUKecmoPyVl0OmmKR7kcJtpqR2NakGmc
         0WizbndmcjewSnvT2dCOGwQ55qmZvdkgVdqn6MNMtwd8FhHd3OIxrwrVkgbnc4u3rYqU
         4pFS7Xm4X8gnvSq6RgbyJ+iTYt7FKx9o5W8PMRQWde8uRJKASZ46F5Q8x/mGWWQ9HxQM
         klVQzScTANxG7U1YYRAPJ+sk63GH/qwoilViwM8XLfOXr4SDQvL18CNDWzY2/ZK18G9M
         VnFHeRwYu+p/QqyYxDyuBNiCzkkDAy6FwZnlwAODYvGsdle8+AqV8snnXy39hhJot2Rz
         zJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=o4csOc+rtB7OUTKym0l3RxG2wfhS0254EiN6uhE/JmQ=;
        b=IqcCVCR2Vf9pB/Qiu4D+jromJ6xXP+p5pjfc1JU+u/3r0ZM7ijrjGMzrLBAzLuTMLY
         GhoFfXNmJpaGNujGzfk8k5BUWt6yBPP/UDez59f+DtXFWQNWbZv+MSW27t8Elk70ke2h
         Cu6V2VG2K3p6PWr93nT8UgpUZmMqncTJcJhE3L2YzuM2qGpLS4if9Zij3VmXP4uxtA1j
         7nIVBQ1vUezC46W11oBoNmna0HYBcKTtnR4v3BQGK/LVSMOfLvAW3x59ruEExFy3/HXP
         4pFHQlhSQ6QZJpMlH3RSlJ2f3A5/AHchDwTN1HFn7buk9zKp9SI1xIW9deGA7JJen57K
         qL6A==
X-Gm-Message-State: AJIora/sizXtiJbM0Cg1TeROERStzp/SKoV1oTcC4oOuVaRhPORGvo5R
        iEewrVydZzsYxaN7EqKV6vSuxw==
X-Google-Smtp-Source: AGRyM1uwCugYrV5gHHxlWUC3M6QBVGA2S0E6AOVw+P1TjDFHQj6fdRDNZcz5gfmUIsb3poGJB2SxEQ==
X-Received: by 2002:a17:90b:4c8c:b0:1ef:bff6:c964 with SMTP id my12-20020a17090b4c8c00b001efbff6c964mr20722243pjb.36.1657974801892;
        Sat, 16 Jul 2022 05:33:21 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090a39ca00b001ef8ac4c681sm7654278pjf.0.2022.07.16.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 05:33:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     13667453960@163.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yijiangshan@kylinos.cn
In-Reply-To: <20220712094350.1379942-1-13667453960@163.com>
References: <20220712094350.1379942-1-13667453960@163.com>
Subject: Re: [PATCH] mtip32xx: replace ternary operator with min_t()
Message-Id: <165797480045.362401.4678527786770696731.b4-ty@kernel.dk>
Date:   Sat, 16 Jul 2022 06:33:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 17:43:50 +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> drivers/block/mtip32xx/mtip32xx.c:2264: WARNING opportunity for min().
> drivers/block/mtip32xx/mtip32xx.c:2328: WARNING opportunity for min().
> drivers/block/mtip32xx/mtip32xx.c:2357: WARNING opportunity for min().
> 
> [...]

Applied, thanks!

[1/1] mtip32xx: replace ternary operator with min_t()
      (no commit info)

Best regards,
-- 
Jens Axboe


