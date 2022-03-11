Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB14D6357
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349145AbiCKOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349133AbiCKOXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:23:21 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FA81C7EBD
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:22:16 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BDTDpo029475;
        Fri, 11 Mar 2022 14:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=byeKvxA6GX3sO0MuOUglsxX745JYya3OyoNB5zjeBOg=;
 b=Sdl7PbPLyRjHZ9/0a8/IMNrLScsgUtltvB22Nn5VNcgZhHlSkyyVauDLTiltX30DxCnb
 TtwqTudB8IVTEXO0fpIipXadDmkCIgPFttgt3TGup3G6nbaJIR3iK1aVju6I5GjYz29p
 M6ODoLhhoKiiNiYDC5U5z/F52N3j4RR37AlFU7NVPfswCpwux/a9pEOHz1GVnPAJA+fo
 C+2vyjd1cm+esW0FMIK/EhFp4onv7iKQDcXwbqGngqClpEekpJqqF7b7yuPE8hZuM2BW
 ZbP/md+I8YGilN+RZILqNgYqqQ0fLU/jPld+Q/VKEXAPXo8MEcFtY3gDmVT1qbrEGBw9 iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2saww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 14:21:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BEBjgp091758;
        Fri, 11 Mar 2022 14:21:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by aserp3030.oracle.com with ESMTP id 3ekwwe4jt6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 14:21:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfxmx8j/7HcjQ46MrZOSvWDN9s9VbkxaCaeg1QG8EKRyCBkKBpf4DWSXMACSnQQ5GpJ6sFKfOJb7clKIPSaRvujUiWrXJC0LtCE3zAWZekYhWgcM7sytANv9uwU5H8Jb/Si5t7Ny6PdwRg/OmYmbZHWPxTkPJnYCA+8E+9OSTK2poeTeZLYCyvCmc1PtcUteu7Lpm3JlC58mbRcnmPTPlj80XTJTUWPYnXWoIy5VORqhYwBjxWA7YribEjUyn3iP42zOLz2rmakPX/3BpuPEmIgHlWCQTONzj+HKsUc1jg82/Z99XKg/ckF8GDaYUf/Tx5fbuIjNY8KJ3ItcUj4yCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byeKvxA6GX3sO0MuOUglsxX745JYya3OyoNB5zjeBOg=;
 b=SAjGAyv+X90JpIZcxvN1Uv0ibiKRx5MKxoy3wFLzpDpGTH6ygyqXN+uhEj6ApaoWj1LYSN5NBrgkii8n6/MK7v8JQLrTFR5H++LmqS3pZ9NeRfrurTf8cT4JR6Wzpn97WlsFQ484gg5zTTGWPZqoVB6eNJrqq9TUkVaeQ2sVndrjN4OfxilszMg78zZIZTAGLNCfiMSOolQySk6a9631JSJdZOH2giPtEQkd87wup+Ux3XNMmdcfEnZs0yToOEuAuiNgdFhKFCo3LliQYVsU9dN5YWNbgKU3Lbhp/oX4pjFAH5uvEOifDGe8VTj3iDobdXwZ8muqIk4+OQNDpwOOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byeKvxA6GX3sO0MuOUglsxX745JYya3OyoNB5zjeBOg=;
 b=FzNNZhxwVW9S1ad7b840wTBCE1jblJkYgwFyrhtkZeiWB8VSrPkllVaJ6Co4I225NdO6MEAEMeQt5zHtbOw0U/n/SsvC7GZuUenQn2bfa7cKIiVY9n2zySKjeqL+UgfNPikyY/BpdmRcgYVTMrukO4/xjuHUDgx2E3IArCidtTc=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by DS7PR10MB5200.namprd10.prod.outlook.com (2603:10b6:5:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 14:21:51 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::1b2:b41c:b2f0:c755%7]) with mapi id 15.20.5061.023; Fri, 11 Mar 2022
 14:21:51 +0000
Message-ID: <eac862a4-e7e4-b042-61eb-b1894610164b@oracle.com>
Date:   Fri, 11 Mar 2022 09:21:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.2
Subject: Re: [PATCH] x86/xen: Fix kerneldoc warning
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jgross@suse.com, sstabellini@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220307062554.8334-1-jiapeng.chong@linux.alibaba.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20220307062554.8334-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::28) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c757014-fd37-4e17-e01c-08da036a7c5f
X-MS-TrafficTypeDiagnostic: DS7PR10MB5200:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB5200F2447265E9E8C5AC10568A0C9@DS7PR10MB5200.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQVLqVcHkfn1WmKG05T+deK87lC6ojNw/uvxmdWtij0TDmmqtFhULllg+/M4sKdgdo5Xi3NzoCJk+EtdQfdph+hlVEhnUCDaf2msqICmabnEqvgiF0elkn27BZFebKH4QOWVLy+qFSo9CHHmH4J86vXBFhxfeKrWKPm2b2xVffV4mX95mDwJfUu4OrIZ1n1t3x/+VROxTRgwy3FJxG8x6E+Wyme2M9qv6t77eWbfeKELMEnUZNB0r8qNcQRpkNd45utPHWYxOHCVhSF5rICNLWY6GHlppgHK48QuYJ9TRI8oP2jalhOrWtLQaFAFKqkBhuEU72d3UMClaYYLXnz7ncsiwYFMnHhyQXGg/Un5JRoJAyeKsm1mxq1gUGbE/VGk24Xsl2xVHbAPsPZvR4jJt3L/3UF4Smd+CNpkT8iWz0o/UPE0p7ZDLUskc2FCljby9NZaSjhoxFgcozsUW4q+AR2DYfGqqnzFWvQbpjSkir+ez+5ezVmFTeWfqd6zrPc0wPkd/vURPHyiHnNjMmsNt5J5hZV7Duy3/DBmHppwzFRtq6E7ZxvocLfMbEuz37lNUENKN08I3sx4Oi4CEw2sp0YsexGkFCyfQ2hjp1fQsrWepFWbGs2hsSRtMOb2gZxQuzjKnIJSDYtGg2RGE0kIjypj46jhKDuvKSh411vK1lbFaj2Pge8/vJ/KK4smhbfFfdASx9LgA2ahDOiQokHahinKkATGJe2Btj07oIBSKbnOs6MAbW4VTdWpTFV2yM44
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(83380400001)(316002)(2906002)(4326008)(8676002)(6486002)(66556008)(7416002)(6666004)(5660300002)(31696002)(66946007)(8936002)(53546011)(86362001)(44832011)(66476007)(4744005)(508600001)(2616005)(36756003)(186003)(26005)(38100700002)(31686004)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emdyQTRxSXJkK2lOaVVLY0xQSDh5TEQvK1Rsc3YvU0JQUVVJTG5jMldNRE96?=
 =?utf-8?B?UlRWMEN2bWdIRFYwUUVhaXZEU3hIQ2haOHMrUEFIQ2d2MTRmSjhxb3J0dnYr?=
 =?utf-8?B?M1lEUjZvK0RpTGpTVDhyTWx4eXJLUVJ5QXA3cndLREtyYWErb2xsRytDcTRi?=
 =?utf-8?B?elhTTmhjRkpKVWVRWGhxcWdXZHVSMXh4VjRqWklOcTNsaFJqL0F6WEFVVHZD?=
 =?utf-8?B?amxMM0MyV1dHUFN5WkhjZmFodEkreTZUNG5Ub0ZSVEdXK05wVDljZGdWcUhB?=
 =?utf-8?B?UHVYamlRdDRLYkxTNHF0NHZaRUovb25uUzJleS9jRTdOeGIzRThaSTNLdFBm?=
 =?utf-8?B?UFNuNm1odkxzelJIcGt3OGwxQUEvTU9FVDg5WDgwY3NmZ1hLMFFxalNYaDRL?=
 =?utf-8?B?dWJ3a2lQVU1NUm5DNjJCYzBCU3VBbW4rdGhMVWdTSkxhM1g5MC9CV2ViOGlZ?=
 =?utf-8?B?bWJ2MkNyWXdobnFIUnBIMExtS0lDU2lFa3JkaHNsd0ZjWmNLZ2ZhZ3c2Mnpq?=
 =?utf-8?B?Wlo2SU1qMHRsLzJudUxDZ2NIMStZeVk5NnI0elBJUy91dmlpT0hhbFZCZXBC?=
 =?utf-8?B?c0pxZGpIYS9LcjZBMk5xOTdzR0Y5V1pJVEFlVmNqVEp0eVR5aUNmcW9nUUZw?=
 =?utf-8?B?eHYzRWMzRmUwUnZsS05KQm85TTZVUmpLYzVzYzJ1WEMwNWZEOTZlaytXSXcw?=
 =?utf-8?B?YjJlOENYODI3WGI3L2k2T25ENVRLaUQxaFZlbFVIRWJZQnEyUGJpVXZEU2Vw?=
 =?utf-8?B?NkpVeTJsTjlROHZTaXdzYUR6cXQ5anhwN1NKWWtUdUs1V205SXA1V1BEMFAr?=
 =?utf-8?B?OFcyYm5GQjRnZlNabEh6SlBkNncvYmRaRkh5M0tEbFUzTkRLNWNxTG04WjJt?=
 =?utf-8?B?RGt2d3huZ2psejUrb1pSL1dlWnNsWE0ySDYvNWdodmhnUmZ4NnJZc20xYXBh?=
 =?utf-8?B?bmtyU3pta21NWnh0Zm0vT0x4SDIvUGoraFcvek4zRW4zL3RnNlBtd2xGcWU1?=
 =?utf-8?B?VStUZXlDbXdoVWwrNWllc2VXcXkrMG4va0ZmMzloem1zZHNFZVBtL2lPdzRC?=
 =?utf-8?B?NHNyWGxoYVMwKyt1MWZXMmg4eEp0Rk5jZGMwQnMySGFoaHpndHZKaUZERGpq?=
 =?utf-8?B?MXdmMU9Va29hSUt4aFpqMGM5M3MxcHZqZGk0MmNFMnlXWVdKZHN6eWFQeEo5?=
 =?utf-8?B?OVRhWVU3cnVXTGtxaTZKRTN1OCtXWERjVjNCVWdFMTg4MkE4L05nMUdiVEVp?=
 =?utf-8?B?M2o4OWlhejRySUM2YU40RUNLQkVCM2NjVFpsYXR1b3dRRDJ2WmQxWHlJNnZY?=
 =?utf-8?B?bWwzRzdLNlZ2TkQ1dXltcG9KUGM1RWNYVHRVLzloMXNTUXdxbnN2eUxPaUJT?=
 =?utf-8?B?dG50OFNDUlVoVWRwN0hRT3ZnemNPT1kzYmorbDFZL2VGNVk1Q3ZEeGU4UHZt?=
 =?utf-8?B?d1lOZFowMWxXbFdSc2VaaHZTVjJLaGVzbFdTdStVNjhQRzZkbFR2OW9BbE55?=
 =?utf-8?B?UDB3NFR6aDJaOXE0VVZQMVpLYS9DbGlBcGVNVGpzU2kybE1ZUmIvZnJnQ1li?=
 =?utf-8?B?S1ZpVExsUkN6bWJlZ1FjYXlud21raXVVZmgyRm83Vkthc0lWc0FDMDZFOG9Z?=
 =?utf-8?B?ZTdXbzVwM2tva29SOHJnVk9aemFKdGxQUnpuVmFObG0wdUxaVEhZNmR6OGdq?=
 =?utf-8?B?WDlPWGZxR2k1bGwxSytBMmtxaFE2UFpEbm5URFpkYlM3NDBBZVpNbTVvdjhX?=
 =?utf-8?B?MFFzWU55YVRnZkZXV0FtUFgrNU9yUkJpWVp5VFBYQVlRbjlKc1NBd3J4anhX?=
 =?utf-8?B?KytjYUNOb3hoTTdaL1RVQjBWalBWL2xQYm81ZkFXSzJ5WFhHMklDeW94VDlG?=
 =?utf-8?B?RERsRkhBSDM5N2ZLclJSV3QzcmxVa2JNUmFFbXJOdVV6N0Rldm8xMldjcVky?=
 =?utf-8?B?UGc2MllLS1VlNllzem5tTXBvN0hjNDgyN1lIZ0gydWU4SVMvamg0QXBqUlJa?=
 =?utf-8?B?eVh1d1lXUXVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c757014-fd37-4e17-e01c-08da036a7c5f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 14:21:51.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wte9l6w2hE7818hzSazcEKjwIj1R3V80xVWLUvBlFb0dzrwFroBcPInVg7wlTnjc338xhxI6Vwwl23LbXHvdFiMeSMBdfr725lmIRxBqNRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10282 signatures=692556
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110070
X-Proofpoint-ORIG-GUID: Q3Wvoga4btLSncV1zrSRZmncOX1sI_ge
X-Proofpoint-GUID: Q3Wvoga4btLSncV1zrSRZmncOX1sI_ge
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/7/22 1:25 AM, Jiapeng Chong wrote:
> Fix the following W=1 kernel warnings:
>
> arch/x86/xen/setup.c:725: warning: expecting prototype for
> machine_specific_memory_setup(). Prototype was for xen_memory_setup()
> instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


Applied to for-linus-5.18

