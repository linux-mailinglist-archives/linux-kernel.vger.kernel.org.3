Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480454D2C42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiCIJig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCIJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:38:33 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B4322C;
        Wed,  9 Mar 2022 01:37:31 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2298h6MX031941;
        Wed, 9 Mar 2022 03:36:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/InPwi8jAKZ+siM2hnnrk2bIAROnKidpBMLsmg6Eass=;
 b=HeTr03wE90HGdUTB9YcKuUKkfu/6m1NooQt9gMGQC2S3uQO+sPak1YgfUoY/wh3kac14
 m1rVSZUv8xp42c2mt9xDXZXOG1hTSB2u8GQWzNyvdyEGtNuiCdELnTZmtui2IIoC+nPA
 wDsUJR8qrMK9hwO1B+qqT4hbpi924qFeORmQZ1J0Vgl15V9/RKAPbnY3rQV1W+NE+Iso
 1YecifcopQo29D74eWDj1jYm7zu+pgzbCi6WUf3ifiZkgCAU4RzaOu+ruCr4P966XhPD
 Wu8KR2ST8Pf2pDvabg2NNWroP1xX7GqLOXu/mH8Bw0ZpPPXCPRQuYka3+etKCoiPfJ9z cA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656negp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Mar 2022 03:36:44 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Mar
 2022 09:36:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 9 Mar 2022 09:36:42 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 56B2446C;
        Wed,  9 Mar 2022 09:36:42 +0000 (UTC)
Date:   Wed, 9 Mar 2022 09:36:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 16/16] ASoC: cs35l41: Support external boost
Message-ID: <20220309093642.GH38351@ediswmail.ad.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
 <20220308171730.454587-17-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220308171730.454587-17-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: jOGKrTjWPG07-Pl5HHQCB9c0mOLhvKCQ
X-Proofpoint-GUID: jOGKrTjWPG07-Pl5HHQCB9c0mOLhvKCQ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 05:17:30PM +0000, Lucas Tanure wrote:
> Add support for external boost voltage, where GPIO1 must control a
> switch to isolate CS35L41 from the external Boost Voltage
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
