Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745BD46B278
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhLGFnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:43:09 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:15254 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235886AbhLGFnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:43:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638855578; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=UKewAIFiJrkQQJEmsNAIUgWl1Cnv1mvrzX9VaOWue/w=;
 b=fKxpk2me6t6HHkNSppsQSlnkFRgcY4Hk/yHVUKtSfJgXexS4M8Ek5bekYMS7/9GaFvS/bvcz
 1xsrrJaWjmWiBwo3kbwJZS90nXEM0bk2kmvfWx8h+9KdsZ2GLlIjDx6CF4Wk/C/P67pwVabt
 vF3/pXA/9O4A5W9X65DnmlzlP8s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 61aef399df12ba53c4d6a622 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Dec 2021 05:39:37
 GMT
Sender: pharish=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC2BFC43616; Tue,  7 Dec 2021 05:39:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pharish)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11B9EC4338F;
        Tue,  7 Dec 2021 05:39:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Dec 2021 11:09:35 +0530
From:   pharish@codeaurora.org
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org, saluvala@codeaurora.org
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Stop IBS timer during BT OFF
In-Reply-To: <A078C973-AAAF-4BD2-85DA-F8017CE89012@holtmann.org>
References: <1637846230-4798-1-git-send-email-pharish@codeaurora.org>
 <1637846230-4798-2-git-send-email-pharish@codeaurora.org>
 <A078C973-AAAF-4BD2-85DA-F8017CE89012@holtmann.org>
Message-ID: <c767becd1ded90dc0cf4b76f38d779b0@codeaurora.org>
X-Sender: pharish@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-26 00:12, Marcel Holtmann wrote:
> Hi,
> 
>> This change stops IBS timers during BT OFF.
>> 
>> Signed-off-by: pharish <pharish@codeaurora.org>
> 
> clear name please.

[Harish]: will update

> 
>> ---
>> drivers/bluetooth/hci_qca.c | 3 +++
>> 1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index dd768a8..6f44b26 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1928,6 +1928,9 @@ static int qca_power_off(struct hci_dev *hdev)
>> 	hu->hdev->hw_error = NULL;
>> 	hu->hdev->cmd_timeout = NULL;
>> 
>> +	mod_timer(&qca->tx_idle_timer, 0);
>> +	mod_timer(&qca->wake_retrans_timer, 0);
>> +
> 
> And I would really prefer if this gets changed to use a workqueue
> instead of a timer.

[Harish]: The full implementation of IBS is based on timers
to that reason I have switched to timers.

> 
> Regards
> 
> Marcel
