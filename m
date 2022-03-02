Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D434CA49C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbiCBMQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbiCBMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:16:48 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111E39688
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646223366; x=1677759366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YkNuTe+8PZ/6/8YrEKTutkyx4YCQhxVnaPNLFEod86I=;
  b=P+456lb5QkKCh0n2iK/TcwGPfBOkxl3Nv7vS4R6eaCWeBHU/6ItpN+9z
   JHzhHcSOi+6mghayDFNF/STYkPnZYHs5KKIYVBPJePq25/mLQIsMdDWMa
   gssymddrS6xxmlnkUOc4GWK7etrQdQLbrshI3ubbcYVapBf5y2pITJAjO
   1opmNVhsMwtYlKiudgVkbRwU/38j7HR/fyYn+bdyW9UZWFt2vs+TgonaO
   8qN7WSWnFmB5PE2BK+Bfj5zdHodqKkQrfWMf3dpnQ50aiqrYzXh4pB3Bv
   2X/6e/xOGpAK3FyTh3BmJBNlGMrpAdaAW3fbImFQaUtsOht7fsRdYhul9
   w==;
X-IronPort-AV: E=Sophos;i="5.90,148,1643644800"; 
   d="scan'208";a="195256304"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2022 20:16:04 +0800
IronPort-SDR: IYeUyicRNM43jLmuy5fWTv2HEgFMZKN9CM60Q9sapJ23FRcGB+92Q2uUcXR1YI7WwCJ70yLMLU
 Q5zH7gsEXwVgWT+Bk/nnhhWzU8mKZ5ix581H+fro3AQWgv6kbGel3fgnC6tRtCtoPO+7hpMn7M
 /f+eK9+6QjhzEspHe8fcWTu9zAKOhjFXaqAWm56qUarX+ObSsAd8HwsSaV9OdNKYXfP6R/h8kQ
 hQ0OUrgs4P1XX8MZL+DIx30jE4xU8SMV8L2C8vIh0jO1nmMJ+XYXMoauRglsc2r7+ECcx/5VRe
 BI+4CG9pW84GiD5bhly+ec4U
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 03:48:30 -0800
IronPort-SDR: iDv1+joN40ZAn/VnAMqxJY3VtvIQmYUXa1849T677RBEMA1QTrESmvxf6Ymw2ZpEP7JeE2FP2B
 8FaYf0qH0XV51tlcDjn3JU0n7Kii9+4dM9JAMsnrRA67luYaHS5bdRtd45MKNgSpkG3EUxmkJT
 q828H22fBAYA0gGdfVrKcMwYZ0gx15YcIG9nHYx50M5LQ+rAhxCwIR4MQyHPZr1RuqG4Nfw0n5
 D9W/G5K03b0lJy3g34ubB5U3G4rbblZKteDEvILiyfoI/ihlat/B+YrhG+WpzConlJVgbgnNgp
 j+c=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 04:16:04 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K7tPb4qX3z1SHwl
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:16:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646223363; x=1648815364; bh=YkNuTe+8PZ/6/8YrEKTutkyx4YCQhxVnaPN
        LFEod86I=; b=A18M91TQuun88n3UaDl0mW9s5nh6V0SL6uu7gzt3IdjplJN838q
        R0LU1kpNHQ3FROzdd+CRR+x9sPvO+sIj55+dCa+OkKf8TO1XNStsZNxjd4uXHEac
        9uxSk/4M0nIQ8hcRn9tgNgdgzSGrW0I2EE43JZDewjz6Vq/q3xgptLAtCm0C5wFP
        Lw1VWF2rTN6CDXPnlDf3lRhpglBsH6Tz2fjIwsQhQ1ZLv55EPljR5Za01Uuv1hJE
        zBJYQV576ryNv42wI51sYcMel7/VQSIT0xqRYg9whnhgq+eZCqi05RDXZAKFqezZ
        iD8Tp8ndEOSP0gost/O/IADICJi3RJcNehQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z_SDcCq1iM_F for <linux-kernel@vger.kernel.org>;
        Wed,  2 Mar 2022 04:16:03 -0800 (PST)
Received: from [10.112.1.94] (c02drav6md6t.wdc.com [10.112.1.94])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K7tPY4NgLz1Rvlx;
        Wed,  2 Mar 2022 04:16:01 -0800 (PST)
Message-ID: <860a2e7b-22a5-787d-fe9b-c1e75d2728ff@opensource.wdc.com>
Date:   Wed, 2 Mar 2022 14:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <20220225172319.846891-1-mario.limonciello@amd.com>
 <76957c33-cb62-5bf8-bb5d-adf9d6c6ce95@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <76957c33-cb62-5bf8-bb5d-adf9d6c6ce95@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/01 14:21, Paul Menzel wrote:
> Dear Damien,
>=20
>=20
> I have a patch on top of this series. It=E2=80=99d help me, if you coul=
d add=20
> them to the libata for-next branch. Thank you in advance.

Done



--=20
Damien Le Moal
Western Digital Research
