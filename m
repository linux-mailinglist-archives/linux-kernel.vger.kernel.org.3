Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6AA549D45
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240830AbiFMTTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346748AbiFMTRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:17:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F630F50
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:14:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 123so6103511pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EsglsVugqC646QVrSW+EmxeHeUWtGwOLKQ6g78eGjk=;
        b=JDglQGKazzXZ6/jpHnkFyaOkGx7rMwuXrOtgz/rYdG4V5NnUtD1HJVYYyY+tp4F50B
         jm2vZdR4sAOyYlm28Tka9+yFrBrx2QGu4h4QR3i2WA5ThLT3C8McquNCgD4wZvw6KjOC
         HQoInTw1BAxz/CJubzHifElmvCyoO34kpHSl0zCNJl9NkDVRFNkUoX8jA3Psy8qoqh2r
         TaZmLWmSPZLfnPAOj7fPO5/7S80Z0A0YyjOv7z34DsBM8HRgTBrFaBr5FVuKRBw/Gicp
         g7cKeiTqCBG1Ejzju/Vjq9teslHvfaU1lwcZkQ0z2RnTv6bborwgkQlOWYkGjfUZ0HgY
         dZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EsglsVugqC646QVrSW+EmxeHeUWtGwOLKQ6g78eGjk=;
        b=WBmPOPpHcdebPXFfjJY7D4X2A8WXPltaOoIbhlss+LpTuKvrQ3jJHuMlVSEuKeNFjW
         w5K0FFNUB1QJd86UzCEpLOzg4KTEBnvmAggCpk7C6ba71qg4BFFy5CT7MuohbKJ6mm4H
         M5P/k/5D1LKSggei+MwbbImIoIm1Gm9QMSfvyqufE0txwRK4Dzeu90q1dRl7Z7RZ6oSL
         g1CPBug8xgDsPM6guKFPC+GVMaDdMeMIvxvbgPSB/4IlK2K9n1dwlyxMDGExMpfTm13y
         hsXTTH50rl06ksMKYBB7xetumj2nZX8fulXDO/zDEEGgB6+rYvLLRSuHWAMDVZJL3nvE
         5VLw==
X-Gm-Message-State: AOAM531adihUr/0+uB/hk92HGIvP/JGymy3FwF9YexWD1f10QuVaEe8x
        K4r1Pdfv8DMi57NUcn7uRvw=
X-Google-Smtp-Source: ABdhPJxnEv2e4bli2pS5CfCYVyTS8V18Fh9CPjE8cV5G/X8oiM63qMSvRJNC4J0oqhde/TLLfgh8oQ==
X-Received: by 2002:a63:1152:0:b0:3fd:b58f:5be7 with SMTP id 18-20020a631152000000b003fdb58f5be7mr568046pgr.164.1655140453702;
        Mon, 13 Jun 2022 10:14:13 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jd15-20020a170903260f00b0015e8d4eb1easm5409192plb.52.2022.06.13.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:14:12 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, kursad.oney@broadcom.com,
        philippe.reynes@softathome.com, joel.peshkin@broadcom.com,
        samyon.furman@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: add bcm6855 to bcmbca arch entry
Date:   Mon, 13 Jun 2022 10:14:11 -0700
Message-Id: <20220613171411.241070-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607172646.32369-4-william.zhang@broadcom.com>
References: <20220607172646.32369-1-william.zhang@broadcom.com> <20220607172646.32369-4-william.zhang@broadcom.com>
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

On Tue,  7 Jun 2022 10:26:46 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add bcm6855 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
