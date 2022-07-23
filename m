Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127F57EF02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbiGWLWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiGWLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 07:22:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773403D5BC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 04:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658575325; x=1690111325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RWBJ/yRKSSe/VTxpK5BDsfaolB5mxrTy3U590x55QlU=;
  b=DZObCXpNsxu0xEm6yc1x5ek3rRbSyteSMDWagJ5CKkRYjScOnz+3mAgA
   7wy2cbQfaf4ltOnPCAkYs9GfMsRSeqg9VrutsLjxL6ghLjcw2jUgFeUm7
   U4ufi7lTYjmFs44Bc7on3LMN+sG/QZoxJKrkjetKp+vxxsqNs+yx6Nkti
   81N4IK647jrP8JbBmUUkxfulN8zpTdv8imXJkd2ag5CQmVU07sae/PJA4
   tji7QOkVwUe3VvTDR5iVZSmpW8n3dVi7txOm8s2Xxo7FOWGzSyYo66ZJ8
   K4Y0tHZgbZilO/xGG09nLKiDMjCIoqpaJhSDccheN9Dl75ZBe0PcxBa4q
   A==;
X-IronPort-AV: E=Sophos;i="5.93,188,1654585200"; 
   d="scan'208";a="183448109"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2022 04:22:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 23 Jul 2022 04:22:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sat, 23 Jul 2022 04:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTezOVbuSg9JLKDPatMN1t9iiboPIqU/vfgtg60BW1K+jGsIDUm+3RPDxFbW+pEGmPCTc+ZfdITP8LpQfWU5Th7soYvu8IYPWRR3k7LRlnCvG7L8fPWBL/0AcZVhGSjCKaPg5aMHzBBruuV7v29ClTJbUSJLo56FopPaZAq3gY9ObfUgdABRUtkPOvYFPIS2eoh6ymttfmUP24qJYHMavWidYsPIQoUS/ysAwkRX1xwiaTHI06DvtPKhLi0eXDbk/CKLrJhCw7/NGueQy/9qzYD35CtIrBdbA5m9Hyqob8VglKITRh84MVWaL37hcO+5ZOg2iZk1cSsyhD4aAaSSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWBJ/yRKSSe/VTxpK5BDsfaolB5mxrTy3U590x55QlU=;
 b=UF65GkTSk+t3x3cTw/YqPZSUat6q/zL+1qd/VPtukm7wXOugL+b/kvZd8ck2VAPQm71P0yMvcbHYItgXAvNx89z+olfveTrIykcwPPoz3D10m0KWqlKbV8SovImTpNlTZXZSOLe4uY1na3Ahd/XfYcaUMF0lyu7lKtQKgq5EVNcvhdJbeb+LXsiA3ce15FHuHSwMQNSacGEfyAdtMyZ4jw0ycPEydH011UHjrfMF1lYs51OZv6Ipo1pYX+fe8e59L+bfSrECbkcCe6W/wtQOEuAHkD7c5yy8mK4dctxqj89sTNeXEHlfyXHttuZ62HxhQXN5BnBp5ATtWkjHSSBy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWBJ/yRKSSe/VTxpK5BDsfaolB5mxrTy3U590x55QlU=;
 b=PLlOyvAQitx6gCT9l710cMMTrBBKUpYe9g5Um31cEvKtFOLwCEWpqcuJhTCaGdXbuOaNu/lyJ7eSsOZLcAn7Bb86rR8iCEm4a76JjaCKOduIoDQEeBZRSq62s+uQfx4U5YAmLI/pbE5bYKZeVt+jsUHmHxZTONmk0k1PsBiIQCE=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1453.namprd11.prod.outlook.com (2603:10b6:301:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Sat, 23 Jul
 2022 11:22:02 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.018; Sat, 23 Jul 2022
 11:22:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <sudeep.holla@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
CC:     <Daire.McNamara@microchip.com>, <Conor.Dooley@microchip.com>,
        <niklas.cassel@wdc.com>, <damien.lemoal@opensource.wdc.com>,
        <geert@linux-m68k.org>, <zong.li@sifive.com>, <kernel@esmil.dk>,
        <hahnjo@hahnjo.de>, <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Topic: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
Thread-Index: AQHYmHPj95q5mWrtS0GGLuvs3DXs0a2L2/OA
Date:   Sat, 23 Jul 2022 11:22:01 +0000
Message-ID: <96972ad8-d146-3bc2-0e49-ffe88580bbee@microchip.com>
References: <20220715175155.3567243-1-mail@conchuod.ie>
In-Reply-To: <20220715175155.3567243-1-mail@conchuod.ie>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce60f4fc-753e-40a9-7273-08da6c9d90a3
x-ms-traffictypediagnostic: MWHPR11MB1453:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fuOBE38tjAFCd+rJpty6ajEaPFP9Pppih3VpZKCF68Fp+emNIMcabDLvl0Pj6XlAEzpbvNoOuWPG/su7vV3hwRTQnHjUpbn39gnd6HgOF4AsFOoEM/+Ui/gZ/kyW7FnfGXOYpJN4oLJGu32l7PnBQlxDHGWZAuT//7iY0vh5F2riUXa2glpG4rzPBw616PCAV1hJG32JIpDTEFMQx3hm8GYD9TMmixYSQRD2Y5R/jK66fUdUCietz06z7zgW9TsIdI68kBxZkxYuawsuMm9h6uKK5xE7nTeEUSFVQDvaF5MwVpjO/hW1X1si1OiJJnxG8nLFa87WgLMfqo7b4BSCbVTnIxb4y6isgrAICnn5KRP6uSbHYe/aPcnP5z8KCfeqS/Q06uIxQ5RHr+iOkyURkLkm2uBo+HotoySwqkq4+Ao/TBJJ+8HlrsxhdCfTzpoFkqfPXOWOW3+yDi6GMSV+HZenbi80aQNu38pIZGDNcNeWIg6kn2M3v034sramiLahu6rfyvK+h6R3pxU4iMR0INcD51AiUgS2nrmLbpsl6BctVdYvTzeuUXZfW2MiAWKajNWXiAE16Tep6wK0DkMfRWqK4cdlXIKRJ4HWSuoBUmOT54YZBYn/ZBLV0sSG20XptsJAnb7RO7VaBwH8YWNd76LcC9fNZgwpq3U0vxT1S5bsLAXDOxCUKtnwPd3ZJTS2+f6JYfFx/en1/bPZG1L0ekej57xgM6okbhSzTeUErOapQfU/ehDVUn9OILnGcQyvP/lfA58LazIW2cyWppcPJcsXg6m7X91Iu3RY8hsPiHa3QHn0418gTMat9Nlh7YCqhlYrKJ5JctBsZ/IL707gQUOfSZ9n1eZQTCgbztT048gmP+6LpyyqeddCaOPIQtcEgrnccDRxShwH+VGja8bNFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(316002)(110136005)(41300700001)(36756003)(6486002)(966005)(478600001)(54906003)(122000001)(53546011)(66946007)(38100700002)(6512007)(6506007)(38070700005)(26005)(2616005)(186003)(8936002)(31686004)(2906002)(5660300002)(71200400001)(31696002)(7416002)(4326008)(76116006)(83380400001)(66476007)(8676002)(91956017)(64756008)(66556008)(86362001)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlR0MHY3UmRBbTlxUU5EUFl3eHpzWDI2bzdXZjR2TkNlTkEzQ2hTbWlCdmFQ?=
 =?utf-8?B?bXBsTlBHMXdBWDBOODBNNzJKWVJRQlVkenBoTGpsTEVKQ2xUdllzcGZRY3BK?=
 =?utf-8?B?MXdpNks0enZuYjJ4bEg3WGE0S1ZyVlZyVmtnSCtXVU9VQjRNWDN0bWNSc1J4?=
 =?utf-8?B?VXpWLzlBc1cvd1Vtd0gybW9PYVM0bC9lOXluN2xCYXgweGlYTDIzeGRmR2NS?=
 =?utf-8?B?c28rM0xoTS9OKzlOOS9XR3JTa0JMeElKYnI2QklBZHllR0V6YmJteEl4WnVi?=
 =?utf-8?B?TVRNVHlaVmp1UkxmNWdEUEp4KzAvMVI3akMrNHVmRWIrTVN6SlF4SDZtT2tp?=
 =?utf-8?B?Y1BoYzFMeEZxczIzelZ3bW0renBpOUFjN3BrY3RUenJZL1VoeDlJTjQwV3JF?=
 =?utf-8?B?ckZ6cmZUL0JxZHU1aldiMG9vRkZUZDRpSkFxTEg2bUVOOE5MbmdRb0k4SDZG?=
 =?utf-8?B?aHhxTXlKQ3JZQ1dSTUIvM1gyYkdyd2JIRmc3eTIxSUxwU2FBbDBsUWg1MWI1?=
 =?utf-8?B?T1EwU3BJaVNiVHBUeUJaVkU0UWdwMGZXUTBIcFMwemgxaWdmZCt6cXJURWR2?=
 =?utf-8?B?bUlpb0oyWmJDU2NncldDZ2hCMkJlUTU0L1VzMG1JRHVvdHl2QUFXZlp0RlY5?=
 =?utf-8?B?UUY3OGpHL0FXMXk3ZzMvRzlmOE5OUVIwWE9ELzdsRUM5cjRLZzdKN0EyT0ly?=
 =?utf-8?B?WWhRenhyODNmQU5UQkE4ek1tTFhlbXVhV3l3NkZDckU5djk4cUZ0OW81Wlc2?=
 =?utf-8?B?eGI1NDhTbE9xb3BYK1RjQ1Q1MVR0b1V5NjdnbGtBU3ExRE4zd3BHZFdTZFg4?=
 =?utf-8?B?anZubE9HbFh0am44ano2emdNY1JxUFRBZ3NpTmVGS1lWNE5zdk5TM3FQOXZ1?=
 =?utf-8?B?V1JBZ0lHSVFCWFE3aDhEd2IyS081cE9wMUlDZ0JRNW50VnFlQnE3bzBQTlA3?=
 =?utf-8?B?eVVjTHBXT2EreHBZb1lTeVZ2bVNVamlyNjN1NFZoS0dkY3VjekxnalJZN3hF?=
 =?utf-8?B?Z0drMDBYQXl2ZWgzR0xWaHJQdFE1c1pvZGo2eEp0MXVuRnRvUURKTE1Sd0RW?=
 =?utf-8?B?WmpJOUtDNHk4RFlYYS9jYm9PNThUR1ZwaDdKcjdVdC96K3dQVDdReU9lZFZt?=
 =?utf-8?B?bzR3K3VFemVVVmlhcXNFSUF4M0drL3A1Tyt4eHROZ2ZwRE9jTU5YVVFLbzlD?=
 =?utf-8?B?cWhJMkJSTDV6ekI3OWhJNlA3Kzg2bUMxVTBDMERpbDlHN1lXcXpzQ1BvTVZW?=
 =?utf-8?B?Z05RQk5vd1h4a1hXUVlZcEJZd0crUytUTXNNUnhQQ1NPVzFyaEpkWDZBd2ta?=
 =?utf-8?B?dkxreFMzLzlzSjJvYzd2NFdIZjBmQmRUVmlpNU5rUDdzcmhPOEZWWXRjRVdR?=
 =?utf-8?B?UVhzMlZBMEdpNm0xd3FmWExkOXRrT3dMTUpNcjRWYy8ra2N5dlJxVERRdjNn?=
 =?utf-8?B?dlpUOFRyZ1V5YXFGZThPMWtpMnM1VGFBZHZGNEJwZ1NMUzk3ZGxldXAzb3Ry?=
 =?utf-8?B?Y0FyK09QejBJUlU4b1ZyZUtBakFlMVR1TXVCTHhSTUhmNVRMaWVDbExHWkkz?=
 =?utf-8?B?cVIxd0RXM3dnN2ZJT0kzU0U4bjE5bzZrbGtkUlhpS0Z1T3lrT2R0b3JLcnAw?=
 =?utf-8?B?R3UvdWRTUmROUTNEeTNxNmswM3NBV2pleTBwYWhuL3NudjlqcHl5Q0Zod0tz?=
 =?utf-8?B?eE5WVUZMYUh6UGZ3MlNCeW9PZHNlVExSS0VvL2hKK0FjVjd5dGV4MFdrTlJr?=
 =?utf-8?B?QzIwUG9SMHJ6Z1dNNjZ1M1BFOXBRc2NubFlaUVMyWlNhelhaVC9nRjVYQWts?=
 =?utf-8?B?d1BsalNleG9IenBFd0M3U3VZQURiWXFzRUtNc00rQ3N1U1VUSjhVMkx3ZEJS?=
 =?utf-8?B?S0NRMWFxbnQvK3BFekdrVjE1TlBNd0hlV2R6eTJHaUJFVTkwUUtlOUJ3N0VE?=
 =?utf-8?B?dk9OQytzZ294aHhuT205WXVYK1RxbVhCVHNteW52TnUzOTBudzQxamlKS3FE?=
 =?utf-8?B?SlRmZlNYUEh2SUNBWEJVSk5jSlJSaHc0cUFBZnQwSUdDYTNMTlJjMGhHUVJi?=
 =?utf-8?B?Q3hKNEJzQStud0JRQmNNWDBkRmdtWWNyZU5vR3M3YmREdC8wUW5Ydm5yelg1?=
 =?utf-8?B?bjhCWHhncGhzWUxsVEZ4SkQrTlNoUngxYTNZVUJRcWtkd3ZuQTR3WTVPVjVM?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <627FF1E919C4244AA31577C4D79EE9B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce60f4fc-753e-40a9-7273-08da6c9d90a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2022 11:22:01.8330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwQddBSrkOI5rP1a2KOPPo8k36HbvQuWI7kR9VrG5hErDX/87/tVQ/pEcfKzapimcNeH1/R1qN1RlvWO1y/iGPQ3LHs6u8d5G0kr2i1gv4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1453
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDcvMjAyMiAxODo1MSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBGcm9tOiBDb25vciBE
b29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiANCj4gSGV5IGFsbCwNCj4gSXQn
cyBteSBmaXJzdCB0aW1lIG1lc3NpbmcgYXJvdW5kIHdpdGggYXJjaC8gY29kZSBhdCBhbGwsIGxl
dCBhbG9uZQ0KPiBtb3JlIHRoYW4gb25lIGFyY2gsIHNvIGZvcmdpdmUgbWUgaWYgSSBoYXZlIHNj
cmV3ZWQgdXAgaG93IHRvIGRvIGENCj4gbWlncmF0aW9uIGxpa2UgdGhpcy4NCj4gDQo+IFRoZSBn
b2FsIGhlcmUgaXMgdGhlIGZpeCB0aGUgaW5jb3JyZWN0bHkgcmVwb3J0ZWQgYXJjaCB0b3BvbG9n
eSBvbg0KPiBSSVNDLVYgd2hpY2ggc2VlbXMgdG8gaGF2ZSBiZWVuIGJyb2tlbiBzaW5jZSBpdCB3
YXMgYWRkZWQuDQo+IGNwdSwgcGFja2FnZSBhbmQgdGhyZWFkIElEcyBhcmUgYWxsIGN1cnJlbnRs
eSByZXBvcnRlZCBhcyAtMSwgc28gdG9vbHMNCj4gbGlrZSBsc3RvcG8gdGhpbmsgc3lzdGVtcyBo
YXZlIG11bHRpcGxlIHRocmVhZHMgb24gdGhlIHNhbWUgY29yZSB3aGVuDQo+IHRoaXMgaXMgbm90
IHRydWU6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9vcGVuLW1waS9od2xvYy9pc3N1ZXMvNTM2DQoN
CkhleSwNCg0KTm90IGdvdCBhbnkgZmVlZGJhY2sgb24gdGhlIHNtcGJvb3QgY2hhbmdlcyBmcm9t
IHRoZSBSSVNDLVYgc2lkZS4NCkkgdGVzdGVkIGl0IG9uIHBvbGFyZmlyZSwgdGhlIGQxICh3aXRo
IGJvdGggU01QICYgIVNNUCBzZXQgaWlyYykNCiYgb24gdGhlIHU1NDAuIEl0IGFsbCBsb29rZWQg
Z29vZCB0byBtZS4NCg0KSSdkIGxpa2UgdG8gaGF2ZSB0aGlzIGZpeGVkIGZvciB2NS4yMCwgYnV0
IHRoZXJlIGlzbid0IHRvbyBtdWNoDQp0aW1lIGxlZnQgYmVmb3JlIHRoZSBtdy4gTm90IHRvbyBz
dXJlIGFib3V0IHRoZSBjcm9zcy10cmVlIGNoYW5nZXMsDQpkb2VzIGl0IG5lZWQgYW4gaW1tdXRh
YmxlIGJyYW5jaCBvciBjb3VsZCBpdCBnbyB0aHJvdWdoIGRyaXZlci1jb3JlPw0KQ2F0YWxpbiBz
dWdnZXN0ZWQgcmVtb3ZpbmcgdGhlIENDIHN0YWJsZSBmcm9tIHBhdGNoIDEvMiAmIGFkZGluZyBp
dA0KYXMgYSBkZXBlbmRlbmN5IGZvciB0aGUgMi8yIHBhdGNoIC0gYnV0IG9idmlvdXNseSB0aGF0
J3MgdXAgdG8gdGhlDQpjb21taXR0ZXIgdG8gc29ydCBvdXQuDQoNCkkgZ3Vlc3Mgc2luY2UgaXQg
aXMgYSBmaXgsIGl0IGNvdWxkIGFsc28gZ28gaW50byByYzE8DQoNClRoYW5rcywNCkNvbm9yLg0K
DQo+IA0KPiBhcm02NCdzIHRvcG9sb2d5IGNvZGUgYmFzaWNhbGx5IGFwcGxpZXMgdG8gUklTQy1W
IHRvbywgc28gaXQgaGFzIGJlZW4NCj4gbWFkZSBnZW5lcmljIGFsb25nIHdpdGggdGhlIHJlbW92
YWwgb2YgTVBJRFIgcmVsYXRlZCBjb2RlLCB3aGljaA0KPiBhcHBlYXJzIHRvIGJlIHJlZHVkYW50
IGNvZGUgc2luY2UgJzMxMDJiYzBlNmFjNyAoImFybTY0OiB0b3BvbG9neTogU3RvcA0KPiB1c2lu
ZyBNUElEUiBmb3IgdG9wb2xvZ3kgaW5mb3JtYXRpb24iKScgcmVwbGFjZWQgdGhlIGNvZGUgdGhh
dCBhY3R1YWxseQ0KPiBpbnRlcmFjdGVkIHdpdGggTVBJRFIgd2l0aCBkZWZhdWx0IHZhbHVlcy4N
Cj4gDQo+IEkgb25seSBidWlsdCB0ZXN0ZWQgZm9yIGFybXssNjR9ICwgc28gaG9wZWZ1bGx5IGl0
IGlzIG5vdCBicm9rZW4gd2hlbg0KPiB1c2VkLiBUZXN0aW5nIG9uIGJvdGggYXJtNjQgJiAhU01Q
IFJJU0MtViB3b3VsZCByZWFsbHkgYmUgYXBwcmVjaWF0ZWQhDQo+IA0KPiBGb3IgVjIsIEkgZHJv
cHBlZCB0aGUgaWRlYSBvZiBkb2luZyBhIFJJU0MtViBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbg0K
PiBmb2xsb3dlZCBieSBhIG1vdmUgdG8gdGhlIGdlbmVyaWMgY29kZSAmIGp1c3Qgd2VudCBmb3Ig
dGhlIG1vcmUgc3RyYWlnaHQNCj4gZm9yd2FyZCBtZXRob2Qgb2YgbW92aW5nIHRvIHRoZSBzaGFy
ZWQgdmVyc2lvbiBmaXJzdC4gSSBhbHNvIGRyb3BwZWQgdGhlDQo+IFJGQy4NCj4gDQo+IFYzIG1v
dmVzIHN0b3JlX2NwdV90b3BvbG9neSgpJ3MgZGVmaW5pdGlvbiBkb3duIGluc2lkZSB0aGUgYXJj
aCBjaGVjaw0KPiBhbG9uZ3NpZGUgdGhlIGluaXQgZnVuY3Rpb24gc28gdGhhdCBib290IG9uIDMy
Yml0IGFybSBpcyBub3QgYnJva2VuLg0KPiANCj4gVjQgaGFzIG1vdmVkIHRoZSBSSVNDLVYgYm9v
dCBoYXJ0J3MgY2FsbCB0byBzdG9yZV9jcHVfdG9wb2xvZ3koKSBsYXRlcg0KPiBpbnRvIHRoZSBi
b290IHByb2Nlc3MgaXQgaXMgbm93IHJpZ2h0IGJlZm9yZSBTTVAgaXMgYnJvdWdodCB1cCAob3Ig
bm90DQo+IGluIHRoZSBjYXNlIG9mICFTTVApLiBUaGlzIHByZXZlbnRzIGNhbGxpbmcgZGV0ZWN0
X2NhY2hlX2F0dHJpYnV0ZXMoKQ0KPiB3aGlsZSB3ZSBjYW5ub3QgYWxsb2NhdGUgbWVtb3J5Lg0K
PiANCj4gVjQgaXMgYWxzbyByZWJhc2VkIG9uIG5leHQtMjAyMjA3MTUgdG8gZ2V0IFN1ZGVlcCdz
IG1vc3QgcmVjZW50DQo+IGFyY2hfdG9wb2xvZ3kgcGF0Y2hzZXQuDQo+IA0KPiBUaGFua3MsDQo+
IENvbm9yDQo+IA0KPiBDb25vciBEb29sZXkgKDIpOg0KPiAgIGFybTY0OiB0b3BvbG9neTogbW92
ZSBzdG9yZV9jcHVfdG9wb2xvZ3koKSB0byBzaGFyZWQgY29kZQ0KPiAgIHJpc2N2OiB0b3BvbG9n
eTogZml4IGRlZmF1bHQgdG9wb2xvZ3kgcmVwb3J0aW5nDQo+IA0KPiAgYXJjaC9hcm02NC9rZXJu
ZWwvdG9wb2xvZ3kuYyB8IDQwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgICB8ICAyICstDQo+ICBhcmNoL3Jpc2N2L2tl
cm5lbC9zbXBib290LmMgIHwgIDMgKystDQo+ICBkcml2ZXJzL2Jhc2UvYXJjaF90b3BvbG9neS5j
IHwgMTkgKysrKysrKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKSwgNDIgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFzZS1jb21taXQ6IDYwMTRjZmE1YmYz
MmNmOGM1YzU4YjNjZmQ1ZWUwZTE1NDJjOGE4MjUNCg==
