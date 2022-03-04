Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0932A4CD1E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 11:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbiCDKEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 05:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiCDKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 05:04:01 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D740652C7;
        Fri,  4 Mar 2022 02:03:14 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2245Ulvb018989;
        Fri, 4 Mar 2022 04:02:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/fHFiGE2UgcbICzvteVz8HdkQH7m5kkhBu6ZmDHQErk=;
 b=EL4qoVndQtUku7OA38zzwGZx8cGDEFvsjMaq4+mQYqAQZ6S+zohDl/CQMDuMnAk2SPz6
 xjviRLnK5r/NEUFZt3Xi2jcGggEDw8PC408Lfw4ZMRZLcv/uLFTFxeIrCSg2f47kJubs
 66ej86LZowSdMU+KZidLlzJ/CK3FwTcMzxTge0Sunzw9UWfoLFxsiai2TTkT6Kfx2rPv
 UsuX62QISDExBXcuQex9J5XDok65otCteoMpn7cqIdVPUZwozjWsuBl4AB1I+eIHkdhE
 2sxsSaQXYKdSeFEn6qGDYw+vBX882TncG68f0wkgWjB0ikItksy5GIqq1XYRPNfgOHun dQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ek4j1rs52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Mar 2022 04:02:31 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Mar
 2022 10:02:29 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 4 Mar 2022 10:02:29 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9A0AB7C;
        Fri,  4 Mar 2022 10:02:29 +0000 (UTC)
Date:   Fri, 4 Mar 2022 10:02:29 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lucas Tanure <tanureal@opensource.cirrus.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/20] ASoC: cs35l41: Fix DSP mbox start command and
 global enable order
Message-ID: <20220304100229.GY38351@ediswmail.ad.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
 <20220303173059.269657-4-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303173059.269657-4-tanureal@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 9gXXiq8gVPtNH8vfxdGQgA-V6iLqwbls
X-Proofpoint-ORIG-GUID: 9gXXiq8gVPtNH8vfxdGQgA-V6iLqwbls
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 05:30:42PM +0000, Lucas Tanure wrote:
> Global enable must happen before CSPL_MBOX_CMD_RESUME command
> is sent. Move it to PRE_PMU as both events use
> SND_SOC_DAPM_OUT_DRV_E macro.
> 
> Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
