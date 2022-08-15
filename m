Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEB5927AF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiHOCGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 22:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiHOCGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 22:06:49 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00412AAF
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:06:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d20so5628576pfq.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 19:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=RGx/Qp3Gi5F06shkDIHb1fnw3ffr/xXLSbmYylTjeeA=;
        b=bDsmXmdfczHc+NbW7ruAgdcczOb/4l8mmhDGampzTGcpRHHjJ1twbK+RQQXZEpO5BH
         kSCpjVDPFFzEO5kwa01XpURyT8Lt2UZnmvUhizde96Qxuji8dtgp2AcZGrXU4sxqlk4w
         a63qDx4rW37z+3Jhe6ZiSpBXT/fve8KKjdbXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RGx/Qp3Gi5F06shkDIHb1fnw3ffr/xXLSbmYylTjeeA=;
        b=lrbSP6RWtmu9k8oGIStRU/st7Alkw3/3H37H/CG6u+nhQi+YitY2n+zacbZBXgtklo
         QuZs6qMN35HdUMqhYksmOYCQdbqGvZYDhOzD3g5Dx2TJuH0zCPv4lbFpB4luYr1YEoNr
         e3ljwCuVNcpC4K0jMp3jRU00Qtl+/FCwjDaBwdB9FH4Tw8ExzxjMeZpE61Oi9NFbuy5f
         eauTasF5nBw+YUCqHEKNLYionTCoICpebkEIx34pPDgRqggauvy2EVwboX1qrwRj6cmN
         F7KF2tjpPHxiBbDokIuWLUtaR7FuoSONupeqcylq9rHYmemz60rEyiUyPZi7zCwJJVmO
         ThEg==
X-Gm-Message-State: ACgBeo2FlOGFXv5Zv759sqeL3w8g1l8GN1pZvcIJ6rSof9qo+Rfr3Ra/
        HSOe1k0siufotlrGzM/j5rNhEQ==
X-Google-Smtp-Source: AA6agR5YN9YetwZ39QriWr6eUGMiuxJCX6xwv/jOIwrsCt7wxyH3k1QxxlsBGDmrV0fkUVzWNKDs1w==
X-Received: by 2002:aa7:95a8:0:b0:52d:4185:198d with SMTP id a8-20020aa795a8000000b0052d4185198dmr14565441pfk.65.1660529207408;
        Sun, 14 Aug 2022 19:06:47 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:110b:946c:84b2:7c95])
        by smtp.gmail.com with ESMTPSA id d7-20020a170903230700b0016efc27ca98sm6025252plh.169.2022.08.14.19.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 19:06:46 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:06:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvmqL6Wz7o77ukF5@google.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
 <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
 <YvUaEDMbZD70x+hD@kroah.com>
 <YvUbhx4HSxAAwIvv@pendragon.ideasonboard.com>
 <YvUghWZbXIUofg5A@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvUghWZbXIUofg5A@kroah.com>
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

On (22/08/11 17:30), Greg KH wrote:
> On Thu, Aug 11, 2022 at 06:08:55PM +0300, Laurent Pinchart wrote:
> > On Thu, Aug 11, 2022 at 05:02:40PM +0200, Greg KH wrote:
> > > On Thu, Aug 11, 2022 at 04:54:53PM +0300, Laurent Pinchart wrote:
> > > > For the time being, I agree with your recommendation to not buy these
> > > > devices if you care about camera support.
> > > 
> > > I second this, don't buy these devices if the vendor is not willing to
> > > get their drivers upstreamed properly.
> > 
> > "Not willing" may be a bit too harsh here. I wouldn't just blame Intel
> > for not upstreaming a driver if it turns out that the V4L2 API isn't a
> > good match and we have no proposal to provide an alternative.
> 
> Did they propose an alternative?  From what I saw here they didn't even
> attempt it, or did I miss that?

The plan here is to land CAM kernel API first and then switch IPU
(driver and user-space) to it so that upstreaming for Intel will
be easier.
