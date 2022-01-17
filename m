Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE44904D0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiAQJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:27:11 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:15882 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232585AbiAQJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:27:10 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20H5VoL8004479;
        Mon, 17 Jan 2022 03:26:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=C91gWLLOR9MQkEctlcrUtw91QuwUpHk8YmwclM2NQqs=;
 b=CYL6ZH4gSY85YIqBxnLO/o5lW5orb9FxtXdJIBFLKnM8xXFXcn6YIIsIYBl0y7efNva1
 S1MX7xg3EqDueduWmMkTmvgugBqYWt4ih3HR4Llh6ELUwZ75sPzwjdTZfpkO1Zc/Mpy/
 ICfyvkiQueJVeuc0SJKN5e0HG3dH7HXchNmsxUz3BAj2sFDFsi2NUp89b1264ocNoBwZ
 SU0Fv1Po/p8djN+vyQQzoEl9saBWcXLEY7H7on49AAb7srj36t9WrNEu/xTJr7+Oq4fe
 foSVdJoMCsNHY8Z/YVic8i7Zmv+9vtb4pf6z0a5mLVGr4BT2U4v+SM9oudJqdBAxzXV9 gw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dkvj59ykg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 03:26:58 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 17 Jan
 2022 09:26:56 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Mon, 17 Jan 2022 09:26:56 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A8488B16;
        Mon, 17 Jan 2022 09:26:56 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:26:56 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Rob Herring <robh@kernel.org>
CC:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Subject: Re: ChipIdea USB regression
Message-ID: <20220117092656.GM18506@ediswmail.ad.cirrus.com>
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
 <20220114111800.GL18506@ediswmail.ad.cirrus.com>
 <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: L6LiOKD6ZkYf6JG-I0wmKxqqYuwXrdck
X-Proofpoint-GUID: L6LiOKD6ZkYf6JG-I0wmKxqqYuwXrdck
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 09:55:23AM -0600, Rob Herring wrote:
> On Fri, Jan 14, 2022 at 5:18 AM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> > On Fri, Jan 14, 2022 at 10:56:20AM +0000, Charles Keepax wrote:
> > So when that patch copies the DT node to the new platform device
> > in ci_hdrc_add_device it copies the compatible stuff as well as
> > the IRQ stuff it was targeting, this presumably causes the kernel
> > to bind a new copy of the driver to that new device, which probes
> > and calls ci_hdrc_add_device again repeating the process until
> > it dies.
> >
> > Kinda looks to me like the best solution might just be to revert
> > the patch, I am not sure I see how that copy of the DT is supposed
> > to work?
> 
> It's not copying the DT, but yes AFAICT it does match and bind the
> child device on the parent driver using the compatible match instead
> of matching on driver name. I think we can use the of_reuse_node flag
> to avoid this in the match, but that needs some more investigation.

Assuming you mean the of_node_reused flag, looks like it already
being set, your code does this:

@@ -864,6 +864,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
	pdev->dev.parent = dev;
	+ device_set_of_node_from_dev(&pdev->dev, dev);

And that function does this:

void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
{
	of_node_put(dev->of_node);
	dev->of_node = of_node_get(dev2->of_node);
	dev->of_node_reused = true;
}
EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);

I guess maybe that flag doesn't do what it is supposed to for
some reason?

Thanks,
Charles
