Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BC256425C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGBTGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiGBTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:06:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA4E0A9;
        Sat,  2 Jul 2022 12:06:10 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z41so6745608ede.1;
        Sat, 02 Jul 2022 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0yu1El6vOD8A0gSx756Jt25HtpMxiSxwi6fNvLtoxg=;
        b=I4sXXmxDa/iZ225kkuLhwo9R+auGLloq99vC99wWuA7xov8rtKLRnD4nCrU8UbINB3
         6xypnAMT5Waiixv3xn8tW1xeyEQ3+ClVhd81CjOcKXGVDOeUkT13SqX3XM6EoCl4mZNF
         +gupnlPKVrv0MSsooUatuOJEyIqAypMd/4gRbTSOt3QzPcMyq7FsIVVW1SQM/uuDIXkZ
         gVa6joh8wIdt8MOBwVgeGryWLGywj8xdbq7UKuJjQGapV49d7kXlcme/mY3W+5Sygbsf
         ea11/cp1vHsccmOcFr8rrgx2yEulKEoC9ytXTXwOwDo4/zZTf5D1RGcoti6J8eK3cMXC
         v4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0yu1El6vOD8A0gSx756Jt25HtpMxiSxwi6fNvLtoxg=;
        b=fwRlD6I6AoT2eSzJHj+hkssMAQWFtLKwTMgQjzcb5me+TsWqyyjtJCw/X/rkuCnjeH
         UksA4Idikl1C0W06lJsJbpx9bZa8XcgxHKvjG0DxmncM8tygKheESK4Cd5lWkmnkpf/7
         cuMvsgQWjSHsySRK6LlpPZwC36NNr7S9zqaZG1GpiA3PjN+5sfnNwvoL7a6nd72tlMW6
         BBrj68Jy80iddWnUsGYxSKgkY3/+OHTaR1EAu5MEr/+RqZ/nMz2/C92BRZHgWbOlDWdX
         j3n7SRX/tva+3oqXAU355jbHoFcuDvrkWcId8nvr0ZIb2Kzj/6PUlBGEM2+e8ZqBEaQL
         HHtg==
X-Gm-Message-State: AJIora86g71g2nD1FLcelE7JzIsKVi72gyn5RThfmwNxSvkbGuSaLoJP
        HeL3C83DKmAgzIjGVT3Ifps=
X-Google-Smtp-Source: AGRyM1uMMhIQ4Yw/s8eXzx+VpJdxchNQa9w2WGeJr1Rl6GkGJCDIxVskSkBGawHb9dTWaD4Ev/CxTA==
X-Received: by 2002:a05:6402:1774:b0:435:7fea:8c02 with SMTP id da20-20020a056402177400b004357fea8c02mr27136096edb.213.1656788769330;
        Sat, 02 Jul 2022 12:06:09 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id c22-20020aa7c756000000b00439c146efc9sm1244786eds.60.2022.07.02.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:06:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: display: sun4i: Fix D1 pipeline count
Date:   Sat, 02 Jul 2022 21:06:07 +0200
Message-ID: <3674367.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20220702032921.22433-1-samuel@sholland.org>
References: <20220702032921.22433-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sobota, 02. julij 2022 ob 05:29:21 CEST je Samuel Holland napisal(a):
> When adding the bindings for the D1 display engine, I missed the
> condition for the number of pipelines. D1 has two mixers, so it
> will have two pipeline references.
> 
> Fixes: ae5a5d26c15c ("dt-bindings: display: Add D1 display engine
> compatibles") Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


