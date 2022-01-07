Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F7E487AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348346AbiAGQta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348332AbiAGQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:49:25 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 08:49:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id v11so5638376pfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZL1IIh8N/t+BHnGrZngRI4Wu6PnsS/ETq8DSWtn9LP4=;
        b=lDsXRzHX0unihRR38tpYXG3DBR5q6h2qwjl3lyjgNQJfWFRlIO/oVy35ifLLPTvBI7
         W4Tg5Esz1Nx5Z4HrkQ7wDiKw2HOG0SNYDJ4U3pNbtyEYAZyhZNvhZjq4hcJZRn9tbKB5
         9HRC1pgUllGCrOR1XHry7tj/NXmSn8GbnmsxQTuPTeT4FNAIUu37lBo8A9ueglsRZ/Nl
         03uCT1mQtpQ4/Du8E6umy/2IPKW+WCagwtD9ws4wHg+gPA8RN0nPdtCfn08bhenyCSfQ
         /e1+KymevWezVqY+KBCozHepPRhZyJPoSGCyIb3ZFFbZOdOwx3BQA4V7pAK4SkaVWAML
         U0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZL1IIh8N/t+BHnGrZngRI4Wu6PnsS/ETq8DSWtn9LP4=;
        b=P6lWOKZwbhtyK0ialXRCwBwA7Egvcgz0rNOiWr55yzfGX9InKdORL/N8QUDm3g/oVf
         gVt+YTFPxNoBTHT7TrIqJONHv8UbfdZ0nMlamdKYclr1y+P8dwlWXMlebPu4AspGbMqC
         RpWdnnHsamUp2Gqws19a8HsmMA94roOMj7U+K+Sy0qF11aBxjZg2hSXr31MdZHe8kt+s
         BbFOG+Bf08uLyveVOdNe/THCg3TzM7Sac2glrkghgrjlCk9Su02ceLg3Sm/gH/ebiJk6
         hX5sRPF3qqNW4BakUGLpkT8qMQG9EICnvIprxKP6p/VJhFNNdCE34RZ+JTTawQW9kiKD
         wIYA==
X-Gm-Message-State: AOAM533Rr7oCWChISvHfZW04YOfV0TMd6fePeMmCJlmWNmaUI0cPvgw3
        lnQ2X5oDbhPY23CPYGRLKD2hA2e1dUJGMarHwJGqIA==
X-Google-Smtp-Source: ABdhPJwKGOGLxY2N6H+C08ShsFe8lUGDHnLP2XOgjBuMBWnlTkNVzmG7RqGrOD4ylj9vZ/VhKTvpCxGk9u3qYdu2EQ4=
X-Received: by 2002:a63:414:: with SMTP id 20mr56480887pge.178.1641574164830;
 Fri, 07 Jan 2022 08:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20220106100127.1862702-1-xji@analogixsemi.com> <20220106100127.1862702-2-xji@analogixsemi.com>
In-Reply-To: <20220106100127.1862702-2-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 7 Jan 2022 17:49:13 +0100
Message-ID: <CAG3jFyvPD075x_N1V_S39NvMUUNkSbBUQrO65naGJG_kzniDwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: anx7625: add HDCP support
To:     Xin Ji <xji@analogixsemi.com>
Cc:     andrzej.hajda@intel.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, kernel test robot <lkp@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series and this patch looks good to me. I'll hold off a few days
before merging this in order to give Andrzej some time to have a
second look.
