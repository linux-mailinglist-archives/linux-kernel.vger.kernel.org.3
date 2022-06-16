Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483654D628
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbiFPAfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiFPAfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:35:01 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C212898D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655339700; x=1686875700;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KS5uLEm7MNinRJDaJienPXh/fDbYItx8+PGMUuwNNNs=;
  b=YYGX4DwKXQEXu4lbUh2p6PvLXYYil84Rr5Fjo1EM4LqfvRUB3eQnoWPh
   aGeyp2yfugvJgmonaP9ZD8BxCsdY0z6iHZXG8oKZIgNWkv8+9hg0v5bWr
   Jp/OylAdD+SXe2XG1I8kZhrcPqoP73syYdymtQDPHJWvxlUf+JDeWS4bO
   /DLe6HjxnjZJa6BiEkC5X6W8ItIHDx/nZKR5dR4Hxziwe7RK8KOSjp+Gj
   sklCP0CtTUiQ7tH4+lv40H0ibZpdVF2C7LQsCl9bXIImJe/YsgohWb3W9
   zQbU7lPTln4TN5OCEMznRpcq+gotkPrUR4CWA7/UrdgZcHZaythJQOaPT
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="203274525"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 08:34:59 +0800
IronPort-SDR: W60rhDafPdg/SMBXdozMH7r6dWww9ENmwR0nav36gVtXsCbOuXg903kDdYYZmddQGjPSjxaSdM
 HTUIK8PtiPij1qW+sLlGnaA+ifszxi2l7+PpNYIw7O0wsGwUloHYLDQHKWItI0/n5d1TAzl/R9
 sjQGXbSq7czZ5OA+A4Kua3vLEzOXSGxLtej8h9LfGz155qJOP7E1/V0PcNdcNynBiavUWTaYpw
 GN9FfcKwgmOnCKxaYBBe/kQpZp83Q29iFb2CQ6MW4H04Ibap6LXL/Ca8w4r9Zv5rcZGx0vOIeS
 QVxE7ZlBLk7wUlJTNsjmNrAU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 16:53:22 -0700
IronPort-SDR: fjdGzWcCx0v7IHlWBXaWZOev6EY2A8OLPxBDelBln8kn96Tl/KmjY//EIvhn0RpWVrqGhjsxPI
 /47J+TvDkb/ffGTqLdJvtcdoXHmcKTkjIJC9ZmPAinhx6Fvm9tiuO4jNQKHOxt2PWTRL08r3xH
 kUrtx3XIiAOaiFEEcflPn70TemhSUpwS/0wxTMk8OPGwFPitgRGvbKaUOwZhVOeJCVRDZELWD2
 9WOnMNTEkrJk/m+BTfMUERoIVqurFNBrglcs98oWfW40xbwD/EHk6uD2CmZLnmcDIn9n8WZVaS
 UGM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 17:35:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNjql1nwYz1SVp1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:34:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655339698; x=1657931699; bh=KS5uLEm7MNinRJDaJienPXh/fDbYItx8+PG
        MUuwNNNs=; b=RiM6WqT7AHdiwKBJPsC+op3gcAmu0GTj/oKDLszzx1P0UtL2ilz
        aWgfIOmFWtOX/bMCl9TIw0BDLHggYcZwfhNl3/MOggs3MQuiCjC/pjxOyesUcGFw
        ANedf6OkAN9QeBSzd06B2bMwbB0RKFiCpM0YTl2EBcUEifg9ikMfUEtFsLDfCh6M
        5clI7Fk0cQBKlpaq319qkLu3olEc+OAJupC1cggJS900CEiEqv5M/NPgKXCCUb/S
        8euy2HXKBhUyIcOnW8kBW5Ydd7KinQhHg4cgMs1AtCh1XZKrZzS0/54uTqHIeb0Q
        AMPpW8LdTDG+voTtsj0Yz0C3lOcqfRBJBEg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i6f88CE6SYPP for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 17:34:58 -0700 (PDT)
Received: from [10.89.84.185] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.84.185])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNjqj5zhrz1Rvlc;
        Wed, 15 Jun 2022 17:34:57 -0700 (PDT)
Message-ID: <6082771c-6bf7-bb34-4d2c-5199024dc4cc@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 09:34:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616001615.11636-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/16 9:16, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
>  include/trace/events/libata.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index d4e631aa976f..6025dd8ba4aa 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -288,6 +288,7 @@ DECLARE_EVENT_CLASS(ata_qc_complete_template,
>  		__entry->hob_feature	= qc->result_tf.hob_feature;
>  		__entry->nsect		= qc->result_tf.nsect;
>  		__entry->hob_nsect	= qc->result_tf.hob_nsect;
> +		__entry->flags		= qc->flags;
>  	),
>  
>  	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s status=%s " \

Doesn't this need a Fixes tag ?

-- 
Damien Le Moal
Western Digital Research
