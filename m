Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B75257CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359195AbiELWcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357224AbiELWcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:32:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425138FD5C
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:32:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CKcLMX032663;
        Thu, 12 May 2022 22:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eHDRS2/p2d+IppeAp3yEQ934/xu7zKc0OsqsN5gBGxA=;
 b=xEqRMk02nws8EsEzHoyCdDx1NR8Su/VT5ouWgXDreKuF5D3lF06D6G/bXwOqiYHaxD7K
 vdMXGjEO+Dxo3uXOPjozwjEsMF6L9zRV1I1VE/ajCBYnHnVxned6+LWC6MzDDJkH2usf
 kEYKYH5px7XcLdDgllh1d3UvgGG9cTs4Z9pbbawvrZQ3bD8VnSA9gW/sr2ZDmZc1tSMo
 5mKB/GUuKIGhTbfhhTRmBOVuXrpKIRhNsGvgpYgJLv4awxq/MaJgt+2R4uJvKvJBmI1M
 P17juVWm1BCCkeigdDCpHYXC1Znuj8V0kEs7BZDc5NNuWxRYi59b3cmzVBPEmVohgRkL qQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatp68y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 22:31:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CMGSDF015038;
        Thu, 12 May 2022 22:31:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7cad69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 22:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFv+8K3VHc3xcTyCqXtgx0wHTFKCP0EHoBLSiFUStKRWxpQXSsmEZIUbiVkpx94N7NRKv3IOYKJaEGsRh2cKEtQQIATBNyuwiE1FOzsRj1XtCCR1Cacwd4HmGWCqJDVRP6QFXpV4mLIL/DylCkz93f6NRHnVBp4hoaaCtgTDkaQ0n7Dl4Z3G7pUKCmqL0X3sIeMivJvxY+nRPQ5qt2p7mytWd9sjHGMPAAzs6XFnWYCHZ+k8OhKswmXPHyBz0R00aYaZ05Ceog9HHNNwMurG7s9cfWydE8VNh0aKc+DBOkZ5DnmIY91h62cb2SIQEZyhNosGqynwSbQ1ieAkvfXlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHDRS2/p2d+IppeAp3yEQ934/xu7zKc0OsqsN5gBGxA=;
 b=nxl1NHES+wF0LBvZQUqlKGQon2x4FfEytnqKlgAfe8cQgXFxmD6wYYzkUcOgX01o7MdfjK2X4tOAM0rMZSxWoUjw9FVXTWY5XR35XHbs+aM3pp8WLbtc76070CF+ZzlcDw68i0waIOPZ8KE6/+i6hzZE4xUmLmfSoxsBWE3cW5zhMArbu+AXrahwJQEoXktqkRoxTgivq+jGizRa/3akShhgt09Zsu2PIEpIKXPwb1+cUOPVB7G/sIxY0XvsI8u6jjVJXc4nvTfUmYkRrBIkVtjQg9o9OScqMucNYgHVt3lS2Qbw0sqtGg9mWObbaOLhU6as59APq0KVPVtl99KuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHDRS2/p2d+IppeAp3yEQ934/xu7zKc0OsqsN5gBGxA=;
 b=mGcxC4adQP9gzwmZaalEKIT177l/LVVd2NF9OCix0aPZUcrRWaBVcTw1vCRTKe9SPi/84XB3+YJCDZ1TFZUd4Ax7CSrBvnr7TT6+VAN0PhKUkcIc+3RtRrUllbudvQxThDmAHu/ytxTwxr2OWaewL5vF7tIQOFMlIYwTrkTRni4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB2873.namprd10.prod.outlook.com (2603:10b6:5:63::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 22:31:43 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1cac:db16:e2f0:9c16]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1cac:db16:e2f0:9c16%7]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 22:31:42 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Topic: [RFC PATCH v1 1/4] mm, hwpoison, hugetlb: introduce
 SUBPAGE_INDEX_HWPOISON to save raw error page
Thread-Index: AQHYWe9USuViGfW1f02mOouabt5NCK0b7DwA
Date:   Thu, 12 May 2022 22:31:42 +0000
Message-ID: <9832f588-7d1b-edc2-2f20-da1990a8ab03@oracle.com>
References: <20220427042841.678351-1-naoya.horiguchi@linux.dev>
 <20220427042841.678351-2-naoya.horiguchi@linux.dev>
In-Reply-To: <20220427042841.678351-2-naoya.horiguchi@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bba00104-9204-4d34-873c-08da346730ae
x-ms-traffictypediagnostic: DM6PR10MB2873:EE_
x-microsoft-antispam-prvs: <DM6PR10MB2873189319975DB77F11D02CF3CB9@DM6PR10MB2873.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ewU/rWxyl4m/VTqqGCIoOphhy1tXkLnLRRcf6589Sf/RpuqrzRYIPZ8y0/FxGxCLDREN7zdFMwvzAI37R8oqjP2nB9N7xc8VDUpWJj8lFRlTFq1Ory4K+nSoVq+e22fq2e3ZzwodkRB5XGfEMCNmwCxdpjR2YuVQi4Ibz/QjUqCkWS+NvPOyHdv2onlh1Zzpx5wBRY5kKKO8E8PHSXbEvA2xFN+X10aHyAvsGY/JSjDl7Tt/xGf73YVQ8UPQYtivhEQ98Icgi1boSi94l9di28yK8/DhVaVju5rBpiKvT4Vuk284PxUn7oOdLxIn1kq3GvUn0crK8eG+loX9f0rIAvAGNYIf8cZ0863DW3IukBjcHhUs48Oea+qZSuSNdoDi/2ZMcva/04c4/AAh6WZLWY8RdUktNaor+baKhsfJRzfj+ZVM33RIgZ0MWBwYf0YML+iVVSVMUIQexnHmrEjCnebSDhIlVh3HmdQiPdqAC0MIBRF72Ch4ccK5+VLviiOqF0OCxjf8dEzHRq+cKlhQgUoTZv7ziAP+ykPkG9aOptehVQxKecF1WsXvpHx+71loNLUkxFPdQvQTWjVakNbmYIGAVOTtxF0VlZJ2ZVySf0n2gvknez2/DyK6rB4AzuMuvL1JeB787gX5PAe0Rz3orW82UkKUIoQdldgmKgAM0Y2x7n5/oM7hnfEmmhB7wllljTRgxk/muAjfCIh89duJWkDqMvNGyDhgFgeSXEfofnCu6uvAxs7uU9CwDy7O4flFHv0/ayEvV/C8o60SQsLMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(64756008)(4326008)(86362001)(31696002)(66446008)(8676002)(2906002)(66946007)(38100700002)(76116006)(38070700005)(66476007)(110136005)(6486002)(91956017)(54906003)(316002)(186003)(6506007)(53546011)(2616005)(26005)(66556008)(6512007)(31686004)(5660300002)(7416002)(8936002)(36756003)(44832011)(122000001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDAzZ0M4VkN1VTBZN2R5UFplblpFTWJtZ0tKUzQ2K2NVb2pGZUVRZFNHTXdW?=
 =?utf-8?B?QzNYQkZ2d0VRMmhTUGNONC92by9HOUM5dzJPMEc0VkhWNjJJejFyWnlrY09p?=
 =?utf-8?B?Ylh5Q2YrZSsvUlpFeWQ2VEt2eDE5NGhzbkhHbUFSM093Zm83dHRSeEhTS1lI?=
 =?utf-8?B?S2NGN2tDTlRvdTFuR2xFV0JMWkFrV1IzamhWU1UyYkRUVytRWmowUWlnZnNu?=
 =?utf-8?B?Z2Q0Z3hvNkFaYmEyQlkzZHdmU1Rvc0dNS2RkV2h5b1h5ajNDL2NDeDBxK09F?=
 =?utf-8?B?OFJHY1IrUkFlOWJxTXQxZmRnQ2wzUDFqWTNuckpFYi9NbkhDbkRjV2pRMXZE?=
 =?utf-8?B?MklFWjlhL1JOZnJJaVVZNkJkY2ZvQVV6dklWeDVOVXlRZStBWmJleFVTUHFo?=
 =?utf-8?B?QTMvNzMrZzJ6VisyZkpMUldWRjhma0x0UENzV3I2RzBGd3JHOFV0UzFNc1Rl?=
 =?utf-8?B?MENKVVFoK2wxYVdHdStYSStMRjdyMXorcXlmMCthS2ErQ3Aza2ZZOGxEbnls?=
 =?utf-8?B?TDF0NEpyQ3l3MzVKU3FTazdpbGdUeVRtWFpZdHVRZDFadit6UituaUt2djZV?=
 =?utf-8?B?Mmd5V0RjQy9SemtiTkZ4K3NVMzBEeENJaW5oc0szWjJqVFUxQjZNMmhMQ2hN?=
 =?utf-8?B?djZ1SEExNUY2bUQ1Q05uT1ZoMkFEcjROL3h1WG83VVJFZHNsMnZmaXZTLy9M?=
 =?utf-8?B?V1BiTjJUQ0hJdlBtamRrWWFFK3djVFl6YlUzREh4YVZHaDhjR1J2SGZZbWVo?=
 =?utf-8?B?NTgvaER2TTFST1FWUnZUM3RFNENsbUFzSnI0ZytJWFl5N2xPU0UxcWxGUXNq?=
 =?utf-8?B?eFFJeFljZmt5bTJTUUM5aHI2RnBiVndwdVEyZSswaitnVUpudFk2WWlTRXc3?=
 =?utf-8?B?cDlBZUd5VGkrdW9oVFhpcHM2WVlqRytuMmhwa3dTZnRDN0ovZ1JhMXlnUWNw?=
 =?utf-8?B?WnJlbTNpT1J4TGVHcWl2UndrR1c0VWU5NUxZSmF4R05rNDBpMmNJNGxIN2VO?=
 =?utf-8?B?a3ZRWmVJMVRxSzFyQldNdGFUNndycSs1eTJzREdFZ2JPN1JMMDJoZzYyRStv?=
 =?utf-8?B?NUpxUjJxNWRsMmNhNkltc1h5c1ZlQnVjVGF6TkxVREwxelhBSFM3S2E2VHRI?=
 =?utf-8?B?MytnbGxjbWNMQjcvNUpuajhiZmFUSDVMU0N1eUFNRGlZdDFaTGRRalpBcXpP?=
 =?utf-8?B?NVJ4cGxtR1FWdmYydS9iZnJUSjJ6R241dm1tMldtQmd6S0lNdEpoand2ZFFG?=
 =?utf-8?B?OHJIcS9EWGQyTmhxYlZqejJTMGZxSUcxYVVJWHVmTFY0K2t0K0hsa2RWRE94?=
 =?utf-8?B?MjJ2QkdqdENPQlZsSUt2dTlMK2RsN3MrT2RWV2JkemxoWTFGNXVDRnhFdCsz?=
 =?utf-8?B?NlpjZlFMeTJSOEJYTCs4dWdaeUdmK0tad1VlRnJDSmJjcGg5WHZtTUx3a0dp?=
 =?utf-8?B?SXExa3VZVmlncCtTWSt5VU5DaDZDbW1CWTkwcTQ2VDk3UU9sN0s3SncxMmJJ?=
 =?utf-8?B?QlE0QUxSdHhLNng5d1dubnpBN3VId0wwOG9EYkl6cU9janpJVWE5VzRzeVB3?=
 =?utf-8?B?bGlJc2Ewa2E5Nm9sZDUwWjVORUFnNlhUNExyODBqdFRzNW05dmxYRDZYNXJG?=
 =?utf-8?B?QittelhJV0NEemVRYTg5ak5PNEJxREdQSDlORTFDZlkxUEpxb0NPM2lUQWRL?=
 =?utf-8?B?cFRHcEk5NGVjMDhDZ21tZFhqQVpXQm5rbE01YkpCa2phYkFibVVoaXpHazNs?=
 =?utf-8?B?bkdLdXhmdTFZM0hsUG1BdmtJYzFOaTVUTDRHbHFNQXc4cVpzc1BoV1RDTUVO?=
 =?utf-8?B?SnBqZVp5d0JndWpkdG14U1BNelBSYkVMbHZkakZuaVJHWHlqQW02SGhGWW5t?=
 =?utf-8?B?aFl4VTM4UG44NmRiQWRHNGZ1YUtDNHU1WlRMTXltZksrSUpoYnBqTG10cksv?=
 =?utf-8?B?MDNhWWpJMjcyMFI3NEVEaFQ5bU9hZXdxaVFhenNaOFdIRXhzVDRxay8yR0R3?=
 =?utf-8?B?YUhTcHl5UjQyMVA0Q3lrMysrRnpWdDcyQkxUaXNyMlJJdjFhUzVFYzJCK1hK?=
 =?utf-8?B?aGJGUmUrOWJsR3lYVnJZeWkyK0NqMWRKSTdYektFWTI1T3NpVzdKOExzemVP?=
 =?utf-8?B?RXdkN0tjTmV0LytxaGdud293WmxIbGNoRkI3bVJKSUg4U0htVVgzMkdvZkw0?=
 =?utf-8?B?azFjSHVBMVVaeFdzeGRSa3pobFp0YmNxY0s1OVBvVm8rRTRVaXViUUV6Yncv?=
 =?utf-8?B?YlBLYWtkbnozcFhGTWlQMEdBcWNWT0FleHk5TjE5VHVRamxscEYyL0dPMFZE?=
 =?utf-8?B?VDFUcDllSmZSSFBkK1JVMmgvZUk5WDlXK2p5cXFtMTgxZ1UzYXd1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C4B5C54C5C20148AAAE3059A6B19184@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba00104-9204-4d34-873c-08da346730ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 22:31:42.9054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nc8vQBAOh7U5h+aml9aPNMnehni60qtMXs0WaLLhEiShvpFUxMG6biQ75Ss7bd18CQy+PUR7wowxGDEvx6DaUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2873
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_15:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120095
X-Proofpoint-GUID: OqJKtoJscqlmTbGzg79VNlH6a5sX_-cl
X-Proofpoint-ORIG-GUID: OqJKtoJscqlmTbGzg79VNlH6a5sX_-cl
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yNi8yMDIyIDk6MjggUE0sIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gRnJvbTogTmFv
eWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gDQo+IFdoZW4gaGFuZGxp
bmcgbWVtb3J5IGVycm9yIG9uIGEgaHVnZXRsYiBwYWdlLCB0aGUgZXJyb3IgaGFuZGxlciB0cmll
cyB0bw0KPiBkaXNzb2x2ZSBhbmQgdHVybiBpdCBpbnRvIDRrQiBwYWdlcy4gIElmIGl0J3Mgc3Vj
Y2Vzc2Z1bGx5IGRpc3NvbHZlZCwNCj4gUGFnZUhXUG9pc29uIGZsYWcgaXMgbW92ZWQgdG8gdGhl
IHJhdyBlcnJvciBwYWdlLCBzbyBidXQgdGhhdCdzIGFsbA0KPiByaWdodC4gIEhvd2V2ZXIsIGRp
c3NvbHZlIHNvbWV0aW1lcyBmYWlscywgdGhlbiB0aGUgZXJyb3IgcGFnZSBpcyBsZWZ0DQo+IGFz
IGh3cG9pc29uZWQgaHVnZXBhZ2UuIEl0J3MgdXNlZnVsIGlmIHdlIGNhbiByZXRyeSB0byBkaXNz
b2x2ZSBpdCB0bw0KPiBzYXZlIGhlYWx0aHkgcGFnZXMsIGJ1dCB0aGF0J3Mgbm90IHBvc3NpYmxl
IG5vdyBiZWNhdXNlIHRoZSBpbmZvcm1hdGlvbg0KPiBhYm91dCB3aGVyZSB0aGUgcmF3IGVycm9y
IHBhZ2UgaXMgbG9zdC4NCj4gDQo+IFVzZSB0aGUgcHJpdmF0ZSBmaWVsZCBvZiBhIHRhaWwgcGFn
ZSB0byBrZWVwIHRoYXQgaW5mb3JtYXRpb24uICBUaGUgY29kZQ0KPiBwYXRoIG9mIHNocmlua2lu
ZyBodWdlcGFnZSBwb29sIHVzZWQgdGhpcyBpbmZvIHRvIHRyeSBkZWxheWVkIGRpc3NvbHZlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVj
LmNvbT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9odWdldGxiLmggfCAyNCArKysrKysrKysr
KysrKysrKysrKysrKysNCj4gICBtbS9odWdldGxiLmMgICAgICAgICAgICB8ICA5ICsrKysrKysr
Kw0KPiAgIG1tL21lbW9yeS1mYWlsdXJlLmMgICAgIHwgIDIgKysNCj4gICAzIGZpbGVzIGNoYW5n
ZWQsIDM1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2h1
Z2V0bGIuaCBiL2luY2x1ZGUvbGludXgvaHVnZXRsYi5oDQo+IGluZGV4IGFjMmExZDc1OGE4MC4u
Njg5ZTY5Y2I1NTZiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2h1Z2V0bGIuaA0KPiAr
KysgYi9pbmNsdWRlL2xpbnV4L2h1Z2V0bGIuaA0KPiBAQCAtNDIsNiArNDIsOSBAQCBlbnVtIHsN
Cj4gICAJU1VCUEFHRV9JTkRFWF9DR1JPVVAsCQkvKiByZXVzZSBwYWdlLT5wcml2YXRlICovDQo+
ICAgCVNVQlBBR0VfSU5ERVhfQ0dST1VQX1JTVkQsCS8qIHJldXNlIHBhZ2UtPnByaXZhdGUgKi8N
Cj4gICAJX19NQVhfQ0dST1VQX1NVQlBBR0VfSU5ERVggPSBTVUJQQUdFX0lOREVYX0NHUk9VUF9S
U1ZELA0KPiArI2VuZGlmDQo+ICsjaWZkZWYgQ09ORklHX0NHUk9VUF9IVUdFVExCDQo+ICsJU1VC
UEFHRV9JTkRFWF9IV1BPSVNPTiwNCj4gICAjZW5kaWYNCj4gICAJX19OUl9VU0VEX1NVQlBBR0Us
DQo+ICAgfTsNCj4gQEAgLTc4NCw2ICs3ODcsMjcgQEAgZXh0ZXJuIGludCBkaXNzb2x2ZV9mcmVl
X2h1Z2VfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSk7DQo+ICAgZXh0ZXJuIGludCBkaXNzb2x2ZV9m
cmVlX2h1Z2VfcGFnZXModW5zaWduZWQgbG9uZyBzdGFydF9wZm4sDQo+ICAgCQkJCSAgICB1bnNp
Z25lZCBsb25nIGVuZF9wZm4pOw0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19NRU1PUllfRkFJTFVS
RQ0KPiArLyoNCj4gKyAqIHBvaW50ZXIgdG8gcmF3IGVycm9yIHBhZ2UgaXMgbG9jYXRlZCBpbiBo
cGFnZVtTVUJQQUdFX0lOREVYX0hXUE9JU09OXS5wcml2YXRlDQo+ICsgKi8NCj4gK3N0YXRpYyBp
bmxpbmUgc3RydWN0IHBhZ2UgKmh1Z2V0bGJfcGFnZV9od3BvaXNvbihzdHJ1Y3QgcGFnZSAqaHBh
Z2UpDQo+ICt7DQo+ICsJcmV0dXJuICh2b2lkICopcGFnZV9wcml2YXRlKGhwYWdlICsgU1VCUEFH
RV9JTkRFWF9IV1BPSVNPTik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBodWdl
dGxiX3NldF9wYWdlX2h3cG9pc29uKHN0cnVjdCBwYWdlICpocGFnZSwNCj4gKwkJCQkJc3RydWN0
IHBhZ2UgKnBhZ2UpDQo+ICt7DQo+ICsJc2V0X3BhZ2VfcHJpdmF0ZShocGFnZSArIFNVQlBBR0Vf
SU5ERVhfSFdQT0lTT04sICh1bnNpZ25lZCBsb25nKXBhZ2UpOw0KPiArfQ0KDQpXaGF0IGhhcHBl
bnMgaWYgdGhlIC0+cHJpdmF0ZSBmaWVsZCBpcyBhbHJlYWR5IGhvbGRpbmcgYSBwb2lzb25lZCBw
YWdlIA0KcG9pbnRlcj8gIHRoYXQgaXMsIGluIGEgc2NlbmFyaW8gb2YgbXVsdGlwbGUgcG9pc29u
ZWQgcGFnZXMgd2l0aGluIGEgDQpodWdlcGFnZSwgd2hhdCB0byBkbz8gIG1hcmsgdGhlIGVudGly
ZSBocGFnZSBwb2lzb25lZD8NCg0KdGhhbmtzLA0KLWphbmUNCg0KDQo+ICsjZWxzZQ0KPiArc3Rh
dGljIGlubGluZSBzdHJ1Y3QgcGFnZSAqaHVnZXRsYl9wYWdlX2h3cG9pc29uKHN0cnVjdCBwYWdl
ICpocGFnZSkNCj4gK3sNCj4gKwlyZXR1cm4gTlVMTDsNCj4gK30NCj4gKyNlbmRpZg0KPiArDQo+
ICAgI2lmZGVmIENPTkZJR19BUkNIX0VOQUJMRV9IVUdFUEFHRV9NSUdSQVRJT04NCj4gICAjaWZu
ZGVmIGFyY2hfaHVnZXRsYl9taWdyYXRpb25fc3VwcG9ydGVkDQo+ICAgc3RhdGljIGlubGluZSBi
b29sIGFyY2hfaHVnZXRsYl9taWdyYXRpb25fc3VwcG9ydGVkKHN0cnVjdCBoc3RhdGUgKmgpDQo+
IGRpZmYgLS1naXQgYS9tbS9odWdldGxiLmMgYi9tbS9odWdldGxiLmMNCj4gaW5kZXggZjhlMDQ4
YjkzOWM3Li42ODY3ZWE4MzQ1ZDEgMTAwNjQ0DQo+IC0tLSBhL21tL2h1Z2V0bGIuYw0KPiArKysg
Yi9tbS9odWdldGxiLmMNCj4gQEAgLTE1NDcsNiArMTU0NywxNSBAQCBzdGF0aWMgdm9pZCBfX3Vw
ZGF0ZV9hbmRfZnJlZV9wYWdlKHN0cnVjdCBoc3RhdGUgKmgsIHN0cnVjdCBwYWdlICpwYWdlKQ0K
PiAgIAkJcmV0dXJuOw0KPiAgIAl9DQo+ICAgDQo+ICsJaWYgKHVubGlrZWx5KFBhZ2VIV1BvaXNv
bihwYWdlKSkpIHsNCj4gKwkJc3RydWN0IHBhZ2UgKnJhd19lcnJvciA9IGh1Z2V0bGJfcGFnZV9o
d3BvaXNvbihwYWdlKTsNCj4gKw0KPiArCQlpZiAocmF3X2Vycm9yICYmIHJhd19lcnJvciAhPSBw
YWdlKSB7DQo+ICsJCQlTZXRQYWdlSFdQb2lzb24ocmF3X2Vycm9yKTsNCj4gKwkJCUNsZWFyUGFn
ZUhXUG9pc29uKHBhZ2UpOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICAgCWZvciAoaSA9IDA7IGkg
PCBwYWdlc19wZXJfaHVnZV9wYWdlKGgpOw0KPiAgIAkgICAgIGkrKywgc3VicGFnZSA9IG1lbV9t
YXBfbmV4dChzdWJwYWdlLCBwYWdlLCBpKSkgew0KPiAgIAkJc3VicGFnZS0+ZmxhZ3MgJj0gfigx
IDw8IFBHX2xvY2tlZCB8IDEgPDwgUEdfZXJyb3IgfA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5
LWZhaWx1cmUuYyBiL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gaW5kZXggM2UzNmZjMTljNGQxLi43
Mzk0OGEwMGFkNGEgMTAwNjQ0DQo+IC0tLSBhL21tL21lbW9yeS1mYWlsdXJlLmMNCj4gKysrIGIv
bW0vbWVtb3J5LWZhaWx1cmUuYw0KPiBAQCAtMTUzNSw2ICsxNTM1LDggQEAgaW50IF9fZ2V0X2h1
Z2VfcGFnZV9mb3JfaHdwb2lzb24odW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gICAJ
CWdvdG8gb3V0Ow0KPiAgIAl9DQo+ICAgDQo+ICsJaHVnZXRsYl9zZXRfcGFnZV9od3BvaXNvbiho
ZWFkLCBwYWdlKTsNCj4gKw0KPiAgIAlyZXR1cm4gcmV0Ow0KPiAgIG91dDoNCj4gICAJaWYgKGNv
dW50X2luY3JlYXNlZCkNCg0K
