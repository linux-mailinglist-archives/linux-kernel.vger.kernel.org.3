Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC4487B5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348568AbiAGR0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiAGR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:26:09 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8433FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 09:26:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso5824742wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ht1OfskK18Tncu8hyQlhD7qZAAQL5kUIMY/RPcI5GWg=;
        b=ovBuHMMnaNmXki6e8ZuoIbwSgvKSbD1rksXRBmgyYUmyP/xeQbqX4CMXw2qDxMN1Vj
         v7Bki5RCHpIU0e56V7Y7EQ3kE2ZXPFmptqvRvDxQZ7chM4UIxRpXdp4o+0LjlKd7pW8q
         cXEGNj0CLps7TCexKvhCcrnl6NC6GUvVbPn8655XITD+oVFX6A77Yf0ibTqVflUqhgVm
         PGjvs5ZFG+72tWQn2lyUd3vH8tp3g1Iw+bUZuz3gxylapUn9yZgbIyZOi1em49vjoi94
         cNXMt0hYVQD9rJAfir0whVAbi7g644rWd6NP5cRkYKgohSf4SMg+HMJ/SIjKzTUI7Shm
         kngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ht1OfskK18Tncu8hyQlhD7qZAAQL5kUIMY/RPcI5GWg=;
        b=KPx2AkIbWGIp8ecBWb7+Kuq/fRhfGLjrwvMAEAvQE5E+tTzDNWA4yAx111zlzsJpWL
         +ui4ZQ1pzVJoFbD98AmdXycTLO/6BE8vE2mk/0c5a86KyJuY+YQjCjF3+TMNxj7PkFMq
         YQydu4O8KIVc0C1X6iK/Tmj4JeKQdYvMFW92dHlJLnAuyh10xoynyRGBC8D8WjBkvFRb
         pSSnuDc3c20hVjKZAC9eLQ3RfgjYjE7pdAL2nEHkDA35Bdxaw9xfoQxDhcddWF7bfF85
         Alvb7oRY3eNGdR1khwwCtgyu/dC/fLPpSLjXR2VOjb1qvTTs4HRymW9mJnfiJ0Fn6Vs+
         hy7g==
X-Gm-Message-State: AOAM533B1h/H/52f/5sZNwqnBimTwWfBeBdyQVcVnM/cPkkbqBzv0r0j
        j4P40/SoxEPJHm5+8hzEQIw=
X-Google-Smtp-Source: ABdhPJxKyHsrAgQTVgZgLm+52z4ULS2Pqwjxj4lcuAMX76VGeJnjfcycUSa/PS919Hvdw9jf9FQEkg==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr10241280wmb.66.1641576368115;
        Fri, 07 Jan 2022 09:26:08 -0800 (PST)
Received: from elementary ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id s10sm8325202wmr.30.2022.01.07.09.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 09:26:07 -0800 (PST)
Date:   Fri, 7 Jan 2022 18:26:01 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     ville.syrjala@linux.intel.com, dmitry.baryshkov@linaro.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, marex@denx.de, stefan@agner.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, yannick.fertre@foss.st.com,
        philippe.cornu@foss.st.com, benjamin.gaignard@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 2/6] drm/plane: Fix typo in format_mod_supported
 documentation
Message-ID: <20220107172601.GA122757@elementary>
References: <20211226112503.31771-1-jose.exposito89@gmail.com>
 <20211226112503.31771-3-jose.exposito89@gmail.com>
 <3DdB6YPUQr4O063yNreefZcIm6p5Z6HORoVVbk5RTMmjz8qvnxMse42hLvfDmA323KG-TWLc_JUFZEEEIkoINXQuAzjLVe2jRRM01tQgYOU=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DdB6YPUQr4O063yNreefZcIm6p5Z6HORoVVbk5RTMmjz8qvnxMse42hLvfDmA323KG-TWLc_JUFZEEEIkoINXQuAzjLVe2jRRM01tQgYOU=@emersion.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Wed, Jan 05, 2022 at 11:54:43PM +0000, Simon Ser wrote:
> Pushed patches 1 & 2 to drm-misc-next. Thanks for your contribution!

Thanks a lot for the review and for applying the changes, appreciate it.

Is there something that needs to improve in the other 4 patches?
Or just waiting on maintainers input?

Thanks,
José Expósito
