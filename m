Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D844E5A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiCWV0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiCWV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:26:46 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE113CCC;
        Wed, 23 Mar 2022 14:25:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id pv16so5512236ejb.0;
        Wed, 23 Mar 2022 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=vysV2YUxUhlwVd6KhPoL0mZSMTmNq5rE3h8xE9VrJx8=;
        b=PtPwjommumuKRrAvDNWWBgum++vMOpb0uWE806D+fInZ45L5E/NJ9NyFzFl2g2MRWp
         NTUwDXLUNCmW9F9V1lLFtHtdGzUxc/Aq6/j4pJSIYNzRUiEGUZnrX6zZEwFDN4bimt88
         FR9Lssy5lLk0/a1O4jgG4MTg81Q5gnxXNnQJVnUe8Zdpbm0XHwURNoPp4pY4Lo32K1kM
         FPz4sr1TxjtV4lRX+yj5S8WnV8JN4CJQJ6DuVHzcM5WDtMikxSxTMlfFUBtHFJU7+XV/
         bRcP42q+GfMms+7ZmvTkae3LSHRSblz8Qd2FSZh5ZN7qfpqg3H8SbiKx8myY9Sgvm4hP
         baWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=vysV2YUxUhlwVd6KhPoL0mZSMTmNq5rE3h8xE9VrJx8=;
        b=WkOKKjbgaPusCt+DimFWTlj85j6BbXwULMx6zjosWtqeinOiK7kpEyaKgxuodinU9Q
         GtU1pXa556a91uIwjRbFqLDVlE2DlFodAaxPPCAINsj/jPwS6VG0DB7AkasEQ8XR+2l3
         SJZ2oDjcLwJOu9ara9LJJQoAaDeBIp8/3G+VaKPkNYl63RFKZddB2twcnYsuSbcu8C8P
         NzkcB8XTV4h6wzcnxaxPsHCHo0ZEdgr0izirWLx0+T2m8qty6DAo6cjdAIA3SBCfCqhq
         qmzg4363wY7bjV7dFRsK2SgqWRG5g5FRG2864nSwo8lyyv8olVNS3t8qD5NYevUkBb3D
         E4eQ==
X-Gm-Message-State: AOAM531UZJVJiVR/FWV+G+Lij1K/SxT3l/Fg068i6gIddt2wZc6iM8Sa
        nSzKs4IkDj/kJPIvOirjGDSv0zCi7wM/Gw==
X-Google-Smtp-Source: ABdhPJwgfyQqYCEPw63TtPi+2J3FKbcZmNiqLGPwcV4bZp0KThU5s1y2CY7v1zeV7VqpCCsJaRIQtA==
X-Received: by 2002:a17:906:dc8f:b0:6e0:5ce7:d80e with SMTP id cs15-20020a170906dc8f00b006e05ce7d80emr2228061ejc.435.1648070714984;
        Wed, 23 Mar 2022 14:25:14 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id d23-20020aa7d5d7000000b00418f7b2f1dbsm466065eds.71.2022.03.23.14.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 14:25:14 -0700 (PDT)
Date:   Wed, 23 Mar 2022 22:25:11 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] arm64: dts: qcom: msm8994: Add mmc aliases
Message-ID: <YjuQNx/zEfq5/9JR@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20220319174645.340379-1-konrad.dybcio@somainline.org>
 <20220319174645.340379-16-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319174645.340379-16-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad, all,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

BTW Documentation/devicetree/bindings/mmc/sdhci-msm.txt
and real code for other SoCs uses sdhc_1 and sdhc_2.

I suppose sdhc[12] (without underscore is the preferred variant.

Kind regards,
Petr
