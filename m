Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7C059E7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiHWQr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbiHWQqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:46:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2931A6AE5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw7YRDCKjBiDmJOIlg4XS5nyE8lKJqlPgORjVWjwpj0ch5Hsh4xSQRf8wy5G+vYeOM7S9RndfrN4iXtXzk/tbJxQ2aDlFR5m/s2NwpjJA9PagcckZ48gWcxI5I9zvG2/UeiLYJaE+VZL7CscxU2wZ7FwLk+Ph4lcgUvYLgSmJ5D2QbwZkUlDxW34ATccGoCdJ33CD7JzvSIHOIBKioqL0GIth0rL/uWYndK4SwBRTFg7GUW1YS1zf2wLs5+0BsNOy+aJSn6QwfhT/svqBAlQ+35QxALr1MRo6YaEfgmW8BDE5bliUp2IkL3B4PLItQqIUrWe06r+VUcpypv9gL8t/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQ2nDgObULu6ZYbY4RWyJhlTL08jmeM6UDLU4VszwAg=;
 b=UbocOhmdcWMynpGRJjdHoIV+jOCn3k0OO+KCNBWKZfP95rI4r6T81DS6L893xG9BbSzfKho+NIA7a2g5zPemhACDn37usQxipkfCFVMpHeHrTRjt4h1kSVqo8bt++Fua+k/8o8nkPU3aigjn+mZqMKQUT/qGaR/PBuzhk1wgzGwBh2LBey93DjpjD/laD5JTE1+j5RLJ3DRz6eEit0ippG9IHFvLcCmkCqjIncpCv+DrgEE75Wd0uYyDg39eWBpFs5rE/bEoONTsd5IUkuZqJtBJ2q8Vuk0eJJ42N3cip61lWmHJusDz93xByMnP3GRB+Eprtqo3j9AtHhsDU3a8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQ2nDgObULu6ZYbY4RWyJhlTL08jmeM6UDLU4VszwAg=;
 b=LyvBZB7+Z9om2bKVWLx3hTnRBvX3hHuMX2mJEtQlE39q6l/L/kt+PYPLD4zKDh719i+GxP/mvgn80XCRxI3zeBjdDQgeIllNirOFf1pEHA+R92FmjBB3YiVkPCXThuSXnuXkFrudVQA9IYVyX0oHemow/4KZ1Xfbh2KVPhUiqCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 14:28:05 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::1dac:1301:78a3:c0d0%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 14:28:05 +0000
Message-ID: <b277f0e9-f2ba-011d-3078-fa4a1222435d@amd.com>
Date:   Tue, 23 Aug 2022 09:28:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/2] x86/sev: Add SNP-specific unaccepted memory
 support
Content-Language: en-US
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <44495aa8acb666b447a08a1c3af80987aa3cea3a.1659103274.git.thomas.lendacky@amd.com>
 <CAAH4kHakyK06eqQhaagdMmvPq6vsWK51k-f4UgUZWzexZOuBLg@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAAH4kHakyK06eqQhaagdMmvPq6vsWK51k-f4UgUZWzexZOuBLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ce4d2fe-6b06-49dd-1ead-08da8513b144
X-MS-TrafficTypeDiagnostic: LV2PR12MB5917:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu2r2n9oY/e85HQz6533WHl1G+eQOpJfw+QFK1+iJFwb93FDmm5XxgtfZ8GUwgyDLSWBpe9cG4qOKTvJ+gpmLZz81qqqt2kFDdVXWnUjLwr8o0t9cE7XGex8RKB9b9YNT6tNSD9j+no/N2WtE7WE63KRry0pqGj4EtAJduJqBOlQll8wyBtOaAemqeVVP0BTw985YjIs2SihISPpysPnVg5L3PjfzP/h7ly2FZ4zb3MsfCokLIMvuOPYFCjI7T9u3D+GmslgJIkIjLmFX/rUUmzXHeWcv9IzHK09IW2x0nbeEzqzs5fqvK8T+cPYvoyBiwwZLoMMhMXS+Jhvs5nIHh0Us9mdVb92JRvyCYufZGWy8TUpoXoU4wB4Tvs0HSEmE/m6RrthaBPYb3ti8hGIOzD0N/jO9RVdOVUJ0edSLx7b9FPu7MexGJj3jtYTS2n62iT1bGunTCnfAIdvSwblJ+n/Mc+/rTEOk2NfT1KgoE5IhsXEE1a8PHfMx1zw5sDioOkK/ftHNwc2xbnc2qy/AqKLazG751yJr08FROvsNcvIQKJ1KOYJx1omg94eA7akEMIcQ+P4voVfWXLUsN9ArH6dqddct0A2eq4okcv30CnuvQY8hVFE5dip56nuJTcplKYnG3Im6Obmiz8LyopBtp41GfoNKhN6/izi6UxpeX2bcFBLQ32AkobvGEzdTWjB6s2PzpyzKhXPKXYaP9vv/jVcz5RkoM+vyNYuX47THzmevyPMSI83vvJBvgV3oRKpDZ8sdTBKQpOSkqjtD70clhyFEbDh8Bmf4zae/CziGYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(26005)(53546011)(6512007)(6506007)(6666004)(38100700002)(41300700001)(86362001)(66556008)(66476007)(8676002)(8936002)(7416002)(5660300002)(31686004)(66946007)(4326008)(31696002)(36756003)(2906002)(6916009)(54906003)(478600001)(6486002)(186003)(83380400001)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVpjR3NldGRqR0p6dVJwZk04R0dHRSt0aXhFNkFpQUo3WGxtclA4LzEzajRo?=
 =?utf-8?B?Yy9DM2lhWUpRd0lKNjFKMFFtcmVwWDFRNEd5WVUxOW4xM24yeDVBWGhzOTRV?=
 =?utf-8?B?bnZjMCs2UmNXUm9qOWdETVNlYnh6VEIyS09FMnZ0WHhMYkloVGVwTG5WZXJS?=
 =?utf-8?B?bkl0WGRMWW1GeFgvbzNIb2I5QXF6N0FFVERSRGVEanpmQzMrbThRY0xXcklJ?=
 =?utf-8?B?SytVVmxmYm9YTVFzUXhoRFM2SnYxR0EvNnI2TFV2TFpEZHdoQnlFeENPOUNO?=
 =?utf-8?B?YUpZWU9kWTA0RmZnM2VobnlES3gwaE0yYW1ITHo5cVdiMGpaZk1lRXlqS255?=
 =?utf-8?B?SGM1cXVQZjFMMWVwVEtTYk54R1VROUhPaE9qMTlKRU5NbCt5YnFNdTRtVm9D?=
 =?utf-8?B?ZlNzRmVSUVdBM3VkeUxYTGNCdEhrVU9NaUtwMGxmdkVaaWVhQ3pRTXc1SW80?=
 =?utf-8?B?Ung3bGcvaTllcC8xUnlZQ1llWmJUREExdGtlT0R3anNZSGxQNTk2VnJMempL?=
 =?utf-8?B?Z3NLSTljZ25ZU1NsdTgwN3NKbVB6cGYxMXllOEZYd1k1ckJRbm55MHM0NmlV?=
 =?utf-8?B?VUUwQ3pwdFlRYi95WDRFbisralRvOWFpdnJ4bFo4RTN0OTJ5Z1NOK1VBbXhi?=
 =?utf-8?B?c3ArbnpaZFh2bDBxMTFJVWs2eHhXL0l3ZTZzTGVzVjc0RDR1Vi9tb1hFWFIr?=
 =?utf-8?B?K2N1U3NFVGIyTWZpL2xrbll4dUpwRkFBWXE3V0kwS0dtTFd3V3U0SlRnYzhS?=
 =?utf-8?B?VFBZNDluVWRBd1Q5YXlOYU53WWFhUE15MkdXeUVCVEtCR2dIcUViTTM5aXlE?=
 =?utf-8?B?SUhQeUo0Y1VNcE9Ra1JPRE1WUlRZSzdvYUE0QTV5c1VYdFNvNUVkTGtVM0FM?=
 =?utf-8?B?VVRMaXFyOTBZcUlZSFdOcGlPR3NBR2JFUWh5M0FzMUgwUkZCdzdjRXFmbXMw?=
 =?utf-8?B?Q1RYQlR2MnpxdTc5OFVNMmxaeHZ2MjNnTWREZHEzUlJ5L0FKdEk5a2hoRU5E?=
 =?utf-8?B?QWhOekkrVHVVV082a2VZOEJyUmxhVU02amQzcEJiZWRUTVJxMHR3WHlxR1pi?=
 =?utf-8?B?SE5IYmluWGhsUUJZZ3hPNFdWQUMwNzJLN3JzTCtNeUM1eDlpelRmS3NaV2V0?=
 =?utf-8?B?U084disvZ0lsM01iUlZPTVRyeGUwc1REWFhLT253YkN6RlFwd2hIaXljR1ph?=
 =?utf-8?B?R1R3aUVMTU8vUlorRm1iT2pUQlFvMDNrQUVONSs5Uy9NZ2Z3K2p1b2hvTHBi?=
 =?utf-8?B?TW92UUFmRVFJWEFKa3ErTWcxUTl4VVl1ZGdBcHhnY05tUmQ1d0VwS2U4T1pp?=
 =?utf-8?B?RWJLLzBVc3pKUkFRN3VoYmtGNE5XcVp3UU4vZE9USmRZL1p5QnkvN29JTVpW?=
 =?utf-8?B?TFA4U2NaNzJEZkV0Z3FVTjRGdTlSRE42d2swR0F3eVhjSHlkdHhPdkFNaXJi?=
 =?utf-8?B?VkhXaGRVcHNGaWFkVG9tb3JrcUJualJxckhQNitCY3QwRGlnN0JVWjhEajVY?=
 =?utf-8?B?NW1FVEdsdXI5ZkE2Y1U1ZXRjUlFnNGk3UnN0bmtHTGIvM2NZMGh1VVJ2OEF3?=
 =?utf-8?B?SjRLQUdJMGxlTWlaeTROWGMrQkRTeUpSR2ZDeFE0UktQZUFvMGplNlJQbUN3?=
 =?utf-8?B?Rm8ydVk2dkNWa0srSndPY0RNUmRtT2IxZDBJOXd5Y0xKSGFQMjJ6WnU5Unlq?=
 =?utf-8?B?bHFyb01YWSsxekIvcWY0WStRYVMyQXdTU25OMi9xckdMU1hrRnVRejlMZmZT?=
 =?utf-8?B?VzZpalcvNzZsbGp4OVBjM1pJT1loM0RabGlNMUtNY3NrSHo1M0RqUGRRWHIv?=
 =?utf-8?B?dXRPTm45N0N1bDBNUWdnL1JMdk9qTGVCM0lkL2lXcitFS1JqYXU3Q1VicENr?=
 =?utf-8?B?RG9ON25UZGxybi9FdmxJdkxZS25MRGo1U1ZWS3pyWStvaG9ZWHVCZWNuQ2Jn?=
 =?utf-8?B?eXJFSXc2TFdRRE1XTTR3OU14ZEZUSXE2VWRna3dER081aHlrK0FQQ1lGSDZU?=
 =?utf-8?B?bFFHTEVrVklWbmE4Qmtxa1NKWDNuRVpVWjZTUnRNOUFPRGxtaXBSUDl5SjZL?=
 =?utf-8?B?VVdyaVNBZVpVeCt4OEFrQkVucFRVMHVzRzZoejRBN1g2VlJWRWxleEx2bDJP?=
 =?utf-8?Q?MPYru+1o6UhitTbMPrV6cJkgJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ce4d2fe-6b06-49dd-1ead-08da8513b144
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 14:28:05.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DBEAV7nR6VcXh5Dx6yST9rczBuilH5saEMzo03J8vxLSQE1nRs76nzLKFhflnPcxlj+mOESWvTKcVCY3wtonQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/22 19:24, Dionna Amalie Glaze wrote:
>>
>> +void snp_accept_memory(phys_addr_t start, phys_addr_t end)
>> +{
>> +       unsigned long vaddr;
>> +       unsigned int npages;
>> +
>> +       if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> +               return;
>> +
>> +       vaddr = (unsigned long)__va(start);
>> +       npages = (end - start) >> PAGE_SHIFT;
>> +
>> +       set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
>> +
>> +       pvalidate_pages(vaddr, npages, true);
>> +}
> 
> My testing of this patch shows that a significant amount of time is
> spent using the MSR protocol to change page state, in such a
> significant fashion that it's slower than eagerly accepting all
> memory. The difference gets worse as the RAM size goes up, so I think
> there's some phase problem with the GHCB protocol not getting used
> early enough?

Thank you for testing. Let me see what I can find. I might have to rework 
Brijesh's original patches more to make use of the early boot GHCB in 
order to cut down on the number of MSR protocol requests.

Thanks,
Tom

> 
