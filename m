Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F9B4D4F79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiCJQmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJQmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:42:16 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1305918F23D;
        Thu, 10 Mar 2022 08:41:14 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22ACrQ0b029203;
        Thu, 10 Mar 2022 10:40:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=message-id : date :
 mime-version : from : to : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=xt9jZcsbIc3uRwCBEAO7UWcKQ/BRR3pjfdwtdFoPCvo=;
 b=MjCm65YBhjQqTx8nYg+XemIJG21ENMfZDKNF82HZUvyie42dm4Tto6XCSdtAqXaG/gGR
 Y37IMrZSJW1VmAffmhfa11aJaSCw6snjw/2B3J4bEUvHbhhBm3oDJjNknxsy4fo+uiiy
 n0QshAZt42LCTjiBBsMhmH33LHsyTyJSWhqvljEtLnSJZrSWJ+YW/T/IKCFbehZTmEGk
 R96VroBI3R0z60hC0uANrIgennXgwTHE0JzmWg6oZL+TUIxH88P7dBX4VwxkAr157yYJ
 ik1yQtQiq9gKUyl/oM3akj/pey3qQ0hGxltaSM+YLftA9XF3NscxkTHVA4zyH99DMzE1 mw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3em55sybva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Mar 2022 10:40:47 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Mar
 2022 16:40:45 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 10 Mar 2022 16:40:45 +0000
Received: from [198.61.65.38] (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 551EBB16;
        Thu, 10 Mar 2022 16:40:45 +0000 (UTC)
Message-ID: <fa73e75d-9500-43c5-5697-b86a5fb594a0@opensource.cirrus.com>
Date:   Thu, 10 Mar 2022 16:40:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   <tanureal@opensource.cirrus.com>
To:     Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 01/16] sound: cs35l41: Unify hardware configuration
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
 <20220308171730.454587-2-tanureal@opensource.cirrus.com>
 <s5hbkydgbx2.wl-tiwai@suse.de>
In-Reply-To: <s5hbkydgbx2.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vG94vteHVVNXs2KSuFkG7uoGHw8T7SbI
X-Proofpoint-GUID: vG94vteHVVNXs2KSuFkG7uoGHw8T7SbI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 1:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 08 Mar 2022 18:17:15 +0100,
> Lucas Tanure wrote:
> > +enum cs35l41_gpio_func {
> > +	CS35L41_HIZ,
> > +	CS35L41_GPIO,
> > +	CS35L41_INT_OPEN_DRAIN_GPIO2,
> > +	CS35L41_MCLK,
> > +	CS35L41_INT_PUSH_PULL_LOW_GPIO2,
> > +	CS35L41_INT_PUSH_PULL_HIGH_GPIO2,
> > +	CS35L41_PDM_CLK_GPIO2,
> > +	CS35L41_PDM_DATA_GPIO2,
> > +	CS35L41_MDSYNC_GPIO1 = 2,
> > +	CS35L41_PDM_CLK_GPIO1 = 4,
> > +	CS35L41_PDM_DATA_GPIO1 = 5,
> >   };
> 
> So CS35L41_MDSYNC_GPIO1 is identical with *_DRAIN_GPIO2, i.e. it's an
> alias?
> 
> 
> thanks,
> 
> Takashi
> 

The value 2 sets GPIO1 as MDSYNC pin and GPIO2 as IRQ pin (Open drain).
It could be the same label, like CS35L41_GPIO1_MDSYNC_GPIO2_IRQ, but I think separating them is better for understanding the code and organizing the code.
