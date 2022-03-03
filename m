Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E24CC39F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiCCRZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiCCRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:25:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FE19DEBB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:24:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d3so8940379wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvfQxkJzRDPW+wX8/sxn+DFVMxJJWvPXRKTHdc+XrVg=;
        b=YQkmHzEB4s8OqwlKwhItlO/pKbcIFQjQovA1+vledCMdv/kfouLxi0pSHh/WigFPTN
         HSecIrR42Qy/Hmbm5JQoMcGNTeTtrPgdfAi8mk48/eq/gUfUIM/8aOwc6Z/eRvVD/aeL
         xvjkVU2MmxyAnmXVzNWo2doxQC8R2/6Qt9Qg34Hv1wkreyUiea6h2DrZeeQbma6bVrg9
         FIHHN43UgqrlxCBPFfkeQC0kvXRChcDLSTYm1xsee7aE8jWz3gGxj2K1OGUmn1Lxxix7
         7VJxMdRgoBd8nY1mggnwVTv8tLY6fpiGvUQxxoyUtOGedMbaCMKsNI1elzBoobAMyvTc
         Rp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvfQxkJzRDPW+wX8/sxn+DFVMxJJWvPXRKTHdc+XrVg=;
        b=2KuDybAtpS/7G4eFslZvnylXEXQ1MgHdSsbncFYkBKzlSCMvtoOmynfpTgGfFpZZZ1
         47zqDhNNveKtlAf9wvNt9Wb4cnlA7dhyF64esvdzqDAaVxerahaiD2vcv/qiFAL5ritA
         gfNVsz0aITrSik2MUu1NJO/K/d/btrfeVAq0vhWbAtlpyhbwyV7QxGAncu3qtnM1NtRf
         zk4e+vRNutTJInjcUwzle5+t1PYd3JPJCpUNWjeri3vqD02EnnnEUmvWr1GkSujTYasl
         bB4Ta6CQDXzPdrM0OL7RU6GJAGY8vdtNr+PH/gV8uU1iF0wwmkqkd13qGMjRqOarIV17
         LKcQ==
X-Gm-Message-State: AOAM531z4CzwiVTGr9jwF9rzVQVO1YEnzWHQkqYVWQpGpDB38mGeWpQV
        x/J99XfTJfrMDWyQh832LHg=
X-Google-Smtp-Source: ABdhPJxDxade1EkWFZLf5wF6H5zZli5HRloQHKc0Wg9/2uchIadgTHbfs5N5QOO31d2oUxKXkUS7WQ==
X-Received: by 2002:a5d:648f:0:b0:1f0:567b:5619 with SMTP id o15-20020a5d648f000000b001f0567b5619mr2704816wri.66.1646328272327;
        Thu, 03 Mar 2022 09:24:32 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b003814673f202sm10298928wmr.47.2022.03.03.09.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:24:31 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     marex@denx.de
Cc:     stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, contact@emersion.fr,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH drm-misc-next 0/2] Use default drm_plane_funcs.format_mod_supported
Date:   Thu,  3 Mar 2022 18:24:16 +0100
Message-Id: <20220303172418.12565-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series is a follow up to [1]. Some of the patches were merged
in "drm-misc-next", however a couple of them, included in this
series, are pending.

I rebased the pending patches on top of "drm-misc-next" and added the reviewed
by tags.

Thanks,
José Expósito

[1] https://lore.kernel.org/dri-devel/20211226112503.31771-1-jose.exposito89@gmail.com/

José Expósito (2):
  drm/simple-kms: Drop format_mod_supported function
  drm: mxsfb: Drop format_mod_supported function

 drivers/gpu/drm/drm_simple_kms_helper.c | 8 --------
 drivers/gpu/drm/mxsfb/mxsfb_kms.c       | 8 --------
 2 files changed, 16 deletions(-)

-- 
2.25.1

