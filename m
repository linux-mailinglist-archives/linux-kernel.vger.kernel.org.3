Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0572A50DD8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiDYKGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbiDYKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:05:44 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1D1F608
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:02:40 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P6KC6N031455;
        Mon, 25 Apr 2022 05:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Z5YuVtU3yeCHJFHuOFw1Fh1OHZ3/W3ElUfaHLr4h05s=;
 b=l4OG3GyWOl/B6u5h5xayNavv2H4ks7yNFVIJbeEK025Ym8trfsJHEmOzgnPEocHHapth
 GOoFMazIiFFq7AMPSeWWw2afLJZzSXvHXGWZl0Pw4wqCmXiiMrCI5NohyuSK4jV+cx26
 u0N9WXuxFiIX6xCSbBdc7dOcjn3wqL6O9Ckmh9qyviyd83fBSmZNIcCBblhcSWfwR5WG
 oRqdgIbYx0qwp2hYp0yISRYaOAcqSp74Uim9FAdwrMS73Uh9xu9curbP/MoI1n+o0C3z
 GYaNfq5Xu7uyRsEYDgmLO1L4aL43jzLwA+MzYSDSURvbfEUqyKiJI0Kmoy6KurDQzmoT 7A== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fmev31rnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Apr 2022 05:02:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 11:02:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 25 Apr 2022 11:02:30 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 577A7B16;
        Mon, 25 Apr 2022 10:02:29 +0000 (UTC)
Date:   Mon, 25 Apr 2022 10:02:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] firmware: cirrus: cs_dsp: Avoid padding bytes in
 cs_dsp_coeff_ctl
Message-ID: <20220425100229.GU38351@ediswmail.ad.cirrus.com>
References: <20220425095159.3044527-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220425095159.3044527-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: FCrVFt3F1McrOxYFLs5iWCdjsCw45OTB
X-Proofpoint-GUID: FCrVFt3F1McrOxYFLs5iWCdjsCw45OTB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:51:59AM +0100, Richard Fitzgerald wrote:
> Change the order of members in struct cs_dsp_coeff_ctl to avoid
> the compiler having to insert alignment padding bytes. On a x86_64
> build this saves 16 bytes per control.
> 
> - Pointers are collected to the top of the struct (with the exception of
>   priv, as noted below), so that they are inherently aligned.
> - The set and enable bitflags are placed together so they can be merged.
> - priv is placed at the end of the struct - it is for use by the
>   client so it is helpful to make it stand out, and since the compiler
>   will always pad the struct size to an alignment multiple putting a
>   pointer last won't introduce any more padding.
> - struct cs_dsp_alg_region is placed at the end, right before priv, for
>   the same reasoning as priv.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
