Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F464C372C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiBXUzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234483AbiBXUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:54:56 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D11C9472
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:18 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id k2so4954313oia.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yuNRPfZ4wSXNWFo4eJjPd8/1lZiboAzYQHF2bGrwvk=;
        b=v1lToXbj6oZ1yX9wpwPl5hYdstrCcyekZCPmIEOlGppkubYZ6pJNuzpaFkf7bGP4Se
         BOJbrNy3BWI+s2+QR/gmTqGk+eDdELRHlq4z8WMk5EaVKMpNGONSux38H5N0dzs6z/2u
         rxdQ5G5zH9RCdv4USnV5CdtUZjD/A2AKGK3yGpzXb0bNEaugvhgupX9mV6O8pCkxc2IV
         YOarLdNp3J0mvPG+8K3uN7xNAH+/lFMH/CZMDBJaIvaiFExN0KH2Gf9dQfCLA8i1pP3E
         BoLb6j5UA/QQea21t7zIeIXiYLYu6S3CLhgHqm+uobeQgHBsziL+Nhhy/bkTPqhF1zfz
         KS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yuNRPfZ4wSXNWFo4eJjPd8/1lZiboAzYQHF2bGrwvk=;
        b=Yu39uB8pWFKDv0f78N5AgAvC4uWl2V+0xzeDeIkkvJfHXVApnAsuWi4uosT5l6CczR
         lUS9jFYUIVyV2CZiMf613nWY3dQj5MVDPAzujPz5HF9tQQ+O8q0nvGOQcI5PAtU7691G
         i8A9BJP6iumdCX0JAm1mN0s7XdpdhikFALBEZUxeu+FO8vE65l5IfjjJAmgOjeafGjBN
         O7DaKr1TlRqT4+UIjxTsLWzvFumre4v17UIB60E+9ekgWVwjhBDlMBw7G9UdDpZNZzv1
         2n5LyEjeWogfhG2TmPXmmw1V3tVbbQaXBIU2REqD511dRyQsHmOfg+YN8RY/6snw7TpO
         59Tw==
X-Gm-Message-State: AOAM532g79B5cU3hD6mAgcl+QDvUtgIfZvq8/98rVQH45Twjzqoa5BkT
        l/ztikHFW2RLtVcwp9ZXi5lbdA==
X-Google-Smtp-Source: ABdhPJxxjHsZdlkR1kwbPa4Qzyy0vNpFU3AB0yGjO2kGTUXG4HI3QT47u3CtJHIp3y7C0I3N9YK+gQ==
X-Received: by 2002:a05:6808:1718:b0:2d7:416e:d9d9 with SMTP id bc24-20020a056808171800b002d7416ed9d9mr1652260oib.76.1645736057319;
        Thu, 24 Feb 2022 12:54:17 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:16 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-usb@vger.kernel.org,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Maxime Ripard <maxime@cerno.tech>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-remoteproc@vger.kernel.org, phone-devel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: Re: (subset) [PATCH v2 00/10] Initial MSM8953 & Fairphone 3 support
Date:   Thu, 24 Feb 2022 14:54:03 -0600
Message-Id: <164573604162.1471031.13389413392112165052.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220220201909.445468-1-luca@z3ntu.xyz>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Feb 2022 21:18:53 +0100, Luca Weiss wrote:
> This series adds initial support for MSM8953 (and SDM632 which is based
> on MSM8953) and the Fairphone 3 smartphone.
> 
> Only relatively basic functionality is supported like storage, volume
> keys and USB.
> 
> There is currently close-to-mainline support for other components for
> this SoC including GPU, WiFi and audio, this series adds only basic
> support so that the other components can start getting upstreamed
> easier.
> 
> [...]

Applied, thanks!

[04/10] dt-bindings: arm: cpus: Add Kryo 250 CPUs
        commit: 08b25f7d99e15f2aa5f4cce3f13ad0c67a4c1e34
[06/10] arm64: dts: qcom: Add MSM8953 device tree
        commit: 9fb08c8019234a0759aab66914f01bc0971e4eed
[07/10] arm64: dts: qcom: Add PM8953 PMIC
        commit: 06ea71e42975cdd43cc1e2dacd3e56c8693ac733
[08/10] arm64: dts: qcom: Add SDM632 device tree
        commit: 24af02271ca7cf095186963002d1d98349d9e5e5
[09/10] dt-bindings: arm: qcom: Document sdm632 and fairphone,fp3 board
        commit: cb898d5e59b41a268dcf4dbef31d651c393dfbae
[10/10] arm64: dts: qcom: sdm632: Add device tree for Fairphone 3
        commit: 308b26cddb04afc7776de1cbbe07172eeccc7c98

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
