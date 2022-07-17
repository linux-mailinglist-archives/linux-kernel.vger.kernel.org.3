Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6725773A4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiGQDJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiGQDIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:08:37 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDB1572A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:35 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10c0119dd16so15636852fac.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIxUE5cXSV3+QGx/oRwxtYuDWIYOJbAf1W0ycXXi4ag=;
        b=lX11eWz3WxHgwgSc4EqDi3y/9st0DQwgDeuy/rZs4c8JS8PbbTm35VgxaJm6HfHtNB
         RFjBvtgcUEY4xktxvmdIwhmE6CIysuC9QW3dFirii4jdwzyH62qb4/Bksd9cNccQHoXZ
         7/Uyz0ijvljcoj9zvv+cDXzae2x9YtJ/NAAljWH7UBvkO82F/CHGBBllaXi2kcIHdPx2
         iwceKVnKHfC9dCiTFquH9WVn14+pmvhU/a78h/S3ooeb1T5QZbffZZjPkuEEKBC1lacp
         eD7RZxlUDVvXy3GRH7LzlV3n7Ok5zzLYPZgVtOu5BX0sW/CJT9a7OI7/DPlhQmU80joN
         l5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gIxUE5cXSV3+QGx/oRwxtYuDWIYOJbAf1W0ycXXi4ag=;
        b=xlZmyupwCyvLZyS7+edq7K8LlThdc1bN6/6/14nu+eRuI0C9zgusYIOBo6SdPCzOsJ
         uuP3CxMp88VPfxzfCsxTQCWp9kabRMwk/dJBRm8UWx9MtCpCdms6i00e+liAcGWpLy8e
         X9riYLj6webdsNNIPcXgR92dgW9JiXFhf/dpkccDB9NVj1AMPg+08rQkh1xTgL3xQdRa
         1BgfkSkca0UhtpDbyUrvSyQZLk0MJE/h5cLOvkTo7s2/ndy+//nLfwnEaRxHXL/dLbED
         FEXd5OCD6KF3TyU34ffSbffbAPFVnfbFa0W4ggx7x66vA+acxIUltNJQdnbg48mOkV1c
         YhLw==
X-Gm-Message-State: AJIora+rn5dj0V9TzEo3BbxU4BAoU4P/26uw8Q5FH7jxtYhgcfYz1mpZ
        H90z21Y9qJTMmaMYcz7AsLTEfw==
X-Google-Smtp-Source: AGRyM1slwpooy2vZuZujiQWhMlKWXik47foLA/lsehdf1RlFAm9Q1KkX3Xjeh/nCMpsfeTfdniynmw==
X-Received: by 2002:a05:6870:c1cb:b0:10b:f2d0:e0bf with SMTP id i11-20020a056870c1cb00b0010bf2d0e0bfmr13334505oad.143.1658027315355;
        Sat, 16 Jul 2022 20:08:35 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z203-20020a4a49d4000000b0043577be222bsm3203928ooa.22.2022.07.16.20.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:08:34 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     vkoul@kernel.org, Ren Zhijie <renzhijie2@huawei.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robert.foss@linaro.org,
        agross@kernel.org, jonathan@marek.ca, konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] clk: qcom: fix build error initializer element is not constant
Date:   Sat, 16 Jul 2022 22:08:25 -0500
Message-Id: <165802729676.1737676.8397755968659757422.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220714121144.71062-1-renzhijie2@huawei.com>
References: <20220714121144.71062-1-renzhijie2@huawei.com>
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

On Thu, 14 Jul 2022 20:11:44 +0800, Ren Zhijie wrote:
> CONFIG_CC_VERSION_TEXT="x86_64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0"
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
> 
> drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not constant
>   gpu_cc_parent,
>   ^~~~~~~~~~~~~
> drivers/clk/qcom/gpucc-sm8350.c:111:2: note: (near initialization for ‘gpu_cc_parent_data_0[0]’)
> drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not constant
>   gpu_cc_parent,
>   ^~~~~~~~~~~~~
> drivers/clk/qcom/gpucc-sm8350.c:126:2: note: (near initialization for ‘gpu_cc_parent_data_1[0]’)
> make[3]: *** [drivers/clk/qcom/gpucc-sm8350.o] Error 1
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: fix build error initializer element is not constant
      commit: b5eb8cde863cdf455436c7ba3fb7362c49e1e64e

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
