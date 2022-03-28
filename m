Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B44E9BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 18:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiC1QLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiC1QK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 12:10:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191F26111
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 09:09:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22SFBP5K011266;
        Mon, 28 Mar 2022 16:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3i+QpIxeGAoM3nHzjWR9WIeOeAbyR9ChSYUJ2eXPEE0=;
 b=spAv9WZUwXiP1wXpEX6Oet56Wt+zrCBVntOIuN4tlnx5ttak8Q+rPJXwm6iT0MqAK6ED
 o8royYdkt4HoYRxdcqF1SBy/MHj/OFctGGCgtZ3Z0MNp2DXjAhjbA1l5rLDTYypucJod
 z/qcOZQAAmzbn1DWeg8hJNbNTYbdopCUjt86KqYq3ogZyqZtFNy4fdaMvTz9m7rjgZD3
 0kQ4toD6+Qk06EW0SapbvHGfKw8Y44kbAZK1GcNxdTd5XejkjvIiXkDSqTX6sbdM0RJL
 JB0G1QcFKhYAgG0O3UjlXtEC5+ZSHgIDso4R99XjDZFNOGwhPevOHE4v0T+5scyGOvXV mA== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctm461-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 16:08:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22SG6sw5127031;
        Mon, 28 Mar 2022 16:08:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3030.oracle.com with ESMTP id 3f1rv8amgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 16:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbVwsVYyCyM2nfMZv0bWLbR748z1Pdly1rW39pa6A8riGoCcGJAVwEhDsDbrPQdSPZbOIcnZO8w+E3ZCP5Qx5wN09h+KZ8iHAX888dxVmQPrGGT+7uOgl6VsfLgV5B3m0axVadyHrL5+FAOTL0oWJaRWBMBfDx0Zn02h8qEYFyjxHcezQarah1b66ILWa/b5za/chzg7Y1T21f9i2UjSBzOo9dIyjlCRhI2WgG2goYZG1H+m5C2sdqmMz/ofS7bLbA1gyMW/awfg7nlG8mVKtGtHEuJOQwa35bcOBvkZmEJy/oFij/eqH2xJ+I1xb4ZO/6xVHT7q6By0Y5AZxVxMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i+QpIxeGAoM3nHzjWR9WIeOeAbyR9ChSYUJ2eXPEE0=;
 b=ksxxF2bNk2veJE61FC1tOmd/S4CrNjtKhUB+6TfMdNlLNDK4a+JsOATn16G2bXtjLPbkGeB0pNMoJsGpHyqq0GjFAPFps+CgjaBlCkW3p7zYgjYjJLBerqknY/6exF6S7QoL3L6MGYFhTBL9e/6zzRX4A1d5B6dOBFy/C10oQuUbUgSGJ8oecKR1CGOhv9O4zKU7IdgR26Yav9EI+B4aw33gowL7mVhkRz7Zg8x8/6xuCbGR78PKt5l28OhH3ZWdAkItZmnsyDtOGXhtqDpLd98J7SDJs89vg9YihnV8S4tGPlrF8U8QzWpTofBN8gElyJjggd+qZURT7Nyn6bUvdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i+QpIxeGAoM3nHzjWR9WIeOeAbyR9ChSYUJ2eXPEE0=;
 b=YPwoe5j+prW8Y1PObDeTDHuAC7AVlN/hyY9CCGxEyf+Bg1RC7GBPvWCIX/c8D9PmE6Y0gUOpxe+S3T+jU+0X21pSCXP1V1fKsIjRml+gyhbiuR1GejdGaumi+7lqC1ha3rtAX42UxbUGdfXVPP/zwN2/1RZEhnPap6iqRGlqRRw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB3197.namprd10.prod.outlook.com (2603:10b6:208:12a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 16:08:28 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 16:08:27 +0000
Message-ID: <6f59af6a-8a70-85ce-b36c-38eb31503c7d@oracle.com>
Date:   Mon, 28 Mar 2022 11:08:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220303162725.49640-1-eric.devolder@oracle.com>
 <20220303162725.49640-5-eric.devolder@oracle.com>
 <20220324133856.GC354864@MiWiFi-R3L-srv>
 <20220324134911.GA354791@MiWiFi-R3L-srv>
 <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
 <20220324143300.GD354864@MiWiFi-R3L-srv>
 <8b68f5b6-f6e0-ca61-56cf-69046edce58d@oracle.com>
In-Reply-To: <8b68f5b6-f6e0-ca61-56cf-69046edce58d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:5:14c::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bebd386-a9df-4017-4a32-08da10d531c4
X-MS-TrafficTypeDiagnostic: MN2PR10MB3197:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB319715A3B0DDE6A55B424C46971D9@MN2PR10MB3197.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKEhc3dIj/+Pq26Qgf1YwATDzPlSRuiSNersBCudGuNqBy5NSa66AoYYtImK/QYX7b0w/56giZVB5zFnXtG+T5Ia8icGFXLityxIb8kCgMNbvtMkTT0+9KPiBDYTW+RLM9h1LplV47AIRju4ruI9YVZqRFACTV1D27/NoQPP0WqRpCRH45k79CEH/ptOAxa8qpiMqQv49NmIbMznM84kbzQAS1ZKpZtpgJCvQa/4DgkILKMwxo158YYf+dxqcGR0j/KWAU4pEuYnA3VZD3gp0eP2SLMmZzfnqWIyvTa3XK4Ts1+kjvkgJetfLvnybpWNRa7F4xGBlYlovPqFelNEzlZ+an7qDIOHqVT2hyo8y/CDXxphctNMNdQUQJN0DvGmecy+1nVokazbE4K2+Mk05paESPh6ch4q8lRlwAG01Syw9/sR+BQF6XE/puMWpX2k/jQFFT+y8aa4x2WmO/hBrP1VOaqBK+Mtaf6SX9UllW8J2vpBoOpjifYwOOA5gADCGgRPW+IWsH9AE6CawAlk8iibEK8jEq5qXiJmbX8PVXO/EloUkaosBN+h4qs+OZpbAqYsVl6Ap3mf/Dzy4Ea/QsDKASS4Qck/vJZiRPkJN5o8tpmQBH49wSMD2gETo1YXz+ECIDaGkgRcETksQswEaxDu3cWtwRTORGYNlgivQ+WTs+7T0JrnK5n8hZUgw8TTQWojuy6pqBgBgnJOXMSPgp3IXJ2MnCDyLhEHqDllzJXI69sAiAZ20hjkGxopsTQlMGkb5Y6KRqzzCcbUVGKSjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8936002)(31686004)(7416002)(6506007)(6666004)(36756003)(53546011)(6512007)(6916009)(4326008)(8676002)(6486002)(2616005)(508600001)(38100700002)(66946007)(66556008)(2906002)(83380400001)(107886003)(5660300002)(186003)(86362001)(66476007)(31696002)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdLcjZ1akVSbkJubmhrTVllS0JIU0pJNWRDWFN4R3ZQaGNhak5qTmdQaDVY?=
 =?utf-8?B?NTVtd25jUWVaRkhNTG9KMnFDUTNERnpaVm14ZzVNTVlCVGx6TlhMc3N6Vmtv?=
 =?utf-8?B?L0lNQjBWejlkK1czbE1oSTFIbVI3MUJ5U3FBZmNGdU9qRTdXbWE4UmltMEtN?=
 =?utf-8?B?VXpHRGNPaUFEMkM4QkFEYmNiNjBXYSs2N0hnZDhJTkQ5RTJ4NjQwa0lKNUIw?=
 =?utf-8?B?REMyQ3hQZ1lQZ2dleEdEZ2k1Nk9rN2grSG1BTzN1NXp5dkpWSWVIVEhZU2dY?=
 =?utf-8?B?MUhGWmVrK0VXSXJaU205NEJ1THFxa2lkRUFMNDhmMlRQQ1B2eVd0TjArZzBH?=
 =?utf-8?B?V1p6dGc4WEFhWXUzRytJTEpiZWdHVFN2ZHZWV3BBZjE5S29zWHVWU1RSR2ZV?=
 =?utf-8?B?RlBCUGZaTHkrTnQ1MFI1UU5iS3ZSd0kyUkZzdnZQM0kzZVZScVlPR1Z4bmUr?=
 =?utf-8?B?ZFlKeURHZWJHMW0yR2dUTXl5dGNkTldCTGpRU01WVnI2SEphcDZtY241dGdi?=
 =?utf-8?B?bmlOOXpmb0lCQS9kR3RUUmFjWk9UcXZTSW1GZ2VBZWZwOHF2MGVaQWt2WlZj?=
 =?utf-8?B?ZzF2Uks5M1hlWkhwa2dlTVNYRVJpU2JYQkxCTW5qVnZQUFE1WjFxd3YzQkd6?=
 =?utf-8?B?UlBnU0IwUlFBRW5CZlNVaGRTb3diT0dkUWpmTzYwd0ZWcEZWaXFXeVJNMlhF?=
 =?utf-8?B?MWpnTENzTnk4elYwK2VjOFJZVXB3VHVQKy9yWkNzV0tOMVR6RDVhUkNyeG1N?=
 =?utf-8?B?NTliZy9mY3hXYk5PR1hSNmNkRXR4QzJoWVNoQTJPQ0R4WW5PU0ZBTHNzSFhC?=
 =?utf-8?B?bWsxN1ozUjlRY1pyQ2hhWTllOENFdXB0QW9MRkZ2MUhVSm8zck1DemlmSW5V?=
 =?utf-8?B?R21Nc2NGSnNJb1pSQ3ZHVFA2clpoT1ZyVmtkK0Njb2hQR3ZNWjB4cG81N2ND?=
 =?utf-8?B?YnpNUGhjbXVFbVRrVUhSYUppN3lhaG5VRU80YmprSFZsRHJKTmM2cVIxRDRp?=
 =?utf-8?B?RFdjcnN2U3NPWHFtSThiYjJ1UldYSCs5eXZNNmw0NGxyWFF3TGIzcG1VTEtG?=
 =?utf-8?B?aFgwSUtDUTNIa0ovMFZmcmJDRkdLMllvaTUwZFVRRDVkclppaVNwblUwSm9V?=
 =?utf-8?B?ck1tYURzMURyTlVQdVZMNXNWNHF6eDUzTExqOEF0dU9vUzFyaGJ5d094ZGoy?=
 =?utf-8?B?dFdjcGNaY1hqUWxwbmlUczJDSUlUOEV6WFh1S3pMeHNFZEl0U1dGdFJ6NzEv?=
 =?utf-8?B?UW5ZQ3pWM0tlbjVFaVkzWUptYTMxRmltWFlRSjJnYlgwVXY5QjRjNDhZZ25k?=
 =?utf-8?B?WE9aa3Z6b2dwUlJkMHRnaTZnM3hhNm1ibFAySnptL2RBUFJZY3FtOTY5L3Bu?=
 =?utf-8?B?cmdaMmg1ZFcxcVZ3N3dRNytrdUsybENUMWNJcFFuc2ZjZTMyblBvTnpIUVpq?=
 =?utf-8?B?MXI0NU1KeDRBSFFCTWd2WjRuNmcrb3VDNzhmK0FST0NuUmdBaWRxMjU5d0Np?=
 =?utf-8?B?dEJEWVhlU0M0NnNtcjNFVFR2V1E5QWhCVFVZTlVndHhTc2YrdmtOQW1TNUFJ?=
 =?utf-8?B?b0ZoS05tb1pIMXpZeWxDOVJIa1ZpWmF0aFFQNCtTZGVGUDhYYjQvK3JVRzJO?=
 =?utf-8?B?RnJBV1d0OVJxMEpZN3h4S3FBNC9OY3MxZGFMbkNJZXBLUXZPeHdwc0xaZlZ3?=
 =?utf-8?B?b1g5c1pHaks4a2EyMlR4RCtuczdzdUtLNXkzOVNtWU1aL3RFTjdsZ1YzUEtk?=
 =?utf-8?B?VzFKVXBqdWdBL2NqSnU4VXhzWmhDTm9nK09NdG5LYlVBMm5TK1JvbzlZY1Jm?=
 =?utf-8?B?bzlWenkzODJMZmVDOTJWYTE1OExSdVcxMlNLbU1LSktzem9xZWtXbERzM0ZL?=
 =?utf-8?B?WnBrTThXQXVGdGNNS3Jxbm5xcEZkSDZkNFN0REFOWElyRVB2cktja29GRW9E?=
 =?utf-8?B?dzFJRVpVam5UUHlaQUpIUWJaTjA0cGVyQVEzNTlzQVkxb2gvSU0zNlgxdElR?=
 =?utf-8?B?cEcxaWh6Y21NVFRMandEVXFpR3BoZ1g2U3YrYnQ4VENTWEJrQzlpek5LRDVt?=
 =?utf-8?B?T2x2VzR5ekptaksxdUVBZFdZczFwekhrVmNLV016bU1TRlNpbFFicVdXTmsy?=
 =?utf-8?B?OUxjVGZuRDU1amMvSmVRdkFwclR1a2pMaGNiNzNsVWZ2VDF4cnprRDJsUjFp?=
 =?utf-8?B?S2V0N01mZ1FRWE0xd1ExK2ZhUWpHb2xMYUZRcTZGbDkzUWJVVVBES00wU0VS?=
 =?utf-8?B?ck1TOEVFMk40YXpSRDl1cWFhTWp4azVyL212cG8rSW55K0lnLzVpWVhwV2lX?=
 =?utf-8?B?blJPT2tWcDhnbjBFb3p4SE1RVHJRbTVWMTBUZDcvNjB3T2svNmFLZnNtOW5I?=
 =?utf-8?Q?apc1Trf+L36GGm2UnGDfGa0IbqHg3wpXkJcz2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bebd386-a9df-4017-4a32-08da10d531c4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 16:08:27.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NBmDpiqgibEWM7XfxnjKfQ7j9dnmVNc4+IDdfH7LxUSz2P+RlRMV68U3opVmCKlq0SsT5z5Bx6tItSH8k7amL35ZzBctdwzjnRwQjoQKZDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3197
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203280090
X-Proofpoint-ORIG-GUID: kCsdl8YyFEulVnlzCgogoew9WZVeF6fn
X-Proofpoint-GUID: kCsdl8YyFEulVnlzCgogoew9WZVeF6fn
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan, a comment below.
eric

On 3/24/22 09:37, Eric DeVolder wrote:
> 
> 
> On 3/24/22 09:33, Baoquan He wrote:
>> On 03/24/22 at 08:53am, Eric DeVolder wrote:
>>> Baoquan,
>>> Thanks, I've offered a minor correction below.
>>> eric
>>>
>>> On 3/24/22 08:49, Baoquan He wrote:
>>>> On 03/24/22 at 09:38pm, Baoquan He wrote:
>>>>> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>>>>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>>>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>>>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>>>>> important house keeping and then dispatches the hot plug/unplug event
>>>>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>>>>> that handler returns, the lock is released.
>>>>>>
>>>>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>>>>> function that installs handlers for hot plug/unplug events. If CPU
>>>>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>>>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>>>>> register_memory_notifier() is invoked to install a handler for memory
>>>>>> changes. These handlers in turn invoke the common generic handler
>>>>>> crash_hotplug_handler().
>>>>>>
>>>>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>>>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>>>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>>>>> of the new CPU list, thus the need to explicitly check and exclude the
>>>>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>>>>
>>>>>> On the memory side, each un/plugged memory block passes through the
>>>>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>>>>> memory events, one for each 128MiB memblock.
>>>>>
>>>>> I rewrite the log as below with my understanding. Hope it's simpler to
>>>>> help people get what's going on here. Please consider to take if it's
>>>>> OK to you or adjust based on this. The code looks good to me.
>>>>>
>>>> Made some tuning:
>>>>
>>>> crash: add generic infrastructure for crash hotplug support
>>>>
>>>> Upon CPU and memory changes, a generic crash_hotplug_handler() is added
>>>> to dispatch the hot plug/unplug event to the architecture specific
>>>> arch_crash_hotplug_handler(). During the process, kexec_mutex need be
>>>> held.
>>>>
>>>> To support cpu hotplug, one callback pair are registered to capture
>>>> KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
>>>> cpuhp_setup_state_nocalls().
>>> s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
>>> names I've introduced with this patch?
>>
>> Right.
>>
>> While checking it, I notice hp_action which you don't use actually.
>> Can you reconsider that part of design, the hp_action, the a, b
>> parameter passed to handler?
> 
> Sure I can remove. I initially put in there as this was generic infrastructure and not sure if it 
> would benefit others.
> eric
> 

Actually, I will keep the hp_action as the work by Sourabh Jain for PPC uses the hp_action. I'll 
drop the a and b.

Also, shall I post v6, or are you still looking at patches 7 and 8?

Thanks,
eric

>>
>>>
>>>>
>>>> To support memory hotplug, a notifier crash_memhp_nb is registered to
>>>> memory_chain to watch MEM_ONLINE and MEM_OFFLINE events.
>>>>
>>>> These callbacks and notifier will call crash_hotplug_handler() to handle
>>>> captured event when invoked.
>>>>
>>>>>
>>>>>>
>>>>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>>>>> ---
>>>>>>    include/linux/kexec.h |  16 +++++++
>>>>>>    kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
>>>>>>    2 files changed, 124 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>>>> index d7b59248441b..b11d75a6b2bc 100644
>>>>>> --- a/include/linux/kexec.h
>>>>>> +++ b/include/linux/kexec.h
>>>>>> @@ -300,6 +300,13 @@ struct kimage {
>>>>>>        /* Information for loading purgatory */
>>>>>>        struct purgatory_info purgatory_info;
>>>>>> +
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +    bool hotplug_event;
>>>>>> +    int offlinecpu;
>>>>>> +    bool elf_index_valid;
>>>>>> +    int elf_index;
>>>>>> +#endif
>>>>>>    #endif
>>>>>>    #ifdef CONFIG_IMA_KEXEC
>>>>>> @@ -316,6 +323,15 @@ struct kimage {
>>>>>>        unsigned long elf_load_addr;
>>>>>>    };
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>>>>> +    unsigned int hp_action, unsigned long a, unsigned long b);
>>>>>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>>>>>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>>>>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>>>>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>>> +
>>>>>>    /* kexec interface functions */
>>>>>>    extern void machine_kexec(struct kimage *image);
>>>>>>    extern int machine_kexec_prepare(struct kimage *image);
>>>>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>>>>> index 256cf6db573c..76959d440f71 100644
>>>>>> --- a/kernel/crash_core.c
>>>>>> +++ b/kernel/crash_core.c
>>>>>> @@ -9,12 +9,17 @@
>>>>>>    #include <linux/init.h>
>>>>>>    #include <linux/utsname.h>
>>>>>>    #include <linux/vmalloc.h>
>>>>>> +#include <linux/highmem.h>
>>>>>> +#include <linux/memory.h>
>>>>>> +#include <linux/cpuhotplug.h>
>>>>>>    #include <asm/page.h>
>>>>>>    #include <asm/sections.h>
>>>>>>    #include <crypto/sha1.h>
>>>>>> +#include "kexec_internal.h"
>>>>>> +
>>>>>>    /* vmcoreinfo stuff */
>>>>>>    unsigned char *vmcoreinfo_data;
>>>>>>    size_t vmcoreinfo_size;
>>>>>> @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>>>>    }
>>>>>>    subsys_initcall(crash_save_vmcoreinfo_init);
>>>>>> +
>>>>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>>>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>>>>> +    unsigned int hp_action, unsigned long a, unsigned long b)
>>>>>> +{
>>>>>> +    pr_warn("crash hp: %s not implemented", __func__);
>>>>>> +}
>>>>>> +
>>>>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>>>>> +    unsigned long a, unsigned long b)
>>>>>> +{
>>>>>> +    /* Obtain lock while changing crash information */
>>>>>> +    if (!mutex_trylock(&kexec_mutex))
>>>>>> +        return;
>>>>>> +
>>>>>> +    /* Check kdump is loaded */
>>>>>> +    if (kexec_crash_image) {
>>>>>> +        pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>>>>>> +            a, b);
>>>>>> +
>>>>>> +        /* Needed in order for the segments to be updated */
>>>>>> +        arch_kexec_unprotect_crashkres();
>>>>>> +
>>>>>> +        /* Flag to differentiate between normal load and hotplug */
>>>>>> +        kexec_crash_image->hotplug_event = true;
>>>>>> +
>>>>>> +        /* Now invoke arch-specific update handler */
>>>>>> +        arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>>>>>> +
>>>>>> +        /* No longer handling a hotplug event */
>>>>>> +        kexec_crash_image->hotplug_event = false;
>>>>>> +
>>>>>> +        /* Change back to read-only */
>>>>>> +        arch_kexec_protect_crashkres();
>>>>>> +    }
>>>>>> +
>>>>>> +    /* Release lock now that update complete */
>>>>>> +    mutex_unlock(&kexec_mutex);
>>>>>> +}
>>>>>> +
>>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>>>>> +    unsigned long val, void *v)
>>>>>> +{
>>>>>> +    struct memory_notify *mhp = v;
>>>>>> +    unsigned long start, end;
>>>>>> +
>>>>>> +    start = mhp->start_pfn << PAGE_SHIFT;
>>>>>> +    end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>>>>>> +
>>>>>> +    switch (val) {
>>>>>> +    case MEM_ONLINE:
>>>>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>>>>>> +            start, end-start);
>>>>>> +        break;
>>>>>> +
>>>>>> +    case MEM_OFFLINE:
>>>>>> +        crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>>>>>> +            start, end-start);
>>>>>> +        break;
>>>>>> +    }
>>>>>> +    return NOTIFY_OK;
>>>>>> +}
>>>>>> +
>>>>>> +static struct notifier_block crash_memhp_nb = {
>>>>>> +    .notifier_call = crash_memhp_notifier,
>>>>>> +    .priority = 0
>>>>>> +};
>>>>>> +#endif
>>>>>> +
>>>>>> +#if defined(CONFIG_HOTPLUG_CPU)
>>>>>> +static int crash_cpuhp_online(unsigned int cpu)
>>>>>> +{
>>>>>> +    crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int crash_cpuhp_offline(unsigned int cpu)
>>>>>> +{
>>>>>> +    crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +#endif
>>>>>> +
>>>>>> +static int __init crash_hotplug_init(void)
>>>>>> +{
>>>>>> +    int result = 0;
>>>>>> +
>>>>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>>>>> +    register_memory_notifier(&crash_memhp_nb);
>>>>>> +#endif
>>>>>> +
>>>>>> +#if defined(CONFIG_HOTPLUG_CPU)
>>>>>> +    result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>>>>>> +                "crash/cpuhp",
>>>>>> +                crash_cpuhp_online, crash_cpuhp_offline);
>>>>>> +#endif
>>>>>> +
>>>>>> +    return result;
>>>>>> +}
>>>>>> +
>>>>>> +subsys_initcall(crash_hotplug_init);
>>>>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>>>>> -- 
>>>>>> 2.27.0
>>>>>>
>>>>>
>>>>
>>>
>>
