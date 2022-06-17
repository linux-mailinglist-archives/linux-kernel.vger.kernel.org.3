Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F01454EFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379730AbiFQD1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 23:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiFQD06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 23:26:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513BF64BEF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655436416; x=1686972416;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=8ctfFtmaA8Kx+E6xmFh3lcOlj9ZvelqXJoJObAR3Zwo=;
  b=g6bm7QtqNaFY6vY1F+fBjLIckiisdzYO59MLjvMXjhw8RLYKMqEEr0yM
   J4vdu2zTdXbKqnGjcyCiTGo22G8kR/hvb26c2IdVWVJ8HcIYHXqPIgKNe
   IE4/PJRPX5cdmlJxZ7kioa4eZ+Z7GCu+NpXYrMYRIr2dOFB+4tuBkIS09
   WApUPvhFLGSu9hVuI+QJ8pFMHZYUepJcy4Ry0HjG78Gb4r+iZ2WtQmwei
   KOpCgvxcRIPgSrkam0iQNSuOqJ5/bq57UUDegyBqgNeoPC2/DHY0EB8U4
   0nMVDznKwhcugMLaYVq5miOxK6lZJ9i95VIS/gLqdAiQ3u5zMc6z09kl0
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="203390665"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 11:26:55 +0800
IronPort-SDR: CYBs5PL+gfaEsKX9rGrmPXv1LPSPxsZTnWs4aBxmSOL5LIGBZzldxEOK7NcfUn+BFz4LGkeVQy
 6PkN5P1oxEmV+AsqZK2xFyxyuJ/qMrQgQL3POmzAz2oCJSt+UZIhrn2Yx5Yc29fNWHOPZLgIUD
 v3ugtPHM4W9x+OakTmSYftJKehQwZTs3VkyvJp/l3kekbOo1dEqKA3++TDmaDivEiKlrOv0/w9
 67IZXFaQdwI5hCwTDnMpOCZ5Jt3lYMmZG5NHRXgHRrKqCGXsUjl8Pa0ky3eNwlPAIMiIXfnQSF
 EElYJNUXzQ7q2xggdBCZ59kB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 19:49:31 -0700
IronPort-SDR: dz3OUvdvSMsfoLqzt2BKYRGTztvBAt8BH41MaELUDsZQK2mAJgr5ZC59dtJmZT6qsxigtza2Sx
 YpmCmF7RI0BGwDdS9PYEpTiE8cFK3UmrunVxu/OqHbAj9td/p2yzqmCE8163UD5+uhdApyBSA6
 Dgxn55Oo7OyEBGNHnfKLFupsR8PzOtanacWOw75a1JqszO+e3HQAp64FnumqlVe2H2JGOyCAul
 GNHd6JhiDuI86hZroE8DfGRxMj/z4mbZYqS6W0GD8aYc80RpLTb7QaSwSP+Dk/Ui/KZaJUI9t5
 mbg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 20:26:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPPbg3fffz1SVp1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 20:26:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655436414; x=1658028415; bh=8ctfFtmaA8Kx+E6xmFh3lcOlj9ZvelqXJoJ
        ObAR3Zwo=; b=bbMPlCSkRVeacmi4OmtRlBGuMg9vRsr+r4F+7IyBAxbgdz5RUkR
        Pn9wYdApiMrYiLVtVj0qU8BUjR8n5gFmOWWCPvtrUq+iNAuSNx06e1fQe9F58gbb
        fxNazQK79sUy803nkPZ5eqqmmEPqbvdtXUgla/mLJ0ch10sppsLPV7qXHf8j20Gb
        fts5LCzx8oY0zPpbrjNjluX8iTMu911kccDU1j5suYJZ8YRPjZbAJIFTe5stcnmO
        y9uI1WBWS+YaDRJ8NhNNzIZVCpi4CfXAgIYzbHj7piFC8JHU1WFdPiATkzvelZ5/
        sWyimKJVNDLTVtJtdhoiME5T4Bi0WYRYD9A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id el3CKFMN-KGZ for <linux-kernel@vger.kernel.org>;
        Thu, 16 Jun 2022 20:26:54 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPPbd2snYz1Rvlc;
        Thu, 16 Jun 2022 20:26:53 -0700 (PDT)
Message-ID: <e8fe553b-53cb-1dee-36c7-f4f737c81e30@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 12:26:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] ata: libata: add qc->flags in ata_qc_complete_template
 tracepoint
Content-Language: en-US
To:     Edward Wu <edwardwu@realtek.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220616001615.11636-1-edwardwu@realtek.com>
 <20220617030007.21768-1-edwardwu@realtek.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220617030007.21768-1-edwardwu@realtek.com>
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

On 6/17/22 12:00, Edward Wu wrote:
> Add flags value to check the result of ata completion
> 
> Fixes: 255c03d15a29 ("libata: Add tracepoints")
> Cc: stable@vger.kernel.org
> Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Looks good. But please do not randomly add tags like the above ack. I
never sent that ! And since I will be applying this patch, I will add my
signed-of-by tag, not a acked-by tag.

> Signed-off-by: Edward Wu <edwardwu@realtek.com>
> ---
> Thanks for your kindly guiding.
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


-- 
Damien Le Moal
Western Digital Research
