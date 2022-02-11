Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD84B1F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 08:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiBKHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 02:43:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiBKHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 02:43:05 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E21250
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644565382; x=1676101382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xV1Xt7qZuIJbKdhiwEYGnwXjYuIyIN/x/fsiGnpmYYw=;
  b=hBTIFGQOCIDqK950L1VYGvpEhrluDe0Rd7dYumDjLVfmBVQkh7Yyw0Tw
   SbB/C7PyUPOMwjY3gMn544tD0J/utUWrTUGlZrR/4uPC8+gfO/PvgyfQc
   hNJQ1fqYKYHbnNxEpAHqp84W3ZvDhTm0jatEOX60FWuMoQX/mkbFA1Zyr
   /HNJFfM2D0PDd1zt1P6ErJE5K/9UuPMEgx/mUXlRAgLDtmWouwX8VSQVc
   wuBpiVtBONuwVQdNoC5Lys58IPuDSCYwK4PPS6h7alCMUbcNzTq/m5GG7
   usSJVFTK0Tc1CeVbhW0kt4dzcFWLMVAVmAqrVNVzeeeSn2gHMpJnaoB5d
   w==;
X-IronPort-AV: E=Sophos;i="5.88,359,1635177600"; 
   d="scan'208";a="192675429"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 15:43:02 +0800
IronPort-SDR: ChvLN9cv0LdMGGm8eqYJxKn44SJa/dCDOSLMvKP+MdQ3RgMtGt7iPHj6d/iBz9dVlj+io0E6ol
 LZTYUiFMETC8zNpMlVrQVss5VpXTkEeQ3GZ+j3cJLlBlhTSpCne03VFRJxiTmq0ZDX8Hzf95Dh
 PAFdQQa42y2vshZ+HUbBKeoz7STA+LcKHBiwxt9fGrNWl9TEIGS75hQR5t5TPiiqZ/gDqHRRtS
 xtPmNbj+AjzPi31fax9sMaAtsb0W/PMbdL+gL7lXdG5d6CccC3ODDkrb+krUoKA/SboRq5TQ5a
 masfetank9gx0NfNpOGf5DDQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:14:50 -0800
IronPort-SDR: wMTJ/9eAaF8NEEkQ8yAwYV9+8AztlFrairWrdjGBd61dph5PwVriud5MtQQvFI4OntGBf3RAk4
 6jgkdQ/s4pxJ1idLolNQt/hKKGynHtpLSZYAH85/mxsq0Np1SV1GfkkLBQyHJVdYJ7J18DpheT
 dBc44Mz2A4McEpwwEqRSzm7p0M5V2VBJYJlcwIl25QvdsqeBEJKoCBf7Wc6m49F7LzUObRkFUt
 AmT64Q/5X75oyW0EdgfzCz/ESiDxGxGGkhX4euFMv+HGtKpRVRxhCSOydLvaQVGslu0zKLzFNE
 PD0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 23:43:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jw5FN04lWz1SVp1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:43:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644565383; x=1647157384; bh=xV1Xt7qZuIJbKdhiwEYGnwXjYuIyIN/x/fs
        iGnpmYYw=; b=JshSfVVOYE959No6nGQxRVk63PT3RmP6PQaYbL6DMAGcEbn159d
        J7fyaH3wFhG73FJZng8Cp6a2tocOx8Z8+tHXzJ8yVuW8dNbaY7DlArOW2LLzN5Ba
        dbQGF08J3JNDzSP+tnvqAwZq05WwsUH/bi/k5bzqxSklFFXoilKZttGp1S62vWE/
        WVffW6JiKk92wkwsJ7u6IqAPjormbCW/BAcYR86tjoXuPt+EmoS0SvJb9o78SYIW
        CtaHXBnTEkBurbDsWhNaLIOX08FmNqf1n16YYlbrSvB9RLcLwUmH18iNmQ1qmgPP
        qhI6xEyGfZKKEObLKgYPeRfqj379FfVaOgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PS7BdeZUXC5d for <linux-kernel@vger.kernel.org>;
        Thu, 10 Feb 2022 23:43:03 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jw5FL664Gz1SHwl;
        Thu, 10 Feb 2022 23:43:02 -0800 (PST)
Message-ID: <ddc1de5f-04b2-19a3-ef95-dad189a66d04@opensource.wdc.com>
Date:   Fri, 11 Feb 2022 16:43:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/9] pata_mpc52xx: use GFP_KERNEL
Content-Language: en-US
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     kernel-janitors@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-6-Julia.Lawall@inria.fr>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220210204223.104181-6-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 05:42, Julia Lawall wrote:
> Platform_driver probe functions aren't called with locks held
> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied to for-5.18. Thanks !


-- 
Damien Le Moal
Western Digital Research
