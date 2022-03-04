Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963A64CD1D9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiCDKCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiCDKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:02:04 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189E199E18
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:01:17 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2247b5Ct008062;
        Fri, 4 Mar 2022 04:00:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=QWEErRiRWN1/TNCzeHf5WfEfHdlTZ8X8iK6zXZlSBlM=;
 b=kBi4q7QOyrZYtE4asa+JrOP/uCGNM4996vND6b7BSAcxnLmLBJLanx5ea97ZmPQW9ODM
 dGd3jX2y++2Djd4x8vFmOtQtqvEa6NDbjjkR1cGNJCR6VYyeIBOzjVjVpgp9W/9Q0jYV
 7ZhccuNs1qSNC2c7EP7VfQnIx2xZB1/8i+g5zncR4A3RozxaMKn54idDOUpgIZx3UU7l
 WzECScygZeOTL+kJdd/q0h+aVYM9sMNIRWZyakLYOSUd+1nHh3mmvaSMygywkgy2CM2S
 7G0wpX/k4adIDWO3pDxyUkxu5rxG/axg3kvy0rNVx/EP34ymeAzQMHAzh5Q4wQo7y0UM 8w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j1rs2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 04:00:29 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 10:00:27 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 10:00:27 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6675A7C;
        Fri,  4 Mar 2022 10:00:27 +0000 (UTC)
Date:   Fri, 4 Mar 2022 10:00:27 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8350: Handle error for wm8350_register_irq
Message-ID: <20220304100027.GV38351@ediswmail.ad.cirrus.com>
References: <20220304023821.391936-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220304023821.391936-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 2KrBtTRaR9Ej1GARveBYJN7a8ldIOiBw
X-Proofpoint-ORIG-GUID: 2KrBtTRaR9Ej1GARveBYJN7a8ldIOiBw
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 10:38:21AM +0800, Jiasheng Jiang wrote:
> As the potential failure of the wm8350_register_irq(),
> it should be better to check it and return error if fails.
> Also, use 'free_' in order to avoid the same code.
> 
> Fixes: a6ba2b2dabb5 ("ASoC: Implement WM8350 headphone jack detection")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
