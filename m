Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D255D5773A8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiGQDJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiGQDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:08:35 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2F14D19
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:34 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-10c0119dd16so15636763fac.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZY9ppo/NgfpshR/QVcrrN7xSjQ/ifkZSAsHqjerp1g=;
        b=yK4F1wdwXGsMObltazKE1YBGgXJ7B/3z//1oEVjrXiUIRUYezjGaZSVbaauKuTNxYt
         PeEUZmOiM5CFRQLxA513OwYUZZdxT5GGfHaw+sVfDmiEg9XTXzVFSBWPlm95gHuvD9vb
         hWCe+0GfYFpKQ2indy/vdeIsdnd3Wrdkw9g1hOGT7fZ9NH9W2fOpAJcOgoQf7bVfUPk8
         fCtkxWwEM0WKD8ODV1Wqtud08OsxlIemv9pAjfo+pxH3o2i08you7Lz+Ot9gv6pTF2km
         hshi/g7J3KyACHnjnoZ9xEQpKxdoZaRHzx8B+OaRoeb+65bKtETwClUr2FIKRm4NlPZo
         Hphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZY9ppo/NgfpshR/QVcrrN7xSjQ/ifkZSAsHqjerp1g=;
        b=5nSVK185q6HLSNnIjeAgI4x1z93xf7bjMIEkW7uA2on81xkCJ67OPbcVo1Hdq1iHAI
         j+2Eci4RMoyPktBWN8pp7UrwQ9xOFNOeAR5i+t0vyHhZ698wjQ8vMrpXmmZ0BInaV0W+
         /JbzoCsGrR9tZB2mReMKKIySOLaw1ZvOcRMUuXsf86tKYfJN2uQzXci3fI+xXMOOfRqv
         bjB+b4Z2zHk9231dGrr4n8hDYgInV3DAaKe40WrMVnjkhgitBdJG0GEpMhLjFX13Wb+c
         tUNFoJWzH+IRyplkHx/nB6vMyq0UeusMY8UTvmaK9kGpvZLgrqxv3cKZcuO1g0ZjKreS
         6HKg==
X-Gm-Message-State: AJIora8VtqEt0rfydWiz2jlV55Vyp0pVWt2vLxKf+yYu7xY5MtW9BqZA
        MwotrCa1eUJDFsL0/4E4C53IHg==
X-Google-Smtp-Source: AGRyM1v3nnHO6ZCxIoVgjBJgBGU1pFjvf8y7ef5TPkVxsxMBlcZmx1GEbm0kglBmRvi4ihlLzzD9lg==
X-Received: by 2002:a05:6808:e8a:b0:32e:493b:1d8 with SMTP id k10-20020a0568080e8a00b0032e493b01d8mr13621810oil.124.1658027314277;
        Sat, 16 Jul 2022 20:08:34 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z203-20020a4a49d4000000b0043577be222bsm3203928ooa.22.2022.07.16.20.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:08:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH] ARM: dts: qcom: msm8974-hammerhead: Add notification LED
Date:   Sat, 16 Jul 2022 22:08:24 -0500
Message-Id: <165802729676.1737676.16131388789289180300.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505164336.13210-1-luca@z3ntu.xyz>
References: <20220505164336.13210-1-luca@z3ntu.xyz>
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

On Thu, 5 May 2022 18:43:37 +0200, Luca Weiss wrote:
> From: André Almeida <andrealmeid@collabora.com>
> 
> Nexus 5 has a RGB LED connected to the TRILED and hence channels 7, 6 and
> 5 of the LPG. Add a node describing this.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974-hammerhead: Add notification LED
      commit: 1ea9098a81133d54b3d40d7ffd197f77881e5ecc

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
