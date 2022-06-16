Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2200F54D7C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbiFPCE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiFPCEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:04:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C3393F8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6R4n7zjwVPdjb9e4+MfkxLaKtdPeBdCgvPCrv+GQzBKDbQWgKuRjfzJk/oBY6XyHq44FWO3pwF8cEjhT+YtwPVze6V2zHSa+6ii7JG0bm2WoM1KmYRpTBw5lm6vIyOdlq3ExU3g9rKgwHqSoRB1BD8iCwoucV/IbtcQ5f5DK3m1KgXmQaSJTtbVt9TILeJRJdCrdceWw5AD7NC7SQFUZL3W4FAazlGYBDPaVuhA2KJ0hK59kBa8YHpeiTCagCejyd+7D6TXD3cKlJ6ngBRsw2u9QCaCYdtwwV1IAT/Lwy5K0h8nVJ5h6FOvW6KA2DcL1K/plufW2y3ZE2RN8IabsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvUIRjyg/MqA+Zu6NRFE3b0jZOjycD2zXxETtV1Sgy8=;
 b=gsRsiofI5HkR5Kih2j63X3XVFTJq7a/bp65ZYKwN/pR1A3ci3cxaCRRuVab6ociqwFZbPQW+TFM8rNsA1moHb0nsz13DD9n6043xa1VKJbis9mPB4pbh+iDwSPwR4GlFT4z7vS3kYGIDxFgX3X3c2DCc7jNurYZ8+oZOyj3QI62w3biIMEQFwwxKGPLmE+Fpc0+IjndbtL9jmdby1SZImFRW8cWp4GZtZUwB8zFWr+7nmVq9akYR0CiYheUvlr59/2+aFNLovrQalq7lSGTF/XU6bY2qGLI5zUZcGyn942GcS3f5XzN0pCdEbgD7pJATZ96M522qwA9M2Dn9T8Pcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvUIRjyg/MqA+Zu6NRFE3b0jZOjycD2zXxETtV1Sgy8=;
 b=uGz9IKKRUyryuA9R5+4m82+gaiRRypeFFS0opXPUoSwGUTb8QxmP+z3+4xNTjb+TtNTJZWhBuHx80EO4f2QQIJJ4jwuA1OG5Y3tjNpUPi64k+NThSm4rpwCQh+0qnN/d45X2IuLa8h1gUhFqdF2XgVp1M8RqGzmcsa9hafbL9yt6vNEsUK/7hjGGlZD/ungCVasPHWdCEat99QSOAUgKGJ83VmJXyt6ofvUZe4lt7c1v6DtwwwwExpW4wGj6lWRQq2UnzpqL4XRkdm5tqXsXPeSGm9hBLjXJcm2ghx8pmg1DXHHzQntVkHPycyi6dErwIrdLcDnXRtouBUgbAKd4oQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 02:04:49 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::15e3:d746:57e8:4de0%7]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 02:04:49 +0000
Message-ID: <7125b9dc-58e9-0ce3-ee84-77d5dcdfadd4@nvidia.com>
Date:   Wed, 15 Jun 2022 19:04:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] gen_compile_commands: fix overlooked module files
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
References: <20220615063315.279489-1-jhubbard@nvidia.com>
 <CAK7LNARsHxH1LF8Pq70EMAYW-p1btgAVC1cJMOkXSTjW5LZuKA@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAK7LNARsHxH1LF8Pq70EMAYW-p1btgAVC1cJMOkXSTjW5LZuKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66141ba8-213e-4180-7fce-08da4f3c97cb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2621AA9030180C649F09F157A8AC9@SN6PR12MB2621.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPg/nn/CqS//lT8JBfNujMgyPG6EmVcU1UK4JgiJ0PZSQ+jT8005a1E/qPkyOGEo7C0vHQJOqvTGOnTEsV/FNQm3fEAjiPWW3GyPQ8W9tOMc5mzNUSRtLDZNBDn6K26zC9exBZT+3Eud8mYZcj/StiLqA2+ZKxTf2MfLLrUBTqFdwu2jRauNFYrP7OMRjzG4XRstW5v3j37Mq9on2rxfBE9PC+C+1vI2ctadg97FS4o66YhOdHvo99k6z3Ni6E5zb5geyvXGRDOjzwYbFstXariouQlBel5lrKc09u8EvbyzjHF82+32A0WDhI0TouorErzA3sGiiSx53NiUJkGvq2cm4KgOhFyDmRSuEu8vGMx2QYRGwyiPlR4l9rvXuSXV8IcCH7ww6CDni0GZVevH0j17QbJpNKjTERpkSTVD0r4I2V0/y3GxBe2waow1rhkdrRftftLdhftvjOYZQMw2T6oic3i8YB74cJufLNzA1YA0gpHTzzN+IVTUBiwc0Ac3fN7Ryl8WIFrbltLH11A0tpTdsfD/qml4wFF5LJ0e5/EV5naL3hwPhIKsMvsAcchqmbVAu455eYD5J+csdn6Ku+st93Gtz1yQR6K2dySrIANumL7jDSIjfP8xB6xcPIWmP3vCVqbvr4IPR89Roi9nqfFw/gL2HVoGMsmR3K4Av9YqU4xTXIAx1mO0w42lEOfuWruUG2DHJ+gB55Fd9EbJHwDLYtVAFbBrFY5aQjL3yZCVwGx4cq2eL3Kl8RGHfnEf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8676002)(66476007)(4326008)(66946007)(66556008)(2906002)(508600001)(8936002)(6486002)(5660300002)(26005)(6512007)(86362001)(6506007)(31696002)(53546011)(36756003)(54906003)(6916009)(38100700002)(83380400001)(31686004)(2616005)(186003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFFGNnZDcTRjOUpFMVVQYkRldGlOZFU1bFhhTHdNMXpXbit1bC9jdTNKbGM4?=
 =?utf-8?B?SEducXlNdUk0MlZsZmxXd1V4dFZhMndhODh5R3lUT2t0cDIyMENTM1VtbjQz?=
 =?utf-8?B?bVNFYkVPTFliREpYR1ZTYzBYdXpQVlhOaG9SeUFSSDJoLzczVUs4eG4yNGRs?=
 =?utf-8?B?QWt0OHk5TDJYTWhTTmF2eThLRnpkejZ3R0dmdmQ1SUVZT0xmZjJnOFYwR0lw?=
 =?utf-8?B?ajB0cnlyUnBhUEhjc0cxbEljWE8xWnJsS2pvbnAzK3hzelJySVVmYmVzejcw?=
 =?utf-8?B?VGNMUjFLaVhqTGdaZ3BqbDEzRk9HWVg0Um9kUlRuUVJqL1kzZDVOS25EbU5j?=
 =?utf-8?B?U0VEYWRhVncrTXRLclJIUnVNeVVLOUczdk9OUEMrZnFWVjYvYVJOWkoxUnlG?=
 =?utf-8?B?Qy85MFRpSm9EQnoxQlhnUmIrNkd5YTU4blJoT0tKSmtlaUtjR1Y1K2I3RWJj?=
 =?utf-8?B?NWxNZW9CSTFwQVhHb29Ea2V3K2t6WSt3aEhUUzdtemJxL2x0SXJWZHRnZzFI?=
 =?utf-8?B?VVRrb3F5eXoxcFV0dXdPZjFHZWJ3RC9lWlA0MGxnajVZQTh4SFVFd0J1dlAy?=
 =?utf-8?B?NG9mUWlrZERUb0hvaDA1NkNwaFcrV21aSFByZ2E5TlR0RC9NZ2grWEo5eHVw?=
 =?utf-8?B?VWxMWlNmT2kvemF6MWhPMXlGTzNoeVhYZnB3ZU1EQTlxTytGRTBwYVdSWEc0?=
 =?utf-8?B?ZHd0Y2tXa3VrOEFUNnVMNG5qL1RIdjdwcHNkUUsvOFRoZnhNeEZTdHlmZEdC?=
 =?utf-8?B?QmgyTGpGdG5VM0RjMm53TVczT2hEU2N1aFV4VmFVcmJXaUFQaTNQQWJTTG9K?=
 =?utf-8?B?aW92WjB6NG9KQVZlZzNOV2dZNXlGekxma3JoM2d0MmVhbThvZ2xyMXdlMlc5?=
 =?utf-8?B?TG10S0FjOXhCSkVZN1JpUWpWMEFhbUw2dnBtazJZZ0ZaUVU4Ukt4REJvaml4?=
 =?utf-8?B?OHVjT0taZmNiazdUamRzYW4ySE9Fb0cyeVQvazJyOFpORmlBU3hqR25WUUdx?=
 =?utf-8?B?S1Q1WVRpMkVIZDFpU1NuVml0eXNubnFSSmtRMlAvZDJlU3B6K0xwTXQxY2tx?=
 =?utf-8?B?WmM0OTBqK0lmQkJ5eXRQL0xrYXZLTjQzVWVocTVTWjhZd21Wdk1TZGdVUHds?=
 =?utf-8?B?RXAwZXRibDhYWldEYThYZ3ljSzVZRmF4VWRVVVo5eDFyWHVUQWIvUzBSS0tx?=
 =?utf-8?B?bFFPc3Y3SWVvVHFPQkMyMGt1SVRNdUNWSjAyeTE4UVdJTHRqMXgxRHd1bmw4?=
 =?utf-8?B?UFpLcFNZZFJYblZuYTlnc0RWSE1CSlJXOW1WUnJkMm1wR0FyWEtCbjZpQzho?=
 =?utf-8?B?TUpUdi9aZDVkTi9BUVdUV1hoWGdPNEt2dTNKYW54M3Y4K1hRMzVBakZrTGwy?=
 =?utf-8?B?bDhxNEpRVGU5MlJjVmVwV1N2SkRSWllMeXFrRDUwT0ROUG5aZ1QyZjAxUkxp?=
 =?utf-8?B?Q2w5c1NvUnh4ckZTd1NMZ096N2dPOWJ0RTl4b3pOWGs3RDNtYVpPQkxreGxN?=
 =?utf-8?B?R0QvRmhIdlpmVStYZEpjNmZUTE5WVi9jRThCV2tYOUl5eEZmZGlLaExwYlpJ?=
 =?utf-8?B?SEU0WHNKZExoeUdvT0dwZ3lGZnNlZzFEYTg2cnpqWUNMNXgyMTVuYjZrOU5q?=
 =?utf-8?B?QTQ4TVdUMFFiOHZMcjRWdmJENWk3Q2RENHUzV2N0d0lrYkV1WEgwNXFmT1NU?=
 =?utf-8?B?Y0s0b2Ira0tvWEhVNGI3RjY5blpKeTZTMHczOFJyU1IyWE14ZnQxbVd4d3Bq?=
 =?utf-8?B?R1FYbjlndTIwdGpkQTRxdituVlVKaElHaVliQ3FTVzdhMWRodDNRRjFwTFdP?=
 =?utf-8?B?U2hHUExrMFp4NlVUMEdiaUplZC9haHB4d1dOLzJkWUF2eDFWLzlETlRTeHht?=
 =?utf-8?B?ZGwvNFZVOE9HNDB0ZkhaQjJRNzgrK2pJMHdvRTc5VWVmVUpheWFQVW1idk4w?=
 =?utf-8?B?Q24rbjRmMm1JVjB2S3FKMU9DYnFkQnd2SEhrcThLdWliMllRWjhYTFV2RGJL?=
 =?utf-8?B?V3dCV1N3OFpMY3FkemtYdUI2MUJZMEo2d0F2RnRDY1Q3Rm93NGwxczRLWm5a?=
 =?utf-8?B?S3hldzA3S0w3WFdnL2lheVRMc2JRNXpmYnZsLzhYMVNBa0JpbjNVZkh6cWRw?=
 =?utf-8?B?TERORzh0K2F4UUY3L3h4dHhtQURmaHM3dXB5RFZ2OXZnT2ZwY3VEZWZGYUtj?=
 =?utf-8?B?YVlPNlJEWThMcS9HM1BOeGJBa015VjRVYVN0Q0poUXhTYnFSbmo3QzFURGll?=
 =?utf-8?B?bGxzMVorUWlQVGFmOWJYMGlGOS9RZFhvUnhXMC9EU0xEa20vNnhoTU0wYUxl?=
 =?utf-8?B?RFlJWXVDaXE3RWx1YlhIN0NwUjFJTGZ3VUFVcGxXZC9UWlBTT1d3MVhpeWRJ?=
 =?utf-8?Q?JFBWBAX1K52Lzwfs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66141ba8-213e-4180-7fce-08da4f3c97cb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 02:04:49.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQgP60UV5BMt0RFkztvmMzNpty4i14gZI+7/ata/rlyNHwJyATq3RG5KCAwb08dh8b0Ez4YJ/Z8m+vNQT2dpQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2621
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 02:23, Masahiro Yamada wrote:
>> Fixes: ecca4fea1ede4 ("gen_compile_commands: support *.o, *.a, modules.order in positional argument")
> 
> This should be
> 
> Fixes: 9413e7640564 ("kbuild: split the second line of *.mod into *.usyms")
> 
> 
> Can you update the commit log?
> 

Done.

> 
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   scripts/clang-tools/gen_compile_commands.py | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
>> index 1d1bde1fd45e..53590e886889 100755
>> --- a/scripts/clang-tools/gen_compile_commands.py
>> +++ b/scripts/clang-tools/gen_compile_commands.py
>> @@ -157,10 +157,11 @@ def cmdfiles_for_modorder(modorder):
>>               if ext != '.ko':
>>                   sys.exit('{}: module path must end with .ko'.format(ko))
>>               mod = base + '.mod'
>> -           # The first line of *.mod lists the objects that compose the module.
>> +           # Read from *.mod, to get a list of objects that compose the module.
>>               with open(mod) as m:
>> -                for obj in m.readline().split():
>> -                    yield to_cmdfile(obj)
>> +                for line in m.readlines():
> 
> 
>                      for line in m:
> 
> is simpler, (and maybe will work more efficiently).

aha, yes.

> 
> 
> One more note, the 'line' iterator is shadowing (overwriting)
> the outer 'line' iterator, which has been used a few lines above.

I overlooked that point, good catch.

> 
>      with open(modorder) as f:
>          for line in f:
> 
> 
> 
> Maybe, it is safer to use a different name for the inner iterator
> because shadowing does not work in Python.
> 
> 
> 
> 
> 
>> +                    for obj in line.split():
> 
> This loop is unneeded because each line
> contains only one word.
> .rstpip() will do.
> 
> 
> 
> To sum up, this part can be simpler,
> for example like this:
> 
>             # Read from *.mod, to get a list of objects that compose the module.
>              with open(mod) as m:
>                  for line2 in m:
>                      yield to_cmdfile(line2.rstrip())
> 

Yes, I'll send out a v2 with all of this. Maybe "mod_line" or something
instead of "line2", but otherwise as you've recommended.

thanks,
-- 
John Hubbard
NVIDIA
