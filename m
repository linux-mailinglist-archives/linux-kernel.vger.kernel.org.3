Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA584F0D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 04:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376920AbiDDChL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 22:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376915AbiDDChJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 22:37:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847EC27FDC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649039713; x=1680575713;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t8pKoysiMu4CyqIOrFEHeeHkKgTktH08bg5oAT6+jus=;
  b=Bu70rB1HcwOBRdwJLAZVya4WAU7D5GCbV4LbvuCPgPy1vItQMzXPfU9R
   cpEaWYEzLBFWpdLZmiadccZnqca3JxgB6d4Dq1rwwl/Bjruy//7Miqra0
   SC7HSlUD5fuueaGWQbBipIEpNpk0Nfqj9QjxPk+sgKQaRIc6TXzsBg/8I
   wiGhgbLIM8hdvDmGPWNsi0DkuhlOk6VVko6z1Purc4xmNrn3M3mv9Z5mz
   wrpkZAhhzLMXbnYQE8sIcDdNYTrKsOD9hRxUcuj6T8wxDrl/TVDGMdFmr
   oYrppR2VDTeA30hw2pDHM92IMMEBFknjFXyQYloWy8cHr3m6IWfrrGQVh
   w==;
X-IronPort-AV: E=Sophos;i="5.90,233,1643644800"; 
   d="scan'208";a="196997927"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2022 10:35:11 +0800
IronPort-SDR: 1xCrVq+afmysn5cOH45Nd3x1WXDuK7033nmg3E2ZPZMNH14kFd9IF2OWc2GDfi3qJ/PCNK6rB3
 xkLfH7HRPzxNC8tQV5nrnWPYT+kl7Ru6lFeeRnWX2bsKXt4rSymQpI9AfoEt7CTSlcQfbbF+VZ
 9JJS8pVi3wJnb7SakKSMrMVYbvUr9jjeIm0QcgwQMzsgMkJLUwUgE9UEQdygb3+SqIUrlNgNpM
 F3TfU//jlddphEw1PeSzmu+A4oUnWz3g69XkfH6UzROmR93RZJXuJzt8XOfcX48VyUfJZsp3P7
 REQuUrX/tEjaEHKoMqS7JkNy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 19:06:48 -0700
IronPort-SDR: WkvwSOR23D/SE4EQLEBRgqn9l7KXsq5ZXUnjJzmx5xPGffkLRQ7a7dniN8lg6IHsUiOASn6/R2
 YneDvKgEvxJpsA6KGO4yiNi5vt2uvak3RDUAAF5IGwzbSCnugJw/MvTXCXaWpRCm0qsTJ6aeB8
 B6skqk2FocnLCXtJ4YUcXRYbxadncuWdbNsBmXxeentMJFb8Ah6chUpo9yNLwTJw+mO7oZ6xb1
 YJTbxU4d+H4j22L+Z5wmeWeLc3LLTeDeN9hugM2givBeV+35gOw06YQVLzeC6oShwsSMpXk1nl
 0LA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2022 19:35:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KWvy7543yz1Rwrw
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 19:35:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649039711; x=1651631712; bh=t8pKoysiMu4CyqIOrFEHeeHkKgTktH08bg5
        oAT6+jus=; b=F+KrbcDXCl595enPQhpArA5xX6uMJLhsQSZi1X61hvqk54AYyxW
        FUSLdN0qFnnVIrHyuT+PcYHxpqxTx/nSD/xJCPhDI/nRkKqhU5R6dXR2CdDWmw78
        8bUs7bEkumWC87iW1QfWCYRU8nDCQ2pLfLy480uHkbLQUL8uDc2DcfpIRZXRavF2
        DpWnUTGclLlrLRBZuKWk7XlsDUS+EmTnkUvzyIngWq3jZ8KcgNJNDWLuyBey4cvz
        4bmHcTRK3Y5ubksNE6HPS2D4ThGeJ/HPg2uTQjCxUUojIBrgCwRWLPtT1lCV8gTE
        g7N9gs2MqGYX5NPb9dWPrwl4JLdlMko3hbA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lgykm2V3sjlX for <linux-kernel@vger.kernel.org>;
        Sun,  3 Apr 2022 19:35:11 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KWvy62Pbxz1Rvlx;
        Sun,  3 Apr 2022 19:35:10 -0700 (PDT)
Message-ID: <cba0d4aa-94ae-694e-6203-d4e56b21645c@opensource.wdc.com>
Date:   Mon, 4 Apr 2022 11:35:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ata: pata_mpc52xx: Prepare cleanup of powerpc's
 asm/prom.h
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <cefae2882f3b07917da18ac1d644d7307f06fe31.1648833422.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <cefae2882f3b07917da18ac1d644d7307f06fe31.1648833422.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 02:18, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up, first add missing headers in
> users of asm/prom.h
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to for-5.19. Thanks !

> ---
>   drivers/ata/pata_mpc52xx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
> index 3250ef317df6..03b6ae37a578 100644
> --- a/drivers/ata/pata_mpc52xx.c
> +++ b/drivers/ata/pata_mpc52xx.c
> @@ -19,11 +19,12 @@
>   #include <linux/gfp.h>
>   #include <linux/delay.h>
>   #include <linux/libata.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/of_platform.h>
>   #include <linux/types.h>
>   
>   #include <asm/cacheflush.h>
> -#include <asm/prom.h>
>   #include <asm/mpc52xx.h>
>   
>   #include <linux/fsl/bestcomm/bestcomm.h>


-- 
Damien Le Moal
Western Digital Research
