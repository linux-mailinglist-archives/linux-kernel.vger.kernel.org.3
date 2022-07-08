Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76456C2AE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiGHVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 17:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiGHVI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:08:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6B19C39
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 14:08:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m14so17304438plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pYULeEDcyYQTk5e9Dsrh3FzNq/wwMad7QPfRp7bF4g=;
        b=WVqNZvmrR3eFJWzMiY2qgxMR3t+/Aur+DGgzo3J9jxctsZicLgT63k0eTtwzEuvQMw
         VaU12iw0Z4+P1+gtLuIvq37COd4K+teGGeIP4eHxEeBUAhNngXspztePgfneP5Envqsq
         frKorIg36x9XMzu08/4cmqfriMgFSGqaWZU9MTbfV1nj+W2xOpi4eAKr8jHiP4skw2jx
         nBbyHlAW9PL57BacYgUOMw5bO8c1S2Tl2wBm7ekNsEekgxcf7Yvrr5k0d1R/SSZNKj55
         8U3QHIC0Mt9Bc+L/CU8yIeKYZP97ZNJ+F8sydIWpWOi3ee+tHggXIuUyY5p3Gaiw9SIt
         ZxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pYULeEDcyYQTk5e9Dsrh3FzNq/wwMad7QPfRp7bF4g=;
        b=2nFgqs1KuOq2HFfwVjHEUJxa7HaBgzlFenksM056EahUyyWKDXz7tP8wd5w6uwAPjH
         Jg7CCxK3pmiXoE7iAWII6uWJqggDTY3Nqf0dtjVSSYYEAYa92qIprwf18/Aqqn3q6CvH
         a3tOxonxMVB8qrLerbl2vwks8GopFBE6AJ7nYIe7Up6AOQUzU2oPCjRRAN5lf2oH/aZz
         HV7FkOxaG/fGAryd03oHUuJtjA+o3ilWCLywMNH1CYO6c2L/cwGixBzrAcbrbSLC27iN
         c7dnEKgkZWEixxb9s1AfQmv2++xHGdoMcE/3KK3z5WPr0fmdxVA26IkGuWuop2otmn5B
         VH/A==
X-Gm-Message-State: AJIora8vYlTZJAlBHQsi10MgAdJw+qQUoPd3pNE32knCbpriVItfvyym
        hZgWvrU+Ah2bt8yU9pvlDlhoZsCD4WQ=
X-Google-Smtp-Source: AGRyM1smfmzlnMTl5ACYu1qeaGbOTeTBjUSYm9t5Ns+dGf1Ne3cavaq5ZYX3NFBBYWxlbko7N6foLQ==
X-Received: by 2002:a17:902:8487:b0:16b:de14:43a7 with SMTP id c7-20020a170902848700b0016bde1443a7mr5538837plo.44.1657314536891;
        Fri, 08 Jul 2022 14:08:56 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c17-20020a170902d49100b0015e8d4eb1dbsm14555531plg.37.2022.07.08.14.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:08:56 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/8] ARM: debug: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Fri,  8 Jul 2022 14:08:54 -0700
Message-Id: <20220708210854.2660428-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-1-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jul 2022 23:57:52 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> DEBUG_BCM63XX_UART depending on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/soc/next, thanks!
--
Florian
