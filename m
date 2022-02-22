Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4F4C037B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbiBVVCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiBVVCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:02:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23BBC3C08
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:02:09 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MJNrcR018646;
        Tue, 22 Feb 2022 21:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8o/ku4bz+eiJM+pOfg9GkPFCv2ze7Ef0j4IaaVPOHkI=;
 b=VNXQUakj/JCNbcTOJgseOJ15UslJluqchcdHDtVCuEk+wVuKlWqbaO4L7o01VlpD/UpT
 cvy7Sc4tasPwY+p6YjYYTe/Eki/8520HLS5u/58e6x22fXnVcYNyTpCqRqe0UE5+nvpU
 hkfwTMnehGztKXggYIleu34Nj+MQVg6CtKit3kE6Ivin9FxYOPBue1TvsUb8lJSbzHVh
 myk78EUDbbWnTKf6UUJylAtfrKJ91eYnku4yK58sdywGL6nxPFznBle5QyMkmv4lg0rs
 ZRgYQbQNs/Aqq5b8N2BL8Tnu3+e3Qs8203D1kd0504tk3ZFvhaxAlVgGygp1yDnKGZIZ 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx2c9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 21:01:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ML0gHr083253;
        Tue, 22 Feb 2022 21:01:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 3eat0nj8eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 21:01:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7zPEjjxqI0ydo4gkalVV5GpO7KFK7Y0q0kc0dwHnbFz119s7HAgNBmI9ZAL9tLQevnz79oMfl4BC8NE9l8wrmiGE9S7+tqnlBOr1KyF7nIGC+uSWbHc164rYNwWBGGd4fkorxPOH+83EOyxOyhpFfe4nDeWLKVcoybdyP0b2v3DJJH+vUj+dXAZXg8P8ExWFtnZpozVyYtmLw8AqKDDu68zLW9V2r1NegJguaZyQSNe+5RkbbAqi1AFs21ZX76xjusWxyoWsZCy84lXjjDi0mRFLEd5vmMvcPClt2zWFw0YjPLPuF0Xf+YR1M+lZyYmfdAzobZMaQqqrGFyMqOEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o/ku4bz+eiJM+pOfg9GkPFCv2ze7Ef0j4IaaVPOHkI=;
 b=O4LS/X1AlPObTxlLoN43jv2dYlY8cPcwh7mMOMtT8EsvqltpGN3PhYwSNaV/TMetiJLNCxK9ydQFbjlLxIudNMiGT0fLNBvfXrFTe5IL5n4anvMXzxddR53BgZuoV03leNcMyaaS2a6bqJ7PZGGdUAXPV7EkTaX+dYtYgXWegnZPaz4nzWhzExc+Tq/ZynxeSUZJUDjv3wzWa71JYWkPqs1qS2Rb954v6uE878aKRGukF6r5OfmBoPYHmBaJClYhyoSGzBINsBchmnLtKn5lA9DBeiLQk6thUPUpjsqYYmOnzOmpmjqsya2ThHtyIUQqeZdJAhVCrrjnu2KK5Nvs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o/ku4bz+eiJM+pOfg9GkPFCv2ze7Ef0j4IaaVPOHkI=;
 b=xT/a9fHkcZCjGKSfg32cGU/YQEdl5uH38F+BddWd0lO3Vh6DMdy7KtZoWV9bFYTosRXK20MUz+BDkMCbNujxqEyBpjWqsX+K0XLayHxbS9ykJyL/Yd9UNzCz5Gm8I4PGWMP0U7pgc/+Son5hKnuxUITKdByN8/lgK5LwC/5KQbs=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by CO1PR10MB4499.namprd10.prod.outlook.com (2603:10b6:303:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 21:01:36 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 21:01:36 +0000
Message-ID: <6e5763be-3e9c-0199-24ea-e4f5b226d990@oracle.com>
Date:   Tue, 22 Feb 2022 16:01:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
 <YgabtFd4Nkpgi+oW@zn.tnic> <2e584fc4-163a-0af4-abe0-9c14996918f2@oracle.com>
 <Ygvy8j9E7WPo6dx0@zn.tnic>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <Ygvy8j9E7WPo6dx0@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44c0b6a6-a91c-4ca9-f6df-08d9f646835f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4499:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB449921AC542FB65DE4B9896FE63B9@CO1PR10MB4499.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8vYiMD6OYh4by90GaV7iru6WwCC27iIHkx1a/AihFKiT/1wiiaEEbjCIWJmPehoLKPPlyonOwC+yuF/S6teXi1TKRc1Ka9GHt01J2RwnZD0z4SgnJH4BX+7BC/aY6CDjvgGYd/FSvu36ZaVz4QiRfrmRr7dzgft1fOjkkQ1R6aQneu4KRMZQk5fOU3EvwufWv5/7q00M/axQRC+QPLEP3tk7o4EsEZfFWOGwxnekX5QxTsoRrdbKktejq3H9nJuQaAhjkwMMfTbCZo8cN6ef7UcoHOordV1ivfC3Z0vWYPLeT4XRcpQ4FZxYD9h5vXxF/4LTGABAKqgNJJCeRBx255X2LZh4mWRTn5+dBfbUm/UhvE5c6QQeBWitKzbzzsKmDRFMZ/DiVcgaEiRpNYcYAVm8VTQJ3iyS4f10T6XrYRuJ4QcALzGDRac0NJXXEWp6fo0RCUuFoft2nhoWArZYy/4iWreqm+K1XhUn/iOkjFy4JjtbHPSMudU/Z4UoAC8BV0y9cLHgwSluJssrmpkjIRpj8nPhQmkQ4afjr0J4EzPmvsLUnKtesWUvJG3CxbT8MF5j0mpXPFkKcdcYoYleXPg83/+QsyvjZLry9jmzOxs4aQtbuVKeL9fdN6pW8KzYa2gdxv+8x0Im3NVkP8iEcdY0ydRkWbRFRu9fU1pC6Qw7SCcPTfJLwj5V7PQVUuxkBOi4ngPMYxB+XAeuIUnhBh8xNxSc8dWDCcjwd/zRd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(36756003)(508600001)(44832011)(6486002)(5660300002)(86362001)(8936002)(316002)(6916009)(8676002)(4326008)(66476007)(66556008)(66946007)(2616005)(83380400001)(186003)(6666004)(6512007)(6506007)(53546011)(2906002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEVPK3VZcEQ3bkVnZ01FRGxTRWFVRUxDallsMGVmQVpGU3lLQ3U0aWtKY3NE?=
 =?utf-8?B?THVnUTZyVFRmdmszc3pXbGtpby80bWV4YlF0bERBNHh5WTRFLzIwR21kUjB6?=
 =?utf-8?B?K1hKVWpZYk5RWERRYzU5RUtiREU5emZoVzRPUUJDNE1PdGdyNUUyNVpHYjJw?=
 =?utf-8?B?QVovN1F6dktrM0hCMTNoL3c4T0hEYkVYYzBmb2VTdXhMVXljS2wrbk1LZ2dz?=
 =?utf-8?B?K2JMcXBQTElLbVl0OW1yNStNT2poM0lpNDFVcGNQQ0pJOHFXSTltTXRCeEd3?=
 =?utf-8?B?b1BxNnA4eUlBZ05XOG1nZStCQXdISzkyT3Q0bkI2RDkveTVQcVVZVTBmTWhu?=
 =?utf-8?B?S3EwZkZ5dnhYeUQwak1nMThObzF6Q2FRdGpNVjRGSDZPMExPb1ZSTHpxdU9J?=
 =?utf-8?B?MjU3Q0pZMFg3VWdmbzVMTWVOZkFHOWJQMUJWS1Q5Qnd3Wm12cUY2Uk16c1ZG?=
 =?utf-8?B?UnQ1amZUV040SktTY2paQ3AzaXhBVHNzUzh6ZW9QVStCRzkyQk9ZcnJXMTJm?=
 =?utf-8?B?Kzd6VHRxdmNXU29aU01VRkJpQzNCQ3l5cnUrb0d4aThhWTBRVzVtVUY2cVM2?=
 =?utf-8?B?eFgwVzJKS1dEakw2ZHYrNFNQZjhLaG9NN1JWTXpHUVE0eW1aUzVpK3dyZVAy?=
 =?utf-8?B?dURzR1MvekJsZTRsSXJiS0sreklBaEFrWkNuTkFia010cEhLa0haMzhMaENj?=
 =?utf-8?B?NVJZalZnVmw2VjlycVFnUWFFSWhEY1JxUGs1clAwQXdPWGlFSzRxcXVoNmU5?=
 =?utf-8?B?aGZEbkhWSG51SnQ2RUhwUW02bzRkUTR2U3pDeFFtUFNCNlZ2SUFaM2Jrci9k?=
 =?utf-8?B?RDIwd2REZHVCVXE0V0pOM2xwYVByYnZYc1FPeDcyOWtIQ1liSVQzZHFybG10?=
 =?utf-8?B?RkZrdXQ4aVVmYnBpTHluV1oxS3RydmRLTzVIMFd0NCtOcHVxenFEUk05M3dM?=
 =?utf-8?B?cDFuWXFjK1pvTTJxOEpaVU1NbC9WNnV1c3pUR1BEeDlxOGxJcHdvVmJFOGs2?=
 =?utf-8?B?M3NhaWVVZVF1WjJEY215Q25ONkFET3g4dGp0Z3JrK0lUSkFDenFabTRPWHVm?=
 =?utf-8?B?ZXc0empadUZSQjdXVEMxN3NMNXJJZUE2a3J3clk2VUdLZFFuMkJzYVNaczZH?=
 =?utf-8?B?VFVaTXZ3KytEeXM5OVVtZlIvZDNzWnc5cjdiYTlSdWlwTHhMSXBIdENhV3lL?=
 =?utf-8?B?MEh6TVdqZVNkT2FvZUluMmdMREMydmpsSXhKR1JSRjA5SGx3WnFKL3JZYXBP?=
 =?utf-8?B?bmQ1TE5SNVZIOUlEY1pjamJPT3hlTVVBbkt0V3ZXNG12Qi9NUDBEeXdwNktK?=
 =?utf-8?B?b2RjU2dFQzQrYXRZQndGOGdFVHR3REYwS2U3SUlyeXoxak84Yi93YUdKZE1X?=
 =?utf-8?B?cVlHK1hxVkswOU9aUnh0a3F4V0Q0azFEenRUME93azNPOUk4N0xjSnc4aWZs?=
 =?utf-8?B?TnMwYXAwcTAxbzhjZHZvaVR6RnN3WkgvL2NYbHlWd1NPb2tPU3RtcCtZdmZx?=
 =?utf-8?B?R2lGSkFydlN2aUFwY3hOUlNHNGY0KzZpbldVb0FVbEdXL2gwUHhPdnV3L0lW?=
 =?utf-8?B?bjB1b21lSUpyOUVZLzBwdnpDN0xqS3dFaE5CekxEb1NsTXdydEhhNXJ3WlNV?=
 =?utf-8?B?ZW40Uk5ZWXpheWd5cVpEdGNrZ2ljZUx4U0VxOFVVbnJVWVdYWEU1T2orUkFC?=
 =?utf-8?B?aUVHaEcvNnZWVnlGUGZZL1RoTUk3MXpvQkxIaHJMeThDT1cvbEkydHVyb1p2?=
 =?utf-8?B?NWZoaUFCTTJlVkltQ2ErakpxVXNtbVBEZmJNbkVxUUJMdlRpVnRJbnc0M1ZT?=
 =?utf-8?B?aEIvcXZWRXVpM2MrbWgrVDZ2WWp1bEtoQlRjWVFOMDAwL1BGZm9XMlYrTHFh?=
 =?utf-8?B?NlNIT0Y3QU5qL1V2WUN5ZERIR0lubVgvNnh6OTkzeWE3VGt5aGtBTWpmeFFy?=
 =?utf-8?B?TW13bENUYkNsYU8zSHcvRVdQcUNnYnVTWW93cnZ6aEdjNEx6cU9UYjMzZENN?=
 =?utf-8?B?Q1daYUVpaFZZSkdmUWZaeVU0MVd6NC9jUmc5NjF6VUJWZjRSdGIyOWdFcmlU?=
 =?utf-8?B?Nkl4L3ZzdnlSdFdKUzUyTUthejlobks0M1ViZDVOWUV3TnplTU1nZlE3RHNn?=
 =?utf-8?B?cFdGcC9BeXBsNUk0ZCtmZGN1VC84R2pMSzkrUGhOTzdaUkZEK1dBZDVPTzNF?=
 =?utf-8?B?Uk9kOW16VTd0YXF1UDNCQm5rNUFEeHB6Si9SV3c0UjhTYWlxSnpEVksyZFJi?=
 =?utf-8?B?d3BVclRDR0U1eE00T3ZTNzZsaEh4emtKWUNBSGVQS1UyL0oza3NZVlA0Szdi?=
 =?utf-8?Q?PbO6FCrnkvh7X/DLmy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c0b6a6-a91c-4ca9-f6df-08d9f646835f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 21:01:36.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+6z1D+IFckUA2QW3sZFK/hGl+WBUwKsGV9nZIParnCQBH68Xt1xdet/g9030ooyM8rf1eRdzgjR19N7b2oYVbs+FmHwQ2kn/ymuzXg1gQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4499
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=991 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202220129
X-Proofpoint-ORIG-GUID: BVzwVB6ohiTqdQPOiosA-p36jRPpG_v5
X-Proofpoint-GUID: BVzwVB6ohiTqdQPOiosA-p36jRPpG_v5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 13:37, Borislav Petkov wrote:
> On Tue, Feb 15, 2022 at 06:34:43AM -0500, Ross Philipson wrote:
>> It can if you run out of slots in the fixed map.
> 
> Right. Or if any of the checks in __early_ioremap() fail. But those
> would at least warn.
> 
>> The only reason I did not check it for NULL was because it was not
>> checked elsewhere for NULL.
> 
> Elsewhere in the tree or elsewhere in this file or in the setup_indirect
> adding code?

In the ioremap.c module, the check for NULL is only missing in the
functions we updated but the lack of a check was already there before
these changes went in.

In the setup.c and e820.c modules, the check for NULL is missing in the
functions we updated but the lack of a check was already there before
these changes went in in those functions. The lack of early_memremap()
NULL checks can also be found in other functions in those modules.

> 
>> I guess there are two questions:
>>
>> 1. Should I also fix it elsewhere in the code I am touching?
> 
> Yes pls.
> 
>> 2. What should I do on an allocation failure? In a routine like this it
>> seems to be a critical early boot failure.
> 
> How so?
> 
> I'd expect in the case of e820__reserve_setup_data(), for example, to
> not call e820__range_update* and not have those indirect ranges present
> in the e820 map. What the user intended might not work but it'll at
> least boot instead of floating dead in the water.
> 
> And similar approach in the other places you're touching.

Yes I can see how to handle the failures. I will fix the code to do the
appropriate thing given what each of the functions is doing.

Fixing it in other functions and possibly elsewhere in the arch/x86 code
seems to be out of scope for this patch set. We could send separate
patches and hunt down other places this check is missing.

> 
> You could even issue a warning or so so that users at least know what's
> going on. I'd say...

Yea I can pr_warn when the issue occurs.

> 
>> I guess the original intention might have been to let it just blow up
>> since there is no recovery but that is just conjecture...
> 
> The original intention?

It was just idle speculation, just ignore this.

Thanks
Ross

> 
> Thx.
> 

