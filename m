Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB43F58CBFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243969AbiHHQRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiHHQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:17:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC012760
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:17:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b6so5032682wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=J1rmlYwPgGl0Wd/FlWh1wxtr/+kzcjTP0pI0FIYafco=;
        b=Ydv9EOXqdzDATYsPOLwCQps90HKsDvtkrizq8+3p++17mQXe5KAmCkVUlD/QNmtsZp
         4jBtoC7G3DEf6hZ5DltwNbtRQXujKLfLmet7sZW5zeIml/wwZZ4nITiKDPc0VS4twrsN
         OvND6uICSH1mw+9TZkAAbjO8GAC/amaTPadHlU/N7BhWdVk2vlEcJTVL4UGnsFe4oXVa
         ceVno/PfjA3qXmrz3RpX0EnVago2Z+B48BxufStYn2gz6iULniRNqCm/lChjFV5nVINC
         iVe2M+KncgVLk3K3zdU/HKZzCh8Ir/wm0YTD39294SZcsk0JRgYE1SfD1YcSlZu/PA7J
         AUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=J1rmlYwPgGl0Wd/FlWh1wxtr/+kzcjTP0pI0FIYafco=;
        b=AyoQMOld/uVJWlLkObDmTFhVqWhSILwkssQOPQ6koItd4tcFWxg9k5ZtpgeAPz4ASJ
         4qwvu+oeSQagXI4qX2xHKqdfklT5qLt72ATCUjGJb6DMeVR0JS0qhzB4W9jPV30uENL7
         kgb6QYI9REKqE2RdkbNLRU3ys0KLkpLwzTIxb6I0rwRjk5wwopomNGPqHZ3NXYrle9bb
         Kch8nHRnFNM/Iw2YVgFzVxhKq8DWqOyf8XG/9qzDaNU5mwQFP2Zd+KiLFuq4iaK9TdVi
         n4Idznzz6PoN5aVS4QWU+fd3kPafZIxPQ+9vba8NwVxaLIgxJowiqCyb31EcBMagB8/K
         8mKg==
X-Gm-Message-State: ACgBeo2vmu4bJTq1WCw6yNELu5ZP4qDZfI3wSJpO82E9WnHeKvQLJcyG
        mCu9nxnhXVtoF/hFPimS4/5gcg==
X-Google-Smtp-Source: AA6agR46HjcogQLGtsya5wlVaozr2DmUAn0T/WaHYPVU1f3XLP+p6bV9qbUszG2TE6IuVhWZ9QeMNA==
X-Received: by 2002:a05:600c:4f49:b0:3a3:2717:27fc with SMTP id m9-20020a05600c4f4900b003a3271727fcmr18218382wmq.36.1659975461761;
        Mon, 08 Aug 2022 09:17:41 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c4e8600b003a37d8b864esm15541469wmq.30.2022.08.08.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:17:41 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:17:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 08/10] mfd: intel_soc_pmic_crc: Convert driver to use
 ->probe_new()
Message-ID: <YvE3I/DSoNuwXDoM@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801114211.36267-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Aug 2022, Andy Shevchenko wrote:

> Use the ->probe_new() callback.
> 
> The driver does not use const struct i2c_device_id * argument,
> so convert it to utilise the simplified I²C driver registration.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/intel_soc_pmic_crc.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
