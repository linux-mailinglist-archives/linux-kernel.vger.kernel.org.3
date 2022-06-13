Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B985E549D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347771AbiFMTUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351204AbiFMTT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5B110D;
        Mon, 13 Jun 2022 10:16:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so6090572pgs.10;
        Mon, 13 Jun 2022 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O89rLS/mzd3GPfJDFSo+5GSTwiN9XZJrpeez4+47ZNI=;
        b=dTicN5xPtrJLyjiW2ipGNV5/G0bUbQRp4VPjegR3FKIX/UnXf6vELBEqOB2StTWq8l
         yoFKDr4cVxkL2cBMyvY5nCvhCRf3/M1xYwh2a/toQ5p7rx04lKaI7x4IDE219i4TcxRz
         Wpo2Q4YVxFGOuvq1DkOG9u2spp0DL/ydJ2114ILpjEEXrgUCcEs2IjVbTpp031mZziK4
         uRvnBZUHO+bTyum3IaiJfJOYhWH8kvfPowx+E0lndAHPYl3Ee6RmK+cSquXqiktqQffV
         Ib8zHi8xQquR95o82D5SL6vk7hCf/nNK0K6w222uMZ9Ulbcr6Xj7u6JiIMQtzpIPu9Rw
         ak+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O89rLS/mzd3GPfJDFSo+5GSTwiN9XZJrpeez4+47ZNI=;
        b=JuWzw2vATv0y50or/rH1JN9KCIqNAtZNBfDZv6sb6YGmARgHCesu8qSxbkpC5efn4G
         QFMfeDZwYhTIsJwYJFpi+jAh/dP+fqRnxqzxoAseLKdhUHhEH2E2+M8L1znKih9J3Svx
         hrXuvMRNFa/KJqefhtDVHmFaD0ToK0gnknqvvDuxRvDYmfRzE7GYdV+I25SRy/zY/PLf
         2XL2iqy0+By1MsYvOShQU7or9YShoVRR22fZU04uvCLL99NXbe08IfZuxUnkCXIJ53em
         cTwsi7N7j1UHwSGsIWxf2YK+Fpg8aySF+u18QSA0MbEEz2aR2NA5eV+OVfdUfmPB0knR
         R4kw==
X-Gm-Message-State: AOAM531FqrvWNrxvX2g/N3gFGrp3Rp9x67L6+zVeNpxgAHwuB2+g5tG0
        afb6dnse9DAYqGEj0hSQR3Y=
X-Google-Smtp-Source: ABdhPJwYjmVQLwa5hFkOguAl4jGmy3T9AiYxPNPENFbusolkPahsaJq76Yf2Xv7ijvOyIC/2uQkagg==
X-Received: by 2002:a63:2a8d:0:b0:3f9:d9f9:a5c4 with SMTP id q135-20020a632a8d000000b003f9d9f9a5c4mr541520pgq.614.1655140612175;
        Mon, 13 Jun 2022 10:16:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79627000000b0051bce5dc754sm5621899pfg.194.2022.06.13.10.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:16:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
        samyon.furman@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: Add DTS files for bcmbca SoC BCM6756
Date:   Mon, 13 Jun 2022 10:16:50 -0700
Message-Id: <20220613171650.241791-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608175629.31538-3-william.zhang@broadcom.com>
References: <20220608175629.31538-1-william.zhang@broadcom.com> <20220608175629.31538-3-william.zhang@broadcom.com>
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

On Wed,  8 Jun 2022 10:56:28 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add DTS for ARMv7 based broadband SoC BCM6756. bcm6756.dtsi is the SoC
> description DTS header and bcm96756.dts is a simple DTS file for
> Broadcom BCM96756 Reference board that only enable the UART port.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
