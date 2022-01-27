Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBC149E76F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbiA0QZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:25:10 -0500
Received: from mail-db8eur05on2088.outbound.protection.outlook.com ([40.107.20.88]:44833
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238370AbiA0QZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:25:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCPusrhWuOlm/HWuG8md6LynvQ3VyVacgAdswCm54aGsesRsEWQj6LaDGoIE0A93Hz/35JuBB+pk0ptVfWZeAawRe9TloaMFY15LJDicuEENNucpVz9nGlZP47sPr7+KXx0AtuGq3W22a2ENDvZxZZx3qNxHKVJAoivL1Dsm89ZPuYJN0VGsqgRzJhUBX3clha+pevtwhmvEWp0P3WSGleRrmen7H+x0YqaGRoGg3rhT7oktg1vsnvIVIMJ3mImEh6H5hOsin34VwXukzJ+AZ+NDJqwZo2/yt1GPlbukOGWEMqyO2lH6f6mN6lUrY3DvEuzneSsi4phiaZc4iJYWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1WtZYHgtjE+tUoDW/5mDGdYJN6B6Ev/jQjKOmnaSoc=;
 b=bik3QbEvy43xi1zZ1hoWz23/+sGBmdzsfgxb+17ki3xqcm/jemGmjd+RHvM0XRxkgsA9lzJU3vj1k32X5XF3YL+VcSNhU8kMnFzf/+O6H+gJ6Momrawxp+aKdY1KW+Cnxzv71CdUka8z3qAPq5ztxfPbenqrgKamK9fdcAT8R6UpaHZX1wysHsD+xzpVuPqJSCM+ztI4Adfp30d8CMpUwXMOgOkcXNhRp0U1hO28S3/dOFmnf+mX1h0vYSAi0j1WE9YjRR41gw09YEY6MhBJ5y9rdDstwQQLKvrM+mb9o3kZm+IO1v6RpspCapAMqUPxuLrP6pspSGOeGO0AgLXZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1WtZYHgtjE+tUoDW/5mDGdYJN6B6Ev/jQjKOmnaSoc=;
 b=qJzatd1GGkE+rKNA7+cMhxpwhWMzzkVd8VWZiwD0MuTIIN+qoUeeD+RRFVifHCVjY9wp6kXT5+7n62ydRxgqHY/noJWNrW6kxrXmhuZ8y9Jc96GoNmx7L6eJ90bffFvhHu0j7mIeBNDW22PmQlkl5HvP3HCRC6UW7U5JNimRD+B4CnMNKQbfVL8VtZrL4XfGXCo14FdWRzClvqUDKKBM/px3Jze6SBJ31pGpm78Ey1aqPjKFsA+3BRqh/EAziTV/7JO18KqGXjnxED58eLQJ+XfS2O/0gFTVaRnDdhpIMazG0DRn9lBB3YdOEqqRakFOPP9/TI/Y+mA7cF8m4niR+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PA4PR03MB6989.eurprd03.prod.outlook.com (2603:10a6:102:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 16:25:07 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 16:25:07 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/2] usb: ulpi: Call of_node_put correctly
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <20220124173344.874885-2-sean.anderson@seco.com>
 <Ye/AUUlnuHBoGxab@kuha.fi.intel.com>
 <dc30490b-15e8-1b10-beb2-eaaa10190649@seco.com> <YfFG1gjpjAkiG64+@kroah.com>
Message-ID: <90e32914-d66f-3ede-b104-454972b01ff2@seco.com>
Date:   Thu, 27 Jan 2022 11:25:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YfFG1gjpjAkiG64+@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0073.namprd02.prod.outlook.com
 (2603:10b6:208:51::14) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472ec5ad-b26f-4490-0e5c-08d9e1b19493
X-MS-TrafficTypeDiagnostic: PA4PR03MB6989:EE_
X-Microsoft-Antispam-PRVS: <PA4PR03MB698900156468E5B07A1B708296219@PA4PR03MB6989.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30Alwpcl5Qyt300AI9OW+CpQNKpM0P7xLmjBTFuK+I3sAcKjZcOKniqSVTczwjZRDCi90Lyi0DDzP2wjfCoVSGEoal9pc6OUGK9EoKLM70rzydCFZzEU0jE0KQ0Ggi29iMrbY1jjCUOUQvmLMnXoD9qHL439md1e8F3YenbX4LFetcrUdizP2QL2N78Pvnx6vQHoFv7Wu3U4Ha1WdfOwpw7FXBLwUIF1k3s8vHPFb4csI7xL9JOYxZ6Latt5Xpdc39XwMkPaBlfx/MwEkGlhVZ+QScIirxPMqlnwOxGox9lVi9jWYrzmt4ZczrEtSFhcF/jBzhTTw+rNvZEoeTF5kjzmjPwAzXP6o7jJKfxZf+waBSKaN+gOM9Dr6DVTDFDnRu1/mzUm8WipwDGWv3wVn7DV4Y8I6u08tQvNuchzADAIOsYaWd5LTNnckfdx+/HeQnano7AJPi+iW2mlD6a1NmCvnbdA2noBsIKjUk/bc4V5e5vPoiFLOG/iWZJpu+XGnhE5R55sr0uJzBF9JoRwK1i/7hEL3b87T3dl3/KXJpId6LGiy2lQnjutUlQLdYdXX2Rh2XGn3ZKtd1gCST9Vi4PhIrcRGNpSclamtzaKeIEr+4hP1HCDsshSOPRpD881k3MqpyLmOjAhLC5Le/9LkxSgrradPBdc/iUPPrBpGQ16JHP3fA6GYyM6ScbdpT577DBGgOOklVYjNirAMwU4cIZF5X5QnQNcL/KB2+vesCbq4sKXEdcpUVXPhbZdJEWkg80FG5E7ZfVqYDwRONpohw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(36756003)(6486002)(4326008)(66556008)(66476007)(6506007)(6666004)(8676002)(66946007)(5660300002)(508600001)(8936002)(52116002)(53546011)(6512007)(31696002)(316002)(86362001)(6916009)(38100700002)(38350700002)(2616005)(44832011)(2906002)(186003)(26005)(83380400001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUlORDBJVlV0KzJNQkh0cXB3bUNPUm45R2xrcU1hUWNzSVdzKzRwK0EzU2lO?=
 =?utf-8?B?WFhBV2E0clNPb2dPY2ZieStmMXY1TjUzdkttOVV6RmMxLzZrdjVDN2o0SXp0?=
 =?utf-8?B?Tko3dE1zY0I2VUFEVm1rM0lYQzgySVFWVngzOG5XckNVRTBrNEllNklwV2Vi?=
 =?utf-8?B?UjV5OGNKWVZTMlR6VjMzeDBGUUlsak5qTGNCOGJsZkVrRXdRWEttUzYraDly?=
 =?utf-8?B?VG1VRzI5ai9tWnd2d2hQWnJiWGlEeGlDdEppbG9jQUcxN0w5TEhqMmQ0N21x?=
 =?utf-8?B?RGVGN0FqcEUxOXRmSW5PZkR2WmhPZDNScnlWVStpMWhYSEdwYWJsQTZ3ejZK?=
 =?utf-8?B?NW1aSFhEQVFVb2RYTFFXenZZNjloUFJDdjh2TVZ1T3hqblArOGRhZmRNSlpJ?=
 =?utf-8?B?dEppRnY0YkNPS0FxUnM4cVJqdXFwalFDbWxzenRBZHRBQU44QkQvUnN0UW9r?=
 =?utf-8?B?SEpJbTNVSmZEcitqYUxoOWJSSDc3Q3dzWHNocFU5ZG13eTZrUTdIRXZLKy9G?=
 =?utf-8?B?UFZWN05DME1RcDdDV1dIa0JYTEJoTGNQWXo4bzVjQ0JtUDYrR0dUdEpQcHFT?=
 =?utf-8?B?QjFYYVpqaU82S2Iyd1VkM1FvWUtnQkZRVktoTVJEZFZ6L0pRYW92b1dLRHl4?=
 =?utf-8?B?c1JYL25Ba3Qzam1kM09zelJGc3p0LzdJTmNaTjJST3EvRnVVbXdwMGZ6NUE2?=
 =?utf-8?B?U1lsaUhPbG5WLzh6NlRSOWRsU0lOM0pPR1dTU1V5THp0QklMUGdMK3d1NGNW?=
 =?utf-8?B?dWVWcUtwTXRqay8rUlVjeGh5SElPbzMzcFQxRUxWWXVrWGRndk9IdHZueGV6?=
 =?utf-8?B?UTFTYktFQ3k0cEdPQTVQYXIyNHFucVhselRVVUszTVo0dVdWQjAxUXZOZ3pR?=
 =?utf-8?B?K20wUTVHUS95aXNIcWh3KytDM1d2dXlDS3l0dS9zU08yaGZ1UXJmenpmVjJB?=
 =?utf-8?B?dDhhcmJpcnA2TllNekZyNFBSRnZDVG9Lb0U3VU8zZGg2eFRJaWMxS3o1UXd2?=
 =?utf-8?B?VktoZU5hdjhSeE5Mc3hOOFcyRmU3dyt2cm1JN3BRcW0reHVPVjBmMHEwNVV6?=
 =?utf-8?B?WjVGKzhDTVhweFBvcWtRMGpGSm05T1h5L1Z2Ym9sdVU2UGpubEh6T0pZTjJR?=
 =?utf-8?B?V1NXcmczeWtsdno5YW9SNFhKVFM0YzRrZFNLQ2FkS1QzSzNKQ2wxUU1yWXRD?=
 =?utf-8?B?RytVQW81VVM5cis2eUxMekNDYWRRdGx2ajFEdWFlRUFVQklIdFJ1bEFQNC85?=
 =?utf-8?B?OFZYYnpJTVU2cFc2N0VXZXYxQzB1NVNBaWR0OTV1TlpHaHlReFRBVTJFMHJn?=
 =?utf-8?B?Q0dKOUFrRjBKeGNPVjJFcnRleitydW9mN093QjV1cDRFUUpKbjBCNTZDZmpl?=
 =?utf-8?B?c1NYNXlSWTZ1eS9SQkJDZDZOelB6TXhHRE16Q3hkLzdRcWpYMjF6aWVpenlE?=
 =?utf-8?B?L3FnaFRiRmQvVE1aNWJ1L0J6a0ZkRXE3N3VhSmlpTlUrQmlJTk1RNlhOcERs?=
 =?utf-8?B?dDI4OEtBT1VrejZnSkluMmJNS08vV3pIRlM1REFFWC9RdzNoZ3lMdDU3aHpZ?=
 =?utf-8?B?amtXZ2pDek9OZzA5ZktWNUVIeGNBOWV2UlNPN1hjdVEydkxudVJJZHRYYUJi?=
 =?utf-8?B?a2FHVG51THBkaXRLYmN1TTAzNWF3WkN2MnJGU25jRFZlcFFFY2ZPUXVZRzJk?=
 =?utf-8?B?NmJxVnY4ZmNoSFVKUUJ4aTdSYWxjN1ZieGIrMmljK2Iwa29GWWpTUDJSTDNq?=
 =?utf-8?B?Zmczazd3ajdjVzc1aXAyek5FM1pKNkhrU2ttSHdENUtiUUY2MWRBbHU4WGdL?=
 =?utf-8?B?dEEzdWFaVnBRWGRMQWpZT3AwZ21rdmQvb1V3VUp1SldWRGFsSVRZdGFhU2cv?=
 =?utf-8?B?ZEtSaUUzWktCdStPNU51RTI5RTNWVXd4S3FKMTd2UklmZndxMXp5NmpIVm9E?=
 =?utf-8?B?MWdab0RleTh5TjBmcDZRazVFSmt5eml1U25QbnBRZDkvRTJXS2ZIZUZNVHM0?=
 =?utf-8?B?NjROcUFyOURycE1zelB1VW81ZE56WDZCUzAzMXBMNzVUMjdkb3VkL1loU3Nk?=
 =?utf-8?B?VnNqaWhtay91c2ZnaDgrUkRxNTB1TTRxUS9WQTQwNVJMUDRPZU5DYjYxZFMr?=
 =?utf-8?B?aEN0cXE1Sm5VcmpVUmpkS3NkM0xYUGtaRXM1WGxWODJSckhRVlMxQlJVODEy?=
 =?utf-8?Q?rLl3QAILehn07sfwiM0trGs=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472ec5ad-b26f-4490-0e5c-08d9e1b19493
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:25:06.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJEqXMCTtqhrfTZy34xT1elq2OcwqGDkjkcIakKDaQB/THTnu9g89Cxn7Cckr996JLYTJbO0jooXJMn0T0g4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6989
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 8:04 AM, Greg Kroah-Hartman wrote:
> On Tue, Jan 25, 2022 at 11:53:58AM -0500, Sean Anderson wrote:
>> Hi Heikki,
>> 
>> On 1/25/22 4:18 AM, Heikki Krogerus wrote:
>> > On Mon, Jan 24, 2022 at 12:33:44PM -0500, Sean Anderson wrote:
>> >> of_node_put should always be called on device nodes gotten from
>> >> of_get_*. Additionally, it should only be called after there are no
>> >> remaining users. To address the first issue, call of_node_put if later
>> >> steps in ulpi_register fail. To address the latter, call of_node_put
>> >> only after calling device_unregister.
>> > 
>> > This looks like a fix, but you don't have the fix tag.
>> 
>> You're right this should have
>> 
>> Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
> 
> Please resend this as 2 independent patches as they should not depend on
> each other, allowing this one to be backported, but the debugfs addition
> added only to 5.18-rc1.

The patches modify adjacent lines, so one will depend on the other. I
will order this patch first the next time.

--Sean
