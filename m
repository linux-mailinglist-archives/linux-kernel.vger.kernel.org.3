Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D64CBF01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiCCNl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiCCNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:41:55 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CB018A79D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:41:10 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AA1D028599;
        Thu, 3 Mar 2022 07:41:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Vl3tneYlwbsngFkHIV5AofOmVbNBXbn336jqbC3WcjA=;
 b=CUbjKy/HGb4QnC0EaFyFSDE1cVlwYFpu1kFLlWedBkLkgkEwUS9IyYalgJ0skZ06hbsz
 0IHiDgFl8c9k/B9XDGj6N3yUO4a34ieFGOFed07QGB5YDXv51Y0G6dp+u9c6cn6gJhtz
 J4nT7LR6gSFLKBsqrWkK879x2XHOpvpeI2z86XSFeXk+XHeH2sD+vP/PRgXcjXaPcYCR
 q0VlNdLtsGV9WG9SdAp9GVKFPt7ExgQbnma9HRMbs1jjfCXSDPZpVAgJqw9mVnPODbBW
 GJE7p8VMEUQrkjxz6jevo2ZW2ufxqw912U2Pk5M4QlZnkpc4PtRH+gCzp9ERotw1oJvD fw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8mds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 07:41:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 13:41:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 13:41:03 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5C42A7C;
        Thu,  3 Mar 2022 13:41:03 +0000 (UTC)
Date:   Thu, 3 Mar 2022 13:41:03 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
CC:     <sre@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: Handle error for wm8350_register_irq
Message-ID: <20220303134103.GQ38351@ediswmail.ad.cirrus.com>
References: <20220303093339.317966-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303093339.317966-1-jiasheng@iscas.ac.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: KJS23B2etGjPta3hzAACEFKNK19l18J5
X-Proofpoint-GUID: KJS23B2etGjPta3hzAACEFKNK19l18J5
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 05:33:39PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the wm8350_register_irq(),
> it should be better to check it and return error if fails.
> Also, use 'free_' in order to avoid same code.
> 
> Fixes: 14431aa0c5a4 ("power_supply: Add support for WM8350 PMU")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> +	ret = wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_COLD,
>  			    wm8350_charger_handler, 0, "Battery cold", wm8350);
> -	wm8350_register_irq(wm8350, WM8350_IRQ_CHG_BAT_FAIL,
> +	if (ret)
> +		goto free_CHG_BAT_HOT;

Probably be nicer to use non-caps for the labels, otherwise looks
good to me.

Thanks,
Charles
