Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C054CD8F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiCDQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiCDQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:19:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AFEE1B60;
        Fri,  4 Mar 2022 08:18:24 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224DOfXD012568;
        Fri, 4 Mar 2022 10:17:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=zjqR9q9GiOBUPRKXEJb75rxzZ1gRxVDQCkHM71cLsyk=;
 b=JJWb49rdZfvOAhrJcW+9e/tL8LBdjImXnsSU0P5u6QUJObwMU5kH8D4sTI9sNSDE6giB
 eTZ1AtONUD2u4pe1WqF3EEBjWUqYvDEPicuIOqiljkGfXldbETusqRUuDJ4WXwlpuhR/
 mbN8PfFVd7lZy3SY1w10s5aLCRNqS/ogsqdd1dTZWUIish1MCkiz31vRySgxi2/u2xHl
 BUqG3X/4f8Wuw/h1YSXSSds2XtNBwsGpiZln15nYvRLl1c/LBSiz4KmCAUo90SaIqBtc
 kOxM1gS6U9dLQ376BA9JhVosDhieaTyPxgkyOoHwjVUCo0YFHILSQrFK+qq67aiqsLBS Og== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j3h6we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 10:17:36 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 16:17:34 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 16:17:34 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 34C13B06;
        Fri,  4 Mar 2022 16:17:34 +0000 (UTC)
Date:   Fri, 4 Mar 2022 16:17:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 13/20] sound: cs35l41: Enable Internal Boost in shared
 lib
Message-ID: <20220304161734.GF38351@ediswmail.ad.cirrus.com>
References: <20220304150721.3802-1-tanureal@opensource.cirrus.com>
 <20220304150721.3802-14-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220304150721.3802-14-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: za1i0AhO99R2P4JBpiRAN2mzmymFBZOf
X-Proofpoint-ORIG-GUID: za1i0AhO99R2P4JBpiRAN2mzmymFBZOf
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:07:14PM +0000, Lucas Tanure wrote:
> Boost enable is the default option from reset,
> but with external boost support, internal boost
> must be disabled.
> Add the enable of boost in cs35l41_boost_config
> to centralize the internal boost configuration.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
