Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027FF4D68A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350931AbiCKSq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCKSq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:46:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350241D306E;
        Fri, 11 Mar 2022 10:45:21 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BFxIOv011140;
        Fri, 11 Mar 2022 18:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JpnKjWxIWeHrLPcdU6i0FX1h+xZuU5ZjGgtp6PUblCU=;
 b=oaHT2NWTkL7NQsd3KCwoyKaCHvW8u9M4ooWasz0dHfXlVa4H3CKFa1ipaJAAAZNqSh4Y
 PZpq2xmoKy6wk1Q1/eJh0t1mg+LcrVtTelisWUxLT9/s+KlOhZe2z1LeaSHnklFSMuBz
 +RbhX58dpWecI+05AQjCMQPbU/hv5KNkKoLnpcj+dzCot/NSZZPYdsUlD7/DkhyBWwIX
 iUa6h2v1olWgUJYqp9BHfK6Vd7dbF7G9Xqz67rbw4jqAN9GqmbeglSXFCNFxP4UFI2wk
 00Tpnadr5ogu0nzpFtjdTZifZJna7zsMwhfPBFA2Eyuv/1d8S0SYBgT3sdc6hTVUHEeb 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2t1wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 18:44:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BIff5o045614;
        Fri, 11 Mar 2022 18:44:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3020.oracle.com with ESMTP id 3ekyp4djp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 18:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5/egjANuDkNymaBR1iocG5Nz3D7TJHycGERp9SvpLjifzCQYSfAEXoYXKZY8lSyYqBFp8XTbq0Al1eTjyMKL8uBqToJsLWad+a5hdFfGlPzYnBZW6QY7WHtL0CTGUVyIWR/gaWRgNgYzZ1+BhnaM8ltbqYR9ub/bao6uVlrtkCvE6URSTB0eYiBCEHexMskzqghilbidecVy9UQFKh1ick5AUgeEay3PGTfelIfRLn/Xy3JpetMbjNXqfFBt2VPBci/3yfjmswihQ516H7Ra7ZBoxiIqOKA7KnorwC8s3D3lYQShCuhbqMaW+/HFc1RxkPcY1YN3Gq0G8cQQ+e7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpnKjWxIWeHrLPcdU6i0FX1h+xZuU5ZjGgtp6PUblCU=;
 b=CR2yRpZkT0wQYrQ0CGH+gUzahi0fiY/SlOG4Ng+nnsNI0FbHIoDNAnVzGDaoEGxtUWnUQ2T3nLKjBgznJaU59k0WkDO2Udoszm4cOX8MDSleS8TguzziYZkmsHmeuGLt5V4kSjnekYpdsZJu2LWKU/tHk0ktsqaG/guPf7WEaaFT8N9cLGpE2/TXHPd9eoc+V8+pVfKoFVw+w87mLZ3QJfY6ROQclycOS+Z34brfgM/87ncYNp9AiqMfcydfYD9U81HNp0mdvDr8g/U/0Em1q/A/P38hUm3xKetWmmD9lQvXTjkV2qmCMgVlLD10nPJDqOqiXS8lrK8mus/vH+IXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpnKjWxIWeHrLPcdU6i0FX1h+xZuU5ZjGgtp6PUblCU=;
 b=ks0P7Hl1j+EG2v4PTBtQqRN3r7tOZwKqfSa1HjQUjz+veExgsCfKEMwy3aRG6VlsynlQEDhcIg2tVFOLXyQ/qd/4Y3mM98E6eqDAMoaR1kLmEvb2Bj+IObXcBP0TFzMF+GgoiKCFvN8zIyjOL1OFqJ0vYGUsHBqqIx7Y2eePBGM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BLAPR10MB5219.namprd10.prod.outlook.com (2603:10b6:208:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Fri, 11 Mar
 2022 18:44:31 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%9]) with mapi id 15.20.5061.024; Fri, 11 Mar 2022
 18:44:31 +0000
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
Thread-Index: AQHYLZNA834T4wj1IU2tnKIEwT0iJayvXcOAgATjNQCAAFKBgIAACluAgAAwN4CAAKt3gIAAWKsAgAGEcYCAABEVAIAADY+AgAMfrAA=
Date:   Fri, 11 Mar 2022 18:44:31 +0000
Message-ID: <00B288C0-5011-4706-B393-481910489FFE@oracle.com>
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
 <B9A8F5BD-5FDE-4501-9C0A-865579C45627@oracle.com>
 <9ea53711-73ab-d242-9eb6-87497c8dc7ac@linux.ibm.com>
In-Reply-To: <9ea53711-73ab-d242-9eb6-87497c8dc7ac@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a45b56e7-515a-4858-af10-08da038f2de7
x-ms-traffictypediagnostic: BLAPR10MB5219:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5219C7B19693C9E657A96BB2870C9@BLAPR10MB5219.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 46wpRw/1e7aQepQ+3rJ07NYgsYGaAIlEmT1349kisJ9jsUbZZ7gGWd6xHLD9niVs8oEtK6EOFNv7WpAYc5RMFbVZetnMcT2e/07Kt9JKCAQx5UpCstDgE2GvVvZbzsHz4EkhxcEDuurRfmsX8rdUTMFIa7sHzh4ipfNxwsrtrq5pqsrxJvi73aFNqwPNGQxmU70FUef75YkxLs8ahTX2ibN+xUCEe+ZCc/1a8sMvHFwc8zueQDXbAJXRefwj2sGysZiAzYImF7HZmjFc6BABLYIFS5y0Pq8SjenpPn34kUdCTBkYf+ITr1T9hbVWXjRw6D/KRG1N2I6IJzrbIjK+sO7EkoWK9WmrH95meYizT+y0OVeADlwpLcIJXkGbAeHQrhLs70ljOkSweRTn5WLk7ZEzD4guwxFAmOaXcr/+XwpH7H8iGxJ3CM38qHqrQ+rK1CxlGCfUepAq/cPZSKCzVLo8Ddi3X9BHTJCq6uwBy8lUlgOROl1+noHS8aKJNMXujmdKStG89epBBvA6HiMUFJzSrJti5hgvqK5UVv0Es+QS+YfcKOJUgcUHKh3NOffgZTgccnUxOWp26MK4KAFoxVkB7/Ztp52RuPkyGQv771ZM4LFewiUrCA6VEhYjDT12j1WzAUnNt6PEv/46ZivmUi9+ZKYUVLrU2zHMH7+z5KdHKnqKomiT9MHHuCx76wzZapNkrA0e6iKejI8GFzW/BofjdP8OQz+dYUizJunzSvaj06k+qZ76r0fiqh+hgsLna3jnUfQLT1yDF81icfVe6mNw+ZMNf2kWjmwQWJ5t66OtnSpFSQ0w1uQSYmqj/2XwloOLZl/e2qmPOfZUq24QnnH+ZEDSF8kxENEEpS8k/EY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(2616005)(7416002)(8936002)(44832011)(122000001)(186003)(38100700002)(83380400001)(33656002)(2906002)(86362001)(6512007)(6506007)(66446008)(66476007)(66946007)(66556008)(53546011)(64756008)(4326008)(36756003)(8676002)(76116006)(316002)(966005)(6486002)(508600001)(71200400001)(6916009)(54906003)(5660300002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MStkOTNqK095clYwdjRUbkhuOHg4cXhaYkdLaERDZ1FtcGZGWHI4Q0FzQlJo?=
 =?utf-8?B?V2podzlZTWQvVzdkQk50cEQ3Rnh1QnE1Qk0yNTBYb1U2byt5V2pVbHFrejNC?=
 =?utf-8?B?bGNGZWdvYXd6dkJ0dmtKc1daY3dvQ1RCLzRlYU9rV29heWJOWEtpZy9OVHlE?=
 =?utf-8?B?QWlFN2IyNDZVN1duY3NiTVR1UFhEZjFVazNwWE9YYitvbkQxV2NVTzJTR2Fl?=
 =?utf-8?B?S2FIdVYrWU1qOWsvQ2dJT3hoKy8wMU5WNk5ZeGJLT0NhdlFtUkxzTmJ2Y1hE?=
 =?utf-8?B?cVh3NDRlM0ZUYWtiVVpNYVRQblY0OFR4R2tSanJYTlJxZFhXL1VGeFBPcEtm?=
 =?utf-8?B?UWNUNVRRbmVPMVd5bWI2bTEzM0lyRWp0c0t1U2Q0UEcvNWEzYVRTRkdoSUll?=
 =?utf-8?B?TWxiRkNvMTYyc25UNzhsT2dDM1lRSTFmT2tiWXh5T2J3UW01c21FUWlOQ0g4?=
 =?utf-8?B?NWVyMXVvMGZtaTNGdFlFSDgzTmN1NHQ0UDZLc1orQStucHdxNWV3KzFEbmxD?=
 =?utf-8?B?STQxQmo5ZDhqYW1wSnc2SDNKUWRJYXg2dnRIVVJ6VTIvOGNtZ25LL1FRTWtM?=
 =?utf-8?B?Y0tFRnJMbHVXbTFBcVExa3hSd3hBNW9pZmtRWDFKNVUyTjF2blJKOFBnc3ZE?=
 =?utf-8?B?cTN0WjV6bzF4RVFLSlp4SjMvSGhvUEU4ZThEMkwzYjZ4Y1dhWUE2V2tKSVp4?=
 =?utf-8?B?R0hhVkQweUE2OE1BNDNtZXBRUllzellHbFFFUEo4MDl2YTRhOXJSbHNEK3cx?=
 =?utf-8?B?LzcrQnppNURVT1hHaTAyb25wR3NSb1lPN0Z0Z2k2c1l2SGJXTmtjZk5hOE5N?=
 =?utf-8?B?L0YzMXhZTzdUbGt4MWdveUdjWkhiOVU3dW5hQjkxRzZud2hoTGQxUXA1L2wz?=
 =?utf-8?B?b1JBNGRlam1IYVZDaWgvK3RxOHpKWmd6bHRTTEJuYkZHUjdCVGFUdFpoVy82?=
 =?utf-8?B?Qm9qZHJaR3pOVktTaEx0d0xWMnlkelFXVE5TdkVSMmRkREM5QVlRd08zbnVB?=
 =?utf-8?B?eUdKcU1xUEZVa0YxaDJkNWpDR0MxcWVSTHUzcG5WVjZHdCtNWWtxYzJ6cjhO?=
 =?utf-8?B?c25wMkx5eS8yYmlTdGZNZDBOUitwS1RzVjhJQ1pGZys4WENxa0ZRdHBUcENU?=
 =?utf-8?B?NWQzM09mY2hvZm8yWVVPOFpub2dtNGZONmJVVDhkdDZKeE1wVmpZelgvQkhn?=
 =?utf-8?B?bVMrcDRLdnphK0R6SHlaRXovQVR0ODNId3U5clpxZ2t2Z3JKYmw1VXZTVzRE?=
 =?utf-8?B?S1ltMEo1Zy9Cc25kSFJYWlQ5QUJhb1Zza0w3NE85cE45d1Q0R0FFYkpjY21t?=
 =?utf-8?B?ZERldWljZUJadHJQVHJqMUt1aDQ0UlQ1MldoRXI2NjJYbnJ2YVI3M3hIVWpw?=
 =?utf-8?B?U3NnZDV4b0w5a2s0U0Njd1IwMUVpWXovZ0VGQ2ZsSGJaNE96QytUcDRzYkZj?=
 =?utf-8?B?ekdWb0VJMlpqZlpkWU9XNThISXgzbHVNZTNqV1pHWnF5eUhLTHRmeFhqa0VP?=
 =?utf-8?B?S0trWmd0akRhRGxEbjljRXh4eXFWbmowWjI1S0pKUVFmN2o3Y3NVenNHTnRh?=
 =?utf-8?B?M1lmV2YrOExkclo3UnovdUR2aHRqMmhJS0pCV0VRWWZQbXZFQ1lHTEFlNUtt?=
 =?utf-8?B?d0dmSHpJSFdHY2w5T0lMbmdMS0FQZTBaWm1HeFhYY0V1ZGR6MEN3dTI1TS9x?=
 =?utf-8?B?TkQ3Y3VJNlNyNDZDRStNTGkwN0t2ejlrcFpmejdzSkZzcFFkNkYxckhkSXZr?=
 =?utf-8?B?cGlmdHlvUkhkTjdLcm5wTkpraUNTY3pVRXBUV2FlSjBNNGNiUTE4d09RYVho?=
 =?utf-8?B?VTZCNm5Qc0R0SDB5RXhtQ2grZXpha3FNeVMrdnh0c0o5VVRPQzNiRHpvckpM?=
 =?utf-8?B?Vk1kNWR1OGlMdUU2aVdVdVMwOEpDbnRJRnhpdlUxTmdRQ3lqaHk2RUVJb0RY?=
 =?utf-8?B?YjRYamlyd21UN2wrb2hkYTZJeUZLSk1vVURqaTlXN25jbmNEQXo2NGVXaHZN?=
 =?utf-8?B?cmhjUzJocElRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34B04688F1168E4C827CD118EE5A70FF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45b56e7-515a-4858-af10-08da038f2de7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 18:44:31.0774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71DN9nfF2gaoKgJCOskAbs8BN6mUJihXoRRbITemrGWrooqOXIvPLW8lCJNujTXxyUp+S4hfmc2FGwezqzu6fbGRCmxg6uwtezc7SEHbvm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5219
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10283 signatures=693140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203110092
X-Proofpoint-ORIG-GUID: 68Byw06MqsWlX_bsYvnvz0r57HFUnS1r
X-Proofpoint-GUID: 68Byw06MqsWlX_bsYvnvz0r57HFUnS1r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDksIDIwMjIsIGF0IDEyOjAyIFBNLCBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5i
QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiAzLzkvMjIgMTM6MTMsIEVy
aWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4gT24gTWFyIDksIDIwMjIsIGF0IDEwOjEyIEFNLCBTdGVm
YW4gQmVyZ2VyIDxzdGVmYW5iQGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IA0KPj4+
IA0KPj4+IE9uIDMvOC8yMiAxMzowMiwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+IE9uIE1h
ciA4LCAyMDIyLCBhdCA1OjQ1IEFNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3
cm90ZToNCj4+Pj4+IA0KPj4+Pj4gT24gTW9uLCAyMDIyLTAzLTA3IGF0IDIxOjMxIC0wNTAwLCBT
dGVmYW4gQmVyZ2VyIHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IE9uIDMvNy8yMiAxODozOCwgRXJp
YyBTbm93YmVyZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IA0KPj4+Pj4+Pj4gT24gTWFyIDcs
IDIwMjIsIGF0IDQ6MDEgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4LmlibS5jb20+IHdyb3Rl
Og0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBPbiBNb24sIDIwMjItMDMtMDcgYXQgMTg6MDYgKzAwMDAs
IEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0
IGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0cmljdC5jIGIvY3J5cHRvL2FzeW1tZXRyaWNf
a2V5cy9yZXN0cmljdC5jDQo+Pj4+Pj4+Pj4+PiBpbmRleCA2YjFhYzVmNTg5NmEuLjQ5YmIyZWE3
ZjYwOSAxMDA2NDQNCj4+Pj4+Pj4+Pj4+IC0tLSBhL2NyeXB0by9hc3ltbWV0cmljX2tleXMvcmVz
dHJpY3QuYw0KPj4+Pj4+Pj4+Pj4gKysrIGIvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0cmlj
dC5jDQo+Pj4+Pj4+Pj4+PiBAQCAtMTA4LDYgKzEwOCw0OSBAQCBpbnQgcmVzdHJpY3RfbGlua19i
eV9zaWduYXR1cmUoc3RydWN0IGtleSAqZGVzdF9rZXlyaW5nLA0KPj4+Pj4+Pj4+Pj4gCXJldHVy
biByZXQ7DQo+Pj4+Pj4+Pj4+PiB9DQo+Pj4+Pj4+Pj4+PiArLyoqDQo+Pj4+Pj4+Pj4+PiArICog
cmVzdHJpY3RfbGlua19ieV9jYSAtIFJlc3RyaWN0IGFkZGl0aW9ucyB0byBhIHJpbmcgb2YgQ0Eg
a2V5cw0KPj4+Pj4+Pj4+Pj4gKyAqIEBkZXN0X2tleXJpbmc6IEtleXJpbmcgYmVpbmcgbGlua2Vk
IHRvLg0KPj4+Pj4+Pj4+Pj4gKyAqIEB0eXBlOiBUaGUgdHlwZSBvZiBrZXkgYmVpbmcgYWRkZWQu
DQo+Pj4+Pj4+Pj4+PiArICogQHBheWxvYWQ6IFRoZSBwYXlsb2FkIG9mIHRoZSBuZXcga2V5Lg0K
Pj4+Pj4+Pj4+Pj4gKyAqIEB0cnVzdF9rZXlyaW5nOiBVbnVzZWQuDQo+Pj4+Pj4+Pj4+PiArICoN
Cj4+Pj4+Pj4+Pj4+ICsgKiBDaGVjayBpZiB0aGUgbmV3IGNlcnRpZmljYXRlIGlzIGEgQ0EuIElm
IGl0IGlzIGEgQ0EsIHRoZW4gbWFyayB0aGUgbmV3DQo+Pj4+Pj4+Pj4+PiArICogY2VydGlmaWNh
dGUgYXMgYmVpbmcgb2sgdG8gbGluay4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IENBID0gcm9v
dCBDQSBoZXJlLCByaWdodD8NCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+PiBZZXMsIEnigJlsbCB1cGRh
dGUgdGhlIGNvbW1lbnQNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gVXBkYXRpbmcgdGhlIGNvbW1lbnQg
aXMgbm90IGVub3VnaC4gIFRoZXJlJ3MgYW4gZXhpc3RpbmcgZnVuY3Rpb24gbmFtZWQNCj4+Pj4+
Pj4+ICJ4NTA5X2NoZWNrX2Zvcl9zZWxmX3NpZ25lZCgpIiB3aGljaCBkZXRlcm1pbmVzIHdoZXRo
ZXIgdGhlIGNlcnRpZmljYXRlDQo+Pj4+Pj4+PiBpcyBzZWxmLXNpZ25lZC4NCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IE9yaWdpbmFsbHkgSSB0cmllZCB1c2luZyB0aGF0IGZ1bmN0aW9uLiAgSG93ZXZlciB3
aGVuIHRoZSByZXN0cmljdCBsaW5rIGNvZGUgaXMgY2FsbGVkLA0KPj4+Pj4+PiBhbGwgdGhlIG5l
Y2Vzc2FyeSB4NTA5IGluZm9ybWF0aW9uIGlzIG5vIGxvbmdlciBhdmFpbGFibGUuICAgVGhlIGNv
ZGUgaW4NCj4+Pj4+Pj4gcmVzdHJpY3RfbGlua19ieV9jYSBpcyBiYXNpY2FsbHkgZG9pbmcgdGhl
IGVxdWl2YWxlbnQgdG8geDUwOV9jaGVja19mb3Jfc2VsZl9zaWduZWQuDQo+Pj4+Pj4+IEFmdGVy
IHZlcmlmeWluZyB0aGUgY2VydCBoYXMgdGhlIENBIGZsYWcgc2V0LCB0aGUgY2FsbCB0byBwdWJs
aWNfa2V5X3ZlcmlmeV9zaWduYXR1cmUNCj4+Pj4+Pj4gdmFsaWRhdGVzIHRoZSBjZXJ0IGlzIHNl
bGYgc2lnbmVkLg0KPj4+Pj4+PiANCj4+Pj4+PiBJc24ndCB4NTA5X2NlcnRfcGFyc2UoKSBiZWlu
ZyBjYWxsZWQgYXMgcGFydCBvZiBwYXJzaW5nIHRoZSBjZXJ0aWZpY2F0ZT8NCj4+Pj4+PiBJZiBz
bywgaXQgc2VlbXMgdG8gY2hlY2sgZm9yIGEgc2VsZi1zaWduZWQgY2VydGlmaWNhdGUgZXZlcnkg
dGltZS4gWW91DQo+Pj4+Pj4gY291bGQgYWRkIHNvbWV0aGluZyBsaWtlIHRoZSBmb2xsb3dpbmcg
dG8geDUwOV9jaGVja19mb3Jfc2VsZl9zaWduZWQoY2VydCk6DQo+Pj4+Pj4gcHViLT54NTA5X3Nl
bGZfc2lnbmVkID0gY2VydC0+c2VsZl9zaWduZWQgPSB0cnVlOw0KPj4+Pj4+IA0KPj4+Pj4+IFRo
aXMgY291bGQgdGhlbiByZWR1Y2UgdGhlIGZ1bmN0aW9uIGluIDMvNCB0byBzb21ldGhpbmcgbGlr
ZToNCj4+Pj4+PiANCj4+Pj4+PiByZXR1cm4gcGF5bG9hZC0+ZGF0YVthc3ltX2NyeXB0b10tPng1
MDlfc2VsZl9zaWduZWQ7DQo+Pj4+IFdoZW4gSSB3YXMgc3R1ZHlpbmcgdGhlIHJlc3RyaWN0aW9u
IGNvZGUsIGJlZm9yZSB3cml0aW5nIHRoaXMgcGF0Y2gsIGl0IGxvb2tlZCBsaWtlDQo+Pj4+IGl0
IHdhcyB3cml0dGVuIGZyb20gdGhlIHN0YW5kcG9pbnQgdG8gYmUgYXMgZ2VuZXJpYyBhcyBwb3Nz
aWJsZS4gIEFsbCBjb2RlIGNvbnRhaW5lZA0KPj4+PiB3aXRoaW4gaXQgd29ya3Mgb24gZWl0aGVy
IGEgcHVibGljX2tleV9zaWduYXR1cmUgb3IgYSBwdWJsaWNfa2V5LiAgSSBoYWQgYXNzdW1lZCBp
dA0KPj4+PiB3YXMgd3JpdHRlbiB0aGlzIHdheSB0byBiZSB1c2VkIHdpdGggZGlmZmVyZW50IGFz
eW1tZXRyaWNhbCBrZXkgdHlwZXMgbm93IGFuZCBpbg0KPj4+PiB0aGUgZnV0dXJlLiBJIGNhbGxl
ZCB0aGUgcHVibGljX2tleV92ZXJpZnlfc2lnbmF0dXJlIGZ1bmN0aW9uIGluc3RlYWQgb2YgaW50
ZXJyb2dhdGluZw0KPj4+PiB0aGUgeDUwOSBwYXlsb2FkIHRvIGtlZXAgaW4gbGluZSB3aXRoIHdo
YXQgSSB0aG91Z2h0IHdhcyB0aGUgb3JpZ2luYWwgZGVzaWduLiBMZXQgbWUNCj4+Pj4ga25vdyBp
ZiBJIHNob3VsZCBiZSBjYXJyeWluZyB4NTA5IGNvZGUgaW4gaGVyZSB0byBtYWtlIHRoZSBjaGFu
Z2UgYWJvdmUuDQo+Pj4gDQo+Pj4gSXQgZG9lcyBub3Qgc2VlbSByaWdodCBpZiB0aGVyZSB3ZXJl
IHR3byBmdW5jdGlvbnMgdHJ5aW5nIHRvIGRldGVybWluZSB3aGV0aGVyIGFuIHg1MDkgY2VydCBp
cyBzZWxmLXNpZ25lZC4gVGhlIGV4aXN0aW5nIGlzIGludm9rZWQgYXMgcGFydCBvZiBsb2FkaW5n
IGEga2V5IG9udG8gdGhlIG1hY2hpbmUga2V5cmluZyBmcm9tIHdoYXQgSSBjYW4gc2VlLiBJdCBo
YXMgYWNjZXNzIHRvIG1vcmUgZGF0YSBhYm91dCB0aGUgY2VydCBhbmQgdGhlcmVmb3JlIGNhbiBk
byBzdHJvbmdlciB0ZXN0cywgeW91cnMgZG9lc24ndCBoYXZlIGFjY2VzcyB0byB0aGUgZGF0YS4g
U28gSSBndWVzcyBJIHdvdWxkIHJlbWVtYmVyIGluIGEgYm9vbGVhbiBpbiB0aGUgcHVibGljIGtl
eSBzdHJ1Y3R1cmUgdGhhdCB0aGUgeDUwOSBjZXJ0IGl0IGNvbWVzIGZyb20gd2FzIHNlbGYgc2ln
bmVkIGZvbGxvd2luZyB0aGUgZXhpc3RpbmcgdGVzdC4gS2V5IGluIHlvdXIgZnVuY3Rpb24gbWF5
IGJlIHRoYXQgdGhhdCBwYXlsb2FkLT5kYXRhW10gYXJyYXkgaXMgZ3VhcmFudGVlZCB0byBiZSBm
cm9tIHRoZSB4NTA5IGNlcnQgYXMgc2V0IGluIHg1MDlfa2V5X3ByZXBhcnNlKCkuDQo+Pj4gDQo+
Pj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTctcmM3L3NvdXJjZS9jcnlw
dG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfcHVibGljX2tleS5jI0wyMzYNCj4+IEkgY291bGQgYWRk
IGFub3RoZXIgYm9vbCB0byB0aGUgcHVibGljIGtleSBzdHJ1Y3R1cmUgdG8gZGVzaWduYXRlIGlm
IHRoZSBrZXkgd2FzIHNlbGYgc2lnbmVkLA0KPj4gYnV0IHRoaXMgc2VlbXMgdG8gZ28gYWdhaW5z
dCB3aGF0IHRoZSBrZXJuZWwgZG9jdW1lbnQgc3RhdGVzLiAiQXN5bW1ldHJpYyAvIFB1YmxpYy1r
ZXkNCj4+IENyeXB0b2dyYXBoeSBLZXkgVHlwZeKAnSBbMV0gc3RhdGVzOg0KPj4gIlRoZSDigJxh
c3ltbWV0cmlj4oCdIGtleSB0eXBlIGlzIGRlc2lnbmVkIHRvIGJlIGEgY29udGFpbmVyIGZvciB0
aGUga2V5cyB1c2VkIGluIHB1YmxpYy1rZXkNCj4+IGNyeXB0b2dyYXBoeSwgd2l0aG91dCBpbXBv
c2luZyBhbnkgcGFydGljdWxhciByZXN0cmljdGlvbnMgb24gdGhlIGZvcm0gb3IgbWVjaGFuaXNt
IG9mDQo+PiB0aGUgY3J5cHRvZ3JhcGh5IG9yIGZvcm0gb2YgdGhlIGtleS4NCj4+IFRoZSBhc3lt
bWV0cmljIGtleSBpcyBnaXZlbiBhIHN1YnR5cGUgdGhhdCBkZWZpbmVzIHdoYXQgc29ydCBvZiBk
YXRhIGlzIGFzc29jaWF0ZWQgd2l0aA0KPj4gdGhlIGtleSBhbmQgcHJvdmlkZXMgb3BlcmF0aW9u
cyB0byBkZXNjcmliZSBhbmQgZGVzdHJveSBpdC4gSG93ZXZlciwgbm8gcmVxdWlyZW1lbnQgaXMN
Cj4+IG1hZGUgdGhhdCB0aGUga2V5IGRhdGEgYWN0dWFsbHkgYmUgc3RvcmVkIGluIHRoZSBrZXku
Ig0KPj4gTm93IGV2ZXJ5IHB1YmxpYyBrZXkgdHlwZSB3b3VsZCBuZWVkIHRvIGZpbGwgaW4gdGhl
IGluZm9ybWF0aW9uIG9uIHdoZXRoZXIgdGhlIGtleSBpcyBzZWxmDQo+PiBzaWduZWQgb3Igbm90
LiAgSW5zdGVhZCBvZiBnb2luZyB0aHJvdWdoIHRoZSBwdWJsaWNfa2V5X3ZlcmlmeV9zaWduYXR1
cmUgZnVuY3Rpb24gY3VycmVudGx5DQo+PiB1c2VkIGluIHRoaXMgcGF0Y2guDQo+IA0KPiBFdmVy
eSBwdWJsaWMga2V5IGV4dHJhY3RlZCBmcm9tIGEgeDUwOSBjZXJ0aWZpY2F0ZSB3b3VsZCBoYXZl
IHRvIHNldCB0aGlzIGZpZWxkIHRvIHRydWUgaWYgdGhlIHB1YmxpYyBrZXkgb3JpZ2luYXRlcyBm
cm9tIGEgc2VsZi1zaWduZWQgeDUwOSBjZXJ0LiBJcyB0aGlzIGRpZmZlcmVudCBmcm9tIHRoaXMg
Y29kZSBoZXJlIHdoZXJlIG5vdyBldmVyeSBwdWJsaWMga2V5IHdvdWxkIGhhdmUgdG8gc2V0IHRo
ZSBrZXlfaXNfY2EgZmllbGQ/DQoNClRoZSBpbmZvcm1hdGlvbiB0byBkZXRlcm1pbmUgaWYgdGhl
IGtleSBpcyBhIENBIGNhbiBub3QgYmUgZGVyaXZlZCB3aXRob3V0IGhlbHAgZnJvbSANCnRoZSBz
cGVjaWZpYyBrZXkgdHlwZS4gIFVwIHRvIHRoaXMgcG9pbnQsIG5vIG9uZSBoYXMgbmVlZGVkIGl0
Lg0KDQo+IA0KPiArCQlpZiAodlsxXSAhPSAwICYmIHZbMl0gPT0gQVNOMV9CT09MICYmIHZbM10g
PT0gMSkNCj4gKwkJCWN0eC0+Y2VydC0+cHViLT5rZXlfaXNfY2EgPSB0cnVlOw0KPiANCj4gVGhl
IGV4dGVuc2lvbiBJIHdvdWxkIGhhdmUgc3VnZ2VzdGVkIGxvb2tlZCBzaW1pbGFyOg0KPiANCj4g
Y2VydC0+cHViLT54NTA5X3NlbGZfc2lnbiA9IGNlcnQtPnNlbGZfc2lnbmVkID0gdHJ1ZQ0KPiAN
Cj4gWyB0byBiZSBwdXQgaGVyZTogaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUu
MTctcmM3L3NvdXJjZS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3g1MDlfcHVibGljX2tleS5jI0wx
NDcgXQ0KDQpUaGUgaW5mb3JtYXRpb24gdG8gZGV0ZXJtaW5lIGlmIGEga2V5IGlzIHNlbGYgc2ln
bmVkIGNhbiBiZSBkZXJpdmVkIHdpdGhvdXQgaGVscCANCmZyb20gdGhlIHNwZWNpZmljIGtleSB0
eXBlLiAgVGhpcyBjYW4gYmUgYWNoaWV2ZWQgd2l0aG91dCBtb2RpZmljYXRpb24gdG8gYSBnZW5l
cmljDQpwdWJsaWMgaGVhZGVyIGZpbGUuICBBZGRpbmcgYSBmaWVsZCB0byB0aGUgcHVibGljIGhl
YWRlciB3b3VsZCBuZWVkIHRvIGVpdGhlciBiZSANCng1MDkgc3BlY2lmaWMgb3IgZ2VuZXJpYyBm
b3IgYWxsIGtleSB0eXBlcy4gIEFkZGluZyBhIHg1MDkgc3BlY2lmaWMgZmllbGQgc2VlbXMgdG8N
CmdvIGFnYWluc3QgdGhlIGdvYWwgb3V0bGluZWQgaW4gdGhlIGtlcm5lbCBkb2N1bWVudGF0aW9u
LiAgQWRkaW5nIGEgZ2VuZXJpYw0Kc2VsZl9zaWduZWQgZmllbGQgaW1wYWN0cyBhbGwga2V5IHR5
cGVzLCBub3cgZWFjaCBuZWVkcyB0byBiZSBtb2RpZmllZCB0byBmaWxsIGluIA0KdGhlIG5ldyBm
aWVsZC4NCg0K
