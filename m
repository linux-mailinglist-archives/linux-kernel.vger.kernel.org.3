Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18CC48E278
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbiANCRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:17:39 -0500
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com ([40.107.244.136]:22784
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229863AbiANCRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:17:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWpeyNsKsSasIeABV5lVMBDwdXtmuyp9KOFfzqjBO2tC1dchntWRyeInDKfcfawMopi8NC+3R73Z2SEieqWZPCF2cl4CxTgB3MCwUOSPTyTh3OMr7mBK1y9ieY5ViBCfMm1tUjPaw9L3AX2EcJo9UQawv+ajVwTPB0os5CVHrQbAxf+aILZg78JJFOS9diHxhUF2g5Mugi3wccFbfPV8OCPgMITvXc/oTdO4xTXBghe8Z+vNi0TYlvWHtFW7IDwdE2a93E+4nsPxzIklaT6F6RQDjNDKhGjE+IvU6Ea0fj0Nlh2DljCsfZ6PwpvDP5QsIYLQ4Erq8BiJLntc7CAkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnwwctdqsggX53+aRh+i7NC1a+chXsW8dpNBCdAwHBw=;
 b=BBDulWCoB3K/kyh4BkRlqejSak0PYV5wW4YqL7nxI3yMft7fhWYzcHvz83nWBSiqOu2bkaZ9ZdHNHk8DI5rOn422RKoEYYZsoTVyRuY9AJ/J0h/iliuqeiLNrpnRS87PDJdqQr5Nf7443I0QAiztM5HLsmYTO8u0GbnOoJPQJWSzQim+TJtZ7AFhT9X618dt69E1/g+QhJFCsxz3ntGtCvDr1NZCllKmXez2eyaP/zZg4VLjQ4WFHJIQHaQQ6Uc3vDZCtzD2ic6W+XLpOtXniELEpk7fTUNNk9AV3qhZADHCsqOwrrnJX0SDRsrXkHIoHWRQNOKjoBjh+fQPdjBCHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnwwctdqsggX53+aRh+i7NC1a+chXsW8dpNBCdAwHBw=;
 b=vtqZ5V1JqyKgq2Y39Bx5WgM9kj7ZHk40EbvgVcpswmE9KkI18wtHEQqEggFaM1ij9ipvbbSv3c7MZDY5uTwS34FxsXhrV8zwTq3GQo9w5KFrlW1uKCiAQxGLqJZ4V5plIyQs7is1ot82ptpqL4GbgpH2fNdA+w6r5b2FsoHI7Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM5PR01MB2828.prod.exchangelabs.com (2603:10b6:3:f6::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Fri, 14 Jan 2022 02:17:31 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::7952:a45e:f5c:9a1d]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::7952:a45e:f5c:9a1d%6]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 02:17:31 +0000
Date:   Thu, 13 Jan 2022 18:17:13 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux@armlinux.org.uk, lenb@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com,
        james.morse@arm.com, Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: Re: [PATCH v3 2/2] ACPI: AGDI: Add driver for Arm Generic Diagnostic
 Dump and Reset device
In-Reply-To: <alpine.DEB.2.22.394.2201051530290.2489@ubuntu200401>
Message-ID: <alpine.DEB.2.22.394.2201131801380.3166@ubuntu200401>
References: <20211231033725.21109-1-ilkka@os.amperecomputing.com> <20211231033725.21109-3-ilkka@os.amperecomputing.com> <20220105104602.GA4752@lpieralisi> <alpine.DEB.2.22.394.2201051530290.2489@ubuntu200401>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MWHPR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:320:31::26) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 201b03aa-d7fe-4263-4196-08d9d70404b8
X-MS-TrafficTypeDiagnostic: DM5PR01MB2828:EE_
X-Microsoft-Antispam-PRVS: <DM5PR01MB282802620DC425CD5C3B8D1F9D549@DM5PR01MB2828.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2e6V8oJ7hGU6wkK2SasfkdUnVFrZj0fZAXMOAvomjHXDO+DeErfq55a+Z8axDvbf6R9Qk3bvgL9j4wiFaCd5Ms7PoGhd2ZqHIV38ovMMFXYMrEpUKikaiuF81SYUWA+wgYsojJ6e3UmzE2KhctwvZN+8KyBBHnyx5MmA2abHNWxnXFe5J1RtRm/dBKgfPqFNiZ1k2g+SbTZBXWZsmPiwxL3nwui5m7rnTJNr0G1UXzeU5FnxIvMzWS1r+T0He7iY3Rtz0nd0NoZIANnBIcHuQXg2DhQLpfR8xSUOThJCT09ZX8rsoPBJAOUuvs9LtUkX3YQjR3xmQuWqJw5LT4Ubdwe6EUtxMZxv9qCGum0TR9RTIeTTK6XHvBKld8o03Y4KCHDztmaqU2cG41NZvgPWb37aRSsWQPwHLcO3aiO8Sx+C5r/4FOEM2t/RiMYCsagMzQWDNB4BwKVSNfobbZHtDHo9pNkwG7VyUWXQk4Ch2972lkK6y8hYInu9eD25MrLIOsVpOncWpuPGpwaVyGQzSi5AECaELI4A0OKPw7SJaoXRNZUt0/vZFOhVkKQWq75OfiaduFLIXSAPOnFua8w4Fh2dRU65Rw44y5Wpkfy95CT4wIXFR/onxsQ9+0d75il00x0p6zYttGDAGf03QxklPt4A+Vf++U9Gjt7MzcjukvyosbMdwGePr2BwoXKnsM/8DM0hmFJhfOC3fM4+jg87mWHPjwSwDQQtLog3MngvnzTXW4rMZaHN0JZOT0UnbpWY2M2dW4LFoQkH5uTvxBk8BEwDKCk/UL7KeTUb+qkLJwCbiNJ9Gjt+GudYss/60F7n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(8936002)(9686003)(6512007)(2906002)(8676002)(5660300002)(6916009)(316002)(38350700002)(7416002)(4326008)(6666004)(86362001)(38100700002)(66556008)(52116002)(6506007)(6486002)(186003)(26005)(107886003)(66476007)(83380400001)(508600001)(66946007)(966005)(33716001)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Woq/gpJb6CzSTV/YrhKda9hGMBqgQ4b2y3jXVt2QBrBz3Q6oAk1he8uusZz8?=
 =?us-ascii?Q?D4PvmdiEkyEulxIM7cq/RuAJ5TRICjPRlAii3u9jRdPTvBJ/NZim4xOIfeNx?=
 =?us-ascii?Q?ra8lxSLeszxLc1Qj/otr4xhxyOJL2Si1lHTm38fYoLYqsTjpnLWFPu+EA0i5?=
 =?us-ascii?Q?Wkv9fqUb8gJpHWQmzNSsrzgsKkLs15mEuTAlsNs0okCM4g6AtYpzXPLMzY3Z?=
 =?us-ascii?Q?tmQ0VzeoLGPKj+0eQ2tZdYNLkPtK8JmrhRCXMPxKHJnmHUphGiRZYPPAfKjO?=
 =?us-ascii?Q?+yiYVeJDHptuGacSE+PeMelD6jWftvAg5w8yo4twvWP80FxsCapE73Lr1LmO?=
 =?us-ascii?Q?ZaPnHre1ffSEs7JP2sw9p5M4BoUlnFRQWii1RguuLqON1tgYzoipJeTp0lvs?=
 =?us-ascii?Q?WVdaNYw1kavY2kHLjADlTP7nTcZoKUZM94Qzd4T0+15xw/QGkDnU5rWMOPLm?=
 =?us-ascii?Q?iMJMfXoajsNvDQbDydS/qAg0Apj3TlYZvBidI8njP4cpGyaWebz26wA4o37e?=
 =?us-ascii?Q?q6LXbGfbriZ1lAqoOqbzCrdVkX6uLJypUBsVkAT1EyjBDsO+GnJjEOJiWema?=
 =?us-ascii?Q?O7Qfyl9BA5bMdjQyRbhHFLi0X3g9kRloq0tNRnvFP4EwwTU67Oxlzvw7AaQ3?=
 =?us-ascii?Q?ZiJ5mOI8WKJuSvFMr1KCTJTTQXITYuxintwlToS4WdsIYty9HniXnTyHBJ8T?=
 =?us-ascii?Q?nYju+K9LMogoLL6s30gN97oHKVx2WITDZXSeEMMcSChbLW/7LnzE+MsG/Du7?=
 =?us-ascii?Q?boqa/TCyZuwIYWSrMjTKq5onquDwZfvCzWbffxT/m5py60ZsRrIo/89fhR1X?=
 =?us-ascii?Q?NJW+CfvxqaXV8212ot4VqQIvp2TYoJLJAtL3zMjk3FzW6zzDglZPe/9BZMGv?=
 =?us-ascii?Q?8l9+4ncNRvMMRfzPXaqzYUOO6Ey8rWwLbhVYRVkU40HzbxFGlNXtKp7Af8/l?=
 =?us-ascii?Q?brgL+gPKByO+i+WktoaY1VMIG08umofZZR72AOPoQ7TjN7cMHg/GNRfPpRLA?=
 =?us-ascii?Q?rc6s/HakWcWOWN9X6Pi8XyHLretzjB4u6QjOFOZX72h8COKAj0AV2w06p7fG?=
 =?us-ascii?Q?ugCAoE7QHLzwtjwp4QfNCEwdRoIaEdFEoWQcfSjBlrhqGD+FSHuOysAmg8p1?=
 =?us-ascii?Q?ni0gRBU6jJktRrY7a5bLeuUB2dKQApcYxHNBsbYbMnpzoTUHw2XnxpP81ncS?=
 =?us-ascii?Q?0dGm5lT2CGFAKoPHvQ9uJHuSuLv3GbFR4bqeVp+CxTzaUUdhBlxls8xw2T3/?=
 =?us-ascii?Q?NrHgwKu9rPFnMAcnKCdLpMF8oiGPakY08vb1ApKkwUs41J6NVS4zOqULztnd?=
 =?us-ascii?Q?3kZSPYyK9hBfoJ9tOYUzqNTvm57fmsam8ZR1w+RdpqHCWsauGaHI8weWAfbd?=
 =?us-ascii?Q?Xl4kT2jQiqMxLly04CXdio+HTbXtjrJ1bl6xNdgF2foVgeC5r2Iyts/HMxD6?=
 =?us-ascii?Q?nHkfp6gRLt0RXnKXxq2sm4OuTKfFB9mWW0N5OvH1IIXW41RbT+YqQvY4OH0+?=
 =?us-ascii?Q?WBeuUnEk4YDSCwWltW5w4XW8EzRaSyPKVSxS0L+iUFgpkIu1z0wy7KWWQMyX?=
 =?us-ascii?Q?r6vTLyNG8JASxk46JOxdGcIZSfoql5DyrevgwWmXw74/Z8fFNMEifOC2EJLk?=
 =?us-ascii?Q?nASP6UON/Oe0jGizslinn0kWfWgrD1mzOfYZmArELp5p2XMY8jowIq6txdt9?=
 =?us-ascii?Q?Kq4JHTgWlDscvg591/3VzaDDAXJTVHjwUe+TsWDkUAMMvpQAKTHxhxZ2Jb5k?=
 =?us-ascii?Q?cJallptX8w=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201b03aa-d7fe-4263-4196-08d9d70404b8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 02:17:31.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxhQYReU3OUGAyNQrp6D4TuTTpqDkrrbqy5YTnI8hvJAq+9VjY6H4Q0ohhHZpavSbi2o8fv4Pcz2twci+dmwcMTqrY/XryzT19bPDfazRTCIymzV7CKFnK9UgxZxGWS0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB2828
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Lorenzo,

On Wed, 5 Jan 2022, Ilkka Koskinen wrote:
>
> Hi Lorenzo,
>
> On Wed, 5 Jan 2022, Lorenzo Pieralisi wrote:
>> [+James, for SDEI bits]
>> 
>> On Thu, Dec 30, 2021 at 07:37:25PM -0800, Ilkka Koskinen wrote:
>>> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
>>> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
>>> issue diagnostic dump and reset via an SDEI event or an interrupt.
>>> This patch implements SDEI path.
>>> 
>>> [0] https://developer.arm.com/documentation/den0093/latest/
>>> 
>>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>> ---
>>>  drivers/acpi/arm64/Kconfig  |   8 +++
>>>  drivers/acpi/arm64/Makefile |   1 +
>>>  drivers/acpi/arm64/agdi.c   | 125 ++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 134 insertions(+)
>>>  create mode 100644 drivers/acpi/arm64/agdi.c

<snip>

>>> diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
>>> new file mode 100644
>>> index 000000000000..6525ccbae5c1
>>> --- /dev/null
>>> +++ b/drivers/acpi/arm64/agdi.c

<snip>

>>>
>>> +static int __init agdi_init(void)
>>> +{
>>> +	int ret;
>>> +	acpi_status status;
>>> +	struct acpi_table_agdi *agdi_table;
>>> +	struct agdi_data pdata;
>>> +	struct platform_device *pdev;
>>> +
>>> +	if (acpi_disabled)
>>> +		return 0;
>> 
>> Why don't we call agdi_init() from acpi_init() as we do for IORT/VIOT ?
>> 
>> I don't think it is necessary to add a device_initcall(), with related
>> ordering dependencies.
>
> That's a good point. I change it.

Actually, I looked at this more carefully. acpi_init() is called in 
subsys_initcall() while sdei_init() is called in subsys_initcall_sync(). 
That is, if I call this function in acpi_init(), SDEI driver won't be 
ready and this driver fails to register the event.

Cheers, Ilkka
