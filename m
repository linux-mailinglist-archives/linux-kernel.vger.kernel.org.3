Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668424CBED5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiCCN1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiCCN1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:27:11 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA64188A2D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:26:24 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223CnFvX023911;
        Thu, 3 Mar 2022 07:26:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=5c4pTCYuRwuOQvexSJv3ZrY0ewqsjXzHl0G2qACotPs=;
 b=ktLkkAp6nXn2INvSuJdOhCT66XzVi6mh4Oaq8efaNQOwmUs1N7LtAtm/LBaZQbSNuKj0
 a2nlpOpyFPW/iJFMO1plapl3ssQAIzDeAOM9taKv2H+wEVG0VwW5Kg4fFAnE8xYVjWgf
 XuB9VFr44ou5zd4Q8xRO0cBk8JhIjX2cIVrEwSScLXj2az0+8q6q2fKWJUWECczCK95+
 9RfP4AVo0FftwE6zkbhh+MJrG0ap+DnWGItxngJ4VSwVog7DKmWIKHOZtBGgdY2tagFt
 fNnfA+h8ntkvTDUkCBoqIs1gCahOP06iUOH/7BX9yVAkqA2S59RzoS/fZjeREPFuoyuX kQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ejsv20bys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 07:26:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 13:26:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 13:26:17 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3BD4D2A1;
        Thu,  3 Mar 2022 13:26:17 +0000 (UTC)
Date:   Thu, 3 Mar 2022 13:26:17 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <sre@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: Add missing free in free_charger_irq
Message-ID: <20220303132617.GN38351@ediswmail.ad.cirrus.com>
References: <20220303094322.342569-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303094322.342569-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 78xQPOv72v0n1v4wGd3ez_R9RUHigCRX
X-Proofpoint-ORIG-GUID: 78xQPOv72v0n1v4wGd3ez_R9RUHigCRX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 05:43:22PM +0800, Jiasheng Jiang wrote:
> In free_charger_irq(), there is no free for 'WM8350_IRQ_CHG_FAST_RDY'.
> Therefore, it should be better to add it in order to avoid the memory leak.
> 
> Fixes: 14431aa0c5a4 ("power_supply: Add support for WM8350 PMU")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
