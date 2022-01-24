Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C571249A2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbiAXXyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1846354AbiAXXPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:15:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93E3C0617AA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:23:45 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u130so13021709pfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=8m79f2otdP4sUy8DiW1radE4Qj/qXh4y2lQHVAza9yI=;
        b=sih7hPju9ABEZNYBhTnxy45unuJ/ZOAC582tPjmciQxLCN0VMyKZXWNDnEEq+8VWr7
         5dtNv3VO4Y3h4E0AprPFp9nQ/vA/bu+eBF0eTTcx5EQSRZGp1mXX58F5DaiD2OmFgOhH
         0BXfpKvPJidJ9LzUJ9cn5aNY4Tt9DMBOLQVdhQqx3N9vjURqsQgV/fXHupDwpmdqA2Oy
         EgHSLDzj6K7PKllvCImLIeFlPa+6fJY+xt1ZNVN7/eO4yugG5HE+iTGtvqPOV24M1ZI6
         Ty38QTrnfg/d+PfdjgOVWYoUrt02kEFp/BmKLZQDLOxLpB7IR5eayH/QBU2pphC5eD/L
         4+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8m79f2otdP4sUy8DiW1radE4Qj/qXh4y2lQHVAza9yI=;
        b=modOXCqmmU56mBnWvo2EGe2488MKrH/quznvGmkSLpRygSjmrst1eS2PwbZFzPFZ6n
         KrJr5IM+0vnmRdoG9DqEF/px5C93DqFyK7RkqVx+EiltU3rC+z/M9uccDHxLc//vI7E4
         /3KtVDTgI2ZI4CfBDSykkmeDDFoIdpU4ca4OYoDTT4YdHnvd+XbKQQRnSBKelJEOZZaA
         th8InH0YG7YARYySwho7xck51rG8njOQVx9S/+yytRDUsmRdrPg7Pb7A0GBd1Tfqim1s
         hELwnKNT+Ysvd4aKAHWJxTjN1EseDfh6TcXV0OQQdei+br+EOhhmmbH0NpmJkOclhogq
         1GOA==
X-Gm-Message-State: AOAM530RowoiQ+Gd943wSqcqkM7G6OhsX67dvWqbQ7mo9cPyHBvFmt5i
        HjyXEPmDWNu4pE6O+bULlCRCrA==
X-Google-Smtp-Source: ABdhPJxjvhGAUnix+5NU/3eKGoKvDuexcD9BnCfy3nMUOCXhRGSchTB37sJvFq1jPipMWDt4dTsOMQ==
X-Received: by 2002:a63:f610:: with SMTP id m16mr13239259pgh.69.1643059425175;
        Mon, 24 Jan 2022 13:23:45 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o2sm12972691pga.57.2022.01.24.13.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 13:23:44 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben.tseng@mediatek.com, Matthias Kaehlcke <mka@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: Re: [PATCH v4 RESEND 0/2] Add a generic virtual thermal sensor
In-Reply-To: <CAJZ5v0gZFBEKDt6S0H91F5xCjC3qtT6B+cTnv6u1nijMHkc8jA@mail.gmail.com>
References: <20220111103346.2660639-1-abailon@baylibre.com>
 <7hilu9xe7n.fsf@baylibre.com>
 <CAJZ5v0gZFBEKDt6S0H91F5xCjC3qtT6B+cTnv6u1nijMHkc8jA@mail.gmail.com>
Date:   Mon, 24 Jan 2022 13:23:44 -0800
Message-ID: <7h35lcygin.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org> writes:

> On Mon, Jan 24, 2022 at 5:58 PM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Daniel, Amit,
>>
>> Alexandre Bailon <abailon@baylibre.com> writes:
>>
>> > This series add a virtual thermal sensor.
>> > It could be used to get a temperature using some thermal sensors.
>> > Currently, the supported operations are max, min and avg.
>> > The virtual sensor could be easily extended to support others operations.
>> >
>> > Changes in v2:
>> > - Fix some warnings / errors reported by kernel test robot
>> > - rename some struct and functions with a more accurate name
>> > - update the dt bindings: rename type attribute to aggregation-function
>> > - factorize a little bit the aggregation functions
>> > Changes in v3:
>> > - Aggregate thermal zone instead of thermal sensors
>> > - Use try_get_module / put_module to prevent thermal providers to be removed
>> > - Update the bindings, to be more accurate
>> > Changes in v4:
>> > - Fix two warnings reported by kernel test robot
>>
>> Any more feedback on this series?
>
> Hopefully, I'll get to it this week and I'll let you know.

Thanks Rafael,

Kevin
