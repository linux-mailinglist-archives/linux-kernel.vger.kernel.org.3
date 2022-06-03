Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D282F53CC0E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245376AbiFCPL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245362AbiFCPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:11:52 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E211220
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:11:49 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id f13so7632809vsp.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRR3/ZPTVsG03kPxvHaCWj5GOU1Fozuljr/KxjIdd24=;
        b=RvB2Z7RxhhPnXx6cxqPf+5ToILBl1dmnnSMkH527a7AvoICiiK3yGW8rJlUAXElMtF
         odcWYwMywrpaROkPhfs+3fa39YFpPOISBqdq7dp8syv+gDfGk60i4/WIVVIcULQGrEUh
         qJ5YEbPabkqRpq3WMTljLMnruA9/2frjVJzQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRR3/ZPTVsG03kPxvHaCWj5GOU1Fozuljr/KxjIdd24=;
        b=r53otJMNFhOMH22k5XGxrTjGArqtRHuLP1TEEBH/pP903HEHr6Gvai3/gVQBeRKj0T
         KXkGOfk7lMMdi7n2acKzzAITn/P8gCvCtmmDfLiS1LgAZBTxTyG6a+O6GN+5Z/lQZ6ru
         mrZ+RoxydEMxDJyOssZdMG1oJ1LUKE4SuIlE2HbJqQmwWKTvrcVWwTCl86Kj8iuuKqbu
         zPlKoCJzF5qWv55eurYBazf9U3AGbA4i5UGxicsDDULpZ0TLgU2ivefE7JbxIfd0NGZU
         Kes807bf3Hp+O5GP7VzVrhGiqM/GPL/9cF2NI8nWdZsrQi72YaIF10IJ+nzFtE1Y0frY
         E0EQ==
X-Gm-Message-State: AOAM531oVU/dmEKb3LbjlO49jHH3hLcYIZxEbGwf5haO0f0N445No+56
        FO6bo7qoE5jxPHBVicjZmV3yBSgeR4tGEA==
X-Google-Smtp-Source: ABdhPJwt8VWb+D8sgEFgUXrG9sHlEmsJ7GihAbDOPl0chbV5SEBFKch6zbVzgGT4X02nKVJLRtj+eQ==
X-Received: by 2002:a67:b143:0:b0:337:8ce4:c2c3 with SMTP id z3-20020a67b143000000b003378ce4c2c3mr4391827vsl.53.1654269108388;
        Fri, 03 Jun 2022 08:11:48 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id o72-20020a1f414b000000b0035c4f114a52sm981407vka.7.2022.06.03.08.11.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 08:11:48 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id q1so2616132uao.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:11:47 -0700 (PDT)
X-Received: by 2002:ab0:3311:0:b0:369:1d82:99a5 with SMTP id
 r17-20020ab03311000000b003691d8299a5mr17684734uao.33.1654269106779; Fri, 03
 Jun 2022 08:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220228202532.869740-1-briannorris@chromium.org>
 <CA+ASDXNSThy7usMKkN22VBq2iyej7sCJ8CAmgnNvxDgZiMbukA@mail.gmail.com> <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com>
In-Reply-To: <CA+ASDXMW14GqJUAogQ0=dVdamhTTGDzcMRv-8Cx-TaXShHxj+A@mail.gmail.com>
From:   Sean Paul <seanpaul@chromium.org>
Date:   Fri, 3 Jun 2022 11:11:09 -0400
X-Gmail-Original-Message-ID: <CAOw6vb+myB0gB1kPvwuL+T1Ka10gDN5rGS2hW+UG+-+K2NGz_w@mail.gmail.com>
Message-ID: <CAOw6vb+myB0gB1kPvwuL+T1Ka10gDN5rGS2hW+UG+-+K2NGz_w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: analogix_dp: Self-refresh state
 machine fixes
To:     Brian Norris <briannorris@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Liu Ying <victor.liu@oss.nxp.com>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 5:51 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Thu, Mar 10, 2022 at 3:50 PM Brian Norris <briannorris@chromium.org> wrote:
> > On Mon, Feb 28, 2022 at 12:25 PM Brian Norris <briannorris@chromium.org> wrote:
>
> > Ping for review? Sean, perhaps? (You already reviewed this on the
> > Chromium tracker.)
>
> Ping

Apologies for the delay. Please in future ping on irc/chat if you're
waiting for review from me, my inbox is often neglected.

The set still looks good to me,

Reviewed-by: Sean Paul <seanpaul@chromium.org>


Sean
