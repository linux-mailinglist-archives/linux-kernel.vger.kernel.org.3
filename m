Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365A4AD366
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiBHIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiBHIaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:30:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901ECC0401F6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:30:18 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B98C3F1CD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644309017;
        bh=31c7s2vA8m7YEf6YWOkMfxDEdxn1Te+1H5YnjylA44k=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=OGZb2teiUUDBOxsxCAbFbKVtyXYjSbO+DMOWhxCLR4nMjQ2TzScNc+ysoHo20Ye7r
         ipzvCVDHAfQWg63eM7/LMEziemhhHrel8bkkzxFNY+BsUxOmuyS+sH70H363u9KlzR
         qnr2DyUabzxwXm2cCb4AJ/5akAJk4YZgtY/3nwXE4FGCuzyXf48m1PN+anJeX+WMpZ
         DXHhpBBo7mAaWphxETu6IA7k+erdk/j7TdGSo1a+Piz/NpySXbLw+DuPz7U+2Vu7Bc
         LFtVqQFKLVS4nVI1vESf8Rvn500+LZ76UL0I4akNcmQP4NV793cVhp+jl4BAPAuJvi
         vH09vwaH14PbA==
Received: by mail-ej1-f72.google.com with SMTP id lb14-20020a170907784e00b006aa178894fcso5400926ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31c7s2vA8m7YEf6YWOkMfxDEdxn1Te+1H5YnjylA44k=;
        b=tsj2n2h6BRApuiO5Ok6mMTkvBZJXDFLS64hAJnUVuueT6s9rPnRVzCXdp5RrT9lrcC
         1xZXalJk5+tTRG7u0rp49n8ZD42Yp+o7T3ESmp0juBvQcwq7utaj97IzCBdDu5HW2ujF
         9tWJMELFkfJ75nHOlQfX3ea3VzeTsBlYQtrNRB/OAWCdwxlFe289c/lztVann8oqZ1GV
         CKvXV5nRl8beZrZRQvBtEsdwHbc0fzy0NlLXSKdUdQU5uf1sdMUParCjbVPuGbzvghav
         ApJa+9fCo0PV06jmFlOl4UPOGDVMwMfiOg8uOQKwmPwqE+osdbNRuexgzbGESCwz7PpK
         qXtQ==
X-Gm-Message-State: AOAM533x6eUDs7Ljvk/h2FFIyk+e0Wzl59MWD6xgW/U8Y4xYcT8uPGRL
        SQxLT8rymbngbZV+p9APxqL4Z6mn0rzmXorypCW5ZxIK0k/DkCmrV6UGCoTzZJTrf6yOSC7AYnB
        rRnR+PDVqxFzxbitPRLRENfYRmSBEAxcN9lJwgMsuFA==
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr2681412ejc.214.1644309017077;
        Tue, 08 Feb 2022 00:30:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwUDohxFhVaBh94RQ4K4ESzFEuTlNG2YYSP/08Vv6gwZxNPIx+4GpBi+yhKGjhJXmCFAQevxQ==
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr2681400ejc.214.1644309016929;
        Tue, 08 Feb 2022 00:30:16 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id rp17sm2790003ejb.187.2022.02.08.00.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:30:16 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     yong.wu@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] memory: mtk-smi: Enable sleep ctrl safety function for MT8195
Date:   Tue,  8 Feb 2022 09:30:15 +0100
Message-Id: <164430901207.10840.1312269540907358317.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220204125543.1189151-1-angelogioacchino.delregno@collabora.com>
References: <20220204125543.1189151-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 13:55:43 +0100, AngeloGioacchino Del Regno wrote:
> Enable the sleep ctrl function to wait until all the queued commands
> are executed before suspending the LARBs, like done for MT8186.
> 
> 

Applied, thanks!

[1/1] memory: mtk-smi: Enable sleep ctrl safety function for MT8195
      commit: 12fbfd665fc473800d25d0f3ca4617c82cff42dd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
