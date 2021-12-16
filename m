Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8621477209
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhLPMmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:42:15 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:32996 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236704AbhLPMmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639658532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpfVRe1UT2wGalaL9iuGTivHiNg90mOv+8A8BigJ4S8=;
        b=R56jaULon8afsl8VXyBVuzVS1xmXynNIsqJDC6jatR/5XX0sDYxYBcPJh0NRIJ/KRqfWsr
        77OSmz3bitdlaumDcAu0kAxxo9ehTKd99cPxplnsemvzSnOUUYeA/fGf2DK15OH8O7voWa
        bjWTYl4ZRUAPtPbwtQW6W422mhmpwH8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-4P4RhgkBMGiL1bZfzao3Yg-1; Thu, 16 Dec 2021 13:42:11 +0100
X-MC-Unique: 4P4RhgkBMGiL1bZfzao3Yg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zyz7gUPTAqwSrCQ4s2Jqep1HO3bxQp7tGoYQQCKz6XTlL5JcpxcRNnnCG7hMwfvkby5flgmRVBfEgI6yjxCGGLOxL/sh8ICAVfsARfrEMLGOu9VoPtep0rXqz4a7LSLyWg8UyZn3vNFmRySYg8jOAyCKV3XDnIXtCA2NEPV/Jtht6DpyN0hSLW/X7X67rj6uPnAgwM1LV9STzBU2xyhiqhFG9cyHDbezN7eMM1kJC5Oil9BXT8kArX0pYYBqtg336ET4RL7EJWo9Ia7vRvsvurEEGFTA6drEYtXUzAzlydRlv7U55jQ/fe6qUJGvLEy8YbsBvH1Z9PO/ZObwY/8qgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9skAueN302NJtXOkTr9zOg/hETyUKm0ms0SI5cyVK0=;
 b=ZflMtpdo162E5oUPhB7+Cl7dVzzdpju75uwq3+FzB91QUiyIJO+a3T2E3Fo5AIP3zU4C1Ibphifs+buZwL3CywkFX9OXeGiepp6aSQoD13jir6A4zxw+eTrCPrpJJYMDBPuq6MruxvWDLy16oOBrhfjlbe7VH0z0ogHe2U27WQNmZPF0NEYKhft0nkeMLdf6PunrbgS94ompfXYGgJOsyrDBs9Aww0YtcLbXFXDhmYP014kpYWJkO2URqzeT1p3ge2zcnlQN5meOBCvldn7Ddh8jLtmnvjKxru2sFs8V1BSqJ8vG0RTJ99bfK37YojAvt3TkYqwnZmpZts+pouNGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB8PR04MB5609.eurprd04.prod.outlook.com (2603:10a6:10:b1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 12:42:09 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 12:42:09 +0000
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     zhuyinbo <zhuyinbo@loongson.cn>, Oliver Neukum <oneukum@suse.com>,
        gregkh@linuxfoundation.org, Jiri Kosina <jikos@kernel.org>,
        benjamin.tissoires@redhat.com, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        rajatja@google.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
 <d2e4a97a-b89b-eaf4-5aaf-89af22227746@loongson.cn>
 <654e90fb-2f04-1f87-f56c-792757e140a0@suse.com>
 <8ed3dbee-c51c-db54-37b7-182d5a75fff8@loongson.cn>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <78229065-61e6-3d61-8cf3-3c24c0f96ae2@suse.com>
Date:   Thu, 16 Dec 2021 13:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <8ed3dbee-c51c-db54-37b7-182d5a75fff8@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM6P193CA0077.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::18) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49770cf1-27e1-47c9-da74-08d9c09179d2
X-MS-TrafficTypeDiagnostic: DB8PR04MB5609:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB8PR04MB56090A7047F7DB8FA916EDF3C7779@DB8PR04MB5609.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iDgOSvOET/dvuvAgPOEfGVMAJ/3nbVl2lYOD/Ewcmt/YFXbGwfjaOOJvfUKwIESoWWKKPzM/S4LudVYsVUt1uDEa9scUkIzdVnxPn+ZIFAie+ujH1hNHY7HO0uEU/fR+WCqE391UlgTbO0Kz2POXhElKRxanX7XW/8pLQJQYubR9KQVs/qBb2Lxfyu4SLfofUX/q/DTF7u1qpdFx8glVpAnh5SgM4sPlVAjbuCi6fOScNTEQpkecykCcPG9AC8iVZrqqYlll2WXlXy2phPqFMGLiP8D8OA3uvxFmtSjkb9nhX42vulBG5SdQgUmSdLIP/Oy69stXw6Q/mY6n5UOCJ73ATd32YOwKd8JOTwUb0vOXh3W4rnpo8rZkNabXxV6+HXYZDwMhwf9qhAVe8a5qgBvd/QBh/UVKXboQaxMAuFgPu+zcQEESFHaZJ/kob5fchxlB16znuBFpL2qNi6njmabCCvl9xDaFUACAan2MHDBFK48eCxIRz+0dk6b06rHBZmSyc3lFgnnEK+f/AMEvTOifyHoBe38r43lCqE5oHjQeFGkVnyDFDrnh/02P+LppQYzoJFhZxlpyV0VEyQflwQuZJqDu5RtNa+d54jr9gkg1TyIhqDLEIKgj42wvdcGoPamtbhJrgype3MsXHyMAJHL+yzyiCDssGuFi4t5tAOzvqUiyF/pCKt8AQI9gHvq53GUVbaKQLAG54Q5wd44kTlBKUh7BNQv6mugRAyAhqWRc9Jfdg4kQBEIONTLPQJhX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2616005)(5660300002)(31686004)(921005)(6486002)(2906002)(31696002)(8676002)(36756003)(316002)(508600001)(53546011)(6506007)(8936002)(66946007)(110136005)(6512007)(7416002)(66476007)(66556008)(38100700002)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7sKYyTcqX6mnTzCMHBqXFZluNRmy9qz0dJ6+j7YwnjMDMMlBs8NfYzxqyC4u?=
 =?us-ascii?Q?hTAVE69DH9aWw/bfyxJQSnQBCFN+/ZL6BGzcddQ4mWhwDGNOEaod+Ir46ZiQ?=
 =?us-ascii?Q?endZ6x4NiBFOK5bwBhSP7CCTVzm5Wt7B//mcDhsq8kEdLABoMutadKB2ghKP?=
 =?us-ascii?Q?iqqY3Q8uUUoUSjkpbjNH7YxlvHVGq/XAg5XzHyiiT7h87kjnNtM6JHDLRZaw?=
 =?us-ascii?Q?5Uxor2Y28C/ndTwFA7QndPmRN334Xmxg82ZUzRmVatEvN8qr3HdpW/S4GaGN?=
 =?us-ascii?Q?mGzfEBAMxpT7MuZTnTJn2PgJbAVw7UGJtx8HS0DfEQmoCRTVEHBRv63KVHR5?=
 =?us-ascii?Q?6c/8yxcIZn1LZxLZnHs96vKTKc2ieQQHsy0LGGzwb7cWDPQI1Sf2VFRn5X3a?=
 =?us-ascii?Q?4Dax0VbTEcZxIvCvjyY/jHVkiQePpUZJZjVzPB0R85n5X4UbCwlIkwoBAijT?=
 =?us-ascii?Q?yfBqlFgNSbpa8qJrmi1sIKiWipUI+gaQ09Sh8NCgg9Rq43ZWAJA+YX476o6n?=
 =?us-ascii?Q?qqrHMNVY511R3jStQVowx2ZXkMXocBoeZ/6KDdhgbtszttLf/VnCm9viGhRY?=
 =?us-ascii?Q?Td0y9u7GsWD6Rj3xI9NiZ59zzdLFxwZzYMqpec1PHgu9fGPGFG7QEWjNS9pY?=
 =?us-ascii?Q?d004d+xOha4OyZzpQp6nb5KQmQ8+HXy16nNpqSaS6Kqow4xVwMUvSu5XPUlP?=
 =?us-ascii?Q?56xJO9Ue1UJCEYQMn4m4uZOO5IIcyGugFoeXovQ7BbD4DBlMuyLkkdXa2ifN?=
 =?us-ascii?Q?c795gFuHd+ompUALF70iSt+JG0cMZYvaND9Ljsk4oVcOtmsAhB4n5+d+01ou?=
 =?us-ascii?Q?APvtJOb95Vc8SbRhoD37bGlG/8ah7VOThncSB+NkzrjIItWdJdFWkw1WBcNw?=
 =?us-ascii?Q?J2zJUKAWmp9zwx93ylbRSxbcE3kQaH49Wr//rVbAqPyObiZmybKF8WBEAXQa?=
 =?us-ascii?Q?aWAPQotDwBTTooCu5HQrWDoF5WlKDXVZzZoDML9TP9zq09fQ27JWNGiKxSE6?=
 =?us-ascii?Q?jmgZeMWNaYjhyQEApOVKTBTV+je74OluJwx47tjAhPcbEUzTeSvDaror8Kme?=
 =?us-ascii?Q?Uo0++VSzJzHxZnIB2/UNbfjXlfvZaO3xZXvxX/OU4XVr4wmArbjHrAVfrM35?=
 =?us-ascii?Q?4qa6tFDbvMo/2DLcfkCNs5ZSRlheBQ9uB0ONLo2DWwCArWS76Ecku6CfB3jF?=
 =?us-ascii?Q?tqI3LQ2H+bo2E3JNrZqLPUtIOWs0yNYcEC64c3jOM24iLFTxUrOIgLwSkEjf?=
 =?us-ascii?Q?pjE6dHkCa5YFOgS/8tYRD6BjsbArhlXsrCZa1vUpAN2/XWbPcwk7vBxTQbR0?=
 =?us-ascii?Q?YpFYj2VjYZLMR7kLOGxtr/0UApjxXJ7ZkmHniXCbFsMqovamiddAgdxssPAX?=
 =?us-ascii?Q?Klpd8z5i0gsaCTJFKiM8EcfbDHYm7Tx4Jo9DxFD4y4oga+do9Fpv1cZEj7V+?=
 =?us-ascii?Q?983csNfwXJ55sO4e+pnNI6JET8GNH7rg7nhaGXlozQLsY702+Yb2fLJrfbe5?=
 =?us-ascii?Q?M2wDFvFHvi1UanzUZzJ/FcU0LGakIOS9td4AWR2+YYO+Q5AJAJcNNaCqHuUj?=
 =?us-ascii?Q?WeDv+DNX7kTlwGKIO0MFueaT6L0Hq6F1wGEYchMEtD1JSg6jcb65Gokm57cd?=
 =?us-ascii?Q?EZFmYi9ij4vGeOJ2dXPVUOOp5+PsYx1CEnguUkyWOjaMQAkc/18vnvfqWMdp?=
 =?us-ascii?Q?QL60rxvA7BdflSqzOTYWmiTW8/Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49770cf1-27e1-47c9-da74-08d9c09179d2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 12:42:09.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrIITNo0jWHlh6Y8szOmUXU44y3kMhD97CwfvkdZhSUrX4xftbj9cyAYXca0wEDtUi8lIKcf22rDboxsoHcexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5609
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16.12.21 11:59, zhuyinbo wrote:
>
>
Hi,


> if you only talk about wakeup source you can think that usb-wakeup
> source and acpi-lid wakeup source was different things. but if you
> talk about laptop and distinguish lid and other event and you shoud
> know the cannotation why system still continue sleep when lid closed
> then system by other event wakeup. if you need test usb-wakeup for
> laptop and that lid shouldn't be closed.
I am sorry, I am not sure what you wish to say here. Could you rephrase it?
>> from the default.
>>
>> In general any HID device must have wakeup capability to be usable for
>> selective suspend. You cannot draw conclusions from that.
> you still can has wakeup capability, but it should be keep enabled by
> default. because the hid device should be convenient for human,

Well, no. We are talking about a kernel default. That needs to be so that i=
t
always works on all systems. Convinience is secondary.


> if you don't think so and I think HID definition is ridiculous.
It does have its weaknesses, in particular with respect to differentiating
between events for wakeups. But we cannot change it.
>
>
> In addition, I had said that laptop usb wakeup was disabled in system
> bios by default and if user want enable usb wakeup that was only by
> configure bios and doesn't need enable wakeup node if my patch was
> applied
If you deviate from the default, you deviate. That is reducing the number o=
f
changes is worth little. The default must be above everything else safe.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

