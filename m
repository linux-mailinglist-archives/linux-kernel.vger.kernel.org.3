Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49751C6C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383010AbiEESPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbiEESPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:15:33 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD44F5AA71;
        Thu,  5 May 2022 11:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgL0eCOGzjNyQGMuURSQkjsKkTcOul1h4J0rjfN+H//QlXCnGjJBne9PBQRWbJDxlQQq+6SvSa/ETnfly9HumwyN10FrYVvH411voWOfkI8gsrjRBTdkhRci2xxW0E5/FBldsN2QE/zM7qRp2aBO1uOOd/kSKdt4koqv01VgHA5syJ0pl4KjxvBKflgcbrdh+s8ViU9sqe5E5LPUFxgZykQwTjSVK7Z1ZJ7bXJsDKJv5I5GUFN4ldfVz5VyZFXhqSaJCRyreCkbVmu4l5Ua+DBw+iL9D482nw4s+J9vbwRgOyYgwcixcVA+E+cku2D12CXWLT4pvXIgYPBwWFvByBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fMEJC9KOqmW1s+PYiT39gpa5B0RarISMyIAFVv5haXM=;
 b=hG6uD7u6/pxtviG0wrjSpKI5cnI4IeR9mImyHCF5JZowfE5gyxzKE7JFCjDVJYRsLwsFJ73a6Ap/Mly57mqKImUlVezCug6zFxtQirEVLlRJm2IrT9n68KdbVS11OYqwp/d9PqJwTbYspnzeFskDxxK8Xms0McPr4ggUQ5RfccRgBt8wMhHghs2J9ONAGx5B9vh9pxJHUX3sluOUbMnJZpasZDt1euFOWxIH3Qof5gnAcUmNm9LKjJbOZfoDpk8Tge2NdQ89ZmCkcjOeC+QxqsXtaNGRChYty5jzZR1xB54k1jGAWezn+FBIhqLR+qFm9jkQL1E4TvEboXdCCQLh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMEJC9KOqmW1s+PYiT39gpa5B0RarISMyIAFVv5haXM=;
 b=p3MPQ1cTfl3IMUvDNIYQWv236N3ELOCVqPkMrxHHFYOFgD1SxvwVu0g1fAkr6/+UwCRUOJatigkDlkwBWJlEBLDG2qd5aEUgf2oqlGfebMfeaXpzIfH21I3U53IuD4Uyn+o5jizoc8RzlJs7ZgcQhhCah51xZMKLdrJFhRVCNS9+O2MGcnNQ1qXnyZMAEYbzTuyBt9SHRIZcNvUaiM94kblowJgiiJK/vmEo8t/6e/Ikhc42DP++orwG2IcWoXN8khYW63ySjVrDhILtXvrr59fOJ3+aE3p3wYfEqqX86qUDa4Qc9mWXkq/5D+WDpkTX+o+/RnPhTsd1O5s0YnZj7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:11:50 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:11:50 +0000
Message-ID: <77ad857b-bbb6-364e-afcd-d9c984aa5246@nvidia.com>
Date:   Thu, 5 May 2022 11:11:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: linux-next: build failure after merge of the hte tree
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220504165956.531c4b53@canb.auug.org.au>
 <YnIlh++OJDRrK9sz@orome> <05e94e6a-86d3-5d60-081a-6adb3bcafb35@nvidia.com>
 <YnPZffmJQjuU+8fI@orome>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <YnPZffmJQjuU+8fI@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0005.namprd21.prod.outlook.com
 (2603:10b6:a03:114::15) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c72bb8-cd3d-4164-2895-08da2ec2b9cc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4465:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB446554E90EF63FA741C6A693AEC29@DM6PR12MB4465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DKehbacM9KwSIHlTfdysIs4tKwxj2GqVMXylYV0CUvLwOTHzxEuXzUySuCHZBb4p6yYvxf4y++IzGhaFzTR3/l96bXw/1Kf5a8ff2UPtaa0idEt1OSWsZ7GobHeAldq6TOvggzUB/Hqn6RtuNPgtPSY5C30DBfUq8E4kVD23eeiAWRHV98c+AfUDheLb4ThGW3r0ptwMNxa9ObD1jTDaSSe2uJv+NidaR8xz6lxyo0lwqlpmjr4IY+4z5xHJQH/MTtlhbrfENKkB753/1Zl82MpaBbvO09tuPHV8zpdgT5manM61JvR9u1EazI50sgpn13W45CKvHOS35IVxI2VnBJIiiPwsGmHxwak7UxmDd9wlWI9q13QsrDj4zvzBnoahnafhr8htsldIKWMY9j2VndJXm0IU3fm0WyNz2wv3FIRX0XuDYm2DSNXbfJLc1KnmTzphJPhW0z9Z35ZAdSEvhWyxtyh1w6zQV9pcS9CnwjyIoLvbAIOTAq8LXGtZdGHCSbsEhljsJHh0/4PRFymZWChI5ZAdb5SCLuH2gKVYY4ZyKcAhQxoCmXVTkScoCpoKWMzMU3m037cOcttut02Ci41Ru88Fd+mW7XDhQfOyJ9dq6iim86+5/MQwVwRpFHzSPUe1aYoF0Ctml2QASwQKE8OMKmo2EEMmIGORGPyQLlVTdQzyQAalzHV0Ktcllzly/zn+k/0JC5mlHFLqOQaoqw8lijmLuVyMqPCA76UfzEiZC8rDiPNqCdu0IGALU8lkoK31jqhIGqzcKEyZ4Xy0N4h3XaeG0VR4lJEpe4alTiUmtUTDCCRKROrlaj40xae53kY9MT6/dQvbKf2lrplbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(86362001)(31686004)(4326008)(2616005)(54906003)(38100700002)(31696002)(6486002)(966005)(6512007)(53546011)(36756003)(6506007)(6916009)(5660300002)(8676002)(66476007)(66556008)(2906002)(66946007)(8936002)(508600001)(186003)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlLWkN2eWYxTU5BdERYYlo0Q1lPODdvazE1TytlbEdMZVdtWW1uUW9aRVM4?=
 =?utf-8?B?MU5YdWU3Yit3c0IzK2hoYjcyQXA4WExmUTRpQ3VjUFhwSjhKTjBSUE0yNk9Y?=
 =?utf-8?B?RDhwY09veXRpTk81bUVIZ0JBb2xQMGRzbUhUSFc4S0hBS0dEWm8rUFZrTWsr?=
 =?utf-8?B?cXVPaElJTmtISEN2MGFkWFpIejhDcEFtdzFtQnRRTVlDKzkyMWYreHFjYUty?=
 =?utf-8?B?SzhXUE5NVktRaG9sQXRzTHh6Mk90WkRFeXJic1JzNEFTWUg0azU3VDRiWEVK?=
 =?utf-8?B?VnlRUmtwVHh2d1ZTZ3BmeXdFeUFaNFJJQW9DeGJoenFnK1BPK01TczUyQmhi?=
 =?utf-8?B?QXRmK09CeTlUTkNNcHJUMUZQQzFtTWpQQ3RpbjJxOVJpMnYxYVhDVnk2Sk9o?=
 =?utf-8?B?K2lPbkc2bUFTRmE4SmJyN1hISjBWcDZQTk1idVo2RWRnaDZLWkdOOGJMS2Rt?=
 =?utf-8?B?bGdPbnFjMWNIVWZ0b3Z5R1cvTXNmZGZZYXFicGpVelQyNlcvcHhJN0N1NENo?=
 =?utf-8?B?MU5KczI3SXdOb1V6WVBJRi9BZ3kxZjNwSkg1RU4yZnIzcnFxRXNQSlFnZERF?=
 =?utf-8?B?ZXY0ZHNGUmkrRzZWbXF0SDFhKzU4VmJhaHVxazE5cldCVkJTdkZNVlBMZnRw?=
 =?utf-8?B?VzdCWGoyMVZVV21yeEoxR3czZ0IzbWNjZ2dCeGZSS1lYR0hnV3ZKd1ZjQVo1?=
 =?utf-8?B?S01ISjEwbjdTaDJpVXRvQXpwVnFiSXUwTmEreWRwOFZVYno4anhhdytqRW16?=
 =?utf-8?B?RmFjb0cwRi9nWlpINEh3WFlGUGszMCtNUExKUE9LNEdqYVpGcCtnQjB1Y2dR?=
 =?utf-8?B?amdMZVcybmtyeU1VS3pIc0hDTE4rMGdUNVlYT0Jjc3B4c1A0VnlzcHpZekN4?=
 =?utf-8?B?a3dTdmZkeDZ6ZUh6c3NuVXhlTWFGTHAxbzc0MjdVdWVqTHgrL0l2c0ZvaWgy?=
 =?utf-8?B?VDNvZTJReVJtS1BUc2R3aTkyT015YVRXS1c5NUFhUG5zd1dwTzVsMGVVUmF5?=
 =?utf-8?B?NG0zU0lVbDcyZFB3a0FIRGF0dXFmU3hWbVExT1dRVEp2R0xhRXhBOVh6cUZU?=
 =?utf-8?B?UjRqN25LcFFoYU4vYlR0ejg1Q0IrcEY5akFHRUhRT2FhcXNWL1FTTUFwYkhR?=
 =?utf-8?B?bC91ditFNnNUWWZCaUQ5elJtRlhDV1Mra3NBc0Z0eHJOejZ6MnIxNmZkRnVU?=
 =?utf-8?B?N1NYL0RySVB5SVpJUDVLMVYxSVNUbW4wZUFxcU44UFR3UzR0Ly9zZW5VVXJI?=
 =?utf-8?B?ZTFaRnZjNTVaMThxMERGUWRMWGRQNGw5SGJ1SmZQZG4yaTZKclI0M3ZPTGxp?=
 =?utf-8?B?UlJ0aDV4bzc4c25TOEcvOFAwb256cWt3K3MvTytDRy95c2dheC9GYXcwVytn?=
 =?utf-8?B?UjNiMjg3TWJQWnVoU05YWjdRcm4xeW1XSi9BeEN6UDQ3TDNYdlplY2hmcHNI?=
 =?utf-8?B?QzFNd29nUW9QZ0RQL1FhZGpSTE1UTVNPVkFiNTVzUGJFd0lFMzBRU2x0Vlpi?=
 =?utf-8?B?cDhwd2xrYXY1WExGelY1VEtCeHJtREdLS1hkUTFnQStBYW5MY1RPYkVNZENQ?=
 =?utf-8?B?dmJjTXBNT2I2eVpBVU5VZnZ6OTZsZmppbXllTEFCMlRxaTZoVlBQMmxROGZY?=
 =?utf-8?B?S3JEN3J0UXA0OC9OMjFVWGxNdmhFT3hHcWZiRjA2Mk4zYmJ4akpHU0pwalk2?=
 =?utf-8?B?TWZTc05vY211WjB5VDhJdm8vWVVzekJ3VDdWSnRPZkVDYVZ1K0Rhak1tNldJ?=
 =?utf-8?B?RGF5NjRFUGhKcXBtOFpmbkRpL1ovSUpXdCtpeTRYZDY0Q3l2aG9xaHhVSUYv?=
 =?utf-8?B?K0tTYUJUdnNQU041Q1M3eml5LzRRTS92OWFTWXdvZkx4SlRzTnZzczhNeEVa?=
 =?utf-8?B?d0Ivb1NCWk9Wa3l0Mm5iN1VPQS9BQ2lFalQ1SGQ0V3oySUswKzNMRWd0SERW?=
 =?utf-8?B?RkFVakYzakpNbThtWlkrR3RCaFVxTjd3dGxjNlNjc0EyRlhaK25lbk8vL243?=
 =?utf-8?B?RnpaZ2hhdG1HVVZOdXVsQ3VTeExPVUprVG9paDFIalZjYjlSaEw4YVg0YTl5?=
 =?utf-8?B?NWtsOWpKK3c0OGptTkthanU2NW9RWEV6bU01cDVHZmhoaHc4eFpIZHNBTnRh?=
 =?utf-8?B?OFo3RGErK1BQaXJXei9Qd1VUSEhKTWhhaityZHY5N2dscG15UVpZTXFQd2Jn?=
 =?utf-8?B?OHV1c0pZZXZzMHkySmV3Q05Qb3drVnpneTBhK2VHOGZKSENNME5RTE5QcXlk?=
 =?utf-8?B?WVRMb0lZaG55STJBSENBTzdYL00rUjBwN2ZodnB0a3dFODFRbmRJa2l6Rk5h?=
 =?utf-8?B?T2c0NFgrYXNLS0RXTDNaTEpYNzJvMEpwZU53bnBxNHFwNk1ST0lIUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c72bb8-cd3d-4164-2895-08da2ec2b9cc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:11:50.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lH2lHkt86ZQjmB+ldbjQNwIy1iqwckj1ftHle7L+xOKAV6peEqF9RQrU9X3/b8CXhW6ZY3gnVcwAdmjsYy80Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the help Thierry.

Best Regards, Dipen Patel

On 5/5/22 7:04 AM, Thierry Reding wrote:
> On Wed, May 04, 2022 at 08:17:50PM -0700, Dipen Patel wrote:
>> Hi Stephen, Thierry,
>>
>> Before sending patches I compiled and tested with or without HTE
>> config successfully, I used gcc arm64 cross compiler. The initial
>> problem kernel boat reported (reproduce step snippet below) used clang
>> as compiler and that gives typedef issue which is what hte_return_t
>> is. Do you know if we have to treat it differently with clang vs gcc
>> or did I miss something?
> It's probably a good idea to do builds with clang at this point since
> apparently it can catch some cases that GCC doesn't. There's some
> documentation on how to do that here:
>
> 	https://www.kernel.org/doc/html/latest/kbuild/llvm.html
>
> The process is quite similar to using GCC and it has the advantage that
> clang ships with built-in cross-compilers, so less hassle setting things
> up.
>
>> However below failure seems like (correct me if I am wrong) Thierry
>> might have changed typedef to int in one place and possibly not all
>> other places.
> Yes, the hte_return_t failures were my fault. Turns out due to some
> dependencies not being fulfilled my test builds didn't cover gpiolib
> character devices, so I didn't catch those.
>
> I've not got a couple of configurations that I can build and a short
> script that will verify that all the necessary files have been built, so
> that should hopefully catch such issues in the future.
>
> I had also pushed a fixed branch yesterday and it looks like today's
> linux-next built fine for HTE, so it's now included.
>
> Thierry
