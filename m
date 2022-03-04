Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B454CD7A8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiCDPYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbiCDPYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:24:04 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093901B124C;
        Fri,  4 Mar 2022 07:23:15 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2244w2iN013723;
        Fri, 4 Mar 2022 09:22:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=zdyEa7Y4Dsr2FafTy8WZl0nDrvZfH+dMGq9ZuvpLGnQ=;
 b=Kq7vR+KhtGA8dQRLQZ9Ne23lw2Po/DfkMXM9tOJ8Z4dwp7gCwgaMoZciXJLJyq9Uu+Ll
 f0WpxYdJ+cgZQ1LukhKGZJLs1VI+Forr6P883c+ws+0Fj72ByolDi8iX2q/8jK7EIiPb
 Tj5yZTCRzno+y9sSIvqCR1TkVGpW36sqXrID9AKyRSbHVnyXl2AqR75LimN9Db7BRvf4
 pVE8Y/u/JqxTXKgn0rY4uerxlB8ifh7mW75HsNtVKBljx+4KuJ+TMMu9hhVshc1nIP93
 PAx8EmAibGAto7N5HzLYpaNgH9rt4KyAAueuw3tDLqNx/WdhUgj11dSS4g5Ck/EPBg5Y nw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h4nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 09:22:28 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 15:22:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 15:22:27 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3B95BB1A;
        Fri,  4 Mar 2022 15:22:26 +0000 (UTC)
Date:   Fri, 4 Mar 2022 15:22:26 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        David Rhodes <drhodes@opensource.cirrus.com>
Subject: Re: [PATCH v2 01/20] ASoC: cs35l41: Fix GPIO2 configuration
Message-ID: <20220304152226.GE38351@ediswmail.ad.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
 <20220304150721.3802-2-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220304150721.3802-2-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 6j_lMiZTNMeNu_XmAeDm7JNCjuNaQLYm
X-Proofpoint-ORIG-GUID: 6j_lMiZTNMeNu_XmAeDm7JNCjuNaQLYm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:07:02PM +0000, Lucas Tanure wrote:
> From: David Rhodes <drhodes@opensource.cirrus.com>
> 
> Fix GPIO2 polarity and direction configuration
> 
> Fixes: fe1024d50477b ("ASoC: cs35l41: Combine adjacent register writes")
> Signed-off-by: David Rhodes <drhodes@opensource.cirrus.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---

Really sorry I only just spotted this but you are missing your
own sign off here. You always need to personally sign each patch
you are sending up.

Thanks,
Charles
