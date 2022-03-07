Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F54D05E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbiCGSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiCGSD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:03:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA8B35DE9;
        Mon,  7 Mar 2022 10:03:00 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227GZ5eF006695;
        Mon, 7 Mar 2022 18:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JFKQC2qDcAxFsJg199xapUsy8cXBufGmccidD43gDHY=;
 b=D95ynMT7ChVlkdz+RHf68HWY/gEjlwMRn60U4AAJNhcAwC73W3vSJKQ7oEs6w0k8ctCi
 GEXEcVBdFU30Js9f1+VZ1psRJmaZCjj9bTfqiFl6u/8L9tQefprb5kncDnBBqi9jXzHu
 XVs5Lgf3oTkcgZHIUkmxC4EWfLhAHd0ffEurkfQ5SIqdAk80koTD9unCqDGWkjFT1ndA
 d3Nsm7uHysN98un0DGf820SJTXjX6ce5XkmpkLRd5DeeYB55zTzqiBsUFriHWJld9XrG
 EcLwKtmO82NeVG75kQLmZwD7pKemWw28gk2opbs3Iw3Bk3j0JOt6Acth8SAhCF23qbeM mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2cpjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:02:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227HjXDf172786;
        Mon, 7 Mar 2022 18:02:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3ekwwb6pgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:02:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYzFR9AcwcDgQSHkSfiHKW2JD8d5B1bEiQfHcQhhJTtomCgqCo+nlMBt0eLxRPG/CCjwF1zHpzrZDxr01oMkGOgnwbVVp3LKxL2s7rCFfU3jvG2ViDDoN2x8aY+Bj6kKq2npZSnuYLGleZQzJm1cXE1yTCRB9e/saMPu82+JAUdHCeVPOirqc4xrBintK+3aZTWAWwGSXW0tJmaB1geGjFT93CfFqwnfl4Ov5TnbK0oyYx7smSTGoCXngLzk0y+37sm9JX4XobV6la/Y3a0nmVVQ4phSKbF+/C9W1ojn9xCSqwxfBssIxqOOUsUTOtfJ4JFZJpWHtnxBBtHTy2kdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFKQC2qDcAxFsJg199xapUsy8cXBufGmccidD43gDHY=;
 b=lAzEq6E3aE2ZK2SY9XvG0+tUng+UBE6OqaReCRt6VTz8DZ+lYesm1iaTTvsiQfqdUa1/z0pRSZQl8oh1Bf+HFTyuEZEIulJT1fQiARZ184gsIwKBmdXsIfgTFIha0t/+LKuh9fqAcN739S2dfVQ59jwhNCH0LTvMGgAD2F/gQrYqEPURyyPLyPp71e6vXopO0qHckRl00qFHRp3Giqhx8Cfxvk/8Ow4oqORkCDXgqS+Cyd443wOZ9qmN7pNl35OMXuZcW2AY1FGzPyYrLUn274P31Xfmw+in3ygQESdBSwZkXH0oZ0hVe/a9TOdciwYnTeBB3q22dWNfWNnM0xTgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFKQC2qDcAxFsJg199xapUsy8cXBufGmccidD43gDHY=;
 b=tPhOwW3AVZSsya4w2Xf/ris54GsL8eFP3M8QCH063/XM+4SRK4G/yt2BNC1gce3xKJz9G7NqQiWzEn5onnOXjmOCuEiOd7QuGWdkqYrhTmiyvzgoiCuFGHLBJ1m3OMufLmu3q6Pb/Gx0cokq2JIMBAIIygLpSABuLPFfUJhI4VI=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BYAPR10MB2757.namprd10.prod.outlook.com (2603:10b6:a02:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 18:02:24 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 18:02:24 +0000
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
Subject: Re: [PATCH 2/4] X.509: Parse Basic Constraints for CA
Thread-Topic: [PATCH 2/4] X.509: Parse Basic Constraints for CA
Thread-Index: AQHYLZM/8AZOeMx5bEqX9zzePWmrgayvWMOAgATnFIA=
Date:   Mon, 7 Mar 2022 18:02:24 +0000
Message-ID: <6236924C-AAC2-4437-B068-87A032544934@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-3-eric.snowberg@oracle.com>
 <b6e9eb1e-846c-c98e-ad16-c651b5e1dad7@linux.ibm.com>
In-Reply-To: <b6e9eb1e-846c-c98e-ad16-c651b5e1dad7@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac58e61-30f6-42a1-51b0-08da0064a20b
x-ms-traffictypediagnostic: BYAPR10MB2757:EE_
x-microsoft-antispam-prvs: <BYAPR10MB275767A7D8DE1A48A854023587089@BYAPR10MB2757.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJrK7/w09wXcP6FvToaXQExiikA1o20gBV9t4fQMni/QLteArFS0YLy/7IiNza71+t/WyIrCfMSZ5ra7XF27wcIsertZlIjDa4yS+AvyBW0zODSgKr0kUPy2Jazipyqey7c9At6ZyBajxzLKiJ8DJIbIl08ki7PEYyin48jJEq8kP01tGcgPmglTqL30eBGMv5pdo/hD77phnVc5/TA/roONdsgpRs6REyqrG9tt6zRZgslYmFmISMUiep5GW83cWeEy2uopdWYUWc7Vm/WcdrLb+veFwu+jJtclkg8a9Z211O/twtNBwGTIXJ2FT1FUuWPodiPqjuTl/TyAfXOablE8vHU0q6EkwKKiWvmdI0fGfQ6kg4o7vJhMiH3n3bbl6iC6AtCq7tehuTJJMtZIajEmx9y2hiCyVF32Mh9lsiI6fGaKG1fDkuvmoqvq7B90k3XbAt05ELXmRRQXidWJEJcszRKhs9Wtg85jpwDWfECSz6Pj1nOfbOXVqJ3RbDaoIWvR2+jsukVLykgScDP6+d39HOx9mmCP46gI/h/6SC/KU8WaldWed6ksLYpLZw2Wca3HEo1L3pwlSx1mrh2zSG9s5Aon9lg9KZDR+Wyj+XGXiI5FgiL69XGljgAhKrC+WnzYkKXGs++CYfibzQ0NbW+MQwNOMdMmfzXe1CfCrt13L+uxeHDaPjMd+h5x5jC+AWls0nfvqlPebX7BMrwCgdXIvzlxBOX5zKo8RPWC+WM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(26005)(8936002)(53546011)(66556008)(66946007)(66476007)(66446008)(64756008)(8676002)(54906003)(7416002)(6916009)(44832011)(5660300002)(186003)(83380400001)(36756003)(6486002)(86362001)(2616005)(71200400001)(2906002)(122000001)(6506007)(6512007)(508600001)(33656002)(76116006)(38070700005)(316002)(91956017)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wjhya3VhcmhsM1Q2aGlKYXNuY0xsb05TcEZrcGNSczZOemJMY2lPVlZtK2pG?=
 =?utf-8?B?ZlhtV0FhYlJmTTlNelJydko5eEZ6NU5IdXRBRTRiSFZvL1lseDFvazhVc3Av?=
 =?utf-8?B?K1hmem9SUklVYzNIMW52Tm45dHYzTWhrbU93ZHNFdjhNM252MmR2UzdWUGUr?=
 =?utf-8?B?a3lPQTRvdnN5ZTE0OCtIbStta0hrVXY5NE4ydzdLcG54eGhGcGVUbzhhMGti?=
 =?utf-8?B?WjNrU3ozWVZRU1YranRaZnZLOVhTNFZDWW5UbTM3RSs4QUo0RGNEYnNUdnlS?=
 =?utf-8?B?bHcxVXMrQkdHSG1ZSFpYVUhKQm9KN0laMFZzTTBmNzkyY1lkT2ZRQ0Q5VXNP?=
 =?utf-8?B?Mm9wMVhhcHNJVitzb1hhcG13WkJRQ0U4Y1QwdFdSV3l5dlpYU0g3RDJxajA1?=
 =?utf-8?B?Z0N3YzlQajZqN1k4clk0UStyTmx5Y1VZS2l4ZkNzM1ZHT3RmRitHczk0S0Ns?=
 =?utf-8?B?M2txejhMV0xFR2VneFljN3FxanFSNjJWemtZK1BndHZsemlFayt0VzhhbDBm?=
 =?utf-8?B?L3VoVlRCSUVVRVptOW1VMER1RkFFZXBFd1RxeVJERTFvcUZ6WndTZldPV1lQ?=
 =?utf-8?B?c3FzcmZOVHR1b0xwNFZhbmw0U3NkRFUzSjlPMFpUaktJRzc1UmlOblUyM2dQ?=
 =?utf-8?B?aWdRMG1pdWVDK1lERFVNRnV2bWpEZzE0RTc5SEsrZ0MveVhENTRyRDNNYzdw?=
 =?utf-8?B?MGtrb1VkTVpCSDRXUG93UjFMQ253RmxtWnVoV0huVGNWemozcE16SUhuN3Z4?=
 =?utf-8?B?QSswbUt4RTk5d1hXaXJxYWRGVXBoRXRpODJDNWtqUnBsbkxNYjZmWm13WjU0?=
 =?utf-8?B?SitrWVMxU3J0ZmE4QWFIVjEzcEFJV1dlQjkvb1hFWk9MYVhmT0VzU0lsWDRt?=
 =?utf-8?B?SWh0N3Voc2JlY3FSQVdDMzVlWkFmdlZpNDN1NkJlYllUL21oN2psRC9TNkVC?=
 =?utf-8?B?alRrTDJ5c3ljbUQ4bUVhazJHK0RaY0FqZDd2eXNqQUVkMHpFUlVxOTZSVWFF?=
 =?utf-8?B?UWJsdEw4bnQyeXBTZTNlamlYWis3QmgwT2ZhTW14VSt1c3Z2N0xxNVM4UjNu?=
 =?utf-8?B?RWd3Uk12bFJEQ3owWDZPbFN5b1k0Tnhyd05zR0VsM2sxSThyQkNIMzYxRSto?=
 =?utf-8?B?aUo2a09RLzQxZlNlSkg1QXduUGtKTHNYQWV0bS9uWEttaDRpSkxQNi9nclp2?=
 =?utf-8?B?Q1dheTladTgyQVRaK1RaOTNldTJyZXJTMWR6RUEyMGRrOWhZZm9qUXlYTjJi?=
 =?utf-8?B?LzBkcldJNDBLZTFHQWxJN080Y2kxYWE0eWhaTTRESkRPNjIxNXQ0bnU4N0E0?=
 =?utf-8?B?OSt3cGkwV1FrNjdoQWtPK1BXUnA0Tk5ocFpXRk5TNHBqWXQ5UkwzWmdCTTMy?=
 =?utf-8?B?TS9YekVkRzB2d0d3WThQaHE2ZjA1djNPTVlibnhmeDJ2ZTBZSHVXTXltQWpV?=
 =?utf-8?B?RTFxNTduSjQyeHZIODdnL1R0dFp4TWR2aUZRTWJxUjhqUmc1NFNqcjRkaG90?=
 =?utf-8?B?Yy9OYVBKcjhYaUUvNFRocEZpK2dpNUZwTm8vcU5jSEs4WnU2UEpnMnoyNng2?=
 =?utf-8?B?YmVRb3psbUxwVkJ2ZzdTY25qR09iWXArenI4aU1BR1NjbWJPSGdTbFIxMjRB?=
 =?utf-8?B?cXFINys1WHR3aWNmWlByQ21HaDZOTWF0VzNrZk1VeDZva0FDeGk1dEZ3UXMy?=
 =?utf-8?B?T2p5eEpPenovU0s0dlZtKzVSZnJtRk9PaDFDQkRwU1lVeVNkT1N6RkliR2U3?=
 =?utf-8?B?ZmFiOGVhYUZwRXpwYTJJd1lCM1ZYVVRZanQ0Q3pEbHFaNFpwMXBWelZ5T3dh?=
 =?utf-8?B?NWNOeXF0N2xacU8ybXNJQWpZSlNoUUZ0UEZSZGhWOG1uTEZYY0Z0VjF6VkVz?=
 =?utf-8?B?OVplMzlQbVRRV1A2ZDcwNS90NkpHeU5oVCs1SWQweFdCSXFNaTBreFNUVEdt?=
 =?utf-8?B?R3N1RUc1NEZuMkkvUkIxTmlyVndQbUxobzU4Zm12K0R4WHpBQjJ6dWplSWtH?=
 =?utf-8?B?ODRGMnRFdUQzTFQ2RlFhcC9JajVTWGhrTkxrL2hCMTd2Ry9JYjRVTzB3eTBr?=
 =?utf-8?B?dnp0ZXBJWUlWT1BoUGhJSlZLWW91MXRtZm9hdzhleXNoNysvMzdXUlA5V2tF?=
 =?utf-8?B?djlPZk5lTFZIMDZ4UHVPV0YwbnNkbVhYUk4zSEJlQ1ZxZHdiMVRYK0dQeVla?=
 =?utf-8?B?cWdZVUZyRm0zbW5vUWYxTXNYS05jbUg4ZzlLK2pROG9uS0tBdWJsYjdLdThm?=
 =?utf-8?Q?XLPmtT7rWM3XNgEFDwxMX/PBF+4MtuDn8By//v1phk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2807416EDE0EF744B2F4B37A7155885D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac58e61-30f6-42a1-51b0-08da0064a20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 18:02:24.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1y9vHwYbJJVKI/2UieZaL5U8YKcFXxyMe8imKNqcLnwYBGjEiclzY+XWEY6whjCVT+0rwnZXJm561iRcn2I3npSJWG//xB7UHT2A684PEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2757
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070102
X-Proofpoint-ORIG-GUID: DaqDILx0pKYqJ1GD-7UN16x7HbcfNZOO
X-Proofpoint-GUID: DaqDILx0pKYqJ1GD-7UN16x7HbcfNZOO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDQsIDIwMjIsIGF0IDg6MTAgQU0sIFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJA
bGludXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gT24gMy8xLzIyIDEyOjM2LCBFcmljIFNu
b3diZXJnIHdyb3RlOg0KPj4gUGFyc2UgdGhlIFguNTA5IEJhc2ljIENvbnN0cmFpbnRzLiAgVGhl
IGJhc2ljIGNvbnN0cmFpbnRzIGV4dGVuc2lvbg0KPj4gaWRlbnRpZmllcyB3aGV0aGVyIHRoZSBz
dWJqZWN0IG9mIHRoZSBjZXJ0aWZpY2F0ZSBpcyBhIENBLg0KPj4gDQo+PiBCYXNpY0NvbnN0cmFp
bnRzIDo6PSBTRVFVRU5DRSB7DQo+PiAgICAgICAgIGNBICAgICAgICAgICAgICAgICAgICAgIEJP
T0xFQU4gREVGQVVMVCBGQUxTRSwNCj4+ICAgICAgICAgcGF0aExlbkNvbnN0cmFpbnQgICAgICAg
SU5URUdFUiAoMC4uTUFYKSBPUFRJT05BTCB9DQo+PiANCj4+IElmIHRoZSBDQSBpcyB0cnVlLCBz
dG9yZSBpdCBpbiBhIG5ldyBwdWJsaWNfa2V5IGZpZWxkIGNhbGwga2V5X2lzX2NhLg0KPj4gVGhp
cyB3aWxsIGJlIHVzZWQgaW4gYSBmb2xsb3cgb24gcGF0Y2ggdGhhdCByZXF1aXJlcyBrbm93aW5n
IGlmIHRoZQ0KPj4gcHVibGljIGtleSBpcyBhIENBLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBF
cmljIFNub3diZXJnIDxlcmljLnNub3diZXJnQG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICBjcnlw
dG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfY2VydF9wYXJzZXIuYyB8IDkgKysrKysrKysrDQo+PiAg
aW5jbHVkZS9jcnlwdG8vcHVibGljX2tleS5oICAgICAgICAgICAgICAgfCAxICsNCj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2NyeXB0
by9hc3ltbWV0cmljX2tleXMveDUwOV9jZXJ0X3BhcnNlci5jIGIvY3J5cHRvL2FzeW1tZXRyaWNf
a2V5cy94NTA5X2NlcnRfcGFyc2VyLmMNCj4+IGluZGV4IDI4OTllZDgwYmIxOC4uMzhjOTA3ZjRj
ZTI3IDEwMDY0NA0KPj4gLS0tIGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy94NTA5X2NlcnRfcGFy
c2VyLmMNCj4+ICsrKyBiL2NyeXB0by9hc3ltbWV0cmljX2tleXMveDUwOV9jZXJ0X3BhcnNlci5j
DQo+PiBAQCAtNTgzLDYgKzU4MywxNSBAQCBpbnQgeDUwOV9wcm9jZXNzX2V4dGVuc2lvbih2b2lk
ICpjb250ZXh0LCBzaXplX3QgaGRybGVuLA0KPj4gIAkJcmV0dXJuIDA7DQo+PiAgCX0NCj4+ICAr
CWlmIChjdHgtPmxhc3Rfb2lkID09IE9JRF9iYXNpY0NvbnN0cmFpbnRzKSB7DQo+IA0KPiBEb24n
dCB5b3UgaGF2ZSB0byBjaGVjayB3aGV0aGVyIHlvdSBjYW4gYWNjZXNzIHZbMF0gYW5kIHZbMV0/
DQoNCkdvb2QgY2F0Y2gsIEnigJlsbCBhZGQgdGhlIGNoZWNrDQoNCj4gaWYgKHZsZW4gPCAzKQ0K
PiANCj4gICAgIHJldHVybiAtRUJBRE1TRzsNCg0KSSB0aGluayB0aGlzIHdvdWxkIGJlIGJlc3QN
Cg0KPiBvciBzaG91bGQgaXQgZXZlbiBiZQ0KPiANCj4gaWYgKHZsZW4gIT0gMykNCj4gDQo+ICAg
ICAgcmV0dXJuIC1FQkFETVNHOw0KDQpzaW5jZSB0aGUgbGVuZ3RoIGNvdWxkIGJlIGxhcmdlciB0
aGFuIDMgaWYgdGhlIG9wdGlvbmFsIHBhdGhMZW5Db25zdHJhaW50DQppcyBzdXBwbGllZC4NCg0K
