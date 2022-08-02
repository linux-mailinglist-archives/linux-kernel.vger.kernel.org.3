Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FA588452
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiHBW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiHBW3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641D554C97;
        Tue,  2 Aug 2022 15:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFNY/06YNDs2XrN/SKQWCw52SftYSAy6bTILqXpCZSqxnpYcg0OPLbkowr8SvS5JDrJeuxbmDdEmrE7EZqob2hZn3vVzom3RvYwS8MmdEWX4qiz2WyR151lafPneEb7RtSBVfSVlSxxsCdpGM2SDNfjGILaregLXwmm7BogfUpG2kzk68fjGb0pntl7NwwSKx+kf9CXNyJrQwV0oeniCpt9g7NhuvumCnou5C5DY781ITAHgNJvjZKkPX6iPgBgTOjJs5IOXd46orbRTSmItEzYsy/A2/gCUi0KrrOp7JhtmJehXoSSA55laFnBTkJVSpseptN+SvarhD4VnCfjhrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B00QBFH3TcCqY1lb6IgXNZLIgMpYw/U2JD9nv+VN+uI=;
 b=FouEfv447sT/FGCQIX2X6w4IXhDft0Cg4BWX37Hy6ViUw15xvhnTjF6ydAxGQb1rMGZ3aiwtSsN2/xCa+PwDs2n0qOEw8QXloirNOQ32PqeHA2NAm2go0NNc/OdsEZtYxf/XzOvmLWJmVRV6FmNV+zkvuz4g3k0BuhV9UsSkWcqEhx4oQtXNFzxMLimnV+OC0EGRHS+aIZIkdE0d6vnSzeX6V53zbS4bYJD2J8wvFwe1eZtizGMmf/LPmIm2RTCQRK6eWUObfpwrPpd652xBx5XFqKPiXw2snlY5fJhxkPEos7x6atGkkQxuN5WmjfX9Uug7Ea974rB52+W9LabipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B00QBFH3TcCqY1lb6IgXNZLIgMpYw/U2JD9nv+VN+uI=;
 b=x/eRE4bbZHQIrxW2sg6XcPyNGoQRU9hvhWqZjlITB7YHKxafevaW8FiqgWpSL/n5ywyiVlbSxCUTezCCbwesT24Vo+lPgr4O7SGrjTLiOX5oKwA7vHGEVkgsxt/MxycgtGwzW92NUBvhwi9aPKZVy6Y+L//A92ozhjkbvoHU+/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 2 Aug
 2022 22:29:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%4]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 22:29:10 +0000
Message-ID: <6c53d995-f7cc-ca56-88f8-e3461129b400@amd.com>
Date:   Tue, 2 Aug 2022 17:29:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: linux-next: build failure after merge of the pinctrl tree
Content-Language: en-US
To:     broonie@kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-gpio@vger.kernel.org
References: <20220802222137.2435761-1-broonie@kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20220802222137.2435761-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0035.namprd05.prod.outlook.com
 (2603:10b6:803:40::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c38be7f6-907d-4b73-db7f-08da74d66b46
X-MS-TrafficTypeDiagnostic: PH7PR12MB5854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WTTIB/elV7hB+d/YxyXCfMWPeJ8Ot8rUI0K9sKwTefTVvoJjRnQKrOBXGhvn75/zhCE2czhJFqx9pSMab6A1wkQdpabmGqYDyXn+ZcBpRSiN/HIyZDDBmAHDgA/8CTSGceNRdfd6xkCsDENbVAfrZpm/BX7JWZ5E8y1mGz0FeP6aC+Jhg2QQGrCOgrMuRjmiesr4IxaydJNps0lfMImySRu1c0FPXy8wYWCPq5GuFtRnbt9xFCiRepkQm/3gSzK9gAvMkLNHODR1RlgyC1rtfIq2mW6RlO7vrb26vW6NDEtChKgpMB7ygCYhe7pefCgcBjbSpreMZ4pAwEFbG3Y3BHfYt9Z7zLQ+HmhQuO+LAeilwgboNZfVpUk8awWX51Egf5dgmdrDfEDzAi312tkfaZOD8TD9YK5Wx9u7DGmoth+Ai8PAL4OtpPRkwWeYKPh9exGpBeZlYGxyXk7KjJTSrVuCDiKykHy7WOut3f+MFFoq3XXwy/YdsmxXYFiqaoJiuwXHTCuDJ3ei2VVBBUZaSDbsJ93VYlF2XZJVOcDfIm9HoiZKgTkcwzMqJ4f9oSSMa40znsE2sYR2NDdtA+6ysUrM/gysof6niwNlLnZCtofuQ9krzKiBuvd+6kEgY9V4TyOdFr0gYI5PHxZBT9kiXx6sBBNsSQquB10qgCmrTP6slIe0Es/OLHy5gCWm8FeX0qwRN/MnQlt55fUJNU7C9g83rc/ApR0XzOPg2uRSc1x2CZBYMvEMccsXg9WPklsg/xZEk4VEuWZj7e4PX+5rDJ1wXPrFEAC9a5Yj1IrrmepFJZN8/ttCuEh4L+fYR5mJP5HEWFzVDOCbtcmQfsOC+Uev6Jf5j+Vn4HZrz6sSCQejVzzkLMPqltO70OuMIQvS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(86362001)(44832011)(4326008)(4744005)(316002)(6916009)(66556008)(66946007)(66476007)(8676002)(5660300002)(54906003)(38100700002)(31696002)(8936002)(186003)(478600001)(6486002)(966005)(26005)(6512007)(53546011)(6666004)(2616005)(6506007)(83380400001)(36756003)(31686004)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzJPaW96UEh2c2lTczdVNENDUjF2cmpMc0JKYXJmMkFHeU5NU092azZrL1FM?=
 =?utf-8?B?RGduL2NNRncyV2VTUzVHZmlmdGZ2ZjZHK25ISkdmN1NpalorU1lpQlBoYk5z?=
 =?utf-8?B?UWdDbHRXMHpPU1NqeVZaaVp4SUpxZ2pmNk5VcWhvRlhsVFBUV2cvMmNUT3BV?=
 =?utf-8?B?TUlNdS8xSklCY0lDbzZ4dWFKekFJQ3VmYm9JZmVWakFia2RUVXpwTUx4blJO?=
 =?utf-8?B?bFFpeWtMRVZLL3F5OU5XUnZNR3VLdHRETmE4RWtwTjkwSEREN2hNemQ3YjNr?=
 =?utf-8?B?bWlpb2hYNzdCNFVQbFdxUWhPR0VJb2xFTnh4YlZuS080QXRMVStOc2RrTlBI?=
 =?utf-8?B?bXhyRVFUS29zZCtJZFFSc1p6WW81Ti9vOVYwb2xsV2tRS01vZVZoYmxEU3Er?=
 =?utf-8?B?dkx2a2pudThzSXhoODNoVFJzeFFvSTlHNDNTSjlKUDkzcU5OWml2ZEhPQUVm?=
 =?utf-8?B?RHFtZXVOKzJpK0hCeW51cXRIeWUwZ3F5aXRuT3daVmNmMkJEWmRXcCtHTFpJ?=
 =?utf-8?B?a1VrbGpwY2VMT1diVTlTY1NvLzB2S2tSa1hEeTZ2dVkzaG4xQUp1aUpnZ0pK?=
 =?utf-8?B?ZjhaczB0SVVXTHdOTVdvSitLd3RIbGFwNE1aaGc0V3pNZ08xbi9ZZ2NjUThB?=
 =?utf-8?B?RXBtbkl5bUtEWGhIVVZhUzFPZmIrNFBMSG14b2NCeHY3bHI3VnVoVUZsZjYy?=
 =?utf-8?B?bGlzYmlyUG1reVhHMjdHZzkreGM1MGEzeVAyaDlhZ0VxeGpRRThML3NyL1Bx?=
 =?utf-8?B?bDFUcFVrSjN4S2laQ2JHUzJFK0FQVWttSXV4SThwRjJXYytGQjNmcmNSNTM5?=
 =?utf-8?B?bkJEOUxzN3I5dEd3YjlnMWhsZWV0QlBYMkxNcE1iRXpNWGhSOUpES0p4UGJr?=
 =?utf-8?B?SGNFZllVQVNGeDRPSFJPeWlMbWZBVkkwUW5haVVvWkVudnB3UmJWMVlFS0tB?=
 =?utf-8?B?emFPemhYZDMvcVJ2OUxmeUYzWkNsTjM0ZTEveXQwbEoxeU9QYmoxZTNTSDlE?=
 =?utf-8?B?R0Ixak44cHlnUHlScm1ieXpiQ0J5ZXlWb01DK2Q5aFM0Yjh3NjdpcjZXMmdr?=
 =?utf-8?B?dUlFOWxQUDRsR24wdTJsOHlwVGFlU2htWlppQldUZVVHcG1NK2ZncERzNzhx?=
 =?utf-8?B?QnZ1d0pRVGNDenFyamJQbWFBaTRTWDFzQ2tzZXZnNHBpUDZvWUNKbmszVXRs?=
 =?utf-8?B?ZkRUUEhsY2taNFZiNzQ3V2twT2NaQ2pmVDNmazU0T3JZMEc1RmhPVnVzbDQr?=
 =?utf-8?B?b1NGZThBYklTYUVOcFlTMWExai9aU0dEeE5penk0SEZwZld2ZXpWQ2dsNFMw?=
 =?utf-8?B?MjhtM0NCVGRGOTBlQU9LcVhMNi92anhBM1BNb2pQbkY2b21UdXNQVVFPSzd2?=
 =?utf-8?B?Qm1GWG9OcWF1VDZicElXbEp1R0hTamxhdjFUMVY3WnpUV3dsQUNSZ3RFUm5K?=
 =?utf-8?B?eERvQk4wMVhJdlFGWmdqMjZFdjFaZklqdGRKQmx3QlRYZmk5dmdUYWxRRGZy?=
 =?utf-8?B?SlA1MVFjbjhRenErdTJsUXJENldHY2dwNWQwazA0clhQOVdkTWVjc1pNcXli?=
 =?utf-8?B?WTVyMTFYRTlYbW5BMmFUVVZuanBZWllZOTQvT1hXY0kyTWkvMUcwMnpXcXVI?=
 =?utf-8?B?VktiTmtwWm56OEc0cXNpN0wzblNKZjZRV3kvT1ZyYnRBd0ZLa0dQRE1TSDNJ?=
 =?utf-8?B?WHgzY2tDRVcwTUc0UERhT1U1SVMvMXA2WlRjdUt0Rlh6VmFrd081d3R2TFNh?=
 =?utf-8?B?K2VDU0RDcG16UHZzRU5MeWlZdVBINkk5TGVaWnBYR3NOcDI1YUxzcVlCN0Rj?=
 =?utf-8?B?OGZyQktha1NROWllTGtQbXpZUjJab3JQNmV2OTExM3pqL2dkVHRUQTFxYWdx?=
 =?utf-8?B?Q2kyOTUrbE1FaVAzL2RuWFA1b0NVNDh0SlB4SzhpUVVqU1FuT2JNL0FaNHE5?=
 =?utf-8?B?MSsra0IyTGljTEUvQ05XanhYcCtaM0ZxWmZDVytETTJsZmpSRmY1WktvMk9n?=
 =?utf-8?B?TnY0V050UmlVbFZmdXBlUkhIWmRsVVJMS0w3RURuNkdIU1RobmpnTEQxVmR2?=
 =?utf-8?B?TEh2c0FxZUVOQXdJMTJZMGtBZXoyak16eVhDSkRrU09UYkZCYXJ5N05xQ0Z5?=
 =?utf-8?Q?uGa5DvWNUi9RNn2w31rxyOE7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c38be7f6-907d-4b73-db7f-08da74d66b46
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 22:29:09.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s35gunhl/GYv8dUuyL9Go4CybhZvspt+Hzd/W+zgkIbVK6rk6ftfUhL7s4TurmQcOeWpmtIkBMPgyNwTHfwOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/22 17:21, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the pinctrl-samsung tree, today's linux-next build
> (x86 allmodconfig) failed like this:
> 
> /tmp/next/build/drivers/pinctrl/pinctrl-amd.c: In function 'amd_gpio_dbg_show':
> /tmp/next/build/drivers/pinctrl/pinctrl-amd.c:219:8: error: unused variable 'output_enable' [-Werror=unused-variable]
>    219 |  char *output_enable;
>        |        ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    e8129a076a509c ("pinctrl: amd: Use unicode for debugfs output")
> 
> I have reverted that commit for today.


I submitted this yesterday to fix it:

https://lore.kernel.org/linux-gpio/20220801144952.141-1-mario.limonciello@amd.com/
