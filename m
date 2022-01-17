Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353AF490586
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiAQJ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:56:14 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:61916 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238225AbiAQJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:56:12 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20H3Y1tY031175;
        Mon, 17 Jan 2022 03:56:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=swnBwmh9T5kN9unWUMrAfFmwCneEGo+nMB8cZHf8ju0=;
 b=DqRN7adqUdumPW28d/JpmCv10RlKfGeMUw32sW5Zy3a1UyMZHoE8AACoSptbrjVA25mY
 yrdiJu6mUja958MoAQ2bz2nwu2OTLY2+KNJxxcRsv5PAIj/zXkY+1JyoLi+/ALJtUZPv
 JxSy2GrGEcLrqrQtnJgHlcgICn+A35KSI+KzZc27jOnq8ixOoxRDZkA17cvuMg8xB+q/
 PuJLI6lFuz2eCAY/f01zzXSOm+VoUhL6kXVd/R8LXWXGzJYd7Y9LyeJHFrqVwckcZeU6
 vnzgWdQudkBsKgjNxwWQq0X0rphzxMGOQMwTibw9idWrsCrr0zGPcf/pqGgZbwDX/oBQ Ig== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3dkujr1nu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 03:56:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 09:55:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 09:55:59 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5F3D5B16;
        Mon, 17 Jan 2022 09:55:59 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:55:59 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Subject: Re: ChipIdea USB regression
Message-ID: <20220117095559.GN18506@ediswmail.ad.cirrus.com>
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
 <20220114111800.GL18506@ediswmail.ad.cirrus.com>
 <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
 <20220117092656.GM18506@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220117092656.GM18506@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: TNVOPhGzgfu8mcnSq8STtQjNU7_aBGB1
X-Proofpoint-ORIG-GUID: TNVOPhGzgfu8mcnSq8STtQjNU7_aBGB1
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 09:26:56AM +0000, Charles Keepax wrote:
> On Sat, Jan 15, 2022 at 09:55:23AM -0600, Rob Herring wrote:
> > On Fri, Jan 14, 2022 at 5:18 AM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > On Fri, Jan 14, 2022 at 10:56:20AM +0000, Charles Keepax wrote:
> > > So when that patch copies the DT node to the new platform device
> > > in ci_hdrc_add_device it copies the compatible stuff as well as
> > > the IRQ stuff it was targeting, this presumably causes the kernel
> > > to bind a new copy of the driver to that new device, which probes
> > > and calls ci_hdrc_add_device again repeating the process until
> > > it dies.
> > >
> > > Kinda looks to me like the best solution might just be to revert
> > > the patch, I am not sure I see how that copy of the DT is supposed
> > > to work?
> > 
> > It's not copying the DT, but yes AFAICT it does match and bind the
> > child device on the parent driver using the compatible match instead
> > of matching on driver name. I think we can use the of_reuse_node flag
> > to avoid this in the match, but that needs some more investigation.
> 
> Assuming you mean the of_node_reused flag, looks like it already
> being set, your code does this:
> 
> @@ -864,6 +864,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
> 	pdev->dev.parent = dev;
> 	+ device_set_of_node_from_dev(&pdev->dev, dev);
> 
> And that function does this:
> 
> void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
> {
> 	of_node_put(dev->of_node);
> 	dev->of_node = of_node_get(dev2->of_node);
> 	dev->of_node_reused = true;
> }
> EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
> 
> I guess maybe that flag doesn't do what it is supposed to for
> some reason?
> 

Ah ok it seems that flag is only currently used by the pinctrl
subsystem, didn't realise that was quite so new and not used
anywhere. I guess we probably need to add something to the
platform device code to use that flag too, if that is the way we
want to run with this.

Thanks,
Charles
