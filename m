Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449D4522083
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347086AbiEJQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347617AbiEJQBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:01:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7412369B68
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:55:59 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A4ORnt025518;
        Tue, 10 May 2022 10:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=O1r9WJZyt40J+0RN2MRQFBgLwHBs+wtdx2VZZTMOA2A=;
 b=CVcITX6N0CRWVmiJUDSnVYOMs6Lic7jKw1euRSpw3XSCYU53hvq0D9UTTG3ycB3Xnhem
 qyccSf+nLzQw7wskSleQ59j2QHSO4TD22VYfEknaZp6UVDlADCETZ4IyoyaGKM1h3GeQ
 q+GVpu4VzYFi1vsU8OA6s4/nlUzexeBsfTTi6SAee131jWhY5GJsLOoZwxbCoREQNQmM
 FVTy59HCPcN5z+P/BwX+irnOV9Jt0EsSzUkun+fHfCC1f7SIdnnnDgDcaGzEOCYrEHCA
 ni2/v4c9Jdbz6eEqJ0qYYL3rx5GF3kcqPThF77+Vk3h/vXY7pD6lzhOdMQDWJD2IUpKj 1w== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp6152tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 May 2022 10:55:13 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 16:55:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 16:55:11 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 60264475;
        Tue, 10 May 2022 15:55:11 +0000 (UTC)
Date:   Tue, 10 May 2022 15:55:11 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <oder_chiou@realtek.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] ASoC: cs35l36: Fix the error handling of
 cs35l36_i2c_probe()
Message-ID: <20220510155511.GD38351@ediswmail.ad.cirrus.com>
References: <20220510153251.1741210-1-zheyuma97@gmail.com>
 <20220510153251.1741210-3-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220510153251.1741210-3-zheyuma97@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: YLx8iFfdTQRK9C8syZN8cmNWTsNgy7H0
X-Proofpoint-ORIG-GUID: YLx8iFfdTQRK9C8syZN8cmNWTsNgy7H0
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

On Tue, May 10, 2022 at 11:32:47PM +0800, Zheyu Ma wrote:
> The driver should goto label 'err' when failing at regmap_read().
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
