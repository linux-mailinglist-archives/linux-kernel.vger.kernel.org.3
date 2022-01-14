Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5174448E906
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbiANLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:18:06 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:34636 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232873AbiANLSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:18:05 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20E5Cio0005698;
        Fri, 14 Jan 2022 05:18:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=R33BElVQupXFbTDN+OsGp/VAy1tSFbXhIXhIS2yYmTc=;
 b=AHo2x28qFcQNanfL+B3lUEoPUbaKNtSFHrd4C7wleElnIpYoMw9jrNQGAcci1Q/BmI5D
 yRie9nU9fqYmbqK54jcNWPQWzIeg+NVKjCPPvrUe49HXNf8yr8M+Tks8CC7EmJ6X2e9U
 UNQ2HSfgOuAZRrA48SvflSzesuqResPlakkGBXMemTX/zr8vHkkFpAdCoGs8jh3eDOZ7
 jJpWZERs1Jb2uCoFO5BDARjmFrdQb8Mx7dP0NM8ODPOlAIWYB5Cc3oVbjWvayQntJhTL
 69Eys0+1ZHUX98+0Lj07qhvNdQz5ktczE82+gdvoTkQhWmFRNWIf60YoZH6E98yMKK9/ sg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3djma115bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 14 Jan 2022 05:18:02 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 14 Jan
 2022 11:18:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 14 Jan 2022 11:18:00 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8878E11D7;
        Fri, 14 Jan 2022 11:18:00 +0000 (UTC)
Date:   Fri, 14 Jan 2022 11:18:00 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <robh@kernel.org>
CC:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: ChipIdea USB regression
Message-ID: <20220114111800.GL18506@ediswmail.ad.cirrus.com>
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: WYqIB65Cdgw84DO7D3IsWwxrzukvmPPq
X-Proofpoint-ORIG-GUID: WYqIB65Cdgw84DO7D3IsWwxrzukvmPPq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 10:56:20AM +0000, Charles Keepax wrote:
> Hi guys,
> 
> My Zynq based board stopped booting today, a bisect points to this
> patch:
> 
> commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
> 
> It looks like it gets stuck in some sort of boot loop of doom:

Ok so poking that a little more, I think I can see what happens,
the USB DT node looks like this:

usb0: usb@e0002000 {
	compatible = "xlnx,zynq-usb-2.20a", "chipidea,usb2";
	status = "disabled";
	clocks = <&clkc 28>;
	interrupt-parent = <&intc>;
	interrupts = <0 21 4>;
	reg = <0xe0002000 0x1000>;
	phy_type = "ulpi";
};

&usb0 {
	status = "okay";

	dr_mode = "host";
	usb-phy = <&usb_phy0>;
};

So when that patch copies the DT node to the new platform device
in ci_hdrc_add_device it copies the compatible stuff as well as
the IRQ stuff it was targeting, this presumably causes the kernel
to bind a new copy of the driver to that new device, which probes
and calls ci_hdrc_add_device again repeating the process until
it dies.

Kinda looks to me like the best solution might just be to revert
the patch, I am not sure I see how that copy of the DT is supposed
to work?

Thanks,
Charles
