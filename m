Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7FC578DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiGRW7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiGRW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:59:20 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6AE2AC6B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:17 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10bf634bc50so27899897fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PgqR1jKI0A85C1IQhaR5HUDNNSKaFrSALeEso3MtDOI=;
        b=WozDfSV4Vy9YwDaf7EZSDXbXpJ/bZ/rzGSSUFktME4Y0Q+oIh1YdED/tuelXk8ZSVD
         fUTFrH5lvb+QpgYEaovzqjoR12EK6Zr+zak26/uUDq4lcJHY/Ll8iLZ77l0c5QvLNE5b
         9FvMtwWcSdvzNQKfNqugOePuyiQzMU1YuHFhiFnLGT6slN0ovHwpcRnxX48PIgkRAycj
         VkWNYDtzW3y0OYyDn7IcUPJBm2ZTxDaI3DfkZ5Jo4NBSyt+jwk4pR+5NrabwlWMjpGpl
         Cr4oPLItGgKEWoxx+PuAq+hgeHYBicWKVRRXfSB20BeAyJEZVBEmRLsB4P7hgDngeWt+
         4LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PgqR1jKI0A85C1IQhaR5HUDNNSKaFrSALeEso3MtDOI=;
        b=46rduuRHNDjwDfr5ktj9B+j7ElqKg1nXIj7DFeHNG4BljCR632Ijb7zs9Mjo8qQT+A
         y4mR3tQnAx/Sa0gjnhopRxApSanl6b7l8+ifnISP7PYjKLmetq+3ke5GlxHWNspvgZKR
         ty1jc8suH2nuhYfeCAc5m7HovTIyRoW4DqDAzBs2sTEOBDeYYzcZpT/K/F1kcESOtpOL
         2lcACQHfgPYxT9NwshuXtWi2IJnF/71W6ssi/OfFjnEQ4iIcfuupOo99z05tH8cRFXqa
         yfzzfX/Py1SXd7dIn/t+aI0H0eQMNdSbKec3/qXRN5uGkyQx+eSgo3v9HuoiWBV1Jst7
         8yew==
X-Gm-Message-State: AJIora+uKA9slsmDICyuDc/da5K3ImYYmTyKnkRlkcdt+JWYX6AV+O8e
        HknQAwqhkSa+i7SjNDDW3bqpcg==
X-Google-Smtp-Source: AGRyM1uSuOoRlBk5vnyTx8l6Y0nQ6zqrPqI7FgzlXvdOlyxp7NUB+xAZdkj8WvPLdwIsDyku+n0u1w==
X-Received: by 2002:aca:62d6:0:b0:335:b346:caeb with SMTP id w205-20020aca62d6000000b00335b346caebmr17469409oib.290.1658185157153;
        Mon, 18 Jul 2022 15:59:17 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j10-20020a4a908a000000b0041ba304546csm5330931oog.1.2022.07.18.15.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 15:59:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     konrad.dybcio@somainline.org, agross@kernel.org,
        abel.vesa@linaro.org, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH] remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators
Date:   Mon, 18 Jul 2022 17:59:02 -0500
Message-Id: <165817634387.1905814.14923150249739430143.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220713152835.3848875-1-abel.vesa@linaro.org>
References: <20220713152835.3848875-1-abel.vesa@linaro.org>
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

On Wed, 13 Jul 2022 18:28:35 +0300, Abel Vesa wrote:
> Use _get_optional as some platforms might not provide the px
> and cx regulators. This avoids printing the following for each
> unavailable regulator:
> 
> [    4.350229] qcom_q6v5_pas 5c00000.remoteproc: supply cx not found,
> using dummy regulator
> [    4.374224] qcom_q6v5_pas 5c00000.remoteproc: supply px not found,
> using dummy regulator
> 
> [...]

Applied, thanks!

[1/1] remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators
      commit: 726ab322d3541cfd056ac938cd7e2e441dd7779e

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
