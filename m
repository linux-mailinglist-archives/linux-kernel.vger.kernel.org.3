Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A888650AC15
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442627AbiDUXox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442612AbiDUXou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:44:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F5E65D4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650584518; x=1682120518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6VjHqbVwWhUfXX9jLz8xlfmJRICTMPmX0u83Z3Qbkqg=;
  b=Q8ZCXbg5NqFTweAc1hFCnV/QEQPYXbEvLWeOzod+VCNIOdTWTI2YHJ8O
   1hRATK2NJfGlS3XbW/QvoAD9HuNQWennWpIfLvXSTETWNnpoFucLKSLje
   msoVbJphPegbsAG8ph6FCbnnugmXAZxMZ1MUJzPkWDL8fs/47jamPtYr2
   zad+VfYWaMyjRW36vHNCKHzkN8oFqmibHxUMnPqfaeQGm1MrG7IqSndst
   eB2BXV2xTSo2/yMeQYWTjpyfGPRzCy6OcqsENpZl/Q1EPD95XrQyRipI7
   GCclZK+3WrhtYZV4huyH8methaSZjPbM9viRgIFtgJa+w5eZ+E7tdajDk
   g==;
X-IronPort-AV: E=Sophos;i="5.90,280,1643644800"; 
   d="scan'208";a="198510226"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2022 07:41:58 +0800
IronPort-SDR: fVKpMhs0p1zBIK+EIyGL4BQ+ZYTNtLT6u60hoIIg1cfsxjilRSIHX0OcaTrYiAhROczTjv7GEh
 Qi4BrImNNJRiGlPFw/1lJxFl5QTk/knGYDZp3oSu0H15Hu8zXWcG3/d3xJyGxQMiWUissKl1m7
 6AmB4S49kBM7XHgius1vcJYA1XoqMr/bO16OuUOOf+UMXhjFGi/I22ApenM4pW5wz/DbNLpddv
 exNSfN/G5M/cW4HcUmDsFjGIMGBkF3ZBUjC3mY+7lLRZLpipQepPkSfztcqTgneHXwX0IwvV/n
 focYSfa3prPrZMepTP9r4tPq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:12:16 -0700
IronPort-SDR: h6dBg1YjfIFdGdFlbEMm8ayWLYNOy90w01JfpHnR7MP9263rfW5y9dcf9ClnUA0b8uUfWTXVj8
 rDdd/W1BJDRp1UGRmpVF4NTbCCo3oixscXIeKETGU13IyFZbyvSb6D2imdWKhPf2kP3H3dAiAF
 g/B78cxH96si0S8mGWLCx+jIN14RF38YtDde+IAIBP2woKmRNQEXGdtsMi2V0cHPiIJLpbTwk9
 N4EAZsLPgRTd2GsLsI76Thp4dazarurJ+/oWISsJVPoy2d6KoGv5ShW0aLDsFBq2QitC4GaYyT
 QSk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 16:41:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkvFz0Vttz1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:41:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650584518; x=1653176519; bh=6VjHqbVwWhUfXX9jLz8xlfmJRICTMPmX0u8
        3Z3Qbkqg=; b=XFuIfxcPK795pKDoH8MycvbUN86JqBVZxEzRq3TYyV2PKdvf8um
        con/ZHDoTrBz69LwXPNzdLhH71LaDNLjhEx6NkLIcfyx2UPEt/NTObFQQ6ocX75T
        eIbp79esrnzYVTsyaCTWoPyMFmR3H14dlg01QaaUZsa+Ikax1le4fA53ksFMQLgK
        KXLtCa7zF0nTLm7P2mPPnzq7fLpcjejN7isTM2ihpbOCvYFgWjBBfEarua5KIdE5
        Pl0sUfa7bp8J+MfhG923KrKxcHOZ1rN/03QbypnKNwYbFyu3uPaVrIPt5qqK0hL4
        Y0WLGzyC64VfvQpZPPheHi1xmgm4m3QGCPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XMC_yjnxLvrv for <linux-kernel@vger.kernel.org>;
        Thu, 21 Apr 2022 16:41:58 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkvFx5vHxz1Rvlx;
        Thu, 21 Apr 2022 16:41:57 -0700 (PDT)
Message-ID: <48a77e02-7eba-6361-7d89-534b9f03da14@opensource.wdc.com>
Date:   Fri, 22 Apr 2022 08:41:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ata: Make use of the helper function
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     cgel.zte@gmail.com, linus.walleij@linaro.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20220421084412.2615081-1-lv.ruyi@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220421084412.2615081-1-lv.ruyi@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/22 17:44, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Applied to for-5.19. Thanks !

-- 
Damien Le Moal
Western Digital Research
