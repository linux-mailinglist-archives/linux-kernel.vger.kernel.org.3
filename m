Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C04D0C1F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiCGXkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbiCGXkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:40:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D23383;
        Mon,  7 Mar 2022 15:39:11 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227LJOhM031953;
        Mon, 7 Mar 2022 23:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CWZWq3aZoedKOMS+S6LxgAG/D8PsKpVERZMlXLckStY=;
 b=c02BVFin9Pxm6zJSsdFOh3DfIy09DGyg7FVswSsagCq4jOvbTuce/q/aEi6Zbz00JH51
 f5yI0Y/HDBXwUIyYvI3mNonA6saXNKqQiLZAEO05RdxshE8oGWO4TurlRyXyHUl97MYo
 fTisMp2nYzDXrv2K8S5iOCQyFNmQRHNhutvZHprmuS6SLiXySA7/nHcxlWDk6h4RrT9S
 iZO9byDAejkFyyA2QWt33dD12eLvHjSRd2AghV1NtwSmm3CWzLI8n8X5VNfHSWrdUFan
 3lq1Bu9xRnd9eudh1wRcF0kKvLngbvLcCaIH3g6yRRyfPx22IHSqynlOoRheScKPMPVo /g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyran9sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 23:38:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227NKJOV058402;
        Mon, 7 Mar 2022 23:38:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 3ekvyu29ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 23:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUGIifiZ3LDdsfg3pI0SVwpli3ZFPcrX1ioB+AGHiTAesIoungxIzkwV1C7aN4Pvs9CIZWNUwEglJBQCn4CZPM6XIEnHMwyYh4OXHuEejsFqjOxEGPbav2IDaY6ufCJIelurRC4p5sevLtWS9tw1bBQi71DX5wWaIvHRS86DYrAWsrF7cNWmnB3IC1nRx1Qg+8KvjEWypodOptLHQKTNtfOeyIjkGFXVJBy5tkzEs9h+LlnohpO1dmbzf2pRWouKjYmqMUYTE0a9KzQGDtJcKldXTghSuSo/K4yPlq/vh6xGiyw35SGMFq1Xz+2KpabKifbi1y4kiFbXjXe8aXGQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWZWq3aZoedKOMS+S6LxgAG/D8PsKpVERZMlXLckStY=;
 b=H5MS8MkoJuapT6FiDKOnVEBCvoTFP1CS0SZFXWNIi/owVO21UxM+8K1gvNJrrizbcFy7xKE395m6/qAhr8xsRt5t9sOPnuk/dvXg5KTH4Uyx7NtiyD4I7ldyZrUkq39fITmwdeqDQmPwrLWBZ8e9D8ONRIGSIS/IZGe/I032VAJVDTY0PxrIKyxdoM02wLJZC7NKnnEnYRAs5zOoSdvUj0HIxMXu5Y4ojK5lC3Ih2UnNUw/vKqQCWSFf+RHYxC8RAzwRSJx1mKFKG5l+S6h8f/BdyFdqcinD3nAS95yL9/wNIiICZkEdSOpH1hOQCG7DRbyQYslHHYWvtKqDd5mHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWZWq3aZoedKOMS+S6LxgAG/D8PsKpVERZMlXLckStY=;
 b=Dg6paWAPQr/ZOFjVpt+LDr6YIm0UXAEoUbcLwDyT/DrIMrtXIhTKzKbyxNVKfcNTzyiQLVPBFuF/UapU4ZrIpndGyoxSwGGC2b8RI//KAX9fPo7X9pO6W8gnjhNhlApgXpY9Vy59xCxprWycAubzi/pjHHqqdW4TxMGwUjnWGmw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB3391.namprd10.prod.outlook.com (2603:10b6:208:132::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 23:38:48 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 23:38:48 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Stefan Berger <stefanb@linux.ibm.com>,
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
Thread-Index: AQHYLZNA834T4wj1IU2tnKIEwT0iJayvXcOAgATjNQCAAFKBgIAACluA
Date:   Mon, 7 Mar 2022 23:38:48 +0000
Message-ID: <67456A73-8B72-4DB6-8E23-7C603661A0A4@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-4-eric.snowberg@oracle.com>
 <47f3654e-892d-a35a-e77c-70ada1ebcf43@linux.ibm.com>
 <2415444C-AD8F-4F03-8B1C-C0770F83ADAE@oracle.com>
 <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
In-Reply-To: <e2dd58cd6074ae692256333b43b5ecde70bcdbdd.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63775f2c-61d5-4603-215a-08da0093a105
x-ms-traffictypediagnostic: MN2PR10MB3391:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3391A48849DEE178ABB25B6C87089@MN2PR10MB3391.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHUJbVfLcwWwtmsPJ1ehlxRyzwAlT14NWTEv3eAWykPeiY5ncrZy+O/UcE91APMA7LJm1iXHf1zE1A0arGC1hHb1KlmV5uq3ijV3D9vuv8Gfk3G33+HQ9Hz2un5udFgTXkSnZ65Sth9It0F3iuReLPP/Nj5yDtmFqV7QD7n5itYVmzNQmfHCzNWYyHPnWY3WpqBCvLsxtBr4p8nxed8J6n2Lc9JAyn4lKmjCEurr0vPyRpgSb4pVoyFWFv/xoPNZkl+lHz6tBsXxqTKQsa48sCbcHbALsVHvgk/g+pIF6/AXhX5TP+tYaXDAcJRO6YQ4NOcPUpDOB3W/HWYoPfGIEAGjEw9Z8S0ddvxvUA5DTlZfT/+noNLZ3fPgFW8T5xk4Sk/Pgxm8HAlhlz734Q0fKtUSVBVy96X0L8fxR2X60AyiUuXQu5Xhy6VSsRV4ZmM8rxBA2Qikibj10ZzmDYYIjxuTCHMMt0Qu1Ch2KiXZWJCedyCtF+zajp9Hy+cyb6MUwb1//oug177BezMty1GFt4j/ua9cavxhw2sUCdTxar6MdkFQTgYmojI5lnn/rdB1PoFQ5LGs6EtkC5hZfSvfTcqJASH7F1A3sCQ+TMksY9aflfVKHmj/pvoeVhh3z7XH8LJmU9CKgf8c+IR+4uwvVGgoHnGmI0L6XOQwFwFWS3jigEk0eP0SHBWIHnRw1asywP57bYwcO9VnN4Yzlo6/gLoYbinXHNxaI4KvADsk8y8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(316002)(83380400001)(33656002)(5660300002)(76116006)(66946007)(2906002)(4326008)(8936002)(8676002)(66476007)(7416002)(44832011)(64756008)(66446008)(66556008)(508600001)(2616005)(6486002)(6916009)(186003)(26005)(38100700002)(71200400001)(6512007)(6506007)(53546011)(54906003)(122000001)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yk8vUGZESlU2eGN1OUhxVFpBS09UeThlZWxRaUZGMjdzWXIrenpTVnVIbjdq?=
 =?utf-8?B?ejlrQXlWTkdadlRXaGJtTnZJMDFicytaQnMzdWFUTUNKdkZ5aDVRZ21BY2tS?=
 =?utf-8?B?NmxJYzA5ZGtSK3dXZXMyMG9rK1k5ZUptTVpLYkt3WmtSSUYrZ1hERG5jOXZF?=
 =?utf-8?B?bWJPd2ZvT1lGZ2M3UFFaTEVZVnc0SnBCZzQyaG1IWTFWWDYxcGhxV3BWR0No?=
 =?utf-8?B?dERsRnZXeGFVZ2ZHN2dVbTRyTTRTZ0JvdzBpS2JKL3RNNHFkR00yMEVpQzZm?=
 =?utf-8?B?d2xMSzZwcDhjWWRsQ1RCV3lmYVZITXV1ZW9GVzc5dWVQM1RtZlVoZ1FUNWNv?=
 =?utf-8?B?UCtCZkVNT0tVdkFkOXIyQVdqM0ZPUVRHMStRWDgyazZhZDUwaGx6TkpDUElX?=
 =?utf-8?B?aTdqV1prQThiWTJsY05mMU9mMC9HeE0vTlN5d3Y5bjFUNWs3dDNMSDIzYzE1?=
 =?utf-8?B?TEkrWnlPWXc3VnpNMThKQURiTk5DUUY5M2d6RkdaYzNyVk9TZGc2aGNRVEZ2?=
 =?utf-8?B?OVJTVks0YVdUclpKYTFvNnJFNnRMRXVLL0x4SVdyMno1dzJmeG5sUjBlR0Q3?=
 =?utf-8?B?Nko5a0pFdlFrWTI3UkN1Tnl3S3ZPNmgzOEtkMFhuOHY3cHd0Ukl6cU1kQ2dE?=
 =?utf-8?B?bG0vRXJyRW8vMUoyTldtOXhNSE5GZFgwMC9VR2VBOU5mdjRNK0pXSTJHQVV1?=
 =?utf-8?B?TVcxRkFkNVN2am8vNHNQUnNaK1FIU3NkaEJDSi85dkJHMEs3dVBsN3QxdWlv?=
 =?utf-8?B?ZCtrV2FoQ0JqaWZVSnRPU1M1aWtmWjUxM0x0d2xjb1YyZnZyT0JGMVJUaVJi?=
 =?utf-8?B?Z1dEMFludDVGTm9leTVUdkM4ZXZCenVNT2NocDdQa1BVa2RvNFJHMWMrMGwv?=
 =?utf-8?B?OFFIUXovVUs3REQ5UE42WWNNTHhnNTRjc0NOVkVWVVdyeFNFOVFRTGRCcUZv?=
 =?utf-8?B?NXVHR2dhTnZxRm5MMlkwQjAreGp0MkpDS2JHM1NoTjFoWTBmN3RuUFU1My9K?=
 =?utf-8?B?RGdjZlVxMlhUR28vZUsxa1JwcWNwZVF5ZWJGOVpYYlVUR1dvSmV2VTcrMUF5?=
 =?utf-8?B?eVNXN21aN084Y3p2QnZqRW14WlQ3SXdMd1g2djNlb2VPK0hoZnFiOFhNalRY?=
 =?utf-8?B?ei9NdWpWTGFNak5NcnZNYzI1bHhYeTJUUTRaZFZjYkFoTkZwM005V2lBakJi?=
 =?utf-8?B?NWd2R285RXZHTzFyS2ZCRkhwbTFHVkZKRzFra1REMUl1V21zMVFPem5EMUs1?=
 =?utf-8?B?eHpqWitMSVBkWGFzRVJHZ1N1UisxSUxjZDJiMTZKY3IxbDFsaU9POE5pa25I?=
 =?utf-8?B?Y2Z3d1lXQzZlMmZ4Y1ZoRHpXbnNNRzdTR3diSE5iSnZyY3NXUXZOYjFpM2Fu?=
 =?utf-8?B?emJCTzlyeUM4VEsyMzVHQW5rRGxLS0c5YlMwM2ZwM3hXRndZTThheW4rMitE?=
 =?utf-8?B?bi9xMnhMWGFjNE9LOHNweWdoem9FbkFWdEozN2FEME5CVGdmZDhNOFBDME9G?=
 =?utf-8?B?WlpVNzE1WUZtV3hKOU16c2VlbmNEdFlZaW5TaEdhNHozZlNqb1o3VkdidFhr?=
 =?utf-8?B?cHZDQ0lxd3p1U2tab0VBL2hxTVcvbUhId2F4dGgzYmpvN2lDaUFyK1NFcUZz?=
 =?utf-8?B?Y1lHNzQ5YStnTnFPTjkrYTN1Q1FNekhCSDhIQlVFQ1d1N29FTitYS0NOa3Za?=
 =?utf-8?B?YVd3YWtPd1ExT2VZMkxlMlJVVklOMEhEdm5wNXc3YUM3Tk5CUG9Sc3h0YUwr?=
 =?utf-8?B?YTM4WVNZQUJRTVhHR00vcG5QY2xWR244N0VzbEV6Qm83ZzNDOTNHeFVuUFdv?=
 =?utf-8?B?dFEvbGR2SldXdDhtcjVpRytLQXRLQnVlSXNyQlFXUkZ4QThneDlXVFl1dFpw?=
 =?utf-8?B?K213NzhGb3lJWTlLNmFEaDNEZDVWbFJHWVhGbTdTMkc4eGJqeXdLU3JMWkFj?=
 =?utf-8?B?TFZqY3J6VWovV0N3OUVzVkRrZVpRc0ZOcENZREpwdkVnZlhNb2c4OUdXQldB?=
 =?utf-8?B?V1crdXhWTWYzVExwUnQ5Y05ZL2ZIMWdTZXBEUW9YTFJSR2JyU1lQVjl1Q2tS?=
 =?utf-8?B?Q2IxYXpqc3I1MXdsMmxFTWw2UmkxVGhGaU9CaE8vMm5wZUNxZUM1Y21zbW9O?=
 =?utf-8?B?Tm8vMnNZaytmU0pKVUd5bWlObTlHUVRMYWk5MkJPWnFOeGVOdGs4QXd6WUNF?=
 =?utf-8?B?NElTRUtOcmp6MFZmRHN3cWZWek43eHlpck5sWWJuakRTZnNFWFpWUmF2Z0ZE?=
 =?utf-8?Q?5amgXuqj6Lz86qP/GiZJ2IhvQN5tqRh0lLp/oMPGXA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B18A34AB4C7CE341A2C3323E163205F4@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63775f2c-61d5-4603-215a-08da0093a105
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 23:38:48.6757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkFAiH6Ii8WVhM/d1BVJYwP6/fsvbVNje5FGQEPr1XKi0X7ivyo020n4a01s+lnAdDNdchp6EXwF/5psCPPqoPA6fU4ZPrjS0tiNkOI/EQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3391
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070119
X-Proofpoint-GUID: 8La2Kbi3p3ezJHMoT0yV8uygmVCJMmEu
X-Proofpoint-ORIG-GUID: 8La2Kbi3p3ezJHMoT0yV8uygmVCJMmEu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDcsIDIwMjIsIGF0IDQ6MDEgUE0sIE1pbWkgWm9oYXIgPHpvaGFyQGxpbnV4
LmlibS5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCAyMDIyLTAzLTA3IGF0IDE4OjA2ICswMDAw
LCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4gDQo+Pj4+IGRpZmYgLS1naXQgYS9jcnlwdG8vYXN5
bW1ldHJpY19rZXlzL3Jlc3RyaWN0LmMgYi9jcnlwdG8vYXN5bW1ldHJpY19rZXlzL3Jlc3RyaWN0
LmMNCj4+Pj4gaW5kZXggNmIxYWM1ZjU4OTZhLi40OWJiMmVhN2Y2MDkgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2NyeXB0by9hc3ltbWV0cmljX2tleXMvcmVzdHJpY3QuYw0KPj4+PiArKysgYi9jcnlwdG8v
YXN5bW1ldHJpY19rZXlzL3Jlc3RyaWN0LmMNCj4+Pj4gQEAgLTEwOCw2ICsxMDgsNDkgQEAgaW50
IHJlc3RyaWN0X2xpbmtfYnlfc2lnbmF0dXJlKHN0cnVjdCBrZXkgKmRlc3Rfa2V5cmluZywNCj4+
Pj4gCXJldHVybiByZXQ7DQo+Pj4+IH0NCj4+Pj4gKy8qKg0KPj4+PiArICogcmVzdHJpY3RfbGlu
a19ieV9jYSAtIFJlc3RyaWN0IGFkZGl0aW9ucyB0byBhIHJpbmcgb2YgQ0Ega2V5cw0KPj4+PiAr
ICogQGRlc3Rfa2V5cmluZzogS2V5cmluZyBiZWluZyBsaW5rZWQgdG8uDQo+Pj4+ICsgKiBAdHlw
ZTogVGhlIHR5cGUgb2Yga2V5IGJlaW5nIGFkZGVkLg0KPj4+PiArICogQHBheWxvYWQ6IFRoZSBw
YXlsb2FkIG9mIHRoZSBuZXcga2V5Lg0KPj4+PiArICogQHRydXN0X2tleXJpbmc6IFVudXNlZC4N
Cj4+Pj4gKyAqDQo+Pj4+ICsgKiBDaGVjayBpZiB0aGUgbmV3IGNlcnRpZmljYXRlIGlzIGEgQ0Eu
IElmIGl0IGlzIGEgQ0EsIHRoZW4gbWFyayB0aGUgbmV3DQo+Pj4+ICsgKiBjZXJ0aWZpY2F0ZSBh
cyBiZWluZyBvayB0byBsaW5rLg0KPj4+IA0KPj4+IENBID0gcm9vdCBDQSBoZXJlLCByaWdodD8N
Cj4+IA0KPj4gWWVzLCBJ4oCZbGwgdXBkYXRlIHRoZSBjb21tZW50DQo+IA0KPiBVcGRhdGluZyB0
aGUgY29tbWVudCBpcyBub3QgZW5vdWdoLiAgVGhlcmUncyBhbiBleGlzdGluZyBmdW5jdGlvbiBu
YW1lZA0KPiAieDUwOV9jaGVja19mb3Jfc2VsZl9zaWduZWQoKSIgd2hpY2ggZGV0ZXJtaW5lcyB3
aGV0aGVyIHRoZSBjZXJ0aWZpY2F0ZQ0KPiBpcyBzZWxmLXNpZ25lZC4NCg0KT3JpZ2luYWxseSBJ
IHRyaWVkIHVzaW5nIHRoYXQgZnVuY3Rpb24uICBIb3dldmVyIHdoZW4gdGhlIHJlc3RyaWN0IGxp
bmsgY29kZSBpcyBjYWxsZWQsDQphbGwgdGhlIG5lY2Vzc2FyeSB4NTA5IGluZm9ybWF0aW9uIGlz
IG5vIGxvbmdlciBhdmFpbGFibGUuICAgVGhlIGNvZGUgaW4gDQpyZXN0cmljdF9saW5rX2J5X2Nh
IGlzIGJhc2ljYWxseSBkb2luZyB0aGUgZXF1aXZhbGVudCB0byB4NTA5X2NoZWNrX2Zvcl9zZWxm
X3NpZ25lZC4gIA0KQWZ0ZXIgdmVyaWZ5aW5nIHRoZSBjZXJ0IGhhcyB0aGUgQ0EgZmxhZyBzZXQs
IHRoZSBjYWxsIHRvIHB1YmxpY19rZXlfdmVyaWZ5X3NpZ25hdHVyZQ0KdmFsaWRhdGVzIHRoZSBj
ZXJ0IGlzIHNlbGYgc2lnbmVkLg0KDQo=
