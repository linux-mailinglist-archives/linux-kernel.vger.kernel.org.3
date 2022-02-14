Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC64B5A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiBNSuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:50:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBNSuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:50:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE47D299
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:50:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso32723pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DgckHGaAkZcrGYa6I90wSGex+wSps1HIk1YzJ1huHBo=;
        b=RJZZX4DXXXc2Vva5RTK54qqa2xE6JBudRSuqI1jH8ljthTNxhlQbRoXtDtgKJ/Vtd3
         9ARstZWodppgVy/ebyhHmFuYiBxh2UAqBhQ/E2HUbJnV47uO0Je2ybKWozhvnHoZFa/n
         PJQElJg2hTvwZbmARt5NeCK94ASxd9CeE+VG/w+N1dmHyu0dDtOclUaqiUiNGpkFSUQg
         FZd/gMLsHHcB5kTYNCETi/yTUZV4pWlqn5DSfzTBdjoGNc8fIJcLvalCCW8W3xbvIE7v
         wuorMvmulrHFt/gA587y5lKfUCWoYEIdYQ5T7VeAAMwZtcUqBjcMest87frN83K7Je1T
         nMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DgckHGaAkZcrGYa6I90wSGex+wSps1HIk1YzJ1huHBo=;
        b=T9CC9in9IHUhCvsK+m6hcKpzD6e/EN3OZXInNffLsBn8HKdRrybKhkvRSoS5S4UGZM
         wQRiwVcMf283uBWMM8sgB71oVK3hLXFhKQFdcPuK2L5T6bXkFv7VHwiCMtlZokF9bg22
         mG9YSP59KxN4kEyHP7GtMwj339Jts8Zp0bESMIswMOhe8Q+Kk77qdN82oIeMUA/aUk3j
         TRA70serCaMxWNm02SQ1CinwqYxaDGswlKHr3QTg8QpIbY68mdtUyKqMt3DlqR41E2u5
         biHeI+FGRCeox/XxtPZ2zXSI++W2TfY40v1kRYj+DHyCnZAv7XX5DecgU8DvepWuXyP/
         dp5g==
X-Gm-Message-State: AOAM531ikLh2hYUZbWBQOw6Lv6Gd4FgKXb4YdOl5Sl+eG3blN+fRpgwg
        WyvOVzlUav7fXUFX8sKbuhI=
X-Google-Smtp-Source: ABdhPJwJMB9C8naMZb2fI5M9G0VerPo7wYHQv0HzQTYEZm+nvYJla2KU96FqYyucOl71Ghs2t/6Q6g==
X-Received: by 2002:a17:90b:4f87:: with SMTP id qe7mr40474pjb.77.1644864385890;
        Mon, 14 Feb 2022 10:46:25 -0800 (PST)
Received: from [192.168.122.100] (133-175-21-116.tokyo.ap.gmo-isp.jp. [133.175.21.116])
        by smtp.gmail.com with ESMTPSA id v2sm14583655pjt.55.2022.02.14.10.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 10:46:25 -0800 (PST)
Message-ID: <cedb1604-e024-2738-5b33-15703a653803@gmail.com>
Date:   Tue, 15 Feb 2022 03:46:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [BUG] mtd: cfi_cmdset_0002: write regression since v4.17-rc1
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-mtd@lists.infradead.org, Joakim.Tjernlund@infinera.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com, richard@nod.at,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, marek.vasut@gmail.com,
        cyrille.pitchen@wedev4u.fr,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linuxppc-dev@lists.ozlabs.org
References: <b687c259-6413-26c9-d4c9-b3afa69ea124@pengutronix.de>
 <dff2abcc-5813-2f2c-35ba-f03cd1f35ac3@leemhuis.info>
 <e11b76dc-5539-fb7e-da1c-a5005713d6b0@gmail.com>
 <3dbbcee5-81fc-cdf5-9f8b-b6ccb95beddc@pengutronix.de>
 <0f2cfcac-83ca-51a9-f92c-ff6495dca1d7@gmail.com>
 <b231b498-c8d2-28af-ce66-db8c168047f7@pengutronix.de>
 <66ee55d9-4f20-6722-6097-e53c2108ea07@gmail.com>
 <579eab10-594c-d6b2-0ddb-ea6ab8e02856@pengutronix.de>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <579eab10-594c-d6b2-0ddb-ea6ab8e02856@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad-san,

On 2022/02/15 1:22, Ahmad Fatoum wrote:
> Hello Tokunori-san,
>
> On 13.02.22 17:47, Tokunori Ikegami wrote:
>> Hi Ahmad-san,
>>
>> Thanks for your confirmations. Sorry for late to reply.
> No worries. I appreciate you taking the time.
>
>> Could you please try the patch attached to disable the chip_good() change as before?
>> I think this should work for S29GL964N since the chip_ready() is used and works as mentioned.
> yes, this resolves my issue:
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Thanks for your testing. I have just sent the patch to review.
>
>>>>> Doesn't seem to be a buffered write issue here though as the writes
>>>>> did work fine before dfeae1073583. Any other ideas?
>>>> At first I thought the issue is possible to be resolved by using the word write instead of the buffered writes.
>>>> Now I am thinking to disable the changes dfeae1073583 partially with any condition if possible.
>>> What seems to work for me is checking if chip_good or chip_ready
>>> and map_word is equal to 0xFF. I can't justify why this is ok though.
>>> (Worst case bus is floating at this point of time and Hi-Z is read
>>> as 0xff on CPU data lines...)
>> Sorry I am not sure about this.
>> I thought the chip_ready() itself is correct as implemented as the data sheet in the past.
>> But it did not work correctly so changed to use chip_good() instead as it is also correct.
> What exactly in the datasheet makes you believe chip_good is not appropriate?
I just mentioned about the actual issue behaviors as not worked 
chip_good() on S29GL964N and not worked chip_ready() on 
MX29GL512FHT2I-11G before etc.
Anyway let me recheck the data sheet details as just checked it again 
quickly but needed more investigation to understand.

Regards,
Ikegami

>
> Cheers,
> Ahmad
>
>
