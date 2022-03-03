Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32C34CC36D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbiCCRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCCRKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:10:52 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9DB17587E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:10:06 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22385YKu022391;
        Thu, 3 Mar 2022 11:09:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=sBTx+Sb/4DNav975t+tA9y9v878xAq0yu9TI8CLTbDc=;
 b=qmd1yQHrdxJjir+tgeUEtTYne1r1QkfzfXPZfiLmbyATWwvR5qfKmn1ju+237HM7GdH3
 y+UPjKGa61WBdwFF5Xax5HYDZy4aB84Bl7Pi5XOydD9r25g1Qq7HJdgIl0jlEYs0dNn+
 qCDDI6/y0tJJMCAVpTndzF6/r4S1ZeGJ9wmBKm8TG0DNqaWydEhtRcpBPMptpd+xn/6n
 4HxzbuZkPAVTmRNJ05jmyj+58mUtGeiQcWOuQ8wEyDl58HFFE3A1TFHuALi+c/mZsOru
 HkbqE7Ru4iOFIzgs1yK5AMWKV15iVnWWvP0T2CUwTkEf7E7Q8pwVX8Kp20D51Lxqq8sO bg== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ejsv20pne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:09:52 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:09:50 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:09:50 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EBEAD7C;
        Thu,  3 Mar 2022 17:09:49 +0000 (UTC)
Date:   Thu, 3 Mar 2022 17:09:49 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Simon Trimmer <simont@opensource.cirrus.com>
CC:     <broonie@kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Expand firmware loading search options
Message-ID: <20220303170949.GR38351@ediswmail.ad.cirrus.com>
References: <20220303155016.122125-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220303155016.122125-1-simont@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: SsBYKiKjvpqxnUz1WRs4hYWDISr14wwM
X-Proofpoint-ORIG-GUID: SsBYKiKjvpqxnUz1WRs4hYWDISr14wwM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:50:16PM +0000, Simon Trimmer wrote:
> The parts supported by this driver can have product-specific
> firmware and tunings files. Typically these have been used on
> embedded systems where the manufacturer is responsible for
> installing the correct product-specific firmware files into
> /lib/firmware. However, the linux-firmware repository places all
> available firmwares into /lib/firmware and it is up to the driver to
> select the correct product-specific firmware from that directory.
> 
> For example a product containing four smart amplifiers may provide
> firmware specific for that product and each of the amplifiers may
> have coefficient files containing tunings for their placement in the
> mechanical design.
> 
> This change extends firmware (wmfw) and coefficient (bin) filenames
> to be of the general form:
> 
> <cirrus/>part-dspN-fwtype<-system_name<-asoc_component_prefix>>.type
> 
> Where the cirrus subdirectory, system_name and asoc_component_prefix
> are optional.
> 
> New files will be placed in the cirrus subdirectory to avoid
> polluting the main /lib/firmware/ location. The generic name must be
> searched in /lib/firmware before /lib/firmware/cirrus so that a
> generic file in the new location does not override existing
> product-specific files in the legacy location.
> 
> The search order for firmware files is:
>   - cirrus/part-dspN-fwtype-system_name-asoc_component_prefix.wmfw
>   - cirrus/part-dspN-fwtype-system_name.wmfw
>   - part-dspN-fwtype.wmfw
>   - cirrus/part-dspN-fwtype.wmfw
> 
> - Qualifications are added to the filename so that rightwards is more
>   specific.
> - The system_name is provided by the codec driver.
> - The asoc_component_prefix is used to identify tunings for individual
>   parts because it would already exist to disambiguate the controls
>   and it makes it obvious which firmware file applies to which device.
> 
> The optional coefficient file must have the same filename
> construction as the discovered wmfw except:
>   - where the wmfw has only system_name then the bin file can
>     optionally include the asoc_component_prefix. This is to allow a
>     common wmfw for all amps but separate tunings per amp.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
