Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C355369E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350414AbiFUPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238783AbiFUPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:48:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E6D64F6;
        Tue, 21 Jun 2022 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655826490; x=1687362490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rgdf0wyxeKArincuG9x9NhnO1ktbI7lwEq8A222Mpdc=;
  b=bIBHpGnjNkcRAYcoftXDAzoYcfilH8gSi2zM+b0l8oPz/Tymt8Li0J5N
   bsPJvzO50+KXC+FLiAw+RU+geXZJKQ0moeWZlEaaIst59TLLubwy4dQnc
   OGhHx4fxH9ENFwPGcXpXe4rA2gYUo9uMhO1Gpqf3T9FAwWrvGmUmZCKTq
   khnK7Y6H6ExmIjzWFKEPOOPBfa1SdX2lomMuLH73GKmtwzeljmuH6Bw6b
   7Wz4s5HnWQLVWxIXiJV505JxH5kXD0NllulI8xxplahgaO73dnpnrwm1A
   LjQwQLmakYxztajp4XTGO7vKU8p6E30o4TexxPzHEHjYtNhkpvDndHGy/
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="164401311"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jun 2022 08:48:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 21 Jun 2022 08:48:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 21 Jun 2022 08:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T10MzXfmg6xyYbPloKYeeGfcsa3wV6CkV5P9vmYuVH60ugNlQWrbMeKJ2sTChLNaZz0g/xG89o+dFDbzpDGFGqE3pYqgJCHik562KfT5kBBEHevRyUUddKmlqUnQUy5CIUct33XeylS2oVc4/O/fn2zz22UKVayQfx1OzvJmj7P6bU+7Amq34OyeRvVSOAscmkMfRwta30oLXeZ09E/uVeJjQWc+p+TIm70iFLgxYAXRu1WbzC5yMkLEtqGqisX9HzOUedeZkH24EFYylpOXU807LEAiuCfq3mlC2UF796/oJD5hPpWP99fE91Q6YnWafjBAVO0cE7XTBd42l3zS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rgdf0wyxeKArincuG9x9NhnO1ktbI7lwEq8A222Mpdc=;
 b=kasP9GsjkdqA9zuCjc5rZzYJ7na/W82yfGKSVai5SaMFdFHM9cl4qYPwH9in+B/FDLjiJQFLOWtQiL+hSfUeKuVysJH/CRoxxjeTLAfuKx14bfGXI/8R3QJ9+rTMWDoCBVD6lALb6HD/A21NbG9lOpMAESg6Is9glsnEoYXvGWDX6xayFVP9CIOI+NlmlpiXTuPZfuY+CKqkDnspA4/6c1GQ1bN/sXVRj22V3iITIYkz6tDfFyVEN6RZ1FqsmUZTe9dFxv9Q/qZWzBPKqj4ZnncCzqx5UV8rTd67EjBWq/yDAkK8bGvPpPc10zDqzokzmhhEPpafLnDMZ/8lB6PnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rgdf0wyxeKArincuG9x9NhnO1ktbI7lwEq8A222Mpdc=;
 b=GNq6+KE9lGFyAGes2p47uhNHqTfE4RL2ohT7nqksGYGLD38T83li2NqoxP6aOBRSBQPhFd52BXAXtQgBaOzeoxcLZ9OMB0JzIS7xjXaQVKev0kL85K4tCYxODpzIHjwQsdfq11Ps4wCGAcLNejNb4eVtMUr432AcidUCuCjn4zQ=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB2016.namprd11.prod.outlook.com (2603:10b6:300:26::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 15:48:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 15:48:04 +0000
From:   <Conor.Dooley@microchip.com>
To:     <gregkh@linuxfoundation.org>, <Conor.Dooley@microchip.com>
CC:     <b-liu@ti.com>, <Daire.McNamara@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <ben.dooks@codethink.co.uk>,
        <heinrich.schuchardt@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Topic: [PATCH v2 0/2] Add support for PolarFire SoC's musb controller
Thread-Index: AQHYfxuMNjzv9qrP8E6NLA6/7ruhLa1Z+lWAgAALTQCAAAbWAIAAAeWA
Date:   Tue, 21 Jun 2022 15:48:03 +0000
Message-ID: <eb87a311-0a06-8a96-d8cc-ea0bd08efeeb@microchip.com>
References: <20220613114642.1615292-1-conor.dooley@microchip.com>
 <YrHXZYe4e4vlCHh3@kroah.com>
 <6c9001fa-5315-c9f4-b7b9-05248635750d@microchip.com>
 <YrHmnND30o1Rjmcp@kroah.com>
In-Reply-To: <YrHmnND30o1Rjmcp@kroah.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a662602-3c7e-4c57-9bef-08da539d6d9d
x-ms-traffictypediagnostic: MWHPR11MB2016:EE_
x-microsoft-antispam-prvs: <MWHPR11MB2016EFED9265BDB82D2AAC6398B39@MWHPR11MB2016.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wn0OZ+G3ji+dSQPiTNZOr6MF5r6yD03syy4vsKyO01/D43cA7sTr33r59YMDJuoR3fvMYXBeBksd35Z5vkTa9O55+2vWixhh078Juz2Qfxynon5MmGnnisw7aJgU9jDtc6+f8JkQ4Vfnja8MRO3LIdJ0sSIjqMuCty8HgvumpuA96DnCFZdkulMQVK1r7cVZlBgvLi+/dq8GeEiM7OC3BQCGwbSAx5yFW9sT6imQXP+4ocRvkI69zxDKZ5LnX6hi34yTZ6zEY3/WsfngCZbQS+L51CSU/pH+BpgHlIKpQy66MwkscothrIn+sQUNbXz6k+BT+J2mQUUyUpCHbx6n4iOzV2YKE0zIM9XHBR8RnPGfEEyjzjdA1l4mFjoV1QwVo8Ab2KKrSM+IFnzQ3DJaoUnLa5WVq17imOI+MyQXF+ehnqLWBL9jTZXWYbhtkNBjPY38IlFOvwqcaDH44b/oXCwOXTxS7rA942gKF47CQoGEkJaCbebAplR17Q91ycIQ46KgJgHwITredspEXvL0PlRSl8XwB4W5Ltb//khGslhyKuu53FXbMASOtQACqhJpakcJlIindH00bC3D0lX99v9D6DWkTcXejGNq2vKtNyb+as14qY8AY3spufwpkp6nd7EcSoFLgxP307Nn3p6s80uiVtgPG7azyT/Dc0owq5phoVkKXXMgXX03UI9VfBw+GQrfAb65VZ71KNPbg/qnzXq1dND7spRrAz+bR51q4P7AA13kxp1m1xRPy8PS/oZb/OMjxnrZKUaqpPUiJvGjfpnKZQExLI8LUmNp3hreULjUpzj+WUvhY5wMsZsVKV5vhRkCjOsWIYqkzauAn2FZZuExmSxgaHADNzgihNMoojc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(366004)(396003)(136003)(376002)(8936002)(478600001)(83380400001)(5660300002)(66476007)(66946007)(84970400001)(6486002)(38070700005)(53546011)(41300700001)(186003)(71200400001)(6512007)(2616005)(31696002)(316002)(122000001)(31686004)(107886003)(54906003)(86362001)(91956017)(2906002)(8676002)(66556008)(76116006)(66446008)(38100700002)(36756003)(26005)(6506007)(110136005)(4326008)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0RCb3ZxM3o0bkJ3dEV1c2xwM2xyVVY2WmVqZEdsMG1nMGc5d2kvb01SSFNQ?=
 =?utf-8?B?Tk1Ed0R6TURWSStXK0pwTnpwRVhqVDB4RlBaaE5icVhmTFN3SUdIL2JFVGlB?=
 =?utf-8?B?bm1pcTNNa2xxMExDZ05IQ01UMnh5QjBvQXMreE9oakR5SEFMa05zMHFLNHBa?=
 =?utf-8?B?cm1sSnBKWXRZUHRWWFM5UFZBMjhDTGlubE8vU0preEpCckFLMGg5d0tFWTFG?=
 =?utf-8?B?R0FUY2pja1k1Q0RuWE53RXh0NkpYRFNUVW9IMkoyWWthUXBLdUFlYTd4M1lK?=
 =?utf-8?B?TXlYQzNrUkdKaklPTTdTNTNrZzg0eGZLTHhZSnBkcWU5UVZIWmZSQk93Rll3?=
 =?utf-8?B?RUtoVU5XYmpOWHF3Ly9yY3dMMlV4VTFNZnlHVjF2ZkxwL3NVSk1CWCtCcXds?=
 =?utf-8?B?elcvRHFJTk9NOFlOSEY4K0hzQTN1Q2s0VkU0eUlGaGl5dTI5Tkt0RlhsVkdS?=
 =?utf-8?B?ajBIMkcvTC9yRUJFcHlKcWNtR1JHV2RZa2taWTJNKzQ5NlRCY085VE9jUklx?=
 =?utf-8?B?S0FWdk1UZFBMYzYxWDRoTytsMlAvbmhNY3RjNzRmTHdGVmpYVGtjZERqaWQr?=
 =?utf-8?B?OUR2MWpSaDFmQ1pqQXRDU1MyMHpZNFNzQ2JCREE1RlYwMVZBQUtSQ2F4amk3?=
 =?utf-8?B?bk92ZjRVTUZlVVE0UVJvWWQzN1I0ZUhIYTlNcWU5QklsNkFiZlR0T1FQVkVV?=
 =?utf-8?B?M1RsZ0xCbjI5TXBMSUF1ejJaQnFtd3dGdU80ckwyQWFFQTRiUG9rNEVKYVpw?=
 =?utf-8?B?Z0VpUlNob0ljVCthbHZDTmVOU2lCRlNhVDNuMEFZT0NNc0xLaCtWWlBsVGN4?=
 =?utf-8?B?UzJPZTFtRG4wWGNjMEkxUnRCMElYem9RTDd1V1lqUlB6UDFDYWdBKy9HY05C?=
 =?utf-8?B?Z1BISHQrY0pQaW0xVEg3Qk8rSWFxdU1wcDA3NXJIVFhpTXRBb1l1bnRSb1BP?=
 =?utf-8?B?UXJCUkVxS3FwbWlFT1RXOWM5K05BSVRlQUQ4N2svQXJ1TUlJbjNnN2wyQjk3?=
 =?utf-8?B?M3VDQitEeFhLcnFWb1NsWlZnazNWeXJMQlFVdk15WE1Lbis5UE5LVmVVY2pz?=
 =?utf-8?B?Y0pDMFlIUVJmMlJFTXlvWlNiMmk1N0RnbGpOT2xqY2xVTExIL1J3ZFlyLy9T?=
 =?utf-8?B?UjdJbWpCWTI4OXU1b0ZpQnFMMzhlRVR3OVpMMEpERnVYeVJ4UGVISUEvZkdF?=
 =?utf-8?B?eGFvZVE4M2ovQnBISzZIZHg5MmIrcytJckVUSWkvNXdrR3lneGF2Z3F1eWs4?=
 =?utf-8?B?YWxlR0trVXFtcDYvNG1QT2hZakwveU9IU0x6ME1wbmwzQkRnV2Y1djlNa2Rk?=
 =?utf-8?B?b0cxYWMrTFJXRXhtaStUZThPWkNwdzM3VXNKMmlhOGNuMUREdUVKQThMK1M1?=
 =?utf-8?B?ZnpGVDFVVkUvV1RoNUd0MHpBanhMS3RSZ3pkd2FVT2tJd1l1ZjllRkhpU3hC?=
 =?utf-8?B?dXlXckxNaTk0SGtxWUwvdk1seVR6YUczM253bW5TWnVxSk8rMmNxdUozekpx?=
 =?utf-8?B?QzV0NktFa0xiWDlUNmgyUngrWnE4UUt2RVpwR1NRckhIYTgvM090bEJFaUcy?=
 =?utf-8?B?ejIxN1RiQWpNRUhoQTFqa3F4QlV4aXVoako4aHZ5b1BqTUtDTFlSSTFMcUtF?=
 =?utf-8?B?NU5zWXJCd0hsN2I2dXdQRFBDK0FRZnFRWXR2NHlLSWNsczdFbzRWajFqcXBS?=
 =?utf-8?B?eEprWTZvYklldExUeHZpWDA2bTFxS1pwdkdMQWFVUjdWZTFKNTk3NmJmY2Zv?=
 =?utf-8?B?WmxIUUs3NEhDUXFFNzNYVnRmMzQvKzI3ckZGYXcxaE13UThjTGZGYllweWUv?=
 =?utf-8?B?Tm1PVTBBUC90d0FHZDI3ZlArRnl3QnJUbWpzOEh6dnd2UjlrTCtXb1VLeHFX?=
 =?utf-8?B?RFNWK2M5Z0JqTWg0Z1ZkY3hHZ0xUUEFrUTBFVnFPTUhNZEgya1IxWitOY3No?=
 =?utf-8?B?bWRaNTNVRjBuWitHdVRiMFVPbHJ3WHNXSnp6a3BQVUhqWEI5QnF1RkIrK0Fr?=
 =?utf-8?B?M21wdzhYOGhCQ0RqL3VJZ0plc242TCtKeXhvSmZaRjgvWm9NZEo4S3d1bUdY?=
 =?utf-8?B?aGdOeEh0ek5FZHpCSFN4eTQxTzE4VzNZVTBDZnBBTVVNRm5xSXViQldWNTJk?=
 =?utf-8?B?Q3g5N01seENneEtXaTdpQkNjd0pjbFJOczVjTkkxNFczY0NtWW5ldFRyOHZO?=
 =?utf-8?B?b3NWcmcweXpObWV5L0F4dXF1MXZsbEZ3Y3NZVVBielpTMlYzdzNGZFA5alJp?=
 =?utf-8?B?NFN0ZkJ2cU5xdXEzcEcxU1NUNmN3bVFJdUVsVEZKcDlvRTFCUjIyR2NIT0FJ?=
 =?utf-8?B?TUlaRlBOL2xkLzNtQ2NNV1pYZEZTdEZmOVNDSTViYWlOSCtSWm10TldQVVR2?=
 =?utf-8?Q?yl4HNXjao3WqGrn8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <164CAA8EBDE9EA4D936391F22A16FAE8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a662602-3c7e-4c57-9bef-08da539d6d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 15:48:03.9894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYHEOn4dsPZPlqkUlHyD3CMF4ifmv4Fs1h9XGGBMe8aoAfvLyfXuDnGdF7l86M1Atys+DEaC3Z1TQnHeKds3MAU5nMGKGi6RL/GeCwwC5X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2016
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIxLzA2LzIwMjIgMTY6NDEsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDIx
LCAyMDIyIGF0IDAzOjE2OjQ5UE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4NCj4+DQo+PiBPbiAyMS8wNi8yMDIyIDE1OjM2LCBHcmVnIEtyb2FoLUhhcnRtYW4g
d3JvdGU6DQo+Pj4gT24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMTI6NDY6NDFQTSArMDEwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPj4+PiBIZXkgQmluLCBHcmVnLA0KPj4+PiBTaG9ydCBzZXJpZXMg
aGVyZSBhZGRpbmcgc3VwcG9ydCBmb3IgVVNCIG9uIE1pY3JvY2hpcCBQb2xhckZpcmUgU29DIEZQ
R0FzLg0KPj4+PiBUaGUga2NvbmZpZyBkZXBlbmRlbmN5IGZvciBJTlZFTlRSQV9ETUEgaGFzIGJl
Y29tZSBhIGJpdCBvZiBhIG1vdXRoZnVsLA0KPj4+PiBpcyB0aGVyZSBhIGJldHRlciB3YXkgb2Yg
ZGVhbGluZyB3aXRoIHRoYXQ/DQo+Pj4+IFRoYW5rcywNCj4+Pj4gQ29ub3IuDQo+Pj4+DQo+Pj4+
IENoYW5nZXMgc2luY2UgdjE6DQo+Pj4+IC0gRHJvcCB1bm5lZWRlZCByZXNvdXJjZSBjb3B5aW5n
IGFzIHBlciBSb2IncyBjaGFuZ2VzIHRvIHRoZSBvdGhlciBkcml2ZXJzDQo+Pj4+IC0gRHJvcCB0
aGUgZHRzIHBhdGNoDQo+Pj4+DQo+Pj4+IENvbm9yIERvb2xleSAoMik6DQo+Pj4+ICAgdXNiOiBt
dXNiOiBBZGQgc3VwcG9ydCBmb3IgUG9sYXJGaXJlIFNvQydzIG11c2IgY29udHJvbGxlcg0KPj4+
PiAgIE1BSU5UQUlORVJTOiBhZGQgbXVzYiB0byBQb2xhckZpcmUgU29DIGVudHJ5DQo+Pj4+DQo+
Pj4+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgIHwgICAxICsNCj4+Pj4gIGRyaXZlcnMvdXNi
L211c2IvS2NvbmZpZyAgfCAgMTMgKy0NCj4+Pj4gIGRyaXZlcnMvdXNiL211c2IvTWFrZWZpbGUg
fCAgIDEgKw0KPj4+PiAgZHJpdmVycy91c2IvbXVzYi9tcGZzLmMgICB8IDI2NSArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgNCBmaWxlcyBjaGFuZ2VkLCAyNzkg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvdXNiL211c2IvbXBmcy5jDQo+Pj4+DQo+Pj4+DQo+Pj4+IGJhc2UtY29tbWl0OiBmMjkw
NmFhODYzMzgxYWZiMDAxNWE5ZWI3ZmVmYWQ4ODVkNGU1YTU2DQo+Pj4+IC0tIA0KPj4+PiAyLjM2
LjENCj4+Pj4NCj4+Pg0KPj4+IEFueSBjaGFuY2UgeW91IGNhbiBnZXQgeW91ciBjb21wYW55IHRv
IGZpeCB1cCB0aGVpciBlbWFpbCBzZXR0aW5nczoNCj4+Pg0KPj4+IEdyYWJiaW5nIHRocmVhZCBm
cm9tIGxvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MTMxMTQ2NDIuMTYxNTI5Mi0xLWNvbm9yLmRv
b2xleSU0MG1pY3JvY2hpcC5jb20vdC5tYm94Lmd6DQo+Pj4gQW5hbHl6aW5nIDQgbWVzc2FnZXMg
aW4gdGhlIHRocmVhZA0KPj4+IENoZWNraW5nIGF0dGVzdGF0aW9uIG9uIGFsbCBtZXNzYWdlcywg
bWF5IHRha2UgYSBtb21lbnQuLi4NCj4+PiAtLS0NCj4+PiAgIOKclyBbUEFUQ0ggdjIgMS8yXSB1
c2I6IG11c2I6IEFkZCBzdXBwb3J0IGZvciBQb2xhckZpcmUgU29DJ3MgbXVzYiBjb250cm9sbGVy
DQo+Pj4gICDinJcgW1BBVENIIHYyIDIvMl0gTUFJTlRBSU5FUlM6IGFkZCBtdXNiIHRvIFBvbGFy
RmlyZSBTb0MgZW50cnkNCj4+PiAgIC0tLQ0KPj4+ICAg4pyXIEJBRFNJRzogREtJTS9taWNyb2No
aXAuY29tDQo+Pj4gLS0tDQo+Pj4gVG90YWwgcGF0Y2hlczogMg0KPj4+DQo+Pj4gSWYgSSBkaWRu
J3Qga25vdyBiZXR0ZXIsIEkgd291bGQgdGhpbmsgeW91IHdlcmUgc3Bvb2ZpbmcgdGhlIGFkZHJl
c3MuLi4NCj4+DQo+PiBHcmVhdCwgdGhhbmtzLiBJIHdhcyBob25lc3RseSBob3BpbmcgeW91IHdv
dWxkIG1ha2UgdGhpcyBjb21wbGFpbnQuDQo+PiBJIGJyb3VnaHQgaXQgdXAgd2l0aCBvdXIgSVQg
YmVmb3JlICYgbm90aGluZyBoYXMgaGFwcGVuZWQgeWV0Lg0KPiANCj4gSXQncyBhbWF6aW5nIHRo
YXQgeW91ciBjb21wYW55IGVtYWlscyBhcmUgZXZlbiBtYWtpbmcgaXQgdG8gbWFueSBzeXN0ZW1z
DQo+IHRoZXNlIGRheXMgd2l0aCB0aGF0IGJyb2tlbi4NCg0KV2VsbCBES0lNIGlzIGFjdHVhbGx5
IGVuYWJsZWQgZm9yIHRoZSBkb21haW4gLSBqdXN0IGl0IGlzIHNpbXBsZS9zaW1wbGUNCndoaWNo
IEkgd291bGQgaW1hZ2luZSBwYXNzZXMgaW4gZGlyZWN0IGVtYWlscz8NCg0KPiANCj4+IEF0IGxl
YXN0IG5vdyBJIGhhdmUgdGhlIGRpcmVjdCBjb21wbGFpbnQgdG8gZm9yd2FyZCA6KQ0KPiANCj4g
UGxlYXNlIGRvLCBhbmQgdGVsbCB0aGVtIHRoYXQgaW4gdGhlIGZ1dHVyZSwgc29tZSBvZiB1cyB3
aWxsIHByb2JhYmx5DQo+IHN0YXJ0IHJlcXVpcmluZyB0aGlzIHRvIHBhc3MgYXMgSSBkb3VidCB0
aGV5IHdhbnQganVzdCBhbnlvbmUgdG8gc3Bvb2YNCj4gcGF0Y2hlcyBmcm9tIHlvdXIgZG9tYWlu
IDopDQoNCkkgc2FpZCBhcyBtdWNoIHRvIHRoZW0gYWxyZWFkeSwgaG9wZWZ1bGx5IHRoZSBjb21w
bGFpbnQgaGVscHMuDQoNClRoYW5rcyBhZ2FpbiwNCkNvbm9yLg0KDQo=
