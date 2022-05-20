Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A347852EDE8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350180AbiETOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiETOOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:14:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2997816688E
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXacxnw2sgANcZCe7L1Yinz9ZVUap9okC1/x6YpDYSwgT6EnWFRFK3oWfau3rUAPQ5o+xSVxPC0F9GrAnC8DerhNLBApvEvKTciy3fVEOtGM8xVgZDIU55+a0UiJa5SrL7S8vxQBhdYwSXVLA6+VjVFry3l+rs4n/ygbO1fXhYz6scTyPkl81Kjf/tspRdFIVj3xs8SirfET5gT40Aid14oLUdPYYNUnPvWGzvX3l9a7WItCYmTBTv2q7mQfxFzLnvPa5hn0s6/v7wJJOSao3gUFn7N/b2p3cGnVxN0Vq2oFF/VKislzquAedM0VNvlSIhtBpO2uonEDbED6qhcfFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waLwIczm8dgLokSXDRX/TSbPWx0fTvYMy3TXmJlGNj4=;
 b=kjz4D20Uwr/K0DONB3HNGh9AwelSGWF7Qn7yOB3koxuXxtSkuZ538EcdNfdetkjglGJBQbvVWDzw/5Hti43Wz4WiSn40HdCuhbT0dYpXpcmXOql+Z6bAQ6wm/IxEuS8MLUxt2G2GEuvgPzevKjjBI3TbPME3ef/xu9NbtljelVIKuCbCM2WfbZAYz0SKqVOWIr98LSsadq+FuNvby0DS6Ogyj0su+nOCZf9HNiOUNBfpOKB0cx80Tnt5BOCShlo7sPs4uDZY8Sae/k9SgXvkHg07OoyOtvUmDEjBckvglv8i/Cdk5qAGe0TZKz7gZyTla7HhVBRSrBrjvshForIQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waLwIczm8dgLokSXDRX/TSbPWx0fTvYMy3TXmJlGNj4=;
 b=cFHZpu8kYJZCS6g3hKzK95mrBg5z7xOhcjDBuRWBqWAc0manrzTY+eQ7RwZTaIyJ7OTkBJqmzVve/lIsRC6mzm75WLPNVU7s5Pqa1CzPRwl0Dse0GegdQZv8Fpwy4rF1fy4u5TFWEEMPLFv15xOZUmtZR2tjupJYOVOy0vPYRR6swK6SvbfwUJYM5ZlW36brVO7qzFV4xlqTCZm9R9iF8aGJxB0MxNfMNFHGO+AWC8dnrGqoaBbO1JyeDEFcbY3Y+rFtF+/hAv6CKebfDNUllSyv3bl8Ua5uf6tJJxJYV8/vPDjdg3N09/O+2Zkxyz7EWj3RV+gvf5UuRjex6iUojA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Fri, 20 May 2022 14:13:53 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::b406:bcb6:14d:c14a%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 14:13:53 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 0/6] Use pageblock_order for cma and alloc_contig_range alignment.
Date:   Fri, 20 May 2022 10:13:51 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <A03D6267-5945-4A6A-9C55-5F3DDDB35CC2@nvidia.com>
In-Reply-To: <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
References: <B621B4DD-5D11-4F0E-AFF5-F8684AE37E57@nvidia.com>
 <20220426210801.GA1038@qian>
 <2B9844C8-6D35-41E2-ACB2-9854E7A9C29F@nvidia.com> <20220427132720.GC71@qian>
 <1D88AE1B-4DFC-400F-A054-662E3824C9AF@nvidia.com>
 <A1956578-A851-4BF3-BD57-12571244DB5E@nvidia.com> <20220428123308.GA71@qian>
 <0E75B247-8150-48A3-83AE-56C586030006@nvidia.com> <YoavU/+NfQIzQiDF@qian>
 <F6598450-EFE0-4EA9-912B-A727DE1F8185@nvidia.com> <Yod71OhUa3VWWPCG@qian>
 <48D48FDC-B8DD-41C9-B56A-EBD7314883AB@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E9B200D4-D38B-4242-9755-44DEAFE6A4D5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:208:32e::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c775761f-2ffa-4b27-034f-08da3a6af872
X-MS-TrafficTypeDiagnostic: DM4PR12MB5771:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5771C9C6EFDFF65815BDD913C2D39@DM4PR12MB5771.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfGM6pby5wxVygTeUDh+KgFFcFQmfioNEmZ/67G6K43+kEYg3pvzwkDLKql4++0xiJABN5QURlJJytO7JISDQ86ZweHNzdGmd4N7PeWuCHyp2OFfpWz4IqTjpD/xaa5fykfd7sAS1Vn9SWrpQ7c7WKA2oyd6A2P/d6n2B+09m+7fUVF6ynHygTXB0AX1moyj1UmPOfz/sm5d0KVKOuiYzcr1tIO/aEON9oB2CJNc7fa8qQak0r8fdp13/x7mJfRrM37aMNIanQmRs5XQFp/Iq4xYTnU9dKPB52KvPObwdYO0//6sv0gH2+MGVKYmCrChGMWt9PRrBO9c5vBFYRdHOz/JFbb2y0OsDPW+wA3pC6wNsb3VlweeYFjuRrOwQDRemS7zoA9ftTTAsLR2i0FLDNOuW2/dfM6tyd8Wfp45Um+Bx4f39x5D9mt9+/ZXI3p4LMmxB17Q0tVkGC3ox1mZ2bMvoxM52ovUefgmMsIuTvmJwj1di967slF9jIuY+gKNKjTYnPK9xA+y0QB5ujjMMgEfD2t1b9SULByOc4RWNtIK4hWJ0Xh0FetVfsgYBGzeef7KwdXP7fA8rcxTm1to78ylHnVB+UTxcutpLtsIzHvE56Cb9f6obdMoe9olcvMZmpon5nFVXW4eyndqUSVPM5OnMnK1ytYji0lXh4lEDT4P9IYzwu0520HlhSjMTwM8ES4GYbqNOqHP5SK7Wnv7oUViLBrNQH50djbQc04SaqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(8936002)(54906003)(6916009)(2616005)(6512007)(316002)(26005)(36756003)(33656002)(186003)(86362001)(4326008)(66476007)(83380400001)(21480400003)(8676002)(66556008)(53546011)(7416002)(6506007)(235185007)(5660300002)(66946007)(2906002)(6486002)(38100700002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqaAtTdQEHFVLdAZ2jyxdvK+T8WxNLr7ljE+tL2jjg/8kI4vZBAnC0t+GO1u?=
 =?us-ascii?Q?dgw9m+qlNaCvnn1Q677NbGZtpuprNqriBM6bB4U8rGpDIrc+Eb3UIoxQzw+B?=
 =?us-ascii?Q?C1D5gjLhKo5onWa2l2E1hDTFd4IKswtywStHg8QB9OgBEnCnVz2S+ya0sKCN?=
 =?us-ascii?Q?7auKf201WvmQKegqYfR/W8+3VvtjxjB7gvBWfIu0LNwNpsPO2vzMgd2qwfRp?=
 =?us-ascii?Q?9GQgqZcudxRAcRC4Y1GqM6JJHKci+cVKij2mUB6fJfhJbjsTYZ3ww/zauNGJ?=
 =?us-ascii?Q?Tc8ox9TN136xG9AUIiItpcfNuxUaor9yZnRViUsB5QygqvXxPCE3AFEVzef+?=
 =?us-ascii?Q?cx00JhEF+b8eyVj5pLrKVUQiemrtJA9H/k7ujN0OWPMJw5wxvCOeSXqurvat?=
 =?us-ascii?Q?KwIrVqt3MjJOWOPiyL6XLbYIhnnT64K9/lew7ZNhs6NrhH4aU2dnIfC6itvE?=
 =?us-ascii?Q?J90dAqfMh2h0Ketwa1BC9mJeSJ+Pkmw5yWA6mARtANv8wvxcNnfss0kyDKlc?=
 =?us-ascii?Q?0AWROndpoiHGZ7DQTmkfy0uzh90eRG7FbK6D4iSrkX7/v2oyKavvp1zbeBuy?=
 =?us-ascii?Q?mC2v5Ppc6xPSafLwuA4RENnILguwgobOEKE4Ld1wOQLHb3UtL7zgz6WhO4eT?=
 =?us-ascii?Q?U8dp3oSXmc57H35DxpriutHhxBnqETs/v5x6ySm7K+24wzfawoWn+BdGL5oi?=
 =?us-ascii?Q?jaI+S3klIl4LW+ZNV7qwO9KTecid1OoWNIB+moNozwOWpS+c/qnIV5bdNP3U?=
 =?us-ascii?Q?kIMGRX0iO2mHqFMqEz8ldmkoJN69VRVrbVr5T7z7EWP0Z9yb+a/WA77hRmRy?=
 =?us-ascii?Q?uRsCnpRN7TsiivzX3yKGIgeXiixVBVVbVr7jCNE9hGEJrB9w68PPwt5wPIcp?=
 =?us-ascii?Q?6yNRH8GpCx9c+cQmGNoFxS/JYGSv7A+cqnHHY76xOwhBAU1pAG5WHtWbY/Uw?=
 =?us-ascii?Q?Ihgjf7eEUEbVqDfgU04lA1AXSscR6ontTZOpSqMZXhdYPevREkCM+TBBRb+m?=
 =?us-ascii?Q?13EUESopIHeQ6L8VV7f8LzopgGDraTeF8ge0tmy0IF1vX5BaHp9rUHIeTH+r?=
 =?us-ascii?Q?s0RWEVtSm+am1aBFTL0ATkTho72wuk4FC2Kg/x1J715wDe34gbAcp+ZR9SIF?=
 =?us-ascii?Q?pkPqkQFiavJJMUyu5XLViSpjWvNX9HryiqNatMxAP7endg0ZVBJb45tHdDRI?=
 =?us-ascii?Q?TSDea78WLPuoE2J1yf/dCC1/bK+AggOvxftzFjbZl8Whb1l9VUC6V8tMOqxL?=
 =?us-ascii?Q?0d7Ur9C0fWljz5A1XRFP/s58wZ0nsZL3vE7UCY64PS8awGb7FBvXFm3mRwcC?=
 =?us-ascii?Q?rEn+anl7+6yuRwbZDtqyJlxSKbpkyiEC7nRYwG3o/roE1o4hOWNhgoacB/af?=
 =?us-ascii?Q?2m4lJwYT0TNFCg8to2DEGsaK7VaSkzfk0i99VyieRFhHhXxL9Ofe3JaxDNNe?=
 =?us-ascii?Q?alQhw7bASXqKLDADJScBqy/Ls3bb1b1Fsa+PY0RqQb/G4JtA2ADr+8TdHztK?=
 =?us-ascii?Q?ai/ky6T7rS53Cm6H5fSeM7Ky0ZgmkOmgUqts+M6ION5lNglz0oXBndbTzqM0?=
 =?us-ascii?Q?pYUTg9qnazpnhwbL5BwQLj+r3q3Yrp074HKGXacFMnlOOiYA/JYZE/9o3iAp?=
 =?us-ascii?Q?m6cnpo7MUDGLvquN1MB0PciTFTFsDjxUqcv39J59ImPevz1No69WPJJxSnF+?=
 =?us-ascii?Q?K0iFqaP4B2usdq++NRftmw+PYRRxxsuX5izejH4jJ0n5o49qpcnYdl0UvWWw?=
 =?us-ascii?Q?gWTCwkN12A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c775761f-2ffa-4b27-034f-08da3a6af872
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 14:13:53.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mclxzug2ltyke8O1+7vMFqMjr3Nd+/qbaZV0vgoInpI1s5T8w0RRVIBODzXcDZlp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E9B200D4-D38B-4242-9755-44DEAFE6A4D5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 May 2022, at 9:43, Zi Yan wrote:

> On 20 May 2022, at 7:30, Qian Cai wrote:
>
>> On Thu, May 19, 2022 at 05:35:15PM -0400, Zi Yan wrote:
>>> Do you have a complete reproducer? From your printout, it is clear th=
at a 512-page compound
>>> page caused the infinite loop, because the page was not migrated and =
the code kept
>>> retrying. But __alloc_contig_migrate_range() is supposed to return no=
n-zero to tell the
>>> code the page cannot be migrated and the code will goto failed withou=
t retrying. It will be
>>> great you can share what exactly has run after boot, so that I can re=
produce locally to
>>> identify what makes __alloc_contig_migrate_range() return 0 without m=
igrating the page.
>>
>> The reproducer is just to run the same script I shared with you previo=
usly
>> multiple times instead. It is still quite reproducible here as it usua=
lly
>> happens within a hour.
>>
>> $ for i in `seq 1 100`; do ./flip_mem.py; done

Also, do you mind providing the page dump of the 512-page compound page? =
I would like
to know what page caused the issue.

Thanks.

>>
>>> Can you also try the patch below to see if it fixes the infinite loop=
?
>>>
>>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>>> index b3f074d1682e..abde1877bbcb 100644
>>> --- a/mm/page_isolation.c
>>> +++ b/mm/page_isolation.c
>>> @@ -417,10 +417,9 @@ static int isolate_single_pageblock(unsigned lon=
g boundary_pfn, gfp_t gfp_flags,
>>>                                 order =3D 0;
>>>                                 outer_pfn =3D pfn;
>>>                                 while (!PageBuddy(pfn_to_page(outer_p=
fn))) {
>>> -                                       if (++order >=3D MAX_ORDER) {=

>>> -                                               outer_pfn =3D pfn;
>>> -                                               break;
>>> -                                       }
>>> +                                       /* abort if the free page can=
not be found */
>>> +                                       if (++order >=3D MAX_ORDER)
>>> +                                               goto failed;
>>>                                         outer_pfn &=3D ~0UL << order;=

>>>                                 }
>>>                                 pfn =3D outer_pfn;
>>>
>>
>> Can you explain a bit how this patch is the right thing to do here? I =
am a
>> little bit worry about shooting into the dark. Otherwise, I'll be runn=
ing
>> the off-by-one part over the weekend to see if that helps.
>
> The code kept retrying to migrate a 512-page compound page, so it seems=
 to me
> that __alloc_contig_migrate_range() did not migrate the page but return=
ed
> 0 every time, otherwise, if (ret) goto failed; would bail out of the lo=
op
> already. The original code above assumed a free page can always be foun=
d after
> __alloc_contig_migrate_range(), so it will retry if no free page is fou=
nd.
> But that assumption is not true from your infinite loop result, the new=

> code quits retrying when no free page can be found.
>
> I will dig into it deeper to make sure it is the correct fix. I will
> update you when I am done.
>
> Thanks.
>
> --
> Best Regards,
> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_E9B200D4-D38B-4242-9755-44DEAFE6A4D5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKHoh8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUa6MP/RXLujDsTjYIvRi7eyoRvAoKCxi3EiJj0+bN
+hc4gqBVSUvy9/r8rCrZ0t7TAvY7O5+YVV8Pq9zmRkEbyEYUWjuTtGddmu45iw6w
+VrILp1VdeWMIu/Rlvj2rDHF0MBmwDB4A0aqkTPCSqcrgcjfTbcceGUa9EDoYyqa
kI+HMrMQojbwRyOuNDZJePUCvHib5+l14MfbD51HVMrBq1XVrff7n1wlKchcFcGE
pl86Q9gf7tXn0IcE7q+7SZuyJCa72etgGjIQq/tDGAN1kCU9gLAqfx3VOqP2CqCC
bQ2sj7I6/sG+5tk5fEOD7SGb1+IMGUi9sIT87f03O3ylrQZ1QkwU423eux0WTX6H
ww176Xq1qoiUjAV8BVBTerWWjzCDn55B7x9DlhZvTDnxlazJJhCo3fGGTgoph4Fz
T+pK0JVa1wbm2F6g1K7hRLVzQqkidSSaDHRTzSlDiijesZFtRXx7aHPmoP3LJsaX
NX7ZomJ6rX3kj5bf3OhoB7k7ngGkWC+1QqIRvLzoh+mDeG2t5XvoBJlY/WF0510z
JZ2su86MQX5PCsav/kni9pw+Lo2KkLdRIC/hp2J0eO0c2Js9pu10TehYlnewNGz+
qmQmGGMhL5/Lk4nmwIJYdl8PLoxH7JCy3gZwlENTIgNUJAeOWE9q5+QstiQC0cmC
I2LXoBRZ
=SAo1
-----END PGP SIGNATURE-----

--=_MailMate_E9B200D4-D38B-4242-9755-44DEAFE6A4D5_=--
