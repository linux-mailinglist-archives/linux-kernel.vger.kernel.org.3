Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC34D64ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349487AbiCKPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348161AbiCKPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F4D0954A1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647013772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qTfEf7yr9paJUlzwxSKVIzpRbR+ggiBcztvNLiAH+tY=;
        b=Chdir7Llre8Lys4KPWjRsF6ur6tSx7G4HZ3+qsCOZlyqaZL1rFd4SDBsg8ABNy+LQVSYLR
        Ri8YkgCSFYZEH9zn0J9he/kr3PXX4Edb6sdRrY/3eHwW4cKpX0DvEHetYPB7V248ukjiWI
        bJ7BIZFmwKEGQXHBlWVhF2nbkd8KCiI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-GvlbbILfM3-n_KpSA-D7ow-1; Fri, 11 Mar 2022 10:49:31 -0500
X-MC-Unique: GvlbbILfM3-n_KpSA-D7ow-1
Received: by mail-qk1-f200.google.com with SMTP id a66-20020ae9e845000000b0067b308a9f56so6390734qkg.21
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTfEf7yr9paJUlzwxSKVIzpRbR+ggiBcztvNLiAH+tY=;
        b=ivxxkbKCgKfZ+1HAAaSp2kwqetPb18TGgXiuyE8Gn8FUfFeCeU7GrGQ4xOw44tia1+
         6fT/lu936CRkoN8dCP2/zBPgtbRqCUnwC/gdJeIVecRxApnNlhP0FA+AO8lDBjcxGUrS
         dxW6Gx5DBk9GyvDPbuRl/Sqm1lJWJNuiOWfcaRTUFITftBZfnRw6VpQdkX5wK1/zYWb8
         jL7m4wrz1D56mfn4kFsqfa6qEX4FChxVAaERQ2csVIHp5MPwCN/iJ43C6jrA7V59Jaed
         u/6/ene8b/kKHBVL9wLcVKiF6tnWcP2l/W4OQeGBkI2584TTyWR271N1CcyC6Id28Xns
         cjMA==
X-Gm-Message-State: AOAM5338gu3A8UzjsSEHG48Km3daPXkSu8ERpb8FZDZIiOZNpbHxdd6q
        1iWH3L+kCZPAQFhyLwoQpmspHQv0aKheGqRWwwWrAiPHoQLRKiWpfVVioDAjYA8sukzON3eYeH3
        K6+MmSUCciDB/nAnm7WcqoWrB
X-Received: by 2002:a05:6214:5290:b0:435:208a:5fd with SMTP id kj16-20020a056214529000b00435208a05fdmr8244511qvb.66.1647013770721;
        Fri, 11 Mar 2022 07:49:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWg01x03AaRegxM1Hv5DU8L2U/TjmBjwQz2DtkoLyKiBE5QG0qlg6M5cwrZ/osbrpgVxDXBw==
X-Received: by 2002:a05:6214:5290:b0:435:208a:5fd with SMTP id kj16-20020a056214529000b00435208a05fdmr8244493qvb.66.1647013770479;
        Fri, 11 Mar 2022 07:49:30 -0800 (PST)
Received: from xps13.. (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id z6-20020ae9c106000000b0067d3b9ef387sm3602719qki.28.2022.03.11.07.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:49:30 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     bjorn.andersson@linaro.org
Cc:     mani@kernel.org, dianders@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] ARM: qcom_defconfig: enable debug fs support
Date:   Fri, 11 Mar 2022 10:49:19 -0500
Message-Id: <20220311154919.1797920-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311154919.1797920-1-bmasney@redhat.com>
References: <20220311154919.1797920-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONFIG_DEBUG_FS since this is useful to have around.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm/configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 50e28a74c361..5cd935ee148a 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -308,6 +308,7 @@ CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_WATCHDOG=y
 CONFIG_QCOM_WDT=y
-- 
2.34.1

