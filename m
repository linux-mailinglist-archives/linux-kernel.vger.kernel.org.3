Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0723E4F681C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiDFRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbiDFRwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:52:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4E45EF91
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:02:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b24so3171832edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1nMvulTyjAQlfGQlFvn9ByZ/Xs7FfvmoWgSD6UTgIi4=;
        b=UU/zBJrBu0bO7Xqa4v0J37isWeusdzqmyr8N15g9CJkCb/kLyX4Crb6CCyqHaOgDBv
         clBr/FnBH6uCwDXmeejrujtz1+HFyuZFbm6b2S/9T5itKG3hewFmL6Bb11E7B+wuBNIO
         46dxtVib7rPNwHJTGklbr/LaM2VBrIXhAA6gPVtCqhyJlRWd3zdBYMIHfCand/cUCpop
         A43ck5TO7ID4PVsFMBIwi+04EWgJS3UOs+zQHSL0PSWuYwAwF+ydhZ+vnX/Twz/ZKnEU
         tT4cdoxzOJW1vv8UFBnD5T9c/RvpoZXuY2yThw5XFzJa+vCDwddNAU6sx4+rzexkUNM3
         06fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1nMvulTyjAQlfGQlFvn9ByZ/Xs7FfvmoWgSD6UTgIi4=;
        b=A4ieEX4ObT9EArhv31eigrvyomhsSRnpCNzVrt0+H6G5dSSS/8d9a+YK0zYSccQibI
         Z9CcMV/CBC46jKu//8b1qj7diTg3C4UdDr9VVXDsHT8W8U3LQbjqwQADu4BjhZ+E3Z5V
         c8yIAIELuQj1SwNrpY31RiSo4neJWdUPUs0tZXoAMZDjY30Dfi7g/dex1LxIVVifw6Yc
         xQTCP53kylK4kYwAJ76evd174SKssFQxoVrYgkbkWYNIKdWKFiYnQhqsC7y0z8ITuCT+
         NCEmwYGpj4CtOzxerBb3ce3aSnbnMWeWM6jwaanSx4ohpBufV/hKNqOrtv9Fmc5hX2sI
         5+4w==
X-Gm-Message-State: AOAM530QvNR2iEbHnWGBQ0PLCVy8ze8OU5IwjYzjLsYf46hSLEfImcRj
        Aq+KLtHPjgQmIVeZbDcEsn6v57Vx4rGkEnzq
X-Google-Smtp-Source: ABdhPJwJUWlTStrJAW6eBVNH8NXDfYYTBfCgGFtZQA/flkJslFlLrb69F5d2Ss6nmBL2Qsj1jwxjAQ==
X-Received: by 2002:a05:6402:5211:b0:419:583d:bb58 with SMTP id s17-20020a056402521100b00419583dbb58mr9490760edd.198.1649260927688;
        Wed, 06 Apr 2022 09:02:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b00413c824e422sm8060666edw.72.2022.04.06.09.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:02:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] memory: emif: remove unneeded ENOMEM error messages
Date:   Wed,  6 Apr 2022 18:02:05 +0200
Message-Id: <164926092322.618472.11762228806748055286.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304082339.230938-1-krzysztof.kozlowski@canonical.com>
References: <20220304082339.230938-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Fri, 4 Mar 2022 09:23:39 +0100, Krzysztof Kozlowski wrote:
> Memory subsystem already prints message about failed memory
> allocation, there is no need to do it in the drivers.
> 
> 

Applied, thanks!

[1/1] memory: emif: remove unneeded ENOMEM error messages
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
