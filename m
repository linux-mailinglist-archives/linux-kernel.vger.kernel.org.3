Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902CC512F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiD1JLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344447AbiD1JLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:11:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A7A5EDD2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:07:59 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S85tWM016496;
        Thu, 28 Apr 2022 04:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=qelkuXXhI7j9+bgOOt/afSN3KCYXxCAlz6N2wmeGKIw=;
 b=GQ4B3y14y2EK/kFXganY54q3e8Li5dqA47V23JKUE4ykUwxZ416fLL2fdKL4CK2xQ080
 i9SRkr2I1AGdBWebYXTvbplHsgJhEYOxjoEXbFbVYs5+8EtuA09asI6gX/0Mh6dcw8Nh
 KQdkIXegs379TkSzZDaAmF9hnIf/EhJvoX6isWi9NPjPp1kKERFSHpoYWfxLfcob+TRU
 4eRpFF7ohwLjToCQTXW+DnjtK1IC9hNa/9cqtTeV/PJf6fcGz0jJbLPAMQxxZiMyndsd
 a/ivvWWjkFTtkDPpwu07D+CrpuUscwVLSPqEaN/G/3NrjZBPw08CmGl7YWVObziFHFuW 7Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3fprtb1v8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Apr 2022 04:07:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 10:07:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 28 Apr 2022 10:07:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ABC8946C;
        Thu, 28 Apr 2022 09:07:10 +0000 (UTC)
Date:   Thu, 28 Apr 2022 09:07:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: Re: [PATCH 07/26] ASoC: cs35l41: Move cs35l41 fs errata into shared
 code
Message-ID: <20220428090710.GL38351@ediswmail.ad.cirrus.com>
References: <20220427150720.9194-1-vitalyr@opensource.cirrus.com>
 <20220427150720.9194-8-vitalyr@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220427150720.9194-8-vitalyr@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: qOq2t3v99asS5a4Cp8ufLVpzTWToPi9V
X-Proofpoint-GUID: qOq2t3v99asS5a4Cp8ufLVpzTWToPi9V
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 04:07:01PM +0100, Vitaly Rodionov wrote:
> From: Stefan Binding <sbinding@opensource.cirrus.com>
> 
> This sequence is required to setup firmware, and will
> be needed for hda driver.
> 
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
