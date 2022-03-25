Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC71D4E7D60
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiCYTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiCYTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:31:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0AD2CD81C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:06:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PHaWXv031145;
        Fri, 25 Mar 2022 19:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y9C9VDdO68CE3il+rGCD8ExF0c6s9J7HTKgjJ3/EeY0=;
 b=d94uBc0A9fgtSwK1umDI0XzvL1nzueJ7j8mMUm6c/zjOweAF3o9BXra3yA012JYLfcp2
 g+1o2WsWNoZETPut0OlLndcA7RR/X0cIM/bI3PvUPA7GJSzMhiXqDYOSTh0Ph6TclSrn
 NDb1Dqfqz2+oh98DupLEqqY/3rmc6ZBd/YsGqrEdgqhI/qE7tQJlJB5cQ0DcnFXL85y+
 +D/+DlOiHC2TdS5+nBInoSCE4V4C2gB2Zop9BI/NTLWQdn/nxh/m5Vd6VDHN0RRINTHH
 1QWf53RLwK5uRxCdMyW8XXB+Jmz3od43sVx1knCd374atbP+qZBMK+q1SmJi6/c5iARW 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s10431-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 19:06:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22PJ0ppL059209;
        Fri, 25 Mar 2022 19:06:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3020.oracle.com with ESMTP id 3ew701w8fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 19:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWcbTEo+MPIbgpBn5qcl1ZGN3nprzyZmOQuaKXEVHEcYgV/onablWjVEjie/7ROI9b4HwNQ/letzXBvP/6fxn3tAOpxEDyVwJfS83WEcvNlVpMtSNLcCbpXSd0MVRcu7G7UOTdDDLhDKjQ7v5XYw/QXHYESsG9a7lORJudy4PAU4QmOCZwvZQOrROnd10ILjDdGUUkA9VU3FmI+S7OW05kLs1I7eOCMXxQwUO7R0fHh/jjAAZXgSs7SZ9s2aKpfZ8LytwyrYLKQ4aYVv9zEVwE5+s75mF5iXTpKYi0P5aGP7aaeiPI+uYVTQwNKmA8RrtWqh5A/p1IsnonSd5BDC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9C9VDdO68CE3il+rGCD8ExF0c6s9J7HTKgjJ3/EeY0=;
 b=DVWDfpzwygMCIq6qBFSg1RwAhqwesF0vNfJkydUx5Amq0TmQYwWae31ROUlAmFxf2C4iYDBt5Dg0is1SA4JBI04Nomi+hFQgXmoVpgnbVCtxIJoo+mReEIlDRYPqMPA+Zb7z4D4xx1KmPZOaKk8EZelXlStxM49UAvnsFChPyJeLcH8cHBqPQor0WxHiKz5plSu+/SUKYLVl/FQc5XELBqXrNxYCl9nsTwmx48gjv6T4upzQ8k5W5+15QF/fl+t1Oa0COIGaOAGvqq8HZuRMPvcg/NRl4nz1dHwJgmDXeLVU1mcsUG8oR8fatjIcK7qS7nInfgWd/Oj6F9P/8gb5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9C9VDdO68CE3il+rGCD8ExF0c6s9J7HTKgjJ3/EeY0=;
 b=JF/sZ75K53kYrBI23ZBiGjDB51ayKOvVb0C/KpPMGKvmRymyKBMffJAkvVVpGyeEtxrVHPxZeHO0oqZCzi+Yi2T00YTC0AEGkmHsgpKH9O3o6hoZdlMwI6IrASWW3d1J3mVadtXESMPgG1A462yGyoL1wDnhTBK2ME7vgy5jsxU=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MWHPR10MB1328.namprd10.prod.outlook.com (2603:10b6:300:21::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 19:06:13 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::694b:b7c8:a322:febe]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::694b:b7c8:a322:febe%5]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 19:06:12 +0000
Message-ID: <6e69959f-ba30-e5b1-c096-c81ffb3a6ecc@oracle.com>
Date:   Fri, 25 Mar 2022 19:06:03 +0000
Subject: Re: [PATCH] iommu/arm: Expose ARM SMMUv3 related registers via sysfs
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Miguel Luis <miguel.luis@oracle.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Edmondson <david.edmondson@oracle.com>
References: <20220323125500.76684-1-miguel.luis@oracle.com>
 <baa516fe-23c2-fafd-d440-5d57852e6b50@arm.com>
 <F26C04FE-9A03-47BD-9C2E-C546BF4EF3AA@oracle.com>
 <03df9921-49de-4a9d-1ef2-c5d191feaae8@arm.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <03df9921-49de-4a9d-1ef2-c5d191feaae8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0299.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 808d48fd-4451-40d0-863b-08da0e928742
X-MS-TrafficTypeDiagnostic: MWHPR10MB1328:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB13281E81BB645FE210D79998BB1A9@MWHPR10MB1328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VMYh79lvYx9zHNyop0zrBnZ58uJn7MWWxtMj7NDLElvVK7HD8zuMbXhxUK2yEaw6xrFzOpKA/3VJCY72pW6rJSesGLMbpVFCp+fpwEa6le01Azg+BE52DXsLP8i8AC+UAlvJFhTBq6/x26pEOkyjffRmkL6TOUDHLc9JQ0CjJcc9U8EPI3xokmdZRJg4w73xLkGuqUYt5nw0atMa92eFdSaqT9gEHvhIkR71+uTU+3YB774mAKYMJsnux+7CBHj4WiyW/g3uFs7DX69tZg8MizAt7r3tlpWvpYFol5jxjzRiKY+dAebTE2Em+RFg5HAOd1ngnelSwCu5eaZgffBcStAMrYb7cHWbxWBPkO4aKCc7Qa6suvdSIKtcout7jdDo/w8IhR+hE80Y9YnykGbj/EcR4JqLKD7CjEXIW6q9VfYfwdgDCXxsj8hYvfTNNuo/9POr9Tt3xmZ0Hk8Hsya0n8+Yui2Ye89hPl1zEYsBYGAWVv1qPFcw08jzFWet5S2W8MER1/lyKqfipvjlIQo15+FDYIhuuu4FirrqvLVLvfsbo4NPdOBjdqIOV9giohfYeQUEh7vK/A7bj7FXXQ2JwoltIcGGQyCL71hnYQdyGEG30OEI26n2cSULtlVGezwb0Ph56AT8XyG/5K9Le2bKzwWRB4fuiZqijA97nnTHOlT7/kh9zl0hWUOrbXXBzV2NvXMdwF4bWiIH5GGYlOY1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(8936002)(6666004)(83380400001)(6486002)(31696002)(107886003)(54906003)(2906002)(53546011)(6636002)(6512007)(110136005)(36756003)(6506007)(5660300002)(86362001)(38100700002)(316002)(31686004)(4326008)(2616005)(508600001)(26005)(66476007)(66946007)(66556008)(186003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW9wNmJienBmaTdRNmhhLzg5ZHNrUkpoWjhiUURHSGt1QW16TEsyeFU3Slp4?=
 =?utf-8?B?VjdtMnFqMFdnMFk5OFVMLzdpWXAwckhGTWhYMVd1L01DVVRlZi9Ib0wxU25s?=
 =?utf-8?B?R1hTQ3dSWFg0Q0tCaDBpdTFmM2YwSk1hZzVXMERyeEhWZ2hFQVdqT0lFbDlr?=
 =?utf-8?B?czZldmthWGdIT2UvWUpXWVVtT1JuQzVWUWVvSmFjUW82QTdPdEpGNzdlSFVw?=
 =?utf-8?B?QXh0VmQySElyY1hER0dUSjRXOG8xc2xadi9tYlFrN0ZXU1laeU5EdmE0UDZj?=
 =?utf-8?B?ajNPMmJKaENpZFA5RVAwMFZWcGUrWnRJT2JoTG12Z1VhSk56Vll0UkZWWENw?=
 =?utf-8?B?OGdPeDBZTDltSmhHYi95bVlpWkZDQ1hmdHJNMm4wSVJaSHlmU0tMWWUrbWRN?=
 =?utf-8?B?WStMQTd2enViNjUyQWtkeENUbEJBZStadVVBaUdUVFQ2TU9CVWhicktqY3dF?=
 =?utf-8?B?NDNrMTRwQ0VCSHY2Z1VaNjJiUVBLOUhsMXJ2R1hjMWxsazNwOGhIWURDWUg2?=
 =?utf-8?B?UEJndjB3UEFGWmNiTXZDK2ZmYUxzQlc4N05zTFhxQ2JjaTlKVXhheC9WUFlI?=
 =?utf-8?B?L3cyMis2ejJhT0ZkMzhOOHhjN2xXNjI1d2lYeXVrQmoxdkM3cnRWd1gxTCtv?=
 =?utf-8?B?UXh4WFRvZ3BYc0kzdC93ekV1MzQ4OThOdkwxcmYrQjNoallUVWZDM0tTT3Yy?=
 =?utf-8?B?Z0Q5emtRY2xYSkp6WjBNUzJLTlJ0c1ZpOVdaWEVPd0JBeUhhZ0NnSHB0OTJm?=
 =?utf-8?B?UTZleXg3V2NNZU1YUnRSU3FnN1d5WEYvNGZycFYvVXFzTVlEK0o5emJnK3hE?=
 =?utf-8?B?ZytWa013MllwSXF6QXh3QmdQNGVvTVlLRGNqZXhZUjdoQjNjWlpkNHNWN3ZU?=
 =?utf-8?B?RUtUeW9rNUQxVkQ5NGJ3OHVlNVcwNHdiM2E5Y1NJVzlzZGxjdXJoaFhic3Rj?=
 =?utf-8?B?amhJNjB2YllTcmx6MFYxdTZvdm9kaG5WM1ZaU1NqTGhaS2h6L05NMm9Oc251?=
 =?utf-8?B?Ri9mMW03VExMYjE2b3FGWkVVWTR2enhVREFoeWxtODBwTXlXMWorMW5TbGhF?=
 =?utf-8?B?NXV0eHBlc0V5OFkyTDd3SnFDekhNWjZKQytXRnlJQ0hSancvTTFzZzVPV2h0?=
 =?utf-8?B?WThHc0RtRndNMWVFRTN5bGkyZzZCREtJOG1ibldkd3BkekZSc3dlYzZXcEhw?=
 =?utf-8?B?V0pKM3pXaFBvcWk4cmcrU3FBY3dFNStIZjF5RWV5NzVPM0h6M3hiNlBLaWRz?=
 =?utf-8?B?eUJIbTBLMlRuYmo5WEFzOUc2NHVkbHlZTlFsQjd0N0VkZ0d5a29rWm8zajNZ?=
 =?utf-8?B?dlN3bzdZR1h0Yk1nYUtDQndRVEtOaW1pK0d2ZWtDUkZpdlpyNDBtbXBwYzBN?=
 =?utf-8?B?RWw5V2pORUQ2bDRISlVES0NCcnhZQk93ZDd0UElJSG1sdEFYUDZnZW0zbDNq?=
 =?utf-8?B?R0REWlUrNVpKdVRTZEFMTWNwamkxUmdrVGhOVG1BU1p4TEJJa2ZHK0Nibmpq?=
 =?utf-8?B?MnFFQ3NBNlN3eXdYRmxHOXdiVXlNS3EwblRtZVdOK3NKRjMxVWVsRFR5YzlR?=
 =?utf-8?B?MVgrbWlJVEVKRENBRmt4SUpRUWl0TEJ1WklibkZvZ0dEMWpXNDMzTzZmdC9E?=
 =?utf-8?B?eFNSalNqNnNlQVFBYUI3RXV6Tk8xNHQ5QTBRbHlYL0VSSzVEZXAvMThvWUJ3?=
 =?utf-8?B?ZHdJcGRUNEV2YkFpVHRPR2lnUzg2ajdJNjJsL0VtSUZJaE4rM0ROd0dNdTll?=
 =?utf-8?B?eHhHc3R5bS9rMktHK2xJQzhGZlM4T29BYXNOd2k3aitLWVk2VEhIZXpXbVVB?=
 =?utf-8?B?aHo3REJxRzNob2JrZmVuTHZnL214d0RGcHZ3R09FNGRLbFVLZk9EUHBoZzBr?=
 =?utf-8?B?ckhvZnFFYWsyc2hJcGE4ck8wT1lzeTd2UGJjMnpjZWxmUjg5SFlmNDZYR1No?=
 =?utf-8?B?cHF3aW81M1B0M3hlWTM4T2l1SjhYcUkvUXhpazFCYytpMTJkeVhtU25QcURh?=
 =?utf-8?B?VzhHSDQ2VDZGcUc4bG1zYTh5elVQcEtPR2V1YVdSOGRTK2tGL056NlhjNkhB?=
 =?utf-8?B?VWY0NFlud1pQbTY2Ti9iOE9jbjlQSTAvU3dNOFJPcU0yV3ZSWmI0aWZpK3Qy?=
 =?utf-8?B?QTQ1WlpFR2J0RndaTmRTSDBQNzUzcGJRamdlSXJnS2czbzNkTHBEOFAyTk9Z?=
 =?utf-8?B?QThiRE51ZklWY1NnKzB3MnAxN1BqUDNOUFFVRXo0b1A3b3ZkWXh2cGZiK1Zu?=
 =?utf-8?B?TUxBQ0pkTi9CMnpQbFliektidkZVWUdUTXJmQ0g5cWQrc2xQNlNWV0c2a2FI?=
 =?utf-8?B?MFYxaVRvUzVwN29FSG4vVG85MU1qdkppU3N3bDY0ZlRYbEgwTERpSWhrb2dT?=
 =?utf-8?Q?+TPjSbYn8wCFMxp4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 808d48fd-4451-40d0-863b-08da0e928742
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 19:06:12.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: www2qPkAFQJj0b3PJJBoi5zHZAtry0vsLm4cHXKeTVtFCXdtrJ/sRJfgC+1zC/ipUjljplmDWzHvtqXdIAnwW/5AGRK9XhyQGvZhDVLQcrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10297 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=773 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250104
X-Proofpoint-GUID: wF8RoptlZCloM_QaxKq2og2lYdCGOMtN
X-Proofpoint-ORIG-GUID: wF8RoptlZCloM_QaxKq2og2lYdCGOMtN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 18:03, Robin Murphy wrote:
> On 2022-03-23 15:09, Miguel Luis wrote:
>>> On 23 Mar 2022, at 12:40, Robin Murphy <robin.murphy@arm.com> wrote:
>>> On 2022-03-23 12:54, Miguel Luis wrote:
>>>> Allows userspace to check for SMMUv3 features.
>>>
>>> What will userspace do with that information?
>>>
>>> It hardly matters what fancy new features might be present, if the kernel and/or the abstracted interfaces available to userspace aren't using them. Any functionality which is supported by a usable interface should ideally be represented via that interface itself.
>>>
>>
>> The inspiration was the same that Intel (cap/ecap) and AMD (cap/features) took
>> exposing it's iommu feature registers on sysfs. It's an easy way to understand
>> which features are supported by the hardware regardless of what the kernel
>> supports.
> 
> OK, so what do end-users of Intel and AMD systems do with that 
> understanding then?
> 
It's features probing and informational purposes really -- that's all
one can do with these registers regardless of IOMMU implementation.
There some others which print the version of the iommu that also appear
as RO sysfs entries.

Those two registers on those two implementations have proved useful the
last couple of years when I got new SDPs/machines.

At the end of the day some tool (or script) pretty prints what's
supported.. on what usually is depicted in very lenghty manuals.
And that's fed into a toolbox that prints all hardware and software
capabilities alongside diagnostics / etc (for troubleshooting).
You know, similar to `cpuid` on the x86 cpuid side (albeit you could
argue that it's behind a 'special' instruction). And that 'decodes' to
an human-friendly on what goes in those lenghty SDMs. `/proc/cpuinfo`
translates that into a set of keywords (which may be software-specific or
hardware features). And more recently `kcpuid` for raw-supported
features. I am sure there's more examples.

>> For example I could print the smmu->features and that would cover kernel
>> supported features but wouldn't help when new hardware arrives to know which
>> features are supported by the hardware.
> 
> Indeed the driver already prints the supported features at boot, largely 
> because it's useful for debugging. But again, what's the advantage of 
> knowing what you might theoretically be able to do with a machine if you 
> don't have the software support to actually do it? Are there users out 
> there who aren't going to update their OS *unless* they can cling to the 
> hope that a new OS might see the opportunity to use foreign-endianness 
> pagetables and finally take it?
> 
> I appreciate the natural human instinct to want to poke around at and 
> evaluate a new shiny thing, but a sufficiently interested user can 
> already do that with /dev/mem or any number of other ways. We don't need 
> the burden of maintaining an upstream sysfs ABI for curiosity.
> 
/dev/mem is an interesting alternative -- I wasn't quite sure you could use
the register addresses here arbitrarily on ARM. Anyways, I suppose it's an
worthwhile alternative in case it works.

> The other fact of the matter is that a great deal of systems with SMMUv3 
> will be using one of Arm Ltd's implementations, and as soon as one knows 
> that one can readily look up all the details in Arm's documentation. 
> Especially when one already has that site open to find the SMMUv3 
> architecture spec to make sense of cryptic register dumps, right?
> 
Heh, the idea was to avoid going to those specs all the time, but I understand
your earlier point(s).

Also, IOMMUs are getting bigger in terms of featureset -- so it would be nice to
better introspect what iommus can do (in the whatever mix of implementations)
in a less chaotic manner. Maybe implementation-specific sysfs entries are not it,
but hopefully something else in a more generic-way, in the advent of a more
direct interface to iommus.
