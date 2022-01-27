Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A13549E21C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiA0MLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:11:23 -0500
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com ([40.107.21.101]:16896
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233669AbiA0MLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:11:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/eq+bZ9xMllD8HgPExENEoj6jJJfux1Q6j7Fg7qwDm/euq9VGaIswuS+i4dXwY06zUMI2/8cPkdWr1qb+MkcYlGNB7tH/vR7uhGcf9BLgvklvo6Us1e3DpfIqMvZXJfu2kJUZwL76D2aLnVaZhdsWJkl94VJq1FLpj0RSapVaurDucYFefyTRaH60wJHWf7uopPzIAOv6DxgWYSNMNfVyeewojp/xY4toC7CXWJymwsGdszAUq3FlemjYnGQ1a8I0p4QbkRtgcRYrwwRhoASvxamqkqK2G+jLbB/T5mEHyIaFT+tsOR4M/9m7W6o/MkLi62vGH9YEQ3I/6EP5ZAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8udWVrbw6jpUgPJaYJaACxuLP6SCOIhMol29XkPbCg=;
 b=oc+CYE3TvJJs0lnmQug7mb7KrjQdS+paRWYCVolNsC+YJdqoTesSiMb8h7l9JcIyg1p3qgaApQpOx0nzUCbzZ9rsRt5aKfD3M7Fem57hi7wk0MYGHbMR7R89r32neol3uuhy6uGvmXlI6xGVDiVWNkVt7sCbjSYAUArrs4OaDG6FAQjk2AJ75y271m4UczabAQsBh7B7j96W1zWX4jSCPBOGJzbii45bprMH4LAOM/s9ckVIKSC1J32KmBNQq8BMG6BRbPahxtnUx+jWaxCtJfOPtTXgKUciQMynqMSQj+ghYSIdLaL2+NKnJBDM2fJGavR809/gkosClHMipdNmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8udWVrbw6jpUgPJaYJaACxuLP6SCOIhMol29XkPbCg=;
 b=OZPOt5tVHmvvjZ0oLBm+pNP9OOpIExxNVLCVCQWEVR4fYQbl9fn8dabTTS9iZKaXQzjjvOp8t3DMBiQ7rufZ262of1TEI715dB6vfNFcaJhTPK9Ok2Ue5IHjaP6+J/h7arMHakhBd23FTOtUQJF3NlVNxwmUeJBTq+i/9G4xtCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by AM0PR02MB5011.eurprd02.prod.outlook.com (2603:10a6:208:fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 12:11:18 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 12:11:18 +0000
Message-ID: <c3fac656-5c9b-4b39-f5e9-e3637f4d5746@axentia.se>
Date:   Thu, 27 Jan 2022 13:11:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Content-Language: en-US
From:   Peter Rosin <peda@axentia.se>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei> <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak> <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
 <YfE45cImAQpOeziT@smile.fi.intel.com>
 <7ed2cdb9-0719-3535-9e0a-fd9d393f1cd8@axentia.se>
 <YfFGLjeAEWfAAUWc@smile.fi.intel.com>
 <7bae39d5-7a38-ebdd-074a-6c140dc3a519@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <7bae39d5-7a38-ebdd-074a-6c140dc3a519@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0052.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::41)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f10b99a-4a23-44c7-7854-08d9e18e1f7e
X-MS-TrafficTypeDiagnostic: AM0PR02MB5011:EE_
X-Microsoft-Antispam-PRVS: <AM0PR02MB5011649F73549AF2636D6FAFBC219@AM0PR02MB5011.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grCnwrTwvI5T8ZwQfUiBSLlzBFt+v9JrT0hJ5oVRfUus21jCcSkywYXe47wXSLVBTPrsjg4+NL0T7QSrLn35tCSlNStnczhTrrteft/SvMcBymhfqwApZ00NxgmeI2RmiMOSfFNKMXc+Qjy8IKWooXr3Kps9OLQ/yaWSnViX6OVfxwjA+txMOfxovFirClNgSgnHlcqALKr5KkiKj1LPk3K7ixET+YbCx7y+IoZH43jFcAJ6b+9ECfh1hHfx6K/y9kPEbVHGISAE0xBkd0y/fkjNVl8XludV6LM3Bd40pFRDtlIGqh9fIFPRWVyoC0hF7dOEB1757fjGwjnqKrUf+qKAjw1FHLJoIWbV+xSK9nCSAcNzwgA2g+QYEjAOco3Z5Q4lVo1v1dYr+SJ4D5z//ERFxr+noM3KuDdUfbmyZ+ebeCxx2kjYsIahSFJ3nu66IBoXvBSFVvqUeO3af94qpnLNvhYsNnlF5Ku51WkpQJBvXCY2+IrZ/J2Z8cOt5di7L7IyIaZ3igVYFoBLOOCEXd36+jXXDT8Q1HJTY+aq9y/Wh2aUk5zASByjo9mSws9mMaSQ14CQ/JgAsxmMRGEvqD9Sw6tqkqvKh5qUtdoR0fl9jSQQMMugUSX85FpiMKRV77kE6M0Lb0n3xhmSWVluJ+wa+vtZ/N4rjB2ArXy5tZXgr0Wuqoh8ppz/Ss/4XqraIkR06OiVdoE9gxEDwgWN+CsWE3YB47vg4AZcAjJiL0wNCGB98zqY52G4L2VJjnV0J8gORGZgpCnXZ8Z7fudV2nboOuJ4jBeSjAqpsemDUXTJtCz9ihyKL/9ai0MSWUPATsF4l49kb9N6+SE5ZeVdKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(346002)(366004)(136003)(39830400003)(31686004)(6666004)(6512007)(36916002)(966005)(2616005)(6506007)(31696002)(26005)(86362001)(83380400001)(186003)(53546011)(508600001)(6486002)(66476007)(8676002)(36756003)(8936002)(66946007)(66556008)(7416002)(316002)(6916009)(5660300002)(38100700002)(54906003)(4326008)(2906002)(41533002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJUaUdiSjVkNXRTZnA1R2VFMjNwVlVHZHdHcWZyMHdZUHBFZG40VDBIVWxK?=
 =?utf-8?B?V2hTV3crN3d2WWNwZ25yYlhSSERqQ2tiUDgrWUFLS2VDNHZhOS8vcG1JbWg2?=
 =?utf-8?B?SG11T1k5eC9kVGtlSGFMVUd4Zm1ObjBGakhxYnRxczFqenBJdm1zS0NkOVJ3?=
 =?utf-8?B?M0k4TEUrY291NXRXYTRVUEhqYU5CTmZIdmxBSG5PcnNLVlpWSGx3TWUvSGpY?=
 =?utf-8?B?NzViQVBRaS9RTGh0ZjZnOERoVkoyVnJnc2JBUXoxY3VkYVo3aE1QUHVTeDAz?=
 =?utf-8?B?NHlvYis1NUNCVFdmVVBSU0FwMFc4cm81ZU1LUWxPK2FvU01xYjZSRU05MUFm?=
 =?utf-8?B?RGt0b21aWCtXR2ZZUlV6NDhhbmxjbnh4by9iNmdsWFVWK0ZHTUV4TUs0d1U1?=
 =?utf-8?B?cTkxL2Qxbmt1RjM3RkdJZVpvMGF4Vm5ZUFFPZkNHV0xLQnFlNVllMTNqNFF0?=
 =?utf-8?B?bWE5UjkrbVBmTno4UjFyQVFNZW1Fc1Z0U3o4cDNCYzRmRW51WFJtNWpUWWc0?=
 =?utf-8?B?dUhXLzFBcHVlbXhUTy9Ga0NTdW5rZzlDQ1pXVnNvUVpQYjRRNnQ1SXNIanl5?=
 =?utf-8?B?b0xHa2lUQUJ5cnM1aEFndjhiQmhrVWJpa2ZOTmwzMGw2YnV5REo5K1JGbVhW?=
 =?utf-8?B?eDVXVHdEcDJLMnNyMjVxeHd4c2hYYWRnYnNBZDA2bFpIaFpFRGNuWkRVZ09z?=
 =?utf-8?B?K2VsN2VYazlESUs0emJySVIycWJvaGZtNUoySVBlcEN1WDBKaUpLSmFNbTU4?=
 =?utf-8?B?RUExOTVxYnN5bjRjYWNnR05mUXhTWlVhckpVbHlJMXQ0SVR2aW9jK3E3Z0Zq?=
 =?utf-8?B?VUJTY3hRNEc4R1cwVlorZUN6SFYvTytiTWlZbFozZUVjYzFhV203Yk5nNWw2?=
 =?utf-8?B?QzNDVmZKRW9HdjhqamR6dmg0c2kyMk1sVlFUV2lacXhNMEljZXlWUDVxL3Fw?=
 =?utf-8?B?YndHWmdvZnh5YkNtT0JCYTg1WXcyYXZMTTJpMGovaE92MlJPTm5zdnZ5bkJw?=
 =?utf-8?B?NnpncG8xclNNYUx1dUFNSG9NL1NjU0d4bFZTZUlkanVqMmE2VC9UVjFidFM5?=
 =?utf-8?B?SmJtRVlwZ1BlWmQwN01MeGlVY2pDTkg4OUpTR3JWemVnUWRUNmNIRmlXVnU1?=
 =?utf-8?B?OHRqQ0VRTjdrRWRZZVpUaGtrNVREc2hyS0NjK2pSUFJEZXpCMmhyOU5TTnBo?=
 =?utf-8?B?YjA0SUlSMzVjdGFaazMrb1R1TzBsQkRvZmg3QVNwN2Y3QS8rck5nTnA5aFJr?=
 =?utf-8?B?dncxNWtvYXR0YmtoRzRxejBteXpFQVV4NVVUMFE1czRXYUJ3VHJ1NjY2TVlK?=
 =?utf-8?B?RGNPWWFUejUzTzdGeCtoVGt5Y3VwT2ZtMktBcHQ5QnBBajVwYlZkMUxNRUxU?=
 =?utf-8?B?TTAwWURMSkF3ZmNqc3RIdUxuNTlEUTFVdmlZMWRhOGs0UWxVUW42ZkhDaC9q?=
 =?utf-8?B?c05zSmJFRVlXendjZ0NnUkZBdUdocVhLZURFa05mNmdpN1FoY2d2dG8vaGtL?=
 =?utf-8?B?aGIwcjlMZ0plMWQ2NlNpM0I1cDAzV3MvczNuNkUzbEI0bTFyZndHR25CZ1FY?=
 =?utf-8?B?KytZV291a09id3ZFUE9sU04vWXQ5SjU0ai9VV29aangyQjhFMklIUzhjWHRw?=
 =?utf-8?B?c2E0UmQydGYrMlFncG1iOW42YjdZOXR1UUdiNVpNRXRad0RjVHVSMnJPZ2J0?=
 =?utf-8?B?aHdWZmNYLzVETHdaekhYSkVjNXk0bERJTDgzS0ZZYXZmUWQ1WVdIZUlRSjcw?=
 =?utf-8?B?TmEveXJKSjVlTHhkZTU2V3JxOGlnN040dFA4aDExNGsyWGw2TnpIbUhNQ1Rv?=
 =?utf-8?B?Y0NZZnR2Nlo5Tm9QTk1tcEpXeWtZTlpwTHlaait4WFgrb3c0MW1ESTdpZW1L?=
 =?utf-8?B?N2wrRUVxMnJxZktyNFRoV1hWWHFFc2wzNjlQMFJnUkJuRFZ3b3NBOHZyckVM?=
 =?utf-8?B?YnA2WjUyK3U3SE1kU0c1dzN3OFZraGhMZTdaR1ZaaFZ0bHB5a0o5TGZ0OUhh?=
 =?utf-8?B?RU1sWVZwVjJBODNkTVl1Z1pVN1V3WU95ZDF2VWRhNnRzczB4ZkpUSTlvVTdT?=
 =?utf-8?B?NldWdlArNzhkYjI3bis2dWlkbmJTZWtET0hBNUhXQ2pzdmU3UjBlR2pmZEFk?=
 =?utf-8?Q?4hyo=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f10b99a-4a23-44c7-7854-08d9e18e1f7e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 12:11:18.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D3ZHrsab5a3eWElnz5KVy70OyXwwdhBq/H3psv1n5c2o6B34v/jev09IMQhtDZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-26 13:04, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
>> It's easy to both remove and to add back "the bigger object". I just
>> don't see the point of the churn. Technically you can probably rearrange
>> stuff in probe and remove the 2nd argument to ->props() altogether and
>> chase pointers from the dev object instead. I don't see the point of
>> that either. It doesn't really make things simpler, it doesn't really
>> make things easier to read. To me, it's just pointless churn.
> 
> Since you still haven't got a point the conclusions are wrong.
> The point is (I dunno how more clear to make it) is to have proper
> layering from the (current) design perspective.
> 
> If we go to the road full of "if it will come XYZ then this sucks".
> The future is uncertain and neither of us may prove the current
> change good or bad in terms of the future (unknown and uncertain)
> changes.
> 
> Preventing this patch to land is to tell "Oh, my design is bad,
> but I will keep it, because in the future everything may change".
> So, why don't you make this future to be now?
> 
>>> TL;DR: It makes possible not to mix bananas with wooden boxes.
>>
>> Which is all good until you need to ship an apple in the box with the
>> bananas. (e.g. if you for some reason need the bananas to get ripe real
>> quick, apples produce ethylene)
> 
> Really. arguments about the future changes are weak. If you have
> patches in mind, send them, We will see in practice what you meant.

I can do one better - here are links to patches from 7-8 months ago.

https://lore.kernel.org/lkml/20210530005917.20953-1-liambeguin@gmail.com/
https://lore.kernel.org/lkml/20210530005917.20953-6-liambeguin@gmail.com/

Or, if you prefer, the latest revisions.

https://lore.kernel.org/lkml/20220108205319.2046348-9-liambeguin@gmail.com/
https://lore.kernel.org/lkml/20220108205319.2046348-14-liambeguin@gmail.com/

You have made review comments on that series.

My previous arguments were based on gut feel, and I'm sorry for not
thinking of the offset in the referred series before.

Cheers,
Peter
