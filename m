Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8164C8C19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbiCANAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiCANAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:00:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F414A3F3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:59:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o23so14326745pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=nuu3cVVJjajd7dp7VsroPAi7NZsR7bwDCDyyjbpRDDujUD45s9McptaCOOXoXmneOy
         zxJuahcoTO4drggn9XJcwzdzajMa+fdXw350MDNp6zxREw2Gep9TLUbSXsJ6IS7b6fsf
         FI0lXYNxy7SJzzoSf6jwmyNImco8IC5pHtjEiVlWfWeKVYAIPinUe6GksyW6ulKx4XIn
         AqMY6RblJl0ewm+R2OORH+kelTRfIMXF5lQglQZftDw403f17lw3aCqf2olgaSvzUmE7
         BpdYq4uNmdY7eHl5CQbdtm85vIXoRo7SrgJVAa4EkC4hV2DziPAAuDy16fEDb8RZsJ2R
         75DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=L/UU/KRWcx75D/UhTRFTTfwqJqaVdY1bDSXBHf8HnUW1gAivoVKHtJbtDo5DWpCzGB
         YYQxe5nkwraHlqsIT1i2UGsBW6Cq768LtLheChLR8acKfrBeOVgzFeqFsU5pFIl76CuN
         Phf9reR+Ayio/ety9ZW5Mf816pZVSSVaQXsLCrtOOK8vNf55amu0Zem1GciLJOrOw2+K
         n4w7KK5CPtddxgcG5UfZpqeEbu8C1wVc0KF6in9mBY+ex29AnAPpQievAchW4nMXlpMc
         1+wNYKVAa/oa6wEuvnP7iiXfHVqoQLE5JtJyjxAE7OiEchALXj1WxxLVe/0uGB5CcJCT
         BpjQ==
X-Gm-Message-State: AOAM531DM1YgV7/MjL6vhgFmcoFYNB795nxN7jhSrvMgXBEIU/OJDyRT
        dW23WDsKZ70zu5+0hMNO5BoaX4IFXGNW9cdXE84q+g==
X-Google-Smtp-Source: ABdhPJz5o1X8z2TsaSIkdJIabo/YlIe+WW8U2EEB3DJBD30mngq8YsXa53vGa9HF0FikZSi9S5b2T/g00LPwwDKYwhE=
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id
 q9-20020a056a00088900b004e0dcc35e06mr27183989pfj.29.1646139559900; Tue, 01
 Mar 2022 04:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20220228081421.1504213-1-hsinyi@chromium.org> <CAG3jFysyV8QHO4zEdUYLxt9eBnGsHWrXdWbicmufUPnTB-oRLA@mail.gmail.com>
In-Reply-To: <CAG3jFysyV8QHO4zEdUYLxt9eBnGsHWrXdWbicmufUPnTB-oRLA@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 1 Mar 2022 13:59:08 +0100
Message-ID: <CAG3jFytamPBHyBBFz7Z6Utfhe4tPh-jfH4hOVLK6GuJxacMmug@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Fix the read buffer array bound
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     David Airlie <airlied@linux.ie>,
        Allen Chen <allen.chen@ite.com.tw>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.
