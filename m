Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9824D05FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244651AbiCGSHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbiCGSHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:07:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DFC7DE1F;
        Mon,  7 Mar 2022 10:06:47 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227HXjjj010114;
        Mon, 7 Mar 2022 18:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+ssB0IvHW00q9lczOo2Cp2AmAgIGkqWFJjjAkOJ6eN0=;
 b=0fmLmtaNF/motiewJkILG7IfeDkP8NWR0v8xaZfWZfv+QF4UZwM+Va8kGnqWxp+1zlZs
 XCE58/p1/+C3UylRLZjJbBgZPIMR4z1ov9FoO3+bIfyZWRnsX64jhZ9LcSw7q6hXEdma
 /8xyp5DStl7s5FZ1FY/uCecZpFLn3bax9pvJIGuXsHMlvYLsap7O2lGmzIC051n/5UGz
 aU9ZbAQuWLArzKtyFDi55NzQuJ2BqttUIr5WLbt8OskAHURDcVzDy0bmCbPj/J5uGn3z
 xuteY0VFVhLa5IZk8mp4JepXHl4mqpvDE9jdSPCLk0HjfvPkG2QZoSk8G8Dqc+OdNFQY Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cckw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:06:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227Hj7An132398;
        Mon, 7 Mar 2022 18:06:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3ekyp1c3cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPAzWZZjYVXiBWymOrJ6aH6FGO10Ff/swlrdO4KnhA4t2uGEa3T5FO976zDy908BkFLxL3/L80mktzK3WZzf6e41cp0r4PDvvzr5MO3+xJbXOMXHxMnoyytC/QK5xl7R/fMVplr613XNPva570V5xRfwHFVhKT4GTOOe00qlbpSa3EgTuAfPIrwslLxOzFcy5U170tVpfWdzMx8bCHOwnSL5XojAnwYbU9r1YLaerIjZ+9KXmW5CeKeXKdMepwSPvfi/snjrLl3THuiAMjQMA+zQFZtJRwZMeEDPWSmfEbRmOqQApZbcst3rzr0BE+wtgfmAg1Nnc1disPZe51gNmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ssB0IvHW00q9lczOo2Cp2AmAgIGkqWFJjjAkOJ6eN0=;
 b=RXlcdbU+W64CnNT09SxY0OoUZRnRITzDn1EtyvoNV6ar5uriX4fZSoLzAGA7UcGdrPj1BFJjtTKnPSCFJj8b0hgGOn/xCYCelZ16iLet3f/80gfvig+gbGzTLtRPimpBK46BzhwdgYCnn8j7jcPB0rfhEVFMTsKl61EegAclZM4HQ1CFFYtgtF29lTx5Y0k3Qz72GG/Hn1ZfVRLJoXKP5kb5YsbbrxYrhJz0xFvrSK5+7rLbl2X00WTVM0MuURV3DA5Bc0YI9MaNb3esxxocE5XybwF3HWtplehqSyh+f5Naqg5CLrwNA4lGc/RMObzIUtaHuaGDjshAezB5ENZFqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ssB0IvHW00q9lczOo2Cp2AmAgIGkqWFJjjAkOJ6eN0=;
 b=ktXFcRAjbaq/8fOGPfDaTGYkuWmCZUh97AKN/36KavlQR39zU1yw1EdYh+I+oNR3huyZjzdZ8AZsNvTzBkg7gX4oBsndP7/zLUCIEZ7xl95LvSPHczZu/o9Yvqgg+uIS8o9UkJ9RGNJjKXdrOMWnyx8rOYzKg0MnBc7xdU9HtUY=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SN6PR10MB3069.namprd10.prod.outlook.com (2603:10b6:805:cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 18:06:27 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 18:06:26 +0000
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
Thread-Index: AQHYLZNA834T4wj1IU2tnKIEwT0iJayvXcOAgATjNQA=
Date:   Mon, 7 Mar 2022 18:06:26 +0000
Message-ID: <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-4-eric.snowberg@oracle.com>
 <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
In-Reply-To: <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3bba741-5498-491f-a6a6-08da006532c2
x-ms-traffictypediagnostic: SN6PR10MB3069:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30694A5D6F3C0A6F9488881987089@SN6PR10MB3069.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2dmOtx7o7rSYAsS34zKS2Nd0tZnEQeZdumBH2gG+iOFQM+L3B/9FZCQAKmmOmg5ZlEBBOBJlErsmRvs4D2nE9DRVyfO0BlNswyimrHQ4PqXEbYzY2qgppl4ZWjNewo+gfY/zpFQ8I8ef9BVMwsZ9HCQD5tWbui9Dryl0rnoJxXpNDHxgWgJcxk4KFCtvTLf7pJd/hxnDooX5N/xMhsjMfAdlurZo89AY+zNBcDv9vMG4SFfiFzxX+0clzb359XXgyZfIwJRQmICuHN/zu9gL5tnHJYDdKDA9QgNSxl/WhDTglvqGjKEuEpH2BvcDbIkG0OuInS1Fw79U/qRLalnY0jqyMF6dnF1hZkgZX4dZDJwuIocxQWgfwv3CT6Y7lDkhVpGIM68bMI1HpzdyNLkxSvm+il6/syLmHgWU3gk8HCkvMwXYYoaI+4fYLjgwy8Z0ceAVeEPDZ6uKRlJ59da+MocAKxbuUNtywmA5WJqj3OavvAeIYTpw3Jm4aVceQ5r8CinFk273VSPwPKl+45B1DgMofTGRZj7RD3b9VtpOlQ9AJjYg0YteRURzDsDIbJrIf2i3DYzuf10xmkxpY9gGRZ8tAh9iQ6lFS0/vVNCHpDbIQehg/Mgti1DWjCtyJglY/7m0Ei1I6DKApggptYZBjDxVppPzHVlhi+anCG2/yAJ205Ol8Ip2Zpe5BswoZ6DzafYb7u/pvYi9dX9s70HYZcJK+92oSrdZsFSLlQM7RVzDuM27ijO67uyXRGbQdMUu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(71200400001)(316002)(91956017)(36756003)(5660300002)(86362001)(83380400001)(6506007)(8936002)(6486002)(4326008)(76116006)(64756008)(66556008)(8676002)(66446008)(66946007)(54906003)(6916009)(66476007)(38100700002)(6512007)(508600001)(2906002)(44832011)(26005)(186003)(53546011)(33656002)(2616005)(7416002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmF2dVZ6Z1lVT3JFVGpaejQvajFzekl4VXhwdUZYMG53akxENlp2NjVSSjlr?=
 =?utf-8?B?TjhTcTBVRDkvZlZ3eXFMMDF1Q2FteHdCdGx3ZnpiRmsyNHIwQ0VEem54MUdC?=
 =?utf-8?B?N2FRNGMyQlZOMEZhSG51ZUpFNGZTbmNXR0sxTlpVd2I3WXRlOTN3TkRBMXlU?=
 =?utf-8?B?WUs1Yyt6M1ZyM0tGZVp4SFRmNjZPRGp5aVcwR1F6emFFZjVWVy8zeXNuTTBk?=
 =?utf-8?B?Tk1ZRUVIS3FOSjJ6b1Awdjd6UnYzWXVlMC8xUVNPalNWNXVSQ2hQNGRRbEhQ?=
 =?utf-8?B?M2lMbC9ySE40WFBGamlQbmhXSmtaVjhINk9UeERVNFVGdHVYSlBKRXRwOFZP?=
 =?utf-8?B?ZGdvN2dpR1JCbm9uQzRnZ29UaTFLZFhKZ2dEUy92aC9zdWRkdnIzSWtvcGRl?=
 =?utf-8?B?SVhwbEZMM0x0T0pTUHFYYmovOC9wREVzeWxwcm9VRGxlN2NhMytLeVRvZ1ZL?=
 =?utf-8?B?K0lwVExQR2xjZEZEKzByYTFiUTI2YzdobU14a3FlSElMV2dIOXQ2K3lFYU0r?=
 =?utf-8?B?RGRBeCtLN1FwblFjUllpcWl6aExsbUlQRkUyRnpqWEQ4VWpLUkt5SXBWRzQ1?=
 =?utf-8?B?Y21UbFlNOXhOaWIvTUw0Z2VtNlUrYUtPOTMvWHQ5TURXbGNtV3p0U1NJMjRL?=
 =?utf-8?B?Z1FmNXNydUVQMCtkODEwTFdxUzVHQkZiTk1zOVhpK1VmRm0yUk1DalBucjdp?=
 =?utf-8?B?RDFXWlF6WlRra0JPcmNYaHkwUGpTRjhCYjYyTVY4bXhNUmNFY0lnMjZic1Nt?=
 =?utf-8?B?dTIvaUlDckVYeTlTdVZqakdOMFlsQ0JJb3YwbnhiQ0hmcXd1RzRXRkJuam1p?=
 =?utf-8?B?alcvVGd0c2lTTnJPSnBaWTBsaWl3MmRPZHJWbENNbzRhTDdlYU4zMDB1RHZF?=
 =?utf-8?B?dFhhQkk3M2t2cS9TbDJqN25OcE5ud0ExcGFOUGFITHRleFp6cXBaS201cVdY?=
 =?utf-8?B?S2Y3OENxNjEvM0VlZUh5NXBHaTIvU2c0RVNZK0trdXlyZjZWQ1BtcEF5WUFr?=
 =?utf-8?B?RFZiaVFEb2RTLzdRZklYWC9XY3hUcGdsR3NUUVVPMS9QOHZtV2IyeDRYR2hD?=
 =?utf-8?B?RXJ3RmZ6N216QUFieUk5dldTajcvZ3hwczlWaFhpN21JV1M0V3lsZ0wyVytk?=
 =?utf-8?B?QloyTWpHakFyeCtVcWVyV2c4ZEtCN1NoRmNWRzN3dlRkNmtJS3BSODEzdmVT?=
 =?utf-8?B?K01jOStaRjFORTFGT09KbzlZVTJ0aUJveGxSaVhQZG04ZmZQSzFJci9va200?=
 =?utf-8?B?eC9wZlJOTE1DOXAza3pmbElqSUwzS0R2cGVFakFtWmRFZ2tOMCtqakw5cURY?=
 =?utf-8?B?VnpPYm9CNkJ2TWtkdG9QVUNlenk2V2pBMHlMckJ6YzhQZTZ1UHRHaWN5UEZM?=
 =?utf-8?B?YVl0eHlxMnpNV0tjU3NkUkdML2hmdG9YbGwxeVJya0NyY3ZucGVKRTBzZzUx?=
 =?utf-8?B?WTFaOWRkSG9EYTJYWVNhc3hYd04wTWl5dTF3Z2VpSGxGZnllZ0FFR2lacmN2?=
 =?utf-8?B?TytVeVN5aFF1UTB2ZWxxNlpyV1U5aXJZVUkvTWZ0SHVPZnJkS0t2eW12Zm1W?=
 =?utf-8?B?NWk4YTRRWXZ2dXhKTmpVNnROTzc5bUFuZFNRVjlud2lRNVM0Ry96V2hQUzls?=
 =?utf-8?B?Q2QzbDV4aFNvVFJoUDJ3eW1rTUk0V0YzUmtISzRGc2Zic3JtSzFSUHhwc1hE?=
 =?utf-8?B?NlN1QS9POTVNR3REb0VMcG9XK29ranhmL2dQWVQwaXNxcHlKdGxWcldDT2Fv?=
 =?utf-8?B?UDY3Z2oxSWZnR1JMaFF0T05TNmRGcWRMQUtuU3VObzFiM255UkZQS0RHcFV5?=
 =?utf-8?B?ZkZ0M2tVOWx2VFA5TzRCVlVpeHU0cHhWUDR2Q3VCWnB4aTdDT3lvVk9qbjZj?=
 =?utf-8?B?eVFUQ2lvSDNTSU9QbTduVHZPNzJ6VmV1MVhGWGdaMW9GeWNoN1RJSWxEQnps?=
 =?utf-8?B?UUo1bENFbjliVmhjbTl2cm4yNHdNSURNemY4VUNsZVFWWC9JVTNaSHJjdzNX?=
 =?utf-8?B?RVlrUDE0bzNHVlZTOTVHKzVaZ1JZWVFxZUgyU0Fkb2hPRWRUcWIyUlEvL1cx?=
 =?utf-8?B?bkNMWlpheFlyamFORDVDWkVtcTFGNDRDUEgvL0Ryei81S2xVc3RiR3drZ3BZ?=
 =?utf-8?B?aXhacVRXY0N4YUxLWUlITG5hRmVKN01RMlZTSGVwVVhYdklVU3lOaFhjdENK?=
 =?utf-8?B?YjllRkgwZlJUdmE4YWE4TExrYkFwbk1UdkxEMU1YNjZpTGZyeW55Mm15clAv?=
 =?utf-8?Q?GipuJCxjCZnYdraopUlvWinnhTy93H+WHQapI36/l4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13B933C8A9B7074F869276A1B4044BAC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3bba741-5498-491f-a6a6-08da006532c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 18:06:26.8879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbzN1m9vd8m/uuIJHcYNs85NU8F8I0twVgdkvd8K7uO2d/Gg5ck+xGTMM2BO7NqfbJbN1DVH+H3aBT6s05Y8S2OAV8hDj/y1lthDoXd47P8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3069
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070102
X-Proofpoint-ORIG-GUID: jtVt5fJKVRIolcu3U94tu7jTbVk-fcIx
X-Proofpoint-GUID: jtVt5fJKVRIolcu3U94tu7jTbVk-fcIx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDQsIDIwMjIsIGF0IDg6MjggQU0sIFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJA
bGludXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiANCj4gT24gMy8xLzIyIDEyOjM2LCBFcmljIFNu
b3diZXJnIHdyb3RlOg0KPj4gQWRkIGEgbmV3IGxpbmsgcmVzdHJpY3Rpb24uICBSZXN0cmljdCB0
aGUgYWRkaXRpb24gb2Yga2V5cyBpbiBhIGtleXJpbmcNCj4+IGJhc2VkIG9uIHRoZSBrZXkgdG8g
YmUgYWRkZWQgYmVpbmcgYSBDQS4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogRXJpYyBTbm93YmVy
ZyA8ZXJpYy5zbm93YmVyZ0BvcmFjbGUuY29tPg0KPj4gLS0tDQo+PiAgY3J5cHRvL2FzeW1tZXRy
aWNfa2V5cy9yZXN0cmljdC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4gIGluY2x1ZGUvY3J5cHRvL3B1YmxpY19rZXkuaCAgICAgICB8IDE1ICsrKysrKysrKysrDQo+
PiAgMiBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQg
YS9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3Jlc3RyaWN0LmMgYi9jcnlwdG8vYXN5bW1ldHJpY19r
ZXlzL3Jlc3RyaWN0LmMNCj4+IGluZGV4IDZiMWFjNWY1ODk2YS4uNDliYjJlYTdmNjA5IDEwMDY0
NA0KPj4gLS0tIGEvY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9yZXN0cmljdC5jDQo+PiArKysgYi9j
cnlwdG8vYXN5bW1ldHJpY19rZXlzL3Jlc3RyaWN0LmMNCj4+IEBAIC0xMDgsNiArMTA4LDQ5IEBA
IGludCByZXN0cmljdF9saW5rX2J5X3NpZ25hdHVyZShzdHJ1Y3Qga2V5ICpkZXN0X2tleXJpbmcs
DQo+PiAgCXJldHVybiByZXQ7DQo+PiAgfQ0KPj4gICsvKioNCj4+ICsgKiByZXN0cmljdF9saW5r
X2J5X2NhIC0gUmVzdHJpY3QgYWRkaXRpb25zIHRvIGEgcmluZyBvZiBDQSBrZXlzDQo+PiArICog
QGRlc3Rfa2V5cmluZzogS2V5cmluZyBiZWluZyBsaW5rZWQgdG8uDQo+PiArICogQHR5cGU6IFRo
ZSB0eXBlIG9mIGtleSBiZWluZyBhZGRlZC4NCj4+ICsgKiBAcGF5bG9hZDogVGhlIHBheWxvYWQg
b2YgdGhlIG5ldyBrZXkuDQo+PiArICogQHRydXN0X2tleXJpbmc6IFVudXNlZC4NCj4+ICsgKg0K
Pj4gKyAqIENoZWNrIGlmIHRoZSBuZXcgY2VydGlmaWNhdGUgaXMgYSBDQS4gSWYgaXQgaXMgYSBD
QSwgdGhlbiBtYXJrIHRoZSBuZXcNCj4+ICsgKiBjZXJ0aWZpY2F0ZSBhcyBiZWluZyBvayB0byBs
aW5rLg0KPiANCj4gQ0EgPSByb290IENBIGhlcmUsIHJpZ2h0Pw0KDQpZZXMsIEnigJlsbCB1cGRh
dGUgdGhlIGNvbW1lbnQNCg0KPj4gKyAqDQo+PiArICogUmV0dXJucyAwIGlmIHRoZSBuZXcgY2Vy
dGlmaWNhdGUgd2FzIGFjY2VwdGVkLCAtRU5PS0VZIGlmIHRoZQ0KPj4gKyAqIGNlcnRpZmljYXRl
IGlzIG5vdCBhIENBLiAtRU5PUEtHIGlmIHRoZSBzaWduYXR1cmUgdXNlcyB1bnN1cHBvcnRlZA0K
Pj4gKyAqIGNyeXB0bywgb3Igc29tZSBvdGhlciBlcnJvciBpZiB0aGVyZSBpcyBhIG1hdGNoaW5n
IGNlcnRpZmljYXRlIGJ1dA0KPj4gKyAqIHRoZSBzaWduYXR1cmUgY2hlY2sgY2Fubm90IGJlIHBl
cmZvcm1lZC4NCj4+ICsgKi8NCj4+ICtpbnQgcmVzdHJpY3RfbGlua19ieV9jYShzdHJ1Y3Qga2V5
ICpkZXN0X2tleXJpbmcsDQo+PiArCQkJY29uc3Qgc3RydWN0IGtleV90eXBlICp0eXBlLA0KPj4g
KwkJCWNvbnN0IHVuaW9uIGtleV9wYXlsb2FkICpwYXlsb2FkLA0KPj4gKwkJCXN0cnVjdCBrZXkg
KnRydXN0X2tleXJpbmcpDQo+IFRoaXMgZnVuY3Rpb24gbmVlZHMgdG8gY29ycmVzcG9uZCB0byB0
aGUga2V5X3Jlc3RyaWN0X2xpbmtfZnVuY190IGFuZCB0aGVyZWZvcmUgaGFzIDQgcGFyYW1ldGVy
LiBDYWxsIHRoZSB1bnVzZWQgJ3RydXN0X2tleXJpbmcnICd1bnVzZWQnIGluc3RlYWQ/DQoNCmFu
ZCBJ4oCZbGwgY2hhbmdlIHRoZSBuYW1lIGluIHRoZSBuZXh0IHJvdW5kLg0KDQoNCg==
