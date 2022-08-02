Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335335883CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235702AbiHBVtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbiHBVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:48:58 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2043.outbound.protection.outlook.com [40.92.23.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266852453;
        Tue,  2 Aug 2022 14:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMnTXuqpEhIKb/NgRctewzmkxMqWVqp/Jv/GQTk8BYBzvR1qSpGtMS6Lwp8PvTqp3lglx68EAt1KVeuUbYTcibmqfe5fVqpfzeQ11rv+RWUoH47ZUcOGbIdullj+GUN03L4M9GFEW9B9PqGBpvz2mf6AXl3API86YJuYryRWwYl95SkZ8BdZipx1ziW9TO5QSQuQmbTXEcAAwHvqZhJQs0mSYUjZp4vXgn5TINU1uNEnzfKpcXTk7zyVestKvYOJgBw1AFWKGkANEa1J7KlCOKytuL71m/YZo8BxgtEeMsoln03TBMc9jDKw7Wyimbde5eDlJfy+kGfq3iWUblZrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecHLiGX9LIOMGnLzK1OLXnFdK9Os7h/F4goajBAvJao=;
 b=oRVwledqp4FUjqroI8f+40FP5sL0puHXO0JMtUy2Pk9hTN2e8yKowjWEVewFJ+P7qdz2vD+b0eNsKTQkvF1b1hifTeSESIinOM56+C7e9o2I8VtHhC3XllH2Zw5x09LqsaS8Fr3x4wbj67ajhiaZe71LEa79XvFTK6qC2QOaLs3vAvs3T2A+kSCM+mIIbcRW7XV8Iklb6exMxzrsWBiaEkDRQrGw0y3jb5Yasq+ESg/irB6LWPiLbg1FWFXPj3KtREoBaMvdOxBl9XTApVbpOK1ScaXDu4EcSsEadUYWZzWW5mJ8BCLKydFdw0GOpz/9v5FiHeg5r0z/MAiwsN1N1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecHLiGX9LIOMGnLzK1OLXnFdK9Os7h/F4goajBAvJao=;
 b=IRGZ7wCYjD6TyUSG5B9BNHnbEkH2BLFzVgjZQHRjbN3AvtMdEcppEND2Lo1ws8vE9scH/Yun7cP97+wa6qVlvkKdn2aNEMHuxLfFs0sI739Yn84NY7wqDdovXYVCEZWe9UyWwBwAqs7TeVYSHJKjM1ktvqTllyd64JhUIW1mP9KpHA1fh0fhjP0JY7jkuhINWBokvUlQwkc6SzNKfgdRbCOQvTScoVvqCocBHsnuqIpvw8KimdAOloiW8MUG7+T0EAWc9JfDDcOD7g30IW6G+2N3zOHeW/uxDG7sYH7IeRSPV4H0unC2chMyy6RzQQ0W9XYUb36xE9WI7EypWHrq2g==
Received: from BY5PR02MB7009.namprd02.prod.outlook.com (2603:10b6:a03:236::13)
 by BYAPR02MB5960.namprd02.prod.outlook.com (2603:10b6:a03:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 21:48:52 +0000
Received: from BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180]) by BY5PR02MB7009.namprd02.prod.outlook.com
 ([fe80::e080:d670:29c7:9180%8]) with mapi id 15.20.5504.014; Tue, 2 Aug 2022
 21:48:52 +0000
Message-ID: <BY5PR02MB7009690D397E52593431E12CEA9D9@BY5PR02MB7009.namprd02.prod.outlook.com>
Date:   Wed, 3 Aug 2022 03:18:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v2 0/3] Add support for Xiaomi Poco F1 EBBG variant
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <BY5PR02MB700972E09CC9D8ED6EFBA59AEA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <CAA8EJpqBVaPt6dc+=u1YZwxEo9i4Y6+QFK5ko0Gd3091pKYXjw@mail.gmail.com>
From:   Joel Selvaraj <joel.selvaraj@outlook.com>
In-Reply-To: <CAA8EJpqBVaPt6dc+=u1YZwxEo9i4Y6+QFK5ko0Gd3091pKYXjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [LkgtmTZFtixG8NNrdJ79qV3i9C9buPhkgCACLcPei/V/mOtZ9OAIVovb2AXkKxRP]
X-ClientProxiedBy: BMXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::21) To BY5PR02MB7009.namprd02.prod.outlook.com
 (2603:10b6:a03:236::13)
X-Microsoft-Original-Message-ID: <55619ad3-d6fc-a7cd-753f-04dfcc2e8e8f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b998159-f5e4-48ad-b0b8-08da74d0ca50
X-MS-TrafficTypeDiagnostic: BYAPR02MB5960:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOebMrC55vdRO667VFxELrzN7VQNAHYmofE0rds1r+U0mH0kgbHsOJUxUzkrZrij3DuzQ9WxVzSrGxX3i/KYuNQg+qfMdAPv6aMJSlgAIEyZs3sllslbAwS2GKiuhVv6bFo+SQ8OvDok+7Ro85vyOUqVm/gAhHQD+R3RTP5HblMaqgRqGVef6ASdYc0qpvgPKoi2UMMm68lcq/6agfgsorShGt/sF0KWbZ1nDQq/7h9Im8vJ1iJdcTTgr4aW6eClq7Lc6nav5JBUTHOrZWiU1mT8chY9ykbEN0tCrKTwXgE9QLp5dsbQG8BZY806lVXYZVx6Uc2ECREVRTV2HauWTB2RKDwJp9zRQjCoNVAEBTjc5e5dmHRe3443xiRlicC7trNluf4GN2vkcpLeo10ZW8KgyQZrA26j+EkaNDdjNrNXwlXwTPQYtw7Fkh1w8LbYfwj+jvimd19SxOHIot21gu43IPfumj7eQEpNs3IIxrL8ERZsEkCgGvAKwVMsXXnVS8zdWqTrP16pEGa0mN2R14ZOo0U0MVVnbY3n1SDxoCaHF/Pl7OcH4LLp5sl7mFUlrdN0oaKvTMU5YGqacEwQZv+BCXiwH83TI87NJa+HkaqxAybTl75GLZoxY4yv4j7sJ7rxVPZddq/dOCLFbRdigoilqx2TaLSFqSLqJI6Y0kQXuH8SuRpneRXf6/9bsp3d
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3pRVFZ5NTBwWUgva0cwS2NqcEtTNFN0ck5JalJJOTUrM0FtdWpJcEpiNS9O?=
 =?utf-8?B?US9vVlliaHg0U0VMMnp2MGNQSHh3RmpGdC9ZQ3FwbnF4RlREd0lzRWxWcUM1?=
 =?utf-8?B?bWYyRnpLcFdBUk9waksrVjlSa3FtSEVmSHVwSm5ZRkplNVBsVXY1dEoxV29U?=
 =?utf-8?B?RzAwU2hkUHZrbWgvL1EzamJablJ2OFRPeFFoVmI1QURIaGhMenBCd2JRY2xQ?=
 =?utf-8?B?clA2ZlVoZkJmTk5kZG9xejlDVnJ3akppYlRZQ0U0YjF6a213dGZvc09tbGJW?=
 =?utf-8?B?RHN5V21aemtGYVFGUHBaRXpSUXNKWDBmL01lQUVpQ1RzbkNDVFZJc1BIL2JH?=
 =?utf-8?B?L0d6bFNxL0U5Z29MOTZLeHdrRS9XNGtZT3JJRW5ZbEhJdVNaVDNmMjd5RldO?=
 =?utf-8?B?bG1mTnBKQ1B1bFVoQ0dlZnN3T0drKzFjdjl4Ty9oWVc2VDVwYlhFd1E0K2F4?=
 =?utf-8?B?MDNGWFBmdmMyT2ZLclJCeWpEb3lkZFZXc05paC9aWWdGVjF5Z0pWZmhYbWpR?=
 =?utf-8?B?MTNUQXplOFpsenJENGYrTFM5SW9yVndJM1JaeXB6Tml4QUhvZkNNMittL2tF?=
 =?utf-8?B?NGQ5K1phVGpTQzVhYVNVL0hkNldaME5ReXhIRExjRTZuc2E4UjBsRzdEeUhQ?=
 =?utf-8?B?bzVUT1RIRzA2dzhYUEFUOGxMNFhaNTZyUnp6eHlUTStsVzFUalJ4TEJTMDRh?=
 =?utf-8?B?ZjZjUHNKVjgxTzJBVTJuRWpRRmpyTjNIWFQ5Z1pBbWEvdEZmbmNsRkp4K1k5?=
 =?utf-8?B?U1EwZHRXOEpWanYyOEhOb1BZNmUyVDBSY2lvZzZ3QlFZZk5jMXlOUVU2ZWFp?=
 =?utf-8?B?ODBTNGJHVWxKYnY5cENYNk9YWDl1eGs0aElVMjhoc0JkdlBlMWl3UlpuOEE1?=
 =?utf-8?B?c3laWVdJajNQM0VSZWZBeExUUW43NFBxZC9UT0F4ekMyRnphbW42Y2ZDeGdC?=
 =?utf-8?B?RWpJVDBESnAxTEhkY3gyeWtUR1l3SjN6M0Nyek5SeVIvRnBlRG5iV3RDWHF1?=
 =?utf-8?B?OU5YTythbEdnZWdpK29WNVFwSVdaYVgrRjhDWnA1SThwc202ZUYxSmRBeXJa?=
 =?utf-8?B?KzRXemFEZ0I0MFA2T2IvTTQxN1FUaGp2TnFUaHM5RXZKQnlPUTZrbk4zSi9X?=
 =?utf-8?B?RTY5S0lVYVpKd0hUWmp4SllvRjMwc0dsNFhSa2RZVS93ODlZZHdpTFh4aHc5?=
 =?utf-8?B?RFJsZzVtd3IwQS84TW9nZTY2RGNIUnF6ZWF2a1pTNVBUbGJoWkFRQUsrU0Nm?=
 =?utf-8?B?NXlkVFhPaGZaOVlWS2NxTVNCRG10OXZaeHNmTnpNN09XMXc1QTdnT0toSlFZ?=
 =?utf-8?B?bGhOQzVoczRIZkZBcVJDS3p4eTFPTFY4TktpdnFzUEpwS0NPN2FVcENHY0gy?=
 =?utf-8?B?NE5jQ0FmMjJWR0plZWF4aEpYa2dnU2M3OGJ4RHVuTGQ2cUFoOHdRR01UT2ta?=
 =?utf-8?B?Zm1oUWMyamthTDhnNklGZVpKK25yRVR3MXpTZzh1elZJUml3OGRpVDEyRytl?=
 =?utf-8?B?N3o1Z2l2TGNKeWJRTFRzbmdBNjNPeWIvWkRiNWNCYlQ3by9SdHBiRUhFK1lL?=
 =?utf-8?B?UGxRdEdqa1VpVXU3dnZwUk9KMkVNRllUaW1jSC96MUMvRkNmaGc5UDhtRktV?=
 =?utf-8?B?dkJsVUhuRU96ODJoWUFSR3B4U1ZJZCtSSStDM05ocGdlc3JTSnBSNnZzZFVp?=
 =?utf-8?B?d1VUZW9uc1VxNGV3Ui9WZG5MUzBoTjJGVytZSGg5cUswazdyK3hXTHAxTlNr?=
 =?utf-8?B?NGtxU3ArZmpMZnJvM3Z6SkVvYklhZ2ZHOUVDd1VjdFhIZEJCM2V6aDdHaDM3?=
 =?utf-8?B?azFtSXk0Q2dmNDJwZ0pNQT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b998159-f5e4-48ad-b0b8-08da74d0ca50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB7009.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 21:48:52.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5960
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry Baryshkov

On 01/08/22 20:30, Dmitry Baryshkov wrote:
> Hi,
> 
> On Mon, 1 Aug 2022 at 14:44, Joel Selvaraj <joel.selvaraj@outlook.com> wrote:
>>
>> To be honest, I have no idea why my patch series doesn't get linked
>> properly. I think there is some issue in my OS. I use git format-patch
>> and git send-mail to send patches. It used to work fine. But it doesn't
>> want to work anymore :/ Is there a mailing list for sending test mails?
>> or how do I debug this? Kindly let me know if anyone has any
>> suggestions.
> 
> Judging from the following headers, it's not your OS, it is M$
> rewriting the headers.
> 
> Message-ID: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
> X-Microsoft-Original-Message-ID:
> <20220801112512.209047-1-joel.selvaraj@outlook.com>
> 
> According to some mentions on the Internet, M$ relies on headers
> rewriting and will not change this behaviour.
> 
> I'd suggest switching to another SMTP submission host. I think it
> should be e.g. possible to tell GMail to send mails with @outlook.com
> addresses. However this might confuse some of the mail clients into
> believing it is spam since the email will SOFTFAIL the SPF check.
> 
> Switching to another mail provider might be an option too.

Thanks for the suggestion. Plan to switch the mail provider for the next
patch. Hope it goes well.

Best Regards,
Joel Selvaraj

