Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CE4E4DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242557AbiCWITC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241370AbiCWIS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:18:57 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D374DE9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023449; x=1679559449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1VOHkxOX7jnacBrrQM6BUhnOIPPKTvdn6a06lacvAe4=;
  b=lYOJtHse7BqEzGHhkV7ke0TYgUUSd0Gl325AyktsE45IgJofBmcaDwth
   OMvS2xD2Hr+jfNt4xV0IjvkwMsnJ2cDDvseWouvitIqNQ5pDtqO6M1oIA
   Hq/R1PCRWYSATgNRvFgr2Hho5qQ+7EGlWLagvNDbf11gIFaopp1GTTiy2
   MA40qDeSVe7KzUcSyQhVWjgKT3vTl7XoPGw3yMd54g3eMXQ4I7zKi5QKu
   9L4tA0ogYI4zkwPNp0r5QAoCHR9BtvtsrtQh9luuMqyf4ttgNl/vNfng7
   6OV3fzryK2/EJ6icIU/r4KfpWoN+p+d67uE3DYn6NHjPg/EQGijPUKVHw
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196969750"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:17:27 +0800
IronPort-SDR: QDlOpQnacpGPu6hM54Z+u+J28Y+VPJzDbcUVnx1i0axDseifclILUh7Pud/qavmkxidnFK+V/W
 1p4wJDZ0NBZZrRYy2abyTd1Ncppfm6Zb4YMzOHBOlLheMgM4d0NJ1tNEH+t6uQ88SOFgkPR8W9
 nkRuj2Z1QwKQSs4nc4k5t6CR0LTATxlzrxIt2xsVsJtIavUBHnY8dq1oB248bh2z+02Atczcvg
 zMuy/+I2CLWAK7z5HSV2N4B2H/uyCpAvUY+YZiP9hsnojOEHEXF5dXfpgGRSSsvz7O5LNMqO82
 ZdpsaQIrn0PcH0aQILqEQI1w
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:48:24 -0700
IronPort-SDR: JE/HpoZ7nsDM/JElCW+yU7qpE344jSuzxykXY7BEfJVaWu+gqrukgMTufRHK43Bc/ACi9Js49X
 eajDxoDpUV3ZYCCjxSB4rWvF/TWn+E+btkW+ra1ow1a6b2zuQpRdq14mj9sxM8kP5yZO8DmHb2
 yW/ThlHIYGPAGEj+TS4uONwwyPSd4ceaFd/AtyblQ5bSEpIqQBkhln0kpmynYiWLSP6SPlnLwV
 Y+TMmq1fxWX+8yA2x9QGmm+gEL045ohhLZpqy3nvl5vqfSAovu6mJbYGeRjtY7xPrtUWl1D3K9
 u20=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:17:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh6Z1s63z1SHwl
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:17:26 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648023445; x=1650615446; bh=1VOHkxOX7jnacBrrQM6BUhnOIPPKTvdn6a0
        6lacvAe4=; b=rZakW39Sk8ueSpaoRDiIZ4wSq28XtTF3DaX5KwlddauI4+Zzwbh
        ZOaJnUmebdbPN7qrpD7+wQY0oWCAJq/L7f13KueMpYgoXUj0007lR6hYtNdBcioB
        YHrkxX98c0O31gfuaUVQJoFtPKrSMKi4fCb24y+V3N5BcmkwuBpA5O+WsWtQX/mx
        k/wkrrWOrivwejdT9YfFfFo/2L1onCLqBt6iaBw6Bs23U5fzxn3XuqOIifjtacBd
        m4/ZfMTPqwplQRiUWp7khi7kT1ctyY4X29aBw9wBK0qr2qQqcuZXBkR0CUamfupZ
        VXjMrri7Hc3b1UjKJx8smQFCPG6O8qp5JBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TLAd3WN7YIlE for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 01:17:25 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh6Y0Q5gz1Rvlx;
        Wed, 23 Mar 2022 01:17:24 -0700 (PDT)
Message-ID: <a030b9b2-d94f-ed62-60bf-cc629da3e944@opensource.wdc.com>
Date:   Wed, 23 Mar 2022 17:17:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ata: libata-core: fix "it's" typos
Content-Language: en-US
To:     Diego Viola <diego.viola@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net
References: <20220323054001.17344-1-diego.viola@gmail.com>
 <ac99cc8e-11c2-d96b-9ce1-ce5618b7b378@opensource.wdc.com>
 <CA+ToGPH+FQ-6QM6MWt6Zoe_pTyL6LTn9-=-694f7xLkSVCCr1Q@mail.gmail.com>
 <641a417b-acac-6b0f-c330-b94b6ed97b99@opensource.wdc.com>
 <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+ToGPEAhWDwFLNHqXvtuumvdLQb=kzme7fdrgBfb4zojVvDNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 16:24, Diego Viola wrote:
> On Wed, Mar 23, 2022 at 2:53 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 3/23/22 14:52, Diego Viola wrote:
>>> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>
>>>> On 3/23/22 14:40, Diego Viola wrote:
>>>>> Use the contraction "it's" instead of the possessive form "its".
>>>>
>>>> Well, while at it, let's use proper formal written English, so:
>>>> s/it's/it is
>>>> s/isn't/is not
>>>
>>> Fine with me, do you want me to send you another patch with those changes?
>>
>> Yes please.
> 
> I sent a v2 patch changing those things you pointed out, however, the
> whole comment[0] looks informal "But wait.. there's more" and I don't
> think replacing "it's" with "it is" achieves a lot in this case.

:)

Indeed. Do you want it in or can I drop it ?

> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/ata/libata-core.c#n1399
> 
> Diego


-- 
Damien Le Moal
Western Digital Research
