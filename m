Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CFA50C52C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiDVXSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiDVXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:17:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C341869E7;
        Fri, 22 Apr 2022 15:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM8ltXRKjKnd7qLxCrcGbP+3875IyADGTab667CFr7KWA31t9UyPw+JoyiGpF+bhKOSa7huyT27rbcwZYr0K6TRfl7uqkMQDCY6ZNZjI8V1zd8J4rxjBxdganiQGqxavOng70R23Ds55zhqPwzU915W3v+I1YCD6YTHWKOySpckU0l0gI6L2iajfwLzBR4yZuXDGB9N3jXsdXk2eLOwn5T17RDm/TRjurOSSWp7BGs4nVwMS7ktgBIjSOM9hOU+HAcf5aD64ogEXYCwey/LB7nhr78zDzY4W3i4wn4u8M5ogdPd57YQ5vsUMyl/8O9o0re3j9euljrmaQdYJ42BUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzTJkwFu9v2KwFg8KqtdTXowFbJNRyJb12S2ODGPNUg=;
 b=UxjziI7dhLlqkSzkvgmv5IoPiuUrH3B0YDxdTyu7J5rhfGlM7YoghLKSeLqzR8eTiSOBKOyQRsvnvm3uNMcpbAx48Z7LAN6WPGIy8kJ29XygWqKl/9elwEBZU97amoMLSzKzeF88g2ieoI8ykeGmVV92ENrUt9Ow2gRFFeUM5P2P0yMv5OOPAj0TI7sFjdGCldufw+5d94zyf/YZei/IhRhTjG5P1jXp1804NBP05E6NxdkKid592Ctxlz3uxucZi7+e6xITL8sfMjPlR3gJZ2hd9KUBoFC/hZiqsYy1xDMWb2ajzZh18LqWJNFfkVPni0KKEnXy+NhUST/YYK8jZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzTJkwFu9v2KwFg8KqtdTXowFbJNRyJb12S2ODGPNUg=;
 b=EuvfOFMIxqlrOsGuDmfQf7kGYkqo3mkHBDCQrsQZnDqoulzelGrZsv55xALbBC2E02ycCobmmAUcB3FO58Hqsoy6rTVLcbhOiSgnNjqqtzRKa54vA8QOahpq5jIhyqFhdCZQveL6HZMWIuKN5ujfquG7h82n6f5tUfRaIxnJw1bPDGKOiS5nOMWCkh4YPF+z5RQjreiMBkVQTsKOSBn3FTFd3LWZix2HV+2aA0goruiNtDi7Pw/vVNk+NfxuMf6aF8TczBBUEzbE23vH03ePzdhplXIIodtGwfgk4DZfARVmilEWJC0CiazeGqClxhMEc10dt+edeh4cd99+f6G3cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by MWHPR1201MB0141.namprd12.prod.outlook.com (2603:10b6:301:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 22:52:05 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::b998:eed3:9088:780c%9]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 22:52:00 +0000
Message-ID: <8cfc6478-2aa1-b864-88c9-99fe3c09e179@nvidia.com>
Date:   Fri, 22 Apr 2022 15:52:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 00/11] Intro to Hardware timestamping engine
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>, thierry.reding@gmail.com
Cc:     jonathanh@nvidia.com, smangipudi@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        warthog618@gmail.com, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
References: <20220329054521.14420-1-dipenp@nvidia.com>
 <CACRpkdbGyrRU9DDTmNDpU52rECAKY3wfi2y3jo9FMypDG=pmJQ@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CACRpkdbGyrRU9DDTmNDpU52rECAKY3wfi2y3jo9FMypDG=pmJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::35) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6156c54-1320-4971-bbf9-08da24b2b614
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0141:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0141D1E2A3DBA0AE984F9676AEF79@MWHPR1201MB0141.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRbWdAQyViTHNKuGKfM9aGWftNzCFKF23M+C0nwn1WAtHAp2hSiquSGMEPTh8Zm7QHY5lIttZQ3eLNwtnqo1Iczn3DNGhqd6bpJNaNCmDjEVYSeGaf17CRHfuzbUhqOM0LO0E1CDwDzhE3+KOJBEC6KRVdr34Z0vzS/NyFQnTpibUka07EtcbXIxWvWT/X5zAxGUrMaJEq/sEDHeXV7V02/bM0oi94PQ9aV09fU8bMiig53xr514jdU2T/YRv9vuzXa5iTytfdYY1DxtWWeqe/rMyHu4lLlPrzRRS5wV9l0PL0adQnrKTTBlMYC5R0NPoKRSRLhMehncnAu8GPIZTUHHXceTrC6a4quZAkKoCJQ/tcPqk0jMxRoJMDbsd95wQWlHDk74vonH4UqDidNzkBqDMeQGA/IJG3oPq9zEMbDbiMuFFJrpm1aovWoDOhLySlQLetE7pSXz17aO7Ntc58gYibiEtq4vhdhIgwMVlr6XKS3KLoQ+dImdv/wqxXDvpO4ibyVpDf9hNdjJ5ocx+yt41fvyWIb/zwpNAVHCUm0mgsg6CrAM8QO8O5VfzjGOMIS4fw4Ruthpq1hp0fPOhlkHrEePqqIJWKJTxpLeThCFp3eCsQZ59fBmq0pkvE+lG/tzC3MpQl4m6LYL3U/UzxkRaxGJMwWXlzxVpJlXGaNZp+770ZKLsmcxAz5q68Y+DzVd3ru3zhHXjH3o/38IOB0uKPXbOBTeIO3V6B7CtZ2jm+EvTaH24AlAio07le6JcnkcC/bL3sS3sgLWO23a4OCSjszOGMiVGRHyONySMkf1mR/9p75Q4MYwSH8PqvCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6506007)(7416002)(8936002)(186003)(6512007)(2906002)(26005)(66476007)(66556008)(66946007)(4326008)(86362001)(5660300002)(8676002)(31696002)(316002)(31686004)(2616005)(36756003)(83380400001)(966005)(53546011)(6486002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxCY2lWelVvaHJmSGIxSDd1SWd4ME1WSjFoVjNIQ1ViR1lQSUlWOTYyN04w?=
 =?utf-8?B?K3JBTjczQlVYNnBWbU4wenlRYk9lWHpkS2N5YWVheUFtbE1XMDNiaW1PSnpy?=
 =?utf-8?B?TDJGOXVpYmNnOHdLTVFoWnlUQnUxUTcwMXdoVFo0aEoyUWV1andmQWRQSVhx?=
 =?utf-8?B?NDRFbHBkRHFaOFJkdjltdE5NU01QQXJXY05jSEM3U3JYOXNWdVVSaHlXV2dC?=
 =?utf-8?B?eGNybmt4RktLS2FIQkNTTTRnT0tFemNmdXhwK3JSQUpWWTZoQjV4dmlaTHVM?=
 =?utf-8?B?akkzLzBQeEF3QjZzWmZMWWVaK1RwdkxVM0NaQ1pXb1puWHhkeDhleFkzTFgx?=
 =?utf-8?B?Qjlrc1puN01OUEk4UGduVWZaNzJzSDFXTC9vSkt5c1kyNWtHeFJaNjdsZ3RC?=
 =?utf-8?B?clNJRUhvYUtCbWVSNmFoN29tYkJDcWJ1elp1amhPZklkWS9UaUtiNFhITmxN?=
 =?utf-8?B?RWt2RFIwVjVCdUpaNTFINlRFd1NxTWdXZk9mQUZPa2oyQy9yZmJTYzJudFJ2?=
 =?utf-8?B?Q29pZktvRGw0U1hvc2p3a3IrSVA5TkhkUnllK0xlSEpZQVFvb1E4bDJFSS9C?=
 =?utf-8?B?a2pHVVpSTTJlNXZUaThCaVhNZ3UzVEVidWFGbGRFVHkzZVl5bkZtSUFIYnlC?=
 =?utf-8?B?TEYwd1o0NXljOVkvMEVsS0RMSzhCRlAzbU5TS2lhL0xNMWZlMmcwai9sRk1m?=
 =?utf-8?B?dTFVUVA0L3dvWDFVaENwaHZQanpsL2NYMjh0bHRqU1FIUHRqLzJxQWRBMXc4?=
 =?utf-8?B?UDVTdkVJa2ZjaUtOVEpmVWVqS2tuWHVOdUhLbFR2LzFDVXBLWTBhZmxzN2Vo?=
 =?utf-8?B?Rzl0N1dQK01GSnlYcjhVZDNWM2lQUmpiVnRoVWF4U0Uxdk5wUzd4dmEzdWpJ?=
 =?utf-8?B?SDFrUVpCa1VpbkVIWm9TVzRIVWx5a3BZS2Fwb2lINzlncktGVEpBUFJmQzRG?=
 =?utf-8?B?ekp5NVlaTU8wckNCT2NzNVhYbUYyOVpWVmY4dld4SlZ1QXpjSGlMRXBLTWlM?=
 =?utf-8?B?c1IrbFZFb2xuN1k2RTh2YW1CQVJPQm5BdVBrTGJTeXpjNXk1dnNyS0ZlejJ6?=
 =?utf-8?B?ODhVSFk4bG9zbE5TbWl1QjVWelRzb3hxYnRmTG1JQjduOTF2MjJaa3FCWi9H?=
 =?utf-8?B?dEp4NTJqSEh3VFl6ckNpTkw5b2RDdjRhVklKeHR2clVUek5rNHA5K0JGbUZC?=
 =?utf-8?B?VE9yRDlqS0FNdWlkYWpldGFSR3NleTRjNXlQNGpBeExrMXRseUtNN2ZwMHNu?=
 =?utf-8?B?RmpTRmwwV1Jxa0VpakdVQU9EajhmdStqQ1pvc2RYVGVPY3RQRndEMDduZFVh?=
 =?utf-8?B?TkF3ejFOS0hHYndSRUt3SEdISFVEa2JMa1NqVlZyWGltUmZhWXVvOWFvR1Bh?=
 =?utf-8?B?YjE4UExCUVN6diszVUJkaFcrSmFKRGhWMk4rRzhTcmk1cGEyVVdXWTRGdnZN?=
 =?utf-8?B?d1p1QnZ2YXRqV3d1S3lxNWhXU29uc0h3WWtReWt3UjRtT29uOEYvR2tnM0xO?=
 =?utf-8?B?aUJQN0d1VWJyWnVURG9WbU1BVkpxYjJmVFRYczJqeXIrMVNIS1lJNUlXTXNB?=
 =?utf-8?B?aUllMUJKVEVCUm5LUW1Ga28yTGhrMklzdzk1bmw2VzVQT0VJTE4yTWpybUVp?=
 =?utf-8?B?UUhaZG5PcjFpWmkwcDZjM0YwdGJWR3NiWWlWMWZ2SCt2dnpXbWRpb1dQYy9I?=
 =?utf-8?B?eVROV2pyTHhveDBNQ293Qkc0N1IyenNDeDArUDliWmkvVU1IVVpiNW52Q0pl?=
 =?utf-8?B?WXYraVlwbVNIY2h6WCtOYk9MSW1hS2J3R3pkR3JWbHRuUHJnZjNEWWVjY1VR?=
 =?utf-8?B?Q2krb2M0UGxTNGRjLy9WblJhZ2JHeGRMRXR1S2w5cVZUMS9xb1hKemVVNkhZ?=
 =?utf-8?B?TW9KcUNnZExBSnVJdmJnc0Y3RXhZOVFvajIxVExqQXF0elVKU0FOdXZSN201?=
 =?utf-8?B?TjBRTU11amNIR3kzajdBSFhGYitmeVdaYytTcVpiaGswc3B0WUlKT0RNL3NH?=
 =?utf-8?B?WFNyNno4dXZMd3ZlYXdsMDVZazRSb0Q0QUJ1cHMwS3ltV0I5c0pwL21kdklx?=
 =?utf-8?B?NzJqQW1UWkRhY0hTYVl1UjNqbUZ3TVZDNXduVFI5dVBjR0VqZkJWZHF2T29u?=
 =?utf-8?B?d3p3L2hWZXhKR3lDc00rMnNTWDhPTTVqbGp1ZzlZRUY3djFTd082WU00SjFC?=
 =?utf-8?B?VVVmbWx2KzdZc3hkakswUlRZWVlqRFRReG1UcVlZTVgvVHdrNmkxLzZVVWg5?=
 =?utf-8?B?NnZSMDgya1ZKSit2eXVhbEw4OXdPb2RyVURiNTV6OFdlNHRIK2dxdTZLbjFl?=
 =?utf-8?B?b2lQb1pCbmJ0cDVwdjJGOTN6OEdidWYxVGJDTG5lejN1OHRXR1QvQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6156c54-1320-4971-bbf9-08da24b2b614
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 22:52:00.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vm50xoicZ35tdHlV71eSX3/HODxDGwyF3rqT/wRlXqu9KAGmnsoqQNOWz0kP/w4mleK4jysk3GQFcMTMIUQnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thanks for the feedback. I have just sent v6 version reflecting review comments in dt binding.

I have also added some init APIs in hte core and moved few codes around. It does not change

much from the consumer point of view.

On 4/19/22 3:46 PM, Linus Walleij wrote:
> On Tue, Mar 29, 2022 at 7:45 AM Dipen Patel <dipenp@nvidia.com> wrote:
>
>> This patch series introduces new subsystem called hardware timestamping
>> engine (HTE). It offers functionality such as timestamping through hardware
>> means in realtime. The HTE subsystem centralizes HTE provider and consumers
>> where providers can register themselves and the consumers can request
>> interested entity which could be lines, GPIO, signals or buses. The
>> HTE subsystem provides timestamp in nano seconds, having said that the provider
>> need to convert the timestamp if its not in that unit. There was upstream
>> discussion about the HTE at
>> https://lore.kernel.org/lkml/4c46726d-fa35-1a95-4295-bca37c8b6fe3@nvidia.com/
> I like this.
>
> Can you put it in a public git and make it eligible for Stephen Rothwell to
> pull into linux-next and ask him to do so, as we intend to merge this for
> v5.19?
>
> Yours,
> Linus Walleij
