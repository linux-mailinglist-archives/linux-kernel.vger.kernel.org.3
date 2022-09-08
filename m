Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7E25B1AD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiIHLFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIHLFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:05:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3E481F2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:05:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e68so4508497pfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WMsQMSX1hfTe9BFmiTHvFAjUCeXT/Sdp4+/k8oeGDSU=;
        b=x9H0iQ3XtO0RguDELrJ2jhxEab22MuIWWVcGxj+8aV9oS97z1hCG9QLWKTVI9e3ern
         CoEXl5u8BoLDnM4fie5AvPQw8dfV/6kxxDRjZhbG83rcYflxYCe8L9PmcDwamSJHd6ti
         pmR72MOckd3/JnwbFEhuej/HpjD2Bx9R2JA7JIbS7kYiIam9aThTcoEun1QdUKRQwVIx
         9yPyc+7EgdKh4yFksOIp9e8HjB+DVUM7J25HvLrOobyFBZ02RGJdX6+/0H1ywvgHGh+4
         vqKRIQR8zGKC9VKSj1yxAF0rl7XPmmiHbagNRkJnCW4tY5tNUne6C4BvjUKGPuNDYvRY
         fvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WMsQMSX1hfTe9BFmiTHvFAjUCeXT/Sdp4+/k8oeGDSU=;
        b=q4gqgaAke/GvVmnA5tIvDgmYXzNz0DuNyttd8cXTaR3WSdSGaRTzS0sfYD192Ywu6r
         AWZ+EVgWfLDQibVpRu0watP4VK16KHe6DihZVqmiYM1OA2USZi4H4f7/IRNYDXRdKjps
         8GDYUWTyqVe1/nieB3juKqTVqz5besekhT5vs3PXB2y7ddtf6/W6Af+jAgO2zD6mcoPS
         0bwjcfOJJ08hvy9iH60dpYZdLd9e8NlFSfh1r1HwJStDcovb+Mp56lXkCfHe0N3dePXn
         GFkZW7zLa/5pQm+YFXo5maahFYcnb7REG5IUEhK8LUNqyQK2SPAsKdbBzHiBBDsnr8pr
         jM3w==
X-Gm-Message-State: ACgBeo07FBVbeq9HW+zRTNiVZHDCd2xX/opF5tRNwFnz43pydCOHrWzt
        d7EPI7cTtLl+T0pMj1pgACLX6Q==
X-Google-Smtp-Source: AA6agR6ujvV1j0Sqsy7/cnqFqwHILNPTNuLZxWGMAPxKylDgw0q7HDxUlXoOGRl2S1cIrBBZhoTKRA==
X-Received: by 2002:a63:df14:0:b0:42b:484c:4273 with SMTP id u20-20020a63df14000000b0042b484c4273mr7264437pgg.186.1662635101819;
        Thu, 08 Sep 2022 04:05:01 -0700 (PDT)
Received: from localhost.localdomain ([124.123.189.206])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00174a4bcefc7sm14426395plh.217.2022.09.08.04.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 04:05:00 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
To:     f.fainelli@gmail.com
Cc:     anand.gore@broadcom.com, arnd@arndb.de,
        bcm-kernel-feedback-list@broadcom.com, catalin.marinas@arm.com,
        krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olof@lixom.net, soc@kernel.org, will@kernel.org,
        william.zhang@broadcom.com, anders.roxell@linaro.org,
        lkft@linaro.org
Subject: Re: arm64: Kconfig.platforms: Re-organized Broadcom menu
Date:   Thu,  8 Sep 2022 16:34:51 +0530
Message-Id: <20220908110451.66564-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220712164235.40293-1-f.fainelli@gmail.com>
References: <20220712164235.40293-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lkft@linaro.org

LKFT test farm found that Linux next-20220906 onwards the Broadcom DTB
builds are not happening. And after bisecting we found this patch is
the reason [1].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

FYI, We have not changed any kernel configs.
[1] http://ix.io/49Wq


--
Linaro LKFT
https://lkft.linaro.org
