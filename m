Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F646CF50
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhLHIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhLHIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:47:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E0FC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:43:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u17so2753205wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=26sZG3HIo6IT2q4mq9Jr5Z7NwmOveaei3bWuwXv9MFs=;
        b=NIKcCoboastcACWdZi8LFsffMuyH86twlU4GhWo8sI8FkQT+kYQLLfTuE1EQX+3nhN
         URYBRYyA5cYfMFWKKlwhIH0PDgPcJQ4a4v6NWo/aHEqrGlQbv0SvC8ZcH+XVEV+iaJSI
         ujnmoq/JzJuf2QrWwhalRSCts1Lle2cL92CUF332idsxHOf35dlZTvOyUwj7VvrDCSen
         g/HY1rzvYA3mTaFTzW/ed17hTxnTyY04m2vTw2S0ekYe8Y6e9S61CtyK6MCWUefFcxT5
         5RyQwI+vWfGR8JsSewZavytQycppa44tjg/ndXvTL+bLPFzzCRZx4HNCLzwDywSf79Ng
         xVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=26sZG3HIo6IT2q4mq9Jr5Z7NwmOveaei3bWuwXv9MFs=;
        b=k+mPkpe32PEmOGiw4UkW3vGelvF7qORVPRYF4kti/wEyfqKx5xTaNYNlUEu1RBwbbZ
         iBGbLXh6+YrJfxVAd+wfHSSc2ghapQDERYXKHmuKjTG2zYtMnTJCEmK79HR4c/aQ2SLq
         gMSl1RR3/Kz6/Q/6ztTyy02P4VtQniH4P6m8iRVE5jWVPPcZnN8VBDrVwAkgp6zJWy9e
         jXBc68v19PthtZ4+rs8AUZyh0hhW0QK1jE5bUMX25+/Tllgeqz+6UWFGeNG/FuZd0kau
         S0ySezv0H8y6bZnnN8qwbQyJJsFHmOwYWFc3kGRYXkpbPWVikaMcbSvjzpX+H5XDoR4Z
         OF7A==
X-Gm-Message-State: AOAM531PFhHMJBJLSkXqX9y6dkuS66vvaVXzH2PuP6nJhMdBBbaTceO2
        gr/OeLgZOd9RRubmD13LPbISjA==
X-Google-Smtp-Source: ABdhPJx8M9FZ6o3yRomu1k33t1Wd3E3SkRm4bgurf9JQn9HRuSnVxF4ZgPPyBWSls+LughFr8fvq1Q==
X-Received: by 2002:adf:e84d:: with SMTP id d13mr57575468wrn.72.1638953035602;
        Wed, 08 Dec 2021 00:43:55 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id l7sm2418034wry.86.2021.12.08.00.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:43:55 -0800 (PST)
Date:   Wed, 8 Dec 2021 08:43:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, shuah@kernel.org,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [V2 2/6] driver core: auxiliary bus: Add driver data helpers
Message-ID: <YbBwSV2IwDHNUrFH@google.com>
References: <20211207171448.799376-1-david.e.box@linux.intel.com>
 <20211207171448.799376-3-david.e.box@linux.intel.com>
 <YbBYtJFQ47UH2h/k@unreal>
 <YbBZuwXZWMV9uRXI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbBZuwXZWMV9uRXI@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021, Greg KH wrote:

> On Wed, Dec 08, 2021 at 09:03:16AM +0200, Leon Romanovsky wrote:
> > On Tue, Dec 07, 2021 at 09:14:44AM -0800, David E. Box wrote:
> > > Adds get/set driver data helpers for auxiliary devices.
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > Reviewed-by: Mark Gross <markgross@kernel.org>
> > > ---
> > > V2
> > >   - No changes
> > > 
> > >  include/linux/auxiliary_bus.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > 
> > I would really like to see an explanation why such obfuscation is really
> > needed. dev_*_drvdata() is a standard way to access driver data.

I wouldn't call it obfuscation, but it does looks like abstraction for
the sake of abstraction, which I usually push back on.  What are the
technical benefits over using the dev_*() variant?

> Lots of busses have this helper.  This is nothing new at all, and is
> nice to have.  Look at all of the calls to dev_get_drvdata() in
> include/linux/ for the examples.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
