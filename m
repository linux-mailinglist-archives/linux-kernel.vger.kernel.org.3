Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B052BC14
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238160AbiERNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiERNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:45:45 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE80C7B
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:45:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I5xw9k005166;
        Wed, 18 May 2022 08:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/v+nztOH8pMiCldPuv2onTZr9sRDaO7ZE4i23WJ4K5o=;
 b=jJqGPkOUdeC/L4ZyYUnC6X9sEc6RTnXH/TCZUrzLpo10aLccXsSaQ5Gh7PWNyyTk9an4
 mLFfI6Vm4S1nGIDnnCnH+5UfcP+yZ0M+OXu35f4oFe99XWmmdA2m1TYIO9Wx4oc48EyB
 E+PwooMR8Mw9YVvGtUcQdWFGmlqCFOio1JhIexHAnTWUQh8EC5H4uIW/xePkvXF3R2UE
 nJJW++M+txPsTxeHfikhosSeWl01oawvw19rL8GgnKy+2+eUVrLrA17lRGIVoyoYTWBl
 mSBZVGDyaPatwAoYd1iH4vZ3o4JuSn+J0G5JKkT21y6DDAg9BvWVP7kNuIlACTq+NUGC Rg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3g28updkk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 May 2022 08:45:17 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 14:45:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 18 May 2022 14:45:15 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 94983B16;
        Wed, 18 May 2022 13:45:15 +0000 (UTC)
Date:   Wed, 18 May 2022 13:45:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: Re: [PATCH -next] ASoC: wm2000: fix missing clk_disable_unprepare()
 on error in wm2000_anc_transition()
Message-ID: <20220518134515.GJ38351@ediswmail.ad.cirrus.com>
References: <20220514091053.686416-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220514091053.686416-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: F0-9IuOAChH6CS56puNXd2LLsGwWYKkN
X-Proofpoint-ORIG-GUID: F0-9IuOAChH6CS56puNXd2LLsGwWYKkN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2022 at 05:10:53PM +0800, Yang Yingliang wrote:
> Fix the missing clk_disable_unprepare() before return
> from wm2000_anc_transition() in the error handling case.
> 
> Fixes: 514cfd6dd725 ("ASoC: wm2000: Integrate with clock API")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
