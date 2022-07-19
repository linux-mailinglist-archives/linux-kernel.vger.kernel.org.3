Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1AF57A13D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbiGSOVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241195AbiGSOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:15:23 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E879F72BEC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:43:00 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JBQGF5017217;
        Tue, 19 Jul 2022 08:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=1iHcTYklM2n0jgLIgnKXAIqlrCeQtsoN+7ckvKvL4qs=;
 b=XGSiDLoU/mlSIQR+TSb0PRrfbM+GLI8zwV8/oopuG9KkteqEvuRdRcpj+MZ1Fad/qS3S
 60mvw2/9429givTRB+NWffWhzNs4/8+QELWfk3X53dQXtaeS1KzXtM3A7cv1gEkLJkRB
 U1Cvef/XbwXCbMjvGgyXZ3ZcaR681MosuzzW3x3fZ/p2/lxZdEdW+kf6aO2vwP0tuKoH
 21RdGsg8YF4vUy2j7a8s/YzqWbEfJ2nc2ybWgxYgOvLboAHRNqPjR7SW1O/omocDL+Sf
 3wyc7yloPggKuP0zKAcdw3DeJyz2BhfeF6GLz/2fOtiM0MNKXGcqR01A61WUKda/9kTq Pg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hdrqfgd8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 08:42:53 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 19 Jul
 2022 08:42:51 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Tue, 19 Jul 2022 08:42:51 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 57048477;
        Tue, 19 Jul 2022 13:42:51 +0000 (UTC)
Date:   Tue, 19 Jul 2022 13:42:51 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Message-ID: <20220719134251.GB92394@ediswmail.ad.cirrus.com>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
 <20220719125401.GA92394@ediswmail.ad.cirrus.com>
 <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: JNOgdpDeByc8GS1rmj71ADqVrXMhhYcN
X-Proofpoint-GUID: JNOgdpDeByc8GS1rmj71ADqVrXMhhYcN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:13:11PM +0200, Krzysztof Kozlowski wrote:
> On 19/07/2022 14:54, Charles Keepax wrote:
> > On Tue, Jul 19, 2022 at 02:14:46PM +0200, Krzysztof Kozlowski wrote:
> >> Current implementation of regmap_field_write() performs an update of
> >> register (read+write), therefore it ignores regmap read-restrictions and
> >> is not suitable for write-only registers (e.g. interrupt clearing).
> >>
> >> Extend regmap_field_write() and regmap_field_force_write() to check if
> >> register is readable and only then perform an update.  In the other
> >> case, it is expected that mask of field covers entire register thus a
> >> full write is allowed.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >> +	if (regmap_readable(field->regmap, field->reg))
> >> +		return regmap_update_bits_base(field->regmap, field->reg,
> >> +					       mask, val << field->shift,
> >> +					       change, async, force);
> >> +
> > 
> > I think this will break other valid use-cases, regmap_readable (I
> > believe) returns if the register is physically readable, however
> > it should still be possible to use update bits if the register is
> > in the cache even if it can't physically be read. So really you
> > need to fall into this path if it is readable or in the cache.
> 
> But what type of real use case this would be trying to solve? Either
> register is readable or not. The presence of cache is just optimization
> and does not change the fact that we cannot read from register thus no
> need to go via updates.
> 
> > 
> > Which does I guess also raise the question if your problem would
> > be better solved with caching the register?
> 
> And how the value would appear in the cache? Since register cannot be
> read, I expect the cache to be filled on first update. First update
> would be read+write, so we are stuck again.
> 

The cache is initialised from the defaults table, so normal
proceedure for unreadable registers is you start out with the
hardware default and since you know when you wrote it the value
stays in sync.

Thanks,
Charles
