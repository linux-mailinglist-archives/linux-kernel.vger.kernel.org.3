Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239F2511A56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiD0NqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiD0NqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:46:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEB73A4966;
        Wed, 27 Apr 2022 06:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDqJY1FVhFycBWtFQRUUrNi3Od+tWV3qYqtshB7iu2BQS/urO2drmHedf2qGinQKaIJVj9m0Klt31n90oPw9OJ1BtxYbXUwWJjy7J+U/mYeSGP9Fgu6IZcgeugpVVv6oi12fRh2/u3WB9ZrZwf0/ewN0wppFrYfaEecnFCMJvhr7qYj0P3xgEPdiWyN47ViRVHWbngdNZ3riCEeI5kHiaxISZ+NbKUGwQlOz643jZafBInt6QeIffzzx2Rxg7Cv5/SsV2W+cyedkOqStMzotP167IilYueICO5jHHiNS28lOasufep02DnzQzpzIoE9PPaaVWmYkp59WjmVG5micPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cmaeWbfKu8N+4TJKtjzST8wdk2LlVVKL0Qneq4Yaz0=;
 b=jJJFctcWPHiQhkzgKdfdrJeSI0UUdSv9wDiFfG6kgAHpwesvfV8k/5g9jaZZd0+2ikIpwgsZoEd0L02mfT8l+8hs+VOhOydiJ7TexIOqTdGHPVGsIvAPPD+LnHUiI/PILl96OdnPXww8iW5fJ4zKPZQoM6L4KO1RckEyp2SvwqCozorgmGXL4/tYmRlLs6ktd8xFf2FZzYH1T6sfruSNWTENjJDXf9FtSxSJRq/Y2kEFWxi5IBpJHJXjQOowW+1n2eFmrgc60P6uAeQL1HYaW5LGlJ+cBZbQAKJNfYUdamhMGCGO2GxCcXjWETAalXeWb+ZmFziP7fSAudHDo2AnKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cmaeWbfKu8N+4TJKtjzST8wdk2LlVVKL0Qneq4Yaz0=;
 b=BMKE/iIvuiHEuR8vkJClq72KBpGb9P0sNg4pii8I4i/ieSKkZLmruulZKYzH04geK3StfVS0RD6CA2HRdYks8D/TG57H+gnDeJgLMAje4akaAqxZF6xOQPC1nAuwG8fKJl2/wVd8LZ0MyT0vXzfu1tphzbrckbZ5kml8whv+0Mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 13:43:03 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::781d:15d6:8f63:a4e7%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 13:43:03 +0000
Message-ID: <c273cc27-6ce1-15b9-c466-7008c92f2f26@amd.com>
Date:   Wed, 27 Apr 2022 08:43:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build warnings after merge of the tip tree
Content-Language: en-US
To:     Borislav Petkov <bp@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220427101059.3bf55262@canb.auug.org.au>
 <YmkpdAYBFbGloIX1@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <YmkpdAYBFbGloIX1@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0135.namprd02.prod.outlook.com
 (2603:10b6:208:35::40) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86380aaf-8a30-4895-57da-08da2853d9e0
X-MS-TrafficTypeDiagnostic: MN0PR12MB5764:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5764C975AE75E4FD70694B2BECFA9@MN0PR12MB5764.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3kL3+uLAqo6llX152vhomRS9Y+zs7o09n+zIwr+AzaDlzeYPeFZCmfOmoFBcM6ICZLpNgvFFORoDRb3ED6Ww2rWhsqLKTkb3DKEm/QqPzdhnu6lGPQEhncB9SnJrCOJjsmuIXeVQMBmd3yDkkEYNRs/ErY6T7rOAwu/0l/xnSWP7xTz3yUSaPMObYEkp2+LcrBRtCNIFBtLjj3JQvo+kXevDfMQuXHtyI3vF+94QnvdHmphmjfNtZ7fKosqckWu77cxZ3R36PdPyDeH6GSoL/hmhd/J2J1r306cRTNuFzJolG3g+PJO/b6POCFfhpINHC1gTyw82vE7ypcGE3AKZQwmano9Rvne4R2pV2DzTmTifdW39K54GcbyhTw1bkQI0MXtGk4lyKfAJt5HQKJQLeh0q07x3r6hjOvr1c20V0UTl/yq++HKUNY4AB0sHv9hcW/uLiYtC+Pwc8lzXKuRZxFTA2tciVMjOf4xmxHbFEgqjPFGjxDLNC5lVSVUMtZgT+6Uugq+Kwl74YIHDBOBAmGdA3FAELsTyU2WcXlKN9f5K5ZmXTn1nGb/x2fgnns4v+D6zMe8+Jal3rM8LDEZ3Ny3vZ/r2sZVX21vbvxLacAz9nKtYL66knwrg84sXh5KriFCBDGqUGDuE/PX4CKunv+nyvM4NMVDaSkM8t/EksJelKz+K8E8CEyEkm+fcD1m0VtZV41OOrM9duTRS59QlO1KFr/OgYj5tEvrBBHcQaqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(4744005)(36756003)(83380400001)(6486002)(186003)(8936002)(6512007)(38100700002)(8676002)(66476007)(66556008)(66946007)(110136005)(31686004)(54906003)(4326008)(26005)(508600001)(6506007)(2906002)(2616005)(5660300002)(86362001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkUwWlpueUx5ckw4aFhzSGFsY1gyd3U3aU81Q2RGT2RHM2JQcE04eUVaSkdR?=
 =?utf-8?B?anFqY0Z3dWdNNVA0NDdUTFFwdmVuRElHQll5MTVEYnJiVGNNbWVHemJUMmZU?=
 =?utf-8?B?YXgrN3hwc21nU2FPOFVNam1KMjRQejBNYUMwWktjWXRDcGlOR251MEZlZUdR?=
 =?utf-8?B?MXVXV256bWpoOTFBY09RT2lidzk1UHlLcWZqWUNHbTNhd2RSdFNtaXV4MU9R?=
 =?utf-8?B?SFB6TjdFci9va2ZFM3hNRHN6Q09rQ2taZTMxMzJKRVBnaFhqS0lLRDF5UnhG?=
 =?utf-8?B?QTFJZ09QYnorYlBZNzg3VC90WGFmeE93YVpYSzV4QTFwNUFBZUV5VG5sZUZm?=
 =?utf-8?B?bnUrNURRTkRwWlNpTVp2VmNyendXdnFCMTNtbEhNclhET0wrbWp4NGZSOEFJ?=
 =?utf-8?B?Y2RsMURiNGZoelRQTCtuNFpkV3o0dURNVVJLdUJSZEwxOVlwa0xLTXBKaXln?=
 =?utf-8?B?OTJ3QUhNQ2pXcHBQZFo2MTdVWFdOODNXdVRTVDVMTU92bDloeGF5UHhFUkFw?=
 =?utf-8?B?ZHJVTFRQaVRqS1ZabFd0V0NxeEJoR1phMUtHbzdmVmhXU2V2QUs3Q2dDQlhh?=
 =?utf-8?B?MC9DNFNNT2NyUjFzTE0xOXJ1M09mcWlCNkgyMUp0d0w4aC9GckR6ckZON05P?=
 =?utf-8?B?K1RYQlVSWTdWVW1INDZRWEhZNWRhbkQ1Zlp1QnRSY0NXQ285b3hiL09sL2xI?=
 =?utf-8?B?cjY0cE01bTJnY0t4RFEzZmxWNVM5TUg1T3BJZVdVM3VwRitKbmZvdktPVTVP?=
 =?utf-8?B?c3lLVzdCQzJ0ajloczMrQnQzbWtRRzVvZDdlckNrNVJLUC9VdDV3ZW0wZHpy?=
 =?utf-8?B?TnlwNWczWGF3N3k1TTJEMlBzWWoyVFFtZ1RsTXVjRGhpaDZ2L0x3RXpZOW45?=
 =?utf-8?B?UXJ2dHN3azNudGZuZDdBOTFIUjRaYjFxTDJmU1k0TFVudXhpdjRaZS9VV2l0?=
 =?utf-8?B?aUJ6aE5WK0Vuc0NZSUlmOVB5RVFLWFhSOUFEUi90ZHFWTnZHbXJyalR1L2Qx?=
 =?utf-8?B?aFNsWnE2NXYwenMvQk5YVlJFQzNKOXQ2dkwxTDZGejBsZEU5cnQrNm1tS05V?=
 =?utf-8?B?Yit0UXJWbFpJV0J3S1RLWlV5dXBTUlE3WHE2L1hVWUVnRjhqNXJDczNURmFM?=
 =?utf-8?B?SnorNTFVNnlpejNwRFNIeXRWRXFkZThBMG9INDdiRlJRT0tkaVdaTFlvOFhT?=
 =?utf-8?B?U3VkT0h3T0RDZlJYbWhEdjU5c0ZOZVdjK1RPRWRleG9IaGpwcUJGT1dDVFFY?=
 =?utf-8?B?bGV3KzZlY0lpMUdpcWdHU1RwaVJqamRQSFBZR3dodXNjU2VJSmpzeTM4Tll1?=
 =?utf-8?B?WTVOTUhFTmFNbEdJNjRRWDhsazlvUHp2RnhPdWFQVWlqWXV2ZmtvZ3RRRnds?=
 =?utf-8?B?TXhUNy9yRkIxYm1CTnV4RzRTZGZGUkRhNFQ2MG5EUFI5WFV2Z3BnUkRyNzhZ?=
 =?utf-8?B?emJkUXk4Y0tOMFFjb01DU3RBVzIwV2MrcHZvZnY1KzhTWWkzbCt6WVBMR05j?=
 =?utf-8?B?TTJGTDI2aUpYbXdOQWFVTi8xNWZiOVRwTC9rUXFMMFBQVU1ZekZTRmtLcGRi?=
 =?utf-8?B?SUhTKzdNc1RybGdJUitjSCt5NmlteFlDM1Z2Y0x0b2N3b00zcTQydVQzeGFs?=
 =?utf-8?B?b216L2NKb3BBa2IwWTVOOGszZm1aUlVTZ0pCai84SndJYXYwd1YwT1lPVEFC?=
 =?utf-8?B?Z3VZemd3TGhnem9NWjV3N3lIMGlGWEhOaDNZMG9PSTZYMEdXVVlPT0RkTlgz?=
 =?utf-8?B?VDArczFjY290Wm9DTDJxUVRqQThjRDZoUEdZUTJBQnk4aXRGY0ZVaXI0SE9C?=
 =?utf-8?B?UnNwSTBoOUh5SHdTeEhyVUkwQkhNcDRMUW15WmpjUGlNbEJxUjZBUklIUE9n?=
 =?utf-8?B?OHhqQllFcUhHc2ZnaGtUcDJXMnM0SXQ3ZVdyZU1lNGxtMVkwaWIwc2VLS282?=
 =?utf-8?B?Z3Z0NFdGVko3NURGRUpuLzQxN25UTlcvb2NkOXVyeVZTd1U4cWttRWpzdUMw?=
 =?utf-8?B?WkhiRFZXbCtTQUtiNU95ck9qbzNnL0luR2pMOVdTMVdZdjVkWmFGc0R6cDRW?=
 =?utf-8?B?Y0VySm9TbDE4dWFNTUZ2V0tIV2VTMHZLMzJsQnVnQ3lBbmg5RHIrRHArZ2lI?=
 =?utf-8?B?VWs3dUpFc3VFZlJxWjF0R01pSGlCOU0xWlhiTVo2N1poVWt5YVhOd05uM0NC?=
 =?utf-8?B?VjhaTzNSY2xtZHRWci94Z0NFelRvUnVDU0EvTmx3S2VjdDl6ZjFPdm5DSi9t?=
 =?utf-8?B?amsrckFPT3U2WS9Ocml2Zlk5bm10U0JtTmZ5Y2tvRWtmaGlMcUJ6OS9rekJI?=
 =?utf-8?B?bWdFS2E0NVVLaUpDUEhSM09WcFZ1ZGFtbmFuR28vbWxVSndiZ3BpZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86380aaf-8a30-4895-57da-08da2853d9e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 13:43:03.1145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jocIxnlPfTt/SKiDLt2mxFu2dSf3IH+Cp9Xz4W4d6DtjaUUq1df/H1ZdJlk6YergIpPebQptmbb3M0CJR2PDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 06:31, Borislav Petkov wrote:
> On Wed, Apr 27, 2022 at 10:10:59AM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the tip tree, today's linux-next build (htmldocs) produced
>> these warnings:
>>
>> Documentation/virt/index.rst:7: WARNING: toctree contains reference to nonexisting document 'virt/coco/sev-guest'
>> Documentation/virt/coco/sevguest.rst: WARNING: document isn't included in any toctree
>>
>> Introduced by commit
>>
>>    9617f2f48310 ("virt: sevguest: Rename the sevguest dir and files to sev-guest")
> 
> It looks like Tom forgot to do git mv.
> 
> Fixed now.

Thanks Boris!

Tom

> 
> Thanks!
> 
