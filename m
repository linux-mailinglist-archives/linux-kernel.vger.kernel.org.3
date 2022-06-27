Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C2455C88F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiF0PTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiF0PTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E886167E1;
        Mon, 27 Jun 2022 08:19:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id sb34so19827480ejc.11;
        Mon, 27 Jun 2022 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DY+/m7obP8UoyHTog4hmSkoKGfbosiA+zpN6o9lOpYE=;
        b=D0cHRBlbRmWhlAhS8ukZOIN2wmzma6Dc5kC5MwnQm8voRiP3a0komtBh8/wZEEPNAj
         Aw0gtROEGSWsV8TATTfUXV5RDhs0LH6534VWrQw8NPedAZGAViN82zskY/0KcVdV3mZP
         W3MPZRCa0sEPBFZQYg+Vb9IAQJSswE4+qHfQ4AftPy0Rz7gaQgylIuskzJu+6JGYgLGr
         kNlWSLg5YXy2W08r8a5M09kFYLI4/4Dswpv39gVpjpA3Yz3aWC/Fb8hFFYurAE3qlzVH
         KtdNq/IpyUi4S+r5JnPJTSfZpfn6HT3zMyT1IoU0llF/lgWS6ig8xNgB/zO6P3dxwFYd
         7jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DY+/m7obP8UoyHTog4hmSkoKGfbosiA+zpN6o9lOpYE=;
        b=BBsckPBVckkJutSaTGSIJxmw6OK7wyWwzeZwQ+/wnN5h22pKcoH5WmQvXnEoYmB3uJ
         cazeWETCccQdR5BB8fTdOx6XJBT9CSjwGIB3akcP2Wi6t0vzFV9OplDUPfmSTRay+YHN
         76EjL0P9MvVE5QmdS0UGdqMmrBT8EMY6I1OsFfY2Tb87oOainZLZ+ruef8dSR6iFmYxw
         5D4HjhnXGV1YwrDr+qqVrqYtM9Epkv1SOFbzpiYDGaYG3FTfUkiGQLw/WZH5aDX1Zqys
         YgM+R3xzKDabIPdcdQjJ1OpI0Cbg0CPtbEapmSqotpyBBJ2801WDZhubBitcSNQtCOvs
         996w==
X-Gm-Message-State: AJIora9Bz2HGFtbIiPRdPivxPsUVXJymRNraERlHGejb02WPDhgkKxXz
        uPhKRbWVzaNTlC9hL8/nWTk=
X-Google-Smtp-Source: AGRyM1sZezcbqNP7zidqGh9udeL38mjshyNzjyck+4zn4xpknn358CrDPb8rYbR709kXowaf1ecZDw==
X-Received: by 2002:a17:907:3e18:b0:722:be7e:302c with SMTP id hp24-20020a1709073e1800b00722be7e302cmr13204470ejc.437.1656343158062;
        Mon, 27 Jun 2022 08:19:18 -0700 (PDT)
Received: from felia.fritz.box (200116b826511b0021a0c74157938809.dip.versatel-1u1.de. [2001:16b8:2651:1b00:21a0:c741:5793:8809])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906434800b00722f2a0944fsm5076901ejm.107.2022.06.27.08.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [RFC PATCH 02/11] docs: kernel-docs: shorten the lengthy doc title
Date:   Mon, 27 Jun 2022 17:18:10 +0200
Message-Id: <20220627151819.22694-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
References: <20220627151819.22694-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original title comes from copying the content from a web page that
covered various mixed computer-science material. Within the kernel
documentation and its current structure, the title can be shortened.

Other titles considered, but not selected were:
  - Index of More Kernel Documentation
  - Further Kernel Documentation
  - References to Further Kernel Documentation

Shorten the title.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/kernel-docs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index b4d98f6f797a..5d6fa71895cc 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -1,7 +1,7 @@
 .. _kernel_docs:
 
-Index of Documentation for People Interested in Writing and/or Understanding the Linux Kernel
-=============================================================================================
+Index of Further Kernel Documentation
+=====================================
 
           Juan-Mariano de Goyeneche <jmseyas@dit.upm.es>
 
-- 
2.17.1

