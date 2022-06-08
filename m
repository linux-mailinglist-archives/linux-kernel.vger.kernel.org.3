Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B42542934
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiFHIRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiFHIQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:16:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEBF375E6C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:45:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a15so18626659wrh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 00:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zYZCvqiqKCqFQS+nJc50gw1Yr4dIMS1wiDRUcaifO4U=;
        b=lxerdrTjKt/1dANFdp46KUeEyXSSVO931aOet5j37ol2P2qpD1l8n6DggHq/ukK8aP
         lGwvFwb+YvkpScBv1zN1WaxM0uVWerkoY6gGwCqSx9nbwA5hyXR9VmlidZcvxNAKCirG
         lWdKHh0A5YwNPMbuQJrX/HCY/sFMDpd89cLnDYuJChNHvaaSc/puSpLlHMw7Plzno/EZ
         wL6OQ1QT9EV1nM4tFDxLVkDEHpi7w4vvi/OVK8GMRPa34znyc8cz/APXBTn3k/78t/Qq
         cLbE1vcFB3p/LHHFk4u1UqnFnruE8+biFbGknhPzV4lWF/UsYLG9XjWtWC+xQ1PrH2sU
         n62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zYZCvqiqKCqFQS+nJc50gw1Yr4dIMS1wiDRUcaifO4U=;
        b=vY6PNtpXS5hRtXw8a4W3TMf7Mm11NsepZVXGXmxdRr+5kQUIP7AV1tFthYhWA5+T0T
         Z2ycUHwXiqsEL0rDGlXD4tFaKDrdLem1myzNTg0K655ORM7K7YWN0ozCCXUxmc+7gOS0
         n2dLwiqW2qdmC5z/60ZD9zZJZR7/nCbcSgmIoqZCvEvk0B6c+TvQWmo01oP5h3fayDmV
         ZmRjuxUWsvlnu6dK4CXCNrm8lRvoo2kWvaidUpM+58s6tlxz3qiTBfisbgVJbDb368qi
         J0V5kEc6sJQl6N1/B9Qias8VHezIRJN4k5uAi47N+l8C8+SOIvF9RZyxQlLy+oPt/ZwI
         097Q==
X-Gm-Message-State: AOAM5323bWMM8oyMu4nVQJeSYSEVE1+Kx9jTz+yXR0m544Wa8hOpI3Xf
        On5NH18dYukzHT7nVgGGgfvwtQ==
X-Google-Smtp-Source: ABdhPJx10VG5yfJ8YtyMSlLzo2jugqwB+3S3m3Sc7F/H+uFDruVt/Zz1xRSkROig33/nIadSYml8qA==
X-Received: by 2002:a5d:6d8b:0:b0:218:4dc8:293e with SMTP id l11-20020a5d6d8b000000b002184dc8293emr8605935wrs.612.1654674301224;
        Wed, 08 Jun 2022 00:45:01 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b0039c64d0c4e8sm630005wms.45.2022.06.08.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 00:45:00 -0700 (PDT)
Date:   Wed, 8 Jun 2022 08:44:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH 2/3] platform/chrome: cros_ec_proto: Rename
 cros_ec_command function
Message-ID: <YqBTeogFDW1tqfZp@google.com>
References: <20220606201825.763788-1-pmalani@chromium.org>
 <20220606201825.763788-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220606201825.763788-3-pmalani@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jun 2022, Prashant Malani wrote:

> cros_ec_command() is the name of a function as well as a struct, as such
> it can confuse indexing tools (like ctags). Avoid this by renaming it to
> cros_ec_cmd(). Update all the callsites to use the new name.
> 
> This patch is a find-and-replace, so should not introduce any functional
> changes.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c                   |  4 +--

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/platform/chrome/cros_ec_proto.c     | 22 ++++++------
>  drivers/platform/chrome/cros_ec_typec.c     | 39 ++++++++++-----------
>  drivers/platform/chrome/cros_usbpd_notify.c |  4 +--
>  drivers/regulator/cros-ec-regulator.c       | 24 ++++++-------
>  include/linux/platform_data/cros_ec_proto.h |  2 +-
>  6 files changed, 47 insertions(+), 48 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
