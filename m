Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3927F581DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiG0Cjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiG0Cjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:39:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678115FDB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 19:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBSnOGuiahEEzGxNvOIt2CrWeQkiAkWoxktPUl+tIrXpD/VmQoA+X681D7vGU0gb34oVlXBG6k8Qm6c1NIq+W6hBmyGMzQRdPjLerztSgRTGKfefjliTauqdOePQFkC4G2o/mop5dljIhSonlol4lo2JFOI9LUECxSki3ImXlYDzniTZrycBA0ecca/V6++jV8ksdq/d8F/JjW1l47XQd1nSm4Mqpi8tkBm3b6s4VquaYX0I3S3CSZiakRaggDjS5y0EwW1Ga3g20L+nFGuOknHuvsgbmgD228vPhzPbCUQk143ELUdd42vm03K0Xap64AP4PqxzHREnvyh4KmRHoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDZd34IMJCasbjHdpsqbcPs8WQh0LQBvkfu7wDDqoYc=;
 b=CbSAw9+BWo3ZAOWy5MD6pFJvb/KOAIazlmiXrutNwV5oShVJpob+cAD0iIpxFUWCOfSsnSoudXhX+HsxySFoJ3AQ9DbVSbG/4hWb3TbuTMvTgpPt8Bsf+ouYA9zmDQNq36X9iCvJe0Dc8jO9d91xyP9iZul54qD3/Iu+CUeUR6witWXEb8WuCWyaDm9X3pF8syf3DocLXA8hJewfGZ+qDizyn09bBU4Dx427qmhA6cpij2vM9R43q+yDdIgKMl+HexO08u3tSXDy5dIpCAhSJxL8Wte3apWcfiIDZFRrDpA7ZqHlZvKoXlkDxanFZLFi+C6++n0IfP3JckVauPsUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDZd34IMJCasbjHdpsqbcPs8WQh0LQBvkfu7wDDqoYc=;
 b=q4vMlgqSg0RI8HRB6rkV24qsg4l0jkk5A0oxT6eFPBOOuzjOM0KOarXEA2UGMVicNqjZ70yI6vQPNLLxsw0lHdPqqrvsHfJrd3rBYArPB/ALZV40RL5Zxy8T1t8/zoSVd27EoXkPkQoevdxZpZPOF68d+nZT2njbCxUN3GaZmpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 BN8PR12MB4625.namprd12.prod.outlook.com (2603:10b6:408:71::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.21; Wed, 27 Jul 2022 02:39:27 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::d4af:b726:bc18:e60c%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 02:39:27 +0000
Message-ID: <abf52a1f-d2f5-43af-c5da-cc8be90c634c@amd.com>
Date:   Wed, 27 Jul 2022 09:39:19 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] iommu/amd: Add support for AVIC when SNP is enabled
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        joro@8bytes.org, will@kernel.org, vasant.hegde@amd.com,
        jon.grimm@amd.com
References: <20220726134348.6438-1-suravee.suthikulpanit@amd.com>
 <20220726134348.6438-3-suravee.suthikulpanit@amd.com>
 <20220726153227.caqf6hagmwu727ls@cantor>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
In-Reply-To: <20220726153227.caqf6hagmwu727ls@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67b306b5-936d-44a5-c53b-08da6f79392d
X-MS-TrafficTypeDiagnostic: BN8PR12MB4625:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6j32X7fru+WBOaJKpA8cCUqf3LLIGCFB/ibcIXXfVocNCjzsNPOm9DrJbYpY/d+Pn2xVQNly9MXmb7TgrU1piTV3HA5A11n/96uiiINrHLb4z2ghAfMA1MGP96QMfGuw3EdjELXEvwoGbVyqIgLYwRFvmolFMgrJVBkgBkfsc8Xo+iuuiTEicTpn3ppbed6egyq+nL+gDE5d5QdXrcE2PJVqW7WzHL5zYHzN1dEIcrmXq2KgeccDf212BjWh5yi3CcsoeYdSDSqGehtvUBEHz8Yn+nvFt3Vdsi9g5nY8N1GViF4FO0puOq1svfbTV/HjJjSS6ApyXkFnd/GOwT8qlONxf3jvn4O9Rnvo7Lz15Et/LrqieE6RoR5tNvjimSJ/jHsyOg5C6thTquJQPcunlhXH86anYgjchowuFLPl20NafHaVc8cwCO4odNnQYVVeC/nksnNXqemuUu3UBJes2XTQgarZvRDYbg+2AOYq06o4hBv0wV+p3d/t6hk/995LMyaxKtGxyNMGdMo1vC2RhNdoiPn+FvjEUgTgJFj4K0GMgTyJ1ZEJeCoxfJzwomzSbhIw36ggHh5v2gKVaIhH0Dajrb7t2P3OkoD7P4SRkN2TonYoJ90R0USMGKCnZngG8PAAsq37xsZlaHYMmQ+avDQDgmEnFAOx48iw3iOs/CXUr69JczXcx2mlBFLMUwkRq2lsm1E4jbxPOQvwZUTt4Pl4ahnA+kbELde2alC19S3hDkLk4SMG3VkEbY36O7E3byreCemN5Q9dJ1HMC/9yKmxfbwPqvVymPf1SXG6ubqBUm5I/a2gfbRYXRt5BOQXxoVfcaqKtq3IIziv/RuWa8pE1G76AYxW6RFhBOI5Ssw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66556008)(6512007)(38100700002)(66946007)(31686004)(8936002)(6666004)(4326008)(36756003)(45080400002)(8676002)(31696002)(44832011)(6506007)(478600001)(2906002)(2616005)(41300700001)(53546011)(6916009)(186003)(5660300002)(66476007)(86362001)(6486002)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW52bHVuT1phY2REN21qWTRGQlVuakR0M245SzZMeU93RWNGN2gyVFBScUE0?=
 =?utf-8?B?b1FqMGU1N0s3L3BnRFUyUGFrVUdtWE55NlJ0QkFjWXNSaU85czRJNjJPeGg5?=
 =?utf-8?B?aWdXVlVBTldYN2dkQjlRVWNYa3F0ZzFscGxaNW5naTN5MGlhOWpBQWcwWHUy?=
 =?utf-8?B?a0lJNFcvV3lvb1VFdEcwSXZnWWtvT0lydFBSUzltNTJUZzN5N0FaSlBTTkdI?=
 =?utf-8?B?b3Z3eHJGazQ2bTBYUTVzb1QzL2cwck1WaGdJbTU0cDMzRlppNWNPTHQ2VFZl?=
 =?utf-8?B?dXBjd3orY2Zueit2OWhlRjQ3N0svbzczQ2o1L2s0cTh3Z25TNEhucWpuY3Vo?=
 =?utf-8?B?cDdBTTFtWVFRaUNNcUREdmFJQ2FxWWdFVkk1YVQ5MWxKQ1FFZnJvVkEwSTJB?=
 =?utf-8?B?NGkwbnVJOWR6cURkSFhCdjZ4WDBvU25Xa0YyN1YyOVo1T3ViSWxrVUszeEQx?=
 =?utf-8?B?U2YzRHBERjdnRVh5SDFZRDd5dmlSZnk3c0FYanZPUXVseWVxclkrQlJ3TVVp?=
 =?utf-8?B?U2RmQlR2eVRMM3dWWkxqQUlucW5hbXN0eTllSkd3NnR6TVJ0Q3Vrc3I5SURI?=
 =?utf-8?B?UzZhR1VweW9xRUtyd3pMUUd5L2I3RW9XYTdRR2FzdFRLbi9rclc5ckRZVjht?=
 =?utf-8?B?b3pYTU5IcXBFTmpoYnBiZkE5L09PYmh1VUN3Unhud0FEcXRiY2xEcGRmNm1O?=
 =?utf-8?B?Ty96bVA2dUpZMkhxNG01alFDRFdZb3ozSUVPb2c4bStoN3hUb2NyS1lOL3U0?=
 =?utf-8?B?aWtxYTBrazhYM2pHbjNheXJJWjU3cDl5Y0U0anp4eklmeWNZR2VpSkJlSUNM?=
 =?utf-8?B?U0I1WWdCZ1BTdWxJSWxnWWxBei9LSGVLR09NNU1mQTBZZkRET3p3aGNZMDIx?=
 =?utf-8?B?Nk4rRUdsdlZsN09FSmtlbG45VjBQd1UwUWhtQ2xqeDJmZUpodEtFRVBmTG5t?=
 =?utf-8?B?alovSmYxdFdldDZxUUFqZFVKazRRMEtnNjcwM3RwYUlZVG9KWEdVMlFja3cv?=
 =?utf-8?B?NXZMWmQrZTFIb1VBVHBBT25ibVA2ditCTUlzL3R5UzU4eisrTWJHdEx0TEZY?=
 =?utf-8?B?dHdRYTJTcU5QYkNLWDFLb2lud1d0VWVRNDVxdnlNMXd2aE11Y2hycFdJSmFN?=
 =?utf-8?B?TndmTk5Ec0l4SUlIVDZleHk2Y0hrMGMrVnVzRUo2OWM4bGdlcm5IUUd4T2pk?=
 =?utf-8?B?cVBLV0dpUElYTGQ4dmpnczZaMmppSlBJcmVoVkppOVNMbFl0azBlZ2ZJZ014?=
 =?utf-8?B?RzFGTHRML0Jnaml2bHMyaFgySkJRM2tQcnA4bkM4S1NTRjZQSzA0WXlqVG9w?=
 =?utf-8?B?SEhCVmlzR291RWhaRGliV1RJcXB3aTk2YzJ3SVVVTm92Y1VmWlUyREpJLzg0?=
 =?utf-8?B?OHdtS1VDWWVLdUIxZlhsRlNDUnhXcDgwdGVYOWVHWWZqUGwxczNRL0JlcUZZ?=
 =?utf-8?B?V2xPK2k3Vld4RjFLaFZlZlJQWjlVNTRvMCtFUEIxODV0ZjBWMTVHdTZ6bzlE?=
 =?utf-8?B?UDkrNzdlL2pLQjkvWld1YWZSUG5SdXNrL3ZwNFlZZ05KeVN2MzE0SnlMTmk3?=
 =?utf-8?B?U2dhVWN6MXpXUWR3V1grT0lBT0ZQdU5VZFBQMUEvcXQ1b2hSdUtCUW5Qa09Q?=
 =?utf-8?B?THlPbGpJZC81QURYZlBPV3o3V3A4YkN1SnhDVWs3cG9CRlZhS3lRa21TWkdI?=
 =?utf-8?B?b3dkd3djb0lhZ0VnblVNQVBIZ3dmQkEzOXpwUlpQQVQ5WkgveHJycEx2VGlF?=
 =?utf-8?B?WEw2NlE1dG84TDBNV0duL0NyL0ttYm9xWWFFVnEyZUtQakt6ZEFDT29uQTNm?=
 =?utf-8?B?NGJnL2tzSjJ1UGpFYk4wYzVTL0dxM0pWZERtVld3WitaY0VjMlFBQ2YxZDBT?=
 =?utf-8?B?dmlhU3dVLytuV3diZjhrZTdDTi9ocGRjME10R2NadDRGaEFnL0pZdXNhSWxD?=
 =?utf-8?B?UTRZS2pPRkVGTkREeVYzQmZYVlpZVlcrSVB2WVJaOThXTnZsTzJ3cHpuNVlr?=
 =?utf-8?B?WlRlNHpIVEE0VXBWY1RxNzYwZUJ5Vi9uSUJJT0ZPN1BHbzFiOWs0S0R3YmZF?=
 =?utf-8?B?RVNrajVBUmowVTM3LzJsVnkxaTVyVFRLVTNNWUtMdWV0MG4wRitMTGJmSWt5?=
 =?utf-8?B?SE90VUNiQk9HYUlLSm13cUxVb2UyU2g0ZjBGaHBWYnZjTEl3S1NlVXQyYnVu?=
 =?utf-8?Q?IuGocoKU5KHil3OKNF72+7j53TVd9Dihpww4NaJnnz00?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b306b5-936d-44a5-c53b-08da6f79392d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 02:39:27.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5z1GPx7ZbRnJRLsz94KtwL2c+eSypD5HwzLiFpQAFwOqFfZQi+T4V0c9UCh4mO3978lcl2i7v1mblC/eVnFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/22 10:32 PM, Jerry Snitselaar wrote:
> On Tue, Jul 26, 2022 at 08:43:48AM -0500, Suravee Suthikulpanit wrote:
>> In order to support AVIC on SNP-enabled system, The IOMMU driver needs to
>> check EFR2[SNPAVICSup] and enables the support by setting SNPAVICEn bit
>> in the IOMMU control register (MMIO offset 18h).
>>
>> For detail, please see section "SEV-SNP Guest Virtual APIC Support" of the
>> AMD I/O Virtualization Technology (IOMMU) Specification.
>> (https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2FTechDocs%2F48882_IOMMU.pdf&amp;data=05%7C01%7Csuravee.suthikulpanit%40amd.com%7C844cc78ad4674484b1f208da6f1c0ee1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637944463702725122%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=U%2Fe%2FxqqQ14UmlF5ThaB55Col4mbNzuqNj8IqEyxmsxo%3D&amp;reserved=0)
>>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> Is this a typo in the 3.06 spec for SNPAVIC_EN?
> 
> "001b-111b = Reserved."
> 
> Or I guess maybe there is a newer revision that isn't available yet
> that describes 001b?

That's correct. The newer version should be coming out soon.

> Reviewed-by: Jerry Snitselaar<jsnitsel@redhat.com>

Thank you,
Suravee
