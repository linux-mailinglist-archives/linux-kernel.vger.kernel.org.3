Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244E34CCF1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiCDHfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbiCDHfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:35:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF660954AB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646379285; x=1677915285;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7djVDIvqH7i6opOWObTLkFxNIeHy8oBmwjrZjN8xM6w=;
  b=iguDnvhkuC+Fceql4VgAj7Q3Q+jvoubsJ1c0yP7Xpb4s5t0IY4oENHWa
   NwiOXR20caXXcUFIORBLPyk32jDFdJ60CDmQ307uVgM8D6zIywQjGD+YG
   FWh3yCYuVlcUA/nwcRR3MUcZ4XDbep/CiKJvgBlYOrLV35BLmoMQpIzFR
   kaT0ZnPy8W0UJctGADRutRRQig6iQCNM/im1aa2782tgeDrPoWihK/rpL
   N0oOV2qozyPoPdRR665kfh0z3h6HHzySRUJRlJdHn/yZkJBRGiXhCY/X+
   bbDBxPLQ45yvJwXzrJk+fmj9pyykYM1PhjMEiI6S9lFQkoS87M40+6ySY
   w==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="155697645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 00:34:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 00:34:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 00:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caLjam2Nl+IQ1zUyQNaZNPoa3WM4xOekaQQLJSSijFAjjR1eJEwXw9/K+2he2bGd1yPYaRKzpIyZ1ohj7bY23TbXZziWiaMapp3sZKpEQwS/vQojSu/6Xu8/+XWfop7YRHr5O/YA6RzzsTuQFEjSmYTm4KQMHqK4/LcUai2bBpSzKZUSUgRkKgNL77MtCXvMa07ksUwhahuycELnjAdNpQFFCw/Ztx4OuQqhNqtwVXNZodBUvPSGuAI7qndx0HFvI2ZVjXrdWXD3alVXDs5pIrDWtis1dUZWC5W/225UcXt6/6HQMyTE7axX91ckMLsAZYpBOmN1aqzveyeIjOq2zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7djVDIvqH7i6opOWObTLkFxNIeHy8oBmwjrZjN8xM6w=;
 b=hPvm/eEs3bVVzHDhzmgw+31OEIdrDS2ehLK3qnEYBNWTfnFu9UzUeY694ao/NxW2fkDpylk3YrSTtGurzG03jGpmb65qIdlQf2T1bDTLnGZxKjjiwdncVQkdyttiiPeIyIO1OcjOWeKrbgPW+0dIbX4C7YwtO7HndTfHf+ilfxRKEZK46Mm/u1NAFpkmTATvhady2M8spb7TBNqzQAS6lwLysltt/L6ITEWsPCGwR+nLnH3NAGKqzFgcHFFKKE2rnE1ORZbvAHlrwqdtAih/kzMwZsxuSg0TX/wjJVtGJDUJJ1Zzbee7qPsV4qn36EVmCcU/JiV0GP8wFuB9QviR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7djVDIvqH7i6opOWObTLkFxNIeHy8oBmwjrZjN8xM6w=;
 b=vdWQhdMmdUTyINc8Z/F3ARM+Z0hKkO1u7wquLNbFbwob3Gdmf0JXQJOFjN+7e5t+ftZvZAocIEFkBJc1g5jenJI7NoerVd8GY+X//dKiT6d2aC/dLMQMorybVksmFr9/W9kNpNOpq1haF7265c3TVsVhD66ioPs/8m96nyxGTMc=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by DM6PR11MB3018.namprd11.prod.outlook.com (2603:10b6:5:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 07:34:34 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 07:34:34 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <xiongx18@fudan.edu.cn>, <Tudor.Ambarus@microchip.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yuanxzhang@fudan.edu.cn>, <xiyuyang19@fudan.edu.cn>,
        <tanxin.ctf@gmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: atmel: fix refcount issue in
 atmel_nand_controller_init
Thread-Topic: [PATCH v3] mtd: rawnand: atmel: fix refcount issue in
 atmel_nand_controller_init
Thread-Index: AQHYL5pLEMe6gY2CE0KrCTWBdGszmQ==
Date:   Fri, 4 Mar 2022 07:34:34 +0000
Message-ID: <ee00de10-2970-6e58-601b-4898bfa1c452@microchip.com>
References: <20220302132758.3820-1-xiongx18@fudan.edu.cn>
In-Reply-To: <20220302132758.3820-1-xiongx18@fudan.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d2b33ff-2950-4724-879e-08d9fdb16de9
x-ms-traffictypediagnostic: DM6PR11MB3018:EE_
x-microsoft-antispam-prvs: <DM6PR11MB3018E870B2B93C2CAB55207887059@DM6PR11MB3018.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JVIvgbWJ0yXhLQsqRKBF39b7qhEToZ0x22bbJ+Fv0qEyaQfPG0JZBis/SMUISiyeLIAj3dJXT3+uqO5GuJPXtLfGkH1igYfWB6pecMwdi9UWqV7I2OdsS1GcxYrVWleGPC/98UYMAsWfKb2VU6q1qUe7G6GHOUTdXft10vHBsal7dVR0TKxi8KDYuQYPbSDsh3TAQtVbvNfO3a3odsvcbG1nh2DujcSPN8dbRv3qIFOm+ahi6zfxThE8slQXhoTCbxF84BWNK8NMbkboQ1mUGgBdNn/+S3+AGfq6tejbKY+br94bGb7w/VP4n7Wgc0UWWYrp2qfa6u2r3UvURl//huTPhvl+abLJ2Pi2HW+LjicmxqcX7vSuWoMKe9upH3O5QKaAK0k60mUO1mNcgCaofS8cC2sv0L+82Gk/qbrYleGpg3lVj+Un+DF8P7Z1e42KsWyePi0CUI7OcSF3Ji7+hy1yIyHnnKxTF8zpNx6HbKOV9J4g+XcusA6of7D0xHTNvoinBVKuRwVONjhcxGVUQvfq3s5wNYjgBq4LDDRK/2mGrm6c1jyuxVfoWC6KfTcG8jdtT0fS/ODrLQahYZ13w+TRLw2hNlvvkm00XR/hMh1pxUV2rqNBuf101iRzk9+k1rIvncbQ6d4MXdoAEDLfHryrr0a3Uo6bj/MmT+xh7S+ZOmvINjO2PokwrD7OzF+B6IKlDOv7rfOcmkmep7DOZqdWHJ+rD5pAle89JavnY/CdGPJehZxCsS+oaSRMBxm317e6Ks5cUcEPo8kwfsQNpo3WEnsPyxrfHakpSyTG+8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(921005)(122000001)(66446008)(186003)(26005)(2616005)(83380400001)(54906003)(6512007)(86362001)(36756003)(31686004)(66946007)(64756008)(66476007)(76116006)(71200400001)(66556008)(8676002)(8936002)(4326008)(7416002)(31696002)(38070700005)(5660300002)(91956017)(110136005)(38100700002)(316002)(2906002)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dThTYzZKdi9KNlg5Qm4xdjd3MDdpYUp5Y1AwUStsaDNXNGV4Q3ZsWVpoQU83?=
 =?utf-8?B?TU9scGNmamtnak91OW1pNnBjUEpiZEdCZDBsRTJjTkFKY3NxMGJ1SVRBZ3lh?=
 =?utf-8?B?SUtELzVPM0tlRW5lcUsxVUFGcUc0bzVpdGNzZ0pnendUNmZ0RGpEb3BMSldo?=
 =?utf-8?B?eU1nT3FOZnlmdDRsWVdHWndHUWc5eStCVEFyaklYMEx6UmtpQTBPQ1o5MzF5?=
 =?utf-8?B?WUdTMUFuaHdPYjRsbUlYeWI3TWs5N3NxTXZGRnUzTGh4Q08rU2JnaU1La0RJ?=
 =?utf-8?B?dENFbTZlN04xQTNKbkIwcmR5V0ltaGJBZy93dE5GVE9LYTF6aXlEV1dqaSsr?=
 =?utf-8?B?MHdrWk04UWtwOE1oWS96QTVGbCtveVNCZTBtRGZTVXlsQkdCc1B4djdDWmxk?=
 =?utf-8?B?dGFUYlRyS092NkY4cUUyaEZTZEJmbG5uS3JFTk1kbG1DWi8rU0hYdktsTHFX?=
 =?utf-8?B?cVpvUEFENmR4cVlhUHc4dDBnVlQ3dnhhbFB2L0xINTd3Vm1FN0Y2amoreWsv?=
 =?utf-8?B?SjhPd2NUVmRDRmxKWDhkNG4wSllOYXJ0YWJZeE5mRWZubWh1MkFoYmNWVHF1?=
 =?utf-8?B?Yi9heThqTzErRXM4ME9OMHRTa1dGYU0wcVlrY1BqdW9WK3c0WnpVVmFOSE5y?=
 =?utf-8?B?QVpGYkQwKzk0QTZvaDJxUDRnMUJFRzBFV1MyWTlOM0U5amJRNFdaRkRBNUl6?=
 =?utf-8?B?dW5JU1dWaFF2QWdTSXdialoxYzM4eS83RTFTZ0hnQzdkd08zYUpmWmcySXJU?=
 =?utf-8?B?dHB3WkJidHh6bTY3SlZWOE1QWFlMVDZtQnhLZXNxUXpuVnd2ODEvNHZSWHRt?=
 =?utf-8?B?Q0RaV09jbFl5SmZxbVBNMFVmeGRMUXBTMGd4VXNTM25oaWR5WHZ5c0lodXJ4?=
 =?utf-8?B?aW54cDlTTThrNE9rc2JyTjZwKzhLQTBQR3RzOGt1ZkV3OFQvKzNtRW5kQkth?=
 =?utf-8?B?Q2pJcVVTYkdYTDVwQXBFdktxa1J1QU4wOWVuYzBIdFY5dnVnYlp1QkJ6N0di?=
 =?utf-8?B?NWx0aFpBM0x3djUwaTR2Mk1sL3pxTytDaFA4ZWVCRXFXaDJEaUxmK0gzMmpE?=
 =?utf-8?B?dTNrenZLc2lKZ01WRTVqSGhVdEg2QU5rNzJHVDN0eEZTek1iZkYwdWlpVzFh?=
 =?utf-8?B?dVU0STlraXRwbnFTcm9TT09tVlN5NENxNEQ5c0V4NXp6RFBqOHpOUEZMUXpo?=
 =?utf-8?B?WUVBb3VUWDNxTTdmd01JQ21jN3J5VGVqN0s0OFpNbEo5U1J3cXdkZWJreFpw?=
 =?utf-8?B?M0R5OUdiRHVnNSs1RHlWK2FiRktxL2NmOEJ1RG9jVE1OaEFQVnpJa0JqME41?=
 =?utf-8?B?VFU3aXZLVGZQdnRCcFFLMnBYcnR1eklqSWZ3ZjQ4VTFLN09LTWVVTm5iWlFa?=
 =?utf-8?B?TFpRanRXbTQ0S3hLNXIwSG5oNnVkWEtLa0c4d3g2ZUN3VmwrS0J1a1ZXOTBV?=
 =?utf-8?B?RGRKM3d1U1QySnR0Tk4zZnc3NklNV1c0R2E4S0c1aDV4dDNzU0FqVWhoVW9y?=
 =?utf-8?B?TGJETXNLeU5qZW56aW5SSXBJMEJxaDVzRHVaQXlrVWJYeW1kSkxVQlZNM2hl?=
 =?utf-8?B?QkROZWVlVE1aRWxFd2Nkd1BCeGxwbHkyMzRidjlyYmg5ajVqQXhkL0J4ZE5i?=
 =?utf-8?B?NGZCb0RCYmovZ3dUZEtqZG8vb1dTWnBTcnVNdFloVTFKNWk5dDdOOFJHS0Fh?=
 =?utf-8?B?SkU0Z2FOMXJCdXpNaGJCY0FJc2c3SS82dHBydnVobHFadWVQVGxEN2VmR0FG?=
 =?utf-8?B?ekxwbnpPK21JWmlnbG1pMFYyK2FrK3ZNUVZjb0ErQkJlUG9MdVlRV2NYU21W?=
 =?utf-8?B?aFlZTGMzWFNIbThIWm5wRENIbCttNE9jY21yL2JUQWowNXhRbFFITDBsRm9J?=
 =?utf-8?B?Smd6Y01BTDdGK3luVUtKYUw3R202ai9FYWYrb1dobFBXRllHZzJiR1pQNGhm?=
 =?utf-8?B?aDZuZ3dUQWc5dDBWWUhOdjM3TFZUdmJ1dE1TZnpya2ZrQ3dwWTZYcUJUSHdw?=
 =?utf-8?B?Mkw5ZTAyeFQ1UHVSUkRCVWpIbFMzK1h2aXJWeTRuTkFMZy9ZQ1locDBXekp6?=
 =?utf-8?B?R29oZWwvbVZ0UDNMQVg0bHJ1emp4TmNwMjFNVXRSTmZZWXRsYmZzRjcwd3lF?=
 =?utf-8?B?RS9kOHlqdzRHMkZEYTNaUTFlNXJPSGZkYlVHa2RWTlZ2VWcvb05GQkdFdWFO?=
 =?utf-8?B?ZlUwM2REUTlua1NVM1ErbHZ1cURlbzd5ZlRUK055bVhrU1B6dmFNWmI0UHJN?=
 =?utf-8?B?OEsvR2x5U3J5OHlDcFVyWWx1VGVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64870F2299E1D844A76DB1684DB9926C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2b33ff-2950-4724-879e-08d9fdb16de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 07:34:34.3289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDNwXvh2q2w3CVgU6ehXEkiw+f439tQ5P4noxWcrdBnZklsKDL5sOd4bPfdPLIxH5XU+3hnVpsnVHPnz6+eUoA75ruL5A/dlIaI488nvAf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3018
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMDMuMjAyMiAxNToyNywgWGluIFhpb25nIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSByZWZlcmVuY2UgY291bnRpbmcgaXNzdWUgaGFw
cGVucyBpbiBzZXZlcmFsIGVycm9yIGhhbmRsaW5nIHBhdGhzDQo+IG9uIGEgcmVmY291bnRlZCBv
YmplY3QgIm5jLT5kbWFjIi4gSW4gdGhlc2UgcGF0aHMsIHRoZSBmdW5jdGlvbiBzaW1wbHkNCj4g
cmV0dXJucyB0aGUgZXJyb3IgY29kZSwgZm9yZ2V0dGluZyB0byBiYWxhbmNlIHRoZSByZWZlcmVu
Y2UgY291bnQgb2YNCj4gIm5jLT5kbWFjIiwgaW5jcmVhc2VkIGVhcmxpZXIgYnkgZG1hX3JlcXVl
c3RfY2hhbm5lbCgpLCB3aGljaCBtYXkNCj4gY2F1c2UgcmVmY291bnQgbGVha3MuDQo+IA0KPiBG
aXggaXQgYnkgZGVjcmVtZW50aW5nIHRoZSByZWZjb3VudCBvZiBzcGVjaWZpYyBvYmplY3QgaW4g
dGhvc2UgZXJyb3INCj4gcGF0aHMuDQo+IA0KPiBGaXhlczogZjg4ZmMxMjJjYzM0ICgibXRkOiBu
YW5kOiBDbGVhbnVwL3Jld29yayB0aGUgYXRtZWxfbmFuZCBkcml2ZXIiKQ0KPiBDby1kZXZlbG9w
ZWQtYnk6IFhpeXUgWWFuZyA8eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+DQo+IFNpZ25lZC1vZmYt
Ynk6IFhpeXUgWWFuZyA8eGl5dXlhbmcxOUBmdWRhbi5lZHUuY24+DQo+IENvLWRldmVsb3BlZC1i
eTogWGluIFRhbiA8dGFueGluLmN0ZkBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpbiBU
YW4gPHRhbnhpbi5jdGZAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBYaW4gWGlvbmcgPHhp
b25neDE4QGZ1ZGFuLmVkdS5jbj4NCj4gLS0tDQo+IFYyIC0+IFYzOiBSZW1vdmVkIHJlZHVuZGFu
dCBsaW5lcw0KPiBWMSAtPiBWMjogUmV3cml0ZWQgdGhlIGVycm9yIGhhbmRsaW5nIGJsb2NrDQo+
IC0tLQ0KPiAgZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMgfCAx
NCArKysrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRt
ZWwvbmFuZC1jb250cm9sbGVyLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hdG1lbC9uYW5kLWNv
bnRyb2xsZXIuYw0KPiBpbmRleCBmMzI3NmVlOWU0ZmUuLjNkYzRhNGJhY2RlNSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMNCj4gKysr
IGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXRtZWwvbmFuZC1jb250cm9sbGVyLmMNCj4gQEAgLTIw
NjAsMTMgKzIwNjAsMTUgQEAgc3RhdGljIGludCBhdG1lbF9uYW5kX2NvbnRyb2xsZXJfaW5pdChz
dHJ1Y3QgYXRtZWxfbmFuZF9jb250cm9sbGVyICpuYywNCj4gICAgICAgICBuYy0+bWNrID0gb2Zf
Y2xrX2dldChkZXYtPnBhcmVudC0+b2Zfbm9kZSwgMCk7DQo+ICAgICAgICAgaWYgKElTX0VSUihu
Yy0+bWNrKSkgew0KPiAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmV0
cmlldmUgTUNLIGNsa1xuIik7DQo+IC0gICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihuYy0+
bWNrKTsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIobmMtPm1jayk7DQo+ICsgICAg
ICAgICAgICAgICBnb3RvIG91dF9yZWxlYXNlX2RtYTsNCj4gICAgICAgICB9DQo+IA0KPiAgICAg
ICAgIG5wID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPnBhcmVudC0+b2Zfbm9kZSwgImF0bWVsLHNt
YyIsIDApOw0KPiAgICAgICAgIGlmICghbnApIHsNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIo
ZGV2LCAiTWlzc2luZyBvciBpbnZhbGlkIGF0bWVsLHNtYyBwcm9wZXJ0eVxuIik7DQo+IC0gICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IC1FSU5W
QUw7DQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dF9yZWxlYXNlX2RtYTsNCj4gICAgICAgICB9
DQo+IA0KPiAgICAgICAgIG5jLT5zbWMgPSBzeXNjb25fbm9kZV90b19yZWdtYXAobnApOw0KPiBA
QCAtMjA3NCwxMCArMjA3NiwxNiBAQCBzdGF0aWMgaW50IGF0bWVsX25hbmRfY29udHJvbGxlcl9p
bml0KHN0cnVjdCBhdG1lbF9uYW5kX2NvbnRyb2xsZXIgKm5jLA0KPiAgICAgICAgIGlmIChJU19F
UlIobmMtPnNtYykpIHsNCj4gICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIobmMtPnNtYyk7
DQo+ICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgIkNvdWxkIG5vdCBnZXQgU01DIHJlZ21h
cCAoZXJyID0gJWQpXG4iLCByZXQpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
KyAgICAgICAgICAgICAgIGdvdG8gb3V0X3JlbGVhc2VfZG1hOw0KPiAgICAgICAgIH0NCj4gDQo+
ICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gK291dF9yZWxlYXNlX2RtYToNCj4gKyAgICAgICBp
ZiAobmMtPmNhcHMtPmhhc19kbWEgJiYgIWF0bWVsX25hbmRfYXZvaWRfZG1hICYmIG5jLT5kbWFj
KQ0KDQpBcyBCb3JpcyBhbHNvIHN1Z2dlc3RlZCBwcmV2aW91c2x5LCBjaGVja2luZyBuYy0+ZG1h
YyBzaG91bGQgYmUgZW5vdWdoIGhlcmUuDQoNCj4gKyAgICAgICAgICAgICAgIGRtYV9yZWxlYXNl
X2NoYW5uZWwobmMtPmRtYWMpOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gIH0NCj4g
DQo+ICBzdGF0aWMgaW50DQo+IC0tDQo+IDIuMjUuMQ0KPiANCg0K
