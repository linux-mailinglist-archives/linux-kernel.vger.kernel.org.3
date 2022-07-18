Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D904578133
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiGRLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiGRLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:47:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2D522B08
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:47:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b11so20665700eju.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbiX+RFIAMeCqfDvuYNCSYIszG13Fk6KIejZi/pE9NM=;
        b=b9NB1aRGK1xMpEy0wYmuiYYeDHdN+OrzTAk3RkL13uzqg2ffPsIzplJiO43jzX3mxy
         aijDR9ab4xqx0jDQYYY3bG1/+S8m/zij3eFWfeLmTaj8aD3Aj7FzaksIHBJYKAXgFfxU
         L24GIh6F4PuHyy8R5ZXFqARNKhTSoTShS9+iwq4YX9E1QILuvGrPjDEUyVbsdIYw6JVj
         v2ROt5wP2qNmqQHUpcBOBqWr+q1guyee19liECetTmesReyn6Xf3ySsuGaIhGYR7M+o6
         KZ+8EkcngIHqXGnDtAEa1q/fn7tAbUZ8dFs2SqmbQK4ROKabsc7znlD0u95KcAlBbCQy
         k2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbiX+RFIAMeCqfDvuYNCSYIszG13Fk6KIejZi/pE9NM=;
        b=pr0KQ35ZV5ahcNk2VmlKsrnrv7+JVV6VwETgERxUJYYWkPJMsCywDNf0q/PA6yQXf4
         64asSM/GRjOzftPTV6vp0g0ourrl2N48sYNIzE2IlE+RE7A0iIS7i4Ja5Y/JyNeBF+2k
         mIHLHlJdoP9qQjGjf6pOmXQW7F3SSOZIZYU4YaZFOzlSxBenU1YroZwqAvTePHPja5Bf
         qPB3sQIS01pHGHEIP9/EQU5QUJK2BBcpe3a02Vu34Qvy2Spv1TEFkIuSqqGvBcgN4TwW
         brNDQgs5Efwa/Zy/ru7RDG2wWTDO4cKzkYIlh2OMp2UI1LvcIWAJWFcO1LGqv3B37OxT
         P1+A==
X-Gm-Message-State: AJIora9LqBwGH9BCB+1n5uoCynf8ixnaJN555Z2AX3bI1VAeNm+kNFS0
        9WXju68B3Css4+BDBI2nT4lPifUk36FRH4cF+kZjqA==
X-Google-Smtp-Source: AGRyM1sP3A16042BETbhyG23Pn8nBJ5zxFTLn76/uqVR71z4ePBJthKuWPXTwJngHsH5tiyWhlfMpwNlyHMcWNn5A8k=
X-Received: by 2002:a17:907:7f9e:b0:72e:d375:431 with SMTP id
 qk30-20020a1709077f9e00b0072ed3750431mr21578887ejc.580.1658144867776; Mon, 18
 Jul 2022 04:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220715024910.12578-1-allen.chen@ite.com.tw> <20220715024910.12578-2-allen.chen@ite.com.tw>
In-Reply-To: <20220715024910.12578-2-allen.chen@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 18 Jul 2022 13:47:36 +0200
Message-ID: <CAG3jFyv6_2OcLp2JyKkiEB0MddOS5Tk5Jm5=r7S5EqVyxGK3gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/bridge: it6505: Modified power sequence
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-Yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied series to drm-misc-next.
