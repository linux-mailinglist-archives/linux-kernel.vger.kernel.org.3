Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83A4856AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241922AbiAEQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:30:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59092 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241912AbiAEQar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:30:47 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205FYG4K016108;
        Wed, 5 Jan 2022 16:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Covvm6FWkvxE1U1LYZ4F3QIib8ozhlzIbmldxDm7Q2U=;
 b=Mcaq7GjddjnLFTBzS7x5HyGfNsB4Ta0VF5bSXZiY4ku7k50WJ5vU9eSV2nOwy5DgquQ5
 QtJdv1IVf6wraVqJcM4QIayWin+7bV2Ouuz+SIygtkw15yctV8tC4wqM7LmxNSLjb2LI
 l4oZb6N9L5ypqesv47D36LAMOF19ar5HuU8HQr0oU0je7lfSVr8UQNA1Q6AMbADYp8N0
 Xou1p+f2vuZR/6i3MmDITlz1BTbW05o65ziQtAyXWq0Z3pVHa20nH0PVPJNJNG085ju+
 PjyzvB4GiZr7egtj7ESXmX9AC46WSCj50G0hQNr4y2TeJILWyNUPSAF8snmHVxxUjioM UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7vmx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 16:30:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205GNIq4084614;
        Wed, 5 Jan 2022 16:30:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3020.oracle.com with ESMTP id 3dagdqrsh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 16:30:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA7HOSWgbcoMWmLESo1JQnfXMjdfIREd1/IGMaN1xNO9tuxQ/RQZ8LyjJVgDptN0C2VJZHqFps3Q2J4IgYsvG70eNW8tvEJcBROPbZefsjkEd7s3cbhyKgDi5F420p1pju33/H69CkQbPiQg49vBoRAYpbIJVpxw3Em1ZtsA/xP1Mce2Cc2ffFs2XMnZmszjHJ4SEX80YwTYR9dr8Je8LRowxwj27foqgXoxYSQpASfR/FJWc7jE4PB9H970woJS/qI8gmqfVKR5rla8Oap/HHFJ1XIYnD6Jk/ZtASCJS/LRMX/CYYIN5AUl86g0DXbLylxnUgD1ix9bE3ljMj8dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Covvm6FWkvxE1U1LYZ4F3QIib8ozhlzIbmldxDm7Q2U=;
 b=D9edJautNpYRwZ+IXpihJp7aCSVHIG3Z3wtXyrjAGNaJgCea6aWxsIZfGxIuY6GNnyJNDtyDY05m1u9Asc3VpShcGF+xr93hHMYvRRugGarthdPDbPo4e9JxalegPCT87mhcvwc+fSUNzCcoCu0rZC+FcYIJVwN8U863/9IwfZoQ0/XKFrpDW2XiOy1TKK2HnBgtl++KmTeC2y85rMG9dzL8Nrz/DNoEfvIH6CpCqlzOGub1/sdymhyKHRo7DvEfpk4espqzjuxntrZkAIfNTRIXy+f8iSZ9pfUk5TOB2sva+UisIFbW8rQKDyoqKova5qnf/YVel4nDJmCJjcGCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Covvm6FWkvxE1U1LYZ4F3QIib8ozhlzIbmldxDm7Q2U=;
 b=On41Z6Q5HWy9wpW03gaEjMj0Ss0UdzqtiV1eQOKrOTdjkmHO3RPd7+sZ7e3mzyPuIG749xmCQ6qJ4/+yXHm25dbXv4rJsXJ3mo9WSBcZ+jVLnew3Aj3rJVA8WOBo1X1Oxr3ofVQhm8hdy3f3+0hKQnosKjd/5bZISCqf0Sk+FdI=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4400.namprd10.prod.outlook.com (2603:10b6:208:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 16:30:35 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::8d84:1f40:881:7b12%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 16:30:35 +0000
Message-ID: <075807b7-ea2e-07e7-2da3-6567c6429c71@oracle.com>
Date:   Wed, 5 Jan 2022 11:30:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] xen/x86: obtain upper 32 bits of video frame buffer
 address for Dom0
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <a3df8bf3-d044-b7bb-3383-cd5239d6d4af@suse.com>
 <bfab8ff9-9762-f90d-3f25-b57362f05b0b@oracle.com>
 <17df4307-ace8-8798-5bce-16f4843ed830@suse.com>
 <16260904-c1ce-dc18-224b-03a131a92007@oracle.com>
 <d0c84e65-642c-8990-49d6-c09d291922ea@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <d0c84e65-642c-8990-49d6-c09d291922ea@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:805:66::18) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa0f39a-7f3b-4ebd-786d-08d9d068b31b
X-MS-TrafficTypeDiagnostic: MN2PR10MB4400:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4400029B340E9DB5983E54578A4B9@MN2PR10MB4400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2K53S79ZVvORRGlAwWAVIf5Kq5SdLeF3t9gyjPXxHi6on4U2ZljLFdUJoXT9QzEJR/alU3MKJ0q9YT/d9XGjBcZJQgLjPuG77jay31Pqehlk3l7rk0W0+1HIqbv4mw1sCTrff/xKFKEOOdSqTunRLI2c3bzKgjCRmL2nl8MTd1V/nA/jH+6+IK6r3+ZAPOLtnejihd1otNlSmcOJl9UjCQcY8mHTCZbAFQka8C7moZvR2xiixNN+ROkH77AlkWvRq6gU1d1ntdkT+moP6z3bSfZhVQjC/uFOusTBAV2alNqx/rH+9cVGWCmX7T8Uw0A9ZQ3PMn+JKL34IKi17ZXDKjwLsDTJSE01IZ3oTxu+WZxqz9WEOVzPPjbngot5aZq3Nhyug36v055K/XzVA0K+WaTpvKaI/7+/5MuN3StTv9eNxA4z5FQ9Cq4d/yc4/Sqj9muxwPeHJ+pUBdPKA2Jnzaln6HEIge5kMUGo+k8nmn6LfFzIHajLKCMctwaRdreDPuZDR7TO8fj7Y9us+8B5ltslrCLbxn3bqv+aWxqHe6HclBTzLjXXedXIQsENUUxP5AJIkK1oAarsYLehYfal4yFqddpa1i9xItlMisg/glOY26JrbjdMrlfBmkodSalfgQxg+ajFRn7nfWfSNdwz9aSadWTlAXOy8erF6UAj1HvH9pb8zVvdxmXdmYx4NHXVc09vyptdMaZzbzrahP4QxsdUjKHzh0dkuRHiidLccs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(31686004)(36756003)(508600001)(2906002)(6916009)(8676002)(6666004)(44832011)(66946007)(2616005)(8936002)(53546011)(558084003)(316002)(38100700002)(6512007)(6506007)(4326008)(66556008)(186003)(54906003)(5660300002)(6486002)(66476007)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0pVa25OSlArTkF6dTMybnlQcUtneXFucUxUYVhyQ2RKbXRqbXJIbkMzd0RG?=
 =?utf-8?B?NGozdkJKU1VVR2hmbGd2ZzBPaTB6K1JBcDdGay80T0lvN01wQlA5bDk3eEVS?=
 =?utf-8?B?VWNoQm1MQVBDSy9KQTRjbmdnbTJndENWdy8wbkpYUDlaWTJsTW8wUTZNc3lG?=
 =?utf-8?B?NzM4K21Db0phWlZvY1lYMndXYWpEM2p4RnFqczkrNm54RlFmRE0vdWV0bC82?=
 =?utf-8?B?VWJZRXllOFpUa2UwbGxUZ1UvRVVvbTM1emFtNS9aaFc4NWx0azhkcEtNM0M0?=
 =?utf-8?B?OVNNaDRndXdlSi8xM05nTzVLSlNaTXBRQ2ZYcWdwcGVvTmlqNG1kc0Y3TlQ5?=
 =?utf-8?B?d2VLbkUyUUx3QjExSVZIUFA4OUxXT1Njb1JqdWM0bDkwK3VpSFkzMFN6ZEta?=
 =?utf-8?B?aURFN0ZBMmI2K3kzTDRnNTdtdkcwUnR3MC9WMWpzanJ1YjM0d2hwcWswZkRN?=
 =?utf-8?B?VnlhclUwYWdNM2x6NDV2U2tTeG1NNGQ1VktzUkM2N01GOVZtZ3VlOWlRc25N?=
 =?utf-8?B?VVYwazhKVHJ5OHJQbnRJcXArcWZoVEhKRzluSnBwSGdQTEtCQ0phRUFvMEhk?=
 =?utf-8?B?SnlLSlo2YUJ6WnhSSTJsNnVxUHBERTlOM0o5Q0pMakpTLzZUci8rU3hSTWFk?=
 =?utf-8?B?UGNNMVI3SmhMd2l1M1lnTXB1UDlkS3RJUFNIVnBDTCs5YWd0L3IzcktnZi96?=
 =?utf-8?B?WXluRkkxcFg3QkNzR0pNUnZ4a3BKNnlHN0M0aEkxcUR4Yld0ZDB0aDRCWW5L?=
 =?utf-8?B?RnpEQ3Q1RjBTVllDRVBkYWp1UGRhWGNYTWVlYlFOQWppMW1VYzMyNjBjZGdv?=
 =?utf-8?B?bDh0V2pMaWYzTUhFOW9sQ1JkaCtVK1JEZkJkWUZFTENxdUJOSDNBcW1DNlVo?=
 =?utf-8?B?SVZXUUtPSm43bjJVVHFxbjltYkYrcjZBUDNvUENWV3BsbEhGcE1YTkhpbGtK?=
 =?utf-8?B?WU1DcUNsOFNqRERnZmV5VWdFQ2ZjaXF1M3pUM2tGWXhJZUwxMzNKeFdqYWll?=
 =?utf-8?B?OHdpRUw3empPaXpSbTdTOGh2K1B6cWI4N2RwdDNHbFNxN3pwZXhmWUljNTVY?=
 =?utf-8?B?RTRpN0c2OXEwMnB2QW52QnV3WVRLMGZYSzN0bzZYa281L3lBUkN4N093NThC?=
 =?utf-8?B?WGxwd3BTRFd2VG9WdHpQYllYbXV4VGlZVWExUDRVM09oRkhYd2hnY01ySWNI?=
 =?utf-8?B?UmI0VFp4Und2RmI5WlNHME5iSDR2SVJ5WGFsQmp3djM2dnl0RjMxbTlQWmYw?=
 =?utf-8?B?L2Nwa1JRYUNUQ21HbWJzbFNLb3ZvWE4rQk1NQmVFdG9GWTgzWExyL2NWdnhK?=
 =?utf-8?B?dVd1WDNwbzRybWkydWpnNUE5K0RqVm9Qa2k3VFlkcXR5VS96eFVzeHVZZ2F1?=
 =?utf-8?B?TDE5ZmdUbG9Tekk1YWVuU0dTY1lnc2FpSUFxdUpGMlhQTk1DZXVONzY1TjlL?=
 =?utf-8?B?NzNLUDlGTDVoQVV6YWRMbmY4Nlk0R3h5RnlrRUpKaE0xYVQ1RGRvZ0orL3ph?=
 =?utf-8?B?SHJLN3VZaEt3YkVramRESkF3djg3RVI1RkppaCs0SlUyQzhVVm5yYTN5YUVo?=
 =?utf-8?B?ZHhjT2xadnJmekVpcnlxeS9XTXloVjZRU1o0RWdwQmN6MUR0Nm1ML09EWThN?=
 =?utf-8?B?SzRlTEpwN1oxQmRwNXVEclJmQWxjK2FucnpFTEpjcmlrM2RXRGpvQkM2Z1hk?=
 =?utf-8?B?QzBnNWM1SkJ4bjdacFFBV2ljSkxzZXRtNGp3V1lQeEUwVW5TMVV5NXU4QzVj?=
 =?utf-8?B?aVlZc3ZHcGQxbndwZXBUOFFuZWVtZXJQdHNaZU9FRHI1aFVhRElvSkUxMDA4?=
 =?utf-8?B?QlNXSkZodVFhMHNwUFZtcmcwWCswYm5WSGtqWVRTYnpGOG0rR0U0YkV2Wk1U?=
 =?utf-8?B?UGFFYzc5QUloYTduMXZ5ZlN2VXRsaFlIWWcwMGIyTEpvZnllNWVpTUNVOGNB?=
 =?utf-8?B?S1FCQ0FvaHc3WFltMk0yM2VLUlhqOWlZOTM0QlhSTjRod1hhdXZzdU1Zejcz?=
 =?utf-8?B?RzE0aTVVZHVCTnFacFIzb1N1Rmlnd0hrdTl6WTNlamphbEErN1ZBSXZLd3Qy?=
 =?utf-8?B?UlQ3RU5lSEFNUjAzT2RIWWlJOVBEQjVsOTJVaTFNSFVCMjZZc2RsN0szd2Rr?=
 =?utf-8?B?VUlKekg0WWpCeU1PZDFtZ3p6aGwyODVCbXdIOGpRT3dVNXNmYUNKalB3K1ZF?=
 =?utf-8?B?eFdBTjI0cU1vYVhsSEhiSWd5YnpsQ1AyWS9NaHUvZnBBYkVpTXlZaTFBSy9k?=
 =?utf-8?B?U3RoRDVkdWFRNkZjWkpaUDBXakVnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa0f39a-7f3b-4ebd-786d-08d9d068b31b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 16:30:35.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smBBlHGPes4hcanpCUuCGNl3yMgSU9JGawSer9ZwHwJK/HtmwFRwpOveGRy8X2iEN7naly20SUll4IKxtd+V8EGBwm1Z7jRxddvGXBdUAPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4400
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050109
X-Proofpoint-GUID: 2pvz04knUZ28jswHi-2o-TCafAiu3C3l
X-Proofpoint-ORIG-GUID: 2pvz04knUZ28jswHi-2o-TCafAiu3C3l
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/22 2:59 AM, Jan Beulich wrote:
>
> Anyway - I'd appreciate if the patch at hand could be taken
> independent of possible further adjustments here, as it addresses
> an issue observed in the field.


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

