Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D59C48BCD0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 03:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbiALCBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 21:01:21 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:37886 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbiALCBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 21:01:19 -0500
Received: by mail-ot1-f43.google.com with SMTP id h20-20020a9d6f94000000b0059100e01744so936537otq.4;
        Tue, 11 Jan 2022 18:01:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qk2OQ/ws2ks++rPbFgmN3BZmamKFSn87De142ZHrSBo=;
        b=mm3IOCg7BE1RUDaNWUP5MzmaanQJ93Tk9NqNoF79W0OkrmDAbRazDW8ksYz+0gaN4/
         jZnN3Tx4Jvl2bbuuzkxb0dlNwRJcj12Xj989obAT5Hi37NrhH2URi9b9dBq3SNPHNppn
         TwsKlSPqlpgYj6k2vELHHp17qVDrUWW1+KxTtAsA3d4My7lm/28UBovoxyAR03t2IDdC
         j3DkH9w2mNRBfZ/N7WVp1AHvqoWE7lCotZEkecBfUlStnAT1l6YA7gQOVpO9QY0hTfBi
         leLilUA98KZiaqBNqZw1wKxw+htkbQQs6FFvXO07GRMSP7WPK6UiJxnltUUjE41nA94G
         KVWQ==
X-Gm-Message-State: AOAM531WJ4E9rX3uIb5rCud2gg9m0odCXy1J+otAb/fdvOeHDahk9tqE
        xxLMv/mURWcuiivhY2HP5A==
X-Google-Smtp-Source: ABdhPJzqarYaUXTAPE1/+tVVkQSjhrV2udoe9wYR0feu1OlMihqzlS2aPOfLf1LHnoecfVXpdiso7Q==
X-Received: by 2002:a05:6830:2705:: with SMTP id j5mr5399966otu.204.1641952879291;
        Tue, 11 Jan 2022 18:01:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u14sm2369656ote.62.2022.01.11.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 18:01:18 -0800 (PST)
Received: (nullmailer pid 3915021 invoked by uid 1000);
        Wed, 12 Jan 2022 02:01:17 -0000
Date:   Tue, 11 Jan 2022 20:01:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Lin Huang <hl@rock-chips.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 03/10] dt-bindings: devfreq: rk3399_dmc: Fix Hz units
Message-ID: <Yd42bfH5skA+TZup@robh.at.kernel.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
 <20220107155215.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107155215.3.I9341269171c114d0e04e41d48037fd32816e2d8c@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 15:53:13 -0800, Brian Norris wrote:
> The driver and all downstream device trees [1] are using Hz units, but
> the document claims MHz. DRAM frequency for these systems can't possibly
> exceed 2^32-1 Hz, so the choice of unit doesn't really matter than much.
> 
> Rather than add unnecessary risk in getting the units wrong, let's just
> go with the unofficial convention and make the docs match reality.
> 
> A sub-1MHz frequency is extremely unlikely, so include a minimum in the
> schema, to help catch anybody who might have believed this was MHz.
> 
> [1] And notably, also those trying to upstream them:
> https://lore.kernel.org/lkml/20210308233858.24741-3-daniel.lezcano@linaro.org/
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  .../bindings/devfreq/rk3399_dmc.yaml          | 24 +++++++++----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
