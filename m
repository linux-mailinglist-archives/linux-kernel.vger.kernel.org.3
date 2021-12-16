Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A563B476A33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhLPGCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:02:46 -0500
Received: from mail-mw2nam08on2105.outbound.protection.outlook.com ([40.107.101.105]:63073
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233934AbhLPGCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:02:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6nlwhKqqndzLJSU1hiAmXW1SugHX6jvSC4owmQwTGMCDLfVY/dvAWu2ZTB9365lE2DOvuXv7ZLMfZsqskk21JTLL7TJhPI835lPo5f6/wuSVlrVZcAaEWngxBffgv5IdggB/LiSUImpiJK0RZFtyaiug4aem0Kwc3xO1WcdDXT/IfXK21zeqMtXKLQN30+YZnauQewwddK8kwfWvbvq7abW4fVTY9k1au1YWvgPvkOSZrOFKT1kTDp8FM0ZQ8WvDfS6b62sWYZhIrkROm3OuY3bnmFpm7ZEi+O0arziqF+9kN54ouQVD8XREIBIiL56Mcu5+nWVHCJAm/3hWOd5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCv4CL0PYnN6GtuoR3e6uLguRMn0oBDZ1lxCJngFaMg=;
 b=LU2C6AG4Y4gltnmy6XV4dJuN0MhopGPIvK5uPAEZFAmFBS0chY1WOmDuFPtScf6m0Glnmkwi4YTllXcKg7s0JVXGKhEikykuOdMOpIPnPYDW303gnCnzWyIsJoJvFM5UqJ2HNx92cYMrlFoEmlkyCBEsTF0IEmKnIhSS1u2NAy699sfzMAVPJZzYHkIp3KIpeDDbndHw71A0Jq7hzy4j9ZQq9kHAQFesRA0BrcbUBu9dvskIrKbK+dq0oQB76eQIi96I3jdu8p7w5qVB70Fgd2vMSBXziQgYhIaE4+RW6/ONbRGP/X81P+6izeYm5Z3IyOFOqyTD+HSLp2JKNNkElw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCv4CL0PYnN6GtuoR3e6uLguRMn0oBDZ1lxCJngFaMg=;
 b=jFoIDA7UiBZKx+Ot5spXZ78EX3iUZLbTaZziSUY2+REwr945tbyqg36LxrXIiAC9bO8tWV2b/Opuu+7Yolbof7/ndlPnYrD4q3Aw/6L/dVZAqAmTYxWnC2BvV5J4RvDTKk1zYmEr1Ulp1qTslLW9xIq5RtaUJEJ1ZSvYHb7zYtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB5579.prod.exchangelabs.com (2603:10b6:5:150::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 06:02:40 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::38e1:cab:501d:6b96%4]) with mapi id 15.20.4778.017; Thu, 16 Dec 2021
 06:02:40 +0000
Date:   Wed, 15 Dec 2021 22:02:32 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
X-X-Sender: ikoskine@ubuntu200401
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        patches@amperecomputing.com, scott@os.amperecomputing.com,
        darren@os.amperecomputing.com
Subject: Re: [PATCH v2 1/2] ACPI: AGDI: Add AGDI tables to drivers/acpi
In-Reply-To: <CAJZ5v0jiLfL0k12y5RZ+9LjLqiBMPqRHrqNQGqQ5Le2yOv7QWQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2112152159220.6791@ubuntu200401>
References: <20211214044036.48245-1-ilkka@os.amperecomputing.com> <20211214044036.48245-2-ilkka@os.amperecomputing.com> <CAJZ5v0jiLfL0k12y5RZ+9LjLqiBMPqRHrqNQGqQ5Le2yOv7QWQ@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27)
 To DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfccaf70-b2b5-414d-0a4d-08d9c059aaeb
X-MS-TrafficTypeDiagnostic: DM6PR01MB5579:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB55790859DD93EB626922EDF19D779@DM6PR01MB5579.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E9u3LJ5f2ampvyJj2AkjH+m6BHIT/1k1BkV81DmiL03NM5s4gkflsV6yRuWNkGHli0X8LqhM8AFoIL6I5V/BQooYUNc7sVQyaqQPX+U2okF+1K6/XZ3a1liTnczZ4wNRO2PJaSh78do91EIm9IPEsEwn768j+wA9s5ZLwhWbc4UeKp8lmPHlo+5VYzgERJ7NYiePvjkF0XNXVRLwyVOILFsg8JEp6tbFlA3fE1m4dy0L7GdT2OdQtKJ0DPKvcz9O9LjgczcBFmQx5NY7y6MaNa3RUciH3dUo8iqLzg6YU8E+YrcDwIRiZrJ/xkVGMJZNS9FSPXDN55cJzlobYxNVahbxR/vQGwxfQ+H0g4Gi6whk7GXHqGP5+u1GoZmNZC3XdRTywaAzSKix8boq6Uxc+E5uNTelFfK7Lo9BvXyAzxrdLmW9s0zloQ+KX/WolZmtL3Uel9z9I6SJL4fbDRwe+hDttfttWkg+CS0kL39UTDDpvFlUN4F7SB0RAfhU0u+n5qhMnRUuZDqVPiyXCr2K5hAaKHqzxx5t8p3yOqy+D8B6JUYFmXbKSlV9cIWRhqCD3inhgL1CXDBDNgjqKWCqhZG9tlaR6TYD31lzYF1PhPZQr4u4aVGzsK5AT6wNoCgLblm8dEWkxQHXRfdYW2FBXlSLQqPv6EhICvtPEmDnytb1mBS55I9u9f7/WJk0qWkvWo/px9gCoE2GVdQY7HA0mEDlprUjeo5+yKExidPKu9KCnRGnVYP2Ll6j2f7qi1dIlp3Ga1e1JBnn3KJAXNGMig1Szuz1WunDKaFJWIhxfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(53546011)(4326008)(6506007)(38350700002)(6512007)(7416002)(66946007)(86362001)(8936002)(9686003)(52116002)(66476007)(8676002)(66556008)(2906002)(508600001)(33716001)(6666004)(26005)(54906003)(6486002)(83380400001)(966005)(316002)(107886003)(186003)(6916009)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XLlkb5LJWpuzZSdx0Lr42JcxLt/xZtjZ0PJJ9eLhgs9Yue2uHYKWTZWAWR1W?=
 =?us-ascii?Q?5xslVJLXjqwLgYoatTxoq1T177i2+9LXLyNpnpWCCjdAxl2ZVGn3dqULa5nX?=
 =?us-ascii?Q?HBpaGT6CU2cY075iGaLGoDQo8ZuNoj01TL4geQX9+Rrcy3/P7ipI0sOq8FUx?=
 =?us-ascii?Q?UKgvtajg+wA3z0UbLTvKNBjl5ZQ8hGt22/RVQvGcn0h9I4dNPo8Ta6DeeW+n?=
 =?us-ascii?Q?Od1J+gaig3e7s227qfGCzf5m8oAAAWsM3OcuzRi4QnCPfKwa+hqgeQir2r7N?=
 =?us-ascii?Q?WuCJ1g0Tk+Cb5A2UUKBiR85poY/JMHmtY2ijzz99CwhBl3qT/u4cC1/WDRYH?=
 =?us-ascii?Q?tpETupIFIFLrDsbcLfARdXtyg+0PhFcZYRsfaB8is5uayTodhHLuhgE3byKB?=
 =?us-ascii?Q?TulKeMVrZ9D76ZNerqtRF2t5h6+DJFO1vIp6CXs4QNO07qRnCpoqybiWCOzJ?=
 =?us-ascii?Q?Ls2QUQCl0dnzKUMPXhZ8NMAAOQSRZGDNnHUa9lvfVdTms0lvJgtYuq16vbFY?=
 =?us-ascii?Q?b8+ECwU54Ll+O0YmBBtCL3meYo/kdQHXPeRtzGJ7Yr+G1MZGeoabuKGdXzwN?=
 =?us-ascii?Q?KVA730ILZN5XvfPqZ6PwkyvIiiY1EwuQWN/viZX30MeNTmoNxQzEJB0eq8k5?=
 =?us-ascii?Q?HLxFqftDVhUGN1pdRJzdsSuXqYshUnX6E02MyHeteNRIV3Ha5OiB10y+mW5B?=
 =?us-ascii?Q?AVMW7AMq5NU8+5tLermWvdpq4ljQybdYORSaDiSPycLiJej2jAAGsRrUcyaR?=
 =?us-ascii?Q?Ib7r8lB3StwRsi8gEgZuzqbv8hxuP4jgnUeeCtY9UXvInD3v59QyaQNmSemY?=
 =?us-ascii?Q?5XRSSY0Jut4WsZ6hbKtu1OwTxOgCtvdBgzRewRw9E21G1HAkoSyD4xRZqzrM?=
 =?us-ascii?Q?o/+g/Cz5597ww8uZKbIN5Z1Pc2B4CsrYbB1UkbKY1ciTkxCRKTetCJPI6dhT?=
 =?us-ascii?Q?CWYLOiirznnd20DZQ3ZBu1aF7c1+mhniEBTfLsayRbRGvco0n0OPEzNZ3kGj?=
 =?us-ascii?Q?dCjDNoHGlzlLaqyeFl7c3AjbWotnFBEdvppOF4tdmnEUr/mIIjVCVmYAj/JP?=
 =?us-ascii?Q?F65PT1WlsWq0+NpY6K2jGgb74ETQwwO5rczRh92iPCO+eGgmzcgONGVXfPws?=
 =?us-ascii?Q?kyCVvBkFgZ8/sG9D1puKsiL6+XbjVWvyvLgBVjgq1WpCevUQPkbowgpXvfCt?=
 =?us-ascii?Q?g36jJvL7qO6lDbR0LGdPmrzr7or/0hoCX8wbfLNI1oGK4fV3TBNPFDPOmC3x?=
 =?us-ascii?Q?3pfhFk/JElyDyGBcOnBSANwgRsMI6F9EKh3EH5S08ZDJ6PSA49uiwwGMMoi/?=
 =?us-ascii?Q?SGMdbSJc7FRLObSPXJ1ASYu9hgAWB1Umd+rZrQw40igQxqCgYQBk3JBWajGF?=
 =?us-ascii?Q?S2xLFuRl0o6Emlr2qZWc+hu3pOQla1UJYaXVoJnL4wdRNHBBsu7nu0s0GR3A?=
 =?us-ascii?Q?MuPeYUXKrAyKfaYmCyNaNenTtOp4jmrzIVGIln+1pCFWxaOOfnJFoOKrXX7V?=
 =?us-ascii?Q?WLrnFWATBpWGVmZN3sAWSVn7+a0yuKnGUbQhLK3n/xyatD5h3qonpnMX7odf?=
 =?us-ascii?Q?zTgovSeCydasPKTzQaXqvnvCQZL3Wut7dal856yVs3yMm2RHuSYBzeVAW2iV?=
 =?us-ascii?Q?lsG3L72Foo9o2LpTvussgullo09/UDnLL35yIzhDqmoilg3zZCiUpWRlmklg?=
 =?us-ascii?Q?QcKQLKYTeVxzSEu/z8LyzkaNgZh/fHLq1mcZiEVj+BcwGr/NHBoV6n0q7AIn?=
 =?us-ascii?Q?HlG4C6UzyA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfccaf70-b2b5-414d-0a4d-08d9c059aaeb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 06:02:40.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uq69BsvwVC1DjwFV+chU5i/dc1t/OdmnRQUxvTcQ4KKjLkMtgY6mpPMK1BhDI5zzfD6CIe3SMEwalknDlnLpT2zdq6KsiDcD9u3c6XzgLhlCIor5daN6tVdk9I/d4A1e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5579
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Dec 2021, Rafael J. Wysocki wrote:

> On Tue, Dec 14, 2021 at 5:41 AM Ilkka Koskinen
> <ilkka@os.amperecomputing.com> wrote:
>>
>> ACPI for Arm Components 1.1 Platform Design Document v1.1 [0] specifices
>> Arm Generic Diagnostic Device Interface (AGDI). It allows an admin to
>> issue diagnostic dump and reset via an SDEI event or an interrupt. This
>> patch adds support to ACPI/AGDI tables.
>>
>> [0] https://developer.arm.com/documentation/den0093/latest/
>>
>> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>> ---
>>  drivers/acpi/tables.c |  2 +-
>>  include/acpi/actbl2.h | 20 ++++++++++++++++++++
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
>> index 71419eb16e09..5e3169bcb9fb 100644
>> --- a/drivers/acpi/tables.c
>> +++ b/drivers/acpi/tables.c
>> @@ -500,7 +500,7 @@ static const char table_sigs[][ACPI_NAMESEG_SIZE] __initconst = {
>>         ACPI_SIG_WDDT, ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT,
>>         ACPI_SIG_PSDT, ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT,
>>         ACPI_SIG_IORT, ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT,
>> -       ACPI_SIG_NHLT };
>> +       ACPI_SIG_NHLT, ACPI_SIG_AGDI };
>>
>>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 71ca090fd61b..66ca85b9f5fe 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>
> The changes in actbl2.h are ACPICA material and so they need to be
> routed through the upstream ACPICA project.
>
> Moreover, you have already submitted a pull request with them to the
> upstream: https://github.com/acpica/acpica/pull/737/commits/cf36a6d658ca5aa8c329c2edfc3322c095ffd844
>
> Please wait until this gets integrated and repost the rest of the
> patches as incremental changes on top of that.

Thanks for clarifying the process, that makes sense to me. I'll wait until
the patch gets merged into the kernel and submit what's left from the
patchset as v3 then.

Thanks,
Ilkka

