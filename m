Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0481E4847ED
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbiADSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiADSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:34:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0FDC061761;
        Tue,  4 Jan 2022 10:34:39 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id iy13so32021329pjb.5;
        Tue, 04 Jan 2022 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CKSNn00/BiOS0SvuNfkaTCGRzG8dHHnuc8meOiDvCjY=;
        b=Sme33SArj00KckuaM6P6MvrxNlbsZq2U4eEN5/tSEx0x6I6PDS9QLX4224ak9BiQai
         G5QnIZ0XpF5bPTl9uwu/dhMbp9qA+lp8wFiXAxY1ZvQ451xY0jQNVkl9BwRqwBCQi3dR
         PJv4pVKP9iiQeyq09YBtdyaSjPeFdhEk3QOy1gmGrzHfBT/U7ptWJ6mt22b9Vl4USj3M
         EkkWj4gixfDuQ1A+sTef+KQ9tRQ+UKAVlXKz3pHW/DE6YZ1Xbden5OMuFf6k9gOM2ecY
         kzlFArg3DX6N3d7S+U4SZ+J88ZUwDJpH9ypTASU1oQT+w1iH3tSDlQzG52Zl4A+mDntb
         CL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKSNn00/BiOS0SvuNfkaTCGRzG8dHHnuc8meOiDvCjY=;
        b=PegKj6vEHY8VP35iwEtO2eDGhypCRGze8FcIjoVs+GqrTRe7eSVFHz6lEbwBO/xGZ7
         b58GDFMg956spMCLsJBuUo9JhBLFwz8LRQsO0OHMczjFPhKqiWJ6YrkPSzS/kwM/rUxd
         EEXhsX/ji38m6z2iJrTAUkD0cQ7pTC6L9tYV5FkU90WdDvLLZQxwhuhNi0RndCoeY1Il
         DruzHIY1cSsz2BezQfRS/0SHzxQA16EeaQD6KGsjMTj3MrIf6FHPv+L3LIUQAsQrTp1q
         Ab5uOHp08Xod0T3ZBWW/sSv5GY+VU37E3sxhuh5cer6cobIyk6LhzWmLONsZ7btzaA/2
         qdPw==
X-Gm-Message-State: AOAM531/rWJTePuclZYijVlKm4rq80PnYRmjrYjugT9R17rPeaiXNDIk
        0XIIvBpG7DJ2SAs6vc4CWlM=
X-Google-Smtp-Source: ABdhPJz0IALYrhxCC7GbFZQ3jRKow5GPCrXVfzfIJ08+IhYJNyghSRA8FNfU0+UC4fCqsBkm3Y594A==
X-Received: by 2002:a17:90a:bc8c:: with SMTP id x12mr55083541pjr.168.1641321278754;
        Tue, 04 Jan 2022 10:34:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p10sm42152336pfw.87.2022.01.04.10.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 10:34:38 -0800 (PST)
Subject: Re: [PATCH 1/9] mtd: rawnand: brcmnand: Allow SoC to provide I/O
 operations
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20211223002225.3738385-1-f.fainelli@gmail.com>
 <20211223002225.3738385-2-f.fainelli@gmail.com>
 <20220103174953.40d7fa52@xps13>
 <299bf6ed-80e6-ad15-8dc7-5ededaca15c5@gmail.com>
 <20220104093221.6414aab9@xps13> <20220104095755.46858287@xps13>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9e4c0120-e088-fca0-0194-c45fcf9181cb@gmail.com>
Date:   Tue, 4 Jan 2022 10:34:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220104095755.46858287@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 12:57 AM, Miquel Raynal wrote:
> Hi Miquel,
> 
> miquel.raynal@bootlin.com wrote on Tue, 4 Jan 2022 09:32:21 +0100:
> 
>> Hi Florian,
>>
>> f.fainelli@gmail.com wrote on Mon, 3 Jan 2022 09:24:26 -0800:
>>
>>> On 1/3/2022 8:49 AM, Miquel Raynal wrote:  
>>>> Hi Florian,
>>>>
>>>> f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:17 -0800:
>>>>     
>>>>> Allow a brcmnand_soc instance to provide a custom set of I/O operations
>>>>> which we will require when using this driver on a BCMA bus which is not
>>>>> directly memory mapped I/O. Update the nand_{read,write}_reg accordingly
>>>>> to use the SoC operations if provided.
>>>>>
>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>> ---
>>>>>   drivers/mtd/nand/raw/brcmnand/brcmnand.c | 14 ++++++++++++--
>>>>>   drivers/mtd/nand/raw/brcmnand/brcmnand.h | 23 +++++++++++++++++++++++
>>>>>   2 files changed, 35 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>>> index f75929783b94..7a1673b1b1af 100644
>>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
>>>>> @@ -594,13 +594,18 @@ enum {    
>>>>>   >>   static inline u32 nand_readreg(struct brcmnand_controller *ctrl, u32 offs)    
>>>>>   {
>>>>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>>>>> +		return brcmnand_soc_read(ctrl->soc, offs);
>>>>>   	return brcmnand_readl(ctrl->nand_base + offs);
>>>>>   }    
>>>>>   >>   static inline void nand_writereg(struct brcmnand_controller *ctrl, u32 offs,    
>>>>>   				 u32 val)
>>>>>   {
>>>>> -	brcmnand_writel(val, ctrl->nand_base + offs);
>>>>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>>>>> +		brcmnand_soc_write(ctrl->soc, val, offs);
>>>>> +	else
>>>>> +		brcmnand_writel(val, ctrl->nand_base + offs);
>>>>>   }    
>>>>>   >>   static int brcmnand_revision_init(struct brcmnand_controller *ctrl)    
>>>>> @@ -766,13 +771,18 @@ static inline void brcmnand_rmw_reg(struct brcmnand_controller *ctrl,    
>>>>>   >>   static inline u32 brcmnand_read_fc(struct brcmnand_controller *ctrl, int word)    
>>>>>   {
>>>>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>>>>> +		return brcmnand_soc_read(ctrl->soc, ~0);
>>>>>   	return __raw_readl(ctrl->nand_fc + word * 4);
>>>>>   }    
>>>>>   >>   static inline void brcmnand_write_fc(struct brcmnand_controller *ctrl,    
>>>>>   				     int word, u32 val)
>>>>>   {
>>>>> -	__raw_writel(val, ctrl->nand_fc + word * 4);
>>>>> +	if (brcmnand_soc_has_ops(ctrl->soc))
>>>>> +		brcmnand_soc_write(ctrl->soc, val, ~0);
>>>>> +	else
>>>>> +		__raw_writel(val, ctrl->nand_fc + word * 4);
>>>>>   }    
>>>>>   >>   static inline void edu_writel(struct brcmnand_controller *ctrl,    
>>>>> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.h b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>>>>> index eb498fbe505e..a3f2ad5f6572 100644
>>>>> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>>>>> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.h
>>>>> @@ -11,12 +11,19 @@    
>>>>>   >>   struct platform_device;    
>>>>>   struct dev_pm_ops;
>>>>> +struct brcmnand_io_ops;    
>>>>>   >>   struct brcmnand_soc {    
>>>>>   	bool (*ctlrdy_ack)(struct brcmnand_soc *soc);
>>>>>   	void (*ctlrdy_set_enabled)(struct brcmnand_soc *soc, bool en);
>>>>>   	void (*prepare_data_bus)(struct brcmnand_soc *soc, bool prepare,
>>>>>   				 bool is_param);
>>>>> +	const struct brcmnand_io_ops *ops;
>>>>> +};
>>>>> +
>>>>> +struct brcmnand_io_ops {
>>>>> +	u32 (*read_reg)(struct brcmnand_soc *soc, u32 offset);
>>>>> +	void (*write_reg)(struct brcmnand_soc *soc, u32 val, u32 offset);
>>>>>   };    
>>>>>   >>   static inline void brcmnand_soc_data_bus_prepare(struct brcmnand_soc *soc,    
>>>>> @@ -58,6 +65,22 @@ static inline void brcmnand_writel(u32 val, void __iomem *addr)
>>>>>   		writel_relaxed(val, addr);
>>>>>   }    
>>>>>   >> +static inline bool brcmnand_soc_has_ops(struct brcmnand_soc *soc)    
>>>>> +{
>>>>> +	return soc && soc->ops && soc->ops->read_reg && soc->ops->write_reg;
>>>>> +}
>>>>> +
>>>>> +static inline u32 brcmnand_soc_read(struct brcmnand_soc *soc, u32 offset)
>>>>> +{
>>>>> +	return soc->ops->read_reg(soc, offset);
>>>>> +}
>>>>> +
>>>>> +static inline void brcmnand_soc_write(struct brcmnand_soc *soc, u32 val,
>>>>> +				      u32 offset)
>>>>> +{
>>>>> +	soc->ops->write_reg(soc, val, offset);
>>>>> +}
>>>>> +    
>>>>
>>>> It might be worth looking into more optimized ways to do these checks,
>>>> in particular the read/write_reg ones because you're checking against
>>>> some static data which cannot be optimized out by the compiler but
>>>> won't change in the lifetime of the kernel.    
>>>
>>> I suppose I could add an addition if IS_ENABLED(CONFIG_MTD_NAND_BRCMNAND_BCMA) at the front of brcmnand_soc_has_ops(), would that address your concern or you have something else in mind?  
>>
>> I don't like much the #ifdef solution, instead you might think of
>> static keys, or even better using a regmap. Regmap implementation is
>> free, you can use either one way or the other and for almost no
>> overhead compared to the bunch of functions you have here.
> 
> Maybe regmaps will actually be slower than these regular if's. Perhaps
> static keys are the best option?

OK static keys would probably work. I am not sure that the additional
branches for each register access would actually be causing a noticeable
performance impact. Pretty much any chip where this controller is used
has a DMA interface that you program and kick, the PIO is already
assumed to be slow, and each register access is about 200ns on STB chips
at least.
-- 
Florian
