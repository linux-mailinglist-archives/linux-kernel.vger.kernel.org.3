Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5604E6478
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiCXNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350656AbiCXNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:55:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A6387B9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:54:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22OCN3Nb024608;
        Thu, 24 Mar 2022 13:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4h42SjLSU2o65PaI/qZFYfaxuSxPFZ3wi8ycuzD1sgg=;
 b=TqatJaKS64yui4q6U1W5RrezaE2lJFJb5sg+dCE3Vd03ONWt3f5Ofg4N5d595bURA+1W
 bq73s6j3ChhxX81SPxFwiInOIWVK0NAbgRNqra7ltcDdYvEGi3Ftx8VFJIMUKXlBkEGk
 RXkf00Y94534ItCnqjMWqjAcC6BBobjCq1A4hLknTy+fGLDooBvTxM2IE4UA1c5YDBra
 tKctWzOeYPYXKdwKHfLEYaF9afaP1aVlIDnc+wSV/1KFHeXHoMBjwhHmX6z+pZ8Cco0X
 rN9zwUeNhCQ5bmnkgs5a8eRO8r/JJkh/KzEkfawrAyOtZatVc0b/sNxJZyN/FmM4Jxjx Mg== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0vkht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 13:53:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22ODklAT059532;
        Thu, 24 Mar 2022 13:53:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by aserp3030.oracle.com with ESMTP id 3ew57907x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Mar 2022 13:53:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSW5+Wy+pIAzfrbocfwYqV3owSn5btu+WYY8Gd2dOJ2OLRu8QcoZCI9pqkiDAboUPpIKAxGmRm+InD6dqH7tOLEQlIbstibDkQBUMQT+zo6EN5Iu6isBJ2f7eZul2E22ZNBZKRgFS3nsEnV2kjU11Go2RUIZVrBcXyIeFLENaepT3NNzzxK4R/hZjXIjZfI5nweYB3JGhHyDF3Ia8UbWI2fiSHUenXqMwkb5rg4wqj0wHbMbS1kZzYrGwlSNnBAHxT0aH48cXeCBfUnf5BmcAQczvM1gaTlThMlGzlU3I5Yo3juMDcYfFbU6+Wfx4e9RrRA22Co6GXrxKQE5hcpINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4h42SjLSU2o65PaI/qZFYfaxuSxPFZ3wi8ycuzD1sgg=;
 b=KatstUfRzP+xqrwp+NTjkstfnc0GsO1epMsU6W5CXlditdi71r79F/w+twJpxaicGCwSoJ4pdqRDN/fdxXzKesvWfvTMJFgrIYNBeK+73seTTTmciuegkC128pRPyoXH3q+jFhBJeBaoiLQ9qxCRBN4HEZyIpkU0uPVrKSj1SEAiKoGFvFSaQrxJYV1doD7bZAsNoLY79W7LTfwJBav2JQgXEtFVIG3SQkjELNeLQWpiEt39Sb7cynNfTm8dBUyirHxJacKpaBdmaFf3aVcUuz4IEPFUMSC+u5/tLs95AJDcia2RUmsfpC81PCCCpAbc9zYF78ezSuBhxWsxeDp3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4h42SjLSU2o65PaI/qZFYfaxuSxPFZ3wi8ycuzD1sgg=;
 b=aOgzbS0/HZol/13/fCEhH8gmtXKqKmVLob3dpISK/VkUPxGEaGwjD1mP4IsuPwCccKBn8SzfyEWKyhMrh8Ha24Si54+CQLTKIzCVG30nQ+RyYoFTiKq7zkL+Ia54FmVxu2m5M+IuGOzUzf4NBu+JDTtgtdW5Dr+9MjewXg9TlOA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 13:53:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 13:53:41 +0000
Message-ID: <d12cd750-4f7e-46e8-8f31-66e29edbede9@oracle.com>
Date:   Thu, 24 Mar 2022 08:53:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v5 4/8] crash: generic crash hotplug support
 infrastructure
Content-Language: en-US
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
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20220324134911.GA354791@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:806:23::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09268497-5d14-4663-628b-08da0d9db439
X-MS-TrafficTypeDiagnostic: BLAPR10MB4914:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB491425988705D87FF997895797199@BLAPR10MB4914.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFoVRvkmbuM34q4rgqASET87cjnp306W/aR/f//CrgFEVrU63fxcdoOFjXpciEddOmTO9QE0SLSsrpi0ej7D6kVJ0haFRhBwzxvfkzEf0vyjWRgGjrTvjSMGtEIJscn12+ER/pbfhkUC85qSyFkU0QSNiJ0+0MYMADUzfugBNJWsZyPoIRzYvKCQWP6d2vZSiTBHKyJigKZ6vs71qFg4oqOI7oXJ+ph/4heAQIaBth6+dL3XZkiP/RorGp0u/OXPX9kLq6WURsW8wpP4t+SgQEwJivqphz0O1jt4QQjjLgVs7xWo9seK8gKwnZPCPeS4/YXaMfLTHGB0xaWGADF8RlIEHhHwHHliTSOgigXtaXeIaGePpwrwe6RjTR2kUahn7m4I8KMzqP16yfMuW3ePpzqiR16FuJxRBe3ljnp0+LQ5vB+kk3M22vEuJjB9X3WbhXYda/cTcQND7nyVNCv6b5uQNz5r3VfYzqSDLa6+YQHa5On7Z+CGvUBqr8qNLJDlLVfvMP+iKiADJOi+ParziyhKJeUqbupcwk/H3UPhGW9U08iaMT2BKqQfeQKDb6CwU1DJUV6MhqDDr0YGSQFjppUMgZ02LoeGZuBgceHOREn1oeN2Efvx+XjeGdT+IOP+mX3F1NB3on2kLW9evxo+9FSCitPvpF+RTlE+2Kk7es+u7USHtFcrvZT6CxPLKpTFe4DOL81dU+26NbAkhXoEphYz42EXwSKUOARFyBCbUtAsM+hMBBiz7xDCeKWZ1IWOwrOnsaIOD0m/IscdL9ryiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(2906002)(316002)(6486002)(508600001)(31696002)(86362001)(83380400001)(66476007)(38100700002)(6512007)(6666004)(53546011)(186003)(6506007)(107886003)(2616005)(8936002)(66946007)(31686004)(36756003)(8676002)(4326008)(7416002)(66556008)(5660300002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNKalFQRFBpKzltNkdpTjkxZ0dWb2lMS0RxRXdWUXFsOFd5dzRENko4Q1hE?=
 =?utf-8?B?Wlp6UlFCMnE5dzdqVDdqdUNVVjZ2cXZSTGlFdy9VRTlHNi81bWRLK2Q4Vlg3?=
 =?utf-8?B?RFZKc2EzV2xLVEpjVm5DVTViLzl6MXBja0IrcDZVbUR3VUw4K1A1VkZPTDF3?=
 =?utf-8?B?NWllQ2E2WHQ5VUFJWmp6d3U2dnlYakNLYzJYLzgyckFjREhkRnZNaWdBcm5Y?=
 =?utf-8?B?MWQ3MmhmNHkxdFhSem1PVUk2Mi9IVU1YcjBtM2sveWlGaFcwQUlEalR3RnYw?=
 =?utf-8?B?QzNpM2RrZDFRcE1TakcweUlPcXBIUTFodFJhaExYNllYQlk3aGlGMzN3SEtO?=
 =?utf-8?B?NHN3QzFGeUZnR2VXeVBXZCtOeXBPM3VNZHJsU0NsNkZ1WlZOZUdZSjhjR3N1?=
 =?utf-8?B?Qk1lR0JaSFBncVFFVjUrNWhiUzc4YjJjUHp5a0wrck14NHllNjN6WjNFT2th?=
 =?utf-8?B?WVhjVzZLWFZKVzB0QlM5Nk4wc3RXckFnQ29xdG1MSkpNMjhubTQzUnFxdTRw?=
 =?utf-8?B?RHVKbXk3VWJzb3FXbExsR2ZzRHc1c3B5QkNFVjJuOUNYYUNoWDlpd3BYWFJO?=
 =?utf-8?B?UWpuYXN3bkZKMTNXTWRBMGN5ZEJvZUFOVzhOSXZWaGZicmRTSlAyRjhnMjBB?=
 =?utf-8?B?cFc3ek1KYkMwRFl6SjJtQWpOZFFJVzVSTTAvR042QWg4alhqVWtBNFFBR2lW?=
 =?utf-8?B?c01EVlF4bldvUVdlakFSN3orYlUxb05uYU1pVUZiVWZoMzBPc3JMTGdaY2tE?=
 =?utf-8?B?WFFld05QdUJmdFBjQktIT0JiOE1QL05RS3EvQm1nMkVBc2t1aVRtN21DR29H?=
 =?utf-8?B?aEhWYkNWV2NWR0ZFUFZjQ2QwN2IxRkdRME5RNVdnY3c2ay80bUUrdVdoUmFk?=
 =?utf-8?B?V0Y1MjJRcnZWcFJucnVYY0FySHR0OHZXMWlUYUp2MVZQYlRiWDRlU3lQUjZE?=
 =?utf-8?B?TlVWS1UrbjEyVkw3b2dnTTRHa3lmbG9hMVpCWDE5anFOSmZhRVdUdVRKRVlM?=
 =?utf-8?B?ZzU0Y0pENzdya2NDdy9hZG14bEZjV0dRVndsVjVVTjhjNkFqTDh5b2FDaEp6?=
 =?utf-8?B?b3QzMTE2eGEvQ3g5MXhnN3VPVjVuVW1kVHRXT3JRRWxZVThEYmY0N3NnNm9k?=
 =?utf-8?B?MERsbmVENUJrZXlSUWRaNm9TQzE5c04zVHFiNWx1cFh3M3Mxc0N2aXdINnp3?=
 =?utf-8?B?VkV2YkFqV1hxeXBJOWlPMGR5bEVPc0ZKcHVrb0lKa2RtenliRVp2Q2sxWVZI?=
 =?utf-8?B?eUhZQlg0ZDdXTW1GZjJEaFFhbi9BQWZOcEpRM0dCZm1VZ1NNOE52cUVWa3hj?=
 =?utf-8?B?QjlycFVSYm4vMktRUDI4VmY4UXdzQmZPK3ZWZ2QwYUQwcGNqNDRRM3hsQ0ZG?=
 =?utf-8?B?MTF2THk5dkRta2dUU2g2dzVFQjF0WjJnZlVBTFkvK2NDNVI3UnZMMGJzK2FH?=
 =?utf-8?B?WlowNzF1N3RXTzNSQ3NZSGJvYWhvKzJVL0h3bGxlajlOaDBhdmplVlcyRlVO?=
 =?utf-8?B?NmVhQ1RVcFFoMTBVWGNHZENKd3J6NHpBVFlUSGdrbkRhUUF3VFIvbFdQTjA1?=
 =?utf-8?B?Nm1FU1lVMmpFbUJzeElvYnpueldkb1BGOFFwWWpxRnhGa2UzcmtuQnpKUjlV?=
 =?utf-8?B?WUV6RVh6VlZaOHEzKyttQ0VIWHRXcXhsVzFvM0Z6R2VIWE5MZGVXS3RZTnpz?=
 =?utf-8?B?a05SOGZSdnUwNGt1a2NyWHlZNURXTEU0RmE4RGM0dmpwWU5vUm5SSFQ5d1Nj?=
 =?utf-8?B?a0FManQ2cjZBbzhpZkFrNlREbk5mRUxiRm42R3NCWE5LMkpic20reHJhYndq?=
 =?utf-8?B?SnJEUGNGaVZvalZJc2FKSmI1b2s4REtWKzhZb0x0LzVhbnUrWm5PVnJBZlFO?=
 =?utf-8?B?S254bzN2ZitsZjdWNHZINGVsWmE3STNxRTBIcU4vM29wQ2tjajZ4ellEdCtu?=
 =?utf-8?B?Wko5VnhDQUtVdmhJUzBtLzNhU2prbUY0QUlia0VjOXhNWWU1WVhzQ2ludzRO?=
 =?utf-8?B?dXJ5cUY2Z1ZTVERZSUdmUHcvSmQ4ZzA4NE9leUR2TmIyZE5yWXdaSXptemt2?=
 =?utf-8?B?SERuMEtndGdGcWsxb3lTMnFWWjd2WnpDOFFFZmFpM3NsLzBGdFRyNUZBdm9h?=
 =?utf-8?B?WnB6Z0lQaldyNXUraDcrNUhwVGo3dW1IcUowUzBrNlFKYkJqZ0lhMjRHeTAw?=
 =?utf-8?B?M0ZLZW15cW5RTnY1amZFNjdpdERyL3JJVllxbmlmSTRlektiSlJJZFphNDVX?=
 =?utf-8?B?ZkVHS0JGWmZOSDZzUlg4Ulc5QjRpMGFGOUE1SUNyb29oQ0N1Z2FkSTFJVWhQ?=
 =?utf-8?B?NG0wN21qc05QdTJzMEVkQmlZYWJ3akhPQUladXJwMzY5ZnhveFFJQmRYRFRE?=
 =?utf-8?Q?5/7Nv1qlOaBK1WMWDM0vVhf1kqCZoTfSswEcz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09268497-5d14-4663-628b-08da0d9db439
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:53:41.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keeNlI7Vsv41bBHc9aFlZy4VMVjh2F7F+EWj87F7snTH4pJzPRfalWo2BHnmMN5jgxgqr3hayeu4PD+4+sN3kNaNSHQCgyfSZET0cUUUJzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10295 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203240079
X-Proofpoint-GUID: Vyzuz_CaAwCmvw3mPyn1lft3bthGqNE_
X-Proofpoint-ORIG-GUID: Vyzuz_CaAwCmvw3mPyn1lft3bthGqNE_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,
Thanks, I've offered a minor correction below.
eric

On 3/24/22 08:49, Baoquan He wrote:
> On 03/24/22 at 09:38pm, Baoquan He wrote:
>> On 03/03/22 at 11:27am, Eric DeVolder wrote:
>>> This patch introduces a generic crash hot plug/unplug infrastructure
>>> for CPU and memory changes. Upon CPU and memory changes, a generic
>>> crash_hotplug_handler() obtains the appropriate lock, does some
>>> important house keeping and then dispatches the hot plug/unplug event
>>> to the architecture specific arch_crash_hotplug_handler(), and when
>>> that handler returns, the lock is released.
>>>
>>> This patch modifies crash_core.c to implement a subsys_initcall()
>>> function that installs handlers for hot plug/unplug events. If CPU
>>> hotplug is enabled, then cpuhp_setup_state() is invoked to register a
>>> handler for CPU changes. Similarly, if memory hotplug is enabled, then
>>> register_memory_notifier() is invoked to install a handler for memory
>>> changes. These handlers in turn invoke the common generic handler
>>> crash_hotplug_handler().
>>>
>>> On the CPU side, cpuhp_setup_state_nocalls() is invoked with parameter
>>> CPUHP_AP_ONLINE_DYN. While this works, when a CPU is being unplugged,
>>> the CPU still shows up in foreach_present_cpu() during the regeneration
>>> of the new CPU list, thus the need to explicitly check and exclude the
>>> soon-to-be offlined CPU in crash_prepare_elf64_headers().
>>>
>>> On the memory side, each un/plugged memory block passes through the
>>> handler. For example, if a 1GiB DIMM is hotplugged, that generate 8
>>> memory events, one for each 128MiB memblock.
>>
>> I rewrite the log as below with my understanding. Hope it's simpler to
>> help people get what's going on here. Please consider to take if it's
>> OK to you or adjust based on this. The code looks good to me.
>>
> Made some tuning:
> 
> crash: add generic infrastructure for crash hotplug support
> 
> Upon CPU and memory changes, a generic crash_hotplug_handler() is added
> to dispatch the hot plug/unplug event to the architecture specific
> arch_crash_hotplug_handler(). During the process, kexec_mutex need be
> held.
> 
> To support cpu hotplug, one callback pair are registered to capture
> KEXEC_CRASH_HP_ADD_CPU and KEXEC_CRASH_HP_REMOVE_CPU events via
> cpuhp_setup_state_nocalls().
s/KEXEC_CRASH_HP_ADD}REMOVE_CPU/CPUHP_AP_ONLINE_DYN/ as the KEXEC_CRASH are the
names I've introduced with this patch?

> 
> To support memory hotplug, a notifier crash_memhp_nb is registered to
> memory_chain to watch MEM_ONLINE and MEM_OFFLINE events.
> 
> These callbacks and notifier will call crash_hotplug_handler() to handle
> captured event when invoked.
> 
>>
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> ---
>>>   include/linux/kexec.h |  16 +++++++
>>>   kernel/crash_core.c   | 108 ++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 124 insertions(+)
>>>
>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>> index d7b59248441b..b11d75a6b2bc 100644
>>> --- a/include/linux/kexec.h
>>> +++ b/include/linux/kexec.h
>>> @@ -300,6 +300,13 @@ struct kimage {
>>>   
>>>   	/* Information for loading purgatory */
>>>   	struct purgatory_info purgatory_info;
>>> +
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +	bool hotplug_event;
>>> +	int offlinecpu;
>>> +	bool elf_index_valid;
>>> +	int elf_index;
>>> +#endif
>>>   #endif
>>>   
>>>   #ifdef CONFIG_IMA_KEXEC
>>> @@ -316,6 +323,15 @@ struct kimage {
>>>   	unsigned long elf_load_addr;
>>>   };
>>>   
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +void arch_crash_hotplug_handler(struct kimage *image,
>>> +	unsigned int hp_action, unsigned long a, unsigned long b);
>>> +#define KEXEC_CRASH_HP_REMOVE_CPU   0
>>> +#define KEXEC_CRASH_HP_ADD_CPU      1
>>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY 2
>>> +#define KEXEC_CRASH_HP_ADD_MEMORY   3
>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>> +
>>>   /* kexec interface functions */
>>>   extern void machine_kexec(struct kimage *image);
>>>   extern int machine_kexec_prepare(struct kimage *image);
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 256cf6db573c..76959d440f71 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -9,12 +9,17 @@
>>>   #include <linux/init.h>
>>>   #include <linux/utsname.h>
>>>   #include <linux/vmalloc.h>
>>> +#include <linux/highmem.h>
>>> +#include <linux/memory.h>
>>> +#include <linux/cpuhotplug.h>
>>>   
>>>   #include <asm/page.h>
>>>   #include <asm/sections.h>
>>>   
>>>   #include <crypto/sha1.h>
>>>   
>>> +#include "kexec_internal.h"
>>> +
>>>   /* vmcoreinfo stuff */
>>>   unsigned char *vmcoreinfo_data;
>>>   size_t vmcoreinfo_size;
>>> @@ -491,3 +496,106 @@ static int __init crash_save_vmcoreinfo_init(void)
>>>   }
>>>   
>>>   subsys_initcall(crash_save_vmcoreinfo_init);
>>> +
>>> +#ifdef CONFIG_CRASH_HOTPLUG
>>> +void __weak arch_crash_hotplug_handler(struct kimage *image,
>>> +	unsigned int hp_action, unsigned long a, unsigned long b)
>>> +{
>>> +	pr_warn("crash hp: %s not implemented", __func__);
>>> +}
>>> +
>>> +static void crash_hotplug_handler(unsigned int hp_action,
>>> +	unsigned long a, unsigned long b)
>>> +{
>>> +	/* Obtain lock while changing crash information */
>>> +	if (!mutex_trylock(&kexec_mutex))
>>> +		return;
>>> +
>>> +	/* Check kdump is loaded */
>>> +	if (kexec_crash_image) {
>>> +		pr_debug("crash hp: hp_action %u, a %lu, b %lu", hp_action,
>>> +			a, b);
>>> +
>>> +		/* Needed in order for the segments to be updated */
>>> +		arch_kexec_unprotect_crashkres();
>>> +
>>> +		/* Flag to differentiate between normal load and hotplug */
>>> +		kexec_crash_image->hotplug_event = true;
>>> +
>>> +		/* Now invoke arch-specific update handler */
>>> +		arch_crash_hotplug_handler(kexec_crash_image, hp_action, a, b);
>>> +
>>> +		/* No longer handling a hotplug event */
>>> +		kexec_crash_image->hotplug_event = false;
>>> +
>>> +		/* Change back to read-only */
>>> +		arch_kexec_protect_crashkres();
>>> +	}
>>> +
>>> +	/* Release lock now that update complete */
>>> +	mutex_unlock(&kexec_mutex);
>>> +}
>>> +
>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>> +static int crash_memhp_notifier(struct notifier_block *nb,
>>> +	unsigned long val, void *v)
>>> +{
>>> +	struct memory_notify *mhp = v;
>>> +	unsigned long start, end;
>>> +
>>> +	start = mhp->start_pfn << PAGE_SHIFT;
>>> +	end = ((mhp->start_pfn + mhp->nr_pages) << PAGE_SHIFT) - 1;
>>> +
>>> +	switch (val) {
>>> +	case MEM_ONLINE:
>>> +		crash_hotplug_handler(KEXEC_CRASH_HP_ADD_MEMORY,
>>> +			start, end-start);
>>> +		break;
>>> +
>>> +	case MEM_OFFLINE:
>>> +		crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_MEMORY,
>>> +			start, end-start);
>>> +		break;
>>> +	}
>>> +	return NOTIFY_OK;
>>> +}
>>> +
>>> +static struct notifier_block crash_memhp_nb = {
>>> +	.notifier_call = crash_memhp_notifier,
>>> +	.priority = 0
>>> +};
>>> +#endif
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU)
>>> +static int crash_cpuhp_online(unsigned int cpu)
>>> +{
>>> +	crash_hotplug_handler(KEXEC_CRASH_HP_ADD_CPU, cpu, 0);
>>> +	return 0;
>>> +}
>>> +
>>> +static int crash_cpuhp_offline(unsigned int cpu)
>>> +{
>>> +	crash_hotplug_handler(KEXEC_CRASH_HP_REMOVE_CPU, cpu, 0);
>>> +	return 0;
>>> +}
>>> +#endif
>>> +
>>> +static int __init crash_hotplug_init(void)
>>> +{
>>> +	int result = 0;
>>> +
>>> +#if defined(CONFIG_MEMORY_HOTPLUG)
>>> +	register_memory_notifier(&crash_memhp_nb);
>>> +#endif
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU)
>>> +	result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>>> +				"crash/cpuhp",
>>> +				crash_cpuhp_online, crash_cpuhp_offline);
>>> +#endif
>>> +
>>> +	return result;
>>> +}
>>> +
>>> +subsys_initcall(crash_hotplug_init);
>>> +#endif /* CONFIG_CRASH_HOTPLUG */
>>> -- 
>>> 2.27.0
>>>
>>
> 
