Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA9F5798BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbiGSLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:45:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79330E0F8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658231141; x=1689767141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HoB6mNAGD8qprJcACnGtFLQCTHjRhxeUO8i/3z716MM=;
  b=PYEk0WcxkxOO88/L0Z2FftSqMA6rXQ8+MLB/tRwt98UcZjieqGXiNEsc
   3/JWfHJCRd9ogVmFaQf66ygTQpBDNWDw85sP0dcJDYWYAMXv2ZJU/0vsq
   HfC8gYMerKtmytFF6lc4oux5yu6TrpItGuo8QaukGELmQlIlAc03ClcDy
   JORmHtCbD8RVCnyXwCzwY6pTnv1kwtHz3ryfihd+g5M/2xTUVxSqLxs8w
   +sgZEku2+ktZ6nMYMs6vsWsgceYI92yavibRqUQ82Zxl9Nq+KPJHKertd
   g1uVD6h3trLN+sDYuo1JOp2lrNIYqSUpKKWZrMuvsguPQvS6GkezEnTof
   A==;
X-IronPort-AV: E=Sophos;i="5.92,284,1650902400"; 
   d="scan'208";a="310657184"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 19:45:39 +0800
IronPort-SDR: 6tfmzZ6IuthX6ogYvaQqbZg6UjTASBZOhukABDlmFLQrfQ01tD16qdKPak0t/QmFTwUxku1foV
 pBoT9kda+1fQi8ncQgugDCs2UJj+H039NbElIs3HMNcvFtPARF0ZH8CIpst12iwL/laL8Ww+m4
 Is7skO/kxEESzMV++DbQVIzlf961hjS4yVMYDzi2akXdcTHTPZITxWHB1tWkBwdkK2P5HvTkm3
 U204B8Zf42s2XNXePLGFP/E7RJnppQvGbJJMr/pt4PYftdhbtwGeaqRvZ3OaU2/QM3yAkIWVIG
 4JgneVY+Nx982vQAWZcmmoZu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:07:04 -0700
IronPort-SDR: O3RU0I95HAqmQN3QSuJZPTE+fzz2KEGuAwyxmz9Fm8GJyGCc8omcmIZoi+LDF03s9p3ojWV7ss
 DNLG92KLqX7J88iDHIW7zlixwf+DKSQhQEEVK7QhXrEEJm2bIIadM1XzbufPgCGlMPenTD4v68
 vh1R1Z+lqXV9yQdkGAfQkud9ZkRFJH2FdNP0bo+vV7aQWpIY70EvyvUv7rqE1vUl5JEH+T1Cla
 0l7TJk9pXFeawG5LsKDeDKnZhkMDZ4jfs7UsyZx9Hn0rZpMZW9DZJtd45xgnEal/TfB493hf/Q
 MkY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jul 2022 04:45:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LnH8M4Jp6z1Rw4L
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:45:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658231139; x=1660823140; bh=HoB6mNAGD8qprJcACnGtFLQCTHjRhxeUO8i
        /3z716MM=; b=bI5x5AJX6ASzFR52bquaFd1g4HlLNDkT32aXjh+B8xLB4T+qrtk
        gTRUnCyUTs1LiiViBL8gcDXT0iz/hVHOqGoER9t4rDE0JcSXAMCgJ1sWwcDzaWaz
        Es7kcmfWWXS/wUYBWOJmA9FeXQQhyA0Hv02zUFBf0aV5qsRWGfQQ2hktV43yaqGO
        b9FEw4jJhChG+2qCPX7hI3f/WNTtGFcxIpsb1fGYW+BmgfVL+DwXSqY3ZAu7okeg
        Q/dgGSTMAug8IVoxiF3Z9j4YlmzSl9pfFwXIM6I3cqGGjE27MJflJtcptRdOvYRw
        /xYSWY93gPea66g8if+8zZ1OjI8hXkFPsIw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id grc4N7eRfhVF for <linux-kernel@vger.kernel.org>;
        Tue, 19 Jul 2022 04:45:39 -0700 (PDT)
Received: from [10.225.163.120] (unknown [10.225.163.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LnH8L4MyNz1RtVk;
        Tue, 19 Jul 2022 04:45:38 -0700 (PDT)
Message-ID: <1ac89860-957f-a24d-82ee-d40e5345d04e@opensource.wdc.com>
Date:   Tue, 19 Jul 2022 20:45:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Date:do not initialise statics to 0
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220719112908.7333-1-gaoxin@cdjrlc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220719112908.7333-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/22 20:29, Xin Gao wrote:
> do not initialise statics to 0
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  drivers/ata/pata_artop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
> index 20a8f31a3f57..1aad8df2ea87 100644
> --- a/drivers/ata/pata_artop.c
> +++ b/drivers/ata/pata_artop.c
> @@ -37,7 +37,7 @@
>   *	test stuff.
>   */
>  
> -static int clock = 0;
> +static int clock;
>  
>  /**
>   *	artop62x0_pre_reset	-	probe begin

Very weird patch title.

Is this solving any static analyzer or compiler warning ? If not, this is
not a very useful change.

-- 
Damien Le Moal
Western Digital Research
