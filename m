Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258214F1E53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351986AbiDDWDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379360AbiDDRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:03:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A740A24
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:01:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a6so10379996ejk.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdkDEqkIYPJe0IiYUAZgG3drRMBxCNYZ0wWJB+F1HJ0=;
        b=yacEimsDx6EtXhSWHR/u21DYYeYT9nBoPDXNwwFSAu4BxrNH/02l8Jf0vS2eCMbpIU
         4nU6ssTnMI8IBH7ITy6CMY9Rqpn2XqqHD/Qv5Pk7XP1v84UzIGqgJRGjPtUZVyxRIDtL
         Qii4Bl6kloDFcqMAfmZM9+RN2dGVyQEAYYhY2TeDm6TThDumjRSwNzzPv7rIXafodpsO
         2l2Ez3vbAS0i3rrootsn44qWArjG0w0/lWvCNbjtG5I6jyTGp2Z6DbLIH0xp8EsIJR1m
         pl7hOkTknGWEnYZDkxd5/hebWcXvVqzn/23EXFD/rPqGB+fC00wHdTC/AZHMzzPaesAU
         Dj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdkDEqkIYPJe0IiYUAZgG3drRMBxCNYZ0wWJB+F1HJ0=;
        b=y9Koasz3RiegectCW4wMmVrk9gZ+ObnZv1Z4WOo32Qn42tJfXSrgynXUmo1KGymA49
         3NXcMD/ozTVlSQmYDoBHgrhlw/FL3vTvPddi2sTb1cI1rxNk2NRoSFd4e5hnVG7biXpL
         UBE5HV+QyfRq6jIwyH1KZUAgsy+ao0n07btnTO48dJdR4YslVpu9nL0VSH456eXLSk7G
         hV53J2aHMZjp1f4yHyQ3vSBv0QV4zMFCf6XnEWCftuVGzleLBX/B1GDv46ShPJNRgXpI
         cCQUib+SQ6M0bQhZQitAHDlz7kshHoWC+vPaNbS/fLeqoJ0ZdavOTp/yR+2xf3oKzs5Y
         61tw==
X-Gm-Message-State: AOAM533UYq8ewaJxb5+12q1spSPT5anr08KDopgvBZ1AVc3wAdpzfvDx
        7Chgh/FlX+8Y5ndP5qG5qpCr1A==
X-Google-Smtp-Source: ABdhPJwO8zEjm4+YadazUoXaa5sFLCdT/YW3MQ4yRm1ptx5qUf09HRh8cZszFmuXUB+1t5biovDWKA==
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id r11-20020a170906280b00b006cef3c7688fmr1079563ejc.468.1649091710942;
        Mon, 04 Apr 2022 10:01:50 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm4557770ejz.57.2022.04.04.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:01:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] ARM: s3c: fix typos in comments
Date:   Mon,  4 Apr 2022 19:01:41 +0200
Message-Id: <164909169269.1688455.7499660640126725885.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318103729.157574-31-Julia.Lawall@inria.fr>
References: <20220318103729.157574-31-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 11:37:26 +0100, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> 

Applied, thanks!

[1/1] ARM: s3c: fix typos in comments
      commit: 170a0c56c5ec597fa15447e63272827a80a19be1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
