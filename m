Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944BB5B1A56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiIHKoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiIHKny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:43:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1895E47;
        Thu,  8 Sep 2022 03:43:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b17so11992776wrq.3;
        Thu, 08 Sep 2022 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=1rzZX/1McMI2OMkoPvvFr/UQWTuPUFvfAYq4p+jSuaA=;
        b=VRorr6pMuOlY5WemwF+arYO6JWw4r0qOblVAxtDIQzme7dRnKR6MDAVSKi8YBmYYgE
         KFuA6+oxh7Vdn5xbP4TVLmeCcMuZsznwPcrzQiJfOb1nOb3l9ymw9LCtpHmd0e7sm8Wt
         9iiRHsxqlUCab3e5XEnCD7+xmGr6craJhJ7c8EKWG6bfrtuSF0DleSGogngof3TpUwHw
         6rbkiFtfYUaE6clQvQ6RNDqaq963NBnZzG8vhO4ib5MT1+FLfuZf8aIlhLiIKCfCVF3A
         j208xXgxbgJ7+whHhA/75D3WZwlT6s2btbRl0mCKC7kNO4Tv+acrBipHVdlTqKrCqIy0
         xveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1rzZX/1McMI2OMkoPvvFr/UQWTuPUFvfAYq4p+jSuaA=;
        b=QEwstIcHjwGejhYjxOmkRcnL/qAjr1UbcJPn1bMPwBmAk5UhP13nt9KW4tTnrofbSm
         IxkIGxjuefk9cacz+HO0ytTCn6ofDPprxw8kKckRTxKJXBAziLY86pZBU53YO5LsR0iQ
         btV6VJfkhZDOpDuF1xB0LKx8B1s3jtwcTqzviG38zrguBk6ZzsHTUjdBU0qLCDYIn2n1
         iW1ka59Gb1TvMIAzg+QUlmA0vXTmaUqthVfTmKlAFvREltuVTpho/GvuiFcH0wxc7gnC
         rwPdZ+jvm15TeDmLuXRwY5N52Jv95ZP9kb4pGduo1zypj3c3qYs/sYjC3UpyztASlH9i
         iWBA==
X-Gm-Message-State: ACgBeo1EVdTULQ6D11dK9VJXk+zU3EQIc/PPYdE1Z58FhjY8YgwJdZHF
        mc2WGet/Ui2i12i6/SzmP1Q=
X-Google-Smtp-Source: AA6agR42mzTr6nwpI2AtStNx5TNTUKx+v0UbikiWxS3BnLb2v/i1vUVqb+NqvRQGBQmbBS6obXyYbA==
X-Received: by 2002:adf:fb46:0:b0:228:6443:c934 with SMTP id c6-20020adffb46000000b002286443c934mr4880050wrs.431.1662633832269;
        Thu, 08 Sep 2022 03:43:52 -0700 (PDT)
Received: from felia.fritz.box (200116b826f77600d0640cc051af4288.dip.versatel-1u1.de. [2001:16b8:26f7:7600:d064:cc0:51af:4288])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b0022863395912sm17227486wrb.53.2022.09.08.03.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 03:43:51 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/6] media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER
Date:   Thu,  8 Sep 2022 12:43:34 +0200
Message-Id: <20220908104337.11940-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
References: <20220908104337.11940-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config EMBEDDED selects EXPERT, i.e., when EMBEDDED is enabled, EXPERT
is usually also enabled. Hence, it sufficient to have the option
MEDIA_SUPPORT_FILTER set to y if !EXPERT.

This way, MEDIA_SUPPORT_FILTER does not refer to CONFIG_EMBEDDED anymore
and allows us to remove CONFIG_EMBEDDED in the close future.

Remove the reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/media/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index ba6592b3dab2..283b78b5766e 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -24,7 +24,7 @@ if MEDIA_SUPPORT
 
 config MEDIA_SUPPORT_FILTER
 	bool "Filter media drivers"
-	default y if !EMBEDDED && !EXPERT
+	default y if !EXPERT
 	help
 	   Configuring the media subsystem can be complex, as there are
 	   hundreds of drivers and other config options.
-- 
2.17.1

