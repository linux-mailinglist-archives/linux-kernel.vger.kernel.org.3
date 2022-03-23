Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C434E4C64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 06:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiCWFqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 01:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiCWFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:46:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E90F710C3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648014316; x=1679550316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pmgRbLy3Prn/gIHeSN+Wt+WYfjNoUuIEjQFsIkjQP3I=;
  b=YbK6vqDXgv1iuugm2FjzdWG3qaTb05ec5JiudM3RMjz41MK57Ygdb1ID
   T3IPWIm4JOzXN61fOisEl+JTPl9UMH4YvbS2Brwru02dQtfTQ2VLcRRk8
   sZi11IK2KSEyf9zhrQSYuedZqpjSiXlXl6J00C41HTHDzT5vnMyAWAekj
   GNeL3lc19K6fkX4gR0Ef+687pyNYcEUO0vQngajWq6SoofwYpy6Sodnt3
   6FXT0rCqBtJnCfZGF7fXBc/7RDE6A4GuwFSBjTPRXmmH5q12V6V6nHiD4
   I0++7StjolvcAU7NcUfYQVlY8MYUj7Bfck63bw3GPcegscC49U4DhkF3Y
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="300181935"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 13:45:15 +0800
IronPort-SDR: UxFhrXHvZseLVDKd0vbIceb4G9UMGbmO+9Wh/wK1b8DVfV53CD01ZuNCFIWRVe+FORWSDcBmOd
 5cWIIVcxnMZWMW52lzsxp737pvcYb8cOD9r2bqdhyBzH1dqIoLCgXNrh7W+HFW8pn3CIx4+2IN
 RStcsuiKMsEiIhqAPBDMHeT1NANV6i2bjIbjTeIFFVM63XjYDEbvdV8WFyKtRLMC6T5CVjsx6y
 9c8eG7EiiqI47opHCOhJPRJ9az3JK9/uv0r4n+Iwo6BBAjPWUJoOUhp0lz4CdQNsw/9Oce3MRE
 SYt33JHN9UM0+Inqr9oUsWOZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:16:14 -0700
IronPort-SDR: jAmpG9eIr4mKLIS/1e/9FlWPgC4ovZ1zWEQcbz6y/wFcq3bLrlmD/LRLb9o+Sq6R1PukdXSxdZ
 RI1EihdKeR1+dToDGVn3MblxsXoJI+VOaRmOiSLmDEkq3vEhxH5QAi5h1qC011BVrIF8YG7Edy
 +1RRgGgQtRsL52Z+o6vjyZe1stNebdW2IWdQ0Y/T/fcz1VLd2G4FidIV4sVYAyNArGOTWOh0SF
 HfNaOD8Nb/LbdB8rXGqZqZkhW0hD5yY5h2sBdmQT1sIpx3jmSWB2BU6PPPAQGb9qvRY5hNbl8W
 A/Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 22:45:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNckz16Q6z1SVnx
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:45:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648014314; x=1650606315; bh=pmgRbLy3Prn/gIHeSN+Wt+WYfjNoUuIEjQF
        sIkjQP3I=; b=RPI8U5O8rKPDUdkEiu1c7EUCRc79R09Hu5tXkiYWokfwGtJQB42
        X2UP9FxfpjN9JzFW+FaNArwoXRf0Sck/rv7qdYh+LvG6FBOqT95+lcOuoT3yDli8
        rGG+9wzTs7fVGCMQlIMgrO244OBQd+3rbbywgcbNFvIkScQ/6rIin4HKbgtcUcBd
        SOog+Hoc3oCppk97OXTXedMvfCDX5XkYwzNmh0P2gTPkQWjpGq0F39K6C3Js1LME
        A0JfQMvkrJtt1Br1+7/UpqXjQsSkO3KENDu3W3Gn9NrL2lcTsuj6Pb/8U14HeEHe
        0ZqSmpZXCKs35bITxBikNe4hAHR0iEtohjw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2bido8Eb0bvr for <linux-kernel@vger.kernel.org>;
        Tue, 22 Mar 2022 22:45:14 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNcky0nKsz1Rvlx;
        Tue, 22 Mar 2022 22:45:13 -0700 (PDT)
Message-ID: <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 14:45:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220323054001.17344-1-diego.viola@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220323054001.17344-1-diego.viola@gmail.com>
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

On 3/23/22 14:40, Diego Viola wrote:
> Use the contraction "it's" instead of the possessive form "its".

Well, while at it, let's use proper formal written English, so:
s/it's/it is
s/isn't/is not

> 
> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> ---
>  drivers/ata/libata-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 0c854aebfe0b..22c93589f2c4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1398,7 +1398,7 @@ unsigned long ata_id_xfermask(const u16 *id)
>  
>  		/* But wait.. there's more. Design your standards by
>  		 * committee and you too can get a free iordy field to
> -		 * process. However its the speeds not the modes that
> +		 * process. However it's the speeds not the modes that
>  		 * are supported... Note drivers using the timing API
>  		 * will get this right anyway
>  		 */
> @@ -5603,7 +5603,7 @@ static void ata_finalize_port_ops(struct ata_port_operations *ops)
>   *	Start and then freeze ports of @host.  Started status is
>   *	recorded in host->flags, so this function can be called
>   *	multiple times.  Ports are guaranteed to get started only
> - *	once.  If host->ops isn't initialized yet, its set to the
> + *	once.  If host->ops isn't initialized yet, it's set to the
>   *	first non-dummy port ops.
>   *
>   *	LOCKING:


-- 
Damien Le Moal
Western Digital Research
