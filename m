Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76954D388F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiCISPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiCISPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:15:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD5F11B0;
        Wed,  9 Mar 2022 10:14:37 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229GRRpA003031;
        Wed, 9 Mar 2022 18:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/TQYgV/5TppFgWZNiNg4qAUVTsR1HZEfbDpJV4ztcJ8=;
 b=SILj42sS1AEX3m0UPPfGV/yhKm3IssZn7vwExuxWYcEpJpFEzCFNgTYbWIqWYh1ifJ92
 0qHYU3wy7mbefklZFSUANUTHdrzXL3hJWKVWJQAw/5bD8zKzLOPQ3kAYEzM/FWyi9W7N
 kNSH2OnS/dIdmZeo0ONFGPZCVq45VKjjB+pg2gbbeYkIoyfj0j6ah493skWIVMfv+L40
 0Jpnk1HuPQ6LkvzH4ktDHBBoXk0z94BzJZ4hVfrgPFq+fkti3X2bjtxRNDi0jJ0fXeKi
 vWcD2AxFThK/l/5LRszEUhsTydI8P4c0o7SyCYeoebiNKlYhI/u8ugrjnaAN0PVlmwsA xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0du33dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 18:13:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229IAf8h034596;
        Wed, 9 Mar 2022 18:13:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3ekvyw2c86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 18:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnY+Dm20OL74JX06Z3C3ZDBLqBe0DfhWaaXJGcSmKzVNRG/B0FkLLu3NtqzqgVWULRUcK7wFoGKsZO/V893maTciDSvKIfXD+YtaArfw/RXluBCmWeXfjIH0gCde9qN3QoYDaSCt2RRQxKXlo/QtZ22SyDqmVmld3Q42xfQdG86OTJd4ScADCiZdd5w5tbD0o81ti6GsivAhQMefRavns0U40975UaWeDrDzAo3+5aX9gaTNydQjI2yUj2DMv558vDNd0YutQBKqw60SaHnLKH8ZSW27I2d1TqJUNHl78Sehb2LxZdelUKMt0MFq377C8mKBNr+MVCRPVEENCsej1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TQYgV/5TppFgWZNiNg4qAUVTsR1HZEfbDpJV4ztcJ8=;
 b=Ft5RRGQ1iWREPOTVDfc9wiLzl4Z10khal6cWGd2Z+I2e59CMLzKx26mBDl0iufA//LHFUyDuikBVnFpf/zyW2oYLDqHstCi0gHqaSFSXw+jdtyzUukiNp/sTKFY2PInA8VM1XHZ5qjuUcFtTDGxcSDlSGkga+aYJQLvPLtlpP0EU9O81IgTIEQV1UfQWePAHoU1rAIx+yfB2EC9Wyn9c4uzYJ7EluwqT2fTr1nEG6Xd3CMjvl7xRDsQ682QhyzLngVsoXyzwlEXVOsCdwqR8ehcYOtMqOtqaSpJ+Z1V2166hNwSlOtf4y5aqF9MNYFJyY8Mv0sYgZiLUDOns6mj31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TQYgV/5TppFgWZNiNg4qAUVTsR1HZEfbDpJV4ztcJ8=;
 b=OY+POqeiKD1E4N4MXGoVhzBRIQCm1xEicOwwAwzFv9tZ5yR4c8h+/YnaqORZVaRCBFCUo3z3SM2DRmNPEsF6ucVbsregfZL/HgfdfxEDKScySzH/zj5fzh6hN56NLJ2Uu/8S136nj/McaabTwE+14ozYvMc0Ilhp5XCp264g9uU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB3120.namprd10.prod.outlook.com (2603:10b6:208:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 18:13:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 18:13:50 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] KEYS: CA link restriction
Thread-Topic: [PATCH 3/4] KEYS: CA link restriction
Thread-Index: AQHYLZNA834T4wj1IU2tnKIEwT0iJayvXcOAgATjNQCAAFKBgIAACluAgAAwN4CAAKt3gIAAWKsAgAGEcYCAABEVAA==
Date:   Wed, 9 Mar 2022 18:13:50 +0000
Message-ID: <B9A8F5BD-5FDE-4501-9C0A-865579C45627@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-4-eric.snowberg@oracle.com>
 <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
 <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
 <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
 <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
 <22860730-d615-5683-6af0-05b6f4f3e71d@linux.ibm.com>
 <e10f2161aaa69a9d301b3a16a37cbab266318aee.camel@linux.ibm.com>
 <068F32E0-B202-4B20-9DE7-57373EF71BFE@oracle.com>
 <930d970d-0120-d3f0-939a-b5ef3b596318@linux.ibm.com>
In-Reply-To: <930d970d-0120-d3f0-939a-b5ef3b596318@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8df97f3-3c00-4f02-b16a-08da01f8901e
x-ms-traffictypediagnostic: MN2PR10MB3120:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3120EFE81303A43C94EA3AF9870A9@MN2PR10MB3120.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DK2vvExKs2W/a8zK88gBosTUd+0DnO+ee1itwape5Pa0ZGy6K2Uu9EFlDNRgZoSW+dfBOvHZfskL6s7ew7qWdG8UR52474gDbFaIZ+RZGVoxkRIAnW1TxkNxXSX7tcSdV/e73zEPSyNdzvJweutv6aeDTVaZOjuIgpiPPEUjTULzjste7GzpntcaUtejtkkavOr1FNc10aLYV1Qt0YNlwEISi2IFgGxn0DAd0RWMgAGMIqziZJVMucsWEpKwGt9BBhq+qUxCbGnaWzjaxSsYTRjUotG3t+uRt1VR2A8FM+AkOXZCoCs//J6zh1zwoDLG6QmnDoIksD7H9yb24Oz505TEgT4NsvnNYTAXdS1PqHpClkv5vI3ZsM0wvBZ5ukQt/mza8enWLAh1PgfjcgAJpLNLMjGdnaOf/NJJ51SN5Xs4/fzVGNFzzVOeNjJKzfnJTpOkUosfvvR8JOQczfPK2LB9YEcUIKMltcPv6Y3LcavYGsj8HORKNfxluaoQhFO4gh6BtNmyzHSZll3Tj8kZGK9m3TRUS5dCTVHUcsUYXwBSqrt3trRQEcoR+Vj5p4hVuewKB7QaRZCBaTd0SVna6iOhJK4frbN1e/yD7TzxCbFs3YIxy16U5dG895m6vczWotIOK4WWGtytksUqaax1vvM8S5gv4CbyVyStNB3J+32FlUOEyL0Ae6iwt0zIfeAWeDrxRkbtKONaYAG8AihEolsUhVTKSoZyMsNqGMywseunEk7a44z1SA0Zt/rRXIZ9XoPq9NCdMbs0AuDGT8EQLz26ctrsqHg8aagaCI0HTgPkASYNLjgSmN1Wj97Xxuzk5OqKCpqCVBZbZrC+ec0wag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(508600001)(36756003)(38100700002)(71200400001)(966005)(316002)(54906003)(186003)(4326008)(38070700005)(6486002)(66556008)(66476007)(64756008)(66446008)(8676002)(6916009)(91956017)(66946007)(26005)(76116006)(122000001)(53546011)(5660300002)(8936002)(2616005)(6506007)(7416002)(2906002)(44832011)(83380400001)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVFCeElucTN4ZEVsWUo4eklWY0cxNnJ1SHUzM0VtbEpUd2hFODJSYkJ4T3BW?=
 =?utf-8?B?YUg2MmxQelA1Ym8rODhYbnJrMmJsTndmVW9ua0xseGVGa1Z6SUJ3UWkxREhY?=
 =?utf-8?B?Zk5rZk9ERjJFUEdNU3FBNjVqNTQ1NCtyeWVCMTllbS9rakNwUnZQVHY5Q1Nq?=
 =?utf-8?B?N0RJY1dQNnV6MHBjMGltREdqQ3k1RUFneTNSTE9MNC84NytZblhncFlKNXdw?=
 =?utf-8?B?VUEzU1dzU2NTK2NVTmxMeXlFWXVhb1VDaDBsdTRISEoxOXZaeVlvUjJyekRx?=
 =?utf-8?B?dExta1R0MVhJRVV3eGU3c0dYVmxwU3JoUktLOS9aaEFCZWpwRjFuajBmdEhJ?=
 =?utf-8?B?dlc0eDZNRjlqQW14RnhETUszNmgzeUJHMFg5UmhIN0Q2TmtsWEltcjBMcVpv?=
 =?utf-8?B?dzdsa1gzcHp1T28zVDU2MkJPb21LQmJNaUVBUTFxV1Z5ZGVqM0FjdU5vUEtv?=
 =?utf-8?B?YXRLa2thUjFRanF2WGRuK2d5SHpweVg3ajA2dmtlMVJOb2YrSC8vcE5ITTVr?=
 =?utf-8?B?SmhIa01TOWpqZWt1SmkwakV1V3NYREd5Uk1hRm5GREFxdndnVVYxTExNWVly?=
 =?utf-8?B?bW95S0ZjVTRnakFNWitIbXk2RVJVZWlSYUVwRXRUTSsxZ09rZFdNVk9OVjRu?=
 =?utf-8?B?N1NQRDhxVUtzSnRKR2dFdTVwUkUrcWVwdmRSMXphaVd6ZUZTdytIK0Z6TVdP?=
 =?utf-8?B?K0xEZkFvNms1b0RmcW4xcCtydWJacGhhUjF1Uk1CUmloTjQrdTZ1K1VaV2JE?=
 =?utf-8?B?TTc3bHg2ZCtCeFBnZE90amlpMGozVDlYdWdTcWxwTjVGYjlGeWROQThHcERn?=
 =?utf-8?B?YVFHcjRpZlY0aWUwam1iM2FLL21BN0FSYlE2M0NiUUFFK01FTE81VlNmc3My?=
 =?utf-8?B?dEhxNFVsTDRKUDJIMFE5SFgwdU82bjZTTzh6RXJRR2FtL0hsUUVxT3dWL2tN?=
 =?utf-8?B?RlZNcHE3RzA3R2pIYVZrOGtpSFJoYzYyZ1NGSllVUTlOQkVrdHdEazlZdHBa?=
 =?utf-8?B?a3JXczFUN0tCNGVhT1Zia1oyK04wSHRJaGlCM2ZUZzAzQ2E3UWlXME1xY0hm?=
 =?utf-8?B?ZUhYdm9Xbi9kNTdEMmVUSHIycmZzamIwVkNxNTNlOW5pd3p5b2txRWl2R0Ft?=
 =?utf-8?B?aVFqVFRmQnNRZ0lJNzJVc1JBUEtmaVJpYWU2VEVYQnRBSHRGMmhVZnc4M0pV?=
 =?utf-8?B?c2JTRzZWUld4cGdWVzExdmFTTzZIZXJYelVyUklOWFBRT3h6bHp6eUpwZXZT?=
 =?utf-8?B?SWdJeWdrUU5xTEFaeDFkNEJSeFpSOWlOdllwOWhwNFZUenFuaVlYcGxYWVFu?=
 =?utf-8?B?eDBpamZ1M3FnZWluNHcwdm5DOWxyNlJ0RlB3VWVBRG1XdG1NZmtKVXl2eXAx?=
 =?utf-8?B?RkdVVWNETW1NZlRKTnBvYXJocVBnc0FnMFIramROcERnMCt5TXcyT01tMm9j?=
 =?utf-8?B?WTZsNkR0SXBkODcvakdRRVZCM2FvRzRtK1RHK0ZZeFBzb2M1RU0zaDJLS25T?=
 =?utf-8?B?UmJ1Q0c4ME1rc1FzRGZCZFoxTXc4cGFudksydHBDNEZaWDlQdWxudGJJckZq?=
 =?utf-8?B?V2VMUEYrWGFKOVVQQ1VsQTFDcVYzNFJCRmR1QlVqdnRrYU1yN09aSnB1QlJB?=
 =?utf-8?B?S2RpYWJscHlLTkdvMGxGRTI5VW9hbU1VbldaVHRQcHJvRUtNRVlHY2Q1SHJn?=
 =?utf-8?B?a1hiOEw1bzEvYWVLYzdiZ00yTWN5bHhxWUVWWkh6THdZQVYvRXR1bXFnZk94?=
 =?utf-8?B?T2hVdXkzT2lVdTVFeHUzWFpSRHZSQjJNZGRXRnJzVWR5YnFVbmh3d2hlSGp2?=
 =?utf-8?B?QjhZS0VUZVdrSVN3cnZIckhNY2hVR1hSOG0raG5WbjZjNnI2bEdaaU0wY1Iy?=
 =?utf-8?B?SUROS0N1a3M3V3AxNW44dmxQVldhN21Mci9TWS9rUDN5bUtRaERLanA3Qkxq?=
 =?utf-8?B?dWFuRmdLOE9qT1pKVFhBazN4SDJYRXFnUlVyRzBWNWg1Sll0NHRUZi9Vd3M5?=
 =?utf-8?B?aGlndXFkSmM5ZE9RQTlKcmUwaGJaOGlmcXRmb21XbUpxakdZTzI4R09hSE9Q?=
 =?utf-8?B?YTEra0VjYUUzbmpGdlpCRHd2eTNUc3FnS0pUUHg2TUtkK3hZSmtRQlViNVZ4?=
 =?utf-8?B?by9Gei9XSEExMGhaKzBwckVnc3VBbWFDazg2YmhmQkEvRU4xVVhnR1VHbU1a?=
 =?utf-8?B?MGliaXlNa1JxZkQrQ1VKRm1LSTRLM1JQUENxQlhqK25IOTVROW1Mdk8rOGFj?=
 =?utf-8?Q?BW7nUePvqMaIhjo2/9II2ZrMT++D6zuJUpemFyfPgY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <155452C302C9B940ABC13D050B05EAAF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8df97f3-3c00-4f02-b16a-08da01f8901e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 18:13:50.6544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4sMV+82iRddgiIG+Li4dYI8qXWzZd9rdyzcqS69jWt+daj3QVzKa1kyoP0s+NxYmyf9QKGhFH86yTxnMTEB5kYhLNu7rjWvg6ALvWKbpxUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3120
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090100
X-Proofpoint-ORIG-GUID: e6nvIOeXOxbzZzgB56Al_TN91V1O0tQ4
X-Proofpoint-GUID: e6nvIOeXOxbzZzgB56Al_TN91V1O0tQ4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDksIDIwMjIsIGF0IDEwOjEyIEFNLCBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5i
QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiAzLzgvMjIgMTM6MDIsIEVy
aWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4gT24gTWFyIDgsIDIwMjIsIGF0IDU6NDUgQU0sIE1pbWkg
Wm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgMjAy
Mi0wMy0wNyBhdCAyMTozMSAtMDUwMCwgU3RlZmFuIEJlcmdlciB3cm90ZToNCj4+Pj4gDQo+Pj4+
IE9uIDMvNy8yMiAxODozOCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+
Pj4+Pj4gT24gTWFyIDcsIDIwMjIsIGF0IDQ6MDEgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIE1vbiwgMjAyMi0wMy0wNyBhdCAx
ODowNiArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2NyeXB0by9hc3ltbWV0cmljX2tleXMvcmVzdHJpY3QuYyBiL2NyeXB0by9hc3lt
bWV0cmljX2tleXMvcmVzdHJpY3QuYw0KPj4+Pj4+Pj4+IGluZGV4IDZiMWFjNWY1ODk2YS4uNDli
YjJlYTdmNjA5IDEwMDY0NA0KPj4+Pj4+Pj4+IC0tLSBhL2NyeXB0by9hc3ltbWV0cmljX2tleXMv
cmVzdHJpY3QuYw0KPj4+Pj4+Pj4+ICsrKyBiL2NyeXB0by9hc3ltbWV0cmljX2tleXMvcmVzdHJp
Y3QuYw0KPj4+Pj4+Pj4+IEBAIC0xMDgsNiArMTA4LDQ5IEBAIGludCByZXN0cmljdF9saW5rX2J5
X3NpZ25hdHVyZShzdHJ1Y3Qga2V5ICpkZXN0X2tleXJpbmcsDQo+Pj4+Pj4+Pj4gCXJldHVybiBy
ZXQ7DQo+Pj4+Pj4+Pj4gfQ0KPj4+Pj4+Pj4+ICsvKioNCj4+Pj4+Pj4+PiArICogcmVzdHJpY3Rf
bGlua19ieV9jYSAtIFJlc3RyaWN0IGFkZGl0aW9ucyB0byBhIHJpbmcgb2YgQ0Ega2V5cw0KPj4+
Pj4+Pj4+ICsgKiBAZGVzdF9rZXlyaW5nOiBLZXlyaW5nIGJlaW5nIGxpbmtlZCB0by4NCj4+Pj4+
Pj4+PiArICogQHR5cGU6IFRoZSB0eXBlIG9mIGtleSBiZWluZyBhZGRlZC4NCj4+Pj4+Pj4+PiAr
ICogQHBheWxvYWQ6IFRoZSBwYXlsb2FkIG9mIHRoZSBuZXcga2V5Lg0KPj4+Pj4+Pj4+ICsgKiBA
dHJ1c3Rfa2V5cmluZzogVW51c2VkLg0KPj4+Pj4+Pj4+ICsgKg0KPj4+Pj4+Pj4+ICsgKiBDaGVj
ayBpZiB0aGUgbmV3IGNlcnRpZmljYXRlIGlzIGEgQ0EuIElmIGl0IGlzIGEgQ0EsIHRoZW4gbWFy
ayB0aGUgbmV3DQo+Pj4+Pj4+Pj4gKyAqIGNlcnRpZmljYXRlIGFzIGJlaW5nIG9rIHRvIGxpbmsu
DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IENBID0gcm9vdCBDQSBoZXJlLCByaWdodD8NCj4+Pj4+Pj4g
DQo+Pj4+Pj4+IFllcywgSeKAmWxsIHVwZGF0ZSB0aGUgY29tbWVudA0KPj4+Pj4+IA0KPj4+Pj4+
IFVwZGF0aW5nIHRoZSBjb21tZW50IGlzIG5vdCBlbm91Z2guICBUaGVyZSdzIGFuIGV4aXN0aW5n
IGZ1bmN0aW9uIG5hbWVkDQo+Pj4+Pj4gIng1MDlfY2hlY2tfZm9yX3NlbGZfc2lnbmVkKCkiIHdo
aWNoIGRldGVybWluZXMgd2hldGhlciB0aGUgY2VydGlmaWNhdGUNCj4+Pj4+PiBpcyBzZWxmLXNp
Z25lZC4NCj4+Pj4+IA0KPj4+Pj4gT3JpZ2luYWxseSBJIHRyaWVkIHVzaW5nIHRoYXQgZnVuY3Rp
b24uICBIb3dldmVyIHdoZW4gdGhlIHJlc3RyaWN0IGxpbmsgY29kZSBpcyBjYWxsZWQsDQo+Pj4+
PiBhbGwgdGhlIG5lY2Vzc2FyeSB4NTA5IGluZm9ybWF0aW9uIGlzIG5vIGxvbmdlciBhdmFpbGFi
bGUuICAgVGhlIGNvZGUgaW4NCj4+Pj4+IHJlc3RyaWN0X2xpbmtfYnlfY2EgaXMgYmFzaWNhbGx5
IGRvaW5nIHRoZSBlcXVpdmFsZW50IHRvIHg1MDlfY2hlY2tfZm9yX3NlbGZfc2lnbmVkLg0KPj4+
Pj4gQWZ0ZXIgdmVyaWZ5aW5nIHRoZSBjZXJ0IGhhcyB0aGUgQ0EgZmxhZyBzZXQsIHRoZSBjYWxs
IHRvIHB1YmxpY19rZXlfdmVyaWZ5X3NpZ25hdHVyZQ0KPj4+Pj4gdmFsaWRhdGVzIHRoZSBjZXJ0
IGlzIHNlbGYgc2lnbmVkLg0KPj4+Pj4gDQo+Pj4+IElzbid0IHg1MDlfY2VydF9wYXJzZSgpIGJl
aW5nIGNhbGxlZCBhcyBwYXJ0IG9mIHBhcnNpbmcgdGhlIGNlcnRpZmljYXRlPw0KPj4+PiBJZiBz
bywgaXQgc2VlbXMgdG8gY2hlY2sgZm9yIGEgc2VsZi1zaWduZWQgY2VydGlmaWNhdGUgZXZlcnkg
dGltZS4gWW91DQo+Pj4+IGNvdWxkIGFkZCBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIHRv
IHg1MDlfY2hlY2tfZm9yX3NlbGZfc2lnbmVkKGNlcnQpOg0KPj4+PiBwdWItPng1MDlfc2VsZl9z
aWduZWQgPSBjZXJ0LT5zZWxmX3NpZ25lZCA9IHRydWU7DQo+Pj4+IA0KPj4+PiBUaGlzIGNvdWxk
IHRoZW4gcmVkdWNlIHRoZSBmdW5jdGlvbiBpbiAzLzQgdG8gc29tZXRoaW5nIGxpa2U6DQo+Pj4+
IA0KPj4+PiByZXR1cm4gcGF5bG9hZC0+ZGF0YVthc3ltX2NyeXB0b10tPng1MDlfc2VsZl9zaWdu
ZWQ7DQo+PiBXaGVuIEkgd2FzIHN0dWR5aW5nIHRoZSByZXN0cmljdGlvbiBjb2RlLCBiZWZvcmUg
d3JpdGluZyB0aGlzIHBhdGNoLCBpdCBsb29rZWQgbGlrZQ0KPj4gaXQgd2FzIHdyaXR0ZW4gZnJv
bSB0aGUgc3RhbmRwb2ludCB0byBiZSBhcyBnZW5lcmljIGFzIHBvc3NpYmxlLiAgQWxsIGNvZGUg
Y29udGFpbmVkDQo+PiB3aXRoaW4gaXQgd29ya3Mgb24gZWl0aGVyIGEgcHVibGljX2tleV9zaWdu
YXR1cmUgb3IgYSBwdWJsaWNfa2V5LiAgSSBoYWQgYXNzdW1lZCBpdA0KPj4gd2FzIHdyaXR0ZW4g
dGhpcyB3YXkgdG8gYmUgdXNlZCB3aXRoIGRpZmZlcmVudCBhc3ltbWV0cmljYWwga2V5IHR5cGVz
IG5vdyBhbmQgaW4NCj4+IHRoZSBmdXR1cmUuIEkgY2FsbGVkIHRoZSBwdWJsaWNfa2V5X3Zlcmlm
eV9zaWduYXR1cmUgZnVuY3Rpb24gaW5zdGVhZCBvZiBpbnRlcnJvZ2F0aW5nDQo+PiB0aGUgeDUw
OSBwYXlsb2FkIHRvIGtlZXAgaW4gbGluZSB3aXRoIHdoYXQgSSB0aG91Z2h0IHdhcyB0aGUgb3Jp
Z2luYWwgZGVzaWduLiBMZXQgbWUNCj4+IGtub3cgaWYgSSBzaG91bGQgYmUgY2FycnlpbmcgeDUw
OSBjb2RlIGluIGhlcmUgdG8gbWFrZSB0aGUgY2hhbmdlIGFib3ZlLg0KPiANCj4gSXQgZG9lcyBu
b3Qgc2VlbSByaWdodCBpZiB0aGVyZSB3ZXJlIHR3byBmdW5jdGlvbnMgdHJ5aW5nIHRvIGRldGVy
bWluZSB3aGV0aGVyIGFuIHg1MDkgY2VydCBpcyBzZWxmLXNpZ25lZC4gVGhlIGV4aXN0aW5nIGlz
IGludm9rZWQgYXMgcGFydCBvZiBsb2FkaW5nIGEga2V5IG9udG8gdGhlIG1hY2hpbmUga2V5cmlu
ZyBmcm9tIHdoYXQgSSBjYW4gc2VlLiBJdCBoYXMgYWNjZXNzIHRvIG1vcmUgZGF0YSBhYm91dCB0
aGUgY2VydCBhbmQgdGhlcmVmb3JlIGNhbiBkbyBzdHJvbmdlciB0ZXN0cywgeW91cnMgZG9lc24n
dCBoYXZlIGFjY2VzcyB0byB0aGUgZGF0YS4gU28gSSBndWVzcyBJIHdvdWxkIHJlbWVtYmVyIGlu
IGEgYm9vbGVhbiBpbiB0aGUgcHVibGljIGtleSBzdHJ1Y3R1cmUgdGhhdCB0aGUgeDUwOSBjZXJ0
IGl0IGNvbWVzIGZyb20gd2FzIHNlbGYgc2lnbmVkIGZvbGxvd2luZyB0aGUgZXhpc3RpbmcgdGVz
dC4gS2V5IGluIHlvdXIgZnVuY3Rpb24gbWF5IGJlIHRoYXQgdGhhdCBwYXlsb2FkLT5kYXRhW10g
YXJyYXkgaXMgZ3VhcmFudGVlZCB0byBiZSBmcm9tIHRoZSB4NTA5IGNlcnQgYXMgc2V0IGluIHg1
MDlfa2V5X3ByZXBhcnNlKCkuDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC92NS4xNy1yYzcvc291cmNlL2NyeXB0by9hc3ltbWV0cmljX2tleXMveDUwOV9wdWJsaWNfa2V5
LmMjTDIzNg0KDQpJIGNvdWxkIGFkZCBhbm90aGVyIGJvb2wgdG8gdGhlIHB1YmxpYyBrZXkgc3Ry
dWN0dXJlIHRvIGRlc2lnbmF0ZSBpZiB0aGUga2V5IHdhcyBzZWxmIHNpZ25lZCwgDQpidXQgdGhp
cyBzZWVtcyB0byBnbyBhZ2FpbnN0IHdoYXQgdGhlIGtlcm5lbCBkb2N1bWVudCBzdGF0ZXMuICJB
c3ltbWV0cmljIC8gUHVibGljLWtleSANCkNyeXB0b2dyYXBoeSBLZXkgVHlwZeKAnSBbMV0gc3Rh
dGVzOg0KDQoiVGhlIOKAnGFzeW1tZXRyaWPigJ0ga2V5IHR5cGUgaXMgZGVzaWduZWQgdG8gYmUg
YSBjb250YWluZXIgZm9yIHRoZSBrZXlzIHVzZWQgaW4gcHVibGljLWtleQ0KY3J5cHRvZ3JhcGh5
LCB3aXRob3V0IGltcG9zaW5nIGFueSBwYXJ0aWN1bGFyIHJlc3RyaWN0aW9ucyBvbiB0aGUgZm9y
bSBvciBtZWNoYW5pc20gb2YgDQp0aGUgY3J5cHRvZ3JhcGh5IG9yIGZvcm0gb2YgdGhlIGtleS4N
Cg0KVGhlIGFzeW1tZXRyaWMga2V5IGlzIGdpdmVuIGEgc3VidHlwZSB0aGF0IGRlZmluZXMgd2hh
dCBzb3J0IG9mIGRhdGEgaXMgYXNzb2NpYXRlZCB3aXRoIA0KdGhlIGtleSBhbmQgcHJvdmlkZXMg
b3BlcmF0aW9ucyB0byBkZXNjcmliZSBhbmQgZGVzdHJveSBpdC4gSG93ZXZlciwgbm8gcmVxdWly
ZW1lbnQgaXMgDQptYWRlIHRoYXQgdGhlIGtleSBkYXRhIGFjdHVhbGx5IGJlIHN0b3JlZCBpbiB0
aGUga2V5LiINCg0KTm93IGV2ZXJ5IHB1YmxpYyBrZXkgdHlwZSB3b3VsZCBuZWVkIHRvIGZpbGwg
aW4gdGhlIGluZm9ybWF0aW9uIG9uIHdoZXRoZXIgdGhlIGtleSBpcyBzZWxmIA0Kc2lnbmVkIG9y
IG5vdC4gIEluc3RlYWQgb2YgZ29pbmcgdGhyb3VnaCB0aGUgcHVibGljX2tleV92ZXJpZnlfc2ln
bmF0dXJlIGZ1bmN0aW9uIGN1cnJlbnRseSANCnVzZWQgaW4gdGhpcyBwYXRjaC4NCg0KaHR0cHM6
Ly9kb2NzLmtlcm5lbC5vcmcvY3J5cHRvL2FzeW1tZXRyaWMta2V5cy5odG1sDQoNCg==
