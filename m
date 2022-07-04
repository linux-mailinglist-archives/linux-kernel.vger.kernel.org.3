Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F9F565525
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiGDM0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiGDM0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:26:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4BDE92;
        Mon,  4 Jul 2022 05:26:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id e40so11527950eda.2;
        Mon, 04 Jul 2022 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DY+/m7obP8UoyHTog4hmSkoKGfbosiA+zpN6o9lOpYE=;
        b=WeM1vFIznTI1Nc+w5zhuICGwUZuvLOXu8aaVvMhn0bEofMRWxEv75rdE/As02cOZ+z
         IuX4zfYw2wHqq0ruBf4XgGvW1KmkBPOHniwAHsqrok/PHwQNA7OS2haOgvQ3M1BIKqiT
         vbN5DJzLUJFFnPNyx15fBLn0BqkMS3D7zjg8f+4TCiZGsKObgRxe8y8BuEUHxegGvknP
         mjp+OK/8o8loCgYRF6ptUi+ncfjHqTUvnIteQWufFAFU9KIt+lWq+Vru9CZl175m3I4o
         Dd88E+KCVi51vuY1NMnB+mgEMUsVOpJV+KZzUy9Iz7p+rgm2LMD/G8e+nyv0NggleTTv
         SneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DY+/m7obP8UoyHTog4hmSkoKGfbosiA+zpN6o9lOpYE=;
        b=gb3TXTaqVWz+OWL8R1csTAEmOuheUKjOeA6LelK5pdfyrwhBWDsX6Nbh63mJ7X38XG
         JKpdQROiEusOZwWdPdTfFwqbq5mtsIDI11ltEcUzbLjwr2i3ydsWqVlMP7XJhX/jIcka
         bF42FRo1NNowwWJovBrXkAYXoHpheK+ihzDDN1q8JcAGFfNtyJKH7ym/+fa+pL6HfBst
         APUyQpPZGI2WSlGa3Z/11cN3tSqWC6xAjjpwgRgmwIBun5MDB1ke2xltuf+gb6XMbT3s
         DEJ3alLW7fJnq88b0MW0pZ9gY9isSdSGDbnMCfBFJL7375X2d4JPh/PO5HbqgVTw9Ezz
         nTTQ==
X-Gm-Message-State: AJIora8y1ES6YJxVarjVSB9v5EfStStPhUKV/xm7kjrW1BkeTw7ObhOa
        NvRMyLNgUl5Nbw6UuN5cc+I=
X-Google-Smtp-Source: AGRyM1vMkC6Vsp1NBP+dNVVCBBdbRhZK7BhHC723SWgdxcl4a1IbxXo1b75aGt2VjxbXfABtqnWqVw==
X-Received: by 2002:a05:6402:2684:b0:435:dcaf:29b3 with SMTP id w4-20020a056402268400b00435dcaf29b3mr39166967edd.358.1656937579991;
        Mon, 04 Jul 2022 05:26:19 -0700 (PDT)
Received: from felia.fritz.box (200116b826716b008998943ac77556e4.dip.versatel-1u1.de. [2001:16b8:2671:6b00:8998:943a:c775:56e4])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm13974467ejj.112.2022.07.04.05.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:26:19 -0700 (PDT)
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
Subject: [PATCH 02/11] docs: kernel-docs: shorten the lengthy doc title
Date:   Mon,  4 Jul 2022 14:25:28 +0200
Message-Id: <20220704122537.3407-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
References: <20220704122537.3407-1-lukas.bulwahn@gmail.com>
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

