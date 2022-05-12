Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE82F524B81
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353201AbiELLWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353134AbiELLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:21:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A787F25A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muAEZqXzn+nkmK33N0/qRP3X0fx7wNq0UOdJTk5WuvcMG3czuJhGmTsG28gbDEzjDeoRUW2aYAeCUJbM+b1lsz2uiXOyVYxXaFlTD+CeaH2vHFIAXnqws0ru09STg8G/31Yk8kdr5j4kfD1JlAK9eivVuevpQmEGE4i41kcl9kZWz/2tr+ArCBFA329okoMFvRtbpT3yVgqabTL1CT+gxAAslQjPM4ldUfOy50evYVz9FYrqcPkICkjZBW3DbSxpM7/nJD+wPYHOP1jPV5sXDGIos2FdaB4IT0C18vohiJbxMxSUhYJ0Wp0ruR48njjFz1/cNhDPgmwidaVoGK92fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utZP84t/hL+rWxIp9A4iFl4xFSfVS84W/kTivBmRVn8=;
 b=NXvOfecfk7fmpH1IUCqARPmr4L8M/ztP9sdt8SS5DnuPebsEo/acb9A7ZHlp30AeVF2IASqCZqYvJ1qxjsUZ8kfdyKco7+iWx+ePFqMz24aLd/Ut4a/bOyM0aIeVLx2FygMVWkrk4+4M2ntcx1EECIlTW2wAbitbXnedttwAZ3X0UQ0C/9arrwje/kFFWRyl4g7KL9IpO8bpRrbV+M8Yd7VtEjbhWm/LfvDJluLGRQ991vTwsT1Lh5PRKCTbAqhEu1DNMM7plkj6q7nNgH8wVpR85m5uKmnnES+xIRL8BCyRgBgmxysg8CxAKhuwg+hhxZF8+VtoKnZkkUAEK+ta+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utZP84t/hL+rWxIp9A4iFl4xFSfVS84W/kTivBmRVn8=;
 b=CN8PLgqcFBWm9xf4tWlJ92vIQej0o8dEWjEBb8iF91uPCSc9uKhGdUu6r8ks/ggupe48C9YHlNrXoHc3SijYTdcsBW9U5czyZ2/gpqq0ECrj0weokhcAKHei9euDpANkMoZ740Y+iairtnVDLzdC8HP6T/0SyvEJSu4Iu0IkKfI=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB2217.apcprd06.prod.outlook.com (2603:1096:4:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.22; Thu, 12 May 2022 11:21:23 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::d161:735a:f459:c6b0]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::d161:735a:f459:c6b0%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 11:21:23 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2] arch_topology: support parsing cluster_id from DT
Thread-Topic: [PATCH V2] arch_topology: support parsing cluster_id from DT
Thread-Index: AQHYZRz4UmkE46baoUWBVBVWQAmP3K0bFEsAgAACPVE=
Date:   Thu, 12 May 2022 11:21:23 +0000
Message-ID: <SL2PR06MB308206F8C6296514B7031C6FBDCB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
 <89525069-4fd5-2fd8-20eb-5af240a4bceb@arm.com>
In-Reply-To: <89525069-4fd5-2fd8-20eb-5af240a4bceb@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dcc41df-1111-4ea6-8806-08da34098bf1
x-ms-traffictypediagnostic: SG2PR06MB2217:EE_
x-microsoft-antispam-prvs: <SG2PR06MB2217C157B2067619F0836BD2BDCB9@SG2PR06MB2217.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h9Bevhww3ZqcA87ZLcwr4Onzo4ELl1QfB9OBlrnXB7GaporNLL34XEBwMTcYW7ZOsf+Ma67BjSCgeGRZgJEOoSjc4hy/0faooRVwc+IJ60xD7wqfDACHT5A153B3mgTD8aggmZR1TV6sQWX6kcB/pjbH6Jr24DYiP7wPmNW+KnheZ8sIBR/MsIXqbnpEtAbm1Nk96V2wlyq2TSmWBspY5y/sBg0zmgvcczHcKMDiPPmJxR56FMEFgJQHzy3afS38jmG8otZwrUvIjW+AOsh+W4I1gUIQ1nP9Ie7HmjuCIV3fWy9hgXyC3W8iBBfMfgisCcFGHT9UPYtizLxo506YDUcAm1NB9XFbVQ8RGkSk8z197AW2E8gv4aJGa0KLdPvSSKnZVmw1MzMRk+ESGbmo8x+9uI4mL4E7kNSFS6koahIggHz0oiAGXBDhe8zubiSlJnpP3/AW1R7tf3o3x47iQzCaAjAz1znv/QVCiV69BxekoCjE5HWA7Q44gfSVjO672JFIcPcipoQBEwm39R/OwlbfgZUq0yuymT7tFHW0EHl8CsmovbcLt9+1yH52qK/imWgESEJsGLGdeRacuaO3zAVdWtYjp/FnbdFh+LQ7gDL1BKi0qAyoK8O83xO8RBOmF1CrAMZEiO7SsxPMubqlgEE8vIDsLfALW0f60+DE5Q0Luy1exu7CASUEHhTW/Qds/PwQfp7D6AV0IFhZG4aG3ngZigwGp3P0eZWSxDlCgcClfzV5r+T3z2hOYs911sZl0Y5TsgcH1F30cl9f6dc7D7wvlcagDbKf5Tu3uzA/eSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(38070700005)(86362001)(9686003)(110136005)(71200400001)(508600001)(7696005)(26005)(6506007)(316002)(122000001)(8936002)(55016003)(85182001)(2906002)(66446008)(66946007)(8676002)(66476007)(66556008)(64756008)(76116006)(33656002)(91956017)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M1FlbHcvaU1sbG5qM3R5QnlKZys3MERUN2llc1RoejVsMlVMUlJldFdjWkY0?=
 =?gb2312?B?Q1JxUXpPa3RoTDB6aVdVTlk5SmU3R0dKL1RHZ1JqUnUyOXltWVJCaTh3QU9Y?=
 =?gb2312?B?Y05oemdyRE54ajdmak9JdFAzc1dCekd3VUd0UDh2dlhzazBaZ09kdExkejBK?=
 =?gb2312?B?L01qTVh0Vlg1VEJrUVk3TUZFMnlOSVJLS3djNjVLejRjMFB4Y0tKL0U1bkFQ?=
 =?gb2312?B?SUdyRXRsVUdmTTh4THFpZXFSR0tQb3RNMk85Wmp1TUc0MitDTzlOc0EzQW02?=
 =?gb2312?B?dFZBZ1V3UUM2dHkweml3MjUwdURoaU43bE5oTDRWOHJtRVVQK3hvSFNVTUlQ?=
 =?gb2312?B?ZDZxMmJRbWY4QlJNeUd2a1paVFNRU2xSVVhIc3BpbTZIS01TT1g4SWNIY3c3?=
 =?gb2312?B?RzFiMGpRa0RmV01wdHNuWUFVWWVBUXZKSm5BRThSb1BqOHRWa0lpVnM0TzBv?=
 =?gb2312?B?bkZmWVV5VVUzalJldDczcVhCQWV2RXV0dTZhczNvYzRVdVc3MVp6b29KL1Jl?=
 =?gb2312?B?ZS84RGlHVUUyVnpYc3B1TTEvRWZnYUw0L2VHaDZpQmd2bnhFNmpLNm5RQ3hj?=
 =?gb2312?B?d0kyekx2bnpLNXc4eExvOGJyY1oxK3FZT0ZTN1NwY3RNUkZpQlg0ODlJdUlV?=
 =?gb2312?B?WWdvODlKNmRRcUNjWmZMRDFnaEFwNmNiNmZ4YW9lT04yYmd1RjhFQjRoVzVE?=
 =?gb2312?B?bWdoRmtoTmQ2UTVrL2lTQkwyaGMvMFNqQkhZZVVZVjNoVWxQREwwMnNqNSt2?=
 =?gb2312?B?U3REZEFtM2xsSkJENElTUXh5QW5TR0lBOEVtUUZuTFczNjRaS0RQRUYvTTMv?=
 =?gb2312?B?UDZjbHFFMWVwL0h5ZktoaGxPeGZXQ0RvcFJMclZLNjJWMjh1SXc3YVVWOEdk?=
 =?gb2312?B?aWYyTVErUmYrOFVSUjFodkMwdk5UUDV0MXUxK21jUnNPdkRSSCtaS0RIaFRL?=
 =?gb2312?B?TEdvV2xHYkVlb3lVUW90RWFaQytZS09pbjB5Yk80QkxTbXFQM1hJTnNTN3E0?=
 =?gb2312?B?RTNDWXR6UkI0WHQ1KzVteThxTFBEeXN3clBxdFdpaWU2YXJBL0hWdmZuSncw?=
 =?gb2312?B?Q1hsdWRSdThRTERXa0ZiZ3BSeFpEMEhaTDJqOWdQSlJTTmR6dEY1dEtWSWxR?=
 =?gb2312?B?RnFGUkh2Umc1SzlnKzMvS1EraU1NaUc0d3VRQ2ZFcTE5bkRjZHRvaFIzVEM3?=
 =?gb2312?B?ZWg5ZXJaQjZEOVMrRlE5cDYzQWNnaXkweVMwMTVNa1hFMS9Jb3I4SG51MkN6?=
 =?gb2312?B?NUZDY204Q0w2akFXWVNneWtTTmJjeXI5SEE0ZlVTVFFiUTk4Ny9TS09kaDl3?=
 =?gb2312?B?djBicHNvM3I3ejBKdlRFLy9IOFQrWFh4eEo2WVRIWWdhVGROZGxiMFkza2F4?=
 =?gb2312?B?UGJhSTMvSkZkOHQ3SU5VbzFCVEhtOGZIbTZ1Ny8rRlRIdjRwVjIzSVZ3RnJR?=
 =?gb2312?B?UDZ1WENWV3FoODJEMnAwVjhxYmF0SlVDUnBBTkVPTXBMb2JwWUYvNExLTGlY?=
 =?gb2312?B?ZnNuK083SnFodW9QZFYxV1BiK25DZERTRGVkQXhDWEJ3RWhSY2ZlSkJoU0lV?=
 =?gb2312?B?Nlp6ZUhJdmJKdHA1QlJJM0RDaXUvVkJQQUwyMXRSYkQ5b25iQXlOVnR2M1VU?=
 =?gb2312?B?akc4cHVSNGVycjVmWG9LV25HMHVHeithUDkyUmNVYUwxRllPdmkvY2o0SVNK?=
 =?gb2312?B?YXFRbk1SQnRaWllIeWxnbFk4eUp0blN5WmJFUXJyTlQvdzYyd1JHSkUxUHQx?=
 =?gb2312?B?MHdDcWFMaGlNL3NzM1RUN2Rka0k4S043cnQrbE9RK1I5ckRwZHQvQ0dJRnJX?=
 =?gb2312?B?eFNDellnUTdmaFhiT3g4MnFqVWhUcTQxT2dpd002NEVnL1o1M1BMQTNPbGI5?=
 =?gb2312?B?RTlGL3FSNnVmYzZjSitNanFCb2IwOGpqOEZnRitpbXlnYm1QeHg0dTJzL1Bt?=
 =?gb2312?B?U3VhNzhFSXVLOU5VVjR6L2IzZjZjWEs3UDN1ODJ5YXp2dCt5M2x4TGZ2TVZI?=
 =?gb2312?B?c2phSkh6Rk0weTc5OTAzZGYvOEVYUW5tOFkyRC9XQ1JWUjArdHlsOEVGaWJH?=
 =?gb2312?B?UVRiTGxsV0dySDZYc2lzMUJDZi9EUHpRNHQxWk9xMUFHQUhqRDh0QlJQZTk0?=
 =?gb2312?B?VGFMSG1TQjc2SzhpVHBETGpMc1VXL09wbGFIYnlweUVoUzMyTUxiZXMrU2Vr?=
 =?gb2312?B?RnFtNkpJNHBNdHJ4UWR1djA0d3pGTFhXMkhBbDF6VnNDYS9OeExrMEFoSjla?=
 =?gb2312?B?THFmU3ZaVzAzY1VtamJncmNNSm1KTDkyb3IzN25SRFl1cFpKQVVpelN1ZStX?=
 =?gb2312?Q?+N2jDEcosK5VFI1yKu?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc41df-1111-4ea6-8806-08da34098bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 11:21:23.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AVEP+WDuSot82D8aOKWx463+XmeW+9fhPy9+fJOKtwsDJAqTN6dFJvRu2ToWYBm3fu2RGytLScaBiXKjOTIMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2217
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5bLi4uXQo+Cj4+IEBAIC01ODIsNyArNTk0LDggQEAgc3RhdGljIGludCBfX2luaXQgcGFyc2Vf
Y2x1c3RlcihzdHJ1Y3QgZGV2aWNlX25vZGUgKmNsdXN0ZXIsIGludCBkZXB0aCkKPj4gICAgICAg
ICAgICAgICAgICAgICAgICB9Cj4+ICAKPj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAobGVh
Zikgewo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBwYXJzZV9jb3JlKGMs
IHBhY2thZ2VfaWQsIGNvcmVfaWQrKyk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHBhcnNlX2NvcmUoYywgcGFja2FnZV9pZCwgKGRlcHRoID09IDIpP2NsdXN0ZXJfaWQg
OiAtMSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29y
ZV9pZCsrKTsKPj4gICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcHJfZXJyKCIlcE9GOiBOb24tbGVhZiBjbHVzdGVyIHdpdGgg
Y29yZSAlc1xuIiwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjbHVz
dGVyLCBuYW1lKTsKPj4gQEAgLTU5OSw5ICs2MTIsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBwYXJz
ZV9jbHVzdGVyKHN0cnVjdCBkZXZpY2Vfbm9kZSAqY2x1c3RlciwgaW50IGRlcHRoKQo+PiAgICAg
ICAgaWYgKGxlYWYgJiYgIWhhc19jb3JlcykKPj4gICAgICAgICAgICAgICAgcHJfd2FybigiJXBP
RjogZW1wdHkgY2x1c3RlclxuIiwgY2x1c3Rlcik7Cj4+ICAKPj4gLSAgICAgaWYgKGxlYWYpCj4+
IC0gICAgICAgICAgICAgcGFja2FnZV9pZCsrOwo+PiAtCj4+ICAgICAgICByZXR1cm4gMDsKPj4g
IH0KPgo+VGhlIGlzc3VlIEkgbWVudGlvbmVkIHVuZGVyCj5odHRwczovL2xrbWwua2VybmVsLm9y
Zy9yL2JkNzQ2Y2YwLTBmZGQtMWVlNi1kMzk0LTY3ZmZmYjVkOWI1OEBhcm0uY29tCj5zdGlsbCBl
eGlzdHMuCgpZZXMsIEkgZ2V0IGl0LCB3aWxsIGJlIGZpeGVkIGluIFYzLgoKPgo+QnR3LCBJIHJl
Y29tbWVuZCB0aGUgZm9sbG93aW5nIHRlc3Qgc3RyYXRlZ3kuCj4KPihBKSBDcmVhdGUgYSBzZXQg
b2YgZHRzIGZpbGVzIHdoaWNoIHJlcHJlc2VudCB0b2RheSdzIHRvcG9sb2dpZXMgaW4gRFQ6Cj4K
PiAgKDEpIDggQ1BVcyBmbGF0IChBcm0gRHluYW1JUSBzaW5nbGUgRFNVKQo+Cj4gICgyKSAyIGdy
b3VwcyBvZiA0IENQVXMgKGUuZy4gaGlrZXkgOTYwKSAod2hpY2ggY292ZXJzIFBoYW50b20qIGRv
bWFpbikKPgo+ICAoMykgeW91ciBRQyBTTTg0NTAgQXJtdjkgdHJpLWdlYXIgKDQtMy0xKSBEeW5h
bUlRIHNpbmdsZSBEU1Ugdy8gc2hhcmVkCj4gICAgICBMMiBidHduIENQVTAtMSBhbmQgQ1BVMi0z
Lgo+ICAuLi4KPgo+ICogdXNlZCBpbiBBbmRyb2lkCj4KPihCKSBDb21waWxlIGR0YidzCj4KPiAg
ZHRjIC1JIGR0cyAtTyBkdGIgLW8gZm9vLmR0YiBmb28uZHRzCj4KPgo+KEMpIFJ1biB0aGVtIHVu
ZGVyIHFlbXUgdy8gYW5kIHcvbyBDT05GSUdfU0NIRURfQ0xVU1RFUiBhbmQgY2hlY2s6Cj4KPiAg
c3VkbyBxZW11LXN5c3RlbS1hYXJjaDY0IC4uLiAtZHRiIGZvby5kdGIKPgo+ICAoMSkgc2NoZWQg
ZG9tYWluczoKPgo+ICAgICAgY2F0IC9zeXMva2VybmVsL2RlYnVnL3NjaGVkL2RvbWFpbnMvY3B1
Ki9kb21haW4qL25hbWUKPgo+ICAoMikgc2NoZWQgZmxhZ3M6Cj4KPiAgICAgIGNhdCAvc3lzL2tl
cm5lbC9kZWJ1Zy9zY2hlZC9kb21haW5zL2NwdSovZG9tYWluKi9mbGFncwo+Cj4gICgzKSBjcHVt
YXNrczoKPgo+ICAgICAgY2F0IC9wcm9jL3NjaGVkc3RhdCB8IGF3ayAne3ByaW50ICQxICIgIiAk
MiB9JyB8IGdyZXAgXltjZF0KPgo+WW91IGNhbiBldmVuIG1lbnRpb24gdGhlIHRlc3QgcmVzdWx0
cyBpbiB5b3VyIHBhdGNoIHNvIHRoYXQgcGVvcGxlIHNlZQo+dGhhdCB5b3UgYWxyZWFkeSBjb3Zl
cmVkIHRoZW0uIFRoaXMgd2lsbCBzcGVlZCB1cCB0aGUgcmV2aWV3LXByb2Nlc3MKPmVub3Jtb3Vz
bHkuCgpZZXMsIGJlY2F1c2UgSSdtIG5vdCBzdXJlIGlmIHRoaXMgaWRlYSBpcyBjb3JyZWN0LiBJ
IHdpbGwgYWRkIGl0IGluIHRoZQpuZXh0IHZlcnNpb24sIHRoYW5rIHlvdSBhZ2Fpbi4KClFpbmc=
