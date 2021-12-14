Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB94F4744B3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhLNOWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:22:01 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:49425 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234876AbhLNOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:22:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639491718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFmofHqybyurvnR6tUIudv3KgCPGIkQ1hnvnN2v66zQ=;
        b=R4RiQ1JDSQ82Y0Hhyt9YXVKMAdEELMN5/EWnM3hG8zOjtMk+bvR/41O3rboX5YNQLIt9mR
        byhRKAYDuJPk6lWE4LwyaBICybLkj62IjvA4/fLlXO1EFE3PjOF1MLXciGr7OQKxA7VeGg
        MLyyfjy3SwgxOErMopoCojwPOkUO88o=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-MpUlIA-WPoqkdx_Zq8HAiQ-1; Tue, 14 Dec 2021 15:21:57 +0100
X-MC-Unique: MpUlIA-WPoqkdx_Zq8HAiQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg7TuWUc+xBhyjnEwfLc9V+aDiPsrFSJ9EvOw8S4Ii4eY+1P/d7FPsPndO9CfYsx7V7CkZr8OG7i5yPTGHn7bCO0bVsr6nFcgRrw9I7bqb3PbXe6CAsZk2X6VTTQCWX7LxGFCTRScvk7OQlcp4uKh4TIldHP840R/E8iogoKnCxwsxdm5OarCNXeoWZLdIs/pkTaYhqs4fjG0A4/uOsDSwkwF4ZjMMk8g0XFmBikr5T6XAnMUega2MIy6ynXN7I5H+/FjZ4j5w8DKb+sPDn9QZyT1Jt82Adq8pyfNH+tTzy1L4mdrXrniiFE+RQcqqPHSgPndgxOKcQ1UCRi9ChuLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yZ7OUwR4+T0HiE/dnG8pI9mz97tGYUPfFLcleXt7wU=;
 b=Imma52FHUZMIiWJQoT+FtKh/8A67QwuACZZo2pf7n+UNsr/OSU/v4/b/eusZ36rVH0vlzUzt6RMyDW7hszbyIzhE3WDh2V6J/S/dAquSPM0PIDQkJ0Ggdxsemtdlrtto/UmxDfmfZv3Z80u8PFl91A7LSydFzkahQDGCF0qKc2dtv7ph9Oh6fYQbo6LbKQnPwyRTBbxOVn6UFlVcA/p5gRXACSMq4ISxzs75h9FesL+Cgj1uMKwUPTdTPukHst/9ns2zo8YCiYkU7wgj2Dz5BUR1NVRMxiNVOzpME6N18B1yxwzldJQ12s2/XmZfPrbiPkyQLuGySPtmudpA6v2rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB7PR04MB5049.eurprd04.prod.outlook.com (2603:10a6:10:17::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 14 Dec
 2021 14:21:53 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 14:21:52 +0000
Subject: Re: [PATCH v1 1/2] HID: usbhid: enable remote wakeup function for
 usbhid device
To:     zhuyinbo <zhuyinbo@loongson.cn>, Oliver Neukum <oneukum@suse.com>,
        Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        mathias.nyman@linux.intel.com, stern@rowland.harvard.edu,
        rajatja@google.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1638956391-20149-1-git-send-email-zhuyinbo@loongson.cn>
 <caf93951-4c63-d0f1-e3f4-d0d49dec6a47@suse.com>
 <d2e4a97a-b89b-eaf4-5aaf-89af22227746@loongson.cn>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <654e90fb-2f04-1f87-f56c-792757e140a0@suse.com>
Date:   Tue, 14 Dec 2021 15:21:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <d2e4a97a-b89b-eaf4-5aaf-89af22227746@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM7PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::31) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff4956ad-4d94-48f1-f177-08d9bf0d1310
X-MS-TrafficTypeDiagnostic: DB7PR04MB5049:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB7PR04MB504966463C5ED4C52E833C9BC7759@DB7PR04MB5049.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLGjvJefoq4Kq7w2DM2pRYBI4cYt3NGOrHg465QNHIJrsDRwHG7ONyvEHpxzzPzPR9FhNTOKZouC+Fr98y7x97tCHW94cjLRuHJBH33KOwE747FHPgIeN4saDsPKgdVMvLtHpYhQNkgHbfpHiqVz4cjaAKspv7nfMOGMsQNIY/qbA2ljAo1WCk1rnTrV9sBlYOzPzmP1ho5bBkXSQFhIjDuFYj+8JjyMarWiRGkI7G5y2mh/azopWlW2q+1XITewEo17cffwxfKwE+PPqztH80vT9pKokt6uVlwzORxAvrqu9VIymlBMZ7yGzSR9yKFwBYEu3mp3SxKVI7ba/sdPJOhiJnvHOvzSzzqekg83pQtVA0bVbEfEHAaYFP6TVcXG1ILkexepHmiMLlH/wDkZ2xqT+OQjfrIK1FZfOgfwfmeVDCe5x4dS/RH7Vu2N6Ybhqn64XvIILXHbpfUBYiomvpN4USHlsNRoiPq46W/1KHs0d2iExlN4Bg4B8Sphjf/PKqmYGM+Z+tDeuQg6b2WQ4VlkxGwHcEver2bRD906Psn/OI3YB3GcFh58SA7cepu/29IO/YYn5CpBgxNADnom5WwqHnGl8QnKPqFUIN7zkZUM/tggtQuJxKm091AMpccw5viBFe+XS4j8HV8zwcNz+W2zx0k6a4HqB3bNr8Mk3xIt3jusA2HYF0Op0IrBQKXJGndUafuvbXIogEeESqNj9RHcRezJbws1ds6M+HqFYYByiz8Td8/3IyJAovKSQK3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(508600001)(316002)(2616005)(8936002)(110136005)(83380400001)(4744005)(2906002)(36756003)(7416002)(53546011)(6512007)(66946007)(6506007)(31696002)(86362001)(66476007)(66556008)(921005)(6486002)(186003)(38100700002)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtBMFOjdm8UXyIU8Olmt+iSWWAU9HN1VeOIZOOk5lKB5tANHb1F+aTIOVjlo?=
 =?us-ascii?Q?lgAP8o193cm0yRYUXdQ4rxu2S0mv4NmWe5BGS3bVKWtWAnRUpATfkf3R6T+H?=
 =?us-ascii?Q?Y9FSeD6rjYauHQCug2nzAqXoU6MsHUFugfThxonoG3WBEs1ulU0Y2zti0DfK?=
 =?us-ascii?Q?sUqefZ/u+QLPGeJGS2gfmAs9S8otFBU2zHx9rjTuWoIw4vXealkJZsOAh/vD?=
 =?us-ascii?Q?MWjmfuHwtSPqA9ZPl+Lc/lEcM8Hq5s0f9qo3E4V8VRdfa68u/sTKDcD7EsyE?=
 =?us-ascii?Q?2NGZ3wHHMPwqV23iuYIrJvaZ9x/fzIrTCMICjx8crLQim6eeonxrFJa4mhUM?=
 =?us-ascii?Q?oDaQ6Xblmv44CQiXhJy9okiN0fe1F5KX1lMbBjUhkBmeO7WMNGsbKavSsqxd?=
 =?us-ascii?Q?MA0cVJktxlnHDqbdBqK5PMwfSCwpYRBoYi8sy9VXXEYv7N9AALLVi0D8co9G?=
 =?us-ascii?Q?Jtr5rEI4fJGhmUyac8dXF9g6I9LO5xD5KA3p0ENkT+W0LUtqk1YdbMQbIdQU?=
 =?us-ascii?Q?0VSx0cI3klJ13lh6IUjUhzG3qQVzjJwDObNEMQihQ1Zn5QBG2ceovdVX84H3?=
 =?us-ascii?Q?94xsa2lxHWP2JAbIm5gaZikszuAG8k7PNKG/egTYqk5UPslUg5CuQjjIIb/z?=
 =?us-ascii?Q?+uw1jgF1IIDp/wvgrkQq7rIeY2IUpuXZ4IkDuyKJxa5ATuVM6NYlyZ8ya0sn?=
 =?us-ascii?Q?nXX2WRuUFGmXVviSn4oeR+HnKg+/LLaTgv83rhXWJ3wLBzbmKX2398cAwjBx?=
 =?us-ascii?Q?+sOsV7BKz2p3XwCsWDFZYskrc0ad4myq2EHgQFpgXl02Ys/O3Ss38UdCRbFj?=
 =?us-ascii?Q?I79h+cdFJg+QRxYVcUoxtM5M8Xqp+JrtD6hQCFZ48ShIxwbLEEunrSUDhJJF?=
 =?us-ascii?Q?C49rmA7jodvT5wBYxHsxFqTLTn8FNM4jugfS/R/hmXQyerRy1w5r1qpxCC9e?=
 =?us-ascii?Q?bKninEvLrLyzXeiPygDV5xiYeXoqmHqJPTD5IBVin7vX7QoMBpm9pk5LTsXr?=
 =?us-ascii?Q?ZtXIXOsujIyt1+pGr7aNkcW4/C6K6gTVJdszLdLA4OHSW3dHSsGAXU+BP3vt?=
 =?us-ascii?Q?9Ej/61oEr9X+y3s85hPfFxl+8+qOfaRGNOClK0L5koauxsGBrxHl/DzL7HHJ?=
 =?us-ascii?Q?aRDJ7JIBIbjQtENmv+5OtmxYC0y1EmV7SOqB/1A7sfOWP0CG+4ejXFNIPZtw?=
 =?us-ascii?Q?uU1PXyX52dVDV7btXR2VHuSmGSojeSoPweTD0qLulJh/+RpO3TerSNpGLxsb?=
 =?us-ascii?Q?gOc+RdfGTquyNdPZmfl3/D72NZ+D5EJdmTIJpMjHyK/9g1SBUo7Ikpm2uwD/?=
 =?us-ascii?Q?1vz4WjhT+16BlvHPDXkMpUhfVaGYHmvpCmMwN9BrFurRn2SQ+1lJyEp4b5Oa?=
 =?us-ascii?Q?p3AK0bm/xLhMOewddyN5ldUsnGZb47xh9vflSm4RzZpiXNUapvHOurFkflPx?=
 =?us-ascii?Q?Tm4XsNUKUKMkhU05qTD5YxGaIfJi7A3EhghmuOtlr8GFEqceeZZvw7K3caqE?=
 =?us-ascii?Q?ktHgIOLRKJeeU8STBbdZHzwnz3iJbOzuGXlmCBM+ALPlKOIywAUjbczT+5XV?=
 =?us-ascii?Q?KP4UPzhdn+iAwqLr6m+tw1Vy8PsPoau9ZTRvthI6UAwT5h5Jhj5dwiu95mZM?=
 =?us-ascii?Q?JEX8s9R8U77kqGJALBoKh87gcQC6ObSTXawETSpP7O/Y0bI35exOydADnAHP?=
 =?us-ascii?Q?osPtrenstWy2iGF8B32jVnrK94o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4956ad-4d94-48f1-f177-08d9bf0d1310
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 14:21:52.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LITBIAYOd0nTPa0q7gUXj9mh0+AMcil/SypHeN6TP0QDZOLp2GzyhfMqBhsWzdQSHX2wRApIjl8RAAph8K6PQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.12.21 10:50, zhuyinbo wrote:
Hi,
> system ask that must it must be accped a acpi lid open event then
> system will always into resume state for laptop, otherwise, eventhough
> that system be wakeuped by other event then system will continue into
> suspend.
Lid events are necesarily for the whole system.
>
> and for laptop usb wakeup that as general ask bios to enable usb
> wakeup then if need do more things to enable usb wakeup I think this
> usb wakeup function isn't friendly and inconveient, so enable it by
> default.
> after add this patch, if want to use usb wakeup function it only need
> enable bios configure it think it is appropriate.
>
No. If you wish your laptop to be resumed by USB events, that is one thing.
You can alter the system settings. That must work. But it is a different
issue

from the default.

In general any HID device must have wakeup capability to be usable for
selective suspend. You cannot draw conclusions from that.

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

