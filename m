Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D53454F217
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380670AbiFQHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380664AbiFQHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:41:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE1674E4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:41:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n20so400392ejz.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dc2j1luI+EEQwcvKzKkmXk1y8TKcznI85/RCQdiwek4=;
        b=AM/yF0SZhFhe55ijKRIPEIzK82JvEg4EsliZNev3dp4Y2MYPYIL8eHaPP9vX5+Kccy
         g3/22TU1s3pY1WvHbHMo1mKH7ST46k0DpinPx807RWI7hgHlcmXPh25xMP+bSOZn8xXv
         QTukUL31guc9BU/Br5f47zlC4aREXLm5Iv2ZV0Mxr9T2Tq3L19pR//nyU+BGZ8qDXrwB
         HnZz/hHd5hJsY3t07Jl4Bt7ASyVIHxkpnfODuYtp6DTRX/INpv82ADCrA3AD2yOA4p1A
         4xlS/xBL3Ekpo4TVaIoBz+7HtyvwXKHa9tBIxgiV6zLU6ki7GnK29EHh2LCEXFdcJeaZ
         uk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dc2j1luI+EEQwcvKzKkmXk1y8TKcznI85/RCQdiwek4=;
        b=p4CQ3QhXk5Ah8qnqjMM3dAT+J6o0d7yz1+2KUPWBrHCwlugp5IMRGYo8l6B4gTrKM/
         p0GhpTpdXR93go66KeAi7w/ugrZh64CZSg2QdVDitZC6Erekz8MRzfWoXQytg81+gfLn
         ZBlFcbWc6OgDxmXpdWeClynD8D9TZW2l/trZJgJ+jqUYtzn0QTWdwFMzFwX/pRNDYti9
         w02gug0Y3tvXVI+wrLiRdIte+VCh1iJDVJnQH+fbD6Lm9iw+ZesYofN1+ArpjXbp43Eq
         Kc2YbZ6NOkR6AKNHo3QUdT2FNDWR6Bm84x93yIHtcVnlFqgTuOSb8utkqrNFnnCAOFLN
         SeHg==
X-Gm-Message-State: AJIora/rbA5djBZu+pYUiH3Um1qaEcOETirQj34VM9I7FSuNF0HkDYak
        Isw0Je1CwZXEKBdv42Q13U3Y/g==
X-Google-Smtp-Source: AGRyM1tZAZXo7GTDpqoNLhUn3VHg4tdTj8OCZfC2+XhmSuSswWoZNuRm1fWjwzAIofShk9gkbUtGNg==
X-Received: by 2002:a17:906:7a5c:b0:712:38a6:9ac0 with SMTP id i28-20020a1709067a5c00b0071238a69ac0mr8133174ejo.713.1655451713318;
        Fri, 17 Jun 2022 00:41:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d227:8f3c:286a:d9d8])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7ca4c000000b0042e0385e724sm3212438edt.40.2022.06.17.00.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 00:41:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     martin.blumenstingl@googlemail.com, Liang He <windhl@126.com>,
        jbrunet@baylibre.com, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] soc: amlogic: Fix refcount leak in meson-secure-pwrc.c
Date:   Fri, 17 Jun 2022 09:41:50 +0200
Message-Id: <165545170511.1745152.4248111835075081590.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616144915.3988071-1-windhl@126.com>
References: <20220616144915.3988071-1-windhl@126.com>
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

On Thu, 16 Jun 2022 22:49:15 +0800, Liang He wrote:
> In meson_secure_pwrc_probe(), there is a refcount leak in one fail
> path.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.20/drivers)

[1/1] soc: amlogic: Fix refcount leak in meson-secure-pwrc.c
      https://git.kernel.org/amlogic/c/d18529a4c12f66d83daac78045ea54063bd43257

These changes has been applied on the intermediate git tree [1].

The v5.20/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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
