Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8AC579FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbiGSNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239753AbiGSNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 09:40:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E793C13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:54:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JBSCu8020443;
        Tue, 19 Jul 2022 07:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=DSnN84I8id4pmT4ygtiuQTO7ZBfhQz7qlV9qScs+cCM=;
 b=a1calhPEyLeoQoMTnMQxbPLqUd348g1KDZUxs8AKLFY2X1ej3nVOmYHVIj4stJMxBjd1
 9pLDsP7cbj2Kcb+B935Xz4x2UjJh6YHLlkitufaBjJCP7csEBqgJgbJ1kL1l3SwpmxhI
 CN7YPU7ZBGNavEQi9XsWH5c1oP1LlB7xrEC/SC6Up2SUWDUIFC66P5xQErlStbvvJNn6
 5HtB15KtOa34ROrXGUdudUI1n57AACypB9pxP2FtVsf/71dPDBWWL18ZlaBCxxUCFSjy
 D2/c5vjv+kJDX+DDpL6vtmUG9gRk9WMxDu/o9k05ykAlr2gCTUfiVYJ0ZS3uQrfiFXJn VA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3hdrqfgas6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 07:54:04 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 19 Jul
 2022 07:54:02 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1118.9 via Frontend Transport; Tue, 19 Jul 2022 07:54:02 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 01914B06;
        Tue, 19 Jul 2022 12:54:02 +0000 (UTC)
Date:   Tue, 19 Jul 2022 12:54:02 +0000
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
Message-ID: <20220719125401.GA92394@ediswmail.ad.cirrus.com>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: UO-aPwDOQH2ADVJS1xfZBGySBHGBnbPm
X-Proofpoint-GUID: UO-aPwDOQH2ADVJS1xfZBGySBHGBnbPm
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 02:14:46PM +0200, Krzysztof Kozlowski wrote:
> Current implementation of regmap_field_write() performs an update of
> register (read+write), therefore it ignores regmap read-restrictions and
> is not suitable for write-only registers (e.g. interrupt clearing).
> 
> Extend regmap_field_write() and regmap_field_force_write() to check if
> register is readable and only then perform an update.  In the other
> case, it is expected that mask of field covers entire register thus a
> full write is allowed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/base/regmap/regmap.c | 50 ++++++++++++++++++++++++++++++++++++
>  include/linux/regmap.h       | 15 ++---------
>  2 files changed, 52 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index 0caa5690c560..4d18a34f7b2c 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2192,6 +2192,56 @@ int regmap_noinc_write(struct regmap *map, unsigned int reg,
>  }
>  EXPORT_SYMBOL_GPL(regmap_noinc_write);
>  
> +static int _regmap_field_write_or_update(struct regmap_field *field,
> +					 unsigned int val, bool *change,
> +					 bool async, bool force)
> +{
> +	unsigned int mask = (~0 << field->shift) & field->mask;
> +	unsigned int map_val_mask, map_val_mask_h;
> +	int ret;
> +
> +	if (regmap_readable(field->regmap, field->reg))
> +		return regmap_update_bits_base(field->regmap, field->reg,
> +					       mask, val << field->shift,
> +					       change, async, force);
> +

I think this will break other valid use-cases, regmap_readable (I
believe) returns if the register is physically readable, however
it should still be possible to use update bits if the register is
in the cache even if it can't physically be read. So really you
need to fall into this path if it is readable or in the cache.

Which does I guess also raise the question if your problem would
be better solved with caching the register?

Thanks,
Charles
