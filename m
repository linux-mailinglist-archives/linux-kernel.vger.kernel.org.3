Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319B558CB22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243495AbiHHPRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbiHHPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:17:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C872613
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:17:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so11340648wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=aEEhusA2uO3xOlijgosxmVncGIW0XNq+zhiCAYCpbsg=;
        b=zttKVRlrIAOc38bj0MZFaWmrn7v4G2JZHrXcj7BDj4Env6G4AwrZi/Y85unzwlT/VT
         5g3H3ynUIwRcYdmrwXQN6y+2kse2fNwAAO8FE35IsnysmkTI4+aD+FHFWKtlqE1bBqiF
         CqjAgcPoaAXr54rS3IR5YYGlpfUa8eBfZWRBuSm1YH7UbCmkYKOSLTgzcl3MVUSS3gh5
         XE/F+tRaaPbB0vSlZ+6veOIvQZcYQ8Qp8Gel+9oIWGlijz5UffmXanzUz0AJWHZQieIT
         hMsTu9L73mMtGCeDbItrfep7M8oY8ahRzW+E3oxNuCVZMfhiXPoWUYBTVdYhrPgoJC0B
         pCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aEEhusA2uO3xOlijgosxmVncGIW0XNq+zhiCAYCpbsg=;
        b=vBdZtvdk3DsC7gOA27CI4HRz/jFtXKJ0k8yZ/jv/encymfRmOvvMzsLQJW80Q2a7LL
         MlVF1ThDaqBOtwkG++UNOM/G5sWmXfuuv0VOfm+GrR09b9vfaTfQ0Efw2aIwWzUptKqn
         lV6qo1UmuMbY/rYoXI646VPlUlRiyVfPL0fbSd3Ecd2RN2eR5wsX4XFdPQ356k7LPG0o
         fYB6afXipBsQrqKEZpHPhDK9bHx/riWucxd8Dfj/g3RSN6xaThumlHIfsM02Bx2pLcbn
         UlxrNUpvTCJ/dWJwarmg/9l1Ep0HgX/dtY7v5NXd8bbqHVFjSSS5zu/0EOG44DkoaWbW
         67Tg==
X-Gm-Message-State: ACgBeo2hP8vhc7NuNY3b7dNUzA1drTOLFMnmTaw2JifeSspsr1oNrbfj
        SyhdjDfI7Mj9S86zhUpuxJ5gvg==
X-Google-Smtp-Source: AA6agR4nqJfrXw3Y9cimqQMY1rskwGr4WzCVKXIdzR4n+rXaRE6zJbpwUZCJ3pwH9RFOFaKqVD2YfQ==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr12457600wri.39.1659971833810;
        Mon, 08 Aug 2022 08:17:13 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b003a2e89d1fb5sm19346419wmq.42.2022.08.08.08.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:17:13 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:17:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 1/5] mfd: stmpe: Remove rotator block from probe
Message-ID: <YvEo9325xhM2fMGC@google.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-2-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712163345.445811-2-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022, Francesco Dolcini wrote:

> Remove rotator block from probe, it is not used in any device tree file,
> there is no related cell defined, it's just dead non-working code with no
> of_compatible for it.
> 
> This is a preliminary change to allow probing by of_compatible and not
> by a fixed name.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - new patch
> ---
>  drivers/mfd/stmpe.c | 2 --
>  1 file changed, 2 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
