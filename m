Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C3578DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiGRXAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiGRW7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:54 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6533416
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:31 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bf634bc50so27900937fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=03LF5AI/NRTuD/kyS3OgVmU6nY/7BwKmaxTyhvUPiv8=;
        b=Ksc5LSfoveTc5spzX5+RHcF06T0ME6J9F+KmQmCChPqrUcOSWXBKjzGEMAOBeofcOT
         Y/DGf0P3FZJECh8tpUplIwS8GxduPhfhcm0jjci4dLv2s4oZIUiu5mjg2AxMu+dTuuKe
         IED1DJAy+EPEteErMxPgYhpv70NK5ww6FGWlk9+XaBC0CkCTJtqWPQ8yLSY0J0BF/CTr
         ascKv/uw4tEIVk37CWiW5fjMscttD1Bx+BOI3pkclbmljHGfamgaZvm5Cmsj8tXDWymh
         u4nfnFqDE2H2n4CQAfpd9iNHnnJ498j/0c+EPvV0KSzbieMoCvA20tP/bIlTaAQsAlCl
         kgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=03LF5AI/NRTuD/kyS3OgVmU6nY/7BwKmaxTyhvUPiv8=;
        b=s47pnezIKzX99MH/lZplNCe9txO7qF/WuTHDDv2CurIfBGARj37/3c6kg7s+I41myw
         OFU+1Fm5v+eOpDvavsLQsfRTY6UCT7uq6K9p+wqnSEEBTEYb6BBKjPi+aIXWiqEphwZY
         G7G9jGQyHiqr3o6+trTBtjkPVXEoNurSIyhf+wsJz4wCW1lPluhbtNaz+RtdJpCIu4Sq
         ePdkShvSmzFZq6zlveIRDK0Io1yqO45KBGits2qki5yH62F5Q3dorrP6P/6RyGkJDwnX
         ckTdvJbfrttu+rP35zE5fumxjoi8wzC37fpev+L9e53GfITEzXbW6Z1kFhspt7Itc/r8
         HJFg==
X-Gm-Message-State: AJIora+yLohwxpIAgnRQ2vYp9g6DPBiYp5daZSm3H/S5HxL3GAH+VVT2
        kfjoUYBtTMtTQvebT++DvHMabQ==
X-Google-Smtp-Source: AGRyM1uQXJXECfVWeSDUL1gakmAAxWhayKcDa92Y0JVrAm78oukdolXUfwGG6P8vFuqc1xkizr7qjw==
X-Received: by 2002:a05:6808:18a9:b0:339:f385:a7c9 with SMTP id bi41-20020a05680818a900b00339f385a7c9mr13967278oib.242.1658185170485;
        Mon, 18 Jul 2022 15:59:30 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     agross@kernel.org, mathieu.poirier@linaro.org,
        zhangxuezhi1@coolpad.com
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] rpmsg: convert sysfs snprintf to sysfs_emit
Date:   Mon, 18 Jul 2022 17:59:15 -0500
Message-Id: <165817634388.1905814.15887899020372976123.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220607120649.78436-1-zhangxuezhi1@coolpad.com>
References: <20220607120649.78436-1-zhangxuezhi1@coolpad.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 20:06:49 +0800, Xuezhi Zhang wrote:
> Fix the following coccicheck warning:
> drivers/rpmsg/qcom_glink_native.c:1677:8-16:
> WARNING: use scnprintf or sprintf
> 
> 

Applied, thanks!

[1/1] rpmsg: convert sysfs snprintf to sysfs_emit
      commit: 7113ac825371c17c15e2d0be79d850e5e16d3328

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
