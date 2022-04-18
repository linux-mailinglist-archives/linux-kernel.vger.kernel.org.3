Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9785650588C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 16:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiDROF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 10:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiDRNso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:48:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B525933A01
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 06:01:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23IBd2un027093;
        Mon, 18 Apr 2022 08:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=0XOMCRsLJEli4pwqJVwSkmm9Imnsr07cAJCh8WzK9BA=;
 b=cHG6J304RS/6msPYoGsVj9ki7BY45Y/QzSGz7QcvCyv8ivwtGCIyS78Tol+GeP0WA17G
 a9Z5o0MeSBuIb8UUmVkujtvtGm1D22SRnMoyJcMcRdW7G1sQL7SFXXSs7XOb2mTIDuV5
 rHkTzgLeUDyBny+8nr4T/OR4Zh8RXDBqLH+2BiREMd9jUG0QB8VJa11c3Uje5G+wN7SU
 +fCzXmO8UpFDT/ty6LnaHqWQnsKZBg3s+s54dYE6FuSldyHINPY0Ehv4woDoUpWpZ0Q5
 n9k/yAd2g6SOFMeELd012kZ6HoQx/adWeJSNN2ADFSwXES8bigHAneNk2ic+acyBeYKG tA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3fft7msvf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 Apr 2022 08:00:58 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 14:00:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 18 Apr 2022 14:00:54 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 46FBAB10;
        Mon, 18 Apr 2022 13:00:54 +0000 (UTC)
Date:   Mon, 18 Apr 2022 13:00:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <cgel.zte@gmail.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] ASoC: codecs: wm8962: using pm_runtime_resume_and_get
 instead of pm_runtime_get_sync
Message-ID: <20220418130054.GC38351@ediswmail.ad.cirrus.com>
References: <20220418110259.2559144-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220418110259.2559144-1-chi.minghao@zte.com.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: PsQS2BgAoLINJu4Xj1w7dDtiBR0lPfp-
X-Proofpoint-GUID: PsQS2BgAoLINJu4Xj1w7dDtiBR0lPfp-
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:02:59AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
