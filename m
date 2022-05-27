Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14717535CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiE0JIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350672AbiE0JFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:05:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A986D1055F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:00:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so2283765wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgOndPAfyvmijpJMBj3VbzHjuhYijVFfIUTkT6Spj0I=;
        b=yq2L9Iov93prcrerNONY8meYTbFWpiD9fleBq4FXsdIRRV8zY6ph1xHdNY/dzwUrcH
         vvxyR7HN6/UlVUj1cLMIpxlGYFf4UiDun28TCZzbHE7fNGH0BeuIipqNGnKNpqiAj1Mj
         DBtUJc1PrpN+1hs6oQMc1WoWyoCsE+ZOzGDMWBsXA7EO223rkpH9kKWQIn7gsB3q5h2C
         lAvbqAyNeosmQHZ0E7+ipm13Rfd8quSni+xiz9546V4eiDxUdj10O08iBeIaw+KXjHbP
         MwqfUHMwlumF0Hq84IIh5K4nhvndxXbYTxhG7szKBIBD0U82R5tnmIMQ0FwwZhB5RAb0
         H08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgOndPAfyvmijpJMBj3VbzHjuhYijVFfIUTkT6Spj0I=;
        b=giuVIr/YAzIc5bJOaZUT3bQsb1YeLASCAWugaeoFlSr/RtrIv9HW52OuHKcBbYd8Ko
         Ue4KwxTH6KjRxcfa3l4xmouRgRXzRtcDz1pzmzgpZ2mxtqaKqOf5GDIYl6ItPyA+Nsbk
         kzWWWlSCIoAKyf8NIiqeaQXbkU7e4iTx1KKRohCcaDW8kA1/oQMSRSIy5Hu/Ev8soj0j
         7urRGE0EsaSdNy3WM3MnlEd1uB7Rw+k/sYayjC/RSPs9RrTrMoOoudvvMA6KxQCOOzO2
         ayGf1yQ9qmRJNW6abnMZi7OBpnsuIWIPec2NhHQHdUd9PXBvjh0IOoaP3sr4QnaO2jcY
         3tUQ==
X-Gm-Message-State: AOAM5300t093Kzj3Wg4eZjUPd2Ngk3qNPDVrKXOtSfPs3gi/sthaqLTl
        qz6CtvROHmZmyW2K27oYOTYJYA==
X-Google-Smtp-Source: ABdhPJzkbMuzL2NSPBI/c7uo7e2MnvfNayThyWCQt8pFuNppY95EZcMlvC/RzIZPXwXVBZa2UnWCTQ==
X-Received: by 2002:a05:600c:1e85:b0:397:6bcb:c52c with SMTP id be5-20020a05600c1e8500b003976bcbc52cmr6042990wmb.41.1653642031059;
        Fri, 27 May 2022 02:00:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f081:5ded:fc86:365d])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b0020feb9c44c2sm1347807wrs.20.2022.05.27.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:00:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        soc@kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Olof Johansson <olof@lixom.net>, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] arm64: dts: amlogic: adjust whitespace around '='
Date:   Fri, 27 May 2022 11:00:29 +0200
Message-Id: <165364202476.67525.12506050494553411270.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
References: <20220526204552.832961-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 May 2022 22:45:51 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.20/arm64)

[1/2] arm64: dts: amlogic: adjust whitespace around '='
      https://git.kernel.org/amlogic/c/7c928017461a740300ba0d74a5a4e7c09c8f75cd
[2/2] ARM: dts: meson: adjust whitespace around '='
      https://git.kernel.org/amlogic/c/5d08817f99847d0ccff65903a99794703de9ad46

These changes has been applied on the intermediate git tree [1].

The v5.20/arm64 branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
