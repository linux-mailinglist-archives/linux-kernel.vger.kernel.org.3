Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF454D8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350872AbiFPCz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350802AbiFPCzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:55:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A61C117
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655348123; x=1686884123;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=whBk6OqEJVjH50l2UWE70391U8KntltEh8+laXVL4cg=;
  b=gtWGF7sF21T6eeXpaQACmX3deJWhWjXqeQ5uLQ0znoP60JyrXg8ibFoB
   3rgKxQaXbLwqnUesbbEpGEgj49To/yfp9jGRpAq/n3FqmLVgMhfAD6xwU
   qGWbL4Xi5crlpzGvLTskT/BqFU8G6SzlQFEs6ah9PJGu5ZBLRLSRYqpXs
   HshTqWnlzDZVNwxygpvQnMh5zuRUdUvxyMmb3pX8hVpzzNTwhMP5Otkfk
   JWu3EDfhEKK4trMacSzhw1CwbnYZB3cf4s/oJsfigo6t76JGrJVn2jGSz
   AfzQgO42gtCn228ksZFJefjdBM8u3Vr7EC4RF9oiRAmKBaE5X5Ho/JzFY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647273600"; 
   d="scan'208";a="204048588"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 10:55:20 +0800
IronPort-SDR: Zt1fHJb98hysiyoDvYQGfCcRMIZcV0bmUg+wrOu0GsYatvLEbVQ+D3kBGQGWKGcrRtxCakzEdd
 X3fZqzQ63p4NRxj+CSUVXAPgyFpbOwIotM83Za+EBEuDlKF1sKl+/zCw8TKZkC8UYe5azfZqsi
 g4HehwPLtylmZcC7rU+VUL03dkrjAvz0xHw5otl/vL8ufWcb4ZyW6VppnkfDHm4dF9FRMTayje
 jxib9Y1wXkdOJH8oinT7yk+XdELUneeq9Id7X7I3Zqrw8SSFX0OElCFxp22i1zx+zKAN/0Hj7I
 OMIgpIsOszH01P4UEu+uNFsj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 19:13:42 -0700
IronPort-SDR: ZFu/oUYMbyi174ondwZF20oddk4B7DaZIT7bGG7Ykpx6bB5A5A0+329qagC/ZqAzSKwIy2NT4R
 v93cpne0XX8uqfhG4GxZWRAleL7IiSaAbHV3zTa//94rni5OnU8v5A3DVc+6GrzU9eqatjBWNg
 WrY7DwJcldl81JluR3rCmlBzQq1YwtkDr+emdWJhgIbEuIKrqTMZt0+Ip98XyNHqw2egIf7Jtv
 T70iAZTm+CMMz5ws09qWSfq5Efo5FHGiUqF/dtqak6ZJcc69PFAbCysXD8OffmfX0B6v7TqJ2I
 3QQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jun 2022 19:55:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LNmxf5sKRz1SVnx
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:55:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655348118; x=1657940119; bh=whBk6OqEJVjH50l2UWE70391U8KntltEh8+
        laXVL4cg=; b=ruHml7RsiFb+anBTZjwc9CftHEwOtkVm0aCXSW5B6jRH7nhtART
        wQ91xN+5Py5nQqihh+LDPzkSgXIHPP3nt0/+1zbdG8AMq0yf5eZTeeS62vq7fwc+
        rNNos5DbR9dMq9zLY6sQcWzwlj/1AoBFBRK6kjjDUdeyk9NIIAR3uVe8xiXmbS/9
        GOpIa4Hxv7+eYGSqlAzaVgR3nD8asPXY81Eb+FP9SvmaoJZJB4MmgW2nuhEP5xvx
        CKkv1W0/mk436NaaEWApYHITPXkkmCN8D1fMZh1IlkbaJEKP0pBEDtv9dmtr7Fbo
        8nVneO67H+XB4Xg4OVwTjyP3ghxgIT8JnlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id itHnH3Jyhc0c for <linux-kernel@vger.kernel.org>;
        Wed, 15 Jun 2022 19:55:18 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LNmxd1Nzfz1Rvlc;
        Wed, 15 Jun 2022 19:55:16 -0700 (PDT)
Message-ID: <bcd06ab1-6ead-985b-eff8-cbc526a8aa84@opensource.wdc.com>
Date:   Thu, 16 Jun 2022 11:55:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
 <20220616004803.12145-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220616004803.12145-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 6/16/22 09:48, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Fixes: 255c03d15a29 ("libata: Add tracepoints")
> Link: https://lkml.kernel.org/r/20220616001615.11636-1-edwardwu@realtek.com

What is this Link tag for ? I do not think it is needed.
And please add:

Cc: stable@vger.kernel.org

> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
> v2:
> - Add Fixes tag
> 
>   include/trace/events/libata.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index d4e631aa976f..6025dd8ba4aa 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -288,6 +288,7 @@ DECLARE_EVENT_CLASS(ata_qc_complete_template,
>   		__entry->hob_feature	= qc->result_tf.hob_feature;
>   		__entry->nsect		= qc->result_tf.nsect;
>   		__entry->hob_nsect	= qc->result_tf.hob_nsect;
> +		__entry->flags		= qc->flags;
>   	),
>   
>   	TP_printk("ata_port=%u ata_dev=%u tag=%d flags=%s status=%s " \


-- 
Damien Le Moal
Western Digital Research
