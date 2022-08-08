Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E09D58CB2A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbiHHPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242910AbiHHPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:18:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B7DF39
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:18:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l22so11280590wrz.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GTevZuUiejguEpsgUOnmB47QMW/b8J20g/JC/eJOuvE=;
        b=Ha9+Yq3Ro24vG0M22gEXTKdT+8MKXJUxoz46rajkJVOlPIgQjDAhrEqSP0rt1hRqBQ
         rLVFkIYUFPRNSGpprIMx7NxSf0PqwhHklzuL/K6JV0gNP3EzNNV+uCxHLiVQed6sNArJ
         oHjzPhQHopsgqpBTU3H/IzuQJd0BH9Ahs9Xugqy0LwNkbjSRLno0aviXtFOqvIExRKwE
         Aqq1CPWRhKj0Pp9UmI+uZgmXU74GCVM5gZSh1mxg+t+9C3nfwEjHrZqpPuNrHKuNX5/0
         n/V7ohbx50K9gIxZ6IhddIlYqq1dJniWaNiQ1UvXtLMtpW0uW5KqwTEbS0lWp+tp1jJ/
         Vsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GTevZuUiejguEpsgUOnmB47QMW/b8J20g/JC/eJOuvE=;
        b=KffpXOhUZ5wUCUv+D+y9aBGFh1xIJuw36cCGJ+OKWLSELkqvqoYVLyXweeM15v139Q
         Kvj+w/xLnNp+obDqmeejbvc1Hg+fwv+IMTwt6lclcrnxYuSY01xNObWxvsRgrQMay+Jk
         XNqaPjlI0/vjYHGguewcSnTsmVl0DmtIYEHt6AR88yn+ZNpnIg3qV3j92GmQ1tTwakEx
         ucvG8DuzXZ+/t3mOWOh1+05xfse2gZcx/V0PzZipjsOQO+/VOLA05joWg5wyCD6o46+T
         9TIpAlX4sGYCLdLF0XEzQoQdqUdQYLnLoLtFmLuD2eovQ7pfS/HWznQ9D8ZW2XPaDqNd
         DOFA==
X-Gm-Message-State: ACgBeo0RNMkkqHgduS70jOP/4qPz8Y95B/Jm4NlcMMfRc7sxjvOeGUVl
        PeQcwjvKYpluMBz7ArwBpyYCUg==
X-Google-Smtp-Source: AA6agR6WY56OsLXZMVeNwAo7AIto/ZApH3k/yLb84Q9i7K35DrTs2jRfcVRioZF3DT8sVmQIlOtQ1A==
X-Received: by 2002:adf:d238:0:b0:21e:c972:7505 with SMTP id k24-20020adfd238000000b0021ec9727505mr12096009wrh.536.1659971892232;
        Mon, 08 Aug 2022 08:18:12 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n17-20020a7bc5d1000000b003a52969e89csm8572995wmk.4.2022.08.08.08.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 08:18:11 -0700 (PDT)
Date:   Mon, 8 Aug 2022 16:18:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: stmpe: Probe sub-function by compatible
Message-ID: <YvEpMVmv7UQiEnAj@google.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-3-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712163345.445811-3-francesco.dolcini@toradex.com>
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

> Use sub-function of_compatible during probe, instead of using the node
> name. The code should not rely on the node names during probe, in
> addition to that the previously hard-coded node names are not compliant
> to the latest naming convention (they are not generic and they use
> underscores), and it was broken by mistake already once [1].
> 
> [1] commit 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
> 
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - remove define usage for compatible strings
>  - moved rotator removal from probe to a separate patch
> ---
>  drivers/mfd/stmpe.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
