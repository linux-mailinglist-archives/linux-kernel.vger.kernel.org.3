Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385854EE22A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiCaT5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiCaT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:56:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D6C62A2D;
        Thu, 31 Mar 2022 12:55:08 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22VHP791019889;
        Thu, 31 Mar 2022 12:55:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4NafIhNVRFaM/bmLNo33KOzF+QqZKoSA3+aQE+I53yE=;
 b=nb7CRBuWdsklTUmCsCyzbE/eecv0VbXzci4aA9i3J88S43ccemOUK1ccMnoaLAOSsS/J
 hpV26BKYfvx840i4HXLcHhiwCvbjd1z2Wyd5MGWxeb6DsBrCWzwoEUeig9EjoRm1CAvV
 vKhnCzqeL10WEoO4kgqqfhaXtXAE/2tHpHk= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f5gpc9fn0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 12:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5/G4sQOTO+yc22FM2hiQuF2uauTfFY4Cm//venx/g8hjGf+GjKRX2FZ5qJ93fk+3nkfH/QP8f+1iE3c3rmpHA+rPWsHjrDe7HrEwlvPkh+P/iOvrCePNMXWiJK2g3HBWpTxM8+ieZbZK92r8IOYNa1eCDu32Ov32v65vpx0P/zv8xXnP18YLrZSpP72iRlEZ/DyCKtee6KxQ6AibulcYNoTOXdnDb4h5fqF/hBqigzMfeuxt75nNVFCQoH/WQ/NhdEm4nIbgBtSeb+6dKSyodmYM87OFvgNHPuwBlQr/MlV65HjudtD2XI/X9YD6CIRTM7oCivHU+yQEX0zXEHBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NafIhNVRFaM/bmLNo33KOzF+QqZKoSA3+aQE+I53yE=;
 b=WyNQhAF0KSzzhzOu558M2hGYxSbUuxKAVmt9AkQU0ZlpMVF2Yav6bLRIIqoq5i4QbtQLYnqUBtf97woJnpbOMiLbb4XNIGm29ZRSQyveq5aLhtnHARnr8yTh23TH4f22taSjgUvhGY+rnoT/JeP6PN4I/sgHbqm9C/itHjOwamTSWJ8SoYKxoexiFth499aTJb6BgHQYfumKOyYdIvRaOJ7OWUviv9ZSgHRQ0xdJqum/IXOX8OfpbjfaSEXGMJQoHk6YRqTVKP4C7YBdz1soFL1nAErfn+fe3ropXKERE+tRMbapsi8ggFWFmE5EIZHKSjZA39wzCZkcN6D67u1LnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by MN2PR15MB2687.namprd15.prod.outlook.com (2603:10b6:208:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 19:55:04 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::19c8:a3f2:1fa6:e36e]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::19c8:a3f2:1fa6:e36e%5]) with mapi id 15.20.5123.021; Thu, 31 Mar 2022
 19:55:04 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Kees Cook <keescook@chromium.org>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH][next] lib: zstd: Fix Wstringop-overflow warning
Thread-Topic: [PATCH][next] lib: zstd: Fix Wstringop-overflow warning
Thread-Index: AQHYRGvmfUnFab/1LEKDPzR9L194iKzYdYcAgAF0DYA=
Date:   Thu, 31 Mar 2022 19:55:04 +0000
Message-ID: <AC568A96-E2E3-4A56-B993-05ED7B5326AF@fb.com>
References: <20220330193352.GA119296@embeddedor>
 <202203301416.568595B87@keescook>
In-Reply-To: <202203301416.568595B87@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa22e344-d9e3-4a8e-385c-08da13505940
x-ms-traffictypediagnostic: MN2PR15MB2687:EE_
x-microsoft-antispam-prvs: <MN2PR15MB2687F5AC57D12111226195BFABE19@MN2PR15MB2687.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XOH0BBk+FlRilSkvPYXpi3egq3gH7LrhIfdser5nQ/5ws5p7Ppbda0XgKKdkWEk1gkWr6pkfEQUMKbGTg9xwIlwKRJuXd65GaawlO2FeFVPzr8nCtLWMdWDM9Cp9w+26wpjhcATs/Pahy5sc+Lznbzv1TLSfegDxoDM7M0zNif/ayub745QdYQiJzkFmUUpa+svFzltx4pOmH+Dq3383IVHiFgkEpIK5+JSh5bk0fQ4HLMDPLw2LcOgLhtP2M9RDLQEttQ9+WR5KGu08ui/PrB/3qJyNsJHY2GfZxIUDcj4L8Svr9IcXgo3S4iX3msBueAEWpYcwLN1GP4p6COS8BVZaLBBC6C91YDf1MLBna6LltlHr7ikzUmSvE+hvPXgaHD2WvVgoBsoZAtgeDRUp3554pA0zydL9UwywVxCg7rM8CqJZHZn3DWFsb5qomcmqvrnr8tdlxjB7Z3wQN0Iq3Dih3AJQAt5Yr86nJzkPQJrPEtyvDZkEFw2lVS4S+AjrmilOCVi9FR2uyH6GaGzocKibPCjV2LL1xCUeBAVEqciCaicjN2YG6n6Z8GpfURXUr4kP6EqjMZpP5eBxL7QzI6ZmFZwADfgAju0M6JLpaX+pa5bKJiXRC2zOCaJ+yD5XBJu57O8TGTnkNVc9Yl35V26CDJFwls3fD46gF134pqCrlB2cm/V90NAbpQfOII+Dqe4zNq82g2nRAu6lg4t+xWMpnP/3nbxsVZ+OTMM2IASm7YwqUNvuq99IMwVs7arna2ddgknefLwbJ5JkOq4LgAY5lqhJ24INJoecDWDgA3QFVz53lYQUy16ZGOkLElbntTpRXGcF95SOk6TXHA4Amo7WZkR/7HzMVDx+bbchwik=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(186003)(122000001)(38100700002)(38070700005)(86362001)(316002)(4326008)(966005)(6486002)(71200400001)(76116006)(36756003)(2616005)(8676002)(66476007)(508600001)(54906003)(19627235002)(6916009)(66556008)(66446008)(64756008)(66946007)(6512007)(53546011)(6506007)(5660300002)(8936002)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0RId1dRcmF4Z29zUzNxL0IxM01Ca2hLZ2czQ1FFMy9RSTRQRGhRMVNHcEtm?=
 =?utf-8?B?cm43SnJwWUtMMlkxdytrcjdnVEtnSFRRVGJJeUhzMUMxTXFYb3hoVVFtUHJq?=
 =?utf-8?B?aHlHVUE3QXF5bzMrTG1uVWkzckRVZjhSYWx3UnV2ck1TTzlkd1VNcy95UlI2?=
 =?utf-8?B?RUxnRytDcXhways1UWVxSndYM2w2UmRMUVh6Qmc3SnNpNTQwWGxjd0Z1eFJh?=
 =?utf-8?B?RTBHbGR2Nlk0QkNJaDJxZ0s1ampsUGc1eVZpOXlvS01mRlNKcmlidC9yWkVC?=
 =?utf-8?B?ZTVWc2xzV05USHh1SGFtTVNLYUl2TjN1M1I3NGpSQmNPaDBTRjQ4L3NZaVZX?=
 =?utf-8?B?bHRuaGRwNXFrK2FtTng2aU5Lc2ZGN010ekZsUzU5eGt2ZTRleS9DcmNLMDlT?=
 =?utf-8?B?Y0k4djVzNTlGczI4V2VpMkV5WjcvWWZwWXZtdnh4bVRoY01UN1R1Tm9rUmVV?=
 =?utf-8?B?TmUyWG1qNmpBeHVUVlFXcDZURVU4RGFMcGFFemk4YjlQTlE0ckF3M254WXZG?=
 =?utf-8?B?M05OQ1lsV0hrdE1YNkZZZWVmYkl1ZlVvdFNRZ0VKR3c4dm0zd29OUmlNN3Av?=
 =?utf-8?B?VlVPd1hyYnFXZ2U2TzZBQkN3SWdsTjZocnJpWURFQzFDMENFaDU0OE0xS1Zi?=
 =?utf-8?B?OU0rS0RGNHFlUit0WC9WSDFoaWRncE1UNkRlcW04eG5lM0sybW5CRVN2cGlQ?=
 =?utf-8?B?MlJLR1JNaVJmZzhMcjlxdFBYQy9saHIrRDJ0TVVHZ2lMaDVScnNra3Z5RElh?=
 =?utf-8?B?Vm9hU2E4cm84N0s4Y1U4dDRDRHplQVZsNEIvRzdJNzVBY3NHODA5NmRsdDVS?=
 =?utf-8?B?OTJjRkZFVXNsZ2pZK1RWcUdBdzFzVUJ2MjBzMWcwMDAxdmJUS2tQMmFKWnBS?=
 =?utf-8?B?SlhYSjZFWmpMbEE3WnNsT2lGTjdvbzI0S3hwRGI0akdhK0dlM0tJRVNicnJj?=
 =?utf-8?B?ZnBlaTZDeEFUYTZNYWNHNmdiV050OFcvUTd1aE1EbnI5SlduWk9rYnRCbG9r?=
 =?utf-8?B?VE1uc1pQbzArb2Q5R1pTaW5Pb1J2MDM0dVdLYnJSOXdEeWpuTUdNemlWS0dH?=
 =?utf-8?B?L2s5MTNEeTdDMkExQzJzeHBRYVRjMlBMLzZiaEV0a2lrWU1iSG1MVjVWM0Jq?=
 =?utf-8?B?dy82U1JGMUZxRHlORG1hR2E1OTJ3SkFkb2ptRDhuVFlTYXI1a3R2V1RGQkw1?=
 =?utf-8?B?NVJTYndtMjc1dld0b1loeUpCalE5V3ZPNTFPcXBwcUtGVm4yWG4wQis4b1hF?=
 =?utf-8?B?Mjd0RTd6UCtsRXJweHNVZk1RSkxVMk84RWl5TlJhWWRnbllvYWF3QnZTY1RM?=
 =?utf-8?B?NXY3bmJrb3M4S2MrMFhFdU1uTVZybnhUL3h1enFObGdLL3NjQ3pTMmpOVFJn?=
 =?utf-8?B?bTNWRS9GOE9KODlXNnVJdDhkZ0tKVUJDSnJCSmE1ZkNIc3NqMmxkazlFK01Y?=
 =?utf-8?B?ZWNHYnFpT0pQbURFQjBORFF2ZGUzWXVwMlpva0JqUjMrTnJJVC9oM1JrUXRz?=
 =?utf-8?B?a1BrR0puczB5dnhyVEZubGxGNit5UGFYdm5xZFdVVEZ5LzVQTDRvWFZLZFRL?=
 =?utf-8?B?bU5PNHBaQkFUeUMvMXJQcDB6V0VkOWNldmh3V2x2OWd3Z0dxVlRqZkZ0NG53?=
 =?utf-8?B?b0xHdzhOMkllWjFLTXYyOTNkTWNVdHZTSFhWWHFoK2REYXV0TGZ6bnBlVzlI?=
 =?utf-8?B?cGVLSFpxT2FWTk9JeGkzVlhXUXJGYmk5SFNrc2FoQlZ5MTl0K3RQbklPTGhJ?=
 =?utf-8?B?QTdVMWs2emJWbmRtRVR6LzI2UE9Zd0ZZdXdJUFhYSTRTdjhZOUZOSWJwWCsx?=
 =?utf-8?B?T0FIMFRHcU9oamF6ZU5SNE94VkhNb2huSEh3OVJMczFualBsWW92YTBVc2ZL?=
 =?utf-8?B?aFNtYUphSUhxeHNmMFNQVEU1aDk3eUZ5WUVIR1NFVHhJWi9WRmhUaU1WaC9L?=
 =?utf-8?B?YmVkRUpxR2haSUcxbmRibUtQalhVT0JDTmdzZ2s2VWIzM0ptT3hNNHBqVDVp?=
 =?utf-8?B?VGMyMnZuaWM0WVVZbkIwS3N5QlcxRXVaMDJ6TU9sS20rUEtMR0xZTXBtQ1RD?=
 =?utf-8?B?V3p6MzJ3alZmN2VTOG4rMU9lekdiWk1tUkRwaXY5SHZEckhocHBiRWxnVnBW?=
 =?utf-8?B?UEZ5L1pOUDBlMzlueitpWDV3Y0NiQjJzVFByYjhYOU9Ob1JxNFhTZFVPQXZ3?=
 =?utf-8?B?RWh4aGlnajljY0VNZ1RhQXlsT0Q0VmZWTWhxSWtvNy9XMVVUY0tnUXExSHR6?=
 =?utf-8?B?eURGcWROM0JuL3NzVUZqUEh0SmsxRG92MzFveWZoNlZKaFVjWFNmMmtCMjR1?=
 =?utf-8?B?alNDRUllb2NlRDBVRzEzejlidC80ZEIwWndzbWhCWFZzTkRJL3NYUUphMEZa?=
 =?utf-8?Q?9m2GWmjdgjfZQx1N2xQOKP/+DshqRBq2+BYh7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5BD9A9320CC614883EB50E9964E277D@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa22e344-d9e3-4a8e-385c-08da13505940
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 19:55:04.1413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKKFUIeeF9Dkn4MUdVijyd1SiD3CUC0bJUY++Yqx4qBdrJ+yHN1gXyrnB/WQLxXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2687
X-Proofpoint-ORIG-GUID: DIFwmyVOek_3Z4aPtFnsjrnL8abk7h0D
X-Proofpoint-GUID: DIFwmyVOek_3Z4aPtFnsjrnL8abk7h0D
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-31_06,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDMwLCAyMDIyLCBhdCAyOjQzIFBNLCBLZWVzIENvb2sgPGtlZXNjb29rQGNo
cm9taXVtLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE1hciAzMCwgMjAyMiBhdCAwMjozMzo1
MlBNIC0wNTAwLCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPj4gRml4IHRoZSBmb2xsb3dp
bmcgLVdzdHJpbmdvcC1vdmVyZmxvdyB3YXJuaW5nIHdoZW4gYnVpbGRpbmcgd2l0aCBHQ0MtMTE6
DQo+PiANCj4+IGxpYi96c3RkL2RlY29tcHJlc3MvaHVmX2RlY29tcHJlc3MuYzogSW4gZnVuY3Rp
b24g4oCYSFVGX3JlYWREVGFibGVYMl93a3Nw4oCZOg0KPj4gbGliL3pzdGQvZGVjb21wcmVzcy9o
dWZfZGVjb21wcmVzcy5jOjcwMDo1OiB3YXJuaW5nOiDigJhIVUZfZmlsbERUYWJsZVgyLmNvbnN0
cHJvcOKAmSBhY2Nlc3NpbmcgNjI0IGJ5dGVzIGluIGEgcmVnaW9uIG9mIHNpemUgNTIgWy1Xc3Ry
aW5nb3Atb3ZlcmZsb3c9XQ0KPj4gIDcwMCB8ICAgICBIVUZfZmlsbERUYWJsZVgyKGR0LCBtYXhU
YWJsZUxvZywNCj4+ICAgICAgfCAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
DQo+PiAgNzAxIHwgICAgICAgICAgICAgICAgICAgIHdrc3AtPnNvcnRlZFN5bWJvbCwgc2l6ZU9m
U29ydCwNCj4+ICAgICAgfCAgICAgICAgICAgICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KPj4gIDcwMiB8ICAgICAgICAgICAgICAgICAgICB3a3NwLT5yYW5rU3RhcnQw
LCB3a3NwLT5yYW5rVmFsLCBtYXhXLA0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICB+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4gIDcwMyB8ICAgICAgICAgICAg
ICAgICAgICB0YWJsZUxvZysxLA0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICB+fn5+fn5+
fn5+fg0KPj4gIDcwNCB8ICAgICAgICAgICAgICAgICAgICB3a3NwLT5jYWxsZWVXa3NwLCBzaXpl
b2Yod2tzcC0+Y2FsbGVlV2tzcCkgLyBzaXplb2YoVTMyKSk7DQo+PiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KPj4gbGliL3pzdGQvZGVjb21wcmVzcy9odWZfZGVjb21wcmVzcy5jOjcwMDo1
OiBub3RlOiByZWZlcmVuY2luZyBhcmd1bWVudCA2IG9mIHR5cGUg4oCYVTMyICgqKVsxM13igJkg
e2FrYSDigJh1bnNpZ25lZCBpbnQgKCopWzEzXeKAmX0NCj4+IGxpYi96c3RkL2RlY29tcHJlc3Mv
aHVmX2RlY29tcHJlc3MuYzo1NzE6MTM6IG5vdGU6IGluIGEgY2FsbCB0byBmdW5jdGlvbiDigJhI
VUZfZmlsbERUYWJsZVgyLmNvbnN0cHJvcOKAmQ0KPj4gIDU3MSB8IHN0YXRpYyB2b2lkIEhVRl9m
aWxsRFRhYmxlWDIoSFVGX0RFbHRYMiogRFRhYmxlLCBjb25zdCBVMzIgdGFyZ2V0TG9nLA0KPj4g
ICAgICB8ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4NCj4gDQo+IFJldmlld2luZyB0aGlz
IGNoYW5nZXMgd291bGQgYmUgZWFzaWVyIGlmIHRoZSByZWFzb24gZm9yIHRoZSB3YXJuaW5nDQo+
IGNvdWxkIGJlIGV4cGxhaW5lZC4gaS5lLiB3aHkgaGFzIEdDQyBkZWNpZGVkIHRoYXQgdGhlIHJl
Z2lvbiBpcyA1Mg0KPiBieXRlcywgYW5kIGhvdyBkaWQgaXQgY2FsY3VsYXRlIHRoZSA2MjQgYnl0
ZXM/DQo+IA0KPiByYW5rVmFsX3QgaXMgSFVGX1RBQkxFTE9HX01BWC1tYW55IHJhbmtWYWxDb2xf
dCwgd2hpY2ggaXRzZWxmIGlzDQo+IEhVRl9UQUJMRUxPR19NQVggKyAxIG1hbnkgVTMycy4gU28s
IGJhc2ljYWxseToNCj4gDQo+IFUzMiBhcnJheVtIVUZfVEFCTEVMT0dfTUFYICsgMV1bSFVGX1RB
QkxFTE9HX01BWF0NCj4gDQo+IHNpemVvZihyYW5rVmFsQ29sX3QpID09IDUyDQo+IHNpemVvZihy
YW5rVmFsX3QpID09IDYyNA0KDQpZZWFoLCBJJ20gbm90IHF1aXRlIHN1cmUgd2hhdCB0aGlzIHdh
cm5pbmcgaXMgc2F5aW5nLiBDbGFyaWZpY2F0aW9uIHdvdWxkDQpiZSB1c2VmdWwuIEl0IHNlZW1z
IGxpa2UgYSBmYWxzZSBwb3NpdGl2ZSB0byBtZSwgYnV0IEkgY291bGQgYmUgbWlzdGFrZW4uDQoN
Cj4+IA0KPj4gYnkgdXNpbmcgcG9pbnRlciBub3RhdGlvbiBpbnN0ZWFkIG9mIGFycmF5IG5vdGF0
aW9uLg0KPj4gDQo+PiBUaGlzIGhlbHBzIHdpdGggdGhlIG9uZ29pbmcgZWZmb3J0cyB0byBnbG9i
YWxseSBlbmFibGUNCj4+IC1Xc3RyaW5nb3Atb3ZlcmZsb3cuDQo+PiANCj4+IExpbms6IGh0dHBz
Oi8vZ2l0aHViLmNvbS9LU1BQL2xpbnV4L2lzc3Vlcy8xODENCj4+IFNpZ25lZC1vZmYtYnk6IEd1
c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4NCj4+IC0tLQ0KPj4gbGli
L3pzdGQvZGVjb21wcmVzcy9odWZfZGVjb21wcmVzcy5jIHwgNiArKystLS0NCj4+IDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRpZmYgLS1n
aXQgYS9saWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMgYi9saWIvenN0ZC9kZWNv
bXByZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4+IGluZGV4IDUxMDVlNTlhYzA0YS4uMGVhMzQ2MjEy
NTNhIDEwMDY0NA0KPj4gLS0tIGEvbGliL3pzdGQvZGVjb21wcmVzcy9odWZfZGVjb21wcmVzcy5j
DQo+PiArKysgYi9saWIvenN0ZC9kZWNvbXByZXNzL2h1Zl9kZWNvbXByZXNzLmMNCj4+IEBAIC01
NzAsNyArNTcwLDcgQEAgc3RhdGljIHZvaWQgSFVGX2ZpbGxEVGFibGVYMkxldmVsMihIVUZfREVs
dFgyKiBEVGFibGUsIFUzMiBzaXplTG9nLCBjb25zdCBVMzIgY28NCj4+IA0KPj4gc3RhdGljIHZv
aWQgSFVGX2ZpbGxEVGFibGVYMihIVUZfREVsdFgyKiBEVGFibGUsIGNvbnN0IFUzMiB0YXJnZXRM
b2csDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzb3J0ZWRTeW1ib2xfdCog
c29ydGVkTGlzdCwgY29uc3QgVTMyIHNvcnRlZExpc3RTaXplLA0KPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IFUzMiogcmFua1N0YXJ0LCByYW5rVmFsX3QgcmFua1ZhbE9yaWdp
biwgY29uc3QgVTMyIG1heFdlaWdodCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBVMzIqIHJhbmtTdGFydCwgY29uc3QgVTMyKiByYW5rVmFsT3JpZ2luLCBjb25zdCBVMzIg
bWF4V2VpZ2h0LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVTMyIG5iQml0
c0Jhc2VsaW5lLCBVMzIqIHdrc3AsIHNpemVfdCB3a3NwU2l6ZSkNCj4gDQo+IFRoaXMgcmVhbGx5
IGZlZWxzIGxpa2Ugd2UncmUgcGFwZXJpbmcgb3ZlciB0aGUgd2FybmluZy4gVGhpcyByZW1vdmVz
IHRoZQ0KPiB0eXBlIGluZm9ybWF0aW9uIGFuZCBtYWtlcyBpdCBhIFUzMiAqIGluc3RlYWQsIGFu
ZCB0aGVuIGxhdGVyIG1ha2VzIGENCj4gY2FzdD8NCj4gDQo+IENhbiB0aGlzIGJlIGZpeGVkIGlu
IGEgd2F5IHRoYXQgcmV0YWlucyB0aGUgdHlwZSBpbmZvcm1hdGlvbj8NCj4gDQo+IE9uIHRoZSBv
dGhlciBoYW5kLCBhbGwgdGhlIGFyZ3VtZW50cyBhcmUgYWxzbyBVMzIgKi4NCj4gDQo+IEkgc2Vl
IHN0dWZmIGxpa2U6DQo+IA0KPiAgICBaU1REX21lbWNweShyYW5rVmFsLCByYW5rVmFsT3JpZ2lu
LCBzaXplb2YoVTMyKSAqIChIVUZfVEFCTEVMT0dfTUFYICsgMSkpOw0KPiANCj4gVGhhdCBsb29r
cyBsaWtlIGl0J3MgaWdub3JpbmcgdHlwZSBpbmZvcm1hdGlvbiBhcyB3ZWxsLiBpLmUuIHdoeSBp
c24ndA0KPiB0aGlzIHNpemVvZihyYW5rVmFsT3JpZ2luKT8gKFRoZSBsZW5ndGggYWJvdmUgaXMg
NTIgYnl0ZXMuKQ0KPiANCj4gSSdtIGVzcGVjaWFsbHkgY3VyaW91cyBoZXJlIHNpbmNlIHJhbmtW
YWxPcmlnaW4gaXMgcmFua1ZhbF90LCB3aGljaCBpcw0KPiA2MjQgYnl0ZXMsIG5vdCA1MiBieXRl
cyAoaS5lLiB0aGUgYWJvdmUgaXMgY29weWluZyBhIHNpbmdsZSByYW5rVmFsQ29sX3QNCj4gZnJv
bSByYW5rVmFsT3JpZ2luLiBJJ2QgZXhwZWN0IHRoaXMgdG8gYmU6DQo+IA0KPiAgICBaU1REX21l
bWNweShyYW5rVmFsLCAmcmFua1ZhbE9yaWdpblswXSwgc2l6ZW9mKHJhbmtWYWxPcmlnaW5bMF0p
KTsNCg0KWWVzLCB0aGlzIGlzIGRlZmluaXRlbHkgYSBiZXR0ZXIgd2F5IHRvIHdyaXRlIGl0LiBC
dXQsIEkgdGhpbmsgdGhlIGAmYCBpcyB1bm5lY2Vzc2FyeS4NCkJlY2F1c2Ugb2YgdGhlIHdheSBD
IGFycmF5cyB3b3JrLCByYW5rVmFsT3JpZ2luID09IHJhbmtWYWxPcmlnaW5bMF0uDQoNClVwc3Ry
ZWFtLCB0aGlzIG1lbWNweSBpcyBnb25lLCBhbmQgdGhpcyBjb2RlIGhhcyBiZWVuIG9wdGltaXpl
ZCAmIHJlZmFjdG9yZWQgWzFdLg0KQW5kIHRoYXQgd2lsbCBnZXQgcHVsbGVkIGluIGluIHRoZSBu
ZXh0IHVwZGF0ZS4gQnV0LCBpbiB0aGUgbWVhbnRpbWUsIEknZCBiZSBoYXBweSB0bw0KYWNjZXB0
IGEgcmVmYWN0b3JpbmcgZGlmZi4NCg0KWzBdIGh0dHBzOi8vZ2NjLmdvZGJvbHQub3JnL3ovb3Jv
ZG9LODE4DQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2ZhY2Vib29rL3pzdGQvYmxvYi8zZTZiYmRk
ODQ3M2E3NTNkMjA0Nzk2OWFjMDA1M2ZiMmNiNGRkYTIzL2xpYi9kZWNvbXByZXNzL2h1Zl9kZWNv
bXByZXNzLmMjTDk5Mi1MMTAzNg0KDQo+PiB7DQo+PiAgICAgVTMyKiByYW5rVmFsID0gd2tzcDsN
Cj4+IEBAIC01OTgsNyArNTk4LDcgQEAgc3RhdGljIHZvaWQgSFVGX2ZpbGxEVGFibGVYMihIVUZf
REVsdFgyKiBEVGFibGUsIGNvbnN0IFUzMiB0YXJnZXRMb2csDQo+PiAgICAgICAgICAgICBpZiAo
bWluV2VpZ2h0IDwgMSkgbWluV2VpZ2h0ID0gMTsNCj4+ICAgICAgICAgICAgIHNvcnRlZFJhbmsg
PSByYW5rU3RhcnRbbWluV2VpZ2h0XTsNCj4+ICAgICAgICAgICAgIEhVRl9maWxsRFRhYmxlWDJM
ZXZlbDIoRFRhYmxlK3N0YXJ0LCB0YXJnZXRMb2ctbmJCaXRzLCBuYkJpdHMsDQo+PiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmFua1ZhbE9yaWdpbltuYkJpdHNdLCBtaW5XZWlnaHQsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFua1ZhbE9yaWdpbiArIG5iQml0cywgbWlu
V2VpZ2h0LA0KPiANCj4gQW5kIGhlcmUgSSdkIGV4cGVjdCB0byBwYXNzCSZyYW5rVmFsT3JpZ2lu
W25iQml0c10NCj4gc2luY2UgSFVGX2ZpbGxEVGFibGVYMkxldmVsMiBpcyBkb2luZyBhbm90aGVy
IHJhbmtWYWxDb2xfdC1zaXplZCBjb3B5Og0KPiANCj4gICAgWlNURF9tZW1jcHkocmFua1ZhbCwg
cmFua1ZhbE9yaWdpbiwgc2l6ZW9mKFUzMikgKiAoSFVGX1RBQkxFTE9HX01BWCArIDEpKTsNCg0K
SW4gSFVGX2ZpbGxEVGFibGVYMkxldmVsMiwgcmFua1ZhbE9yaWdpbiBpcyBhIHJhbmtWYWxDb2xf
dC4gSXQgaXMgY29uZnVzaW5nLCBhbmQgdGhpcw0KaXMgaW1wcm92ZWQgdXBzdHJlYW0sIHRob3Vn
aCByYW5rVmFsIGlzIHBhc3NlZCBhcyBhIFUzMiBjb25zdCosIHdoZXJlIGl0IHNob3VsZCByZWFs
bHkNCkJlIGEgcmFua1ZhbENvbF90LiBTbyBJJ2xsIHB1dCB1cCBhIHNtYWxsIFBSIHRvIGltcHJv
dmUgdGhhdCB1cHN0cmVhbS4NCg0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgc29ydGVk
TGlzdCtzb3J0ZWRSYW5rLCBzb3J0ZWRMaXN0U2l6ZS1zb3J0ZWRSYW5rLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbmJCaXRzQmFzZWxpbmUsIHN5bWJvbCwgd2tzcCwgd2tzcFNpemUp
Ow0KPj4gICAgICAgICB9IGVsc2Ugew0KPj4gQEAgLTY5OSw3ICs2OTksNyBAQCBzaXplX3QgSFVG
X3JlYWREVGFibGVYMl93a3NwKEhVRl9EVGFibGUqIERUYWJsZSwNCj4+IA0KPj4gICAgIEhVRl9m
aWxsRFRhYmxlWDIoZHQsIG1heFRhYmxlTG9nLA0KPj4gICAgICAgICAgICAgICAgICAgIHdrc3At
PnNvcnRlZFN5bWJvbCwgc2l6ZU9mU29ydCwNCj4+IC0gICAgICAgICAgICAgICAgICAgd2tzcC0+
cmFua1N0YXJ0MCwgd2tzcC0+cmFua1ZhbCwgbWF4VywNCj4+ICsgICAgICAgICAgICAgICAgICAg
d2tzcC0+cmFua1N0YXJ0MCwgKFUzMiAqKXdrc3AtPnJhbmtWYWwsIG1heFcsDQo+IA0KPiBJdCdz
IHBvc3NpYmxlIHRoZSBwcm9ibGVtIGlzIHdpdGggdGhpcyBzdHJ1Y3R1cmU6DQo+IA0KPiB0eXBl
ZGVmIHN0cnVjdCB7DQo+ICAgIHJhbmtWYWxDb2xfdCByYW5rVmFsW0hVRl9UQUJMRUxPR19NQVhd
Ow0KPiAgICBVMzIgcmFua1N0YXRzW0hVRl9UQUJMRUxPR19NQVggKyAxXTsNCj4gICAgVTMyIHJh
bmtTdGFydDBbSFVGX1RBQkxFTE9HX01BWCArIDJdOw0KPiAgICBzb3J0ZWRTeW1ib2xfdCBzb3J0
ZWRTeW1ib2xbSFVGX1NZTUJPTFZBTFVFX01BWCArIDFdOw0KPiAgICBCWVRFIHdlaWdodExpc3Rb
SFVGX1NZTUJPTFZBTFVFX01BWCArIDFdOw0KPiAgICBVMzIgY2FsbGVlV2tzcFtIVUZfUkVBRF9T
VEFUU19XT1JLU1BBQ0VfU0laRV9VMzJdOw0KPiB9IEhVRl9SZWFkRFRhYmxlWDJfV29ya3NwYWNl
Ow0KPiANCj4gaXQncyBub3QgdXNpbmcgdGhlIHJhbmtWYWxfdCB0eXBlIGZvciByYW5rVmFsIGZv
ciBzb21lIHJlYXNvbj8NCj4gDQo+IGkuZS4gd2hhdCdzIHBhc3NlZCB0byBIVUZfZmlsbERUYWJs
ZVgyIGlzIGEgcmFua1ZhbENvbF90ICg1MiBieXRlcyksIGJ1dCB0aGVuIGl0DQo+IGdldHMgcGFz
c2VkIGFnYWluc3QgbGF0ZXIgYXMgcmFua1ZhbF90ICg2MjQgYnl0ZXMpLg0KPiANCj4gRG9lcyBj
aGFuZ2luZyB0aGUgdHlwZSBkZWZpbml0aW9uIGFib3ZlIHNvbHZlIHRoaXMgbW9yZSBjbGVhbmx5
Pw0KDQpJdCB3b3VsZCBtYWtlIHNlbnNlIHRvIHJlZmFjdG9yIGl0IGFzIGEgYHJhbmtWYWxfdGAg
dG8gbWUsIHNpbmNlIHRoYXQgaXMNCmNvbnNpc3RlbnQgd2l0aCB0aGUgZnVuY3Rpb24gc2lnbmF0
dXJlLiBIb3dldmVyLCBhZnRlciByZW1vdmluZyB0eXBlZGVmcywNCmB3a3NwLT5yYW5rVmFsYCBz
aG91bGQgYmUgZXhhY3RseSB0aGUgc2FtZSB0eXBlIGFzIGByYW5rVmFsX3RgLiBTbyB0aGUNCndh
cm5pbmcgc2VlbXMgdG9vIG5vaXN5IGhlcmUuDQoNCk5vdCBzYXlpbmcgdGhhdCB0aGUgY29kZSBj
YW4ndCBiZSBpbXByb3ZlZCwgaXQgY2VydGFpbmx5IGNhbiBiZSwgYW5kIEkgd2lsbA0KcHV0IHVw
IGEgUFIgdXBzdHJlYW0gYnkgdG9tb3Jyb3csIGFuZCBsaW5rIGl0IGhlcmUuDQoNCkJlc3QsDQpO
aWNrIFRlcnJlbGwNCg0KPiAtS2Vlcw0KPiANCj4+ICAgICAgICAgICAgICAgICAgICB0YWJsZUxv
ZysxLA0KPj4gICAgICAgICAgICAgICAgICAgIHdrc3AtPmNhbGxlZVdrc3AsIHNpemVvZih3a3Nw
LT5jYWxsZWVXa3NwKSAvIHNpemVvZihVMzIpKTsNCj4+IA0KPj4gLS0gDQo+PiAyLjI3LjANCj4+
IA0KPiANCj4gLS0gDQo+IEtlZXMgQ29vaw0KDQo=
