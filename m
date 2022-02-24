Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E74C2AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiBXLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:32:50 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE7B108BC4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:32:18 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6D7213F1D9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645702335;
        bh=6QAB5G6wzlpUL0XVf4afDiAG1Yh+7YZL2RUHJwx8q4s=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=gW1DHr+KksU8Mh02pXAeZFrEOTpnGKu3OsBNKOfSVS0ZtcSgUta2aWmemfGEATo7c
         ajo+iFey9DPB9UspDn7Dv3SdyPMnmw/Bg7zoIwLlX9tJZ7W0aVCXod3lIkwHakkeu6
         41upqSab8etbUlOhnL9pw5FWdSJlX1gPvFNq+/jtZDogrd1AvQhfeWKOF0PyZPyhAG
         CDyz/MDy7nX+GnwZw3FuMpDn9Noy297SIm+bsKLa8dltZDl8ORs/22Sqpwdn+ygxCE
         9CSJ1hX0cdSM/sanygdEJoKgb2UQ3977OVwgAhqLHZdhsjLf1I3V86lLwrFpe0xaBR
         ngokaEb3+WytA==
Received: by mail-ej1-f71.google.com with SMTP id hc39-20020a17090716a700b006ce88cf89dfso1079554ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6QAB5G6wzlpUL0XVf4afDiAG1Yh+7YZL2RUHJwx8q4s=;
        b=WOrZ+MIQyh0eWap+Y+YgkHBNHX5NwMeYrY1MdLGuOJjyX/Lrxibyn38yKV7OsckcZE
         ToAufh3FBVZGUNdvoenAk3nso1b60VbZ4g7vxwBRFHI9aGqUuq1yvhDWdxycJnMwW+Gy
         lbDu6FNUAWa0rx4KQ6lWX2CpFT4R+vUhl6SYFBPhaj8dmGfdl916cWQAXNBKCrh5IfOB
         FHydzG5OaQS6IcYrE1QXkNugD3w9IarPCQOx5t75Pfw5xSVMKifhlFBcjdo0CA09MIQE
         OOHU5p6SlZSnSqf1QTqg1GGfj3aRw34QHMGyn5+9voF3pYe8UZ031Ok/Nk0JgVz2eweG
         XlMA==
X-Gm-Message-State: AOAM530hHVhkvrcaykcyYwzW5q9fLwaSFdg43c9mKAAZZTZT/bzlg4cK
        jqMenO6sy5KuwcXMbwbUsf0Vts7ymENBPA6BgTI1G4wePU781zU6wWq1CF9tJar+PQN1O6SGYLl
        ZB+jvDnDSr/FLzpzx/ZIXoFXTgUXMOwLSGTywJ9PV1Q==
X-Received: by 2002:a17:907:12d5:b0:6cf:bb0d:9b2f with SMTP id vp21-20020a17090712d500b006cfbb0d9b2fmr1956422ejb.138.1645702335155;
        Thu, 24 Feb 2022 03:32:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzCHcLPyCC1s3Ik7qr4TIxyXVnkkXqNSDejNUcwQH9N3LVSxYrf8XbZW/XmE73MCY/Ws4QGA==
X-Received: by 2002:a17:907:12d5:b0:6cf:bb0d:9b2f with SMTP id vp21-20020a17090712d500b006cfbb0d9b2fmr1956410ejb.138.1645702334964;
        Thu, 24 Feb 2022 03:32:14 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v30sm1216688ejv.76.2022.02.24.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:32:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-samsung-soc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: fsd: Add the MCT support
Date:   Thu, 24 Feb 2022 12:31:38 +0100
Message-Id: <164570223367.241583.16227180262128695261.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223171858.11384-1-alim.akhtar@samsung.com>
References: <CGME20220223170727epcas5p20066f8455fa0ca98323ac286dabc90ec@epcas5p2.samsung.com> <20220223171858.11384-1-alim.akhtar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 22:48:58 +0530, Alim Akhtar wrote:
> Add node relevant to support MCT, which is used as
> one of the system timer on this SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: fsd: Add the MCT support
      commit: 272a253338f91a192defc124930030369b2a7fd4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
