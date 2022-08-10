Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F0558ED18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiHJNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbiHJNYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:24:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C772A432;
        Wed, 10 Aug 2022 06:24:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBKZEAnQq9Gy9+CYBTEkSxZot6f8vzPxAzT0FW8taGPPYDVscUm1TbL9km1ZVsE9ymzTSoPY3zBleFCaU2cRr+Cw0C/tCv0e+ZnTJFaMRuBLlleRBwmPSSBEWFe6Or2JHt8wdR1P5O1NEGqDjmv40Fso/YeSOQZ98G1NerxLuCdne+0u5qYwPKh4ljkrYQVMp3DdjmMG3SJe0w0gqpe379FxPBaZRgPJaJyov8hGJ8/ROAVdLjGLpkt+Ff188XmEPT+ZL/ctFh+ORtKPyfPWAQLAGWSyxVjyip8mBmT7OgCWIlbHM/QJL9WAW5ib8/DeASN4/25P036k5AwTd3uvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCZaO7X0vaYe3AkxGz4KdweTzlx7cXPTDnVDA3XzHxA=;
 b=SD766bkFeCH+RVyKyBCJ2rXY7Q+7PMO+Nm5Za6/F3YRgLr+sR7hhn7tYlhqJ+Pm/Drdoz6OVMy84S63MUuHTFHT3I0PXNPDB3vpPrEFgzryFvNdlh1P+00VcRhiU5ypgPj21YBG74o3au19YKP8lHYCy3pceFrLwJI8uVOW94C3avzq57D3uBTIQG1damZcYVL1dHJm0xvgRD2kT/rfdykiAGC08A+UqVvWy4Qhb1TeR1dbp8FD8nhlSR+GXUyrsawxXwzMCNrQV66h/Z7DkrKt1Gyk6IjlyDxsWqn2kDeEU7LB68yEOhG46KGrdeCd7GNpVOsULGn+nawpZTLOPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCZaO7X0vaYe3AkxGz4KdweTzlx7cXPTDnVDA3XzHxA=;
 b=mJ8OkzTILdyEqhcrTTwTqRr5lElJxtpz4tM07PO9uQ43WOPbcHCaE1GRI3MTMQhYy+qvdhdBS1XYphXcrt4DoxK4NUAQfqBZjD7pGFlOIaNVGY9YityBh8pvqspX5wfWOXPauxnmXJPFHcZTqTQEE9TBBlMYM9TV6rQWSQgD294=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9)
 by BY5PR12MB4835.namprd12.prod.outlook.com (2603:10b6:a03:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Wed, 10 Aug
 2022 13:24:40 +0000
Received: from BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::219f:8080:9607:b847]) by BL1PR12MB5221.namprd12.prod.outlook.com
 ([fe80::219f:8080:9607:b847%7]) with mapi id 15.20.5525.010; Wed, 10 Aug 2022
 13:24:40 +0000
Message-ID: <bb9d1a37-5406-72b7-00f9-4144028f0081@amd.com>
Date:   Wed, 10 Aug 2022 08:24:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] crypto: ccp: Add a quirk to firmware update
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        Harald Hoyer <harald@profian.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SE..." 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220809224915.92111-1-jarkko@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20220809224915.92111-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0193.namprd04.prod.outlook.com
 (2603:10b6:806:126::18) To BL1PR12MB5221.namprd12.prod.outlook.com
 (2603:10b6:208:30b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a75f4f5-3dc4-47f4-961b-08da7ad3adcb
X-MS-TrafficTypeDiagnostic: BY5PR12MB4835:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twDKBBUM0qx9gy7ThnLer4cF97Gr6Ps27dwnCglrQhnuyMRDWMRt4kLbe8e+DxEK8xgKMYV9d1mcu4Kx9EqXfVeBbGZeHqGvn1OVh4mYXXMUA9wumsloL+GexhFlhojrg47/+jDkvX6vOC38b2ykyE5eYW/ZzYc4yXSMCk8r3DyI0435HN9StrVaxMjv/ssR7uRQSmuyQwhvZ3e36zr9JRc7Od1QO43jiZ3GjPSi8+yNNIuvg4zIZgYLGWN8JR/YB21i+U2a1mWvlO0z3AzaZCfoNTO9fccLsNj915k4odqUFolrreuPy6E8oFl/upOrB5YwFQlqRJRdv1l2HsnvbqaBJs+CcvfL59gtgoNukhW7gzX9TkDf7au+B4KaJ4A3qyToK5AJFy8qaHjQz6pEyHVM5yY4fzHz63LgFLlFYS14DM/biohs5DHHOmtTeMaoHtYecAsKNvOTXuzOGef4bb2t54LC94drcqXMMGBgHckdpUEIZtre+nfcwim0jOtEIXv7KYZ00y/q5KhXHxyach7oj8L6j1oRRsUVgaiMYjNrRVOaRZ8+P7gYfAlrsBSzQJ4w6towKcKzU0eWFfzy5h3d5hBl1suI7+VjSRMkgY26EaSZM6YBnqoEvZhonJQpsikFdCdgY1BZAtRbmXcNYMrb00Mq0wEdPb2Sq4ehnw5UFMHfEmxlBLwKgcB+PhQWLOYN7n8HpQKz2Hq0O/nVrRCwv9faA9Nb/XJDIvX8A90uB8tVPkZcnMHKCCj02HBnWdJRsaIEQMLN/9vc/AWsO/OMafpOWvsxeWCKAaWHxKqjps52dWFN5jNW2Y1scZfhCVjLYBOQnXombf8JPkr+J3fkA7RTZZlNaqiSZqJ+jgZSVuWVOToVyl0GGjPpUVxv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5221.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(5660300002)(86362001)(966005)(83380400001)(31696002)(6486002)(66946007)(66556008)(2616005)(478600001)(66476007)(4326008)(6506007)(26005)(53546011)(8936002)(6512007)(8676002)(41300700001)(36756003)(6666004)(2906002)(316002)(54906003)(110136005)(186003)(31686004)(4744005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QURtNFJJWlVXcFpIcWwvSWdvVjJRN1VKczR2d2wxMlFRanc1NFNqbFlOelJR?=
 =?utf-8?B?Q3IwVkprVUhIOVpVV091azJZbGJCbURBd01kODlFMUQxS1J1UnBBZjF1dy9m?=
 =?utf-8?B?Y2RWZ0luOUZaZWdBZksrcGtKYzZMcUxzcCtycEdwVisvMGkrR2p4M2dqR2xi?=
 =?utf-8?B?ckxsU1hWbk9BRmhtUzF5VWx1MkN3Z2hxQ3daVlZVYUE0THhPaUNUN1dadmVt?=
 =?utf-8?B?bFpoQWYvV051bklQek1Bd2R3TmMvZHNPOU9ta2NEbkl0bG9INTNaM2FFaEtC?=
 =?utf-8?B?cmlLTjMvZ0xQaEY2bUJ3dERBZCtDOFpSK3pCanhOSFdkQ3pIdnlHeTRvVWNJ?=
 =?utf-8?B?SENGZVBDU083WHNubGFBd25tRGRKc3BuSlVYL2tzeXhwUjQ0c1dvV2JTVFZK?=
 =?utf-8?B?OS9SdEthemxRS3ljcGhoYk9nU2pvZXpZTFdFSXcwdDF4WlJFS3orY2FjYzFx?=
 =?utf-8?B?cG9aN01EVXNEZmpObEM4VGpVNHBucjNhcWJ1UXNvWGYwek13OXJ2UFJCbGtW?=
 =?utf-8?B?NUNranR2U0haVWFDWnFJU29ZSTc3U0tLTmVONzF3dCtOVlR5SUt5V2ZBWmhL?=
 =?utf-8?B?aEluSkErT2pHS0kwWGhLaFhUejh6Zm9ITFV6VWlWM0g1ZHVlWmcvQ0NyWU4z?=
 =?utf-8?B?REhyZGNXejNiZnlyOENheHpJQ1NpM1plRURLMWYxMVhxTVMxbGNCaHVjaXRN?=
 =?utf-8?B?aUtRMCtEZWc3NTZVMEZaSGxuck1vaDFYdCtDcEVZV3NURlF3YzRkV2MvczJ3?=
 =?utf-8?B?U1VsY0FrMFpVQWVYVVNiR05lNGdNUUE5L0tVRlIxSk01QW14bldJdzdiVzVV?=
 =?utf-8?B?MERrK2dORTJOWWFkZGpOc1VjaDJycGV3ZTQ0VjdSQ1NVd3AxS2Vhb3pvMVhq?=
 =?utf-8?B?Tmczc3p4TU1meHRKK3MwVUpKblEvd2U0bEZSejE1MWNWWnoyaTNIVXFZaUhP?=
 =?utf-8?B?bHp4akdkSUVEYVNBUlVUVVVuUnB0eWIwSEpSZW1VTkhIWk5GSGdPWWM5QlI2?=
 =?utf-8?B?cndEQ2VrOXIwTkJvUXJ1Sm1mdHo0NTlvYmFvR0dzVnd3bCtnUmFDZi9PN2R6?=
 =?utf-8?B?YmhJSytCSVliZEtEK2xIekZVR2x1eXRUdGRLcVNpcGphRGpVUEE5alJkYWV4?=
 =?utf-8?B?VlBOZGxvZTZyRjBoRGZpTFEwLzRtNkF1TnJ5d1c2ZXFtUG9xNDI0S2plQUpN?=
 =?utf-8?B?Yis3ajc5RFc1Wm1MNVNzeHFBU3JCcUFJY1Q0YXpnYzg0bGtyT0pWNTFRcDdi?=
 =?utf-8?B?Q3BndGdHaWVPWHhjdm5LbUJDWU9RTi9QbDhXd2NvRXhra28rRHh0VHdPUGpQ?=
 =?utf-8?B?OFN0b1VtNC9MNjdWd3MwazJvVU1ldnlYYW9XTzlCVm5HOENlRlZpaVBCL1Fx?=
 =?utf-8?B?WjhwMHEzazJxWnVKaUY3eHVSZ0F4TGNmcXhPOXJnSXJlK1Q2RkdtUkJ6Mjhp?=
 =?utf-8?B?UVhkaEl6UTA0V0xyS3pMdC9yanRjR00rQ1lqL3hQRU9WUG1zYnFwdWFJSXNV?=
 =?utf-8?B?NXdzTC9mTUZYcU9wenBPejJydVMwUk1LT3B2Vm8yZnkwQzloQzdaRkdHS0dq?=
 =?utf-8?B?VDcrU0swSGx6ZDBKd3B3bjNZRXBCOVlNdFBGeDllVitZWEt2WWtnNnVIb3dV?=
 =?utf-8?B?Y2Q1aGcydGdGVkducWJjMERnbkJUbDFHdjZVTWtUVTUrajdVVmt4endERVdM?=
 =?utf-8?B?OHd1TDRaMUNrOENRZnJ2L2pwMk1aYmlUQzljTmpieTJUSkhVSGJGZDhoeFYy?=
 =?utf-8?B?TVQwVFFGcStiWmNPWHNqTHdMMXZ6a2UyQ2lUTC9WMWp5UFRRa0dQa3RWQXkx?=
 =?utf-8?B?ZjlxY1NTNTBtUmQ5aVpEM1MvZDNvSEdSSnEzazBHNmZnekZ3OUxWaUpTYmtC?=
 =?utf-8?B?YXJ6aXkxM1BESXBwbWtKNDFJZ1R4RVF2cWtZWEFzdlVuS3J6eklGR1lQeEFY?=
 =?utf-8?B?MU4yQkZhUEZmRnFKWGJ1cnhRMExXZEJxR3hxN2dhM3F2RllnV09HTHhzemZU?=
 =?utf-8?B?Z0VnU3M3YWlkdW5wVittYjdieWlKTzZBdXVyNU9xQmZCVkFFNGVxOUwvdG5s?=
 =?utf-8?B?L2VjMnpOMGNucHdSYzcvSElWSGJnK1lYM1ZueDQ5M1JwRlorWUkzSVVYbGM5?=
 =?utf-8?Q?d47K5UNYy9vS/epovpaJlo9zv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a75f4f5-3dc4-47f4-961b-08da7ad3adcb
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5221.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 13:24:40.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qErgteN36FSfchrKxVySiS7eegKUUabIMa27ESEc5faf4D4/z1JeBBF385VBX/gDbvQSJPFiVhenjQL4DBRDvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4835
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 17:49, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko@profian.com>
> 
> A quirk for fixing the committed TCB version, when upgrading from a
> firmware version earlier than 1.50. This is a known issue, and the
> documented workaround is to load the firmware twice.
> 
> Currently, this issue requires the  following workaround:
> 
> sudo modprobe -r kvm_amd
> sudo modprobe -r ccp
> sudo modprobe ccp
> sudo modprobe kvm_amd
> 
> Implement this workaround inside kernel by checking whether the API
> version is less than 1.50, and if so, download the firmware twice.
> This addresses the TCB version issue.
> 
> Link: https://lore.kernel.org/all/de02389f-249d-f565-1136-4af3655fab2a@profian.com/
> Reported-by: Harald Hoyer <harald@profian.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

