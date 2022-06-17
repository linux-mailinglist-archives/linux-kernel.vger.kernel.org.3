Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B91F54F205
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380508AbiFQHc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380228AbiFQHcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:32:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B710FC4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655451173; x=1686987173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AGN9iam9OVUBe+emJURBvw7lAJ/RYEcPsdW9ccb3QPw=;
  b=QAbqOhncNCtP6+IAn17jb2CpQAkyeMCd+vr2ZOwHQtonfro6DjgHnnL8
   iiJYjifMr/IVw7yCE6IfGm7oxhg78IQ3ql5gDoL+1hCUedcNK6C0kYCEu
   ClQ3MpNhEqFy7RIgboDBShOmJVw9XEJwL29jpLzIQ1lKEgZmAbHv2q/p6
   lGxtKYgegBYO3DHUc4DxxaFTwQWvUhRl5vmVZjkyMl/G18CdXDjMUzTvh
   oHYTYRI6b0KbBXa2mAnSyZnynkfjApRJOPfhwKDgzcQhkPbZOHWFDRznA
   g0H3FbV3J85MDKR4JDOg9hgwQwGLRUAu3aZh26UW796oN02kATQAPnEFu
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="315492922"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 15:32:46 +0800
IronPort-SDR: Xm9gUaU2scYXW5142xI/RVdI12DaRiioUvCqC7VQq+0d02cDoDmGCXRK07+6ThVEcn7yIDUNzm
 Cs5xTtB5UwIhLuO/1/5zGrrwo0T/tUkBEmBoVX2N0tnpvLyXfgQ0L56u159UWBMX8IusOHhw3g
 JomEOxs7JmwViKhmEM7hiiu3IhUf9LF0mrAYSEyg0iQIiw8iHIwmvOUnaN8cow6eA4OYpC3KED
 9Z4pfGXIMBSiDSUm3G+eXKb/0+EupNZ+n5o5/8q/pU/P5qJFyZJkFG48Hpi8ObOqVjkmk6ehTf
 tvVmqy+GoUYCMtkmdtmgE3E7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 23:55:22 -0700
IronPort-SDR: 4MsJ2xnzX7Iv11wLpdt5gfodaeydjQWlXHw8yi2RHVspLHTPSWqiPbrh9uCRcbo/RLDll7Xh5Y
 HNeuPRs4BVLQlzoQLYd8HJwjbCSLVwz/cGEY/hwbLWyuOK5dNKbY5LH4hjZPMAjAryVdFL6OEj
 fGPwZ6wErbM1IZ7g7Ee9dkZb7bmyDPOieA9w2jxLJpUSQepdM6DprlDHSK+AaTIkgexAvIxRpQ
 MngTjEYZkrDDJQWrRxcnteBHQtnKttAnhJ6uRx+2V96OUBpl92F2UNcfAl1cMoDERmWhYOg8b2
 48M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jun 2022 00:32:46 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPW3L2bY4z1SVny
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:32:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655451165; x=1658043166; bh=AGN9iam9OVUBe+emJURBvw7lAJ/RYEcPsdW
        9ccb3QPw=; b=nsuz0R9+VvgOjUFhD2WdHST7UJx0g5mjukF2CpQndUZwlvj1u/0
        3c9bLNKR90G6isAcA2E3GmYTOAE7Kzt7MHN4Zkp/PXQoIboF7ge3qd7PirT+dB4f
        41UNhPvYdKwKykAKObSP1e0jfwV2gNJYqR2tz/+fr58j3XamR7GxBmkD7O2Pt0DC
        hR97Rr6hKhXTyoMd5/CnkHL2s5i+u/REHXRAdDZ0yT9pTgLUvZXlaKPX/Mj/ucIX
        0GDszV8hQ27aYT1BkDQKHct8teZBZ0X613Dp2gS5uyAH4HIrh2gRJyiDdZ2nGtmo
        LjGL7/GOiisfeVyGICVVc3hUddnRHLow0dA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QK46XT1RFAFA for <linux-kernel@vger.kernel.org>;
        Fri, 17 Jun 2022 00:32:45 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPW3J3r3vz1Rvlc;
        Fri, 17 Jun 2022 00:32:44 -0700 (PDT)
Message-ID: <84b454f7-3c84-541f-ff9a-4f247b178c69@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 16:32:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
 <20220617033221.22049-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617033221.22049-1-edwardwu@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 12:32, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Fixes: 255c03d15a29 ("libata: Add tracepoints")
> Cc: stable@vger.kernel.org
> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
> Fixed, thanks again
> 
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

Applied to for-5.19-fixes. Thanks !

-- 
Damien Le Moal
Western Digital Research
