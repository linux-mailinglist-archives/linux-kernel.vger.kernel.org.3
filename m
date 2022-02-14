Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BEE4B4534
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiBNJJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 04:09:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiBNJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:09:11 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 2597D5FF3A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 01:09:04 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1644829744; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0IElTyYDBIfvi2zer1ahdbOZj2DmTRQFW8xbpLmh/s8=;
 b=p3iTfhY7Lz+8WOKwRNYabAC1feAty1MmEF2jJi/9MHDZnaVJuZzTJwLg5W1KzzPlzefh21Uj
 RSnnOdDH9TAhHj9kJVUXM/0nsbsmuzrK1vueo3f1SmFFL17mm54jo4pKePt5KwWMMigR+3CA
 hfe9BgBRplyFMV0EjkSJ+L05A+o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 620a1c2e3047cf1c0a528733 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Feb 2022 09:09:02
 GMT
Sender: zijuhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 713F0C4360C; Mon, 14 Feb 2022 09:09:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4C18C4338F;
        Mon, 14 Feb 2022 09:09:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Feb 2022 17:09:00 +0800
From:   zijuhu@codeaurora.org
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, c-hbandi@codeaurora.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org,
        tjiang@codeaurora.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Improve stability for QCA devices
In-Reply-To: <59F65F10-0988-4E50-8956-69C601F05434@holtmann.org>
References: <1644566620-16748-1-git-send-email-zijuhu@codeaurora.org>
 <59F65F10-0988-4E50-8956-69C601F05434@holtmann.org>
Message-ID: <d7fa066f93e5869d955da46c43f6b142@codeaurora.org>
X-Sender: zijuhu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-12 00:22, Marcel Holtmann wrote:
> Hi Zijun,
> 
>> Controller will reset after NVM is downloaded for QCA
>> device, so wait a moment for reset Done then go ahead
>> to improve stability.
>> 
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> drivers/bluetooth/btusb.c | 5 +++++
>> 1 file changed, 5 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index e03dfbd92fcc..20e36f53d2e7 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -2994,6 +2994,7 @@ static int btusb_set_bdaddr_wcn6855(struct 
>> hci_dev *hdev,
>> #define QCA_PATCH_UPDATED	0x80
>> #define QCA_DFU_TIMEOUT		3000
>> #define QCA_FLAG_MULTI_NVM      0x80
>> +#define QCA_BT_RESET_WAIT_MS    100
>> 
>> #define WCN6855_2_0_RAM_VERSION_GF 0x400c1200
>> #define WCN6855_2_1_RAM_VERSION_GF 0x400c1211
>> @@ -3320,6 +3321,10 @@ static int btusb_setup_qca(struct hci_dev 
>> *hdev)
>> 		err = btusb_setup_qca_load_nvm(hdev, &ver, info);
>> 		if (err < 0)
>> 			return err;
>> +		/* Controller will reset after NVM is downloaded, so wait a moment
>> +		 * for reset Done, it will improve stability.
>> +		 */
>> +		msleep(QCA_BT_RESET_WAIT_MS);
> 
> how hard is to just grab the data sheet and figure out the appropriate
> time to wait? I will be all documented and then reference the
> documentation.
> 

let me explain more for this patch:
a BT enable failure issue is reported for WCN6855 2.1 chip, the root
cause located is that HCI command is sent before controller reset is 
Done.
100ms delay is suggested by firmware team and it is a appropriate 
interval
based on verification. so these info is not available from data sheet 
currently.

> I really dislike this "add a sleep here and sleep there". It might
> just work for now. The next hardware generation comes around or if
> placed on a different board just behaves a little bit different. And
> at some point we are at 10 seconds sleep and you start complaining why
> the controller initialization takes so long. Stop guessing and
> reference the data sheet.
> 

you are right.
i will only restrict that delay to WCN6855 2.1 chip this issue is 
reported for.

> Regards
> 
> Marcel
