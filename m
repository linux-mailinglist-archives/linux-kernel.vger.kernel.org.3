Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2054AD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353984AbiFNJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiFNJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:16:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35141F9C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:16:11 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E8EEoR024961;
        Tue, 14 Jun 2022 04:15:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=hGaw1xpIdCRzMGGJr+AjwkBfT2/8u311FkS5dHtbvyc=;
 b=jc2xlFdBKEffU1+ETM/D+dwgICc4/YvL113PC2Qx2JPrKi+3fJ62DNmX7titImY3CioW
 Ubp94ZqDHNYjZBXsgSdq8sUNtpBop1DXrNFqA+fY5UAz2G+M6BQkhaTailYQj8j2dp2K
 WVz2NB5SK/DNyX4mI3kxU8maV8rhVs5+oywWQSP6HowEMBs0/StfZCsQsNfVvNQ3HZRf
 5pXwUPRkwE88+lAYvMO3WZoNBBEZLEE/31xik4A/uuJCrVC7jsb15chv0OFa4RdpTJe/
 xYhjNg1c/7H1P48iMh3rsC2k71aGQ2tCDdUoBYDNk/b1Id01S0wl0MELvmEE4R0txMpD /A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gmrf32w2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jun 2022 04:15:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 10:15:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 14 Jun 2022 10:15:48 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 089CD458;
        Tue, 14 Jun 2022 09:15:48 +0000 (UTC)
Date:   Tue, 14 Jun 2022 09:15:48 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     <broonie@kernel.org>, <matthias.bgg@gmail.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sun8i-codec: Partial revert to fix clock
 specifiers
Message-ID: <20220614091548.GC38351@ediswmail.ad.cirrus.com>
References: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
 <9e105410-94d5-1801-8919-af8c0cef4de1@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9e105410-94d5-1801-8919-af8c0cef4de1@sholland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: uhUugW3zc5bftMo1ASxJcy0Ldlvdyx22
X-Proofpoint-ORIG-GUID: uhUugW3zc5bftMo1ASxJcy0Ldlvdyx22
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 01:39:20AM -0500, Samuel Holland wrote:
> Hi Charles,
> 
> On 6/13/22 11:15 AM, Charles Keepax wrote:
> > Recent updates accidentally updated the clock producer/consumer
> > specifiers on this device as part of refactoring the CPU side of the DAI
> > links. However, this device sits on the CODEC side and shouldn't have
> > been updated. Partially revert the changes keeping the switch to the new
> > clock terminology but going back to the CODEC defines.
> > 
> > Fixes: 7cc3965fde74 ("ASoC: sunxi: Update to use set_fmt_new callback")
> > Reported-by: Samuel Holland <samuel@sholland.org>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> Reviewed-by: Samuel Holland <samuel@sholland.org>
> Tested-by: Samuel Holland <samuel@sholland.org>
> 
> Thanks for the quick follow-up, and sorry for the confusion my earlier comment
> caused. I verified that sound is broken (loud static) on a Pine A64-LTS board
> with for-next, and is fixed by this patch.

Not at all man, thank you for spotting my foolish mistake. Glad
we got it fixed up for you, and thank you for testing it.

Thanks,
Charles
