Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162C94BFA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiBVOAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiBVOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:00:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2939127D46
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:59:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d187so12111266pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=C1W4kV36E/88MQ0EgD4ReD32RmYbAbilQEMq9CuhY1c=;
        b=GAr1v3gitOFpOK94KhGgG0iriGATs5o0l/cpvr99uSwtKjmP8LD3IyRhRJUyh89zsa
         OFRq86cVgW2fBdCfDAvqvSoTZOLwtm2tgFfDxZ2rCUL0J8AieTaLUlr2B8GiDOrnlCAF
         DRmY8oiIU4cMLpVeW+arMTXFklUp1QVeYLefRhm7cX0t61L66YcuBR1M4mcO2EMDNSeE
         FcrMYJkmR/qTQTn/l63QrKuitFxDy3jKRDuLcQBlF1khAml8v6YYXTKJsCFHEhtkSP7v
         z0RnhrcV6Uy3AmUEtwj6jKTBoWl26tjeWM5exrxsF0GvoP87beDE9+yMVrfo2muLWoSH
         OVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=C1W4kV36E/88MQ0EgD4ReD32RmYbAbilQEMq9CuhY1c=;
        b=hk2vCus3RxpeMb03inrVGMtOblSIUKs1UctBAJCpsP4Xdp8nxB+lOaCr+QZlBMhFyH
         FgfpW/FSiVnTwRdrwOmLy0Xzqv9XDUOQliDKSbthRezpXJrrkXIIoiesel3IBukxz2r5
         Ut4X7FbZzB2UyxQaAXkkySOTiGxVYplOlVLb2xIE4frvxgZatA+g34iJgcvSueR/ypNW
         oozSd8TNn5c2vshcbTUms/NdJaH/P1Q1Yag9YBTi+vV8mLVRuKFCtVvwkeu4l/EuRs1V
         LOY7H1YSwBYqt1ZKcR9u7jdTCprSXrjeOr06WFrWTomFetbzAoC626U5g/TfwmV2C8g7
         Q/ig==
X-Gm-Message-State: AOAM531VrX+oZ6KAuPRMUP4II2E3IJTy0GI9j2kam50ihs+uxfqt8YUw
        jAEd4I50uY16TqGr3FDFXPKt8w==
X-Google-Smtp-Source: ABdhPJzDRyJ/ki1TBz8O7jl8bNr+phcLYza9jywAF1RQVWiTjbI7ZTyTt3RunHBudGSIVMZTqGzQQA==
X-Received: by 2002:a05:6a00:1943:b0:4cb:79c9:fa48 with SMTP id s3-20020a056a00194300b004cb79c9fa48mr24948520pfk.47.1645538376196;
        Tue, 22 Feb 2022 05:59:36 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p9sm17624580pfo.97.2022.02.22.05.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:59:35 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
References: <20220217064247.4041435-1-zhangwensheng5@huawei.com>
Subject: Re: [PATCH -next v2] block: update io_ticks when io hang
Message-Id: <164553837519.20990.470624285897960760.b4-ty@kernel.dk>
Date:   Tue, 22 Feb 2022 06:59:35 -0700
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

On Thu, 17 Feb 2022 14:42:47 +0800, Zhang Wensheng wrote:
> When the inflight IOs are slow and no new IOs are issued, we expect
> iostat could manifest the IO hang problem. However after
> commit 5b18b5a73760 ("block: delete part_round_stats and switch to less
> precise counting"), io_tick and time_in_queue will not be updated until
> the end of IO, and the avgqu-sz and %util columns of iostat will be zero.
> 
> Because it has using stat.nsecs accumulation to express time_in_queue
> which is not suitable to change, and may %util will express the status
> better when io hang occur. To fix io_ticks, we use update_io_ticks and
> inflight to update io_ticks when diskstats_show and part_stat_show
> been called.
> 
> [...]

Applied, thanks!

[1/1] block: update io_ticks when io hang
      commit: 86d7331299fda7634b11c1b7c911432679d525a5

Best regards,
-- 
Jens Axboe


