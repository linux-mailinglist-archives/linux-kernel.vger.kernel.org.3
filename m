Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8C49D5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiAZXIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiAZXIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:08:16 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F9C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:08:16 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so899070plg.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LhmiCV1/nM9D4gpfyVW54b2aVU9iaxsA/jDSOqByd6c=;
        b=mF01vYXvOAIm8eYXKjcQ+xRocd5AaOMvSFzLDioyrOJ241l2bFLE4rW25ovbHQ98gF
         m/q1of8fUYjdZheDSJAIUXq+mKUlMYGdF4ZmpVaDg7QtAWTwOdfgiJOZQKIErZ1p/45n
         aCDqZGUPP3q/36Q2n1MMP6FbZOcGnbdhuXy+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LhmiCV1/nM9D4gpfyVW54b2aVU9iaxsA/jDSOqByd6c=;
        b=mCu8WeoXZnoVWSPq1SLCdF8Zp1ixo1lndz0KzUmedO6XjHgvKDGAwqd315UGEpRlOd
         92MzrVa2mQ3gtlT7SuE8Yhnq1dCE4jXeiLgFe4wYYyr5bJFDEyPMLoBWHt9d9yvtiSl+
         rEGEZR6frnXtsH4hBUI5eSYCxCR8GiNq1if1FbSHBONqm8FXgfdaP66okbTaP3VO6tzC
         YzSLSHWq8Yfp9OxhYlyATkgUOwOjEXb8zU8oYbuE19adFgkGm6Q7j8GmtRC8jx2/P/sD
         43hJFGtgvBh2ikcPmPfP9XMxgWyInriLBqxbbxfLiqKB+Cp430vTbmRtl2DeK+67qOJt
         mNhg==
X-Gm-Message-State: AOAM5326IieNxnXrM38DQutbzhxvkvRN/ONcTuV6lj/I9R62mgnwh37W
        aIc9EQb+yakTfAZ6vNOLkV08Bg==
X-Google-Smtp-Source: ABdhPJzs05hXyywazKC+HKYue2PywfenZJW+jT/k98U5hemfAiKCaoELDEqako88QP+FXfVJBffexA==
X-Received: by 2002:a17:902:dad2:: with SMTP id q18mr683229plx.172.1643238496133;
        Wed, 26 Jan 2022 15:08:16 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k13sm3505959pfc.176.2022.01.26.15.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:08:15 -0800 (PST)
Date:   Wed, 26 Jan 2022 23:08:14 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
Message-ID: <YfHUXtJPU77wtCPb@chromium.org>
References: <20220126190219.3095419-1-pmalani@chromium.org>
 <20220126230411.nn2illij4wbpdm4q@eve>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126230411.nn2illij4wbpdm4q@eve>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alyssa,

On Jan 26 23:04, Alyssa Ross wrote:
> On Wed, Jan 26, 2022 at 07:02:20PM +0000, Prashant Malani wrote:
> > The Type C ACPI device on older Chromebooks is not generated correctly
> > (since their EC firmware doesn't support the new commands required). In
> > such cases, the crafted ACPI device doesn't have an EC parent, and it is
> > therefore not useful (it shouldn't be generated in the first place since
> > the EC firmware doesn't support any of the Type C commands).
> >
> > To handle devices which use these older firmware revisions, check for
> > the parent EC device handle, and fail the probe if it's not found.
> >
> > Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
> > Reported-by: Alyssa Ross <hi@alyssa.is>
> > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> > Hi Alyssa, could you kindly test this with your existing setup? Thanks!
> 
> Hi Prashant, I'm happy to test, but I'm on vacation until the end of the
> week so probably won't get a chance before Monday.

No worries, whenever you get the chance is fine.

> 
> I'm guessing I should be testing with latest upstream coreboot (now that
> your fix there has been applied)?

You should use the coreboot with which you discovered the crash, so the
one which *doesn't* contain the fix.

Thanks again!

-Prashant
