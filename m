Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7134BC069
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiBRTou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:44:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbiBRTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:44:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECD1617C0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 11:44:28 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIhS6H007058;
        Fri, 18 Feb 2022 19:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UK3n6zJR4ml8W5EfJ7Is9BNSuF9dRruKlC9fsprykqI=;
 b=eB9xOumu0Tywff2UsdU44RZqYtU9auM3H1N6WnaKrdq2ED930Z/5gP4qi2rHBHZwCkt6
 2bgsGBONbbbimLHbyKde1rlGlmI+tetI3j5WTHDdamx+Ua5HDXCcTEc4AOn0viTTft0d
 LoaIrn+9y96dSCXzRQ+b4ATiD4eSmPUrsCIaL2u0vyQqMC1R6rVOcbaomBhaUqNxfMnW
 B18LBJwW3MXBdxjjZdw9LEd0HxP2CJaCY0dS7oJDwMs5QP3J6CTwaDsLarqTBthJC2PE
 urkOiMgFvoP/wJngVsSjxlH0g6t3PtXMoE/+rc+SNQ4DYjZg3YseSBMTZkyi+Z1O5DCv xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr9ar1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:43:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IJfpdL162175;
        Fri, 18 Feb 2022 19:43:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 3e8n4xyv5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aerR8cn8BYUSFpLY9YfpbxFhJorSXm/op+vT7HKbJ1TLub/gf0yAtU3CiUxQO6/Uxcj266sjFn59TuX2ZIYbfWRUV8aBMEpCu72IEfo4ImpIO0+eBrUA0Npv9YL3LC/L38lFMEAY77+H/0WxyoCNlHhxUbpPJ4D97K6voqopcuXyZiQaFs1rLHWmMyjBy8+VdJTrlYus9jBgtp8cTAvs3mwLcm9FRKyy81V64hmwmneHUD0l4BfAbJG/ylDs9d0ccveTaWI4nztQnTBYkeAdfDoxmyAj283ciAAIEzYqPlK18iNc45aymm+6EtNM+9uPr+YQD4+iJzdb8q+2pvzwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK3n6zJR4ml8W5EfJ7Is9BNSuF9dRruKlC9fsprykqI=;
 b=juRJRUFc3undzojm8xlXdQKXa4iC+QelypKUXD8tnWzEijVSGZGbUHk0pUcc9aQG8KC9kvvlbHO+whkzB1pSwuyDDy5B3Dvf/vX1UrcEn1QwH+BbCVALZZPypDPDyQY4M5/YwwIJXolE/NKgYvrvcjDFEgMzrYar+svEryJx8INFzHpXekoKnaTOdfW7Qp6haxN0CIfe6zI0pGX/xJj9PxSIgtwQy7dEMkavki8Xl1s0e8Uz4xqHAAFBr6sxqiz7KUFKPF2Z6ovyeJ/wtzWf1C8WuffQen0WNoW5I6aeRRJ0J6W7OZuQ3Txe4DXDWoIL8Z4YbE3KciWBGHEY53PXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK3n6zJR4ml8W5EfJ7Is9BNSuF9dRruKlC9fsprykqI=;
 b=ChYyx2z9SIz9wfNyY/cAZpy/moelWD+DeALvTUqr1FE3eFyqQ34+gtbLnqmNS+V0w20ypLTqvC3NaqPFw11w7hGONgY4/aJz7pCGdfwn/kupU0zAdUkqrnj2MhQeNj0XEpCmlIqk2FVCaJSeQ473mx9rKuk954HjNoZra95+yd8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 19:43:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.023; Fri, 18 Feb 2022
 19:43:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     =?utf-8?B?SmFrdWIgTWF0xJtuYQ==?= <matenajakub@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "riel@surriel.com" <riel@surriel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/4] [PATCH 1/4] mm: refactor of vma_merge()
Thread-Topic: [RFC PATCH 1/4] [PATCH 1/4] mm: refactor of vma_merge()
Thread-Index: AQHYJMIWR3BGTps7OUOPY/SvNH0+TqyZtiEA
Date:   Fri, 18 Feb 2022 19:43:48 +0000
Message-ID: <20220218194338.5sdi7jwusfvh3b45@revolver>
References: <20220218122019.130274-1-matenajakub@gmail.com>
 <20220218122019.130274-2-matenajakub@gmail.com>
In-Reply-To: <20220218122019.130274-2-matenajakub@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83f3d1c6-d8c9-4015-7e24-08d9f316fbb2
x-ms-traffictypediagnostic: SA2PR10MB4713:EE_
x-microsoft-antispam-prvs: <SA2PR10MB47138367ABB757F9632C8278FD379@SA2PR10MB4713.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /aaiQbN6EDB+Zfyob+CcOkLcf3s4HkDYPlG7uuA5UcoIGrwGEjZ3LoRUxj+pXjF8TbcYTOTZQ96l2zCwMg9einUbLm616MxSxmqPzxSA1WHfdWO2qTmYKKAv0tKisO6EsHS9Y76VHYJJX+L8PS6SHDtXcHhafiKQXqZl4lXK0EqIZrrLALH6Ak6Z8esUMfPJg3p4LXPLExLqSiM7eX6XhZ8s/7Xm3d5kD98Hc+I/oQnghNMXkYWVG3oRZ7UHphu2Onu7cD6Mj9E4Yi9tyYvQ0Q/5j/VrIItV/w+LKq2PRTw/hMsKSTj+gRznRjojoZKocvQ48w/XaBy6ojoEu+ZIbDDYgGpYkmjznfCPlwDR8QmjktlcXpXpmTXPo//sbHn6D7p4wGmrSNNFGpF0NU2GtfUePPIaOufbh0CNmUk6d4XqgOMCDN8Oq3aFqyU1Sd2BgrKP/UiYGm4C8SYTFH7ya4GEPVwRFrucMEQnmLLjTgXxW9wesiN5pboqXYsLer+2ztoxTV5ntaCdMJggsTN1JUz43UNlBWwh06ESyTFK2t/a02mEuz9GDJbysqinTQw3jFPQfiasF4xTHtdUl62WetCG6mttZlOHXyg6OYSjViQ/X8T94zQx5lPF6TtZwGNxKl70eS6zHYsTDJv2vSZNO8kS7M1S5HOFXFY82EbI2bB3sdnVQJb2La/lZm2KVhcP2XY+JMQaUoAxG1UPplC6yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(91956017)(66476007)(8676002)(66946007)(4326008)(1076003)(38070700005)(66574015)(64756008)(2906002)(8936002)(71200400001)(38100700002)(76116006)(26005)(44832011)(186003)(86362001)(66446008)(6506007)(316002)(66556008)(83380400001)(33716001)(7416002)(6486002)(6512007)(508600001)(9686003)(6916009)(54906003)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGFyVzBkQ1BYMmdCOGl5NHNKK0U4d1I2Z2pmSndJZDdla0U0S1RTV2ZOYjY5?=
 =?utf-8?B?eWl4VzVDbUZ2N2VWb0dvZ0tDVnNRb2JtWnB1aWV6ZVkzQ2R4dE8vODdTQ0VG?=
 =?utf-8?B?QmtLS3dUaVVtVDZmd3Z4cll4MlpoangyRW9NQkQvZWRISkNHa0NBNzdyMWht?=
 =?utf-8?B?cTB5WVFQZWtqa2p3QXJxVzBGTVRpSmRYTTBPc1VuN05rUkp4L20yVFM4MHpM?=
 =?utf-8?B?b05TZzh3ZWp6ZkdXZWlocGVlQS9aU3RTQmdWcjNSSFlEODBrQlJId0ozMHdy?=
 =?utf-8?B?Y1oxc0pDd3RqN0hoOFJ6dFk5TWpBbnNJN1p1emlRaUpyKzk3d2IyR1hEZnha?=
 =?utf-8?B?OWlqNkVyckJhWDJzV0FxSzE4VWZxdmp1OWNORVVOUHQwM2lGR3Jpd3IyYXhi?=
 =?utf-8?B?S1JQMElJWjUwNFErV2JvNEJNeTQ5ZzNyMXdNb1VKZUxacEVWWCtMbk80NGJ4?=
 =?utf-8?B?QW1JL1NxNThCZnZRUmwyd0xwdk1UTGkxVHMrMUFzSE53R2tnVE1tV2FDUUo3?=
 =?utf-8?B?bkJnNXJVVmxyMmVZbEVJeVJDUVNBd2ZRYmVBY0dTTmdBbUt2dTd1QWhVQWpw?=
 =?utf-8?B?Y1FPY3hYZzM5bHhqME9NY243ZFVOd29lU3lULzhSK05GSjJzck5aUjRZZ05F?=
 =?utf-8?B?QlZZWWt6Q0J5ckVDcnY0YWV1WDZtTWtoQkNxYm9aWHhmWktQMFBFNmpEOUxG?=
 =?utf-8?B?emEzdUpXZUkrVWc3UFVuM3ZiUEVQdncwcERQa0JPVkVlYVhkdWRSeDZaL05P?=
 =?utf-8?B?MHN1SDU5dnpFWTI2b2dwVnlmc1EybHRIMUJYMUhBWC9BTHJYcmJLbTBHVS9i?=
 =?utf-8?B?U2RSSUV0YjdhZWZqMmtnQ01SVkFJcFUxL2UyNHdBWHR2Wno2a0NVY3VzVThJ?=
 =?utf-8?B?VmorUlZQQVpES0JsMkFXSzFYalprWjJ6RFFiSjdtTDZEU09xVlJyN1R3NFpH?=
 =?utf-8?B?UXJZOGozVXBYclBBQXc5WmdVMklld0t5cnpOU1U3bHhzdnpVVThQa3lURkx1?=
 =?utf-8?B?V29LYXJmSjRqTEhUY3hKdU5ZcCtvWUp1N0dUVjVuQ0JXZko0WmExaXFHZUpz?=
 =?utf-8?B?cEZ6VjZDM2FkNEFMaHpBcWpkZG81eU9KWVQ5UmV2bjNSQVZHbEZWMENXc1Yy?=
 =?utf-8?B?bjExWjFBOWorZCtRbm01Z1lDRGVuUlJUcVhjUGhHWHRwQnVONUZZbWtrM1R4?=
 =?utf-8?B?MFFpbGJCdWJnc1YwaFg5Z0wyN1pkakd3VE12ZzVodEdSdll0enN1cEM1dUhw?=
 =?utf-8?B?WFh0MHNoTHlrcXJ4Y3RFUC9rakk1bWZGQW5VZWk2WEJ0OXJyVjMvZVJwSlJy?=
 =?utf-8?B?KzJLa3VpZUJVMW9hdXZxNDg3R0lVZXVKeWNKMTN6Nmlrd3FLYzA5QWU3VnBM?=
 =?utf-8?B?Y3RqekV2eDBkb2x2cko2eEVLaHdBSUxmRy9icmpqMTYwcWt4azkwUFRlM0cr?=
 =?utf-8?B?TjBxcjU1MW9EL1pOaE1UTklMNkkyQ0ZPU3BicGtIbXlTWVRrMVB1OTVScEFR?=
 =?utf-8?B?emd5VEMvVlQvMVZ3UUMrUzNWdDdUL09VbzNBbU1MMUw0ZHM5b29WQjlXVklj?=
 =?utf-8?B?cUpoMi9XN0cxMUxaTW8zZDRTN0V4RkxKR0ZkOFUydGhPK2lsQi9teDI5YTFR?=
 =?utf-8?B?azBxRWFreHhRaXN2alR1MG5LeDB5K3pGVUU5R09GMzRtK1RrVk96ai83MUo3?=
 =?utf-8?B?V1BrQ0o2T3dDN0NnTU5mVGMxUDl0S1NCNERmL3g3V2pUWmVPa3dwV1o1c2R6?=
 =?utf-8?B?eXpIUzY0MVRLaFhaS0lycWxyYStsMkkwZjZCWVVYZG91ZkNHTVZNYit3RGVQ?=
 =?utf-8?B?Q2t5MG5OdmxxZm5sSjBjTGlMeFBpTm9nazdDbDVabEx4Q1RQNnR5Sm53WE5n?=
 =?utf-8?B?Z2JHcXJTRU0wakpwcWlCMFZLRGRMaDA5ckpjZkFnNndYd3BMTzdQMWo4Sk9r?=
 =?utf-8?B?WmUrNlVMR2JnWmwvL2o2dWh1SUJidXpaZlJVR0RjL2tNMUg3SXlDWE1kVXdU?=
 =?utf-8?B?c2JtNUlNL2hTa0o4TjY0VWkzc2kvU2owVEg1MVhHWDFoODlUU2V2N1A4cTFi?=
 =?utf-8?B?N3E0RkhjMXBlaDM5QWF0QklTQ2g3MFhkYnFneTJTVzUyRzdieXBDN01YOUxi?=
 =?utf-8?B?Zk9IREdINHNNZnE4eFlvM01xaUplQ1FodVN4WUlyTVl3Q3FZWmlTMzFBK2F0?=
 =?utf-8?Q?K9LxAG+3/0X8r1I75xDG5Zo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAA8C319B91F894BA1C998DEC85AED61@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f3d1c6-d8c9-4015-7e24-08d9f316fbb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 19:43:48.6619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdB5qX0BwvMFc/vHQWmhv91MySZUjcEJ0N5qKO+Bj39rIS5MyTCyOfGzLzK6yZuRJachOO5bw1oZP7Ncm90lzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=891 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180120
X-Proofpoint-GUID: 2AHJrvvMZA3RV7hdYBieq8hEG4ureeTn
X-Proofpoint-ORIG-GUID: 2AHJrvvMZA3RV7hdYBieq8hEG4ureeTn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KiBKYWt1YiBNYXTEm25hIDxtYXRlbmFqYWt1YkBnbWFpbC5jb20+IFsyMjAyMTggMDc6MjFdOg0K
PiBSZWZhY3RvciB2bWFfbWVyZ2UoKSB0byBtYWtlIGl0IHNob3J0ZXIsIG1vcmUgdW5kZXJzdGFu
ZGFibGUgYW5kDQo+IHN1aXRhYmxlIGZvciB0cmFjaW5nIG9mIHN1Y2Nlc3NmdWwgbWVyZ2VzIG1h
ZGUgcG9zc2libGUgYnkgZm9sbG93aW5nDQo+IHBhdGNoZXMgaW4gdGhlIHNlcmllcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpha3ViIE1hdMSbbmEgPG1hdGVuYWpha3ViQGdtYWlsLmNvbT4NCj4g
LS0tDQo+ICBtbS9tbWFwLmMgfCA4MSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygr
KSwgNDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbW1hcC5jIGIvbW0vbW1h
cC5jDQo+IGluZGV4IDFlOGZkYjBiNTFlZC4uYjU1ZTExZjIwNTcxIDEwMDY0NA0KPiAtLS0gYS9t
bS9tbWFwLmMNCj4gKysrIGIvbW0vbW1hcC5jDQo+IEBAIC0xMTcyLDYgKzExNzIsOSBAQCBzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYV9tZXJnZShzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gIAlw
Z29mZl90IHBnbGVuID0gKGVuZCAtIGFkZHIpID4+IFBBR0VfU0hJRlQ7DQo+ICAJc3RydWN0IHZt
X2FyZWFfc3RydWN0ICphcmVhLCAqbmV4dDsNCj4gIAlpbnQgZXJyOw0KPiArCWludCBtZXJnZV9w
cmV2ID0gMDsNCj4gKwlpbnQgbWVyZ2VfYm90aCA9IDA7DQo+ICsJaW50IG1lcmdlX25leHQgPSAw
Ow0KDQpZb3Ugc2V0IHRoZXNlIGFzIHRydWUsIGNhbiB5b3UgcGxlYXNlIHVzZSBib29sZWFucz8N
Cg0KPiAgDQo+ICAJLyoNCj4gIAkgKiBXZSBsYXRlciByZXF1aXJlIHRoYXQgdm1hLT52bV9mbGFn
cyA9PSB2bV9mbGFncywNCj4gQEAgLTExOTEsNjUgKzExOTQsNTkgQEAgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWFfbWVyZ2Uoc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+ICAJVk1fV0FSTl9PTihh
ZGRyID49IGVuZCk7DQo+ICANCj4gIAkvKg0KPiAtCSAqIENhbiBpdCBtZXJnZSB3aXRoIHRoZSBw
cmVkZWNlc3Nvcj8NCj4gKwkgKiBDYW4gd2UgbWVyZ2UgcHJlZGVjZXNzb3I/DQo+ICAJICovDQo+
ICAJaWYgKHByZXYgJiYgcHJldi0+dm1fZW5kID09IGFkZHIgJiYNCj4gIAkJCW1wb2xfZXF1YWwo
dm1hX3BvbGljeShwcmV2KSwgcG9saWN5KSAmJg0KPiAgCQkJY2FuX3ZtYV9tZXJnZV9hZnRlcihw
cmV2LCB2bV9mbGFncywNCj4gIAkJCQkJICAgIGFub25fdm1hLCBmaWxlLCBwZ29mZiwNCj4gIAkJ
CQkJICAgIHZtX3VzZXJmYXVsdGZkX2N0eCwgYW5vbl9uYW1lKSkgew0KPiAtCQkvKg0KPiAtCQkg
KiBPSywgaXQgY2FuLiAgQ2FuIHdlIG5vdyBtZXJnZSBpbiB0aGUgc3VjY2Vzc29yIGFzIHdlbGw/
DQo+IC0JCSAqLw0KPiAtCQlpZiAobmV4dCAmJiBlbmQgPT0gbmV4dC0+dm1fc3RhcnQgJiYNCj4g
LQkJCQltcG9sX2VxdWFsKHBvbGljeSwgdm1hX3BvbGljeShuZXh0KSkgJiYNCj4gLQkJCQljYW5f
dm1hX21lcmdlX2JlZm9yZShuZXh0LCB2bV9mbGFncywNCj4gLQkJCQkJCSAgICAgYW5vbl92bWEs
IGZpbGUsDQo+IC0JCQkJCQkgICAgIHBnb2ZmK3BnbGVuLA0KPiAtCQkJCQkJICAgICB2bV91c2Vy
ZmF1bHRmZF9jdHgsIGFub25fbmFtZSkgJiYNCj4gLQkJCQlpc19tZXJnZWFibGVfYW5vbl92bWEo
cHJldi0+YW5vbl92bWEsDQo+IC0JCQkJCQkgICAgICBuZXh0LT5hbm9uX3ZtYSwgTlVMTCkpIHsN
Cj4gLQkJCQkJCQkvKiBjYXNlcyAxLCA2ICovDQo+IC0JCQllcnIgPSBfX3ZtYV9hZGp1c3QocHJl
diwgcHJldi0+dm1fc3RhcnQsDQo+IC0JCQkJCSBuZXh0LT52bV9lbmQsIHByZXYtPnZtX3Bnb2Zm
LCBOVUxMLA0KPiAtCQkJCQkgcHJldik7DQo+IC0JCX0gZWxzZQkJCQkJLyogY2FzZXMgMiwgNSwg
NyAqLw0KPiAtCQkJZXJyID0gX192bWFfYWRqdXN0KHByZXYsIHByZXYtPnZtX3N0YXJ0LA0KPiAt
CQkJCQkgZW5kLCBwcmV2LT52bV9wZ29mZiwgTlVMTCwgcHJldik7DQo+IC0JCWlmIChlcnIpDQo+
IC0JCQlyZXR1cm4gTlVMTDsNCj4gLQkJa2h1Z2VwYWdlZF9lbnRlcl92bWFfbWVyZ2UocHJldiwg
dm1fZmxhZ3MpOw0KPiAtCQlyZXR1cm4gcHJldjsNCj4gKwkJbWVyZ2VfcHJldiA9IHRydWU7DQoN
CllvdSBjb3VsZCBzZXQgYXJlYSA9IHByZXYgaGVyZSBhbmQgc2ltcGxpZnkgdGhlIGlmIHN0YXRl
bWVudHMgYmVsb3cuDQoNCj4gIAl9DQo+IC0NCj4gIAkvKg0KPiAtCSAqIENhbiB0aGlzIG5ldyBy
ZXF1ZXN0IGJlIG1lcmdlZCBpbiBmcm9udCBvZiBuZXh0Pw0KPiArCSAqIENhbiB3ZSBtZXJnZSBz
dWNjZXNzb3I/DQo+ICAJICovDQo+ICAJaWYgKG5leHQgJiYgZW5kID09IG5leHQtPnZtX3N0YXJ0
ICYmDQo+ICAJCQltcG9sX2VxdWFsKHBvbGljeSwgdm1hX3BvbGljeShuZXh0KSkgJiYNCj4gIAkJ
CWNhbl92bWFfbWVyZ2VfYmVmb3JlKG5leHQsIHZtX2ZsYWdzLA0KPiAtCQkJCQkgICAgIGFub25f
dm1hLCBmaWxlLCBwZ29mZitwZ2xlbiwNCj4gLQkJCQkJICAgICB2bV91c2VyZmF1bHRmZF9jdHgs
IGFub25fbmFtZSkpIHsNCj4gKwkJCQkJYW5vbl92bWEsIGZpbGUsIHBnb2ZmK3BnbGVuLA0KPiAr
CQkJCQl2bV91c2VyZmF1bHRmZF9jdHgsIGFub25fbmFtZSkpIHsNCj4gKwkJbWVyZ2VfbmV4dCA9
IHRydWU7DQo+ICsJfQ0KPiArCS8qDQo+ICsJICogQ2FuIHdlIG1lcmdlIGJvdGggcHJlZGVjZXNz
b3IgYW5kIHN1Y2Nlc3Nvcj8NCj4gKwkgKi8NCj4gKwlpZiAobWVyZ2VfcHJldiAmJiBtZXJnZV9u
ZXh0KQ0KPiArCQltZXJnZV9ib3RoID0gaXNfbWVyZ2VhYmxlX2Fub25fdm1hKHByZXYtPmFub25f
dm1hLCBuZXh0LT5hbm9uX3ZtYSwgTlVMTCk7DQo+ICsNCj4gKwlpZiAobWVyZ2VfYm90aCkgewkg
LyogY2FzZXMgMSwgNiAqLw0KPiArCQllcnIgPSBfX3ZtYV9hZGp1c3QocHJldiwgcHJldi0+dm1f
c3RhcnQsDQo+ICsJCQkJCW5leHQtPnZtX2VuZCwgcHJldi0+dm1fcGdvZmYsIE5VTEwsDQo+ICsJ
CQkJCXByZXYpOw0KPiArCQlhcmVhID0gcHJldjsNCg0KSSBkb24ndCB0aGluayB5b3UgbmVlZCBh
bGwgdGhyZWUgYm9vbGVhbnMgc2luY2UgbWVyZ2VfYm90aCBpcyBvbmx5IHVzZWQNCmhlcmUuDQoN
Cj4gKwl9IGVsc2UgaWYgKG1lcmdlX3ByZXYpIHsJCQkvKiBjYXNlcyAyLCA1LCA3ICovDQo+ICsJ
CWVyciA9IF9fdm1hX2FkanVzdChwcmV2LCBwcmV2LT52bV9zdGFydCwNCj4gKwkJCQkJZW5kLCBw
cmV2LT52bV9wZ29mZiwgTlVMTCwgcHJldik7DQo+ICsJCWFyZWEgPSBwcmV2Ow0KPiArCX0gZWxz
ZSBpZiAobWVyZ2VfbmV4dCkgew0KPiAgCQlpZiAocHJldiAmJiBhZGRyIDwgcHJldi0+dm1fZW5k
KQkvKiBjYXNlIDQgKi8NCj4gIAkJCWVyciA9IF9fdm1hX2FkanVzdChwcmV2LCBwcmV2LT52bV9z
dGFydCwNCj4gLQkJCQkJIGFkZHIsIHByZXYtPnZtX3Bnb2ZmLCBOVUxMLCBuZXh0KTsNCj4gLQkJ
ZWxzZSB7CQkJCQkvKiBjYXNlcyAzLCA4ICovDQo+ICsJCQkJCWFkZHIsIHByZXYtPnZtX3Bnb2Zm
LCBOVUxMLCBuZXh0KTsNCj4gKwkJZWxzZQkJCQkJLyogY2FzZXMgMywgOCAqLw0KPiAgCQkJZXJy
ID0gX192bWFfYWRqdXN0KGFyZWEsIGFkZHIsIG5leHQtPnZtX2VuZCwNCj4gLQkJCQkJIG5leHQt
PnZtX3Bnb2ZmIC0gcGdsZW4sIE5VTEwsIG5leHQpOw0KPiAtCQkJLyoNCj4gLQkJCSAqIEluIGNh
c2UgMyBhcmVhIGlzIGFscmVhZHkgZXF1YWwgdG8gbmV4dCBhbmQNCj4gLQkJCSAqIHRoaXMgaXMg
YSBub29wLCBidXQgaW4gY2FzZSA4ICJhcmVhIiBoYXMNCj4gLQkJCSAqIGJlZW4gcmVtb3ZlZCBh
bmQgbmV4dCB3YXMgZXhwYW5kZWQgb3ZlciBpdC4NCj4gLQkJCSAqLw0KDQpJIHRoaW5rIHRoZSBh
Ym92ZSBjb21tZW50IGlzIHN0aWxsIHRydWU/DQoNCj4gLQkJCWFyZWEgPSBuZXh0Ow0KPiAtCQl9
DQo+IC0JCWlmIChlcnIpDQo+IC0JCQlyZXR1cm4gTlVMTDsNCj4gLQkJa2h1Z2VwYWdlZF9lbnRl
cl92bWFfbWVyZ2UoYXJlYSwgdm1fZmxhZ3MpOw0KPiAtCQlyZXR1cm4gYXJlYTsNCj4gKwkJCQkJ
bmV4dC0+dm1fcGdvZmYgLSBwZ2xlbiwgTlVMTCwgbmV4dCk7DQo+ICsJCWFyZWEgPSBuZXh0Ow0K
PiArCX0gZWxzZSB7DQo+ICsJCWVyciA9IC0xOw0KPiAgCX0NCg0KSWYgeW91IGluaXRpYWxpemUg
ZXJyIHRvIHNvbWV0aGluZywgeW91IGNhbiBkcm9wIHRoaXMgZWxzZS4NCg0KPiAgDQo+IC0JcmV0
dXJuIE5VTEw7DQo+ICsJLyoNCj4gKwkgKiBDYW5ub3QgbWVyZ2Ugd2l0aCBwcmVkZWNlc3NvciBv
ciBzdWNjZXNzb3Igb3IgZXJyb3IgaW4gX192bWFfYWRqdXN0Pw0KPiArCSAqLw0KPiArCWlmIChl
cnIpDQo+ICsJCXJldHVybiBOVUxMOw0KPiArCWtodWdlcGFnZWRfZW50ZXJfdm1hX21lcmdlKGFy
ZWEsIHZtX2ZsYWdzKTsNCj4gKwlyZXR1cm4gYXJlYTsNCj4gIH0NCj4gIA0KPiAgLyoNCj4gLS0g
DQo+IDIuMzQuMQ0KPiA=
