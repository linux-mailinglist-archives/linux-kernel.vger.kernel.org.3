Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C347543708
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiFHPPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbiFHPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:14:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54C12C94C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:06:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so13544076wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jATA95LsnhYFzxsaTpEfiLLPxPwn/THDoyk5wt0l0nI=;
        b=hbOY8G1cNdcNSM2rz9aqfN80nHdpQjF3stZaJaXKZ1lZ6OvH8TqhGf/WurVi4UR7My
         VVtmf2kO7y8EDorkGEycNEFb/gxL5p1HxdqniF/SCzMt3gGSzLbua7akAAkgGYPjo6RS
         Cp6Z4xJZMXZnN5UtvWBrqFrUqbgoCdjM6B3rhuQsRqbiQnP1UON3jfG+y54PDv3d/inF
         oJC+66zFO6/KhCZzWqtSm5CwwdguT2X2//ldNrfFB8QF9odQhhDBFMfjfo5tUqlJI4/4
         LrfM4vISzALHDnOqMxB1dLF4Iepfdrfzo4oT/FY0dRbeq2/JWHKoGWWS2CdUYldd7qdn
         ge1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jATA95LsnhYFzxsaTpEfiLLPxPwn/THDoyk5wt0l0nI=;
        b=Oc3r8Zo31WKszlZyge63ByWH/6bVYsp3cTEnCJB6WmCgu2K8b/eps3gEHuz6tv97v8
         z0vMlq8MLiO74rz1nz7JIdCTRL5HnnpWAoowL0P9HDooi7s3YHVAL3S1nmdzkZNlCydU
         Qoprkou6M3C2gnCZRZmqFnC4jScMeBlM207C/f28B/ilHqmWMu2KDw2n4ugup8MQLWZu
         GZUTt1JyaRIA5A9dxJmPiIJVC1raJs7cw7wjqXeH0nLQNQXwVBZxNy+md0H/uEP0mn+z
         P2mJ5EdHuY1JLDlVF9l3CNCPgTZkL6h+hLGVXD9hkIoKoPfUPRQAl7QBaC24l3Jlp0BT
         dADQ==
X-Gm-Message-State: AOAM531PnBh35DyNKb/FSzvHPX2RHRqDndIbic+HNhO/rfUDJresJgLQ
        u17lwX5/FUL7AUTPR5C51xSStEH9YKdmHjou
X-Google-Smtp-Source: ABdhPJzQqTXDqbgmmxZv/Q2GpTtx2kbX9ghYxOw2jBT+X54NeFZwyWg1HZJNdvhY5FiyH3VIHer5TA==
X-Received: by 2002:a05:600c:1f05:b0:39c:51c6:7c85 with SMTP id bd5-20020a05600c1f0500b0039c51c67c85mr16583501wmb.33.1654700812170;
        Wed, 08 Jun 2022 08:06:52 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b0039c5b9e9142sm5076671wma.17.2022.06.08.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:06:51 -0700 (PDT)
Date:   Wed, 8 Jun 2022 16:06:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] platform/x86: compal-laptop: Use backlight helper
Message-ID: <20220608150650.azsobwjurgf34jbm@maple.lan>
References: <20220607184635.1127913-1-steve@sk2.org>
 <20220607184635.1127913-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607184635.1127913-4-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:46:34PM +0200, Stephen Kitt wrote:
> Instead of manually checking the power state in struct
> backlight_properties, use backlight_is_blank().
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Cezary Jackiewicz <cezary.jackiewicz@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
