Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793DF597016
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiHQNlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHQNli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:41:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4F76440;
        Wed, 17 Aug 2022 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660743695; x=1692279695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=04TzNo12vno3SD99jaln12hJkslWckg1kdUOW0sCkUE=;
  b=qq1yaFY4ON58RS5rHIEirGxjDLhBJTLvCSV9mOHNNdedTcMXXdWYMysF
   nCLfVIA6+Q8TgSAkzLYYn9cXXW0kAvRJNG1O1aNE/qLX7JRLBDsAl9l1/
   dCPuQ4aQBP4lzKJBiZGU083WjKvuNsKGQIhpq40slPcOjP01KWTaykJQ2
   P1tfz7elSkYDLN7O/0FweODa+QgFdGE757dIj1lYQn32y3HgPAAXg61x1
   JOoNLD6Q16JxIKhyqSpdaatlppOGy1Awu/Enba2R91fHsPy48dR7W9v3u
   Sy/sU8K5OTJFJRCoUXKz+QZbK0kzDKVy9jOME07Zqdsz/hLkfVOmZtzMU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="169698696"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Aug 2022 06:41:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 17 Aug 2022 06:41:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 17 Aug 2022 06:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwJEDDt9wPOdYr7jqrnbW1RR5L5X7dWZvc+zyFDO/PVLoWkVyIK8uEOQHRCDEVDnUFo7eQkpJMJJMqv8aTn4UEFMf4RQHm5CqjLIKx4Y+Fnn5ejBtquhYq6Q3570Imt0dj7s7KQEUZ28Zr91hEB240NRD1z4hxmOYOoA24lXsAeQEQRcFJXLCKVbW4VfAoSxrzSNC2yt+VPUWeL14DQF89PMepwHzbInwXiC/dakufTCls+93BCnpslHVrGZoNEWSTVb2pEQJNoKobiQ2oPbnAUjjYKkuhFIdRKWiO2CUuN1nmehyKMiw05H3m3kICjYgPndugjSzBuZ4ScMbBVw8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04TzNo12vno3SD99jaln12hJkslWckg1kdUOW0sCkUE=;
 b=inCl14o4wqocCD48iWuxIR25z1kWiAhwW+owrS1/2v0vxeE/L3nyZLC3oj+OkCMtKBEc2hSbD6q7ER8g9+auhew1PwpZyT3qqVBJB1xTvmXu+fGYDMrgSmHBlS6UdI9NiIO4xQN+o0ilCIZ9eL99XFgWEBV3KCzGy1UQlfmUetImd3Lq2x+PjQEgNwLTWTgSbJ3QCLAgA/vrdJ6VBxTVPMbG68k2/i8r1fSaY0NB4E3cOcuBtwUvfVY2rArmIrMAO45GvmzriOC47KP+cGd9xoMuU51Er2hnrjoQ6LuMh070RAnZYuSu5wDsR5qkxiR9N7pDeveQfW1Fgg91JPJQjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04TzNo12vno3SD99jaln12hJkslWckg1kdUOW0sCkUE=;
 b=ShxXUiSLO9EbX4oWnU+5iTBRrdIxJFR5ZvLyxjnhaRIRpksJHtyv4tdCVR1oA9wpkksmvqyHwKd6IyIqHEyJlZFitQTZFrDCuCk5tTjSdfuKG8Z2JvOUTY3TZnDbLMC7PXzauaLB8pE2r0FRc5ZcMXATshOMUVvEKdrqaXpeVL4=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4368.namprd11.prod.outlook.com (2603:10b6:208:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Wed, 17 Aug
 2022 13:41:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Wed, 17 Aug 2022
 13:41:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <lkp@intel.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <robh+dt@kernel.org>,
        <krzk@kernel.org>
CC:     <kbuild-all@lists.01.org>, <Daire.McNamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v8 3/4] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH v8 3/4] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYsWkBOIqIOJ12yketXMe3xks8Fq2zGICAgAACpYA=
Date:   Wed, 17 Aug 2022 13:41:15 +0000
Message-ID: <9d0c3441-f79e-4e24-74aa-fb6c387c25c5@microchip.com>
References: <20220816120829.719749-4-conor.dooley@microchip.com>
 <202208172150.rEZ2HEYS-lkp@intel.com>
In-Reply-To: <202208172150.rEZ2HEYS-lkp@intel.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd77e50d-a596-4352-43db-08da8056284e
x-ms-traffictypediagnostic: MN2PR11MB4368:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8SgbvhDHdZd/1tsrJhmk+uIn0IHreLSia7STm6D+9GCxMC1cHC+VGGT2ZlQrtIev9Fqzu1+ib7XktNBXPzYUn0xG6z4igtQIYAZ7hUcu+u5dMvgBa72G0vAk4cCFUGBf0ryQrpT4NGGdvrJZm8XPQMOcQhOaiJOxFyH1ifbcN/mqKzyWd70AI+1RzEUoTqSptULCi0oWzmmiXm8jsnkkIzjbDH0Gw3jDEaCIkIR7gBhcU3rkmMKuCnzxj5fQQ1tOJPVMbTywk06onAyG36s8PZZwbe9oftVAosAdafiqle0egeAjuXZbyzWFdnk+9q878EyCB21BaO44YAAXBabiHOwtzK9Xj4kTKXL0xxE1DJqABu8zSB/ysXlpO7a7qUajfhaURJ2J8+Q4ePrtd4+jdILNp3B+QXfrn3sMf6mm9kqxDcauN6L9y3gy34KnnHSOOggqWbOwkMsUWRZI4rviGc7MZSaRAo+km6CzoY22x7RNT78T+QpzN7Iq388O9nCzlvhjAHOkbloW2pHzqh4h+z2VWvJTMXzxJP1Xy34npq89EC31+9GvjHav8HkCNe/7oh2aNNbU5F0Bq6wH4ZVqe8vd7SX+SxNmQyY9Kip6wnd5pIrwKrDG5QS9hU4grDy6a9gsBuHcPrBn9mWO1vHRmSUzm5KRcAx3FeFZn0iz3Te0IQSeHLaihQVtUPdGXFFAOzaZwljSEag3REqiVXYMOAXqGmeCmwJ2RWn8lYMjKkb9g6nSUw9CuBUfFDAfFdhEpFx7kQPLVGmIDN40fMMSz0/xrMR7PmlGDJgYaDeFZ3Ma4daE9hJFLO0DPcSnz9bQiJa9aUf6R1Mv0ljTIVKmfw2AmSXYJRFlGcMVnyCoaS35AlNCRHB4wDF45cM2s0EKMy6q417IU8+aw9VdEAsofB248WUdD0am3PmkiRC3QcSFaA6KxVDQZQfuUBEsu9O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(396003)(39860400002)(110136005)(316002)(122000001)(36756003)(38100700002)(38070700005)(76116006)(66476007)(31686004)(4326008)(91956017)(66556008)(66946007)(66446008)(64756008)(8676002)(53546011)(71200400001)(5660300002)(2906002)(26005)(86362001)(966005)(186003)(6512007)(41300700001)(83380400001)(54906003)(31696002)(6486002)(7416002)(8936002)(478600001)(6506007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2owbzlaMFlqNmZ0TE5SejlNL3ZhTXc0M2JNcXNKV0hQYXhPSENKSWdQa0FL?=
 =?utf-8?B?UDlzaFRyTHcrZE1VS01xUGlWcXhyMVZrMGpUcnpvV0dwc3U4NmI2UXR1aDJW?=
 =?utf-8?B?QW5VazRuVkVQMFBhd3FoMzVIRmFBSmFXSjNleXpaVXF1MEhWbkZaQnU2dVNz?=
 =?utf-8?B?RXpnY2xrbDVNK29CMndhSGdDRUZzeS9UT1lrdkt3U1IwWTdqSElRODkveHQr?=
 =?utf-8?B?aFpieHg3Ujk3Y1luUERoVDlWSjg4ZWZZRXZJbTFUNGQzMU5LaEdna0E2YlZk?=
 =?utf-8?B?bEVJcVdyd1l6emF2ZTlRVHNTd09jWjk0RkM2aHo5SklVcnQzWWlJWW5rcUw2?=
 =?utf-8?B?V0p4ZXRQWkVpeFlsOFR0bXUwS1NSY3RyZDBlTU9tMzY0WTlIMWNiVko4VTFx?=
 =?utf-8?B?QUUvOXhDV2hPNjg2ZDVKV0xFUHpHbE9DUzYrT05URVlVcEJPa09xM3hHUVk0?=
 =?utf-8?B?TUx5TnVCNWZORzgzbTkvd0NsUUdOYjU0Zk5QZTV0dkJoZ1pUSjBRQ2NiVm1R?=
 =?utf-8?B?MWcxYlphRXJDU1dLZFhLWHNDcGlaWDhqZXRUMXhIRVo0Qng2amUwc3RWNVdV?=
 =?utf-8?B?NngvbE1ycjdGTnRieDJ5ZStWOTFON1k0Q2UvUG9SbC94azdNOTdrd3FZUFVZ?=
 =?utf-8?B?cFR1U3Y2VUwybXdUOFhrYXhzYXh5clhxUVNsajFCNXlqaDF5SnJXVEYvTGU2?=
 =?utf-8?B?RXlZR1VzT1UzcDNlczZQY3JvV2IyVVBGWjhNcDh3UHRDREtEdis3RFBXcmdN?=
 =?utf-8?B?Yk9LV01TK3FOM0xtM0lLWFlTL0djMWxkVE0xVU96eVFiQ1RDaSt1MkpGdThq?=
 =?utf-8?B?TVBqT0lXdXlIcGo1OHdRRU5tMVU0ZjZNUThNOWg4eDVHWjJXWDFBU1g2S3Nv?=
 =?utf-8?B?bHdCMFNKaW9LNTVtUzVYUFlVTFg3Y0tUQUZMN1kwcVFpRFNlSjczQm5pY3VV?=
 =?utf-8?B?eG5PVXgzY2ZkSjRkMjI3czByWWtyTU5kTXRqUTFYcEw5bDFGb0FPM3dCZ09P?=
 =?utf-8?B?Y2x5cUFjVnNEekVUR1JKRUIyV21najlXVm00TlVVWTIwOU5TeWhQeGNnRDI5?=
 =?utf-8?B?Nm5xdmVCczYrZzdzZ1p2bFgzUm5rS29seURvVWg1N2ZYUzlxRjR0VHBWL05V?=
 =?utf-8?B?WjZpSEtkNjZkWUZDS1Rrem5LM2pMTEJyNklpbXI5UnZTMTg4T0Jyb3NhdkVo?=
 =?utf-8?B?MzA3RUFnU0xGc1ZsaDkyMnVOclFUS09xd1NBYXR0SERDUjJ4MUNNL0s4cUFa?=
 =?utf-8?B?MXVqdThBQ1dhMDUxbDFPZ0FXL3dqMDcya1lXUEtzL25xZHMxY1luWmdrblpa?=
 =?utf-8?B?QThBNHFZNlcyZEVoYTR5UHlQZUZMbG9yOTRaQWNaN0k0WHl2QlZ6RE1rN2pM?=
 =?utf-8?B?S0ZmN0xUdTJPcVlhMVJYRCs0eWZEb25IalYvUUoxZ0NVVUJEcjdGNlZaVGox?=
 =?utf-8?B?QzlIUW5HcGpsRnNKZitheWFxMXNzQVloWWZxZEk1TVdDcEU3YVpYbUd4cVVn?=
 =?utf-8?B?WktQM29qZXZjV0dxSnRvOXh5VmtxcFRtc0NDbXBuN2NtUXZQUjl1VnBncENi?=
 =?utf-8?B?RVhDalFnZFJTOGFTa1BaMmd5emlQMHRlZWo5MGVHeFNETlAzcDd4K1A3eks0?=
 =?utf-8?B?NSs5cEcxbEdxSEltQTlYK29zSVJ3c0VCUU1Ga05CLzZlTUFGdGY5eXpXZ0NW?=
 =?utf-8?B?Q3l1Z0xFRzhRV0ZrckEvVXBSczRlbDVJVnNzMjBYdVpFWk94bnE1SDkwekFo?=
 =?utf-8?B?V0htRko3L01MdkR0SHlmajRtTy9SeWJXeUVNZmphNFdSWnV6TFJHSUVSZWw5?=
 =?utf-8?B?MEYrNW5rQk0ySXFSMS9LZmNuQUllMmNROUQ2MVpxWDM1NllvWVY2b3NOUE42?=
 =?utf-8?B?YmlXMjhTbmg4TlRyUHE3ZzY0Q3ZmRGhCQjFCdi9KaFFWU3crOU9ldHlwVWtn?=
 =?utf-8?B?a2VLcHh1eG5WZ21hRGZKTnhNUkZxNXpkaFBnQ2dNa05BWmxyeWhGdkNZWlcr?=
 =?utf-8?B?QkVPODdBdEg5eDVhQzVRa1pBL2QxMjFXL2N2d0R3VU1VQzdnQ241bnpSNUpm?=
 =?utf-8?B?Q2EzMGpwOFhlL3dmVkRSL1NIN081R3E1aU9CZHc4L3NBNGF4OGVQY2NJSVh4?=
 =?utf-8?Q?nyjtueHWjFBN7nWyvOWagIw9t?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70B43A1FA43A1344BFF81A1E223CA9BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd77e50d-a596-4352-43db-08da8056284e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 13:41:15.7781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJaBVqnnxn1cH9nB6f53jEV4WJ649blXJbA4XO+gUy7MoXpYzzU4+jvFp/yEbSqpKthVtXQL1tYayd5kt0hoYqqHFsAabxmf8ns7a8XJXEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4368
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDgvMjAyMiAxNDozMSwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ29ub3IsDQo+IA0KPiBJIGxvdmUg
eW91ciBwYXRjaCEgWWV0IHNvbWV0aGluZyB0byBpbXByb3ZlOg0KPiANCj4gW2F1dG8gYnVpbGQg
dGVzdCBFUlJPUiBvbiBsaW51cy9tYXN0ZXJdDQo+IFthbHNvIGJ1aWxkIHRlc3QgRVJST1Igb24g
djYuMC1yYzFdDQo+IFtjYW5ub3QgYXBwbHkgdG8gdGhpZXJyeS1yZWRpbmctcHdtL2Zvci1uZXh0
IHJvYmgvZm9yLW5leHRdDQo+IFtJZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdyb25n
IGdpdCB0cmVlLCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuDQo+IEFuZCB3aGVuIHN1Ym1pdHRpbmcg
cGF0Y2gsIHdlIHN1Z2dlc3QgdG8gdXNlICctLWJhc2UnIGFzIGRvY3VtZW50ZWQgaW4NCj4gaHR0
cHM6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1mb3JtYXQtcGF0Y2gjX2Jhc2VfdHJlZV9pbmZvcm1h
dGlvbl0NCj4gDQo+IHVybDogICAgaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGlu
dXgvY29tbWl0cy9Db25vci1Eb29sZXkvTWljcm9jaGlwLXNvZnQtaXAtY29yZVBXTS1kcml2ZXIv
MjAyMjA4MTYtMjAxNzQ0DQo+IGJhc2U6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IDU2ODAzNWIwMWNmYjEwN2FmOGQy
ZTRiZDJmYjlhZWEyMmNmNWI4NjgNCj4gY29uZmlnOiBtaXBzLWFsbHllc2NvbmZpZyAoaHR0cHM6
Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjIwODE3LzIwMjIwODE3MjE1MC5y
RVoySEVZUy1sa3BAaW50ZWwuY29tL2NvbmZpZykNCj4gY29tcGlsZXI6IG1pcHMtbGludXgtZ2Nj
IChHQ0MpIDEyLjEuMA0KPiByZXByb2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOg0KPiAgICAg
ICAgICB3Z2V0IGh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9pbnRlbC9sa3AtdGVz
dHMvbWFzdGVyL3NiaW4vbWFrZS5jcm9zcyAtTyB+L2Jpbi9tYWtlLmNyb3NzDQo+ICAgICAgICAg
IGNobW9kICt4IH4vYmluL21ha2UuY3Jvc3MNCj4gICAgICAgICAgIyBodHRwczovL2dpdGh1Yi5j
b20vaW50ZWwtbGFiLWxrcC9saW51eC9jb21taXQvOTYxZTM3NWEyNDUxODZjOGVjMmM0MGU0OGU1
YmFmNDBhMTEyZjE0YQ0KPiAgICAgICAgICBnaXQgcmVtb3RlIGFkZCBsaW51eC1yZXZpZXcgaHR0
cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgNCj4gICAgICAgICAgZ2l0IGZldGNo
IC0tbm8tdGFncyBsaW51eC1yZXZpZXcgQ29ub3ItRG9vbGV5L01pY3JvY2hpcC1zb2Z0LWlwLWNv
cmVQV00tZHJpdmVyLzIwMjIwODE2LTIwMTc0NA0KPiAgICAgICAgICBnaXQgY2hlY2tvdXQgOTYx
ZTM3NWEyNDUxODZjOGVjMmM0MGU0OGU1YmFmNDBhMTEyZjE0YQ0KPiAgICAgICAgICAjIHNhdmUg
dGhlIGNvbmZpZyBmaWxlDQo+ICAgICAgICAgIG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcg
YnVpbGRfZGlyLy5jb25maWcNCj4gICAgICAgICAgQ09NUElMRVJfSU5TVEFMTF9QQVRIPSRIT01F
LzBkYXkgQ09NUElMRVI9Z2NjLTEyLjEuMCBtYWtlLmNyb3NzIFc9MSBPPWJ1aWxkX2RpciBBUkNI
PW1pcHMgU0hFTEw9L2Jpbi9iYXNoDQo+IA0KPiBJZiB5b3UgZml4IHRoZSBpc3N1ZSwga2luZGx5
IGFkZCBmb2xsb3dpbmcgdGFnIHdoZXJlIGFwcGxpY2FibGUNCj4gUmVwb3J0ZWQtYnk6IGtlcm5l
bCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiANCj4gQWxsIGVycm9ycyAobmV3IG9uZXMg
cHJlZml4ZWQgYnkgPj4pOg0KPiANCj4gICAgIGFyY2gvbWlwcy9rZXJuZWwvaGVhZC5vOiBpbiBm
dW5jdGlvbiBga2VybmVsX2VudHJ5JzoNCj4gICAgICgucmVmLnRleHQrMHhhYyk6IHJlbG9jYXRp
b24gdHJ1bmNhdGVkIHRvIGZpdDogUl9NSVBTXzI2IGFnYWluc3QgYHN0YXJ0X2tlcm5lbCcNCj4g
ICAgIGluaXQvbWFpbi5vOiBpbiBmdW5jdGlvbiBgc2V0X3Jlc2V0X2RldmljZXMnOg0KPiAgICAg
bWFpbi5jOiguaW5pdC50ZXh0KzB4MjApOiByZWxvY2F0aW9uIHRydW5jYXRlZCB0byBmaXQ6IFJf
TUlQU18yNiBhZ2FpbnN0IGBfbWNvdW50Jw0KPiAgICAgbWFpbi5jOiguaW5pdC50ZXh0KzB4MzAp
OiByZWxvY2F0aW9uIHRydW5jYXRlZCB0byBmaXQ6IFJfTUlQU18yNiBhZ2FpbnN0IGBfX3Nhbml0
aXplcl9jb3ZfdHJhY2VfcGMnDQo+ICAgICBpbml0L21haW4ubzogaW4gZnVuY3Rpb24gYGRlYnVn
X2tlcm5lbCc6DQo+ICAgICBtYWluLmM6KC5pbml0LnRleHQrMHhhNCk6IHJlbG9jYXRpb24gdHJ1
bmNhdGVkIHRvIGZpdDogUl9NSVBTXzI2IGFnYWluc3QgYF9tY291bnQnDQo+ICAgICBtYWluLmM6
KC5pbml0LnRleHQrMHhiNCk6IHJlbG9jYXRpb24gdHJ1bmNhdGVkIHRvIGZpdDogUl9NSVBTXzI2
IGFnYWluc3QgYF9fc2FuaXRpemVyX2Nvdl90cmFjZV9wYycNCj4gICAgIGluaXQvbWFpbi5vOiBp
biBmdW5jdGlvbiBgcXVpZXRfa2VybmVsJzoNCj4gICAgIG1haW4uYzooLmluaXQudGV4dCsweDEy
OCk6IHJlbG9jYXRpb24gdHJ1bmNhdGVkIHRvIGZpdDogUl9NSVBTXzI2IGFnYWluc3QgYF9tY291
bnQnDQo+ICAgICBtYWluLmM6KC5pbml0LnRleHQrMHgxMzgpOiByZWxvY2F0aW9uIHRydW5jYXRl
ZCB0byBmaXQ6IFJfTUlQU18yNiBhZ2FpbnN0IGBfX3Nhbml0aXplcl9jb3ZfdHJhY2VfcGMnDQo+
ICAgICBpbml0L21haW4ubzogaW4gZnVuY3Rpb24gYHdhcm5fYm9vdGNvbmZpZyc6DQo+ICAgICBt
YWluLmM6KC5pbml0LnRleHQrMHgxYWMpOiByZWxvY2F0aW9uIHRydW5jYXRlZCB0byBmaXQ6IFJf
TUlQU18yNiBhZ2FpbnN0IGBfbWNvdW50Jw0KPiAgICAgbWFpbi5jOiguaW5pdC50ZXh0KzB4MWJj
KTogcmVsb2NhdGlvbiB0cnVuY2F0ZWQgdG8gZml0OiBSX01JUFNfMjYgYWdhaW5zdCBgX19zYW5p
dGl6ZXJfY292X3RyYWNlX3BjJw0KPiAgICAgaW5pdC9tYWluLm86IGluIGZ1bmN0aW9uIGBpbml0
X3NldHVwJzoNCj4gICAgIG1haW4uYzooLmluaXQudGV4dCsweDIzNCk6IHJlbG9jYXRpb24gdHJ1
bmNhdGVkIHRvIGZpdDogUl9NSVBTXzI2IGFnYWluc3QgYF9tY291bnQnDQo+ICAgICBtYWluLmM6
KC5pbml0LnRleHQrMHgyNTQpOiBhZGRpdGlvbmFsIHJlbG9jYXRpb24gb3ZlcmZsb3dzIG9taXR0
ZWQgZnJvbSB0aGUgb3V0cHV0DQo+ICAgICBtaXBzLWxpbnV4LWxkOiBkcml2ZXJzL3B3bS9wd20t
bWljcm9jaGlwLWNvcmUubzogaW4gZnVuY3Rpb24gYG1jaHBfY29yZV9wd21fZW5hYmxlJzoNCj4+
PiBwd20tbWljcm9jaGlwLWNvcmUuYzooLnRleHQubWNocF9jb3JlX3B3bV9lbmFibGUrMHgxY2Mp
OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBfX3VkaXZkaTMnDQoNCkFoIGdvZCwgbm90IHRoaXMg
YWdhaW4uLi4NCkkgYXNzdW1lIGl0J3MgInNsZWVwX3JhbmdlKHBlcmlvZCAvIDEwMDAsIHBlcmlv
ZCAvIDEwMDAgKiAyKTsiDQoNCkknbGwgdGFrZSBhIGxvb2sgJiBzZW5kIHY5IGxhdGVyIGluIHRo
ZSB3ZWVrLg0KDQpUaGFua3MsDQpDb25vci4NCg0K
