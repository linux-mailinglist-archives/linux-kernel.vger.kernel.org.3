Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23810496981
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 03:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiAVC4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 21:56:42 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:13731 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbiAVC4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 21:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642820201; x=1674356201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7tUnRsqJMCPyS1ZK9VW+gOMCKNDNUo4yACdhjLjuGMU=;
  b=DMpIomAAdjdDEtuIcZE2cCnWeU4RnH1IvqBAxuIOirGSQryVqsqV/2DV
   n7PlNTxwsEI6jYWZnHDSy6bRGY2+Tq83vyDV4zt1nG0B9IwnHrClGm9lc
   cq9FjQAX/X17WSY+V9ya7p0PDT274fah7tKHzz42vhlnVshXccZJC4QRC
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 21 Jan 2022 18:56:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 18:56:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 18:56:40 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 18:56:38 -0800
Date:   Sat, 22 Jan 2022 08:26:35 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_sourcesink: Fix isoc transfer for
 USB_SPEED_SUPER_PLUS
Message-ID: <20220122025635.GE11385@hu-pkondeti-hyd.qualcomm.com>
References: <1642764684-26060-1-git-send-email-quic_pkondeti@quicinc.com>
 <YerDsJKn0vAHEIAC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YerDsJKn0vAHEIAC@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Jan 21, 2022 at 03:31:12PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 21, 2022 at 05:01:24PM +0530, Pavankumar Kondeti wrote:
> > Currently when gadget enumerates in super speed plus, the isoc
> > endpoint request buffer size is not calculated correctly. Fix
> > this by checking the gadget speed against USB_SPEED_SUPER_PLUS
> > and update the request buffer size.
> > 
> > Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
> 
> What commit id does this fix?
> 
I see that the issue is present since the super speed plus support
is added to this driver. I will add the below commit in the Fixes
tag and send the v2.

commit 90c4d05780d47e14a50e11a7f17373104cd47d25
Author: Maciej Żenczykowski <maze@google.com>
Date:   Mon Jun 7 21:41:41 2021 -0700

    usb: fix various gadgets null ptr deref on 10gbps cabling.

    This avoids a null pointer dereference in
    f_{ecm,eem,hid,loopback,printer,rndis,serial,sourcesink,subset,tcm}
    by simply reusing the 5gbps config for 10gbps.

Thanks,
Pavan
