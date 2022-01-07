Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB20A487516
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346574AbiAGJze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:55:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236788AbiAGJzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641549332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vU/+uDnZT4UsYy+CubW6TDRh/j2zvfOBIhbG7CAs8Bc=;
        b=G5tNpvk4yU/GJyKrTIJ4b0KIRzY+FrACpGrn/afUr43ffxXRd457ZccrcBOMaHczjfmBap
        rnzu9Obz+TYuq0dRv2Qc/zgUuUUM55H8EYZu2us98K+VlESHghauafWBg3x+UXpDOTryOy
        JCzRDuAYGV4jtn7uHm3SA7GxABqybWk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-fdkK6teXNHKEmguP6OIS_g-1; Fri, 07 Jan 2022 04:55:31 -0500
X-MC-Unique: fdkK6teXNHKEmguP6OIS_g-1
Received: by mail-ed1-f69.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso4218076edd.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vU/+uDnZT4UsYy+CubW6TDRh/j2zvfOBIhbG7CAs8Bc=;
        b=a4mUFwM2sn1qx9uao4TPuBgjww8GDAvlImvEvQyd9weZjmzvbkxb/K8ywWuIf3u6Ad
         eDGkznvhpF8MAEJuYAXGjbaUH7qKn2d7k3ZDIMt9SRPdD9+qGvE8mvB+I/bOsZfR+Hag
         BBMP9gET2C8sqs8m30dBIP3LGbqE5kceSh4EYLc/zv2LQe1KiqoyJHfDDQqW6I7lZjg6
         rj7DMyjTTJQOlpQQU0WNE8bq4DCnGuc3B1U9FbS9nmhkM0nAVshA2hoJyAb7xsVsFg8n
         WKL/G5Zxi76O81buGOlLC57iTHTenN5QUrb0hAQLZeLzOC7qu9lFMNkIwujzvMZw7+LR
         q41g==
X-Gm-Message-State: AOAM530rwclipqQoA6XRwPgUMdXdCOGpsogUMkhSnX2H3CfR+PHhKNj5
        FS8ajVM97M9kUKPGZ8PpdpJ5E+P5yE94sSU4Zaipk9sQ6HX5GNu67CqUABD1Afaz0yTzAKF6pMP
        v5IF+sDAfsJd9dpypsFRtw7Rn
X-Received: by 2002:a17:907:16a8:: with SMTP id hc40mr47473813ejc.210.1641549330373;
        Fri, 07 Jan 2022 01:55:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHF9wCz78cGHX4ge90ZwZXWSxnboBDzrhueC6nzlzaqaV7drboEBAgy4xLeyAlpf3HJpDSng==
X-Received: by 2002:a17:907:16a8:: with SMTP id hc40mr47473791ejc.210.1641549330082;
        Fri, 07 Jan 2022 01:55:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id ho9sm1248874ejc.86.2022.01.07.01.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 01:55:29 -0800 (PST)
Message-ID: <44981345-5889-e8bd-01f7-2b80114adfd8@redhat.com>
Date:   Fri, 7 Jan 2022 10:55:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] Bluetooth: btusb: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL on fake CSR controllers
Content-Language: en-US
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6a3f5e8b-fbc1-bad8-aef0-3e2cf9be364e@gmail.com>
 <3BCA0ABD-6BFC-4487-A5DE-3AF043A6ADE0@holtmann.org>
 <2efeb63e-a3ee-82a7-69bc-84d39745a4f8@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2efeb63e-a3ee-82a7-69bc-84d39745a4f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/6/22 23:29, Ismael Ferreras Morezuelas wrote:
> Hi again, Marcel.
> 
>>> 		/* Clear the reset quirk since this is not an actual
>>> 		 * early Bluetooth 1.1 device from CSR.
>>> @@ -1942,16 +1943,16 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>>> 		/*
>>> 		 * Special workaround for these BT 4.0 chip clones, and potentially more:
>>> 		 *
>>> -		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
>>> +		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x0810 sub: 0x1012)
>>
>> Don’t get this change.
>>
> 
> I swapped both numbers by mistake in my last commit when I moved it from
> a conditional into a comment This is explained in the changeset as:
> 
>  > Also, swapped the HCI subver and LMP subver numbers for the Barrot
>  > in the comment, which I copied wrong the last time around.
> 
> Thought I might as well fix it here, because it may never get corrected otherwise; it's misleading.
> 
> 
>>> 		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
>>> 		 *
>>> 		 * These controllers are really messed-up.
>>> 		 *
>>> 		 * 1. Their bulk RX endpoint will never report any data unless
>>> -		 * the device was suspended at least once (yes, really).
>>> +		 *    the device was suspended at least once (yes, really).
>>> 		 * 2. They will not wakeup when autosuspended and receiving data
>>> -		 * on their bulk RX endpoint from e.g. a keyboard or mouse
>>> -		 * (IOW remote-wakeup support is broken for the bulk endpoint).
>>> +		 *    on their bulk RX endpoint from e.g. a keyboard or mouse
>>> +		 *    (IOW remote-wakeup support is broken for the bulk endpoint).
>>
>> Fix the style issues separately.
> 
> Fair enough, I can obviate this part, no worries.
> 
> 
>>
>>> 		 *
>>> 		 * To fix 1. enable runtime-suspend, force-suspend the
>>> 		 * HCI and then wake-it up by disabling runtime-suspend.
>>> @@ -1971,7 +1972,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>>> 		if (ret >= 0)
>>> 			msleep(200);
>>> 		else
>>> -			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
>>> +			bt_dev_warn(hdev, "CSR: Couldn't suspend the device for our Barrot 8041a02 receive-issue workaround");
>>
>> Why change this?
>>
> 
> Because depending on the clone this print may end up showing all the time;
> we *try* doing it, but some clones don't like it. I thought showing it
> as a warning would make sense. Tweaking the text a bit again helps
> when tracking down which version of the workaround the user is
> running, we can narrow it by just grepping the log itself.
> 
> If it doesn't work it doesn't really affect anything, and we can't
> whitelist something half the clones use to get unstuck and the other
> half just ignore and stay peachy. We're trying an unified solution.
> 
> 
>>>
>>> 		pm_runtime_forbid(&data->udev->dev);
>>>
>>> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
>>> index 63065bc01..4e5d5979d 100644
>>> --- a/include/net/bluetooth/hci.h
>>> +++ b/include/net/bluetooth/hci.h
>>> @@ -246,6 +246,12 @@ enum {
>>> 	 * HCI after resume.
>>> 	 */
>>> 	HCI_QUIRK_NO_SUSPEND_NOTIFIER,
>>> +
>>> +	/* When this quirk is set, HCI_OP_SET_EVENT_FLT requests with
>>> +	 * HCI_FLT_CLEAR_ALL are ignored. A subset of the CSR controller
>>> +	 * clones struggle with this and instantly lock up.
>>> +	 */
>>> +	HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL,
>>> };
>>>
>>> /* HCI device flags */
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 8d33aa648..7af649afc 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -150,6 +150,7 @@ static void bredr_setup(struct hci_request *req)
>>> {
>>> 	__le16 param;
>>> 	__u8 flt_type;
>>> +	struct hci_dev *hdev = req->hdev;
>>
>> This should always go first in a function.
>>
>>>
>>> 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
>>> 	hci_req_add(req, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
>>> @@ -169,9 +170,13 @@ static void bredr_setup(struct hci_request *req)
>>> 	/* Read Current IAC LAP */
>>> 	hci_req_add(req, HCI_OP_READ_CURRENT_IAC_LAP, 0, NULL);
>>>
>>> -	/* Clear Event Filters */
>>> -	flt_type = HCI_FLT_CLEAR_ALL;
>>> -	hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
>>> +	/* Clear Event Filters; some fake CSR controllers lock up after setting
>>> +	 * this type of filter, so avoid sending the request altogether.
>>> +	 */
>>> +	if (!test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks)) {
>>> +		flt_type = HCI_FLT_CLEAR_ALL;
>>> +		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &flt_type);
>>> +	}
>>>
>>> 	/* Connection accept timeout ~20 secs */
>>> 	param = cpu_to_le16(0x7d00);
>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>>> index 92611bfc0..cfcf64c0c 100644
>>> --- a/net/bluetooth/hci_request.c
>>> +++ b/net/bluetooth/hci_request.c
>>> @@ -980,11 +980,15 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
>>> static void hci_req_clear_event_filter(struct hci_request *req)
>>> {
>>> 	struct hci_cp_set_event_filter f;
>>> +	struct hci_dev *hdev = req->hdev;
>>> +
>>> +	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
>>> +		return;
>>>
>>> -	if (!hci_dev_test_flag(req->hdev, HCI_BREDR_ENABLED))
>>> +	if (test_bit(HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL, &hdev->quirks))
>>> 		return;
>>>
>>> -	if (hci_dev_test_flag(req->hdev, HCI_EVENT_FILTER_CONFIGURED)) {
>>> +	if (hci_dev_test_flag(hdev, HCI_EVENT_FILTER_CONFIGURED)) {
>>> 		memset(&f, 0, sizeof(f));
>>> 		f.flt_type = HCI_FLT_CLEAR_ALL;
>>> 		hci_req_add(req, HCI_OP_SET_EVENT_FLT, 1, &f);
>>
>> This is not enough. If you do not have clear event filter, we need to disable suspend/resume support. These device can for obvious reason not sleep accordingly.
> 
> Would adding HCI_QUIRK_NO_SUSPEND_NOTIFIER be enough here? I'll take another look at the
> codebase, any comments about the best/simplest way to tackle this would help me a lot.
> 
> As you can see I'm still getting my feet wet around the Bluetooth subsystem.
> 
> In theory adding another quirk condition in hci_req_set_event_filter() or anything that leads
> to it (i.e. hci_suspend_dev() / BT_SUSPEND_CONFIGURE_WAKE) may also do the trick.
> 
> The least code I touch the better. Right now I'm thinking of mirroring my hci_req_clear_event_filter()
> nop-out in hci_req_set_event_filter() *and* just setting the NO_SUSPEND_NOTIFIER quirk.

Note we already disable runtime suspend for these broken clones in
the btusb code, I think that in itself might be enough, together with
a comment in the header where the quirk is defined that devices using this
must disable runtime suspend ?

Regards,

Hans

