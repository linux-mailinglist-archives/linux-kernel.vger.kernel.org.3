Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BA575FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGOLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 07:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGOLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 07:08:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C8868BF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:08:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r2so5256367wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OmAVkQqBTTkr9luYSoZNqmHxg6zKrdYzcTAh39XB80E=;
        b=WHo2FU3vtMGV3aElDTXi+mGo+/8MM2a56xn0TGixZDPayyPzlYagMDJb7abO5NWLzp
         V6QBe6cHD2iC/JjNFxLPxxOkhjL2OX/IQxZ9AxnfnJ2g07EfV1gs1EbdNy/qtP7P/2iQ
         Fze5KHOR30JKo0qsuODX1AcxJOdEZhyqW4oE0BMVyiOfKB52QWepFHScSFaY8BWFlIsZ
         YlSE3dUxuRILm9qIcuyDMx6m3f2l15QkleH49hBbN5FUtnO6/rYYj1LikLf/fUWV4as4
         ctMSdWmGHme0FScQiEXP8K97X/D6Ru8dB84i8MuyaqKCuSuKuUqG7pBlCOVwR9dMXeOZ
         LYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmAVkQqBTTkr9luYSoZNqmHxg6zKrdYzcTAh39XB80E=;
        b=TX41jh9Spcn7oYdrIhgcBt2yQIVFqP5fBF77TiS9CXpXAIGsYQR3rDuwbRua2gSU24
         /6NZ12RRV25Jw6/MphSbNd+eC5sTvbmt28/OHbQqFAkdCYE2TCDf0NS7EtcPyPQhdfcT
         BP884PtplrmdHSk4WLprl/La+cHqgus7M4U9rK6hLa3qPlzxuqG2RZ3cRNXF+tFCjTdR
         JkVpEkVVyFnunzebSIfPpzrYMBRtyUlXqJbvvlZ17z+rMSkeVIBQorsmbtX9THhGBRI4
         91mY+jwo9hB+eTv2V31a2xzMkFHt/hox5eTLu7nzwtq56JLh2IDEzy1IDNbGanWwbgEs
         LDxg==
X-Gm-Message-State: AJIora+EX4QkDbOeq0yis7ogxkaF7BlXsZ6YEG6Obn2nozVFSgGP7FB8
        Fei3XYF42EHj8WTLAIlobv6sWg==
X-Google-Smtp-Source: AGRyM1sEjpj7feotX5UfZAdeUwTZLkodeYC6VvTR5tSQyXV/Uekt9N0ER1lQi7rDu073X4wM9rjEKg==
X-Received: by 2002:a5d:59ac:0:b0:21d:944a:8a0e with SMTP id p12-20020a5d59ac000000b0021d944a8a0emr12137645wrr.61.1657883300766;
        Fri, 15 Jul 2022 04:08:20 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m18-20020a5d56d2000000b0021a34023ca3sm3521355wrw.62.2022.07.15.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 04:08:20 -0700 (PDT)
Date:   Fri, 15 Jul 2022 12:08:18 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee@kernel.org>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/8] dt-bindings: backlight: Update Lee Jones' email
 address
Message-ID: <20220715110818.2hxept5xuaxkpcvw@maple.lan>
References: <20220714112533.539910-1-lee@kernel.org>
 <20220714112533.539910-7-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714112533.539910-7-lee@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 12:25:31PM +0100, Lee Jones wrote:
> Going forward, I'll be using my kernel.org for upstream work.
>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-leds@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Lee Jones <lee@kernel.org>


Daniel.
