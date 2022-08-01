Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3990A586F9C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiHARe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHARe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:34:57 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FFCE3D;
        Mon,  1 Aug 2022 10:34:56 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id s206so10298690pgs.3;
        Mon, 01 Aug 2022 10:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=h6Q/0U5LlsxmlACtV60jOLJAoajkWvRfWYOnNrrKuSM=;
        b=aWX69LaN9RUtZBjdlAIOYhZdICUDPM0wPpnJKeM6WlzNMtPCLwyXV2u1goaAL6EPLY
         Z6+8XdsYCqt0aZCMgAXRjMqTBdKkh6BjamX3+rFNFkfMbjw0SunlDYKxf1g9kske/nRa
         I5NX7WwcUJfSdunT2w0rZSNa26HX7ZeKeQ7R/3fr41iXfZqyqut5Nh8Zw2UjezXuPnfK
         4+7Ifw5YCkU5sbzf9dYTK7c5Ts8rmDcIBQFFLqWNI+9w0Lb3nDcBXabWpbY4uiFbAcug
         WFetkbi91pwbZntYNj757Ur585msnNwSVUyc+6pfsiaCHZJfm+zuPZrnKajEsncX52tD
         xnvA==
X-Gm-Message-State: ACgBeo029KHyuC8+YKB1XadP7Dn3DPIt5Z5F8Sc0fql9zmskXqwSZ/V4
        aZ3oATG7Wlq9+cpgt2g2nUw=
X-Google-Smtp-Source: AGRyM1sIK/8muQ4Rxp0DlRlTENq5tuXZdvMcOlwbp1uhmYTSsCxPhCXmxBPkQwTFYTHqEVF7wuycJA==
X-Received: by 2002:a05:6a00:f85:b0:52a:c718:ff9 with SMTP id ct5-20020a056a000f8500b0052ac7180ff9mr16950033pfb.85.1659375295785;
        Mon, 01 Aug 2022 10:34:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6496:b2a7:616f:954d? ([2620:15c:211:201:6496:b2a7:616f:954d])
        by smtp.gmail.com with ESMTPSA id f4-20020a62db04000000b005251fc16ff8sm8737517pfg.220.2022.08.01.10.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:34:54 -0700 (PDT)
Message-ID: <b92ef74c-1068-b86e-c3c2-a95f057e2494@acm.org>
Date:   Mon, 1 Aug 2022 10:34:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] scsi: ufs: Fix ufshcd_scale_clks decision in recovery
 flow
Content-Language: en-US
To:     Stanley Chu <chu.stanley@gmail.com>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>, alim.akhtar@samsung.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        peter.wang@mediatek.com, Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
References: <20220729075519.4665-1-stanley.chu@mediatek.com>
 <7e8c58cf-64c1-8426-bf22-97d3df85ed38@acm.org>
 <CAGaU9a_G1kH8VezozhZ3-S6-GvMr=EUVc4btU8Dwdo+cCJDxUg@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGaU9a_G1kH8VezozhZ3-S6-GvMr=EUVc4btU8Dwdo+cCJDxUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/22 00:08, Stanley Chu wrote:
> Hi Bart,
> 
> On Sat, Jul 30, 2022 at 4:12 AM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> On 7/29/22 00:55, Stanley Chu wrote:
>>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>>> index 581d88af07ab..dc57a7988023 100644
>>> --- a/drivers/ufs/core/ufshcd.c
>>> +++ b/drivers/ufs/core/ufshcd.c
>>> @@ -1574,8 +1574,6 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>>>        ufshcd_rpm_get_sync(hba);
>>>        ufshcd_hold(hba, false);
>>>
>>> -     hba->clk_scaling.is_enabled = value;
>>> -
>>>        if (value) {
>>>                ufshcd_resume_clkscaling(hba);
>>>        } else {
>>> @@ -1586,6 +1584,8 @@ static ssize_t ufshcd_clkscale_enable_store(struct device *dev,
>>>                                        __func__, err);
>>>        }
>>>
>>> +     hba->clk_scaling.is_enabled = value;
>>> +
>>>        ufshcd_release(hba);
>>>        ufshcd_rpm_put_sync(hba);
>>>    out:
>>> @@ -7259,7 +7259,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
>>>        hba->silence_err_logs = false;
>>>
>>>        /* scale up clocks to max frequency before full reinitialization */
>>> -     ufshcd_scale_clks(hba, true);
>>> +     if (ufshcd_is_clkscaling_supported(hba) && hba->clk_scaling.is_enabled)
>>> +             ufshcd_scale_clks(hba, true);
>>>
>>>        err = ufshcd_hba_enable(hba);
>>
>> I see a race condition between the hba->clk_scaling.is_enabled check in
>> ufshcd_host_reset_and_restore() and the code that sets
>> ufshcd_clkscale_enable_store(). Shouldn't the code in
>> ufshcd_host_reset_and_restore() that scales up the clocks be serialized
>> against ufshcd_clkscale_enable_store()?
> 
> Both check and set paths are serialized by hba->host_sem currently.
> 
> Would I miss any other unserialized paths?

Where in ufshcd_host_reset_and_restore() or in its callers is 
hba->host_sem obtained? I don't see it. Am I perhaps overlooking something?

Thanks,

Bart.
