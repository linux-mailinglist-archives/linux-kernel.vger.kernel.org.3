Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5165929C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240853AbiHOGoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240689AbiHOGn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:43:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7181ADBF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:43:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so5663640pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=blOwFtIlb0epux0KE7iDtki8GIqZ3py6TisC3Pc7SsQ=;
        b=KF9pNrtqYb/STvSOhpmkV4gKrvwiRQ1il32mzFZqFx2UInzL9gwqCTFXS57w3Gknd9
         YW3KI1fv7aXliDnShFTNhC4eZOIwax8BFKHC31zrUx6NGmuLzkzADU8sARdffj+F6edv
         dJ6ItGnABs/3GqoNb01fJKXyMINytW0rZW8+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=blOwFtIlb0epux0KE7iDtki8GIqZ3py6TisC3Pc7SsQ=;
        b=W8YvBMbLlzbnMxCak1U6ZZYIsVx2fg+1pjPiv17DyYwoRntntkgh9DL30R/FmVV8dZ
         b/Y5nreEWBIZ7OJSRWqSwPBE9Tp2tQauNmeOQRd2pLKkYtsCjj3uMrqWVfDggpyNLzJ3
         RtnliM6WVA8VIGeYlVpw1glytGVOXllNj+km0A1mbTi61YcQtQYowvQot8BvpRlAjxAe
         VQGcuUJZf0Fw76Rf5mju8A2cE9UI1JjNFj+rtFkwBp240tOin5cHbZcPUDPnDUvhYRcc
         EzDobx1M7M+dz9F781gaXlXJ96arG8U1Uc2KbL9cGwEeP1S9+Vs7XBfI3DTFkIvCi/Li
         R0nA==
X-Gm-Message-State: ACgBeo3IFVmPeml5WXb0Qqh0c60SmieASGFxywsPNl3EmTYbjfuyjXJn
        swfKDWWuSHx7cKlyDeKtFKmisw==
X-Google-Smtp-Source: AA6agR7CS4fp8rbo2pGtzXt41p1v7FRGQNytkb7NO7kfnScMDxaDCBmsAgzU11jZ2yw3KPG2bhmN1Q==
X-Received: by 2002:a17:903:210b:b0:16f:d62:1384 with SMTP id o11-20020a170903210b00b0016f0d621384mr15510159ple.133.1660545836748;
        Sun, 14 Aug 2022 23:43:56 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:110b:946c:84b2:7c95])
        by smtp.gmail.com with ESMTPSA id u14-20020a17090a410e00b001f6c86e6ff0sm3918589pjf.36.2022.08.14.23.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:43:56 -0700 (PDT)
Date:   Mon, 15 Aug 2022 15:43:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvnrJBI8599+E43T@google.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
 <YvmqL6Wz7o77ukF5@google.com>
 <YvnpVmnROTsWWw0o@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvnpVmnROTsWWw0o@kroah.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/15 08:36), Greg KH wrote:
> On Mon, Aug 15, 2022 at 11:06:39AM +0900, Sergey Senozhatsky wrote:
> > On (22/08/11 17:30), Greg KH wrote:
> > > On Thu, Aug 11, 2022 at 06:08:55PM +0300, Laurent Pinchart wrote:
> > > > On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> > > > > On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > > > > > For the time being, I agree with your recommendation to not buy these
> > > > > > devices if you care about camera support.
> > > > > 
> > > > > I second this, don't buy these devices if the vendor is not willing to
> > > > > get their drivers upstreamed properly.
> > > > 
> > > > "Not willing" may be a bit too harsh here. I wouldn't just blame Intel
> > > > for not upstreaming a driver if it turns out that the V4L2 API isn't a
> > > > good match and we have no proposal to provide an alternative.
> > > 
> > > Did they propose an alternative?  From what I saw here they didn't even
> > > attempt it, or did I miss that?
> > 
> > The plan here is to land CAM kernel API first and then switch IPU
> > (driver and user-space) to it so that upstreaming for Intel will
> > be easier.
> 
> And what is the timeframe on the plan?  Where will these changes be sent
> to for review?  I'm guessing they are already in a shipping device so
> what's the delay?

We haven't sent out KCAM for upstream review yet. It's open sourced,
as of this moment [1], but we still need some time and wanted to convert
one of the previous generations of IPU drivers (IPU3) to KCAM first to
see if everything is working as we wanted it to.

[1] For everyone who is curious, our first public KCAM version can
be found here:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3668500/
