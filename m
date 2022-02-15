Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA64B6A04
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiBOK6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:58:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiBOK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:58:53 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440DCDB4B9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 02:58:33 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21F4STA4031155;
        Tue, 15 Feb 2022 04:55:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=9pRI9DHKMGrjxTpdktKuGS8mctU4c81Pqefuj9Uotc8=;
 b=Jp3pzaNepVGVVDVl+Igkfk8BlLbu+gQbUcdAqV4rmSlO7FBvUIArT6iofAI2ZVycyqDm
 I6ENQqlHwdhB0+AThKzsyqp5J/gYbBKgmnPAyfnOo7MEiW2wnQw35uQsKxHJk89NTL9q
 LYi+vBNq4bukYemDZJHLtHZjAkBHZ7Pgfinb3vAQ1TTqtH0nExM4b+2mlCRIl9ixx257
 YNH7fsSe6yz0pgFUIjWZGiAG5YbtDiHwbiwihAYQna8wcXRqhjEw7YzfhQBsB6k0ux7M
 hvXNPA0LNpqeacn+OSoXI7IefUr8DR1YjZlu737ncMPlvUBbvNPOUtF/RGiMZLER3fI0 uQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e7kx7sbp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 04:55:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 10:55:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 15 Feb 2022 10:55:35 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 48B4811C7;
        Tue, 15 Feb 2022 10:55:35 +0000 (UTC)
Date:   Tue, 15 Feb 2022 10:55:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@freescale.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codec: wm8960: complete discharge on BIAS
 OFF->STANDBY
Message-ID: <20220215105535.GE38351@ediswmail.ad.cirrus.com>
References: <20220208121727.4461-1-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220208121727.4461-1-viorel.suman@oss.nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: HvhLj2FcgwmuXl1hKIbOImqGwRK0Hy7H
X-Proofpoint-GUID: HvhLj2FcgwmuXl1hKIbOImqGwRK0Hy7H
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 02:17:27PM +0200, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> On BIAS STANDBY->OFF transition the current implementation sleeps
> 600ms on suspend in order to discharge the chip. The suspend is
> propagated from "snd_soc_suspend" call for all audio cards in a
> serial fashion, thus in case of boards like i.MX8DXL EVK which has
> 3 distinct WM8960 codecs the total cumulated sleep on suspend is 1.8
> seconds.
> 
> On the other hand the BIAS OFF->STANDBY transition happens
> asynchronously with regard to "snd_soc_resume" - the call is
> propagated from "soc_resume_deferred" which is just scheduled
> from "snd_soc_resume", each card having its own work scheduled to
> execute "soc_resume_deferred" call.
> 
> The patch performs discharge completion on BIAS OFF->STANDBY transition
> so that the cumulated effect on suspend described above is avoided
> and discharge is completed in paralel in case of multiple WM8960
> codecs on the board.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---

Apologies Mark not sure how I missed this one, a bit late now,
but the change looks good to me.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
