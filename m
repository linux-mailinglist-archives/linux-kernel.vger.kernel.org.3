Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4948358C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiACR1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiACR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:27:33 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85FC061761;
        Mon,  3 Jan 2022 09:27:32 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id h67so19233500vkh.1;
        Mon, 03 Jan 2022 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Grh3iRZLDkYqgCiFWJobaJkZx4Mto9jnEwXBQ73vVs4=;
        b=mMZ8yh5BwCDZZkz+NRrigwzXbRhzhr0uT47SGJR5vQ41rWiwsqT75T/KjbMPToqiOU
         ONeOVHXANG/jIWe6RYJ3tpVidoHTRfmCGdwb62w6tp1ND329HnY4TQ3brTu4cjnySEro
         E7JvCakWwdQ8GNodifagl0smURKNMV/i7BaNbTkfslU4WP4FFTEuqzAtYegsMPjbvruC
         MmabsvRR7PK3R5O2fGvEMroZnY3/W643AZX7WGsoqlMoNsczeuKmHx2X24T0x2rGdIkT
         ShdqfeUeECkDZ9fNBgWAMNl7JJOt+LjGXYTmt6XBVS+ciYmE+DynpwBCMOztEkoLpE/q
         ekUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Grh3iRZLDkYqgCiFWJobaJkZx4Mto9jnEwXBQ73vVs4=;
        b=UJSNpKL3ce8+UIP85Otn2tWlOnAptY+pdg1aX0lJ+Z5+Hcmr+p8GHQgUDuIuBqDlIV
         G9ZLDqJws5oc07a7lWZJsMDokl5XzdsxZTe7x5q/tOTV0FySiPJbPjvUefZEkLiLraaC
         edhWgBE4zSSNMzFuMet6y/VQr40QawjVK7ackRuAsabSuU5r2FN/ypJfWExqimER/RR8
         Dc/TIywsH4cTfQKc8sLHiaZsrv8vrlWW0c+dd9PXc2CMCtr7eji0MxPqIRBQlgaWEqlW
         jA973nj7RTf+uKEFMIrtIEiq7T+SCf7G6jPHSD8hha9EiVCB9uXnLue74wSWyleYWXgJ
         wFmw==
X-Gm-Message-State: AOAM531vJnRLPWVxNO7kfs4qfj8ylem1J3e9Yis/fHl54WDxu7zydrFo
        gr4OEIpPcWQz5TKhtbJz5YjOgW+/IjE=
X-Google-Smtp-Source: ABdhPJxUFUMmfH39/l/tXRgkH25UICIz6jPCAdEbL/I7WJI7MiJEefbIklc92it83hGd4QWS/zKivw==
X-Received: by 2002:a05:6122:220d:: with SMTP id bb13mr6095735vkb.33.1641230851556;
        Mon, 03 Jan 2022 09:27:31 -0800 (PST)
Received: from [10.230.2.158] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id r2sm7449338vsk.28.2022.01.03.09.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 09:27:31 -0800 (PST)
Message-ID: <00d8af2f-45ff-48d7-43e7-14c59a0aca62@gmail.com>
Date:   Mon, 3 Jan 2022 09:27:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/9] mtd: rawnand: brcmnand: Move OF operations out of
 brcmnand_init_cs()
Content-Language: en-US
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
 <20211223002225.3738385-5-f.fainelli@gmail.com>
 <20220103175606.71a4eb93@xps13>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220103175606.71a4eb93@xps13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/2022 8:56 AM, Miquel Raynal wrote:
> Hi Florian,
> 
> f.fainelli@gmail.com wrote on Wed, 22 Dec 2021 16:22:20 -0800:
> 
>> In order to initialize a given chip select object for use by the
>> brcmnand driver, move all of the Device Tree specific routines outside
>> of brcmnand_init_cs() in order to make it usable in a platform data
>> configuration which will be necessary for supporting BCMA chips.
> 
> TBH I'm note a big fan of the idea. I'm not sure going back to
> supporting platform data this way really is a good idea... There are so
> much things that are well described with DT that we now rely upon that
> I am not entirely convinced by these changes :-/ The move is generally
> in the other direction: getting rid of the legacy platform data.

In the cover letter there is an explanation as to why we need to 
introduce platform data/device support here: the platforms on which this 
NAND controller shim is used do not have Device Tree support, and won't 
have it in the future either. They are old platforms (first SoC 
supported by bcm47xx is maybe 15 years old now) but they are still in 
active and wide use by the OpenWrt, dd-wrt communities.
-- 
Florian
