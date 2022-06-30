Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047B4562224
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiF3SeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiF3SeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:34:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506DE25C7A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:34:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UITn8C024971;
        Thu, 30 Jun 2022 18:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bf8QpExTn1xuQXEX7VzHq84T+4CUdmMAMsEbV5ydTVI=;
 b=aj1BdgJ7n5P0+a8m9GfF9Dj+VAiVCHpQszUFaMs24WBNy76z8xuHFIuiDADgP7m3Qq/8
 SCS5vd26EIdmFDp93d2aoMUh4M+k7sPfD14X9/q0oAhP49daZZ4sim5qpae8Ja12ThKW
 y8yA+3UDUtVa+K7RZYTfKWXOc3jzJudnlttRD1g2WxL+YwGLfjBmwKBWJ7eEniqD8Z7t
 oSseKgVw0xgcKHQ2v41UA29qmtGya4dPkQRudr+BzQEOromYZGEH4YVQx/cBCPkcdrbC
 m+YVTLihx2snXsnJtG9gtaqE4Uu5B37Bwjs3WX/HSkb2o46hg1R3LYLyjUjTEujlUOUQ Jg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52n7dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:34:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UI5BP1036651;
        Thu, 30 Jun 2022 18:34:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrta1cse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeBp/P+xy9Q+ZSBwaBM/HsudmXd/GF1w8ET+fZpvd0BjqhSTPwzlYARFADMHawh7VS8IJEMnZ8onY49DOnPQ8/0P0p49/9qpqFqInjs3+CmOcZneiHNI4FxZb7iEp0TE37/Hfk3gYeEj699Pk5BgSAzQ2cQOpD1Oby4YtnA6b2kYLOdIUw/Zw/Z3lyRCh3rAyrEYez7o9rcwuuC9e+QE+J+0rG7A7yGH2U5mjSTN4pkjHZzZ9q/A+yviqae9L7kNL6mSlzcMeP5SMoe0ChEyZVtJHCb+LA92LXqju5AvFkIJSd8VGRmWNrsX8K0688wLnuFSbXVl8p+Vzl2W18Tj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf8QpExTn1xuQXEX7VzHq84T+4CUdmMAMsEbV5ydTVI=;
 b=cKj7/HX8Uv+M9k6pETwbtYJKnG2qiMSasRBcC7rq7S3YUYQZFXmqDRw/8URMTsMAJncFoOJrbDRE/Q3b7Gw1AVsGXFCncMJ7rPiTNHZVJ26sJJWqU9ObEhs310jf1g1bCE13GO1BBE/lly/91GQbr7tZOD/RgqdM4w3Xgo5568iR0KCXwelFlB7dn/gEa+z/HEMLEvXNSVV2Ct94QFd4Cz/HQyRIZEiDnX2Z5vor5muLdYezUHE1BY7vphfSgUB6X1SkxGOshQYmMxFTz7YbxN98QYEQaXdBUxzoaMU6cxFRAAYYWIawlSheY3j0ns+vehftG+9yhvFTKBndHsXzGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf8QpExTn1xuQXEX7VzHq84T+4CUdmMAMsEbV5ydTVI=;
 b=jllVyrXWAFfif+tUzpWzkbaFJczXQwHUw+D6MvXaTvCrtFmUAVT+l4YrnVupB09v0efVq7mymKaMtxzuR0Tu7xuHOiGxzDOtNhcM1pNWO81XxvBHajbx+gUJGpc+ZTyVEZAfchyosNlKc2uBSJhcMFi4DshofEABYdJmLco6cYg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 18:34:04 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20%9]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 18:34:04 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2] pmem: fix a name collision
Thread-Topic: [PATCH v2] pmem: fix a name collision
Thread-Index: AQHYjK8rBSATsthIi0m9QeL2G5Lstq1oRVaAgAABPgA=
Date:   Thu, 30 Jun 2022 18:34:04 +0000
Message-ID: <cb2660a6-e91d-33b2-0664-2c8924ac176c@oracle.com>
References: <20220630182802.3250449-1-jane.chu@oracle.com>
 <20220630182937.GA19534@lst.de>
In-Reply-To: <20220630182937.GA19534@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27a5a98a-a198-436f-994a-08da5ac71c61
x-ms-traffictypediagnostic: DS7PR10MB5087:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YrlrJgbGn0NJCksS3zwpJZmNa+YJt97CsRwDf+EgeTEzm0qk9ggaA5btcYKl4YpR/K/QIPZSyKIcNYNoegH/4wPzihcVicA5iWp6B/rhI6fEEidMgUlQzXA2JjeDeSzTkC8ZLCDOGlSBKSx+qOWpWvSOOI6yRhgH8eG+gnIqR7AEEEVy1/n61P5B8t9vRHMYptFIm9ryHN32GhXIZ+xbJXUi5wyBRnq+4tHhBwmBUTBSC5Y7yxSnyeNwBRVUgA6e8ZiY6JQLIUkDmyU34MBrVE0sQdjuZdvyMtVrMKYVHkfiyhH1K9BSDofb337Nu78idhZ+cpMn/LaF1SNskDB55N8SdSNaZ9JhI5blxjlPrkCUhb3qM5jZjrROGXXSzOMjZMJ2SsM9DMBZZ7+saC/bK9WVinZ9vwH0BqUY+eudpMqL3Hp6rvEQvB2Ma+R+Z7dHiAui0Pd205h57vWl1gzLtawls0BlA3Mttd8eP+G0hAUZcY0m1XtjFGOUrFUMVvH633w1ODAnBicoKSQ2bNKpF6RLxvAtsbby3rjIhZUdVS9nItyUhb2Ri8EqorpN3I6ZSmm2S7lOjQfuUqHblfxWvskAAYcaxf7ieEK4rE9S17EEJXunwdiC6SqEm22OHgiGih+7pefKX0OugQGOk78mzjBVNS9VDNK9bdQATKAj6+SfglFUzwrdEQD72a3Zf+lEU0yAtWC2AkhIBTBr/CsNof/pA5v+glLeGXgCr+9C5lyX+umTEzeNb7DBKs6c9nLU/CjXO/dS2QedgWrUEJqMUObKVQ4MRWgrDhc1ja2waXiQAeg3Nmo96+vW3kMD7I0A+Aig9mzS9uOGEWgFWbDmiXNF/qG0g715TbrdjndaeicW06HV7OvdoVZPZ/kmEvzY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(39860400002)(396003)(26005)(53546011)(6486002)(478600001)(41300700001)(558084003)(186003)(44832011)(86362001)(6506007)(2616005)(6512007)(2906002)(8936002)(5660300002)(71200400001)(31696002)(66446008)(8676002)(6916009)(4326008)(54906003)(64756008)(316002)(122000001)(76116006)(66556008)(66946007)(38100700002)(31686004)(36756003)(66476007)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjJZL25oUVUyNVYyaDd2bkJXb2d3M1YxNWRTRFdCWGxBUzBWTWhHSXlIWnly?=
 =?utf-8?B?L3VaeEJiS3IrQldVeHZHVTJLTG0rOG5hck1rSVBJeXU3Ym9ZbXlwN2o1c2I1?=
 =?utf-8?B?NENZT1JmbnhWWVN2ZDVLbHlMZHF4cTdtNFo1aVBxTm9QbHJZOWJtK3FEYm1T?=
 =?utf-8?B?YkxuSnEzUkJXUThEVEs1OTZoazlOeDhIUWF2QzVDVkpMa0UyRkFncTRBazlO?=
 =?utf-8?B?SHZTUkJYT1QvRVQvSGRtcXJ3dXNVNzNFOGFiZ1VFcjlTc1F3ZFNZVFp5OEhj?=
 =?utf-8?B?bXFRYWlSS29YL05aQU9yV29jNFk4bXEvYndZRTVmemc5Vk5IcW8yVHRYOCtn?=
 =?utf-8?B?YnZFUDRzMkFsRld2Z2FyQ0VyT0s0ZGF4OVd6bnBSOTNBTFF4TlVJd2xmamdC?=
 =?utf-8?B?Rnc1Rzd4QUk4VytaYW1IV2xtMVI4bXhoU0MyUUlYcGdhdUg2SGczdHN4K1lm?=
 =?utf-8?B?Mk9zemhYUS8waXVVbFgwdGdCNnFZM2ZzSGgwSVV3VjRvL1FpWS9rcmQ5Mmdu?=
 =?utf-8?B?RzR0Nm1xSmt5clE4ZERINkdHYkhMS3VjVUtPcVZhYnF3QVkxU2tHZUhBaFVN?=
 =?utf-8?B?ZXhiMXR2N0xZc0lMVndESm1wc2ovbWllNUJWcG81c0FaWlB4VzFWU2tGVmps?=
 =?utf-8?B?Rndkb0hOTENpWGp2WkZKRzdjbHRZTDJ1Ui93VHViUVI4N004Z1VrTWE0UzEw?=
 =?utf-8?B?bEM5cTM3UVhXSlhFSXVLWkdTbEFsMHZ2VWFCVTdaaFFscDBocUV5R3RDTXcr?=
 =?utf-8?B?OGZtUHhOLzlyVy9SNWNnODgxUytqSDZyeXVITzJKSk52dEhwZDdDNjloeFlx?=
 =?utf-8?B?c09QOGlsQnprUFlhTXVrdUZyUGxzbkdUcGlRb2FJVm9qVm42dXdzYy9lOHVp?=
 =?utf-8?B?T3RLY0QybEpxTElqMHhJblJnNlBrWVZFeU1NTVNYNmJaNy9uNGJweS9kYk5j?=
 =?utf-8?B?d1ZQVDhpMGpMS2MzMVVkRVAwM1BOWmM4M1lnMU8rbm9ma1RzQmZrYnpnMVI2?=
 =?utf-8?B?UFVmU0oxRVY1TC9JTVA5K3VOZnd5dzZyRzhVdlVJSURNSjJ2NFQ0dlNKRFN0?=
 =?utf-8?B?eGpmcTVzSVdZT3hyNlJlRS9MNlh0ODFyak5KVlY5OTdmMjVYa05uT1llLzk2?=
 =?utf-8?B?RCtDeExMYkdjMmE0MVNqbjRScFh3VURJcmRlaCsycTcwcFRjeUZCaDFseU03?=
 =?utf-8?B?Y21MU3pkaE1yVm1VRU5DdjlPejN5WnBTVFhwYjBiVE5ISmlSTzgwd2RDWGgx?=
 =?utf-8?B?cjBSRjhWWGVmeUljbGJKakFPcGxzemdWZEI2U05qOGYxMFk2T28xQ2dFMmRa?=
 =?utf-8?B?ZHY3RkxoMlpyS1ZvQWs0WG5pSjJQZXJTdXhWN0pmYkoyM3dqbmpIcVFETURm?=
 =?utf-8?B?NGxmYzZBMitCZVlxSk4zcG1pQUU4U2tiOHA0RkxXb0tjdUtmdHIrZDcrVmVp?=
 =?utf-8?B?MDJCVDZIa1lhdWcxQUoxZW9BdEJLNndXRVRvWEsrdHRKeDdnaXgvSzZMbGJK?=
 =?utf-8?B?dEh1NTVCN2MrWFlOL0N2VG8zSWYwNDBhMnNQcHRUZ2FVN2U5ZWUxQk5ZYmpM?=
 =?utf-8?B?RXhCSUkrRys5ZjZLRzl6Z2tXUGtYZytMYW5vczlISWh4a3lZV2NyVzlRL3Q0?=
 =?utf-8?B?eVBZY20xbEErdWkrT1hrN0NQd0hjWGlTdk9Xb2lHMmQrNVVoSVlZb20rNUhz?=
 =?utf-8?B?WkdYdVdzQWJPeWVzWUZJRzByVzZUR1ZRZTBKV0pGQlVkbnVHOXJuOFF3TVA5?=
 =?utf-8?B?QUdyN1ptbWxYZFdpSHNSaGIrZGNJdDV4UUxsajlkcmxDM2tlRVM2WFM2SGNX?=
 =?utf-8?B?VzIxcFpUL29HVlZUUm1sdUFXTU9ucm43cUE0TmhTem8veHVKVjBPbGxCZmVV?=
 =?utf-8?B?SWliYWNubkFIV0tIaDlSbWxNcEQ1V25hdTFRcVJ3eVJtZElEM00xY1dlanJn?=
 =?utf-8?B?ZWtuekVsVG1FK092ZUJwbkhkUXBXQlBseGpnR3FHakJzUTdxTERSRG1ObHht?=
 =?utf-8?B?eHErOW1tRnM0THhlMDFWcFlzYldaOXJZSmYzS3pPQUQ3VVJ3QWVvZEYwUjBh?=
 =?utf-8?B?QTBmNGdLUGJtWGZOVGRhY05UM0huNjlDaVV0YmlEWlgxcXJ0MllMZ1lNc1d3?=
 =?utf-8?Q?QYqg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E5D874576DC414D8A3EA9FD27C2E9EE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a5a98a-a198-436f-994a-08da5ac71c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 18:34:04.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wxLPlDhDtY0+9u5jDMjnI7WOVkn/bznB7b7/E+uenLM+5VS5GJ8dg31qeq0tUQECwXkWrLgWKHU0bU9EIOGPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=927 suspectscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300071
X-Proofpoint-ORIG-GUID: Z1tgvfwFjWtjiVSHn1n44AuG0wPhaiAO
X-Proofpoint-GUID: Z1tgvfwFjWtjiVSHn1n44AuG0wPhaiAO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8zMC8yMDIyIDExOjI5IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gTG9va3Mg
Z29vZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cg0KVGhhbmsgeW91IQ0KLWphbmUNCg==
