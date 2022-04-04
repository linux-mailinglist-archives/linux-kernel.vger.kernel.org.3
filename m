Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF84F1D9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiDDVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379376AbiDDRD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:03:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225B840A25
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:02:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ot30so11354507ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDRai04CA05RswVKu5alUWJtGVzhDwT89lcIpEMtwKM=;
        b=YGjEVbKrxaCj2fiISbwvOvVSLZ42rj3jHDAPpX+ykNsk90fFh/VsuaFoFMNYtyxuzF
         nVi1FnYccUZfV3/L6BEPiJ0lmNO/JN8Kl/CXMB+yUcnqfXIsneiUpStjBd+YralAyO8R
         JLRIj8Rz1nEW9LenHRh9+U+poKxEmfIx3v0EhYx8lPOK7IVh+YyBW2M/utkM2TUi6YtW
         ecN1C1KwqD/KkxPnoqCS1NdxfskdpaEB08QOhOK7NFRh4ccuynpl9jFvSDFIFCiqBGEg
         hD9fv5XB7Jz+vbUMOAPD6yJO7KoPbmdn4G0J5eypih98p+tNOvZfhExy67YIyPuCt1Y7
         P6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDRai04CA05RswVKu5alUWJtGVzhDwT89lcIpEMtwKM=;
        b=aYkCxuf2IdRy6ayUdWC0mpswW58Bf7zYC6BIzRLMBVag0vOgJQXztHsKYLQ80JC7MT
         iZapY235dZLDziHswT1XdWX0YT5Jxyp44EBbmg7nmtePhITdS4AP3hsZAKzCWkKPtg/x
         l9XymfqhFtYPAXc/3jvwgZ+AKlC5/t7Ew3j2AZTXAU9ZxfUTsBJdEh7c5rOTyArwRHcP
         VFqaTAEZxahAnPitKjTPU6eizkZdajyFwrtb7AMdVb9wM+CCd7Cyy3F+0MZDzVLREdEZ
         s+GIpJM5C/9z3r82le5mmtJN14cpLhQJSQdOKe2gKQ4xDvPGgOuLKiqPf/x6MLP51Vb7
         f2lQ==
X-Gm-Message-State: AOAM533lxPzTMY1LmMWNmcepBfiW05YLBqCzJDatiZXpytJKGcIRo1el
        zHSv485DaNu5jN3TAqaJPY0seBDRldPTGmNu
X-Google-Smtp-Source: ABdhPJxjxE1555uF2gVoe5qYPFLZ+9GXlrvyiQUh8yEYi1nxgJCJ+oxDdo2NSpOk6a60bL6TomwbSQ==
X-Received: by 2002:a17:907:96a8:b0:6e7:c54e:66e4 with SMTP id hd40-20020a17090796a800b006e7c54e66e4mr1100334ejc.322.1649091717687;
        Mon, 04 Apr 2022 10:01:57 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm4557770ejz.57.2022.04.04.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:01:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: drop deprecated SFR region from MIPI phy
Date:   Mon,  4 Apr 2022 19:01:46 +0200
Message-Id: <164909169269.1688455.14606590160258224493.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220314184113.251013-1-krzysztof.kozlowski@canonical.com>
References: <20220314184113.251013-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 19:41:13 +0100, Krzysztof Kozlowski wrote:
> Commit e4b3d38088df ("phy: exynos-video-mipi: Fix regression by adding
> support for PMU regmap") deprecated the usage of unit address in MIPI
> phy node, in favor of a syscon phandle.  Deprecating was a correct
> approach because that unit address was actually coming from Power
> Management Unit SFR range so its usage here caused overlapped memory
> mapping.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: exynos: drop deprecated SFR region from MIPI phy
      commit: 04398e04173f1be0b21d7cd50c54e8affcebe106

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
