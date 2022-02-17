Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E294B9F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiBQLrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiBQLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:47:44 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B832804FA;
        Thu, 17 Feb 2022 03:47:30 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21H4JNci032488;
        Thu, 17 Feb 2022 03:47:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=facebook;
 bh=U9SgP4JuOoXTe551MZ+ENE82j9GdRW5fo+M+ppqsO3w=;
 b=l572xLgEZkPnlIh89Y5FAzaRavVTGxZaSD1ZcNvyhSolCw04NJTKKpWlX4WpirWmDKVT
 f0dZR++MnCSl48IMPQ5ApxiH7MBkzO8BF9vAXQaq47iF/gHd3JlhylyQzEi/kLSqY5AY
 Jci3jfYYRBhmerr6Hir0I2NNGOtc5FsaY9g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e9f7ra4dm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Feb 2022 03:47:30 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Feb 2022 03:47:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4siSTWcft5y+djrSh1QesZPmM1U9s3NlDqj1u4F8eu30A1OytNgDUmCBWAX5+Wh0caXGrZVP1XN7CRH1xTk0L0j6caYzggKgClj9ezMjpXlKUP31LScxHcq7YG3r3mIYBUAy5Bp3kFKnj4cTsQFq1JCvGNeALELgetNWJIRegbC6lF3ca8CmtRBqGhf757Iu4igECknFGjpA30AOBiE3F2li/ymFiQ6RzuzmdVJ8Y6t56Nui9c380WvODRE8Klcbpp+iDhcWw0HtI4830DhfbhRH3Ne4qeiI87gYYXYAJ0hiiPTYjAEIuB43uhL0DDzXrXgxLQP+9qpIZ/KfrbZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9SgP4JuOoXTe551MZ+ENE82j9GdRW5fo+M+ppqsO3w=;
 b=AErjWIRv3yqEXYaydPxc/ebxFv7bpTXs81sPuA0FGxDjbjwX+IEdrh9MiCxfdzf5E5dbCpZ3flSkLeHxfYBzxGnZCp8W/mK5xLJi7lZBedpZT6CpTVuW/mCoZbIpcXPx1xXGEMOMC3RML49BJIW70ZuLDNGQkAOXsMzx33tXI4N+V+7hgJqJZ/bPrrUdqbfafXWU7+cQwdDdDCbgFJUsJVTe+waNKE29ATqRBC+VpLt45wJW8B6pgzsUmoIOfLygCh/9vkRjZYWj92ITApxiL6UJQx3K20cWPmODyr3TkgBPwLt/rC2ccnDociUSXXmAuRsT59mtBL02aN/n/K+/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB4854.namprd15.prod.outlook.com (2603:10b6:806:1e1::19)
 by MN2PR15MB3567.namprd15.prod.outlook.com (2603:10b6:208:1b5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 11:47:21 +0000
Received: from SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::7d8d:31e5:e6cc:e92d]) by SA1PR15MB4854.namprd15.prod.outlook.com
 ([fe80::7d8d:31e5:e6cc:e92d%3]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 11:47:21 +0000
From:   Dmitrii Okunev <xaionaro@fb.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>,
        "qiaowei.ren@intel.com" <qiaowei.ren@intel.com>
CC:     "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>,
        "greg@kroah.com" <greg@kroah.com>,
        "xiaoyan.zhang@intel.com" <xiaoyan.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "gang.wei@intel.com" <gang.wei@intel.com>,
        Jonathan McDowell <noodles@fb.com>
Subject: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Thread-Topic: [discuss] Improve and merge a driver proposed in 2013: sysfs
 interfaces to access TXT config space
Thread-Index: AQHYI/QfaYkfdhkKB0GRGIMREhsvJQ==
Date:   Thu, 17 Feb 2022 11:47:21 +0000
Message-ID: <4febd50da7e5007a2797e0f4c969fa5edd0bf725.camel@fb.com>
References: <1368465884-14779-1-git-send-email-qiaowei.ren@intel.com>
         <1368465884-14779-3-git-send-email-qiaowei.ren@intel.com>
         <20130516160311.GA12299@amd.pavel.ucw.cz>
In-Reply-To: <20130516160311.GA12299@amd.pavel.ucw.cz>
Reply-To: Dmitrii Okunev <xaionaro@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe26c422-f4cc-4789-9bd2-08d9f20b41f3
x-ms-traffictypediagnostic: MN2PR15MB3567:EE_
x-microsoft-antispam-prvs: <MN2PR15MB356713B128F524154B512F26BC369@MN2PR15MB3567.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxqa28hx6zGkbuTK43J1zV/Gcu44CLisNKIJaWDsAKfSS2hpzD+aIIhbDSpYRwWaiIR30QE4DsN46dyVZAv1J7LeR+R/XqhgWM6/y15PnzRC5/a2OXxZfJ7Sew/CpPUXYlhII+8hPKXlDwy+C5w5aw3rRGfct1Dpl4r6dmzSf7gNlm8o2pppujsQQvMYbLCGQakrTl5XZcTq9lQNunsh494bPMvBi/R2KkNqVeLMEQDQis3DhMdP7aQGZAqUG7DUB0mc2CEywaYAUbuPnZWZvStBD3ajAUu8DuR4H1XLOhBnH5qA+pzYKw6/YBcPiXTXibkQeygFEsywDvE5AXLc8MbqyvIaBmznVeUtDirBnirOSjMX8C3ttznbtjofM/6BLgipuvNbo3NxQU1eCOIBZxMyU23K6rVbKK7094aCUMw14V13TvgqqXjGl6aL8wpAwVUnh8Gt5J4Z2QWF9nWaDV8TBDiV+fmoUWUPFrjJSY8N1AY603Y1/6bzJ/tq4GamDeK4Gs7HwBkFCkmalgbEgxwYMabnT3F80q9mHmXALqNt4VBAxYGq5fpJSfYUg190jpRSxTC1zm3E9QRlvA09Pu31S728PGU/IX6SIgOp3VDBq5HlYxjoahEE/8fC/hGZQBgqmBcAvj6Mwt0jH+hgaQj49HyrwReK6SyuTBLpKRrcxGJ9SKAlM4ut7iP6nUUhfK+vdvtvu2azcsxmxp6rsAetCekPMA5TKmLBZ3Q6t3rBtr9Z56qwlcPP99P8cSObCGwqzUJ2M9XGj3L09cxctiP7dg0SanmLMUNndCXT9fk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4854.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(71200400001)(186003)(966005)(38100700002)(110136005)(66446008)(508600001)(86362001)(6486002)(6506007)(8676002)(3450700001)(5660300002)(38070700005)(91956017)(76116006)(36756003)(2616005)(66946007)(66556008)(4326008)(316002)(66476007)(122000001)(64756008)(54906003)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NURYNlJTbmdGMkJFbjc3M2NjSkwwbWhrb2p6VFIyQ1RVckxvWmxRWHVsc0w1?=
 =?utf-8?B?b1hzczFYdG9DVUhmTWxjV2grQjVoSSsrd3F6ODRBcHBBd1BDcnhEUzlOVXh4?=
 =?utf-8?B?WnpzUXhEcVJOUU1yYkFtOVRqNDdQd294SFU0d0tiRWZteUQxOHZ2VHNmRmVt?=
 =?utf-8?B?OG1SamxITm50T0hwN2c4NFIza0VFUlpUKzBiTGxWaFFSYzVQM1hleXViVWpa?=
 =?utf-8?B?Nlo3TExJaVlPSDdsNUN2L2hLQUViYnBQdUtVSHcvTjMrL29kUFJHOUtJTHBv?=
 =?utf-8?B?bmsxOHMxWFd2Q09SN0JnRnFjVUdMWkN1YTJjVmpuVlpRakpTdkVDZERxbnBp?=
 =?utf-8?B?WkJQMXZLa1BkOGl2Z1ZxNlQrSTE3ejVvcTMrbUJsQ1c1YTBua3Jmb3IxNlNl?=
 =?utf-8?B?WjBpVm5RMEVJMi9wMEVwUWY2cnBXSjBpNXc1eWtkK1lLMDBkeTYxSkFiUDR5?=
 =?utf-8?B?SWRPWmpHNHZubFQ5OWdXUm5JdEExdis1THZZMHJtWWRyVVZUYWFGODU0aFUw?=
 =?utf-8?B?OU94T2VGd2RtbGVWYzFIM3VkcVo1QlZaSkFLUktQenlTR1NnOVpIMDFMTWc1?=
 =?utf-8?B?aGd1VURhOFdpVjEvMS9oQXNhalBoVXMyMGM0azhmc2lxSFB6TTBjRUpONDYy?=
 =?utf-8?B?bHZYN09lZUpWT3YxSWZPNy9UNkpxbk45ZmJWeEtpTE85T2xCaFFqMEJDMm16?=
 =?utf-8?B?WWVsSmZyZGJpOVZNTExvSVVkVzBLYkZaVHdkUmpHbEFWOGhzKy9jVnFrMVBX?=
 =?utf-8?B?OFZKRU9ZSHVVQ01UclNRazRBNVcyUzhWUlJoYVVmUEdWbXJ3L3dDcVFpSWVH?=
 =?utf-8?B?Y1hNemY3REV0eEorSHFsUnBOQ3BiWEt3QjNVVTQ5bGZwTnFVT2lHeDc1M0dp?=
 =?utf-8?B?YkgxWG9hZ1hickhLQzgyWHFSc0gxd2grZ2h5a1dtRXcyUTQ2ZXFkN0xRYjVP?=
 =?utf-8?B?L05uSXNOejYxSGpoTklhWU1xS2kxb2hqLzg3M0JRMmFNMWo3VkFjOFFtZmpr?=
 =?utf-8?B?T1ZNOGp6QURpS1BRb2tqT2RmckxOQzJaZlp2Mm1aQkZHajRtdVlSdEdpU3A0?=
 =?utf-8?B?cFkydHBWZTQ4QTBBN0VqeDRvNW9Qc3U4TjJaMHMwUGVlckNUNzYrVkFoZzRC?=
 =?utf-8?B?amFHVXF2NkdGaUpnQVNtU3kyamF4bEZlWVJwOEJzdUxqMisrRFlDdTRKSVJG?=
 =?utf-8?B?NHFUaEZvOUxaZEhFaEVoc1BiWEhXQ1ZHS0dhVUd0UUgzaUZDZUhoWWZnVFNS?=
 =?utf-8?B?d1kwSjI2RXNMSkFLM1FqOE1XdkJnRDNtaDFyNkRWZmR6dDhFdk5kS3RpdEps?=
 =?utf-8?B?UnM1U2NIS2cvdnpFMFZZTzRyUElLTkhPek16OGtYVXJxYS9RWlhoSXJBN2xz?=
 =?utf-8?B?dEk2NDFOTkxsYmQ3eVFSM2J4aE5oMmxhbWFWRDlJSER3bk9hN2VIOTBxRFN4?=
 =?utf-8?B?WlcwYUF2UWxSZmw2VXRpdm1xTmtwVzdsRnJhUmNrVytma2wyaTFMRFlJZ3dL?=
 =?utf-8?B?YjVOSTd3UGpRWTRoT0Z1b2xLNDZ1NHcvWjNHK0lMd0ltYjg4V0xEUXdnck4v?=
 =?utf-8?B?MXdFYm1SQUZnNGtCWGJ0b21xNjl1RUkrTDZwQm9xOTMxZGx3c0wyc1pkaStO?=
 =?utf-8?B?M1dvTmplUEVRWkFyMlRudVAwTVRhZHBpNWl0ZnFlaWt5ZVZJbkJXMWxPWWVY?=
 =?utf-8?B?cERuWk15d05acUxSWEdjRWdGMVNqMkZUQ2VNMnVQSXJSeDVuNnErWFJYZE5p?=
 =?utf-8?B?RkxZQjZrVjRTaENESHhlcERPOHpSMGE0Uk1IdmFMNk5FUEptNjFhbGdyaTZZ?=
 =?utf-8?B?ejY1UHM0enZrSzNkRmFsR2ozTmJyUDFTMUsxeHZldklkbGt2Nit3UTJjekcy?=
 =?utf-8?B?dld2MW5sM3RSdUhrVFlTWG5pWlVVMG94ZzZWOXVkQVhPK0xsbWhPK25VTUV4?=
 =?utf-8?B?bE5GS29tTHBzVmhWd280ckRiN25YSFk5YkVEK0xZVTlIcXczUXFnWGlnZ1ZM?=
 =?utf-8?B?cUZLcVpGR3BObzU1Q2hoT1o1ZUhVZ1NGL0F3N2NJaDF6V09tQ0JiRHZka2FX?=
 =?utf-8?B?ZnQva0FDVVZTSUZlZUhpS01HS21RSHFyT0JvQit3RnNrSThyTVZldTdPY0NT?=
 =?utf-8?B?QmdiZ1hnWFBMdjUyekwxWENsbGVDdmFQTi9Jc2YxNWFRVzNZdmZCeE0zNUNW?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332DFD6BE81C91499A7F093A637F1306@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4854.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe26c422-f4cc-4789-9bd2-08d9f20b41f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 11:47:21.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BEM/ZwI1hHjdiSUQYkd/a+C9Iov+zJx5k245hzBiimrxZYS+/t0d3DHz7euQ45zr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3567
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: aWdinRVb98_0Oxtwj3-59kBfqa3uUVYd
X-Proofpoint-ORIG-GUID: aWdinRVb98_0Oxtwj3-59kBfqa3uUVYd
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_04,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170052
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8hDQoNCkFzIGZhciBhcyBJIHNlZSB0aGUgcGF0Y2ggd2Fzbid0IG1lcmdlZC4gQW5kIEkg
c2VlIHRoYXQgdGhpcyBpcyB0aGUNCm9ubHkgdW5zb2x2ZWQgdGhyZWFkIGluIHRoZSBkaXNjdXNz
aW9uOg0KDQpPbiBUaHUsIDIwMTMtMDUtMTYgYXQgMTg6MDMgKzAyMDAsIFBhdmVsIE1hY2hlayB3
cm90ZToNCj4gT24gVHVlIDIwMTMtMDUtMTQgMDE6MjQ6NDMsIFFpYW93ZWkgUmVuIHdyb3RlOg0K
PiA+IFRoZXNlIGludGVyZmFjZXMgYXJlIGxvY2F0ZWQgaW4NCj4gPiAvc3lzL2RldmljZXMvcGxh
dGZvcm0vaW50ZWxfdHh0L2NvbmZpZywNCj4gPiBhbmQgaW5jbHVkaW5nIHRvdGFsbHkgMzcgZmls
ZXMsIHByb3ZpZGluZyBhY2Nlc3MgdG8gSW50ZWwgVFhUDQo+ID4gY29uZmlndXJhdGlvbiByZWdp
c3RlcnMuDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgdmVyeSB3cm9uZyBpbnRlcmZhY2UuLi4gZXF1
aXZhbGVudCBvZiAvZGV2L21lbS4NCg0KQXMgYW4gYWN0aXZlIHVzZXIgb2YgdGhlc2UgcmVnaXN0
ZXJzIEkgaG9wZSBpdCB3aWxsIGJlIG1lcmdlZCwgc28gSQ0Kd291bGQgbGlrZSB0byBpbXByb3Zl
IHRoaXMgcGF0Y2ggKG9yIHJld3JpdGUgaXQgZnJvbSBzY3JhdGNoKSB0byBtYWtlDQp0aGF0IGhh
cHBlbi4gT3RoZXJ3aXNlIG9uZSBoYXZlIHRvIGRvIGhhY2tlcnkgYXJvdW5kIGAvZGV2L21lbWAs
IHdoaWNoDQphbHNvIGNyZWF0ZXMgcHJvYmxlbXMgd2l0aCBwcm9wZXIgYWNjZXNzIGNvbnRyb2wu
DQoNClRvIGJlIGFibGUgdG8gaW1wcm92ZSB0aGUgcGF0Y2gsIGNvdWxkIHNvbWVib2R5IGNsYXJp
Znkgd2h5IGV4YWN0bHkNCnRoaXMgaXMgYSAidmVyeSB3cm9uZyBpbnRlcmZhY2UiPw0KDQo+ID4g
K1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2RldmljZXMvcGxhdGZvcm0vaW50ZWxfdHh0
L2NvbmZpZy9TVFNfcmF3DQo+ID4gK0RhdGU6wqDCoMKgwqDCoMKgwqDCoMKgwqBNYXkgMjAxMw0K
PiA+ICtLZXJuZWxWZXJzaW9uOsKgMy45DQo+ID4gK0NvbnRhY3Q6wqDCoMKgwqDCoMKgwqAiUWlh
b3dlaSBSZW4iIDxxaWFvd2VpLnJlbkBpbnRlbC5jb20+DQo+ID4gK0Rlc2NyaXB0aW9uOsKgwqDC
oFRYVC5TVFMgaXMgdGhlIGdlbmVyYWwgc3RhdHVzIHJlZ2lzdGVyLiBUaGlzIHJlYWQtDQo+ID4g
b25seSByZWdpc3Rlcg0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcyB1c2Vk
IGJ5IEFDIG1vZHVsZXMgYW5kIHRoZSBNTEUgdG8gZ2V0IHRoZSBzdGF0dXMNCj4gPiBvZiB2YXJp
b3VzDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEludGVsIFRYVCBmZWF0dXJl
cy4NCj4gDQo+IFRoaXMgaXMgbm90IGVub3VnaCB0byBhbGxvdyBwZW9wbGUgdG8gdW5kZXJzdGFu
ZCB3aGF0IHRoaXMNCj4gZG9lcy9zaG91bGQNCj4gZG8sIG5vciBkb2VzIGl0IGFsbG93IChmb3Ig
ZXhhbXBsZSkgQVJNIHBlb3BsZSB0byBpbXBsZW1lbnQgc29tZXRoaW5nDQo+IGNvbXBhdGlibGUu
DQo+IA0KPiBJcyB0aGVyZSBzcGVjaWZpYyByZWFzb24gd2h5ICJiZXR0ZXIiIGludGVyZmFjZSBp
cyBpbXBvc3NpYmxlPw0KDQpJIHdvdWxkIGxvdmUgdG8gcmV1c2UgSW50ZWwncyBwdWJsaWMgZG9j
dW1lbnRhdGlvbiBbMV0gdG8gcHJvdmlkZSBhDQpwcm9wZXIgZGVzY3JpcHRpb24gKHdpdGggYml0
IGxheW91dCBvZiB0aGUgdmFsdWUpLg0KDQpbMV0gaHR0cHM6Ly9jZHJkdjIuaW50ZWwuY29tL3Yx
L2RsL2dldENvbnRlbnQvMzE1MTY4DQoNCj4gWy4uLl0sIG5vciBkb2VzIGl0IGFsbG93IChmb3Ig
ZXhhbXBsZSkgQVJNIHBlb3BsZSB0bw0KPiBpbXBsZW1lbnQgc29tZXRoaW5nIGNvbXBhdGlibGUu
DQoNCkRvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHkgdGhhdCBhIHByb3BlciBkb2N1bWVudGF0aW9u
IG9mIHRoZSByZWdpc3RlcnMNCnNvbHZlcyB0aGUgcHJvYmxlbT8NCg0KPiBJcyB0aGVyZSBzcGVj
aWZpYyByZWFzb24gd2h5ICJiZXR0ZXIiIGludGVyZmFjZSBpcyBpbXBvc3NpYmxlPw0KDQpXaGF0
IGFyZSBzcGVjaWZpYyBwcm9ibGVtcyB3aXRoIHRoZSBjdXJyZW50IGludGVyZmFjZT8NCg0KQmVz
dCByZWdhcmRzLA0KRG1pdHJpaSBPa3VuZXYuDQo=
