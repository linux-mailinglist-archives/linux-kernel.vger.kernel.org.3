Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74915481390
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhL2NdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhL2NdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:33:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C385C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:33:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id b73so13623719wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BKpElLwKNn8FnsVpdZIkqH4EbDV3rPO/O/5EGCSSxtg=;
        b=G+Z0zGrBu2DV6kfpcKKqbNfCLA0fixv0xdF/IksUEk9nksafn1aCo5n9/1aMY2+Ihk
         fPXkj/PewhLHlgoUbPMVf/srzSa3AqDKX9Ok9gwf2tqJfnx4V9cm0L/8MP5Xru3FQm2i
         xiUH0SNzT5wvgbohOSQGPxRCBXQamZ15kfqBuzg9vt3eKkIVZxuqo01HMT7nZ5lfeB87
         QMVWXNnENpLVliux22djHxBqFUk/QhgPbLkBO8FMexfiSuy7DZn40pK6FtSjDixKjvSr
         5KcRJJ3LfXpyp1NtNWwyFYLl41UFJzyahh76kFHdOJlDKfu6wfFpEoasDnWFXaL63NC/
         LBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BKpElLwKNn8FnsVpdZIkqH4EbDV3rPO/O/5EGCSSxtg=;
        b=qaSaZOYauKb0xrpkBj5iwvgIy20mPirZJIe8XtTjL81SsDMGKKakWAlHXB8KDt4q0A
         oE1KApjxdED39RThdb6BuczI/ooMjlh2RG5+ml0kg0C6pyvnf+31Tn7A7md/d6iomRFQ
         EU6WW0BSMmZYBfeeY3n2oJ3w+QAxP2dzC8HcyLkkY+Zuln7xda8RZowBvlUsK7cf/xxg
         rNj3x3eHpzmSm3CF6lQ1UvBLbC4MwzjcoH0DGRSFIBK3dFle5FuVv12YZyx4o7LtgzDM
         +owFWjXxGnV2AepTE3kIOz/G1Y94hVlzpDO0ZwpwkzPJPLY1Jlg176o2YgG38qUxlNn3
         as3A==
X-Gm-Message-State: AOAM532L1UvlCDKJ6osjwvHztf8t2XdBbKxkwcaptrCerV4ICuPL6lwJ
        ilcTBQPQJg96iLgYggqZ8BmQtw==
X-Google-Smtp-Source: ABdhPJyYhUHUhiiSFehhjmu9dbKkhuY1TfL5ESNm+Ysq5Tcv6QmDPbNEV+FCzbrkHz7gpVF3XBcPgw==
X-Received: by 2002:a7b:c00d:: with SMTP id c13mr9743239wmb.99.1640784788889;
        Wed, 29 Dec 2021 05:33:08 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id k7sm20916996wrg.105.2021.12.29.05.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 05:33:08 -0800 (PST)
Date:   Wed, 29 Dec 2021 13:33:06 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, Tsuchiya Yuto <kitakar@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH resend 1/1] mfd: intel_soc_pmic: Use CPU-id check instead
 of _HRV check to differentiate variants
Message-ID: <YcxjkhEN0BiicJsv@google.com>
References: <20211206174806.197772-1-hdegoede@redhat.com>
 <20211206174806.197772-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206174806.197772-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021, Hans de Goede wrote:

> The Intel Crystal Cove PMIC has 2 different variants, one for use with
> Bay Trail (BYT) SoCs and one for use with Cherry Trail (CHT) SoCs.
> 
> So far we have been using an ACPI _HRV check to differentiate between
> the 2, but at least on the Microsoft Surface 3, which is a CHT device,
> the wrong _HRV value is reported by ACPI.
> 
> So instead switch to a CPU-ID check which avoids us relying on the
> possibly wrong ACPI _HRV value.
> 
> Reported-by: Tsuchiya Yuto <kitakar@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I switched these around (same with the other patches).

> ---
>  drivers/mfd/intel_soc_pmic_core.c | 28 +++-------------------------
>  1 file changed, 3 insertions(+), 25 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
