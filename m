Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00A4B6A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiBOLKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:10:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236940AbiBOLK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:10:28 -0500
X-Greylist: delayed 962 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 03:10:15 PST
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6E107ABF;
        Tue, 15 Feb 2022 03:10:15 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21F6vGcF025181;
        Tue, 15 Feb 2022 04:54:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=ZA1HdUqFb+HwEJ8FdZvVs2kz00f9tkNcxNpgQ96eXPE=;
 b=lGmOC8ZryEdtSW6TmatZkTJzoP+AWgpXfYNMPHZYDqOELAAOkswAJd3800duR5wd/1XY
 UazWcy3Mmlb0gUCWnOWeAtX8/huO7lrMjN45NONAb0JjHc1qDpfnLhOfkk/BfqxUCsQR
 iw1qk3Ql8x3Hf3/W7vB37+ttGka3X/UpEeDoIexx8JYFA5O+Zs2lHRSmW3n7gXjq3it3
 zJhqNHuhve05z6g7odf7uTFvLL/OFsj7ua5agi0lU6K/+3AXEF8ou6yVtxh3GFVTZkFz
 VYivd+vtinxoLtGWxQWra2ShNXIyshcV/Fkly0ZOAiB6JaoNWHV6ZkrW/8oEfPlabOx3 gA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3e7qq197c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 04:54:07 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 10:54:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 15 Feb 2022 10:54:05 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 060682A9;
        Tue, 15 Feb 2022 10:54:05 +0000 (UTC)
Date:   Tue, 15 Feb 2022 10:54:05 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>
CC:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Message-ID: <20220215105405.GD38351@ediswmail.ad.cirrus.com>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
 <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
 <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
 <20220208133957.GC112838@ediswmail.ad.cirrus.com>
 <20220208135036.GD112838@ediswmail.ad.cirrus.com>
 <YgJ2hG2vwUclA/zF@sirena.org.uk>
 <20220208143316.GE112838@ediswmail.ad.cirrus.com>
 <YgKBEIapL8MAQAoI@sirena.org.uk>
 <22d9bf04-e069-c6a3-4d59-974a9402b0f7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22d9bf04-e069-c6a3-4d59-974a9402b0f7@quicinc.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: O5SJEsYmLvIZhquG6L90YoFUWeq5Uh9q
X-Proofpoint-GUID: O5SJEsYmLvIZhquG6L90YoFUWeq5Uh9q
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 03:06:24PM +0530, Prasad Kumpatla wrote:
> On 2/8/2022 8:11 PM, Mark Brown wrote:
> >On Tue, Feb 08, 2022 at 02:33:16PM +0000, Charles Keepax wrote:
> >>On Tue, Feb 08, 2022 at 01:56:20PM +0000, Mark Brown wrote:
> ISR = Interrupt status register
> ICR = Interrupt clear register
> 
> When the Invert_ack is
>  *
>    *FALSE*: For ICR,writing 1 will clear , writing 0 has no effect.
>  *
>    *TRUE* : For ICR, writing 0 will clear , writing 1 has no effect
> and clear_ack
> 
>  *
>    *TRUE* :  Some hardware doesn’t support auto clear for ICR,  Need
>    explicitly clear the ICR
>  *
>    *FALSE *:  No need to clear ICR, as HW will reset.
> 
> Consider the following scenario,  where Invert_ack is false and
> clear_ack is true.
> 
> Say Default ISR=0x00 & ICR=0x00 and ISR is triggered with 2
> interrupts making ISR = 0x11.
> 
> *Step1:* Say ISR is set 0x11 (store status_buff = ISR). ISR needs to
> be cleared with the help of ICR once the Interrupt is processed.
> 
> *Step 2:* Write ICR = 0x11 (status_buff), this will clear the ISR to 0x00.
> 
> *Step 3:* Issue - In the existing code, ICR is written with ICR =
> ~(status_buff) i.e ICR = 0xEE à This will block all the interrupts
> from raising except for interrupts 0 and 4.
> 

Ok yes I the issue here now. I hadn't quite realised there was
hardware where you actually had to manually clear the ACK bits.

> Code snippet for step 3
> *if*(chip->clear_ack) {
> *if*(chip->ack_invert && !ret)
> ret = regmap_write(map, reg,
> data->status_buf[i]);
> *else**if*(!ret)
> ret = regmap_write(map, reg,
> ~data->status_buf[i]);
> 
> Solution: Since ICR does not clear automatically, writing 0x00 into
> ICR explicitly will clear the ICR (ICR = 0x00) allowing all the
> interrupts to raise.
> 
> So I’m thinking to implement as below.
> if (chip->clear_ack) {
> if (chip->ack_invert && !ret)
> - ret = regmap_write(map, reg,
> - data->status_buf[i]);
> + ret = regmap_write(map, reg, 0xff);
> else if (!ret)
> - ret = regmap_write(map, reg,
> - ~data->status_buf[i]);
> + ret = regmap_write(map, reg, 0x00);
> }

I think this looks much safer, the values you are writing should
have no effect, other than clearing the ACKs you just set.

Thanks,
Charles
