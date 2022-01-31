Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA84A45CE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376865AbiAaLqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378596AbiAaLe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:34:27 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E5C07979B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:23:34 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id r65so39232765ybc.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 03:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mfeb88SgNAu3DA1TovWLpJ9GU00PuBZKgL/FgGbBmOk=;
        b=WEK5URMbKWCEr+E+XSH0mpKLZ+NhV27Btn5eGtzM0qtsPnwScOdv3xZzIPTCqgEXkd
         5IrPm6HUBpHLkaMBntp2Q90o723ZIyceD03Py/EOAGUwggrikLy2WBW30V/1gqVEqzte
         m//HNeElTBBpiQnu7E14yOvYxlyN1fE2Umbli6ezeZOqMehNSiKEUDTKkUDJhSf654gb
         yZQ6W8qJbKO4paW+GirnnW2dtgHJ5YhbjinKCcaeqI/dBy8gAzoC5GPbEmHFG6nOPq9P
         w72bIYMVbxwxPaXynRmRE65tDAgfs4MUNpWyexop42dJE7znS/t6pADy+cffZbrcgrOS
         fmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mfeb88SgNAu3DA1TovWLpJ9GU00PuBZKgL/FgGbBmOk=;
        b=7+XRInUsVk/wRk49GfOonUy9Wld+WzCJ9aISwWlfqdq4VZpXNo/MtVg+S3A3TKm/4F
         lH7Xj84yrCrhMjruKw3SfodxRDh/nlj6MP8o+rlBcGS/Fsuc4JK+wsvCcGospLBzGq5d
         59yqvYkKE38lTJWqgPW9MJB5gcFmCl3nJl1/+aFhN7Dl/0C6UFDEOIR15C1AHs8hcE66
         DRqq5TAngSdQgTibAfh1L8n2xRkncR19gSezMqegGV4gIw75NtmtHKb0pnyDJe7GQjiP
         B6q3MAvGMhkgIrj5wRl7ahpeUIAsKcuS6Es04Cv2SBnRArZAhqVmYqavmih8wbFgDtMY
         SeJA==
X-Gm-Message-State: AOAM532rHzo0lrqoZN3E9bt0dSw9oDaxWtPubqb1PfUY/lCDDeZHWl6/
        GBZXPJ+IePfuskVm0am7QcMjphoBEKOAVj0vptKylQ==
X-Google-Smtp-Source: ABdhPJyJF4KcmkIVlYy6MWPxlek8Lb/gigZvypCrGUGQiwZhktVI00QkPs/ebeWHJlJba0FitxHDSwERyWccpovX9XQ=
X-Received: by 2002:a25:cfc6:: with SMTP id f189mr27662344ybg.322.1643628213945;
 Mon, 31 Jan 2022 03:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20220130034441.15474-1-samuel@sholland.org> <20220130034441.15474-4-samuel@sholland.org>
 <20220130141048.31be2554@jic23-huawei>
In-Reply-To: <20220130141048.31be2554@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 31 Jan 2022 12:23:22 +0100
Message-ID: <CACRpkdb407XmMGSM+7okOx50ZNTK3UuHWSFSH+CZ_2bQS0NJ=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: accel: st_accel: Add support for Silan SC7A20
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 3:04 PM Jonathan Cameron <jic23@kernel.org> wrote:

> This is nasty as 0x11 is a valid who am I for an LIS3DHH which is a very
> different device.

The WAI value is just a second line check anyway, the device is probed
from the compatible, this is just checked to make sure the device is
what it says it is. Annoying, but it will do the job.

> It's worth noting that a good part of the maintenance of this driver is
> done by ST employees who are probably less than happy with seeing
> a clone (with bugs) supported.  So support is likely to be somewhat best
> effort / not going to deliberately break support for this part but no
> means to test it. Hopefully we'll remember to cc you to test anything new added to
> the driver.  Clones aren't always perfect!

Linux began with people running it on IBM PC clones... ;)

I would assume good faith, especially with the silicon shortage
plaguing us it is
perfectly possible that this is a fully licensed copy. I think the two
derivatives of the AK8974 magnetometer for example are
legally transferred IP, we just don't know the details behind the curtain.

Yours,
Linus Walleij
