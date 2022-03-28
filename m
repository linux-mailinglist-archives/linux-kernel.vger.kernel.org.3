Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D498B4E91F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiC1JyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiC1JyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:54:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB44F477
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:52:23 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S8AwhJ030875;
        Mon, 28 Mar 2022 04:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=OPCCfEOxSxc4F6/2g2ra5BL+qnE51JBOttEN9Gmrr08=;
 b=Gze6ubOBlOUPUwqoAaAkiINiEniBN1GwXwfojOXqdH6gV+RBw6llMYRYFf074xCipnaY
 dOTf/85uWryVD+yC2FZXv6bOZC3xIovl+w2MgbvRdNlrhMzc/DutJCuT61vvbLYCcwYm
 VNRo8TPtgGLGAC5CkkdxmN7N/kjSfeSAHVkBca23FJDmHQ+GlJN56SpYtpQLI8P03hHE
 Wt74uo0xxJJmeAKLmosDVu+5RRlFr2ZxjYz42PO8qIrOlTy8u01+MQYjqgcjt31K2vfA
 9g25EBOeX8wje0mZutzXjDhwbdqBOfTGHS3duHWHi9JPNxZJ/Naf9s19AiJIlYgDY5bE mA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3f2081age3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 04:52:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 10:52:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 10:52:10 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8505E46A;
        Mon, 28 Mar 2022 09:52:10 +0000 (UTC)
Date:   Mon, 28 Mar 2022 09:52:10 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Stephen Kitt <steve@sk2.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, Wolfram Sang <wsa@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm*: use i2c_match_id and simple i2c probe
Message-ID: <20220328095210.GC38351@ediswmail.ad.cirrus.com>
References: <20220325162515.1204107-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220325162515.1204107-1-steve@sk2.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: DEmKjIcPs1Wzj91A8oheLVMgf5aAknVv
X-Proofpoint-GUID: DEmKjIcPs1Wzj91A8oheLVMgf5aAknVv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 05:25:15PM +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
