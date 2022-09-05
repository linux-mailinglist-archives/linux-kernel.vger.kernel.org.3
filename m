Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0055AD038
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbiIEKff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiIEKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:35:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7120F43
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:35:28 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2855wec8006069;
        Mon, 5 Sep 2022 05:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=KdQsKPkmzzna+66ZNEVg4limEcdND9IVkdx5GyLXL0Y=;
 b=SEbfUku9x7l9LuazcQeJc8IcuX6YQaamzRINoJt+eYnrOVYM/Pn3jFh1LBKGoAFcoJMW
 rmtQMu/YYetaxjp82ymkuTEUAp9sKy7x0NDfh1HYjpAcYeA8dNpAwNTsMbq6s9phMOIy
 xWVugVK43jtdZXfy4JRHyKcRiO9WRbFKG/AX8DpDFhJdtK6kMy7DAwadYDU9tdRvsOJZ
 TU/U8zNEbRCAdUYDcOkrMpgE8ENL1tvgWqCMTpUNw4B+jupHrDTtq3si5X6WQBF0jTja
 jtqZWP4mX+E+brGAanaPjz1GiMjmpzQHyqjEjqXhHcuH7+ZGDRL/UsZJybxKRSC8Q5wy mg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3jc4b29uxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 05:34:25 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.12; Mon, 5 Sep
 2022 05:34:22 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.12 via Frontend Transport; Mon, 5 Sep 2022 05:34:22 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BE1BB46B;
        Mon,  5 Sep 2022 10:34:22 +0000 (UTC)
Date:   Mon, 5 Sep 2022 10:34:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Vlad Karpovich" <Vlad.Karpovich@cirrus.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH v2] ASoC: wm_adsp: Handle optional legacy support
Message-ID: <20220905103422.GP92394@ediswmail.ad.cirrus.com>
References: <20220825220530.1205141-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220825220530.1205141-1-cristian.ciocaltea@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: SSupwDQyn-zFDGAWTJbr5gdZlcA_Akgv
X-Proofpoint-ORIG-GUID: SSupwDQyn-zFDGAWTJbr5gdZlcA_Akgv
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 01:05:30AM +0300, Cristian Ciocaltea wrote:
> The tracing capabilities for the speaker protection fw enabled via
> commit c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker
> protection FW") are not be available on all platforms, such as the
> Valve's Steam Deck which is based on the Halo Core DSP.
> 
> As a consequence, whenever the firmware is loaded, a rather misleading
> 'Failed to parse legacy: -19' error message is written to the kernel
> ring buffer:
> 
> [  288.977412] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Firmware version: 3
> [  288.978002] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: cs35l41-dsp1-spk-prot.wmfw: Fri 02 Apr 2021 21:03:50 W. Europe Daylight Time
> [  289.094065] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Firmware: 400a4 vendor: 0x2 v0.33.0, 2 algorithms
> [  289.095073] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: 0: ID cd v29.53.0 XM@94 YM@e
> [  289.095665] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: 1: ID f20b v0.0.1 XM@170 YM@0
> [  289.096275] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Protection: C:\Users\ocanavan\Desktop\cirrusTune_july2021.bin
> [  291.172383] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Failed to parse legacy: -19
> 
> Update wm_adsp_buffer_init() to print a more descriptive info message
> when wm_adsp_buffer_parse_legacy() returns -ENODEV.
> 
> Fixes: c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker protection FW")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
