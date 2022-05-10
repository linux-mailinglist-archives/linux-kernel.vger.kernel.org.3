Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA85E521019
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiEJI6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiEJI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:58:46 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8352AC6F8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:54:48 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24A6NhvH002472;
        Tue, 10 May 2022 03:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0YkFFAz887Qm36gFThwOEYzoNDPgmPh1ObjkpzKkRGE=;
 b=E5isWg4x8DGylbBvtUyN+Aw2MVPaBnNcVwmHjp0eR/QgV9m0+S6n1SVzyvO2j0F95eSG
 fPO5K3f8QaQ9C53DNn5KM7hKW3qhPUYV/pwBduSZUQmoVms2EbBQY5mpJ4SJcLAcn/iC
 vWEQkbaFtoCDmxIVEFpu/tD2kJNf/BXBuCqswC63J6cAja/err6oy9y2b251Hut0FRog
 VEbwKT85X6zt88BXWUTtPx+RbvhgoMluokZJ/3/aH7frHVKOe1T9zqTEa1oFZazzU3p7
 XxveFnbI+wiKAwDnnZcX4oQeEI1HMsSOiqMl9XY3BUbyAmKGtW/dWNVoIXXHnr6pynIj Uw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fwp6146ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 May 2022 03:54:03 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 09:54:01 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 09:54:01 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 44880475;
        Tue, 10 May 2022 08:54:01 +0000 (UTC)
Date:   Tue, 10 May 2022 08:54:01 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH v2 19/26] ASoC: cs35l41: Do not print error when waking
 from hibernation
Message-ID: <20220510085401.GB38351@ediswmail.ad.cirrus.com>
References: <20220509214703.4482-1-vitalyr@opensource.cirrus.com>
 <20220509214703.4482-20-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220509214703.4482-20-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: mxY978Zt_bkbu9WweFSSDiwAbC-m8WZp
X-Proofpoint-ORIG-GUID: mxY978Zt_bkbu9WweFSSDiwAbC-m8WZp
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

On Mon, May 09, 2022 at 10:46:56PM +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> When waking from hibernation, it is possible for the function
> which sends the wake command to fail initially, but after a
> retry it will succeed. There is no need to print an error if
> the initial attempts fail.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
