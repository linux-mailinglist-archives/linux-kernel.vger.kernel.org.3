Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AFA4EB844
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiC3CZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiC3CZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:25:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5847C39694
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 19:23:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TKmiQ0026999;
        Wed, 30 Mar 2022 02:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=z3s4LXdEI1GIFGSY0m2VVWjdR1Ml1iONPpSDDO8/gEk=;
 b=Hcwfw35StpHhycRdDZ8MuFHptz4rMVZYIafInl7pUJl4DqK4ju8Ml3ypK3x+b+iciCU6
 CMbgmC7IyTBO74FzujNyFcHK0PT5lxSlLMa+zd8fkWyyccGN1ymMO15eQHQG073iprg3
 d5rqmbtf7VlsQw4Ka3wMNYCOQt03ccPVFuiIH/Qq9LVOmUc+16elGyxhVPzuTbKoFvSk
 77Q+8RrH3D6aGJKC3eBOoG6TUVQWdFLXDHoK4CZ5LUrHrudJynzETcIycMidwRUBVIsd
 Ty+iXBOCIL0+n3eoLWjfDOT48AKVPqziG/wZz/lvKlheJlw8H6smmw2CcM2jVcvJy9tp dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tes05xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 02:23:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U2N22f181088;
        Wed, 30 Mar 2022 02:23:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3f1v9fjqwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 02:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxqPmGfU2iIKH4bHP9zouFncvBLHw6VS3ppleQfri0D8WfIY3NCK5eINX/FalLR9v08u/tbE0qKTbeW/e01XCWd9p7Hq481QCSIGG8qACpJXlo0QSLpYi9tr5oU5O/bl292kNKGGgzig3+wmBqiKklnQpt3oDq9i+ZY3ejEjddlMQQkxe2F4WZP66u1xGAY1Df2GKFMEzQcQ/7vWCg0pDDAXB34a5YVvXgcZb9gYvkZEx0/Kckr6o/SlzHKYfRqxfHhhrOhOfuF3b0PD3AvbErX04TXeDochn7gSIEiY08yQM3LAU+34yn6xzc53F6iSdWl3jNm0L1R8n5ZS527OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3s4LXdEI1GIFGSY0m2VVWjdR1Ml1iONPpSDDO8/gEk=;
 b=gk42zIHfo/NFqjlU0u9ImrAYYqMirngxY+YaImX3hAUkh6/P3RK31e95d11dGBR6Vqc9gmPTS4j3I/ZOfj3wsD6ZSXtuKPzzKY4S9XL0BpF2tgBh4mvWkS8fqk99oBY7Je3baOtB64BKiei7l4lXATOahnFZQEJnURNxbj1WxdBAd3grQhKzql2wtCvleqRc5MY2uw6YlNi8HQFz2pfnfdvyqEjGqQ/BoFRv6eYqMnW9hpZxGADUVEg7wuCIBnB73kJ15GNBYgl1ZsYTedZCasjdO7Zl8C9jKhkOrQaWORcRRBSyrGuHlqdhF4qwzCAVXGsP1QfXdcyIrXmqZTjeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3s4LXdEI1GIFGSY0m2VVWjdR1Ml1iONPpSDDO8/gEk=;
 b=GKB8A39dLE39j3q/IuOik6ixefNjmbVtEaChW1TmkVta8Q0cPY6fzsYisBQwfyZXJoMUeSt0vKL/JDB0pd14XlSv/qARCAD1DwB9/alBL8C0ojqN3pOxBwcc97kmfP3oraslHIiPNQCp/PxmgOYHCgTkpEAQ4h+4tdrWnGEVw04=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH0PR10MB5306.namprd10.prod.outlook.com (2603:10b6:610:da::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 02:23:29 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5123.018; Wed, 30 Mar 2022
 02:23:29 +0000
Message-ID: <9be86359-e74d-6283-c088-ecdfe329930b@oracle.com>
Date:   Wed, 30 Mar 2022 13:23:23 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk> <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk> <YjjP5ldCCGYqD+UV@slm.duckdns.org>
 <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:40::17) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdcf80b5-8f92-41c5-0b43-08da11f4471d
X-MS-TrafficTypeDiagnostic: CH0PR10MB5306:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB530655EE86A73BA0612805E6B01F9@CH0PR10MB5306.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGa04OtKzJEywCffRc+Up3lu23mB0IPCGZ+YV/NsBhqSsnhX4kpD5i+4+ZTMZ6ot1zCsvYEs2Z7XEgRHkdtIs6MWx2R165lpHCQqK0ziolX4f2QXhHAEO9MLmWpoJyp2LiSU3PbRSjKuSSBKV8JaSXDrR+yk6BNv+6eaveDqAIBtquGkXnxiYV9tlVgXT2z59xBEpraP2iXK9l4fxZlEKOYsrObuYcUIIBEJ3ejhDMsxp/3l2GaxssEJ9ebm9Bva16DauhJLZCQj6kqWfvXxp39Kjzh9I6f9m1pWQP8+6SjIRC4kj+dEF9uVLQ61AoiHqlQU22hO1XOmqDndrY+BxcMhBgRp33I6U48N1gGqfUUR+OzidnrUFyDiOHtl4y62hvHKHZTSliBYjOK5sJtTxG8YCVwKdvDg46yfGK8mm6r7PDYjdQS+sKAFCTRTDyYpdfJVr4a5ug099+ZM8/DozB7dOV7xpMOWB3eO62ykmcYxnSebh2CjMC+UKkD9JxoNQKM1TeUT5cSuj7EehQ+u33GBncUVVzk/y06ykKb94Zb65NHyJo16f2bOBrCmr9Dbp/YY2i0dWtAvMIffjiPC85HDGiUf/KiwO9r5LnkmP8xzjf5DxTw4KACVOhMahIbC3J4TKQbYRcHm1zb51Id94L5VDrEyuyGT2zoxVikzXXzxDRL0Z+gEGQtbugb3857zJJ3p5ORYf9pGTfN4V/qmU/VPGII2TlL02r6pWU8gIXW7DQTG2Uu9Wbk4oXPXrNaO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(38100700002)(6486002)(6506007)(83380400001)(110136005)(5660300002)(6666004)(8936002)(2906002)(53546011)(31696002)(4326008)(66476007)(86362001)(66946007)(186003)(2616005)(6512007)(26005)(316002)(66556008)(31686004)(36756003)(8676002)(31884004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1OT2pob2c4aVZHWlk0NU1PeXl1MnllK3cwWEZhSDZNbm9Kd2RmTkwvQTl1?=
 =?utf-8?B?djRLbkI2b1dzdUticlNJc215Q0x3V3hJR08rL2pyQ3JaMlhKbkxXL2czNzRq?=
 =?utf-8?B?K2JxSmRzWmlIMUNIaVlIenNpdHd1NGVlZmJKVCtRM3VvazBnd2NlajZrMjZi?=
 =?utf-8?B?ZlFUSit1NzEwS0RxZmc3KzJHMmw2Si9PSnZ5WU50enZoU2wyZmJmTTBISkVZ?=
 =?utf-8?B?bSt0NDVyZ01EV25STnJWVG9NeWF6QTdmeXc0WjVMb1FUYlpBblV6QTQ5Z0pm?=
 =?utf-8?B?U2ZCa1p2YUdYWGt5TUt1YjdmaWF3d3ErczZCNUJOUS9JTlVDSWY3WXE2SWhi?=
 =?utf-8?B?ckI4WEFJcTBFMjIyTW5iazNLOS8rS2xaOWl3ZEJzdDhjbS9DZU1ZZjlZbXlS?=
 =?utf-8?B?ZzV1RVcvdTJCcnhKQzFydGdOSWVBUDQ3MlpQQ1ZRWWFOdGVNeEdCVEg1bFk5?=
 =?utf-8?B?Z0srUGZUUVJyWWQzV3g5b0U4VHFiMjhNcGMxRktPd0pBbnBiSjE1bGNmTm9w?=
 =?utf-8?B?WkNjcUtiMG8xOHE4VTI4VG5GQWxIaWhrYnM2TTZ2eUVlcTlUb0JVR2pXMkJt?=
 =?utf-8?B?cDZTbjZxODhySVB4T0NMcGFuTVdBM0FhakZpWDI3RC8rQitRZ2pVMzhzb0U1?=
 =?utf-8?B?NlRrYXB3ckZVcTYyaWgwUFpBSXExREZaNjJSZURaTzlaSW5rZXhBZ1dlUjBQ?=
 =?utf-8?B?WUlIeG15dkdDa1YwSC80UU1oZnJoUE1ML3JYOWQ4dGoxbncrZnlxM09NdklY?=
 =?utf-8?B?dU90c0c3M3k1WWhNQlNISXV5M2VIOWttQ1J2MUgrVmJkeElWUTVjTzE4T01P?=
 =?utf-8?B?ckEydnRWQUd1MnBDZzlQRE5QeTZrclNwV0VjVXFoUjFJZElCZGVtM3hFbU5N?=
 =?utf-8?B?akpzSGMyY3hIUmk3Q2p5TnRRNEY4UzV0Kzh3S1Vkd0RzMll0NUo0aHNLQzYz?=
 =?utf-8?B?V0NZek0weFJFaWlpSm41MHYxR3Rza2ErdThtdkZpbHhHWHl5cTl2b1NyZEdT?=
 =?utf-8?B?T09JWDN4ay9FcmFwNkRnT2VnV0RzaVVBN09ZK3Bnb1dxQXZ3NFFldVVpOTFI?=
 =?utf-8?B?azc2ZUlxTkgwNTR3S0F5b1N1N2Y1Um5HcWpvNDkrL1EvNTJDQW93TVR0d0Z5?=
 =?utf-8?B?aXdyRGJYQW96cHAzaFpjbXQvT0J3THcwMmJ4UUdXY3R4V0Yyc1Q2RVlicTR1?=
 =?utf-8?B?cUFpZTc5MGpuUHBMU3pSK3I1RjR0YWxJR0pxVzV2dmhMTjdCdU1CandYOG9Y?=
 =?utf-8?B?TlJjMG9YOUxTM2VLN05YTklsdkhFWjVDekZsT3VXeUdIZ2hlWTd6akwyRDZs?=
 =?utf-8?B?QU5ZMVZRVER3Sm92eVBkSWRENU5yOW96UVZmKzBoaWdpVE9rd1hadXlnRklh?=
 =?utf-8?B?bEpPQ0txMFhHUmpKa2NhbVBDQzFkUW9yYlR0dU5HZWtYUVEzVjlmQlBEK2pv?=
 =?utf-8?B?K2lEdXlFVVJKVWV6S3EvUFFpQWpET1BtelN3elBQOFpUQWVpM291TXRta2V2?=
 =?utf-8?B?aW5IeEVXckxwUTZvbTJiVmNFUmJPQ1EwcjBBNWI3ZW1IV3lpQkpjdzc1ditW?=
 =?utf-8?B?RnlXUCtMbGF2NzZsSnk2dmtzTVNMM2dRRzVnNDZ3bDl3c0d5ZjQxOFcwWitB?=
 =?utf-8?B?MWpmN1kvSkZqU0NIbkNsQjZlK1FrVnBQTGJYTXJrSE81dENCWnRCTkJWYk5R?=
 =?utf-8?B?aHRua0h1UEdHNlE5d0htYXFJYWRoVERmUWpFcjdzRjlpTWFNTzJKYUE4V1Ir?=
 =?utf-8?B?NFRsUlU1eGZpYkF2V3RTUHA1UWRTWnpjczF4UG8rSlN5ZmJWdUw3dFplSUpC?=
 =?utf-8?B?emhwMmJKYytESktJc2llN1pOZSs0eW5VM3BCMEhaYjJkem9pY0NEMFdlcGFk?=
 =?utf-8?B?b2FxUWN4WnZJWFlXcjhDTGxidHRFdHBhYWZFQnRVL1FZNENTc21XM0hUbG1h?=
 =?utf-8?B?T2JUd0NFTWNNNTVPLzNmQnpFaFJVYnFMcitzbTdhaEdmNU9MWVlIYWttalh4?=
 =?utf-8?B?a0pxYmJ2aUlGV0s2Q0hJbE5vTjVSc2RqOTJmdm9KeStRcHNRVFI2TkppWlFx?=
 =?utf-8?B?dElORzBKanlWZDlPYXhTRDFDVVRzZjdqU2dCaENLYzEwNmxSSXhMbGdyRXNY?=
 =?utf-8?B?czdjR0NFZGdaUVNPOC9Cc3RROHpPdDlqU1dib1pWWGNCOXZtUnI5T2tlb1Ro?=
 =?utf-8?B?TEdRRWZmZjhCSFZybjRtV1hyUkJteGVVc05hMEx3czBneDFhNm5QTG0yd3hx?=
 =?utf-8?B?UFYzSXo1TW1BMkhWUk1hVGpsMmVLbFlJSDJsT1piSTIxVVFPYWI1Wlg3ajYy?=
 =?utf-8?B?WGxzSDIrbDFzRVRNWHJydDlJckdCVFlqMzhHL2ZtaGNtcHYwc2Z0L0ovUjNv?=
 =?utf-8?Q?SqdFrgLkAUdY/1GY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdcf80b5-8f92-41c5-0b43-08da11f4471d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 02:23:29.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RH6jxjteUFtnqtoiIprXfjt6myjBYrVi88gNkHaRCZMrDu1kkRScG4WbjmtLsbUvT/mX+VejfaXokuAfFV+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5306
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=965 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300010
X-Proofpoint-GUID: xuYrBaND310qzPCMpnM6Dt24-irXuCEn
X-Proofpoint-ORIG-GUID: xuYrBaND310qzPCMpnM6Dt24-irXuCEn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al, Hello Tejun,

On 22/3/22 1:40 pm, Al Viro wrote:
> On Mon, Mar 21, 2022 at 09:20:06AM -1000, Tejun Heo wrote:
>> Hello,
>>
>> On Mon, Mar 21, 2022 at 05:55:53PM +0000, Al Viro wrote:
>>> Why bother with rwsem, when we don't need anything blocking under it?
>>> DEFINE_RWLOCK instead of DEFINE_SPINLOCK and don't make it static.
>>
>> Oh I mean, in case the common readers get way too hot, percpu_rwsem is a
>> relatively easy way to shift the burder from the readers to the writers. I
>> doubt we'll need that.
>>
>>> kernfs_walk_ns() - this is fucking insane; on the surface, it needs to
>>> be exclusive due to the use of the same static buffer.  It uses that
>>> buffer to generate a pathname, *THEN* walks over it with strsep().
>>> That's an... interesting approach, for the lack of other printable
>>> terms - we walk the chain of ancestors, concatenating their names
>>> into a buffer and separating those names with slashes, then we walk
>>> that buffer, searching for slashes...  WTF?
>>
>> It takes the @parent to walk string @path from. Where does it generate the
>> pathname?
> 
> Sorry, misread that thing - the reason it copies the damn thing at all is
> the use of strsep().  Yecch...  Rule of the thumb regarding strsep() use,
> be it in kernel or in the userland: don't.  It's almost never the right
> primitive to use.
> 
> Lookups should use qstr; it has both the length and place for hash.
> Switch kernfs_find_ns() to that (and lift the calculation of length
> into the callers that do not have it - note that kernfs_iop_lookup()
> does) and you don't need the strsep() shite (or copying) anymore.
> 
> That would allow for kernfs_walk_ns() to take kernfs_rename_lock shared.
> 
> HOWEVER, that's not the only lock needed there and this patchset is
> broken in that respect - it locks the starting node, then walks the
> path.  Complete with lookups in rbtrees of children in the descendents
> of that node and those are *not* locked.
>
Yes. This was wrong. I have tried to fix it by dropping the lock of
previous parent and taking the lock of current parent before each
invocation of kernfs_find_ns from kernfs_walk_ns. However this does not
look feasible because we are already under spinlock (kernfs_rename_lock).
This limitation will still be there even after changing
kernfs_rename_lock to a read-write lock.
I have thought of ways to fix this but have not yet got any solution.
I am checking further but in the mean time if you have some suggestions
please let me know.

Thanks
-- Imran
