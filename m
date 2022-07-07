Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7262C569787
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiGGBcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiGGBck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:32:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692D2E9DA;
        Wed,  6 Jul 2022 18:32:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id j22so3646749ejs.2;
        Wed, 06 Jul 2022 18:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=73StDBafAFoimZWPDY5sfTCTqYtNMPriED7nm6PDGRo=;
        b=Ygudwhr65932O7JApn/NRyICurvHUiDHCRkQ7Az46Vr+Y6DS/yHV5A4NEMwA9Bs30U
         8w+dsl+PZZ/xW4U5/MviH5Z76ytSvVZ40AG88NPoYp7eMpqjcAgP8i5ckUV4gMd6bcjK
         dr9C3pg9Ey4mx6Y/qoEu4wVHYvf4EQX6pD5k0++k9fd75YYEXn+Vna1VjhHijihq3QXS
         aMmO2Pf8nK1UQYb3kzK8hUqQYSUDYP2prTEK+X1tdHIJeS6TxxWXMZR9B3QRjP1PEOkE
         VU6AOodMilcCEMb6W3mGWIrNwi6j2qiXmWxv4DOqBMi2wOWJZRZrL9U8TpyWVZntsXhd
         RqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=73StDBafAFoimZWPDY5sfTCTqYtNMPriED7nm6PDGRo=;
        b=W4CWghX9ms0oZH9VQIgOz6lAwih5M1rBcJOuJPbWHugofHeU/6Fm8O61l5Hh09+Ab1
         tcdtnoM+9kPk7E6yd7su/qjRzjgW49pZOUtSpU+7tqcvjv0/khnXVC26NPWeD3j2NUy1
         xrvNX+uzfdj4Gr09mneXcOEsMSMM17Hx+8Tfy19YstAZ+xDKFrjFxeDu3iicJbAA7CSK
         o/2jSuOpJTkKGmNv0Be2NJZ/Wa6wWTBp1uDRV9UHCPITh+b8sa9yP2njBjPpDKrPu2rv
         9WPFSFlvvIdsVwx/Oc1NBafp1ML43ob78aBPsbMIBuVyDNISeJ6ER/F02RsoohSeRiKS
         uleg==
X-Gm-Message-State: AJIora8KMl3nIKHQHSDZcW2DvhzDae+v8Ghmdkw1dhSmy+2ShbxT9Mqb
        ecRGl6mXzZKdgdiaf85/aU4=
X-Google-Smtp-Source: AGRyM1shRjseXx5SkyieU5cWhnsfQl8dE6QOU6IdufehChSX1/HytvKdx4brLrT0D89tbuyznhJEMw==
X-Received: by 2002:a17:907:1b25:b0:6da:8206:fc56 with SMTP id mp37-20020a1709071b2500b006da8206fc56mr42799330ejc.81.1657157557966;
        Wed, 06 Jul 2022 18:32:37 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id f22-20020a056402069600b0043a7404314csm5870698edy.8.2022.07.06.18.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:32:37 -0700 (PDT)
Message-ID: <62c637b5.1c69fb81.6f196.90a2@mx.google.com>
X-Google-Original-Message-ID: <YsY3tAZVHlWTcp7x@Ansuel-xps.>
Date:   Thu, 7 Jul 2022 03:32:36 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: add missing smem node for ipq8064
 dtsi
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
 <20220707013017.26654-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707013017.26654-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:30:17AM +0200, Christian Marangi wrote:
> Add missing smem node for ipq8064 dtsi.
> 

Slipped while fixing commit description... pls ignore.

-- 
	Ansuel
