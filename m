Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66087595216
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiHPFeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHPFeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:34:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D826823FE85
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660601704; x=1692137704;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=8ErtX1O4mXAC+uorKTtJDEULLX7NBRq1qAhebU/zdRc=;
  b=vxV7c/PZVg6q7q2AIW7jvtB/is7vAPit/JtHeXlzFEfybJ0IyzJOpEHP
   fOcbXOtV62G56+lVGRRxCFNgmb45ga7SkTuGovawSmwp5VwAMM+qcuOXn
   dYbtW1t7bdF+12vWV5Ba/MaDX60vMQ9oWLKafUGYIoI+PL1dqrOk/7099
   g/FF+miTyOM3eRCFDW2XfHhirIWO+Ewn983UmVsmatly/45cQ+J13tGPk
   +vYZNfs18yhkMFMkbqFgXq8HqRXj5c45rzJ6M/EWhQxKHLle2K2eYMhnd
   6CCWI0kyb+XlZCJIloazljSl3ffMyjGcWCy3LKkDBiia9yTXWgJXgPgKm
   w==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="176341821"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2022 15:14:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 15 Aug 2022 15:14:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 15 Aug 2022 15:14:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsmezGIRrsad9phFZYe8StIefAfMTtAWiWc7CG7/j1pSI/02y1OtlFSQvXPCkPaiH9/nK+IdOyYS/Jb1Salfv9GHtTfSgwx3vZaCzQxpUxV6jvoeO0iPNPDCmnzEKDdJ7q4pqMyN0mH73aPTrI22USg7U7GFgDnL1/DN8OlkJRFCZ3A2lrULHIyYyPthE03J+RUrEkPpIMyDYSH08Bj/TQ1qqupaDIF3o+p2I2rT/gZ8Hov1c8x0ybpTPjlEdG/4VEuf08q+6aE0cMv2LlY5C3vLfSQBR+CaXPyHCmldV1Ik8WJa+TcbvWS9wFyanDbEF3Swj9+tW46uHB5A1ME6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ErtX1O4mXAC+uorKTtJDEULLX7NBRq1qAhebU/zdRc=;
 b=fXUKygS00v1Xu4CVsJXNmV2NkZMx7cTdUgL+fs7TaLLQWLP5aCG8pX6+LXRs7kGT9CuTrcwWItT0US7hmlswliyq2D4yRGVY8Owm6ccfGMigxVFcMsCS1YueFwxQtKsb6e1FaZdckrmgRGoBhKIavs6HS2083s/E/XFy0tGaTTInnkZO9RElMaf8FV7Ra+pcSuMy0Goa3OXyETPntG//3TyPORgNuSwq0Rg1BIGFqCpDMPsq8u5bzVfhUb5LXub66WXsB9K8rnoHw8IhT4bMqJ/gaFCouLGUjxCaYhN2XpvYFDmSDQrj0TY+yRN80u2TLZdmADzOLeC81tPGU7pjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ErtX1O4mXAC+uorKTtJDEULLX7NBRq1qAhebU/zdRc=;
 b=RA28NO+hNEyDH6dYQUO0R+fN189cpyfVhdURxTfoqGOjaplEApWp5Ja4hypBJ2a1lG1PiSRLRsxVG99qg3AjelVTDH2SPCs4l3/O9kGKpqyDJO8hYMIk51wXbDXJWGrCxP1K/AearSsVdSzqABH8RpZG15VGiWLSSa2uK6UFLfM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB4132.namprd11.prod.outlook.com (2603:10b6:405:81::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 22:14:56 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 22:14:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <palmer@dabbelt.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <atishp@atishpatra.org>,
        <Brice.Goglin@inria.fr>, <gregkh@linuxfoundation.org>
Subject: [GIT PULL] Fix RISC-V's arch-topology reporting
Thread-Topic: [GIT PULL] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYsPRyXnHNGxm8rkSgpyoSWfWKTw==
Date:   Mon, 15 Aug 2022 22:14:55 +0000
Message-ID: <4849490e-b362-c13a-c2e4-82acc3268a3f@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d1b57d-0904-416d-36ac-08da7f0b9556
x-ms-traffictypediagnostic: BN6PR11MB4132:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMmHsoLRdLEsbD6Gtt8INdVdUJ2M/T13Wa2vAGCPWbrpFyyH1TmSqHwLQKz9nqt+yXFR2k7cti7HSkRxLqvY26XF9+0dagurlz3cROcRHeY8mDDQ4wk9FroDLsRN+hDxEn41A46FUxh8znCJki1i9dB+3xfgJNUShV2eSV41aCGN2npcfiAjFzyiAegTO7ERNaqs/567zuvf/M23FRe9xPU9N9HOiAv/14fAvQTm54tzpeqhn0/DjaX4xVJMTCfFQ5/vzZARvfy+uoBceLd+wvYb90sqPgUiNFCGUDYdnrp86NzilWaGQN0HEKChPChIeyphU92TyTvVhRBA2wutXQmfZIh8enkhTTbC9hjs87XTLRnALXbiefNskhr58YZaVSWw1LJErphPzudLwzcn68ZYFNHhgqPJNZ2GplxKjsybTHKMWwvnZcGUoKLkibqHHpGS5/eTDpYQ6qVIAkjSGtepeISzLf/vWyffO0DUCtyXFX8BrfAbcJQaLSu2tf+HK/64jhEhvg9BfdHeaRhEgKhDSZorsNmF/22u7OvEsmc92f+yjpQSNhbOdLweTTNSSRPhyLe2CEx9fYgzeC2lk+GC30qxRvasv2uutxBz/YEhQyzeOJv01Xe3SWD0T64DvWJOcyB1DjIsSqtPRqD55wn22rBwGOIaEd8NdF5cTzypIiyTNpupIEKIA/7D5tkqvInFX1kCNRII46/1B0kbSnnkHkSeE9LUEdVOYUanNN3L8Dccx9izHh2XbLiMM5VwyASHcQzoUd+vqi5Lyo8zWlWWwq6F+9kxl6p06P9N32EprhuL9K0+KYjKDrJvKBbbEpylGH0Ke728yoHiYZ+KMZ1TSHURooTlyn8qfSkERJZaOB8JSjSuyi1XhoVLot4XxYR3egn6JSfOpBz2F6iqd9uljFNGEkz3wLMwXF24zJajY2Nq1Pdcubf1pKgOQKS+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(39860400002)(346002)(376002)(6512007)(71200400001)(54906003)(2616005)(86362001)(41300700001)(6506007)(36756003)(186003)(26005)(83380400001)(91956017)(316002)(76116006)(4326008)(110136005)(31696002)(66946007)(66476007)(2906002)(66556008)(66446008)(64756008)(6486002)(5660300002)(478600001)(966005)(31686004)(8676002)(38070700005)(7416002)(122000001)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFZ5NDdGK2R5NHEycUdIRFhRS1lqWmRaeFQybnczWXNiWHdtTjFnQ3BFWm1V?=
 =?utf-8?B?S2FjTEQ0UkpQZFU0MFMvRERzNUlQR1VEeUVxM3VIbjZWbUVURVhDaVAzTjVl?=
 =?utf-8?B?VDRlTjA1NWdJby9NOWIwd3dFZzdXeDdVMGkwTnVCT2VYYmM4eVBTbkRYUW9Y?=
 =?utf-8?B?U081MFNlc3pGNGVOczQ2TmpMbnBrTUFMNkJtK3ZvOUxlcnJ6OFUrK1R3ZHNr?=
 =?utf-8?B?RVVKKzhRWXdwdHQzNGZEM3hCMnMxeVJ1cE8wTmg1ZWo4ZWxhUU1LaGhHY2J6?=
 =?utf-8?B?eU1UdFQ2N3kwWDROdFhwMDBoRGF0R0x6RytIUEN0em9uSVlod1BRcHlwZnMv?=
 =?utf-8?B?bE81bzd4N2VjUm5zL2dIOFZTWWZocjVQRG9hektYcmhWV25UYkR4OXdnRU9i?=
 =?utf-8?B?bk14bm1LOTlqdnJZV2Z2TTNBK3g3M1RZSW8vdWVoVmJWbDBBenpsTEZNQ0tP?=
 =?utf-8?B?NC9Jam5lbzV3M2tLOWpCYitET3VVNmJQem8wSm1QNjhtN2hOWENjTkpqZG9C?=
 =?utf-8?B?dTBQa0wvZDB6R1doanBSUXFZWHZGZGxhVzVyaUE5OXVGOWd1RDVmQjBsVGRI?=
 =?utf-8?B?T1BtaHZDOTNLTzZDaHppZVA1QWd6RlFBaCtVSU5rd3BHS1RRVnQyWWFIWjBp?=
 =?utf-8?B?UE1yWTRNaGlpc3FwSTBvUElQQ0tEc0h5eUVaeEV5bDJVN3B0Y2hpcGpWQ0Nv?=
 =?utf-8?B?cXBvTHpXSlZZcFpKNXk4Q0hWQmpUZ3g3c3JXK3RsMFgrRzBSTFhyZ2RhVzhj?=
 =?utf-8?B?Z2VscnRHS1VqQ2o4bll6UkN2YVl6cy9oK3NhVzE2dUo1dlZyanVLOENSVHVq?=
 =?utf-8?B?bVhEdWJ6aDAyTElOTWlEZi8wNERUV2wwbnlMVUVUVThtUWtsdTRzLzBrYldU?=
 =?utf-8?B?S29iUkNaQ3lrNEE3TGEyZllrYkErdTE4OWJjRnZaNDFZcTAxYlc4UG5QMy9w?=
 =?utf-8?B?M2hKWktuRVl0YU9JTzdtUE1TbWpMZlphRThGTXpGd0g4OHhSMm0yMHhpZE0z?=
 =?utf-8?B?alJ4b1NCeVJFcHk1ODh2dWRkYmxDQ21qNDRNeU50U25qdWREOFpFWFh0ais2?=
 =?utf-8?B?b3k1clpqVzVHbkZSMzVNa1d6TTdLVi8vU0JQY0NXcklQVmZmbnN5RHRTdkRh?=
 =?utf-8?B?djBlZW5WWTNDSEwzaXdsQlpsWlFvby9ITW9yZ2lUeUxoMzJ3cUlGczNGNUVK?=
 =?utf-8?B?bzNXK0xLaDN2MXg2NjFGUmhwa0hKVVN5eE1CemFFNDVWYllkMDFMSUpNK3hk?=
 =?utf-8?B?OVh0L2I0VEYrcFU4NVF1NkozckFjdTNuZENhc1hiN1h1SW9HMGNkakpmdC8x?=
 =?utf-8?B?WFZMWnJHWVcrMmVRdlF2UDhMaVM3RVhiSWUxc2ZyeXFtNDM3NWxLNVdwZjVV?=
 =?utf-8?B?OFdkZElNQm1mazhCYXhGc1dMM2pzQ3I2RkJVRDdZZkFZVHRXRGRNd3duMW1K?=
 =?utf-8?B?N3cvMEE4alRKQlJMcGpncm1jVTM2cHdQV1VEZnc4aEh0UW5xcHI4eWZ3KzdO?=
 =?utf-8?B?T0ptWHhVWmdCb2JJWUF6WFljVEdrblpMeDV0ak5BY0FOd1JrYnRjTEpqZHJW?=
 =?utf-8?B?djlBeGJneHdBQUZPTWgvMDU4ZmlXWjMyeDVjN2NLVHpvVWo1UzhVSktPc2RJ?=
 =?utf-8?B?akttY0xRUUNRVk03UkJYaXZFSW9wdXVFTUQxbEdRa0xHK2Y1RUhqVnE2SFZL?=
 =?utf-8?B?a2FkTkdJdWo4dlVyOS9OTUlaL25CNDZtRDRiRjRXbEUvU29PN1dZZ3BMY2xi?=
 =?utf-8?B?VUNaQ2N6dTZ6YUJzcDFGQzJIck84Ty8xdUNwaFE2OTVmTElDdVpuQmtMVGF1?=
 =?utf-8?B?enlkbVB5S2hwNHg5Tks5SWQ5ajJQT1cyRExvZnhVc2NlK2I3K0RLVVI4dXV0?=
 =?utf-8?B?enNuTmpkcGdGZTNENXhuYVN3bjZTUDI2YzA3RVNZbFhIQXhFZTBkZEpOTmxK?=
 =?utf-8?B?TWc0UzZORkI1M2QvRm9xL0QxelRkTStLdnhmRCt2bWNyM0JFOURLMmVIOStK?=
 =?utf-8?B?SEx6ODM1bWswNDFwZkswUDE0YlNPbXJYd1VhTXZrVWpDOUpGQzhVMEpIdm9q?=
 =?utf-8?B?M1hxVkg1cWpNdElVNFVWVSt5WUpEMUROdU9lMXhtT3pTbERPUDRsME5nWnly?=
 =?utf-8?Q?hgt6IydE2EUw0Ib9snlE4H2yi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABD5967021992B45B9DEAA94C532255C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d1b57d-0904-416d-36ac-08da7f0b9556
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 22:14:55.2857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwfZj1ICuXsCaQkPnm7YsyiUuwnDMygi2Zbemb0/H853cIVBSkhhYm+8Uk/k3g42zBgVfau1E66GBfcGbyerxjql3HSaXfvNEZGjctMq15w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4132
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IFdpbGwvUGFsbWVyL1N1ZGVlcCwNCg0KQ2F0YWxpbiBzdWdnZXN0ZWQgWzBdIGRyb3BwaW5n
IHRoZSBDQzogc3RhYmxlIGZvciB0aGUgYXJtNjQgcGF0Y2ggYW5kDQppbnN0ZWFkIG1ha2luZyBp
dCBhIHNwZWNpZmljIHByZXJlcSBvZiB0aGUgUklTQy1WIHBhdGNoICYgbWFraW5nIGEgUFIsDQpz
byBoZXJlIHdlIGFyZS4uIEkgd2FzIHN0aWxsIHVwIHdoZW4gLXJjMSBjYW1lIG91dCBzbyBwdXNo
ZWQgaXQgbGFzdA0KbmlnaHQgdG8gZ2V0IHRoZSB0ZXN0IGNvdmVyYWdlLCBidXQgTEtQIHNlZW1z
IHRvIG5vdCBoYXZlIHJlcG9ydGVkIGENCmJ1aWxkIHN1Y2Nlc3Mgc2luY2UgZWFybHkgb24gdGhl
IDEzdGggc28gbm90IGhvbGRpbmcgbXkgaG9yc2VzISBJIGJ1aWx0DQppdCBhZ2FpbiBmb3IgYm90
aCBBUk1zIGFuZCBSSVNDLVYgbXlzZWxmLg0KDQpJIHRhZ2dlZCBpdCB0b25pZ2h0LCBzbyBpdCdz
IG9uIGNvbm9yL2xpbnV4LmdpdCBhcyByaXNjdi10b3BvLW9uLTYuMC1yYzENCndpdGggdGhlIHBy
ZXJlcSBzcGVjaWZpZWQuDQoNCk5vdCBzdXJlIGlmIHlvdSB3YW50IHRvIG1lcmdlIHRoaXMgdG9v
IFN1ZGVlcCBvciBpZiB0aGF0J3MgdXAgdG8gR3JlZz8NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCjAg
LSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi9ZdGFjN0cxemxxNldXNGp0QGFy
bS5jb20vDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNTY4MDM1YjAxY2Zi
MTA3YWY4ZDJlNGJkMmZiOWFlYTIyY2Y1Yjg2ODoNCg0KICBMaW51eCA2LjAtcmMxICgyMDIyLTA4
LTE0IDE1OjUwOjE4IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9y
eSBhdDoNCg0KICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9jb25vci9saW51eC5naXQvIHRhZ3MvcmlzY3YtdG9wby1vbi02LjAtcmMxDQoNCmZvciB5b3Ug
dG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBmYmQ5MjgwOTk5N2EzOTFmMjgwNzVmMWM4YjVlZTMxNGMy
MjU1NTdjOg0KDQogIHJpc2N2OiB0b3BvbG9neTogZml4IGRlZmF1bHQgdG9wb2xvZ3kgcmVwb3J0
aW5nICgyMDIyLTA4LTE1IDIyOjA3OjM0ICswMTAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpGaXggUklTQy1WJ3Mg
dG9wb2xvZ3kgcmVwb3J0aW5nDQoNClRoZSBnb2FsIGhlcmUgaXMgdGhlIGZpeCB0aGUgaW5jb3Jy
ZWN0bHkgcmVwb3J0ZWQgYXJjaCB0b3BvbG9neSBvbg0KUklTQy1WIHdoaWNoIHNlZW1zIHRvIGhh
dmUgYmVlbiBicm9rZW4gc2luY2UgaXQgd2FzIGFkZGVkLg0KY3B1LCBwYWNrYWdlIGFuZCB0aHJl
YWQgSURzIGFyZSBhbGwgY3VycmVudGx5IHJlcG9ydGVkIGFzIC0xLCBzbyB0b29scw0KbGlrZSBs
c3RvcG8gdGhpbmsgc3lzdGVtcyBoYXZlIG11bHRpcGxlIHRocmVhZHMgb24gdGhlIHNhbWUgY29y
ZSB3aGVuDQp0aGlzIGlzIG5vdCB0cnVlOg0KaHR0cHM6Ly9naXRodWIuY29tL29wZW4tbXBpL2h3
bG9jL2lzc3Vlcy81MzYNCg0KYXJtNjQncyB0b3BvbG9neSBjb2RlIGJhc2ljYWxseSBhcHBsaWVz
IHRvIFJJU0MtViB0b28sIHNvIGl0IGhhcyBiZWVuDQptYWRlIGdlbmVyaWMgYWxvbmcgd2l0aCB0
aGUgcmVtb3ZhbCBvZiBNUElEUiByZWxhdGVkIGNvZGUsIHdoaWNoDQphcHBlYXJzIHRvIGJlIHJl
ZHVkYW50IGNvZGUgc2luY2UgJzMxMDJiYzBlNmFjNyAoImFybTY0OiB0b3BvbG9neTogU3RvcA0K
dXNpbmcgTVBJRFIgZm9yIHRvcG9sb2d5IGluZm9ybWF0aW9uIiknIHJlcGxhY2VkIHRoZSBjb2Rl
IHRoYXQgYWN0dWFsbHkNCmludGVyYWN0ZWQgd2l0aCBNUElEUiB3aXRoIGRlZmF1bHQgdmFsdWVz
Lg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpDb25vciBEb29sZXkgKDIpOg0KICAgICAgYXJtNjQ6IHRvcG9sb2d5OiBt
b3ZlIHN0b3JlX2NwdV90b3BvbG9neSgpIHRvIHNoYXJlZCBjb2RlDQogICAgICByaXNjdjogdG9w
b2xvZ3k6IGZpeCBkZWZhdWx0IHRvcG9sb2d5IHJlcG9ydGluZw0KDQogYXJjaC9hcm02NC9rZXJu
ZWwvdG9wb2xvZ3kuYyB8IDQwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCiBhcmNoL3Jpc2N2L0tjb25maWcgICAgICAgICAgIHwgIDIgKy0NCiBhcmNoL3Jpc2N2L2tl
cm5lbC9zbXBib290LmMgIHwgIDMgKystDQogZHJpdmVycy9iYXNlL2FyY2hfdG9wb2xvZ3kuYyB8
IDE5ICsrKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMo
KyksIDQyIGRlbGV0aW9ucygtKQ0K
