Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF91C4F6054
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiDFNsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiDFNr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:47:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9E3C8101
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:04:29 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2366Aowd008097;
        Wed, 6 Apr 2022 04:54:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ZWtYtEP6ksjFQqnyEmmOpZ3NxAIAdcKEON9VScCRpts=;
 b=kS8JququnS/P433jjj4yjCHo3EvYeF/l6X80KjiVJ+H48moB8mHAU6LHqBwAC3eSlFVf
 mSUvu3vyqMiKN7FcJLCq1+baEy7bOAXI6B3m3mxE0SL9dEuatMUoNEaZfE6XB5qplrOh
 y6ppnN5EFutCLbuJ1Lri4ovPNYVNSGqozOdoPPT8kTUSYjRgNLKAk1W8HNNhuoN7yrZl
 jpa6BXX+E0FkWYtaie8TxKyaBBuQ/dZzoqVXjmVB57Tpx33o69zBda70L4Vs1ULYLMkp
 cVP7VM0e9d9CNM1rGg4F7B4g4C/Q6Yys7y2HSt5ohwU2W4H5whtTaUZPfVMe0IEr/g8D Wg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2d06t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Apr 2022 04:54:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 10:54:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 6 Apr 2022 10:54:22 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 095912C5;
        Wed,  6 Apr 2022 09:54:22 +0000 (UTC)
Date:   Wed, 6 Apr 2022 09:54:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Kitt <steve@sk2.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, Wolfram Sang <wsa@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm*: use simple i2c probe function
Message-ID: <20220406095422.GU38351@ediswmail.ad.cirrus.com>
References: <20220405122411.2096387-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220405122411.2096387-1-steve@sk2.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: J7OSmPskFQrUtpATmrtUgfaSwannSLbK
X-Proofpoint-GUID: J7OSmPskFQrUtpATmrtUgfaSwannSLbK
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 02:24:11PM +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> wm8731.c is excluded and will be submitted separately.
> 
> This avoids scanning the identifier tables during probes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
