Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69E25436F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244250AbiFHPPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiFHPOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:14:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358B8A062
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:06:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a10so8521221wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LicVPwnZXPcISn2oDvw38YiCixBz7nAXnKboREn28oA=;
        b=I7m34TKJF2NVViuUzoxPzWj8ttUrTOIGWj2xW4XB3ylIEc1yrNODIeL1VOuF7iJ5FB
         ooSZMlyVOKvfizUy0PMH5xh9vogbKZuB49YOJjdSQDfttO8NEMmtoQ8n7LiLrTHTXvd3
         CXO3FFGAoydiI2ZoekMfsawXP61UBvWer9WUSGvxRqA2AQuzIV35RT2L6pXiF2cGbR02
         eSk1oTwEWrur/5qKg00r+NjTDMDsyqaqvepdhgUvTawtk3kanMGD6rp7nS6wdaiXLFAV
         Ti/P5WvQJBv1yjrPLxokBccZEq0b5GTRe96WFjkPNaoMLY1BpYfbFdzJQAIkzNQHe2mn
         0E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LicVPwnZXPcISn2oDvw38YiCixBz7nAXnKboREn28oA=;
        b=di9YMNTCnSDLWFWQTJuzZuPCNwUvRN1p6dBDfDF9YmBYe9r2Uywcyo/flA4UriUSsU
         nSUAkiX9QmT+dD9vM1HE7nvWpEAhwAhnW1CcbKEkHJAJRAiNSIlyJgjoIb79jf6KrTbp
         38fou46jBQV8eHYbkBCdEMqxXvKBSEmmNg1yPmibpmcJi7lJCjAOhxOk15vR+Kbl3TYp
         OqihoTMx7O4Nq2dilT9WQAWqz4uyUn8EhM6sFHEVRCUFa47fOJFCYUYwjqra7hthz+u7
         pjuEd8RYz3s5oIXGR9KgiKHOi+hK+WC7mQeiG4XKcBdUOcbOkTCEDoPrhqvX2wKnE1m2
         YAAg==
X-Gm-Message-State: AOAM530UBTJPM0StFnTXPzg36Kkiui9VzVmegEvae5exIwNzu3EsAEeJ
        EfKvJ15gAjIZGV+qK0x9hC0qgw==
X-Google-Smtp-Source: ABdhPJwrBsVQb8xDnZ+yujUU0xErzW+etDwKNXI8QuX1wGqVPGpSrbiuoNnXKmCtMaB74NmcqTq0xw==
X-Received: by 2002:a05:600c:590:b0:39c:5cd4:8623 with SMTP id o16-20020a05600c059000b0039c5cd48623mr7718911wmd.45.1654700766860;
        Wed, 08 Jun 2022 08:06:06 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b003942a244f2fsm29352020wms.8.2022.06.08.08.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:06:06 -0700 (PDT)
Date:   Wed, 8 Jun 2022 16:06:04 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] platform/x86: acer-wmi: Use backlight helper
Message-ID: <20220608150604.l7act7qvtbshnpux@maple.lan>
References: <20220607184635.1127913-1-steve@sk2.org>
 <20220607184635.1127913-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607184635.1127913-2-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 08:46:32PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: "Lee, Chun-Yi" <jlee@suse.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
