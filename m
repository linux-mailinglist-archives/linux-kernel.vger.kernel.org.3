Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAA4E5DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 05:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiCXEQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 00:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbiCXEQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 00:16:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E35D8E1AC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648095293; x=1679631293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xd5sAvX8hMb2p9Z8ogrOkaPOjxoWgMd3Ta9xe+gNRcc=;
  b=lV8JuYd1NVk521NOgu+xArRAuLfFjraE2SLyU1WsDH0AA5P4Ty9JxNRN
   qoNW7CwPr3wbpLJj0P1C/ADBvJ4AzpBO1f3UV4BvHbNsX91MJ6vpDUT6k
   iekxQpWtQjRmiC2owVqNAAYer3xClkcmJx2GgH+Eb/7nNA9pBeRLRNqoD
   ns1B0REUYJQXRcQAgDnl7bd4vphdSLy3Xitr0hYwJeP4R/1JFQkAyhIwW
   lzE+ZZT7ascdqxpOz4LVVE0MamSYFXfiIfqAdBMygdHPxxgQvm+eHTxkS
   AsFzB4HFz27ifOwc/zxbFWu9C7gdr5skRAkc3xQt7pEYemHv7hSR0BYoi
   g==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643644800"; 
   d="scan'208";a="197051287"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2022 12:14:51 +0800
IronPort-SDR: q2CksHX8FQexu2ifZ65exHHX71tiTaqY9oYllmW/mILyf0OO3MVR1giHuIoCmC5cGBspzd47xr
 +Fxv8Zv9WHZNsy6NRywW/1SVDTR8DLPnYDhSpk7t0O/ZTz90b5OQawhtlBoca3Am3QwT4z8ix+
 Q6ltaA4aVOFiaT27RggTZs330zTwkHd7RUS6OJaQTBXL1YYCY8i8EFvSnN+oz1wibfAyyjEJlN
 Oj2pc3X0NSQwVUNpq+CM5B/o7COHGsxHPKlaF30cx9MCugQ91qJeWE1QBULWknCRmprg5/edln
 +gK6ugzSXRrvFEZU4wn7bLQs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 20:46:43 -0700
IronPort-SDR: osmz7XER5r+emgvnIMkbLR6zXpVAG2+oZ+3nl83uL+BBfLpB5nae2uzcRpmD3EP/+/l2JqZ44V
 AJ4ip0A1gPYfStKPKRRhLE2hHsbEVHOKzAcHe+NrrGOXMUCrAfPTgss55rseOw+fGwfOBqFmpS
 Or6CTeCTv51EqtNNtQ/7LlnUDx76ESadSspnz4O29MR/ILn5KkM7LS/5l/S8GdOLDtngTqAmym
 9k4XhvZVMR1Kag6zWNsad7jwSSWFTefruKPKmbZL/NN46lBc3Xt9ND+3FkTu9up3J7a3iAc3Uu
 JsM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 21:14:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KPBhB36Vnz1SVp0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 21:14:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648095290; x=1650687291; bh=xd5sAvX8hMb2p9Z8ogrOkaPOjxoWgMd3Ta9
        xe+gNRcc=; b=TWqneSSOlD/UMx1prge58tHDbd+Rzo6He+NeW8hUByEeIPt8XB+
        jM/LkCeqNoylqB2ivjRLZi8LucMgKRuQczsa1SX3Ls1gZ6D+2O2dsrRIA1+v6vCp
        WXy9icXRXUtVhAcDbHH5Xe86JkNrVJK01W/weYOEezfB4YNNx2cS231rrqOOGj7x
        V1U9nkME3Gn+/FCbarY/zvweETn/4WF7H6UiDlqLVcKuYCNuf1bqCDvt6j/BtC5w
        BkL/nitocobVIPD7f1OJsVRviw9Qihlpdpv/YbS6cYqCozzJXGiAKqcaxUHRtVdn
        HL2J/aVJaKKsQkj/PXcSHAUX8RkdMPM4xnQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DkDaGOdxliH1 for <linux-kernel@vger.kernel.org>;
        Wed, 23 Mar 2022 21:14:50 -0700 (PDT)
Received: from [10.225.163.114] (unknown [10.225.163.114])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KPBh91M7Sz1Rvlx;
        Wed, 23 Mar 2022 21:14:48 -0700 (PDT)
Message-ID: <aa410785-b9db-cb97-2fea-f24336472f98@opensource.wdc.com>
Date:   Thu, 24 Mar 2022 13:14:47 +0900
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
 <a030b9b2-d94f-ed62-60bf-cc629da3e944@opensource.wdc.com>
 <CA+ToGPGVdwXgWTZFa24PDMkpXrVrpM48WAxR4U6d4D9t-k=nJQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CA+ToGPGVdwXgWTZFa24PDMkpXrVrpM48WAxR4U6d4D9t-k=nJQ@mail.gmail.com>
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

On 3/23/22 17:44, Diego Viola wrote:
> On Wed, Mar 23, 2022 at 5:17 AM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 3/23/22 16:24, Diego Viola wrote:
>>> On Wed, Mar 23, 2022 at 2:53 AM Damien Le Moal
>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>
>>>> On 3/23/22 14:52, Diego Viola wrote:
>>>>> On Wed, Mar 23, 2022 at 2:45 AM Damien Le Moal
>>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>>>
>>>>>> On 3/23/22 14:40, Diego Viola wrote:
>>>>>>> Use the contraction "it's" instead of the possessive form "its".
>>>>>>
>>>>>> Well, while at it, let's use proper formal written English, so:
>>>>>> s/it's/it is
>>>>>> s/isn't/is not
>>>>>
>>>>> Fine with me, do you want me to send you another patch with those changes?
>>>>
>>>> Yes please.
>>>
>>> I sent a v2 patch changing those things you pointed out, however, the
>>> whole comment[0] looks informal "But wait.. there's more" and I don't
>>> think replacing "it's" with "it is" achieves a lot in this case.
>>
>> :)
>>
>> Indeed. Do you want it in or can I drop it ?
> 
> Given that the language is mostly informal, I'd rather see the first
> patch applied (if that is OK with you). However, I agree with you that
> it would be nice to see formal language used, I just don't think I'm
> the right person to change all the comments in that file. :(

OK. I will look at it.

> 
> Thanks,
> Diego


-- 
Damien Le Moal
Western Digital Research
