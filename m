Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1C52ABE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352703AbiEQT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiEQT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:28:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DC25046F
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:28:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s5so3190097qvo.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=T25orQZcjJ9x64HlBZmcnhujj49u8jvUi7v4c/vg2ig=;
        b=NxqOtqZxaRI9geSW3ohqQMnXUxpE0Rb38kPdTjSul1t77l+SCfNdNXOoXtSihMFvR3
         hy3eRo/0Yrz1QGBWWV3Q+L8J2ql3t59DHpjUnAyejxx8vtajD/zT+KporB8jWqBG4k4L
         y5mcFUwGFNF6xBkGXAJvb+cZFNwHgCE9yv5cGazWxmTAJJbrCjSn0o/YIeMv/gJ+UU0X
         MWAjvQcoGxsQNLHGNAWomJ+TyW1FlWl8wRHRIF6qh1ujJ4foaZ989zbI/kR58qQkhdGk
         j0bx04mXaAT371xsfTSqvrJ5QsRi9EAY+LNCMga1b5Q22OT88/joqEblXyNuElam6wZ9
         Zmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=T25orQZcjJ9x64HlBZmcnhujj49u8jvUi7v4c/vg2ig=;
        b=qN0miO0jT8x4jfM7rilbO8fBcjrDzri+r3woL6r4nYAuimoU7HkSo6hMWSx9Lj3J31
         O8tB3XmYKxdrsx4RQmPAKtneyQsNtqwJW68vVHJ4QQ1em/jKCUD3svIZQP0JqE7JTEI0
         cn/O/TAP9v9rwoy6UyivPrMBdtYNdH7sgnb/BcRUtzPkt9r4YwgCYE/b1lVxxsTMCUrT
         8bEsSOjMMUoPc3IQFOc4+Vnbsv3h9b4VDIh/xkQ4EyvSHiDY+hEQz/8LX6oDWFufTKCf
         NMo1CJj0hc1I2bzcSQuLo9qLwGSDCqnVEEx4I7uIdWm604h0XQEj7MJ/Prs57VjfR4nT
         QlgA==
X-Gm-Message-State: AOAM533EZtkqRw7ONxRxZkJm1Xxj+qv0IQoLOV06++yoUk4BCosTA/Ob
        Z0hJWe3/p/HorPaJDh8Jghx8x7L72Go=
X-Google-Smtp-Source: ABdhPJyyUT8WIDsCiESNZbn08Hyx2dRtMYdv+Fo37IPodgHy6tZQQoAq6m7GQcQ41kxN4In7T4bZkA==
X-Received: by 2002:a05:6214:194e:b0:45a:d8e3:2d3f with SMTP id q14-20020a056214194e00b0045ad8e32d3fmr21546166qvk.59.1652815692947;
        Tue, 17 May 2022 12:28:12 -0700 (PDT)
Received: from Sassy (bras-base-oshwon9563w-grc-26-142-113-132-114.dsl.bell.ca. [142.113.132.114])
        by smtp.gmail.com with ESMTPSA id h4-20020a376c04000000b0069fc13ce1d4sm33546qkc.5.2022.05.17.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:28:12 -0700 (PDT)
Date:   Tue, 17 May 2022 15:28:11 -0400
From:   Srivathsan Sivakumar <sri.skumar05@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: spi.c: prefer ftrace
Message-ID: <YoP3S6mGQEwUTQDC@Sassy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl warning:
WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Srivathsan Sivakumar <sri.skumar05@gmail.com>
---
 drivers/staging/rts5208/spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rts5208/spi.c b/drivers/staging/rts5208/spi.c
index f1e9e80044ed..0d2d065508d3 100644
--- a/drivers/staging/rts5208/spi.c
+++ b/drivers/staging/rts5208/spi.c
@@ -460,7 +460,6 @@ int spi_set_parameter(struct scsi_cmnd *srb, struct rtsx_chip *chip)
 	spi->clk_div = ((u16)(srb->cmnd[4]) << 8) | srb->cmnd[5];
 	spi->write_en = srb->cmnd[6];
 
-	dev_dbg(rtsx_dev(chip), "%s: ", __func__);
 	dev_dbg(rtsx_dev(chip), "spi_clock = %d, ", spi->spi_clock);
 	dev_dbg(rtsx_dev(chip), "clk_div = %d, ", spi->clk_div);
 	dev_dbg(rtsx_dev(chip), "write_en = %d\n", spi->write_en);
-- 
2.34.1

