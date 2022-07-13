Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C004A573E37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbiGMUwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiGMUwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:52:45 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A94A31386
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:52:44 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id s204so59497oif.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ykUFDJKpymYm5hCsAJ+Q7MiQQTFwssew2VYnA3ZdZY=;
        b=J+uEzqlW+auhEWVaicUqVAqenJlGy9Hwh6KlQHYrzJXEwp3+EeVIh50RVp8Gf39nyZ
         1l+WB4bASoxi8ehROmXeofZQXV431Vjr3skA0Z2eR5+TIpsMA0f7MVIXXER4iPSWaUDz
         0Km7HPD+6uEZz8Yb8BMBNXRojeH5Y91kjJwUbGc3uaqZZvBQFGCOroDbvXjEu9ogdsXX
         66VF/QPAKsmf+HuSsKvvSpcNbXJ9JKBvCGz47KGB2IGRF6aK/gT7iPC2PRBP/tQ5dx9f
         QHKoakGz3lUFO2R/hqZW7taIa9Tj8VVyR2vs+qwiGMrDbVJ/l23glyeac07VeW//ajuh
         t1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ykUFDJKpymYm5hCsAJ+Q7MiQQTFwssew2VYnA3ZdZY=;
        b=BXKj1P5FJGZPPHp/S292wwLLlcQ78YRkC/izxSG3t+o/yBl2wwPulkfzT/kb3v4aPY
         GiIFW1v4MZsw9wVF+HYtTF6X3D7gSR0Nc9DVKz2PNZWs6K4Yw6nss37Gg4j4TEKJPhNM
         2V/duVzPm94IXY2RV4WSsUjiVXjmhOjrmQaRYktC2fPh692Stayqm7rQX0TIC9aZ2TAI
         5A0czB91fOJmeq6N5l5BuKBXzbRz/H6G4VDiSyCszcWzGg7THZzqI295AuyctDDuxU7u
         DBizeu3/lQTNLpbdVMqHZf2Zscv4jaCIeGUr2498aIcv3YYx4FOHaCa6TaYd1+BChfEr
         DTrQ==
X-Gm-Message-State: AJIora+WzwqPqw7dBnRQbh0AsvzmkrtcyWZ3GT+pQn0o3ZknyWbSJ5ka
        +xRuOYwdUtCXchTmKWWQb7G/Ig==
X-Google-Smtp-Source: AGRyM1vxfSoqykkHIcVnF4vZoC0MDmVbJ629P8d8bFXmakWLTxeWAvfc6mFEXLsLmOn6YDCOYQi3JA==
X-Received: by 2002:a05:6808:144b:b0:337:aee7:b006 with SMTP id x11-20020a056808144b00b00337aee7b006mr2896659oiv.204.1657745563421;
        Wed, 13 Jul 2022 13:52:43 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d1-20020a0568301b6100b0061c4b17c0b7sm3980864ote.43.2022.07.13.13.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 13:52:42 -0700 (PDT)
Date:   Wed, 13 Jul 2022 15:52:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Joel Selvaraj <jo@jsfamily.in>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: sdm845-xiaomi-beryllium: rename
 beryllium.dts into beryllium-common.dtsi
Message-ID: <Ys8wmeMYnKFa9Iqv@builder.lan>
References: <20220708111207.85249-1-jo@jsfamily.in>
 <MN2PR02MB7024359650A02554EF6ABEA5D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR02MB7024359650A02554EF6ABEA5D9829@MN2PR02MB7024.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08 Jul 06:12 CDT 2022, Joel Selvaraj wrote:

> The existing beryllium dts file is converted into a common dtsi file
> which the tianma and ebbg variant will inherit.
> 

Applying this patch would cause the tree to fail to build until the last
patch is introduced. This would cause problems for people trying to use
git bisect to find regressions in the git history.

Could you please respin this patch such that it continues to build the
currently supported board and then you could add the new board/variant
in a separate commit.

Regards,
Bjorn

> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>  ...5-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename arch/arm64/boot/dts/qcom/{sdm845-xiaomi-beryllium.dts => sdm845-xiaomi-beryllium-common.dtsi} (100%)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> similarity index 100%
> rename from arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> rename to arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> -- 
> 2.36.1
> 
