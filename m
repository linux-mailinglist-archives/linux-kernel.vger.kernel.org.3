Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7498E5A38E8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiH0QxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiH0QxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 12:53:18 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBCD52E7A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 09:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEC9IXi/yHgryZtmd9hmzTD+guFj0lwKWgxhsKax9mBu8VkpSiuhwypTLjuGPY/G/x4y/AwB+kfYKufp+2WTj9dPCCyc/CP08c58gyXbC731cBJlvYVy/5+4cAiKCh7XyU+ZO0wWHmEareOnP+dDtoxa/M4pjsCAyqTUqoVOK0azN4sMXSsUcwrIxNH2UKR+tgSsHNFlbCtjeoMTVAjnmkPRcSDsvPKjmrQO/Guvo5JGV2Ybj27IGgRdlrTTBRhop3cMigBYY6f8NV7fPjk0N38k9s0PFRxcsYmBQr4vkeGXOBJl3ZRPYlEAOb7WyQnPQHqRUUDiKXesPSRupkJT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mXfDvE+/0W3S+DyWASKTM4QD3JXTWrRx1gTqqMLEUU=;
 b=FJV4Qm7cgRsvTmsrVxD9D3qttSuyKMEDcXeM9Aber+UxXZyb6TOdUQWNXXoda72u9xRkB5igyhz0/BXFIooqHHM5DwkQXw/zI2bXZ5zIjbA1BIT3IhGxR8JcVnoOp3/vE9Gmp6Up5l2+yC2RWbJzc3mpk4c0pY2mOoVulH0ZXrDmQii+t9GFQ3cw/vagA80FOsvsf6Tu3ykH8p265sjAx3Qp2tgABBp60XE2HJpkDl54JAmDzr6sO6B3aJWOiY84gI0z8WfI4XnvFuFut4YVLCV1G1qs9jsnXnFQeTLpRLzmjGT8WFZq18jQ77SSodqzzmVspZBo3I8gpJ7KhNe7oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mXfDvE+/0W3S+DyWASKTM4QD3JXTWrRx1gTqqMLEUU=;
 b=STCjkebb0fkttpgs0DldG/I+m9p60jFY6JzDNUxuL34o96jjqQF3aU28hjPA1433wlRldJgLowV4aUxB3C4rUFvBi68yPccK/vBM/l2gIFsQ7L2eehJdSXVKsuQZiMjpyHOjiuu/fOSU7nl1oo5q4MNLRIcpd+0X9xUHk2CbpnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Sat, 27 Aug
 2022 16:53:11 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::bc80:d6e7:d73f:d955%5]) with mapi id 15.20.5566.015; Sat, 27 Aug 2022
 16:53:09 +0000
Message-ID: <471a7a14-a312-b9ae-a8f4-0a3d4f6087fc@amd.com>
Date:   Sat, 27 Aug 2022 22:20:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 10/13] ASoC: amd: enable Pink Sardine acp6.2 drivers build
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        mario.limonciello@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bard Liao <bard.liao@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
 <20220812120731.788052-11-Syed.SabaKareem@amd.com>
 <YvZeNDg++YwEsgdI@sirena.org.uk>
From:   Syed Saba Kareem <ssabakar@amd.com>
In-Reply-To: <YvZeNDg++YwEsgdI@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b44a8d6a-c253-42b9-201f-08da884c9ecd
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN5yTsvM+7i4CBSmifiRTtcl/jp8mPZFeZ6DypGdq9A5Ao26mwg8UBmes+2taj4ia9AnBMxLZRnPigXsacILFoNgs2p/xT8+4m/zaf5ZC7gjlKzl9HADIt8py1kKe93c+Nj8FV7GHPX3KTSkwwfxd1qzH16Iv8LwXOy48jivaTrW8Bt5jM1wgMFxwwIHER79+Q7Q+H4u2iE7daKOBXVbkCtXitUkhm+RwRSGSxI/3dADRLqTp0sQq2PKX6zZfxvJ9IIOutJOUEajKXG6USGEx+eBOj0MLYolEhyihlTqufGH0SsFD3Ql4oK24Bf6dmtAMxtaME1TrZy6IGtGbKzGJ/8HHwD68/jbfHaZiUtPC5Dp0LrSh1TE00XAktO1If150Nr1ukxTNE3tfI+jeI+pbqzmKteTF2L4iLXCdut+9ERNx6L3xH5CCQyadDx17tTRUlgPWkMbdhpcCF7s1mqdGTpD9AjnHU0kLLfO9eyL3oqPDQQubiYK9GA1H4T5X9uw7onyZeHuOe9V67tSihRMNviSgMPclgL28j8V5yfZgV1CkP8lAVz8yNz6ga8p+3xFRovIw8LAAuj7VLMv+1TBvFVucBjAZs37Anp4PWBbh8kBsm48eDWzU2RaQFVuzzi/MCHLpil3qHSXJWR9E7USOkJpQhZe8aDh1h+cgfLxk33w0u1+qPgdZkJcHSskvNpwq7R/5lsjD/eQbBwGPOMUm24tOm6xGFcuYnDV3o518+LInFEjjT5QEOX9+6+Tb849Y58emKfiYtszSGbfnNrjr1kHfGroTKiwNV1sr/tyKSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(110136005)(66476007)(66556008)(66946007)(316002)(54906003)(6486002)(8676002)(478600001)(6636002)(36756003)(558084003)(38100700002)(31696002)(31686004)(53546011)(186003)(6512007)(41300700001)(6506007)(6666004)(2616005)(26005)(4326008)(5660300002)(2906002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNxb0JESzVIY3A3L0FkdVptQ1V6TjI4K2Z3TTJGTW1FdUJ4MEQ3VDB1cXNx?=
 =?utf-8?B?ZVlEN2ZRbHpEZ015QmNtaUhsOXRFT1o4MDYybERjM1dwQTZiN3pPRVova1JW?=
 =?utf-8?B?QW8zUDgyS2hRelUxSlpaTGZhcmpkUWdzTU9OZGJNUVJnL2swT3hVTkhJRyto?=
 =?utf-8?B?enV6ell5VEVlVWpmdEdiL3p6cUVrNjFjbFJqYzFINEhWSGhtZk1YckE5MzFv?=
 =?utf-8?B?Y2V6b1YwdzNOZWFUa21tWjB1QWJJR0dpdFpoeGpKYXVZM2dQOW92NlgySnBu?=
 =?utf-8?B?VjIzUkZYdGpUUjJlVENneE9hZnUzcXhCRDJHeWZabFJmaTRaQVFWaWo4cTd6?=
 =?utf-8?B?bytXV2FXVElqb1dJSFFudXZaOXdLb2UxdVExR2kwQXpqb0NIVFRhNWJIL2ox?=
 =?utf-8?B?RDZMbUx6RkFEQjZ5MXJXYVJlNjlkMFZ1WWRjNEZFbTEzRFZtRmptc1JwQkxD?=
 =?utf-8?B?dFdpdFQ4Ynp2YjZ6dVlWQWlVanUzUitXK3VRS1VjY1gyUWxQcXM2WVl1OVVv?=
 =?utf-8?B?OUFKODZOV096U0tTNEltMytIMVFuTzcvNk56blFtcThWc2dwc0FQOUwxNkZv?=
 =?utf-8?B?RE9JUisva2dMS05wZXRaWXFzNjVocldXejdtb29WUVdnY2lNN0FSNGRtaThs?=
 =?utf-8?B?Y0pPMis4L2ZETU5xY1VDTkx2K2FkRFM5eTRBRWcramlOb2FqbmRpVkltTTRm?=
 =?utf-8?B?SE5hK2x6R2xVbkZCRitMNTNrTXVSUm9sNTNVSm5zWWg4N2tzMll2OU9rckRC?=
 =?utf-8?B?cFpiVm1vV2JqT28vaXBkTHBhVFdNcUVkV3EzN2VFL0xlWGFsN0JlQ09ac3RN?=
 =?utf-8?B?S05ONWRkemFiVCtERzllcGxVaE02Z3h4ZDArWFFDbm5xTzNiVUFiUFJZU0U2?=
 =?utf-8?B?YXZkWExBT3dUM0s1SVhiQ0NrNUMxYnAyL2dMamxvR2FYa3Bid2VoWVZHSUw4?=
 =?utf-8?B?OWkrOGdLSkx5Z0FWZmRaTjQ5YlVEL3dyeGlwNEllZnE5U2FnQTE4LzhwODE3?=
 =?utf-8?B?Y3hyMWp0V2M4ZlFOdXl3UjRmUVJrdFNMVmd1REl5dXNWTnZmY2drY1cyd1JM?=
 =?utf-8?B?bTYwWklYODg3N1pzaEwzbzZwNGFEa25pN29Ca1BsSmNXVEpRTHVtN2NFN0tk?=
 =?utf-8?B?TjIzNG53Z3FpZFpZZmxLcGJmZHpoUmQ3QVZwOTUxT2JCQ0hkblBKbEZGVGV6?=
 =?utf-8?B?VTdlZ1YydVhzRFFSK0o2MTdvNkZ1c3ZucU9CUHNtUlVuVHJ4QjlQaXFQd0xM?=
 =?utf-8?B?WE80MTA1MC8xWWhvelVwZWtRTDNseTAxVkl4bndkNEZxTTN4M2YyWkVEYlQv?=
 =?utf-8?B?MDBXRmNLc01rYzBmYzA5angwT0lQaTZsa1FTTmZETG1oN2xTcUI5eEZWek1T?=
 =?utf-8?B?MWJWa2ZLYWFWVDUwb3ZGa0hRWVZUUlFzYUtRUVVQeHdaK1BZRXh4b1Y4SFRT?=
 =?utf-8?B?czk4dXE5cjFsWFZtMnF4M1p1NUM2bDdSc2xqUFpJd3hFNEtEOE9WZ3k0MUpt?=
 =?utf-8?B?bXN5YXg1NjlpYWRpV292bGVQTEtOTW5JNHhML1ZTOWh4bzJrN3Jmb3lrZU9n?=
 =?utf-8?B?S3pBYlg1TWJJek9XSk5wKzNlNkhOakNXSVlOMitrRmszOUZaSkRVZWxHQ3Z6?=
 =?utf-8?B?b2svZXRaSS8yeDZiNytyTWFaZjZDTEVxNjNBd3BtTDR3bFltOVJuMVdlV1FL?=
 =?utf-8?B?UnlnTU5mZHVlWjBNOWZvWktsbjNmejJqOGlzVlE1QitxMXE4STFOaktldHI2?=
 =?utf-8?B?OWlWQ0pXRU5rZjVGNFRQSDB1SnFJVHprODFwNGM3VFNCSW9qbFZxZ00yaGFn?=
 =?utf-8?B?cXQreDk4b3FNLy9nMGU5dVBKWHUwWS8vRHZLL29MbEVHQnNtZGlFK0U1eVZF?=
 =?utf-8?B?Y1ZpVkJsZy8xekdWY2FSLzBHVkJQU0NDamdPQXJidnU5OUE3aDNieDBZcFpq?=
 =?utf-8?B?d0F1SENDdHdxcGFqQTlvRFV4aHNJMG5hV2lJZmpISVJteHZnNEZSYUZhUVNQ?=
 =?utf-8?B?NEZRTm0rKzNZMVdDUU9MazFZVjBEcWVIM3lBdFBvT3JCZzh1bmdSS213eDB6?=
 =?utf-8?B?SVJZUDlCU0tEYXhXUHJXTjFBZW1WV2Q3ZXQ5N0gyRUZ2bWw5TmNoSUZJNmo4?=
 =?utf-8?Q?N26cfjBS4L7+CdTp2zx4Y4Ih7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44a8d6a-c253-42b9-201f-08da884c9ecd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 16:53:09.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFQrWLFZAE0V3ADbkxLcD/oZhUUAE3WhW46UiS2YdVMzHZ+9+eksa2sKfXqbFHliej9tTpfU3LTZVmTJMYyimg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/12/22 19:35, Mark Brown wrote:
> [CAUTION: External Email]

ACP Driver has strict dependency on ACPI
COMPILE_TEST will relax the flag options. As ACP PCI driver has strict
dependency,compile test flag cannot be used in this case.

