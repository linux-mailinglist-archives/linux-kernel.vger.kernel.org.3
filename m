Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F6585587
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiG2TW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2TWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:22:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6151C4F6AD
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/c1zlXHtPy+MJOxwi7lIx+b2j4YEz5QBSmqMl9oE7hYekoh+b5yLCfrUq+83cODkXlVzWAj8kNKCW9MY0kdiFqiGsY5AfN3Pzgxg6URhusaevos9e117Tl9MZZyR3p0/HWmN9etojwXsAC9ZfoQf5+/SbkCjAVqSeOyh4YTUtnG0mq2l1ijhSgQ+mlcZpE6ejtVVA+zphff/yC+iG7AkmbMfQja1zO+GNnAwpB+h/qkL2kL1Wr2mgz+yTwXyti43xgV5VchoqzQPm+Xw1X/zOEjSYk73m7NzpLYXyN9H1QhxQNHr7VWdX3yrC2KHZ4Wb+W4pgdAixQGKvXjZK47iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFUQ89UuK/x7geZ0EUmiYvZrF6Y+kjDrmYr0YakvQEo=;
 b=XtDZknQVaQMpPtJ09qAufnhgyAoCMl4795PFm7M110IJgd7tg57qYvMj3xSM/Zi+9qAsZP2F3iz4MFhl1PFDHUWnfHomcl/0TiYUW6VxyYEoy1UIyVYmqwU92eN4FENK5Gkub3OZYltPOL1u4OzturGhGaHD/IdQxOp4VkXER6GWiflwWXrMNXU/DsJOld1+BE8OZQKToMrlirCYJFTKuvb30TNUSAdKCdYrpXIsdrZBVN8PMKTlh3cn2hKixuvaB2qygyVyGhUmVT+D2BsJXsVG9MOxnTDIORWzAqgl4xvEhLqM44CT9HasYShSN8ax/YlMf3rMe1hFW4N8jMlNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFUQ89UuK/x7geZ0EUmiYvZrF6Y+kjDrmYr0YakvQEo=;
 b=JatUaGOLt8z1GYO1V8bofwqCnYvMcuTokg/dOx9MhyILIslgHzXUMPsYlg0fAPvSc41rRUSIhdOT1LX/Tt2CYd0+k/vvNRzjlTZUpkiK2HrQlrWkV6d6SI+wiwKoATYyIFJ+aBmPp85WHAFzZFJ+ARvOAKoR4dfgTlfzXdnEcBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by CY4PR12MB1320.namprd12.prod.outlook.com (2603:10b6:903:40::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Fri, 29 Jul
 2022 19:22:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5482.012; Fri, 29 Jul 2022
 19:22:21 +0000
Message-ID: <efde397b-35fc-c47b-b21e-898fa2ec6920@amd.com>
Date:   Fri, 29 Jul 2022 14:22:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
 <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
 <9da5204f-5c8f-b47b-bcc6-d68ca63db08d@amd.com>
 <377f6c30-bdfc-55a4-bda7-f29c60c53300@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <377f6c30-bdfc-55a4-bda7-f29c60c53300@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efd62e2c-ab2f-446d-22f5-08da7197a8a3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1320:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: atleBMGabiGbyxTdaHWLzu1yvlVJ5h9jFcWbJhc7IsOZkWnNbNq1iJrDdhg4f+HU5MzUFB650suRzKl9Am+n/7F5nmkFOAi/FSJcc2aapaMOAqlK5TMgiOelaEu0VPXfqD1Vdx5QaUvO2a6MsqsGmGUWAgVU4WMJ88osK174egDVxT3V3vRKLalG6zI2TjiJ7QjnhsXpFmzii8J2RTb6e5eNnPXxoV0SggDm75e3SgEC7ng0AQyLdfuHKnGX2wd9Sqa0Q0rCLuy/OwokOYZhFUjJLnST6hi7PZoSDPKxj3jLmC2GVcpFWa5r8zMLZ+jsg3eYNVDXyupfWKIySzcrYxSDzwdCDy7iXzFw79+UMjDKj5V8NhP+8kM0O0Et4iQjGdE+RjM0lauRfAHO/Z+kWYYcEUBcPAzgClKpvJxn67T/gysDQcHShH9E3ZhoUpfgStBa71ZLajA7VcX75aYdU8Ml3oYYnyTPm0bmFgw00KfvuHp8Yu81tUuioppbA/RqWB4yG/+HIiCm9PfhtCaZB2mZ4JF/kGufDzeqfUpyveC5b4nPjb2sn5lRzM0szmxASTZGSqtcQmnbJtr1Xkupotl5e5Y4vXDVDk4LdNvJz2i9ytMYrKfd+U/Z+M9Ex+fQPeCYX/gv6pmpdeKsVVZBKEmDDeHp2d2yDuCiEbNlR4g8+JLl6OJzC4a4KBqmtsyUuMwXwkjImvzH4NWbNzmW8rUf0RUcb9SxcOc44UU0ezueRDl+PWa3TtIwCI0TrJQMbM8kppA0PmcDMHqrLRnyLaFeaschcokPDyL4E4lXZGff3MqeqZ49aTsJ93B2+pn5Wm6u3YfFIk3h6fCupYtfJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(4744005)(6486002)(2616005)(6666004)(86362001)(38100700002)(36756003)(83380400001)(31696002)(31686004)(41300700001)(7416002)(186003)(5660300002)(6512007)(66946007)(54906003)(8936002)(8676002)(66556008)(4326008)(478600001)(66476007)(2906002)(26005)(53546011)(316002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1IZTdsam1GZlRPYXFaZm5GTUVRNGJkMkJYRVhnSFpJZXB4dFFlQTBpSmxH?=
 =?utf-8?B?NndoYWRiQWN2azdOTjl6RUVmaDdyaGJEWEduejFZRmdoUEdFYWFUeHJGS3JY?=
 =?utf-8?B?eFdxSXNVNjM1S3JYQ1ArajRtQURjWmhxZER3U1YwbnN5STRocHFzcFhBdFZH?=
 =?utf-8?B?OXpWZHFNcVZQQVd3eWJ0SENuRE53YWpCd0YzdnM3dWZhM2lQSkZSaWxrSTVq?=
 =?utf-8?B?aTU0V2lPbGdFWXl6UTYwQTRxZ0tjVnRsUExXUmladVB4TEtEZ0dYMnhOWVlj?=
 =?utf-8?B?V1BUby9uZnNpbVVuQWh5WVNTanRNMVhhelZJbW5yWFhWOGRCRXphT1VRVjM3?=
 =?utf-8?B?a3p5ejd0MmhEWUExUWlSeUJhMEFqUGh2SHhuTWMzMXhvdTJYRUZlNjQwUzdK?=
 =?utf-8?B?V2k1Sm9XTE1kWEl3MWhlTVpvWlVBMXBnQkxrRm91dzNqYUxoaTcrWUpGWVc4?=
 =?utf-8?B?ZitIM2h2K2lrLzE3OVA5Yys0WlNmS0xKTDBXWXdiN2k5c213T2JjS2pldjk4?=
 =?utf-8?B?bzBVNmhWUFJFSWtpaTQ5OVhLNnlVZTBIVmZaNnRvOWpJWDFobjFWT2ROUGwx?=
 =?utf-8?B?WFlwUmJvYmdTNEdNT2RDZ1NHUmpESHVIU2xvbnN5VUpENHNUVm1HakdSWW5D?=
 =?utf-8?B?V0hUR3N6RjRhYnRBNHluRkNXaEM3QmtNaG4zRXZWR2E4U1BJajlWdzdQRDlw?=
 =?utf-8?B?Mjh3eStjd3BndFZhaTlva0NIYUxOVGE4UXBXYkJmRk9QUGRxOEJGWllyWkhm?=
 =?utf-8?B?cEtodFRvRjJ1d3Nvb1dQMVBYeEZFdlpIYmptWUtGT3Q2WHFqd0RNWWFTWVJB?=
 =?utf-8?B?ek9seXpYbXNHVEFqMGpST0ZHQXdQYVJ0QkRQR1RSLyt5aUxSTnN0U3AxWnFl?=
 =?utf-8?B?RzB1M3VyOHFoWDIzQXc2UkNHRzk5TWd1amhndTFDNkFleGxjS1UvblRRNlNh?=
 =?utf-8?B?VXZHeDNEQVBRVDRRQ3lEcXNjODVrenUvYzJSQ3MzTFVuWEY0dGFmWDEwR1Ju?=
 =?utf-8?B?RVUxUVUzZmg1M3QwcjF3Qm15ai81OFpQNnIxdzZCWUFoZWcyWDlaMEYyRUFE?=
 =?utf-8?B?L1FCUk42VzJ3ckdjdXQxcURrRG9KM2twWDlNam1DMEJwWWExWkFYaytIZ1FS?=
 =?utf-8?B?eStodzdldkx0bFZiMU5GclR6b2ZkUEY3eWxMWTdKUkppTUlTTnpZZ3ZsKzdr?=
 =?utf-8?B?czE3alUwOVUvT1FyWUlHUHJDdnh5bXNzMTNjWUs4TVJCa1VKYUFxbElBbHhj?=
 =?utf-8?B?WnJRTlJWYlEvKzRCdmxpcHpWY2RTbVRROVpiZFF3VS9NVEw0TXV0N2pKRWRC?=
 =?utf-8?B?NzIzR2NXQ1p5ZTcxaEtiY1BkUVlzT2NYNmpKdjNhTmtqQ2JPWGh1NGhlK0xB?=
 =?utf-8?B?UzFJTUp1VFhtZlI3QUptUFhEQ3gxVHErYW1FVll1ZXZlZXYySzYxc20vQUFY?=
 =?utf-8?B?MzN2Z1l4MnUrMGxFemlKeGlQV3A0RXlQUEpsaWZTV2c3YUN2VUdOS3RTY0lp?=
 =?utf-8?B?VTdPbi9EaGFXOVRmNzhrUk5xU1ppUWtVVnlmZDU2S2xkNy9jbUhmTFA0NmJR?=
 =?utf-8?B?dGYwd3Z0dDhzN2x1MWNhTnkzRW5JTVZ3akFRSk50aDhQNHVFRWlpc3lyRU5m?=
 =?utf-8?B?VzBiK1pEeHlSUVFXc2MycCtnbmRqVVBEeWV2SXFYSlB5SUZTUm1qU2xFK05k?=
 =?utf-8?B?WGphODIrSXhaYjNhbDQ2SXJrNEpwYytBUDNMN3JZZ2N4NlRybFppVStPcytF?=
 =?utf-8?B?Z0drc00zTk51QkZjcmtFUUFBYVArWG5lRnp0OWo0STlXNHMxeFU4cjNtUmNE?=
 =?utf-8?B?VWN5QXlxRHlSVTYxZ2lQcFNGdDYyOW5MdHNGbWdmV05GUncweHk5QlhDSDZw?=
 =?utf-8?B?TG9aY2ExM01BTitzZ2p4b0xJQ0xadjFuejJxRWY1b3d0YWlrdXp4K0MwUjgz?=
 =?utf-8?B?WkpZb3FEZTBhWVVyeUoyeERqUWFQbENWbGgyZlpsS2syVmZuNm1jblZTKzJE?=
 =?utf-8?B?ZjJuS1N0eHRidlF5djhpZ1o0Z2EvK0JUTmlQQjIwUlhoNnZneUdHRXVKelp4?=
 =?utf-8?B?em42Rm52R2lpU1dseVFrUFZOWk1mc1hjVWtHZzRqY3RhQkU5T0J2WlkwN0NS?=
 =?utf-8?Q?FG+1lFvaoPC85m2+gWdV6zWQd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd62e2c-ab2f-446d-22f5-08da7197a8a3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 19:22:21.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxrX238n+W1xIPWrCS3XYAJ5Tv81c2VVumZjZvlrPanyWevSpBP0EwGPhuMolWg786D33naQ/51lap6Fr/4uIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1320
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 14:08, Dave Hansen wrote:
> On 7/29/22 07:25, Tom Lendacky wrote:
>>> Considering that runtime acceptance is already single-threaded[1] *and*
>>> there's a fallback method, why not just have a single copy of this
>>> guarded by a single lock?
>>
>> This function is called for more than just memory acceptance. It's also
>> called for any changes from or to private or shared, which isn't
>> single-threaded.
> 
> I think this tidbit from the changelog threw me off:
> 
>> Protect the use of the per-CPU structure by disabling interrupts during
>> memory acceptance.
> 
> Could you please revise that to accurately capture the impact of this
> change?

Is s/memory acceptance/page state changes/ enough of what you are looking 
for or something more?

Thanks,
Tom
