Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB584F6247
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiDFOy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbiDFOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:54:08 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFA60136C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:30:28 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2369gXSf007091;
        Wed, 6 Apr 2022 04:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ipm/ngHMypCesWys/XTa0OgI71t3t3hjG5sHl/IPXrk=;
 b=MS3ehJE+I5jkKUoSg8zUxweUJxNXtKR12L6XE/vZCBgoOovXNVIuLaRDld8uxChMvklv
 nbm7sy28ll+ZmA0NZbI5dvfIpxTwtyqF83CzESeo7Gyo2sm7YqMhgEJ6aDxF8oLKWpDS
 TnAa8W5FCETxSP3SmexLAvykSRRb7wEb+69ofx/9WE27f5OG3m5AyrYxXN1rKc+iIjPI
 1hMbCrbXRs16alZKDOw8okvQgEHhjyGBLMI/p3XqlQIh77r9Ge1m5w3GcfD0oLYGZxW5
 5MiL1UA5J9kqKvUfL9tyCNiUwETUeAHqFl3HBcp8X/68tRjgYk7WvOR4sET/fMotSbPh ZA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f6kw2d06h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 06 Apr 2022 04:53:56 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 10:53:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Wed, 6 Apr 2022 10:53:54 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0EDABB1A;
        Wed,  6 Apr 2022 09:53:54 +0000 (UTC)
Date:   Wed, 6 Apr 2022 09:53:54 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Kitt <steve@sk2.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, Wolfram Sang <wsa@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8731: use simple i2c probe function
Message-ID: <20220406095354.GT38351@ediswmail.ad.cirrus.com>
References: <20220405173952.2180743-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220405173952.2180743-1-steve@sk2.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: YkNeHWFXdysIDpp7KySJ9IqP0vEH1COc
X-Proofpoint-GUID: YkNeHWFXdysIDpp7KySJ9IqP0vEH1COc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 07:39:52PM +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
