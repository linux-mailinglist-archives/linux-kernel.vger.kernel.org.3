Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66AE58E69A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 07:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiHJFII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 01:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiHJFHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:07:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B809782FBC;
        Tue,  9 Aug 2022 22:07:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so25670567ejx.9;
        Tue, 09 Aug 2022 22:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=WsXcmjBQTbbS4kpYY9SBHjgMTL8/jvQNRCwa0TQb/Dw=;
        b=Mv1ccTu9Pt7/8Od4hcaLuLZygPfFa1idQh4Iwor2NDR/berSoqrpXJla+nyBiiGbr3
         h3UKWCuKMcyIMtS989oOv41ozNXbnk/WtywEAN7OcoerrgnnR1KtA//X8kaDTpzAhekZ
         Bwj+qhKRj2694wPxYZussIJtV2Q4LxbutLacyKcUD8j9T4GJWPjqvTCp0jjDoJGA/L6T
         FvMZmq4T7WUv/dwkaF5zWQmKwkafAwCyrzU0+7Aok6GAv03naIFweHysXUuondhs+tFi
         ko08cm0RQP+mEek+uFcwOIZrPZRMCjtbxMSVHeoKONP17wKwbx5AkYB+xGtHEQzXCLtX
         +7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=WsXcmjBQTbbS4kpYY9SBHjgMTL8/jvQNRCwa0TQb/Dw=;
        b=3oK0z/bcGu78Z8poMflhLHo6peSRHgkQaZl0FaxT0Oo6RTKCx2kWoGiD4S7xezCNgJ
         OuYP+H5okurk1yg1k4dwCinVWvgQR65Jg45Tm69rnjIOatHCbcU6oJx0A2ziMKC/qkMT
         SDgexubbvQTBH6mSd3mnJ84SOqOGldoyK/vNPLj7yKMH4lAgZMK28igT+JzYEzru94Ij
         wyPKbS0qBjI1T/Iu5ewm5E7V915LzeDjNcLqgIOsX91i3sJRGQjLTY9N5wDgMo2lm6H8
         N86dzyodgmp+a1uK2dCUJKkHfY2w7qDlXSJ1Mq7ksqWoGvT6NCIsSUSxW73DNJXtDDrj
         8+og==
X-Gm-Message-State: ACgBeo0gpHl/ODuP+zC6m6o6vYVTHc270+8mn+BfG7xcURC/cL+7gbzZ
        75sLuVxdk7V9fGMs1pCvAuU=
X-Google-Smtp-Source: AA6agR7yLzaBfBvPVm44Z2rLdVtw/TzNrHXYRUe4nMa+MCuJoOnDFeBpiEiZup/g1QpSARwuyVKKVw==
X-Received: by 2002:a17:907:1c24:b0:731:59f9:1b3f with SMTP id nc36-20020a1709071c2400b0073159f91b3fmr9018203ejc.595.1660108062166;
        Tue, 09 Aug 2022 22:07:42 -0700 (PDT)
Received: from felia.fritz.box (200116b826504800504e9aff21bf95aa.dip.versatel-1u1.de. [2001:16b8:2650:4800:504e:9aff:21bf:95aa])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0043bbbaa323dsm7009781edb.0.2022.08.09.22.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 22:07:41 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 1/4] xen: x86: set the config XEN_512GB after config change
Date:   Wed, 10 Aug 2022 07:07:09 +0200
Message-Id: <20220810050712.9539-2-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c70727a5bc18 ("xen: allow more than 512 GB of RAM for 64 bit
pv-domains") from July 2015 replaces the config XEN_MAX_DOMAIN_MEMORY with
a new config XEN_512GB, but misses to adjust arch/x86/configs/xen.config.

Adjust this config fragment now.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/configs/xen.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/configs/xen.config b/arch/x86/configs/xen.config
index d9fc7139fd46..8a6c88f48e75 100644
--- a/arch/x86/configs/xen.config
+++ b/arch/x86/configs/xen.config
@@ -14,7 +14,7 @@ CONFIG_CPU_FREQ=y
 
 # x86 xen specific config options
 CONFIG_XEN_PVH=y
-CONFIG_XEN_MAX_DOMAIN_MEMORY=500
+CONFIG_XEN_512GB=y
 CONFIG_XEN_SAVE_RESTORE=y
 # CONFIG_XEN_DEBUG_FS is not set
 CONFIG_XEN_MCE_LOG=y
-- 
2.17.1

