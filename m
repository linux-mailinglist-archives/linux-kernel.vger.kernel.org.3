Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D92486D37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 23:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbiAFW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 17:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245078AbiAFW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 17:29:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8CCC061245;
        Thu,  6 Jan 2022 14:29:17 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e5so2797911wmq.1;
        Thu, 06 Jan 2022 14:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4Yj9TyVs3tZ8xF5+eDrRhCv6AhgJyNZykIrYVPdyDhM=;
        b=Yzd4uU1MEvSWRs83Jcf7WUNk6iLqH1szDwS3OQyDl/2GwGccNiD3xxxsv0kxq3eTKS
         EUePpCNIm0RQ/XEZBktuoJ9eYY0l7vjudsTAj3r5lsA1Xdex0H4GXOCBQLoikifbeBwb
         ewAwnHbJP97kAwf+gwNPaEM8UlBNS5Eg7oa00QdAZowkCt+9MnnU5ilwWfzb+qFriIh2
         9YPF054Ky4qiSF7puGeBfI+FjL/oYcNFpQOt+O6rp47xQQebw669YJRRytIWGYVYxPBh
         OPaKN3kv9KY/d4ZZI+nNRrznrGURuq403PQRiom4HOm0aJHS2xoEfyGlNDhKZ7YQFzjJ
         0HZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4Yj9TyVs3tZ8xF5+eDrRhCv6AhgJyNZykIrYVPdyDhM=;
        b=bybPPpGGHsFrha5aPx/nuQ70cANsue4PKceSlyxQEqXjFkbGLg4i64NQNtDMzWoA6p
         yoRuuDseNretk5kapU2c/PdYrt3PNx+UiR9sLHUMKj6m2g72dZ/Dwxm7RqtGuYcySg13
         SwQxzhu2s+rDYIrUFiP8YUoTjpLS1PGMvM7x+viSu/qUZA3/PxKfq10Aigre1e1eKsip
         3Ah+bohQAsVme2WynTTDk+PTw9+ipKv0A4Gya8QCTY8tZGtTy+qHHBhkDm/UlcRg8Z2k
         mgf3VPXS2v7hgz+ttOtbfZyblHRnKHiElzPFhwzElGXJyz1XD9ncsyJgjD9GVskRUprp
         VaXA==
X-Gm-Message-State: AOAM532IiiNCn7WmxCMQ/Q4t/UswIgvXRRBNvne/wtMM2dpJWjErBKzq
        BcCICLCkXuZdq6UUdu+Tq7o=
X-Google-Smtp-Source: ABdhPJzUbPFEzAVkbsnsoDqQI4DFEH5G+Yq7+JyqDCGVRj5Esr4Tza0s5oLegECSow1KKD1qCqRS5A==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr8595220wmq.127.1641508156508;
        Thu, 06 Jan 2022 14:29:16 -0800 (PST)
Received: from 168.52.45.77 (201.ip-51-68-45.eu. [51.68.45.201])
        by smtp.gmail.com with ESMTPSA id n4sm3132226wrc.1.2022.01.06.14.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 14:29:16 -0800 (PST)
Message-ID: <2efeb63e-a3ee-82a7-69bc-84d39745a4f8@gmail.com>
Date:   Thu, 6 Jan 2022 23:29:13 +0100
MIME-Version: 1.0
User-Agent: nano 6.4
Subject: Re: [PATCH] Bluetooth: btusb: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL on fake CSR controllers
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
References: <6a3f5e8b-fbc1-bad8-aef0-3e2cf9be364e@gmail.com>
 <3BCA0ABD-6BFC-4487-A5DE-3AF043A6ADE0@holtmann.org>
From:   Ismael Ferreras Morezuelas <swyterzone@gmail.com>
In-Reply-To: <3BCA0ABD-6BFC-4487-A5DE-3AF043A6ADE0@holtmann.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again, Marcel.

>> 		/* Clear the reset quirk since this is not an actual
>> 		 * early Bluetooth 1.1 device from CSR.
>> @@ -1942,16 +1943,16 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>> 		/*
>> 		 * Special workaround for these BT 4.0 chip clones, and potentially more:
>> 		 *
>> -		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
>> +		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x0810 sub: 0x1012)
> 
> Don’t get this change.
> 

I swapped both numbers by mistake in my last commit when I moved it from
a conditional into a comment This is explained in the changeset as:

 > Also, swapped the HCI subver and LMP subver numbers for the Barrot
 > in the comment, which I copied wrong the last time around.

Thought I might as well fix it here, because it may never get corrected otherwise; it's misleading.


>> 		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
>> 		 *
>> 		 * These controllers are really messed-up.
>> 		 *
>> 		 * 1. Their bulk RX endpoint will never report any data unless
>> -		 * the device was suspended at least once (yes, really).
>> +		 *    the device was suspended at least once (yes, really).
>> 		 * 2. They will not wakeup when autosuspended and receiving data
>> -		 * on their bulk RX endpoint from e.g. a keyboard or mouse
>> -		 * (IOW remote-wakeup support is broken for the bulk endpoint).
>> +		 *    on their bulk RX endpoint from e.g. a keyboard or mouse
>> +		 *    (IOW remote-wakeup support is broken for the bulk endpoint).
> 
> Fix the style issues separately.

Fair enough, I can obviate this part, no worries.


> 
>> 		 *
>> 		 * To fix 1. enable runtime-suspend, force-suspend the
>> 		 * HCI and then wake-it up by disabling runtime-suspend.
>> @@ -1971,7 +1972,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>> 		if (ret >= 0)
>> 			msleep(200);
>> 		else
>> -			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
>> +			bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
> 
> Why change this?
>

Because depending on the clone this print may end up showing all the time;
we *try* doing it, but some clones don't like it. I thought showing it
as a warning would make sense. Tweaking the text a bit again helps
when tracking down which version of the workaround the user is
running, we can narrow it by just grepping the log itself.

If it doesn't work it doesn't really affect anything, and we can't
whitelist something half the clones use to get unstuck and the other
half just ignore and stay peachy. We're trying an unified solution.


>>
>> 		pm_runtime_forbid(&data->udev->dev);
>>
>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>> index 63065bc01..4e5d5979d 100644
>> --- a/include/net/bluetooth/hci.h
>> +++ b/include/net/bluetooth/hci.h
>> @@ -246,6 +246,12 @@ enum {
>> 	 * HCI after resume.
>> 	 */
>> 	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
>> +
>> +	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
>> +	 * HCI_FLT_CLEAR_ALL are ignored. A subset of the CSR controller
>> +	 * clones struggle with this and instantly lock up.
>> +	 */
>> +	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
>> };
>>
>> /* HCI device flags */
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 8d33aa648..7af649afc 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -150,6 +150,7 @@ static void bredr_setup(struct hci_request *req)
>> {
>> 	__le16 param;
>> 	__u8 flt_type;
>> +	struct hci_dev *hdev = req->hdev;
> 
> This should always go first in a function.
> 
>>
>> 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
>> 	hci_req_add(req, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
>> @@ -169,9 +170,13 @@ static void bredr_setup(struct hci_request *req)
>> 	/* Read Current IAC LAP */
>> 	hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);
>>
>> -	/* Clear Event Filters */
>> -	flt_type = HCI_FLT_CLEAR_ALL;
>> -	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
>> +	/* Clear Event Filters; some fake CSR controllers lock up after setting
>> +	 * this type of filter, so avoid sending the request altogether.
>> +	 */
>> +	if (!test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks)) {
>> +		flt_type = HCI_FLT_CLEAR_ALL;
>> +		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
>> +	}
>>
>> 	/* Connection accept timeout ~20 secs */
>> 	param = cpu_to_le16(0x7d00);
>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>> index 92611bfc0..cfcf64c0c 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -980,11 +980,15 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
>> static void hci_req_clear_event_filter(struct hci_request *req)
>> {
>> 	struct hci_cp_set_event_filter f;
>> +	struct hci_dev *hdev = req->hdev;
>> +
>> +	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
>> +		return;
>>
>> -	if (!hci_dev_test_flag(req->hdev, HCI_BREDR_ENABLED))
>> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
>> 		return;
>>
>> -	if (hci_dev_test_flag(req->hdev, HCI_EVENT_FILTER_CONFIGURED)) {
>> +	if (hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED)) {
>> 		memset(&f, 0, sizeof(f));
>> 		f.flt_type = HCI_FLT_CLEAR_ALL;
>> 		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &f);
> 
> This is not enough. If you do not have clear event filter, we need to disable suspend/resume support. These device can for obvious reason not sleep accordingly.

Would adding HCI_QUIRK_NO_SUSPEND_NOTIFIER be enough here? I'll take another look at the
codebase, any comments about the best/simplest way to tackle this would help me a lot.

As you can see I'm still getting my feet wet around the Bluetooth subsystem.

In theory adding another quirk condition in hci_req_set_event_filter() or anything that leads
to it (i.e. hci_suspend_dev() / BT_SUSPEND_CONFIGURE_WAKE) may also do the trick.

The least code I touch the better. Right now I'm thinking of mirroring my hci_req_clear_event_filter()
nop-out in hci_req_set_event_filter() *and* just setting the NO_SUSPEND_NOTIFIER quirk.


Thanks for bearing with me, I'm still learning. It's fun.
