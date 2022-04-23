Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1A50C6FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiDWDuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiDWDtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:49:40 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452013977F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:46:46 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-e67799d278so6809000fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VK+Mc12IDWDoCeB4UokFVRy/0yOeXXdrFoo8csy15fI=;
        b=rj1fWjvFr6UfrBYJZaadRrPi88B/qmQLm8ZzbEv6/alcfmDFmFeBGWnL4HKOjP37Oo
         XIMpB2qQ1V8TZ5PJZgcS9t0rwYLuCx/HXeYd46dXX9BffgCtszf+ujA7bpVEDTbTllKr
         9KuNVf4yaUNy1B2uLsiF1lj0wM19F15AdtbVlPC3DYFAWn8EYd5Wb3/cp0mY5gePmOY0
         uDlSHzgYy48VHrRChwQWIbKfAU2B7/G+sVEH4wDLIPfXhyL1qCG67Gokmjruh61W/Wkf
         ArAI0RkwHAhB9loPoYk+0/fRNf1D40UaO2lsgdjDih3yTT+SgLXv2D69dVSO4yoTT1lF
         9EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VK+Mc12IDWDoCeB4UokFVRy/0yOeXXdrFoo8csy15fI=;
        b=dDjY7rpYij1qS4EP8O35ZoBqZ8ZmuqTWmblu5YYRCWEwgwEtq+izypcmFstvqrOvBu
         IkbVXnuynfNmWxuaaYM63B8ZUcCTWdMVRk/TA1jsRn7wz6i1CTjQYDsDvyBi9xmCFUj1
         zSsV4z7FVErmNMrmTY+nHsd5pKoUTa2gNra1vTEo/JCKsSNCMA+wooMDbLNgQxqBqfuI
         EUYyfOTLvGAqKrEJVXY/al3V9co8+ksXIum3M3NpVbI6GfWLYVsf7ieS6NhnZMefa1rb
         PYIe+1E/DSIjY95yoxOI6NK8rDCWPp48YTqEcOdHz3uf/kxNYNNl9y/3FXgMjgjDevQu
         h87Q==
X-Gm-Message-State: AOAM531SRZSKgWvoKb4MA5NrhbV/Kz8WnAO5IK19nHMg6peSJTeFgC+9
        oz6C1yFzRdVjOLaBLgxwqLS0zD6ygyE+tQN2
X-Google-Smtp-Source: ABdhPJwkRUj9ppkMSZqmz3YeDFf41/hx08RbxlEXevnET+FZzlP8mrOGYwNPSqQII5QEVaDRbcIT6A==
X-Received: by 2002:a05:6870:8907:b0:e2:a4fd:7539 with SMTP id i7-20020a056870890700b000e2a4fd7539mr7629021oao.56.1650685605139;
        Fri, 22 Apr 2022 20:46:45 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm1440218oia.31.2022.04.22.20.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 20:46:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: (subset) [PATCH] rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value
Date:   Fri, 22 Apr 2022 22:46:41 -0500
Message-Id: <165068558593.2759280.17055526649115604333.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422105326.78713-1-krzysztof.kozlowski@linaro.org>
References: <20220422105326.78713-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 12:53:26 +0200, Krzysztof Kozlowski wrote:
> The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.
> 
> 

Applied, thanks!

[1/1] rpmsg: qcom_smd: Fix irq_of_parse_and_map() return value
      commit: 1a358d35066487d228a68303d808bc4721c6b1b9

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
