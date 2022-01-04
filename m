Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1179C483BD0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiADGEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiADGEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:04:32 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5700CC061761;
        Mon,  3 Jan 2022 22:04:32 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s1so30328022pga.5;
        Mon, 03 Jan 2022 22:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DKw/IAK5THDPWlkH1ztOYcj33QLJ56CbVxqT4YIX96w=;
        b=KYJe7ngf9iWAOKhyp5tCUigi9GiFs7LNYI7KqG95CNk8qBGvl5HoAlT6vcPWZLlkq3
         o6CGqnNMXk/HuV+TCZNOzzmBkWrcdh7TcqmCwvLYln0bKkkREa9hDUKq6L6rT2ayHktH
         /syNib+E7xfva9bOOI3sSM5C4MeEM+2XsNGQ1Cs+wcl6tu9jeRaFpCOnG2eRBJsCvza/
         lder25O2K/XA104fIqFWua6ifha8vz3qFdN3DNzFtaJm1Wum49qxbyzpVk2dRWZs1JBN
         DLwrkedjL4GP34KnlhBJLuhSfLpVTD6gUuu4DyPjhwmhpuUn7W04ltq9qzHxWIfOdHKj
         sNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DKw/IAK5THDPWlkH1ztOYcj33QLJ56CbVxqT4YIX96w=;
        b=JXq2VH9yOQXeuoYcYYY/vcoJRImOrwBb/TZxLGsBLazIulxrq96YBA49H/q0f867NE
         VWmAdT1WFrijn7VnTVMvMDHAMJ6A/41FdgE0kEHMg02cl3jUNWWOdwqzxa3SOKNiqHAX
         hbzTPQWV1281Zbk+hOKOdPoJtMh1evtQ8ctaJiSJOYByXqX8je4f2rqg/yDd/Wg1BoPD
         kcU8HKlkOw7DM5U3dAKVvhhEP0LDIhPg+UBDbvvG9Yez0vkkZDnY3AgDCDQpvzNBUGvV
         Gkkn8FjeKy9Pxtd85VMH58zrIk+u0eEDcyyvD9CnIS1VA4yiEvdXTJTR/0akGKX/FpDQ
         DA4g==
X-Gm-Message-State: AOAM530OYiZId4lXksZaJQvKtBl/32LV6Cz/sUXxgOsnW0i4c3Tu3jWs
        x9CKVc2GeCQSZr/+o6RhCZfEn0PX1CM=
X-Google-Smtp-Source: ABdhPJyDo/n5w4VuuoZCxDnPzCYvNggjliTiX+2V3AsWopsWgVedaKy0VGHz2QPnumO4fksx5eCxHw==
X-Received: by 2002:a05:6a00:2349:b0:4ba:98c6:48f6 with SMTP id j9-20020a056a00234900b004ba98c648f6mr49726664pfj.42.1641276271755;
        Mon, 03 Jan 2022 22:04:31 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a7d6:43d7:bbe3:3573])
        by smtp.gmail.com with ESMTPSA id h5sm34246481pjc.27.2022.01.03.22.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 22:04:30 -0800 (PST)
Date:   Mon, 3 Jan 2022 22:04:28 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ahci: AMD A85 FCH (Hudson D4): Skip 200 ms
 debounce delay in `sata_link_resume()`
Message-ID: <YdPjbGXwa/YEd38G@google.com>
References: <20211229161119.1006-1-pmenzel@molgen.mpg.de>
 <20211229161119.1006-3-pmenzel@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229161119.1006-3-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Dec 29, 2021 at 05:11:18PM +0100, Paul Menzel wrote:
> 
> Add the two Chromium OS developers Dmitry and Guenter to Cc, as to my
> knowledge Chromium/Chrome OS also tries to boot very fast, and the Chromium
> project has some CI infrastructure.

I am not sure if we can be of use here as Chrome OS devices are using
either eMMC or NVME for storage. I do not recall devices using AHCI,
maybe some very old ones way past EOL.

Thanks.

-- 
Dmitry
