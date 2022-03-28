Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD24E97A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbiC1NNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbiC1NNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:13:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3201001
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:11:39 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22S897pb025877;
        Mon, 28 Mar 2022 08:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=z2lM6O7vGhTvwrKdmAeXIfKrAC85LExsDuP6+CYz1kU=;
 b=M/+80Apj4BzVfxM54IgAVjzRX6c51VJa0gZfOwGpD11pqJVHOiDadYbJNek5ef1IsYMt
 XfXVQSxjfrQILZrkoBRKLIfKhXOzeLHtC4TdJi/LoMvT3+13VuEXNTBu2gYKAgBTCPV9
 ImPSHj7dpAM/m271cnQSgSpvCIYV2lpeAUdh79q9Qm/9JsB/ApXs7aCu9IMUMGdgsESq
 PboWzvHoWXW38Qt6lLAbfUu4gOkhqYgSWD62ma5VaYXhit1ALmNdNprbiLa90+JSOqgg
 qsAq2AA+eL14rXPYXzZ2GQk9pgAFcAS3Aj3Q/Uj60UV6WzsfpukhDZjQMcZboTiSsutm ug== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3f1y8pag9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Mar 2022 08:11:33 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 14:11:32 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 28 Mar 2022 14:11:32 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 11E24B16;
        Mon, 28 Mar 2022 13:11:32 +0000 (UTC)
Date:   Mon, 28 Mar 2022 13:11:32 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regulator: wm8994: Add an off-on delay for WM8994
 variant
Message-ID: <20220328131132.GI38351@ediswmail.ad.cirrus.com>
References: <YkDpozx+ZmSWwwH0@sirena.org.uk>
 <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Ww6RZjcNHMZfZmcPqvt_gjr_tkMgo-I0
X-Proofpoint-ORIG-GUID: Ww6RZjcNHMZfZmcPqvt_gjr_tkMgo-I0
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 06:01:54PM -0700, Jonathan Bakker wrote:
> As per Table 130 of the wm8994 datasheet at [1], there is an off-on
> delay for LDO1 and LDO2.  In the wm8958 datasheet [2], I could not
> find any reference to it.  I could not find a wm1811 datasheet to
> double-check there, but as no one has complained presumably it works
> without it.
> 
> This solves the issue on Samsung Aries boards with a wm8994 where
> register writes fail when the device is powered off and back-on
> quickly.
> 
> [1] https://statics.cirrus.com/pubs/proDatasheet/WM8994_Rev4.6.pdf
> [2] https://statics.cirrus.com/pubs/proDatasheet/WM8958_v3.5.pdf
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---

I can confirm the 1811 also doesn't mention the cycle time in the
datasheet. So that checks out.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Part of me wonders if we should just apply it to 1811 and 8958
anyway, I suspect they have the same IP for the LDO and its just
the datasheets never got updated. I had a go chasing the apps guys
here but we are a little short on people who remember details of
these parts. So I guess we trust the datasheets for now, unless
you have any strong feelings, Mark?

Thanks,
Charles
