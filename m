Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B958CC01
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiHHQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiHHQSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:18:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB86E2F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:18:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j7so11490548wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NyKsM3P78cM3a/Ci14kwoVmqxTONI9UjrHj67c2mb4k=;
        b=lZ9UciJBJaUqdPItG1yRpUH8RRkfd0EJdkvwugIpp7w+/nc5g2cRDkkfA/dEWMuILb
         8us7wetZvFq78IvkmEsXu9uNhLLP8INQLUCii58t2Nj5bt31+zi1qj33ZmkNtfTpfKXM
         U2U2Maew2NOYyV4EKg7HxCDaozevuKUn8ztu1lJ6EKFOGSzJtn+YMY1qG3usgK//Npjc
         A2AupFzoH1oJDQvtREXayURDvVkObvpdLfoqmjmc0RDdCSMnX4zde3i4LHzR0TPp9Cia
         wpfLur8Dawvwkt0EqO/zH6rzr3Pg3f/L0U26sWfrxkq8TQLaSARsX/D2CbIipSwXwDsq
         bpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NyKsM3P78cM3a/Ci14kwoVmqxTONI9UjrHj67c2mb4k=;
        b=i6CWNXmbGMcgRQt2Kmq7pXuAoGJx7vOlPQXNMmqZrx4ftwztU0R9x8HOs7FDzDww29
         D5Ux4ea5cc2piA/SJ7nTfS87XzwT6wxtuldp6MBClH3WA07gGS8xo1qF0cjlCThdA1TK
         LIP1nXePE1I8lyA7mxch9I4Cgi8sJ3FjNiY0F1zEwyn7EWUkweaerqgxc/DClHESGDXY
         xUffZNr+L4S/bExM4PTCuTyPiqDaXUMdFWk62JBDDhexIIvgK8RCJBic/21llPzwcHCJ
         NV9+qJOvZkCoSS9uswK51D1cMuRcrODZk4arluE8Iu3tGpTUIHXGxZgHDodU8mQoffxL
         dnpw==
X-Gm-Message-State: ACgBeo146BfleDyqNzrSnDU3t8ZVqHRqD9ZsJynkQhxTtp9SIsmvS2ok
        YU6uIPvUT/h0xUiDznaM9jGAZtIZ+6fqmw==
X-Google-Smtp-Source: AA6agR69CuKhImhsr25ChVcojbEMAIGmH/yx2fztaJxA100bcAK8vRgtHtjZkH9FnxPlpC8TA73tRQ==
X-Received: by 2002:a5d:4345:0:b0:21a:3b82:ad57 with SMTP id u5-20020a5d4345000000b0021a3b82ad57mr12092139wrr.176.1659975488355;
        Mon, 08 Aug 2022 09:18:08 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b002217339ce90sm9250510wrx.8.2022.08.08.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:18:07 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:18:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 09/10] mfd: intel_soc_pmic_crc: Replace intel_soc_pmic
 with crystal_cove
Message-ID: <YvE3PmND8em3YwkP@google.com>
References: <20220801114211.36267-1-andriy.shevchenko@linux.intel.com>
 <20220801114211.36267-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801114211.36267-9-andriy.shevchenko@linux.intel.com>
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

> To reflect the point that this driver is only for one type of the PMICs,
> replace intel_soc_pmic with crystal_cove (avoid using crc for possible
> namespace collisions with CRC library APIs).
> 
> Note, also rename the driver name since we don't expect any user
> that enumerates by it, only ACPI known so far.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> v3: no changes
> v2: added tags and rebased on top of new patch 1
> 
>  drivers/mfd/intel_soc_pmic_crc.c | 42 ++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
DEPRECATED: Please use lee@kernel.org
