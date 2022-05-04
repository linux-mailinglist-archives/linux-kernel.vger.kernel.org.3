Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122D51A46E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbiEDPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiEDPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:52:52 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670A40E55
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:49:16 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446OEmB006119;
        Wed, 4 May 2022 10:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=84DmXt4gkkOYgFnsQAgnwXAlvLD3q6mcVFv8uhaEpFY=;
 b=Q/C/NuYMYcchHHsVdlg7QQAvTebnLadWEB8QI9oaEP0qAhjP9foB2FXUASCcNx386E4d
 4+P/Kf3PBdni5relu0rglAqB/uaBQ6P623AF7l3zs5kjJxpwZ1MetKRvQD/H64+jg+kN
 kIjPHzfFWafc2HkKE+BmmEwLWxCIpCGn/NKhjsZLAuwUn9XmsnGtvUXNhdQGm6e27BmR
 c7HL5zgSwyRQ/uiVR3/2NxrMIxwtR5zO/KmYbMV0zb6VIes24BI1ZoYWPZJb46hYUVYl
 q57Qt3cfRcUOM+2mfXSFsNasg8MN1LCwlaebhxR8XqZnuQW3I+7ALHwsVKEuQFvreenK XQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fs1hpcurr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 May 2022 10:48:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 16:48:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 4 May 2022 16:48:15 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1F1CA459;
        Wed,  4 May 2022 15:48:15 +0000 (UTC)
Date:   Wed, 4 May 2022 15:48:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: cs43130: Re-use generic struct u16_fract
Message-ID: <20220504154815.GW38351@ediswmail.ad.cirrus.com>
References: <20220502120455.84386-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220502120455.84386-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: Vdq-p2tbvc5U5cfun-lsY7PjND8fBZY8
X-Proofpoint-GUID: Vdq-p2tbvc5U5cfun-lsY7PjND8fBZY8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 03:04:55PM +0300, Andy Shevchenko wrote:
> Instead of custom data type re-use generic struct u16_fract.
> No changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
