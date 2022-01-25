Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C9A49BF58
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 00:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiAYXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 18:05:43 -0500
Received: from mail-dm6nam12on2114.outbound.protection.outlook.com ([40.107.243.114]:44859
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234612AbiAYXFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 18:05:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m42zKkYm37u11lGiVcezgx+Opx7Z99EYxUxQjKD6MvrKTCSrx2SSBxxNaYYHr7vftUi9sw6zJvT9FS3SFsTnWvP2gltjQvgXzoMDcEsQXFPvM16lX55/KJZA0imLWhufBkAoRcSTfLJao+LE+wJqBnrnbd3RC33/aKjnS394/xVvFZzTT53f9l0yyUmnwICBZqZ5jQ0ewfLrsvZ5ld2ZR9kqQNVh/SfJTsnkxHqbEbb2Wg40ry6zowZRxxbKet+KuyFbvhqLllpv3dF7CZ2X6oA7BL771frhUDaGlMTq25FtlVHVIsbvrGcwmCCoHjjZlJXmm7P84kIlU8ZyjhhIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qpG3nTaPL2bYLU98yhSVCsfUH7Tq1rRzfIVyCVXt0c=;
 b=FDL5qCZTrKV/A8Ps9J3YRKY7XzxBBxgI8/yGE1xzuGRYCjLBQEfvfZsT+S8MPhZxb3RiIM2tYBmUDD6DBkplv/9tsRxYYsLewuHvgrJ0pPeIvpjaPKte0vHZSlBD1YXS8Bht2VzCC6FOjYKMpXrE3ikktMTTL6/lR6AkWEzsxPUSm6vB4433bHaaAM+epTXj+iVnQ8agB/1G9MOn7FEqjsWRLl9RJmn/TmuVmN/98w54lmnJTMFR4GHcjwbWyaxKEG9UORMU/kh8UvbcmCj5RDOvwIevBO+CmH4OrjCposM8uBvh5oqnNDDauL/wS2Dez6mSbPkVkv1WYeLop5YxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qpG3nTaPL2bYLU98yhSVCsfUH7Tq1rRzfIVyCVXt0c=;
 b=YFj8572/kbQsLMk50nQSvDuE3FjnkjswdcmXWUrNgb3OaMgHvI1/Auc0NgTGTP1+kG0/fixBBJy7vHXHTROWmOEUUOd1kY42f320+cDlBPljr8JdvemMspzQtgm8QantR5lFnqDH9jzHePuwm95YMZCcAWlNjdYnzbr+8Si/vYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CY4PR0101MB2854.prod.exchangelabs.com (2603:10b6:910:47::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.17; Tue, 25 Jan 2022 23:05:22 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::c4f4:4df1:380a:2ad8%5]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 23:05:22 +0000
Date:   Tue, 25 Jan 2022 15:04:13 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
In-Reply-To: <20220120163819.GA8187@lpieralisi>
Message-ID: <alpine.DEB.2.22.394.2201251458550.2578@ubuntu200401>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com> <20211231033725.21109-3-ilkka@os.amperecomputing.com> <20220105104602.GA4752@lpieralisi> <alpine.DEB.2.22.394.2201051530290.2489@ubuntu200401> <alpine.DEB.2.22.394.2201131801380.3166@ubuntu200401>
 <20220120163819.GA8187@lpieralisi>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CO2PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:104:4::24) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0004d28-24b5-4737-14d4-08d9e0572991
X-MS-TrafficTypeDiagnostic: CY4PR0101MB2854:EE_
X-Microsoft-Antispam-PRVS: <CY4PR0101MB28543CA6A1E9C3257B0571A59D5F9@CY4PR0101MB2854.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17qBUqcmv5razoKzHcSClzKnm/Kzt7JxzVpLj34MAi04CWaGibgWCo9R3FQoOdiG+RvxKLKqYHUU9WW29twQ0PzVAnmga9Evgy84W0sbRxo8u9zbVPxzzuJQxaBsD51GK9Wti43TQmS1LkwJgTf6JHlvEkKFx4HqMsiJC9ZTYw4VroBN+ncW8q9uLPAV3bdQhMMD94lGHsvTR3tktfeLSsxp+bZ/51V6bf7MLgYifP4I7qBATr2nZQ5hIm2KzIyToBkBHmzCX021sGWJ18gA2HEhrI5he2/DqOOU/fuYcbA8iTrIDidBYjcn6RpWw4QpKQZ9rBBo4H6Dz8zpsBRA0QbU7dqiakeo7QF8VkTMpTirAZM07IiI6lGVHb5n77NOkfICv0Ai/1/vuXhUCok2XjDQ8up3q6IBTki4rfMmXXgVvSDx0+gmZKFmzRwm2y5E7jQJkJVBkrkUSlUzZTrcblhdpZOqtuc49iYmmUFJOWdfsdFVlZEMHh2lOg5j6VYmjm5h3X7qHtAH/unk5Mijelw2SoZQmNORlRAFokYXPx0KwXshdsJt/SXiT/m8Zgs55uoxGmdnqtEvWno2KGpm3AlI7GqhL6jFvfLPKhduTKpzixAlpq75TMPxqUHGtE6T83CiQxnrERi11Ae9jVW8RDnfuueS8xFDNmts9drm5XQ0FD2jqwhDTlxvJbHW0d9vB6OVrrR+BFcXxj3dzpKXwA0YRIQ4KtDxcz0ktBtty6Yz6z1gIkzLzzfS54HSttooH6dcQOBswdHtbZxk4gwPPEviNTLO1rXfMESwQZnWEAjk0Zl6WoGfqkTfpayugbHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(33716001)(186003)(66476007)(8676002)(66556008)(66946007)(6506007)(38350700002)(966005)(26005)(38100700002)(86362001)(8936002)(83380400001)(316002)(2906002)(52116002)(7416002)(4326008)(508600001)(6486002)(6512007)(9686003)(6916009)(5660300002)(6666004)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dqr9lwBLMdvJXZ9jtEEHxZ4mfJF9LefDxA/6BkXUJiYtyw6njQm1BbDrF7SZ?=
 =?us-ascii?Q?Z2F7acEeOdCq66/KKKzGrnbugvEodF+t3dFQP3tRisirdcjBRR3za7Nrxjaw?=
 =?us-ascii?Q?7BBq4/i2so7nWR54UEH8109edyE81mHL25jWGlhYBq7wmhkDIvUiel2g41UJ?=
 =?us-ascii?Q?bKpcqa0q1HTY0aetpQA/QjjkMZrMTEMsd8X783efqXRI8XCXH2dv/Me0dAfA?=
 =?us-ascii?Q?B782f1DR6kfr/zXAMDUGcDbTARx1ym/gt3WqeOA+lF0GFzGWfWp0J7IOXhtl?=
 =?us-ascii?Q?NV7RoiUkQh8RUEtuqtPApYel1TSY0+zuAoG+uZbPIV8wea5pkeGXJkhPAzGa?=
 =?us-ascii?Q?zpl1tVeWR3JjetFUxtG7Tj7cvx51aV/iaiEGOwUkWstea2g8t6ARWd/9pSh3?=
 =?us-ascii?Q?evSQGXpPTWaIb8duCOPE5Bos1U4z64irNStAnWjA/dZilSP5E820kJiIa+K5?=
 =?us-ascii?Q?qrgEdQge9EStI+twORDIrDBIm7ZKMsovpfFepaQHbCjvpiLbuZxP28Y2MvYa?=
 =?us-ascii?Q?+yimypROrPQKh1hvcV1VxR6/VnFz7kZCcZnqF9wkHXcnwMsMool06e1juUKl?=
 =?us-ascii?Q?ZSayQpV/zbAEn5JeD34G+IJ5KpZfsFbwLO9faII6UdzUSdcip2xsD32Jm/iA?=
 =?us-ascii?Q?HuVufwPzaH9WfMp49Ym/dXn8GVMHQWncv2NfWbBZLbKpuyqK3ra6F2++VFHv?=
 =?us-ascii?Q?y2iPqEC0Edb2LmBwvo35cPScICHk+BiLGnFWfQ6p86OK41RFTzj9Xlk9gRvF?=
 =?us-ascii?Q?6M5ymQkeHt34pHEKQslSkyMZACRqiYaIz6OZVDb6UBwpjAKtn/ZvPGwmF28P?=
 =?us-ascii?Q?yEEJxcySZ5Bu0VXbvDS3tG8SFf8HYyUqVtdPnI55W38VyZLWMBFPEiH+69pn?=
 =?us-ascii?Q?Wle8kOD+br5WSbC5Gis3Dh4YPFSXBp7ga8WRXUph9OfH8hvVrj+0QCkOCg17?=
 =?us-ascii?Q?Q9X8KJlA1627d2oOXNzNiVBr5tcdtKlVoqSLbQPWe7s5bq24ET9EDXWlH0Kf?=
 =?us-ascii?Q?q5CFLXZOXjWhmku6DkAbyq4+SzffcCdiLY+VUNAe+JoIahKiFu8u9VSeaPPK?=
 =?us-ascii?Q?k0RdLv0PSWGQrihgTbGsl5wtUy/mcU2crHw0gBR+IoC0/U21LeJElZoI9LHC?=
 =?us-ascii?Q?6cg8UbgmRyopXh4CIWm//1p6K8o306FnIHoCiDyJO/HnegHm3nsPguLOU2m3?=
 =?us-ascii?Q?vWsGIu5gkz7/la1YHW8lpjOrHQ1rRmPpye58bBHqloxGJzW0xpjmmhciNAgw?=
 =?us-ascii?Q?+1Gdj0UBYwZpvSHoIcwGIUhhmHNi8kzqjNbviLBw/q22qALP/5upT5EPO2lc?=
 =?us-ascii?Q?2rxqSiZk5m/TUm/3BC6PgTb2Ot/byzX5jaJuJKktfsdem9nAqWffIVS5agFW?=
 =?us-ascii?Q?8Cz9cjHF43Ewp8H54EUopeWcC8gOxYZq8aA+L+lhD8CwBc4V+/eS4KWiDRSF?=
 =?us-ascii?Q?2I3BkEFOUf3f+G0bYYLZPgtRQaG02Cbb7/4BV+YuRw60HVSzgvzomeONqEd6?=
 =?us-ascii?Q?p0F4+xg6R5xGc9rAB3hwAwYNvVn+JWPVfapgxs7HVvQKrSuWnuBT2G21ZXw/?=
 =?us-ascii?Q?aFaRY0cJu8trFchDYCEP9yo8X2GjIf0k0kr4Sb2CtYlFO6+SlgzUEf/VKNG/?=
 =?us-ascii?Q?xE8l+ON8yTtbzQ7tXqJG+/kNvU/N+QSlrBP+DfCX60KYi7IYWfL7jJN2JuV6?=
 =?us-ascii?Q?K5cntlOIeDG5UVFrYrJIOgtvIFwFc6tbKd7fQ9QsLjmhdr01DDUI6z2Tx9xO?=
 =?us-ascii?Q?PmkoE+NRWA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0004d28-24b5-4737-14d4-08d9e0572991
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 23:05:22.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvERhhxZourZiZXzruiB//yrlF0M9aDzZwufvwP8VuAbgcV5ifoTfHnrzt+mFrismma5LmLe6kE3cr1pCxWjvwW5GoEzUWLH/k1OvPijbUzhEoNZuvGlMdMAkZfHqgnZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0101MB2854
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Jan 2022, Lorenzo Pieralisi wrote:

> On Thu, Jan 13, 2022 at 06:17:13PM -0800, Ilkka Koskinen wrote:
>>
>> Hi Lorenzo,
>>
>> On Wed, 5 Jan 2022, Ilkka Koskinen wrote:
>>>
>>> Hi Lorenzo,
>>>
>>> On Wed, 5 Jan 2022, Lorenzo Pieralisi wrote:
>>>> [+James, for SDEI bits]
>>>>
>>>> On Thu, Dec 30, 2021 at 07:37:25PM -0800, Ilkka Koskinen wrote:
>>>>> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
>>>>> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
>>>>> issue diagnostic dump and reset via an SDEI event or an interrupt.
>>>>> This patch implements SDEI path.
>>>>>
>>>>> [0] https://developer.arm.com/documentation/den0093/latest/
>>>>>
>>>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>>>> ---
>>>>>  drivers/acpi/arm64/Kconfig  |   8 +++
>>>>>  drivers/acpi/arm64/Makefile |   1 +
>>>>>  drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 134 insertions(+)
>>>>>  create mode 100644 drivers/acpi/arm64/agdi.c
>>
>> <snip>
>>
>>>>> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
>>>>> new file mode 100644
>>>>> index 000000000000..6525ccbae5c1
>>>>> --- /dev/null
>>>>> +++ b/drivers/acpi/arm64/agdi.c
>>
>> <snip>
>>
>>>>>
>>>>> +static int __init agdi_init(void)
>>>>> +{
>>>>> +	int ret;
>>>>> +	acpi_status status;
>>>>> +	struct acpi_table_agdi *agdi_table;
>>>>> +	struct agdi_data pdata;
>>>>> +	struct platform_device *pdev;
>>>>> +
>>>>> +	if (acpi_disabled)
>>>>> +		return 0;
>>>>
>>>> Why don't we call agdi_init() from acpi_init() as we do for IORT/VIOT ?
>>>>
>>>> I don't think it is necessary to add a device_initcall(), with related
>>>> ordering dependencies.
>>>
>>> That's a good point. I change it.
>>
>> Actually, I looked at this more carefully. acpi_init() is called in
>> subsys_initcall() while sdei_init() is called in subsys_initcall_sync().
>> That is, if I call this function in acpi_init(), SDEI driver won't be ready
>> and this driver fails to register the event.
>
> Maybe this will help:
>
> https://lore.kernel.org/linux-arm-kernel/20220120050522.23689-1-xueshuai@linux.alibaba.com/

Yep, that should work. I'll wait for his patch to get approved and make 
the needed changes to mine before submitting the v5.

Cheers, Ilkka
