Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5B8522088
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346978AbiEJQD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347404AbiEJQBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:01:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C181FE2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:55:19 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A5iU1j032715;
        Tue, 10 May 2022 10:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=7lL6RqLJPGkynsQSaxGyq69dVR1T6FKpL+niMCkLJEI=;
 b=cbrcgnB9KDqiP36nY+qFxvWIGpmPcJLYe5BSRSSwxxFnjirJnVj1QE+XKLINQVoLr5jn
 CgvUD+9F89BkaRTzfgFPWBDvdoh2LJJO+AQPSyUL54XuWbcujdwWZiRq/eBAesa8ADqM
 Z9iP8LkAlks9A2wAQDmXLZ3fa84pPJwwrZ4EDCFsGZ17Gh+MK511vZHOQIuIfMHuo1QA
 RvZgAP+ZsPk6PtNAo+WeayvYMr7IwxkKgUUmctAkNk/9nhNQ9Hp8SNURBPXZeb2cvlyk
 Zuadv06vGz9DFPIyNJAROmLnVduvabzxMLdyRvI63T58yqH7Jq6G5Yi/KdHcjERbdrEM vw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp6152s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 May 2022 10:54:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 16:54:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 16:54:11 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 04C4CB10;
        Tue, 10 May 2022 15:54:11 +0000 (UTC)
Date:   Tue, 10 May 2022 15:54:11 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <oder_chiou@realtek.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] ASoC: cs42l52: Fix the error handling of
 cs42l56_i2c_probe()
Message-ID: <20220510155410.GC38351@ediswmail.ad.cirrus.com>
References: <20220510153251.1741210-1-zheyuma97@gmail.com>
 <20220510153251.1741210-2-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220510153251.1741210-2-zheyuma97@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: CRXABebgtt9svhTLF867E-nijdpNEqoH
X-Proofpoint-ORIG-GUID: CRXABebgtt9svhTLF867E-nijdpNEqoH
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:32:46PM +0800, Zheyu Ma wrote:
> The driver should goto label 'err_enable' when failing at regmap_read().
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  sound/soc/codecs/cs42l56.c | 2 +-

Patch looks good but the subject line says cs42l52 instead of 56.

Thanks,
Charles
