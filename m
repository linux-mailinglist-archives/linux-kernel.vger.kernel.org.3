Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF598475A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhLOOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:03:27 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:57852 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237716AbhLOOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639577005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=63EsgojecgMz4kCx/nfJJCQTwXpcHVXKBVt5bMBg7EU=;
        b=lhClwpiwy92D0MBcB40jgz/h3N5ONF3OKwqhNbmBErJK/AIfSQUGeHDDUyaoMXl+yHwGLR
        MS4E8lwJR3DxQ/xUJx+WjHesZuoDBAoci7zijbrID1/mwd0vyKidKVfMJibmH2Glweyzlo
        JKhCTJMhlkqKcr3uyk94Ah3TNrkmY4U=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-uSd9ZGP2NOKj4vkDdgcZLg-1; Wed, 15 Dec 2021 15:03:24 +0100
X-MC-Unique: uSd9ZGP2NOKj4vkDdgcZLg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUJ+Q5B86ZbAoT5tPTH2RYzv/vTWwmo+N94YsttEYvPzfyTDClBU1eS2yaOYSinoHUdC4USjMCAq62SBOwvHtdZIhfxh7P4qngQxduN6udPpBrx2FY57yQLmHbAxJQVSFen4tmKwmNX1XWFJ3b7H5QiBgkE+wmlR+c2AcqkRwXtIVxtEDT00nD43PxqvtVVG77H+LvVxr9FfR8ruuXFqWqAgzwJihLn7J3b4MD6WGE6kTevDhOWg+I0Ak+P1jSkrxfWuXhXlzdRjlU4TInIpSAxLCMAwZK2qMrE9zAi2n3RPftU23qJnJ2Dg7P9w6iRQN8yuCOMj7LpcNuaDOhJNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8CFDhUHuJMHoiLezJWSp7jKkplg0kBNIzLTgQsYY5Q=;
 b=AQIk/yczMftGHHecoGy2pOZtwpmTio2aQafKjVi+mpXKubAe41uG+B2xQ5ZkctPQjnRRChZR+ex+bcnx3hJ1H3CGdWgKG4KLUwLdsmDZ/UDLbw3L+rW4Rzjj/DAc0TvfhPECdrpah/T8Zz7Mc38umtGW30E5gM0DmTkgI0TpGfmBQmcSB/04nd2Zx2qWEINvam0WWTCsZwnXa0rPdHhwqAHfB3n8M74tr6njBT8M8Opbm3qHdBx1GUgH7RM6pnWpKUa1N8+SFThPjubH/ScTcGbANdC3kUZ7J6+zOzBz/5O/Da2OWJfDc9/HHOvbf+Fc5hCkf5+tYCSntsxhBXtvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com (2603:10a6:10:22::23)
 by DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Wed, 15 Dec
 2021 14:03:22 +0000
Received: from DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1]) by DB7PR04MB5050.eurprd04.prod.outlook.com
 ([fe80::e9d6:1be9:d046:af1%7]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 14:03:22 +0000
Subject: Re: [usb-storage] Re: [PATCH] usb: storage: do not use UAS with
 Logitec LGB-4BNHUC
To:     Alexandre Courbot <gnurou@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211212115506.180629-1-gnurou@gmail.com>
 <9b20ae5d-be8f-59dd-3136-2a9f7ce216e9@suse.com>
 <CAAVeFu+sLzNUztnW4Vyr6ukCyjxTwCT-L4Y2xEWsRx=CPuarPw@mail.gmail.com>
From:   Oliver Neukum <oneukum@suse.com>
Message-ID: <c4b4aa34-12d9-7000-6398-d94a7ebffdfc@suse.com>
Date:   Wed, 15 Dec 2021 15:03:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <CAAVeFu+sLzNUztnW4Vyr6ukCyjxTwCT-L4Y2xEWsRx=CPuarPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::28) To DB7PR04MB5050.eurprd04.prod.outlook.com
 (2603:10a6:10:22::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf4e589-0d65-4e9f-3646-08d9bfd3a784
X-MS-TrafficTypeDiagnostic: DB8PR04MB7148:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB8PR04MB7148603436EA2AA4EB832C54C7769@DB8PR04MB7148.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyRkH/zTr3qi9zTp8Y+b5axYzxnTuv/R2xGHPpX0MRXUETOKhraW2I9jqeA3XHb4EUa+B2seMiR6fOQXhs9AnbPKwEug1Tu2CmGZNsGl8hOnuR0HEC5rvlKrwj1aWdTTfSPLLvisoLpmvvOzwIno5HBQ/7J4cpy1OnCXHlBrac/4u3xprrsZroe/zWO8szC9scEqo67gvetauJW7nhM5xhQKqbih7FnHgZf1FS+4VRhIre9X4OqKmuCj9KUj7EXzIeZhpPr0dJ3IEARG7uhTR3tkxtwocP09c281KD/V5GscWLFb2Efyq6f3W0W+PQV/28NDaT6VSqk5hiXR4rVfJS7VUabO3BD0ZLuTfwqph7OVJ05mUz7zcZMje8v/E7GIGKF4qHtW06p2ea35XQnQc1Ysi1Tr7pc0LHR/yD3SKP5aQw4pn9PfaIlSzHF24oX9h2LAm5iux6BsJgVoIOYk2SiQ8+jfTdTWNoNxofHzf7dJQvnK5Nf+3ppYyApHT4Js1posDIpWt+lSRL8S+HMfsF+wBTAu18rLtIv5rJTQsIQRp97T30ojF6OyXtjyO3V+XJfAZHFGWOexHRYhkRUJMcj+MR48YO9+9oqWorEE+/Gij1dx2zLwluYxVXXwaO2LeQK+HHZ3eIGUyfA0jwguEcj+dl78jtDnHHzipHVem+JlwsrBwwz7WB/9NpXLNIciMWtO2VE5e5ZZnyPmVERklC6Mi2OZwREiCc/DB8kTR5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5050.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(508600001)(53546011)(4744005)(6486002)(31686004)(316002)(6506007)(2906002)(4326008)(8676002)(66946007)(66476007)(2616005)(66556008)(6512007)(86362001)(36756003)(54906003)(31696002)(83380400001)(110136005)(38100700002)(186003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmUTCFgqL+3/mmeIamFtC7LnVplLGwQjgjenO2sLiqEyjSPY3gqfEghUBKcT?=
 =?us-ascii?Q?9eDMRLZUl9NUw7Cq8xDRnb27JdwIPscKuUEuwqbgXRGOXOu5MgyBQgvOK/vU?=
 =?us-ascii?Q?V43LcE+0kmA95a7V6qpnSgHj71RaEWyeCHrwqIxHNqSwAKk7TQ3Nf4eqqH1y?=
 =?us-ascii?Q?kRfvudNpu/LX1XVUQ+pcBUFzXz9Dr8506SE4Z0sT4u9N31h17Rc8HF3dVv5r?=
 =?us-ascii?Q?IfITgcdZXF0laXp1kgxCogZ3YnVz1XDZ/6RHRWRGSxNHccGVBLZRH+6Jm+zY?=
 =?us-ascii?Q?FAGlmIyREMwmYFz2L8Xr63rwiHonWKPEDHo1IUeDemMmUAZQH7Db9lU0A5XV?=
 =?us-ascii?Q?rfJI2xmCTAUFP0ByMZO4M7xbu6q2MLgZtk7T4brkvS52PAB56h8fvQjw8FhB?=
 =?us-ascii?Q?5+pNGG09cjc5KQWYnDKOk7eYkoOoF0+7WMdHROm7p7+xaiUuAWwftxN78WyM?=
 =?us-ascii?Q?5A1KawLj+teZ+jUAp7gSBOX251uI3UjvBycnm3TjxQCC37tRDjkEsvwDviha?=
 =?us-ascii?Q?alfsTKMqSzAeW4xBNmVBFULtJmcMo5UuwYIxTrFjWh3imdPk9qTyEM61EZ8X?=
 =?us-ascii?Q?D0NVR3PBe3Cn5KHhcFbPjzkMAyKIOctzWC0wxm9480frCSvyodda7pqQ5XjY?=
 =?us-ascii?Q?+lna54++KzFOZxV6d72cBpm9xKnNXt4qUc5FDoxACG6XOulDD//+9T6PGdQi?=
 =?us-ascii?Q?LvaUW9yGo5BSgBWYdUQrvp7UNmM8KR6BvuhUkG7+Tfa+zfKwas0isrAYrNRX?=
 =?us-ascii?Q?S0tdNPH8O8DvCmJoE7fLOrLlnVMdZ3E9IoQ5EtB3G7ZFwd0a9CDLKsRvQM+W?=
 =?us-ascii?Q?XbBdQATlJqLnsqgIoiunqNe1K6rjgiygyGcrTld6avtP8w1mW+StDBmcjWln?=
 =?us-ascii?Q?LgvG3Tww6Dq36KjnpGUKRRvN8Oey/gZDkPTfKszUZtQRUmOFpglc/OqsWyWk?=
 =?us-ascii?Q?E52kY9NG5yvrQ0edEiaizA8qwuKvApGgAL/RJ+2VH3EaWqpJXWg+OE563Iop?=
 =?us-ascii?Q?2I6LlwUZnEY/9yDtFpQUeoLV4mD/Lozoo0A3XzGblqzk/NlasMtdl0EC4f25?=
 =?us-ascii?Q?9pigoXcC7xz9Od3LMoITO1jafLwqEJ49/rI9U1c0K1rLh2BXV70FRHJgr5BA?=
 =?us-ascii?Q?J9WxzJLZXhEOi9H6xDpU7lSCW7I8DNdEEH64Z0lCKFmUaNJt3HugfRrqSDK/?=
 =?us-ascii?Q?Zn43Zi0rX4E833JA7uv75Id26zHQVf5bDLLFzER58qvN2Ut0m+O0qLmJRGP3?=
 =?us-ascii?Q?dl6ysM2yt1T2rs50qcH2OuvgC1xjeoKjaeaW2iLvQDVXRFiaYpzYopgHqu0r?=
 =?us-ascii?Q?qwJSSjT/rHWc4biLJX++EXbEYi+OpdUkDl+bYaF4eX+A2Qrd2IyyYFcPcayu?=
 =?us-ascii?Q?Go5geTt9AAO9JHzjjs69YwH9x95WreOji8Ti89GJMt5yuA4sYLybQ0lFYT2N?=
 =?us-ascii?Q?NvD++sf6fk8nzcJ095H9m+zGdAD5rCCPhtn8DPTM8EIEjsrci2lI8fz+N3Sq?=
 =?us-ascii?Q?BFFMFr75k0a7I0poGpQsxVR/6aZaXKVBlyzO+R4lW0GQkc9M6IMcSN0i7rOy?=
 =?us-ascii?Q?kPNuZGdVQ1Uchk/FZ/CXjs7PotcTkSrqtekolp9XSzrGTWHODHZyuu8rfPCB?=
 =?us-ascii?Q?l7spHe5bKDfi7yjJTkqLOR2dZIIKcT8OlOnIeypnDcZYs1Ok/61wlyi5mHv4?=
 =?us-ascii?Q?4w7BSjaLVqwjmZgVLXxQ95YsMkw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf4e589-0d65-4e9f-3646-08d9bfd3a784
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5050.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 14:03:22.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3aPwY4+1+wbColrEIpAyhnC21oz+L6tTdhUdbT0bVG3ZfgGKb/Q5pSXb8OQDuOeWW/xP0+Sb0jDel9xNOv2YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15.12.21 12:41, Alexandre Courbot wrote:
> Unfortunately I am not familiar with the storage subsystem so I'm not
> sure which quirks would be good candidates to try, would you have
> suggestions? As for the command, reproduction is rather random and I
> did not keep traces of all instances.

Hi,


could you try "fgkm" ?

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

