Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ABD57922D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbiGSEsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbiGSEsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:48:21 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A4B3718B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:19 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g20-20020a9d6a14000000b0061c84e679f5so8247130otn.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 21:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w+cVs+fEQHDsD6oHIwKG/7UKi6EY2Xf3i8QTO+aFkE4=;
        b=TxkSoADWN0O8CrifsBppV2Ph6WlHG7OPyL3ck673pNG/3MQqpIeQ5QnJSgu/wY4foj
         MB301r+SyH/nTQirYvbS3RO6TEO1ZbCV0wDiwuk0YaP4WUEEYfbxvlbLmdCuvK2YL8v1
         jr2OWcD/2tbzjXKfN48jksCUdmdFcTkQiDobWwpUtBf3EV2by4tkfjMVgL8AHnCl2is0
         WAuPEggzVd21S2BQaBbbCcDEHFLBdW6glYyIDoyHDtJ1H4IOoz03C7Maz/D3IO7U5nJy
         Wdg+VZaujaA2oLwy7SD1lOEEluPGPQ3prtAef0mTIAmtQz8Wr7wFAnnxFP143gGANWKD
         JWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w+cVs+fEQHDsD6oHIwKG/7UKi6EY2Xf3i8QTO+aFkE4=;
        b=XbaGMHIguJIthCCFIZrDlbGXss4oC/sbTSBwthBxwJNzagGBr1m+COdUJUp8UBvGud
         XkxeR6QzekGsq+95J+/BnOhbEbhcD4HCvkn2qDBxY3vw19CXlA+GY10Ma5JtrKdWXoky
         VyIMVRy1upCLwma5YuFGi0mN7s/7+Mv5oZtDntXkbQH9GH4a5MWLblK6u3R6iv57IKfA
         6d7ltVzl+IhPJQHFJ+dpkA6TlJRn6Gpflw2SqOLLM66FNuuliW6QJgbUTHngmDCQM+33
         k/4TnXS9dZ8dXPKxECDH42wiYd4CF1/eW/EzskM6OG1bDwpJLRWUAPU9eDa72dCqK1pL
         6Pdw==
X-Gm-Message-State: AJIora9UqO1xwuo6d7TZTAVxCXx82QgwV58jLc2KhV49a+AiCXvm23WJ
        6KuffPsK/YUR/oAiG2qIpcVu/PdLghTH2w==
X-Google-Smtp-Source: AGRyM1vg5K8aulaVSJY8dvVh+J6/Vo3qbIBBgMDz1OLizGQN+CyxsTNYFFiiJ48gQJbx5jR0dgdKLA==
X-Received: by 2002:a9d:2c5:0:b0:60c:2bf9:1dbd with SMTP id 63-20020a9d02c5000000b0060c2bf91dbdmr11776387otl.254.1658206098757;
        Mon, 18 Jul 2022 21:48:18 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w9-20020a9d70c9000000b0061c9bbac1f9sm2803209otj.16.2022.07.18.21.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 21:48:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     yang.lee@linux.alibaba.com, krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH -next RESEND] soc: qcom: icc-bwmon: Remove unnecessary print function dev_err()
Date:   Mon, 18 Jul 2022 23:48:06 -0500
Message-Id: <165820608068.1955453.15631286847684499008.b4-ty@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714075532.104665-1-yang.lee@linux.alibaba.com>
References: <20220714075532.104665-1-yang.lee@linux.alibaba.com>
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

On Thu, 14 Jul 2022 15:55:32 +0800, Yang Li wrote:
> Eliminate the follow coccicheck warning:
> ./drivers/soc/qcom/icc-bwmon.c:349:2-9: line 349 is redundant because platform_get_irq() already prints an error
> 
> 

Applied, thanks!

[1/1] soc: qcom: icc-bwmon: Remove unnecessary print function dev_err()
      commit: 947bb0d16576bdac27f3355f268f51acfe29bfa7

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
