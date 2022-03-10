Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530AC4D3F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiCJCWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiCJCWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:22:41 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21964AB44A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646878900; x=1678414900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WDO4HSWRyY0O08kBCVNY2t+nO+m9kmaqPv0llFc0uSo=;
  b=Abch88PpIbxDpfDwjHStLQN2o1ZfYL9wWUu/rGAlkPBEk8lAGy05sDrt
   Pj3w8/RrIU1YCTevy7+i5IcvetN647dIGlrrpxK0/ar+w0hCC+GgCN2wp
   TGew7zSXCcccSGq6fkufjIEdwJJycPaxLCMBKx+zqidwzr4Ykk5wJBE4n
   3qzf7E72GAVuE7Vg6xwheuduJgYxeQO9RoJaA8rA7mxim/M4YBXLP4Ygm
   TlzWsZkTn/a5twUl8CHFts3D/B/etrWvY8Du6/k6zviUwRDKcxv9n3YjL
   ZJr14naH4CcslNflDMZHZDQC5uLzx+/1nSvqdiOX7fZj72RgeE+hHZM5z
   A==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643644800"; 
   d="scan'208";a="199753645"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2022 10:21:39 +0800
IronPort-SDR: d3oIMWwvuAQV6UndhLvAszP4+VCnv8RRMV8McQWmxvswft5hQ90tQyTEjNKe81KnRfgAt/gqxs
 zLj3SfBq5LL0uLhEhI2pMWm7t9xXCQYA/zwzzdL0vkamrsmX8+nc9eCxtUx0TxDLVNLBnEel7G
 7EgcC4UX/bO+sHdPi+2zdjk0LRDIjE6AAdSmUygbkiRlDUfCKtH7f42h+Str7Oxo7GPp223oDh
 HpvAw49xSFAVveF1b38dgOpQWYHETEtBgibBScqwsRxaqbKlJzHfUprURDyj2DOhbmOpOj212q
 8675fxL//nuSkfOJbSsWdMdk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:52:54 -0800
IronPort-SDR: w9KX95uYRkEiKcLBYQRbgA6Fsj6FJKR7sdCO0eP9K0XOYylBf9LWtr7Ya1CfUURpq8q/pJX758
 xCi/3888IDUKkq2Rlc4BLalnQnda57wESP1F6WpmgtXFpZpzeThVjHC7nlDU2844YFtCo/qref
 Wq9XbVgNKft6cA8wEeHrx4rU8HFZ9xmRZtKjj20KewZJ1dBafKI6CL9zUq5IfL3icZMjE4+aZB
 ZnvzLipl+fyVYSh8rQjcpKhNzkA+0E9vmi912/7lNAgvDJIELNBhE/nAdRTcCZfdgJ3M5zqCSW
 GnQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 18:21:40 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KDXr41hkwz1SVnx
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:21:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646878899; x=1649470900; bh=WDO4HSWRyY0O08kBCVNY2t+nO+m9kmaqPv0
        llFc0uSo=; b=X+C0kD8tUpUUUKvMksaTwHwMVC5UJiIOQ41BEcRYawnlD//4Et7
        /pdimEVj6tdYzAfp9CZDgkjcv9kBmbLRF+AXF+7mp96XQG1flzHJ63eZhtKE2NDm
        wenB48Xr0Ty2Ot0OQl+gG3zLSDLYqgfYnXbY+MuIZGrjMk5fkU6qWUjzxO/Mmti+
        Jxctgap8RiEX7Q8f6+wdgLUyQ0qWB9Yy8QyFq/EvYg2JagKQSiXCFU+WrsrRcO/E
        eWAU5TT5Ay3JVG+H3y7tI53I2all+UY7J83L6nb2Zgbju7Qn0IMPVSoZtTXaCcvO
        I1EkTh9lCMx01Mle8SGOocIZ8wewAlB8a5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B0bHEd-Ze6F6 for <linux-kernel@vger.kernel.org>;
        Wed,  9 Mar 2022 18:21:39 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KDXr24HTmz1Rvlx;
        Wed,  9 Mar 2022 18:21:38 -0800 (PST)
Message-ID: <268d5589-fb80-b1d8-a513-69530ca2ab9e@opensource.wdc.com>
Date:   Thu, 10 Mar 2022 11:21:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, zealci@zte.com.cn
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
 <20220309072834.2081944-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220309072834.2081944-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 16:28, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> v1->v2:
>     - Use more specific in the subject: ata: pata_pxa:
>     - Switch to returning 'irq'
> v2->v3:
>     - drop the unlikely()
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied to for-5.18 (without commit message fix). Thanks !


-- 
Damien Le Moal
Western Digital Research
