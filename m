Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3C7567876
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiGEUds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiGEUdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:33:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4321F5BD;
        Tue,  5 Jul 2022 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657053225; x=1688589225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r2pm/lAfroyKcUkX5Rgggs3XnYxOHFrQWrbiunnOFUs=;
  b=19liKF52+tHa9sAIC3YtGp5evtmzI+EbsT1KtbnSjvgAHq+uyQyBtJIE
   GOUomE3dvdZ4hxrDyvIStSWJVBGqyX22+wOcXjvf/nN/Iq9UTaG45BFcw
   k66W90OEPkbh2SBNeoLdynsYNzuLBlpNXbWseBW/DXGeR1dlyePy4qVO+
   1k/GmBSWRbHxSVTQyMU7bOPztvCNYe6PdSryMo42J+RBnNSzpxXizbLvq
   6Gj3OT1XEg8gIE187FLSY+m2BVcW4eiCFCvQTjYImBLWmW35iOn9B9zVZ
   6iyi3EEjayf0T/bZaG64sKoXGCSQKrqUJkLXEvZdE+u9cbGgQw1gdVyQF
   g==;
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="170878579"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2022 13:33:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Jul 2022 13:33:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Jul 2022 13:33:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mU0RbRpb8G9sfeFKXBhq9fQiJshgJ3N0srcjnUTa2b4d6wTVN2cQ6I7+nkcQpUONuF1kQF8fj9EODm2oBnzm/c7N/bbD2wGJwNgdjQmC38wq88PY9R0jQNTToZ+ZdA6IPuypya/I3xOul2+k2PkJGxXp+rD6chIyjykMZUomtz6uNd/Hc79U3I5GCTAFi4eOUk3rRp2CMouJTRGX9KEv4rMXsO8aEGJa05Qav+R5dXXIlcnPYqeiEki0qxF9/9vZGgWTpBdLKmIrxMCxkD6/pWRJMRqV3lzdrXdZ5c7T2mBehP32+XRRwmxu8OEmeCrdxvyByOL9BqGt+OjHjIhjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2pm/lAfroyKcUkX5Rgggs3XnYxOHFrQWrbiunnOFUs=;
 b=k+7tTXej9yIaQlF/m1BrxfR9trFIvWs7CtlPIjOLIco3Fld4xVArqz2TLtCGxd0uWV2OceyIXerXTrJ8NewUQVEfknUdygWrJZX+inG03S4C75yL+rX6Y+BD9K7R1M+v2bSo4NBEjQdg1YF7kbkBhTfJWuQWniMeu8upGbnTHLGH7581rSsXAAjrGZs8jmAGZK9nGxKvENX02k7U7b9H5owTYslm+d0WT8j4PuuUT/04rleMiQ1o+UE2d9EG1qnxgcCdQ7rfpM+lPrOejCIg2kh9/hhsxQEFGZtUnwcMubatNtgXcHXzi/L0tS3MHF25OyUB2ZSUcWJ3EKwqTE91vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2pm/lAfroyKcUkX5Rgggs3XnYxOHFrQWrbiunnOFUs=;
 b=nt29APNKauaxGaISYPhe/oIfmB0bxMsG1TDgbYuDvAsP0tNKh3ETbZ5Ni0FqIByU7CIw2M6E7mTEXRPTqLen4gLy5Cn59Jq4TSrxARUDYyl35CyiibHiOZtk7eXFURDtUIGBBVideCpm+vnSdAcD8swCYuQshs9WPhEkGgYQpow=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB3051.namprd11.prod.outlook.com (2603:10b6:5:61::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 20:33:39 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 20:33:39 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Daire.McNamara@microchip.com>,
        <Conor.Dooley@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Topic: [PATCH 0/5] RISC-V: Add cpu-map topology information nodes
Thread-Index: AQHYkKIdHc6oV2H//EKJV+LfcdW+Dq1wN82AgAAD8QA=
Date:   Tue, 5 Jul 2022 20:33:39 +0000
Message-ID: <8f07796a-d9a2-3301-aafb-7fbec4d5b1a2@microchip.com>
References: <20220705190435.1790466-1-mail@conchuod.ie>
 <20220705201931.nfwi5rlku7ykmydr@bogus>
In-Reply-To: <20220705201931.nfwi5rlku7ykmydr@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8aef5462-c34d-4ec9-ec1b-08da5ec5a4b2
x-ms-traffictypediagnostic: DM6PR11MB3051:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3bVJIroV/sB1knJPVFpCp3gDajoveSJsnnhvF85OKpzP4zCN3mc1n+MIKApoGikzsAVUvt18fb56n5atjG+d4S8m2s82raN6qJ2d+GSX3oq0XZHc30kxc0xw5guYEl+nyYj2VwWRS6Gw/Hhixo9kjb1yBYBYvhW02sDroKPDsxz1BNOtWi0NdknxBNOIB/drlHM67q461uZlfZNT/xYQyiGArWQQClB60xhSenWMnh7b6qITqUPmbv75l3iF6fRxJCNe2zcJphNh09Q3aUIPm/J6BefHEC6UgckGFaEofrqvp2Itiad6SN8iMf267zZIGuKfyZTvDLth3nt4E9POOcMf/jRqkZ49Sl5XCylEe0139ywaOKOKNFQFMSCg96fzB9m7MSHNA8z+KVanGLqSLDsWx4X1syACJhlhN2z/yjuRjzuqKr77WKb31IdFjwEAJ3+RO7DiJSQM7LE7DX0q26A79xpnlF7K2hlgo8KE1HDxs9j3KDU5oeKnWYYcNiTM5h1YDxWOurbQPYf+IYZPCI71ElLwKfQ1EAlaWgD0hHPBFNr6LFtKzL+chxEci3CdsWvJhbqjwaRy1eqqVD8+Azj8NVWJ7S8qbZZ8UzfGc86qJM82//9NI8klOCNF6YH8M+ynnpNkAt7EHz2USKzR8/w/2X07Njj7gdWSq8PU/ziQh5RLweWtgtMOv52BXnMbs8WeM6BPCLTxJW+ImzCatSqfpim8bzM0IJgd6A6NZP3rBOCKAqJf6L94NaJduHSVvoUq+BCDzg9oi2auOxFuhQZTk9iik+Ufe5NdCi1rlfGhzR/qPczeDscnxr/GEjdytKC0o726YnGPDaM+nwOI7et/YxN19wuRwGETAlGgafyQnnYZ7cM1ppKZIa90m92o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(39860400002)(366004)(376002)(6486002)(38100700002)(2616005)(66946007)(4326008)(66476007)(64756008)(66446008)(91956017)(316002)(38070700005)(8676002)(122000001)(478600001)(66556008)(71200400001)(76116006)(54906003)(6512007)(53546011)(6916009)(26005)(86362001)(83380400001)(186003)(41300700001)(2906002)(6506007)(7416002)(5660300002)(36756003)(31686004)(8936002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXBhZ25ISzhKS0lOMVcyYWpDWGppV2pIU0dtNTA0N21RMVFZQm9JeDQ3bktq?=
 =?utf-8?B?UWhWaTdFd3AwVkRaV1hWR21xNnBuN0pDSGFSZUd1d0tRNG1QTWE3NmlDYitl?=
 =?utf-8?B?WEg1eHIrY2traEZMY2pJMkovSkZpZWRSRmhRWUdLbC9tM1NZcG5KNTdXTDYw?=
 =?utf-8?B?Yitqdko5UXQyaHdWeEJBQUhEMng2RCtDMzdiOFhXRHlETjd0VDJTbUhxOTg4?=
 =?utf-8?B?ampycUQvQjZmeXNJbEFweWdWNzlGY1JsZXBUYmh2OSszRUVocHkyc2U5MjVu?=
 =?utf-8?B?NUo4VEk3Q0wrdzkrVlI1bFg0SDVScXZKcmNYTHVnbTlSOFQ3UGQ3MG1qNmR6?=
 =?utf-8?B?TUV1R0NXMVBGdzh5Z3lEVUQ2a1NJQTZ6ZC9Ha2RQUGw1VUh5MkpVYm9QSFlB?=
 =?utf-8?B?V0xWUHErSjdhVkxUalEzSXJGaSs0ZjUwTFhqWVl0TG9zbWtOeVlPTEhBVE85?=
 =?utf-8?B?bVdVd0VSNERIVU9td0FYUDN4bnRzUXNSN1Fqc2VwUk0rNGsvR3hqNmZLeWxK?=
 =?utf-8?B?eVdEUDFhZG43YU1uQjZ2M3VXaHRIQWZUNi9kRUpzY1pTVWpNeWVRWW80YnNW?=
 =?utf-8?B?T0dYRGVVc0FFSGgzMWZZc1NUZm5wRlkyNVBCeGdiUlZsL2J2M2pZWW1lM09Z?=
 =?utf-8?B?SEQyTVRtQVdhVGhhOFBZZlJrTXlkdzY5RVNWelVITFlFZkZVWGQyMlgvcGs5?=
 =?utf-8?B?SHRFeHVtem4xM3VoM3ppM1RhbWp1Y1EyVHZmaE1PeHVOdU9NUnZMazNDaS9Y?=
 =?utf-8?B?NEpaeG9GRHp5ZThDV1h0TmFxMFJSK2UvRFpSL3IwOFloNFJ3K0M5enFMcko3?=
 =?utf-8?B?WldMek4wLzBRSXFqTi9sMURVVnN0MjkyZlRPZXVxOU9UYUFXYkIvUHBDWnFh?=
 =?utf-8?B?RlpiWFVidEpQbDZabzlndHA3cXNCVzc4cWcrdUdncWhVT0ZlTWJUSDVwbEQy?=
 =?utf-8?B?bFdPV0J2US9WNUxIQUZZYTA0RmJlcHdqRTg2LzVDa2hoSE91UHFxdnd4UWVU?=
 =?utf-8?B?Yzl6LzhtWUFQTWZGOEMzNVNGandqYnBKQTk3V09acllsa1BuTDJ5a01ralc0?=
 =?utf-8?B?bmdYWm82RnhuTUZVS3RWNGZ3ZkVGYXVBT25BNytLWElnbkZFSzhHQmNZZHBk?=
 =?utf-8?B?a3Z3eFVMMHBvalJlWklRbkhObUcrU3ZEYmFLMUZrT0hQRXR0ejArMi9JYlVC?=
 =?utf-8?B?NGVtVGVuVEhGR2QvS28wY2JMRlJNYktac0IzeThDTnhIeEJtaVUycUNwYkIw?=
 =?utf-8?B?cElDTWZUeGE0MG02ckdCS2RzVk5Fako0TkNkUnIwZ1RJZFkwdkowcTh6ODdl?=
 =?utf-8?B?aHdXUnhPaHlxNUFnOHoybm1ndTFsdG1DUGdlZTZpWXZxSFBYVnVOVzN5SDdZ?=
 =?utf-8?B?Z2NZSjM5clJzMHhjaUhFbTVpdGFqdjNpYjl0L1VwOU1qZnA5S3gwRERlUzBw?=
 =?utf-8?B?ZUlOK3REcXZ2bVBmOXNBRGtOYVovald1NmpJRE9VdWR3MlVmYm1CVGZKT2dO?=
 =?utf-8?B?VmhRU0lSVFFvRG1RdTFCbVE5SE15R1VWNytXSCt6STl2cTJsaWlXNXFyeWVO?=
 =?utf-8?B?NUpaWnd5QmFKVDVDcE51eXlya0xVOU9aN2w5aTk2SCsxOHI3R3k2QVZXWlRt?=
 =?utf-8?B?MUxNcVZURytta1ZGeGpMWE4wWTM2bU5BM3NHQThaQkJoVVFldFlZZExPRnNt?=
 =?utf-8?B?N2FkenBpL3k4dlY5OXhPeUVNcUdwQlUvcjVjOHFGdUoydjNxUGdZamJhNExS?=
 =?utf-8?B?NTVpeHA0K0tuMSswQWtIWXNKcXdXMEVnRFpJYVdCTHpTWHFwQlVtQ2lzWFZq?=
 =?utf-8?B?Tm4vN1kwbGh0QTNpOFExMS95eURvMzJTLzkvMkdidDBIUWkrZjhBRnFubUsw?=
 =?utf-8?B?VTRRM2M0U3pGVHIzVW1xL0xFVkdCbTdqL2RoaHNpejBIbU83dktldVRvWjc0?=
 =?utf-8?B?Y2F6c1RHdnpUOFFxSm05TkFMa21nenNLVlF2ME8wZUZqQXRBT3ordGEzZ0xn?=
 =?utf-8?B?bXF5N0tSV0hwSndTY0dKbUdzQ0gyUFZxUlBKODAxVUpFTHJYd0dVMEpLaXNr?=
 =?utf-8?B?UE9sVTNGL1cyc1UvUExTTWtqUUNjYWwyL0M2d1RkdHFDaG52NzZMZHRkbUlo?=
 =?utf-8?B?Smo2dXNSNWtJUU5WY2xwUGFWTXNBTlhqd1BlbXBka0drVFhTTy9SaU03czRS?=
 =?utf-8?B?M1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2F373F34B86604F9F403DFB3F33C4E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aef5462-c34d-4ec9-ec1b-08da5ec5a4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 20:33:39.0791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tKTSSqIEacVpY4g/85Oh8/ucizH0/F0tXYYnrevqUvBJ5jaxImmXs5zGxpndO+/HRhzHLjMaXhItkli43JbVcS/CWqQT1I2Y9jip2EgarE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3051
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzA3LzIwMjIgMjE6MTksIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gVHVlLCBK
dWwgMDUsIDIwMjIgYXQgMDg6MDQ6MzFQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4g
RnJvbTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBJ
dCB3YXMgcmVwb3J0ZWQgdG8gbWUgdGhhdCB0aGUgSGl2ZSBVbm1hdGNoZWQgaW5jb3JyZWN0bHkg
cmVwb3J0cw0KPj4gaXRzIHRvcG9sb2d5IHRvIGh3bG9jLCBidXQgdGhlIFN0YXJGaXZlIFZpc2lv
bkZpdmUgZGlkIGluIFswXSAmDQo+PiBhIHN1YnNlcXVlbnQgb2ZmLWxpc3QgZW1haWwgZnJvbSBC
cmljZSAodGhlIGh3bG9jIG1haW50YWluZXIpLg0KPj4gVGhpcyB0dXJuZWQgb3V0IG5vdCB0byBi
ZSBlbnRpcmVseSB0cnVlLCB0aGUgL2Rvd25zdHJlYW0vIHZlcnNpb24NCj4+IG9mIHRoZSBWaXNp
b25GaXZlIGRvZXMgd29yayBjb3JyZWN0bHkgYnV0IG5vdCB1cHN0cmVhbSwgYXMgdGhlDQo+PiBk
b3duc3RyZWFtIGRldmljZXRyZWUgaGFzIGEgY3B1LW1hcCBub2RlIHRoYXQgd2FzIGFkZGVkIHJl
Y2VudGx5Lg0KPj4NCj4+IFRoaXMgc2VyaWVzIGFkZHMgYSBjcHUtbWFwIG5vZGUgdG8gYWxsIHVw
c3RyZWFtIGRldmljZXRyZWVzLCB3aGljaA0KPj4gSSBoYXZlIHRlc3RlZCBvbiBtcGZzICYgZnU1
NDAuIFRoZSBmaXJzdCBwYXRjaCBpcyBsaWZ0ZWQgZGlyZWN0bHkNCj4+IGZyb20gdGhlIGRvd25z
dHJlYW0gU3RhckZpdmUgZGV2aWNldHJlZS4NCj4+DQo+IA0KPiBSZXZpZXdlZC1ieTogU3VkZWVw
IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gDQo+IEkgd291bGQgcmVjb21tZW5kIHRv
IGhhdmUgc2FuZSBkZWZhdWx0cyBpbiBjb3JlIHJpc2MtdiBjb2RlIGluIGNhc2Ugb2YNCj4gYWJz
ZW5jZSBvZiAvY3B1LW1hcCBub2RlIGFzIGl0IGlzIG9wdGlvbmFsLiBUaGUgcmVhc29uIEkgbWVu
dGlvbmVkIGlzIHRoYXQNCj4gQ29ub3IgbWVudGlvbmVkIGhvdyB0aGUgZGVmYXVsdCB2YWx1ZXMg
aW4gYWJzZW5jZSBvZiB0aGUgbm9kZSBsb29rZWQgcXVpdGUNCj4gd3JvbmcuIEkgZG9uJ3Qga25v
dyBpZiBpdCBpcyBwb3NzaWJsZSBvbiBSSVNDLVYgYnV0IG9uIEFSTTY0IHdlIGRvIGhhdmUNCj4g
ZGVmYXVsdCB2YWx1ZXMgaWYgYXJjaF90b3BvbG9neSBmYWlscyB0byBzZXQgYmFzZWQgb24gRFQv
QUNQSS4NCj4gDQoNClllYWggdGhlIGRlZmF1bHRzIGFyZSBhbGwgLTEuIEknbGwgYWRkIHNvbWUg
c2FuZSBkZWZhdWx0cyBmb3IgYSB2Mi4NClRoYW5rcywNCkNvbm9yLg0K
