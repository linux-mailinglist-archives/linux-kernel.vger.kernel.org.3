Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C354FAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382669AbiFQPui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiFQPug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:50:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5951237DF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:50:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H3eJxo019085;
        Fri, 17 Jun 2022 10:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Ahdx8sBoxSV39mhILpNiLucN5DgFPfJrpifEXjQFb5c=;
 b=llf4ZdqGNcKfhg9Pn3WEVdHkpS8YZ9snRyfeGtLSYu4lDBwll/0pi83nXYwpGgWKaTvI
 3WS/q7CY1X48Kmi7hKQoEzEctAmQQwoo4XS0ngJB1ZqtN7Yz19z8wfAlRKcEQBza6jjd
 a3pZxfhdahX+UNezO3WvwjF1QYlXmq8PdvUBr+zUb1BJ+SNOWg2thye8/4DcPlnrSuFe
 cUok9y/1F+v14F/KYW5ev9KKb7qZ+IRqE+3MaCeCRCXsQ4IToiAzbWEc2zevdowrJ4KV
 8hwJ/zdLXHloBLWGt+aTjLJ+35xomMW8iG8/MjzUD1xFaDHyXyQuCG90DD4VuBJDLaHY iA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq79r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jun 2022 10:50:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 16:50:28 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 17 Jun 2022 16:50:28 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D454468;
        Fri, 17 Jun 2022 15:50:17 +0000 (UTC)
Date:   Fri, 17 Jun 2022 15:50:17 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stefan Binding <sbinding@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v1] ASoC: ops: Fix integer detection for when max
 possible values > 1
Message-ID: <20220617155017.GF38351@ediswmail.ad.cirrus.com>
References: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220617153606.2619457-1-sbinding@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: UpVMj3PBZs9Q-zpD-1y79KJr-yYNuJjg
X-Proofpoint-GUID: UpVMj3PBZs9Q-zpD-1y79KJr-yYNuJjg
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 04:36:06PM +0100, Stefan Binding wrote:
> The standard snd_soc_info_volsw() allows a two value control to be
> defined as an integer control only if the control name ends in
> "Volume". It achieves this by creating a substring if it contains
> " Volume", and ensuring this exists at the end of the name. The
> volume substring is then used to decide whether the type is a
> SNDRV_CTL_ELEM_TYPE_INTEGER or SNDRV_CTL_ELEM_TYPE_BOOLEAN.
> However this volume substring is only computed for a two value
> control.
> This means for controls where there are more than two possible
> values, the substring is never created, so in this case the
> substring remains NULL, and the condition yields
> SNDRV_CTL_ELEM_TYPE_BOOLEAN, even though there are more than 2
> possible values.
> If there are more than 2 possible values for the control,
> then it should always be an integer control.
> 
> Fixes: aa2a4b897132 ("ASoC: ops: Fix boolean/integer detection for simple controls")
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
