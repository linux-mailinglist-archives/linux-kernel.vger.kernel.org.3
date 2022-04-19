Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD575065F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349412AbiDSHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiDSHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:35:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99FE09B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650353565; x=1681889565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PgNHd1vB1qYWGrFDfjFiu/2jhKFpN8qLR0vXzqGGfcQ=;
  b=ZGgX2cGoiaPVscSE0AqbnvlNRZ37ckxAb7CRnaowbv7imGHo4kTvDxnx
   8sPGmUenCTaEbhwgDcDAbufcMR7pdEljBj7qijm+OrV46nPKGEqs0XIRl
   GiZ+qWbmW/hb5IKNdTazbHFDwK/fIGgmCVwZMtrnoRNekgDjx3z7IDr1e
   CfwF70t7TDrZXrCDaXDwAsbYcxkEpcHgu4HjJHPTFr8y2Kiq3KYu17SWT
   J5zN09XpZgA+74xzPoGvNlGO+eCGepClrQE8N053DxQi+2X+foDdivB6y
   fdmCfeyqYnzB6QDbfvPa9iT7GHgHf2pQ7OJ8SB4W2D+qnXGMWPaCzYBNJ
   w==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643698800"; 
   d="scan'208";a="170060936"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Apr 2022 00:32:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Apr 2022 00:32:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 19 Apr 2022 00:32:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVy4o4vJnH927bew1NDWi1GBGIiaM0AcDh1/wRScpw/Dnuqzx9YzAfraKRkFlgSFK+P1NLZuxjXCkBDdFDAXb7TjKkD3jDfymRWoC/f+NavfIA4OHBYofNgenBEnp67/Qdz6cSD1Gt/KP+mjPtuz19mEvOHoJ1uGuf4J5wQwPE5k6S8yMYchnZEscNdAYEPD5WlZf4sw8Aiz+IEoPMkGzUHdjbML1Q/Dkgsgo0ix2IFuC9h09tQgSGtlBbeu+DR1hgefA2qpecJGhtJCykpzq0yznzl91sO6HbmFIKDDx+3A3WwYEDyGabw/Y1j0wWdAc8fhQ/m7Qd9MoIfvhNZEhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgNHd1vB1qYWGrFDfjFiu/2jhKFpN8qLR0vXzqGGfcQ=;
 b=LkPzyG3LQqjXZy/LO4BVqJC15ylSvLgABkTF9UFBPUN0rET650Cb6iMt8Do+EU97i1aZmP4v3Hp2X/z5FCC6ovZsEhacXR7YJlm5+bhFwy9iBsKvm5W63/4xP8+NZqqoxCmqMn6Rb8OSzfFS5yG8pQtK8J/uz6eJ+0LoZGOUHnX7xveZxkfDhDffq9jZi2Uxe66+W5U/73uvoOISV8SGFK1FEnV/+dmNjn9es3myCr2rRGSNW9kszqyXdag7Ew9PLp380qCF7N+8WuHkS19iYYcahRgq/02PwIZ//yB3FanAoJhy5E+noX2ne6x/c5+KhK4/+TM9nnl+75ADJ53cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgNHd1vB1qYWGrFDfjFiu/2jhKFpN8qLR0vXzqGGfcQ=;
 b=dBubCahwX50nzg0EQg35LE3N69v75tSYP112cMmAzrCdtHp4lkdncLkEbqdEeM96I9R3DB3Az91eWOxL811DwYPaRIX4b6Kv6UqMlofxY5cOJ/gsEFImB83sg69T/OacNFh6P5RJzQleO3d11ld5NS592cLA5Vw3TmDxUQcfu/E=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3358.namprd11.prod.outlook.com (2603:10b6:805:c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 07:32:37 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::3414:43b2:d8a:bc00%7]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 07:32:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <quic_c_sbhanu@quicinc.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_asutoshd@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>, <quic_nitirawa@quicinc.com>,
        <quic_sayalil@quicinc.com>
Subject: Re: [PATCH V8] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Thread-Topic: [PATCH V8] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Thread-Index: AQHYU7+k1+QxrxVooEeFpVQoWpy1mA==
Date:   Tue, 19 Apr 2022 07:32:36 +0000
Message-ID: <4324bf7f-e397-7510-96a2-5a309e30d76c@microchip.com>
References: <1648191975-1366-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <20220419042742.qqfj6wurpxxqhr6l@ti.com>
In-Reply-To: <20220419042742.qqfj6wurpxxqhr6l@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d876a3-dfd7-45b3-fe6d-08da21d6c6e3
x-ms-traffictypediagnostic: SN6PR11MB3358:EE_
x-microsoft-antispam-prvs: <SN6PR11MB33584E0E0EB31873D98E6C40F0F29@SN6PR11MB3358.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PKBrH5KtDCiR8N56q24/RJKN56OcZ2kIg1C6L38sjwIr2ADQomr+5FuGQHA9vIZtaiokRysKbmQ1aJvdpijA/2/GRO+dojE00L8bqR7jd9aUc+VMv0kcbz5ZQHc2rod0wpSO86dER7NfDQ5GDqVnKnMtHgHL9muazv4nah1/xWNMnBjOvuMcy9MLIX+bM6kbO1ZGn51bA0+G94uXPqdROYOSzL1L0EO8C69/jbYJpaKj0+R9EpJKHUw5A84EKIof2aRM4PjR7lAFr/msOfphSto1guY3ZGU+RFb4K/BfEfrCZCB65nz/7SqwrvM8DS6jBq9f2aFVN7ds48FdRNq7SKY7RAyjGa7IenWl77LMx7fMNp7AK6XaFx5IwlLLyJMGzEzGNtjyAY/u9LAmhZRyf4/tVYM72QKQcJLK42OFB2qajmVyBPyEJ353BFvtnIRXzrqSbvE/2HRXjp1BfWq4MCTn3xvMqMndq/ViSoP8QFvNMpQnUf4UVGJ26HcI7LaRRr3l7HgbofQKvv8BYUOegNOqSkhF8OjOfspK4SYadmOZpsddxV/AY+vOuiUfC6ftq2Z4H+46nw7h5SU+DXjTdjLn9dx5aS3YvRrkzIBGuD0OkIuiCnfqy9bLv4iDhWA0u5sBF2rt+m4M+P7b/FV9iAGZ/NvjJotLIxBLu8wyMkPmiDl+4aOxPyAyEcUMhFsNMMg7h+XJCcu9eN2f+m4ESrRXuMxk78Anh/YCOa6LzfUN18IcFLvYGEhVY5bV9xAQLiNB/rKW05WVPn9Qj0Sqhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(8936002)(66946007)(66556008)(66476007)(64756008)(86362001)(31696002)(4326008)(186003)(54906003)(26005)(110136005)(7416002)(122000001)(38100700002)(83380400001)(6512007)(6506007)(8676002)(2906002)(38070700005)(2616005)(5660300002)(91956017)(76116006)(53546011)(316002)(71200400001)(508600001)(6486002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wi9VZFE1L3RwSy9lSHhxMitiN2MrL0N1N2RZTC8ycVltYzh2QjlrVEgyTHJk?=
 =?utf-8?B?TkRuUjZ3alM1eGpjbnV1eEY5UVA3dEJpeXpKYUtQdUxnL0NCQThMSkNoQWNi?=
 =?utf-8?B?TWxkT1ZmWUlleTFXTmtocEtnTGlZQzZGZWJsd1VVNmd4aTgybTh2NUFTQU9y?=
 =?utf-8?B?ZGx5eGhaK3ltSE5HQVZ2QzBpS3ovZDhiNEwyK1Z6YS9GTW1lSnNFOEc3S0tR?=
 =?utf-8?B?bk9qU0pqc2hoWkxoT29URUZ3cytVTGhEOUhLdHc5SU5mb0swYThzekZBdEx1?=
 =?utf-8?B?V29nNDk4SDJON1RGempaMFhsQXQvNHdrS284eWUySG5LV1ZSRUdTemR3a2s2?=
 =?utf-8?B?bDUxV2FMenZVVlJiVCtvUzFWMlZVQW53d0pVYnBOaU9YNDluRkpoKzJzc0dQ?=
 =?utf-8?B?Tm54aHFEcGJGSy9QT0dKdStNaGhyWjYvTTZtNWtGRUliWk5lNXpKNDgzUUtr?=
 =?utf-8?B?emJFbmZnVjEzOUxiNVh0Z2tKNzhtVlNGQTRkSzB5b0dXalo4R3dkd2xQRTMr?=
 =?utf-8?B?Q0drNTFiZjA1UVZUbzhhRzNmSndFSHFoTmRkaEd3UzlYSURXNWlDK1VTeDd5?=
 =?utf-8?B?VDh0SkVkRlVqakVCQTBZUXN4VHlzMk9MYTVML1RHSFZma3VWcVMwYlVmcWY2?=
 =?utf-8?B?dUZNdzBEQklxa3dza0Q3NGN3bWpWVDlYTlh0akR2dUE2dkQ0OHlnL0tZaGpp?=
 =?utf-8?B?NTgwWUkvbjE1QW5xT2lzZ09DZmpuSkE1L2F3REFMNEtUVEw1eE0zWjNyMHBr?=
 =?utf-8?B?T0FNbVUyRWl5MkN0cW9EeUU2Z0ZrdmdUeW1McFlwblA1aHZJNDMzN01KUTdi?=
 =?utf-8?B?eE1jOUdieGI4ZGd4cEFSN0Y1V1Mrb1FGbndsSDArYjdLWVp3ejJlSHlKU1BP?=
 =?utf-8?B?QTRBTnpkUGlDV3g2UlBSSThBNUFLaWZoZXdqU2h4N0tXSlI3SU9lVjFnbkFk?=
 =?utf-8?B?Ky9ycnFNNCt3eEsvcGVpQlliendkcDBKWEVZN0FhL24zdm9kOW4wNGRQdnRV?=
 =?utf-8?B?eUtLSlNrZEI2VWhpWFY4WVdBSU11eGdySm9TMTlVTitmcUFES2R2WVJDTG80?=
 =?utf-8?B?ZktmdzRzNm13YWRVSkh3emhkWUtyb0h3dzN3THF5WkpObGNKMWdhWmFQSklE?=
 =?utf-8?B?Q3JVR2JHR05WdHAvZHhOU1JrNUgzVWNoRjdXdzVPdTRsZW5YN1hDUmVSMHh5?=
 =?utf-8?B?MGUzd2NKMzVFRHFXUTUxVUNqUEJ4MjdiWWZ6RWZVZFM5TCthcEYvZjZ4d2pn?=
 =?utf-8?B?Q0owRGZaUUlHRDdMVGlEVllCOE5NUDV1cWFoS29USjc4bDl4UEErRHd4OEhp?=
 =?utf-8?B?UzJCTUNFRFdqeGVaK1JvOGN2dzhIejFtaVFRTFFuTnBSeVZCVTRRNWJWNWxI?=
 =?utf-8?B?bGtWa2l5V0g1UmE2bDk3eHN5Z095MGxKTTFlL3N6WElCbW1WelVlK0p3VG0x?=
 =?utf-8?B?RmZ5eEZvWnU0MkQwVUEzc01rS2ZSTEg3eUkyVFh0bnpOQWdiNExvVHc0NE53?=
 =?utf-8?B?QURBZVJaM3U1UHEwMjV4ekRyU1A3WEpTNnBHcnF2R25tLzdISENDYnR6T0NP?=
 =?utf-8?B?Y3MzMUlmMDgrYnlyaGJZS0VGTkpBdGlQbno3cjB0VnhEM0FXS3hBT21TbTFX?=
 =?utf-8?B?NGIxc1djbVVmMmdVeGtaMkZEWVNZTFdJY1g2T0RZVXlEaUpwejdDVk5uUXc0?=
 =?utf-8?B?VElxUThXN25uZDUyYU84N0wzV1hCTXY2eFN1ODUxOXByd0hzdVB5Y0pvVjhi?=
 =?utf-8?B?M3p1cGZNVnM4dG5RK2lndkpPMFlYdWlKdWJKT255eUsvbEhUc0NWTTR4RXNE?=
 =?utf-8?B?K3QwbnBPU0RJd3MveEdsZUROTFdvQzZ3a3hIQXl0NUt1Y055eCtFUCs3aThC?=
 =?utf-8?B?L21KbXkxTEFHbUVWdnVjcUJwU3BDYnhCQU5SL1d0ckZpUWY2dnVuWkljWDRS?=
 =?utf-8?B?NkxwellEWUJKWUlpdnN0QUV0ZDFlVlVvREQ5WE5UODk0dkI4QXdNbk9XbTlF?=
 =?utf-8?B?QzFGRFQ1QmFRWU9xVUtxblJaeUszcUFpVFZ0ODNGdW14MFUzY0haR28xQUJX?=
 =?utf-8?B?LzlrdHNBNWZWdTk4aU1HRDEwcFVDcjB5WTBzclJOVnJvcXJhRmNTY2lwSlB6?=
 =?utf-8?B?dU9MWURGSmExanZmelR3djd0bCtoU1djV3g2SXIxcWdIZnF2bEMvcmFNck5i?=
 =?utf-8?B?UWswTUtndjROYTRxdDJjODdFaTNyZThnR29SWDlua1ZmS3VRRHJsWTNLbVdr?=
 =?utf-8?B?OHovUnhTcURPbnI3KzYzK2pha1BkZnV0NmJWbjhTVmZhSW1OMHNYWVlwWVNO?=
 =?utf-8?B?L3dOcVNpYzVBbnhCMHR1ZGoyUXBLWXdyNzN6U1hRblk3UFRrN3NHN1h5Sm52?=
 =?utf-8?Q?7i9iAFvttMvu/0MA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE10777BC027384D8B1CDD2044B55DB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d876a3-dfd7-45b3-fe6d-08da21d6c6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 07:32:36.9425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROKKzlJ6BzxSnyxZg8gZDA+o//OL/yTQVHeOjCU/iVc44Y6sGjnKXiKxKUiOTQ5MUjiZhS8YZ52jeBIadEvKVTgAwKtxHmyz5aFm7IS5n78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3358
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xOS8yMiAwNzoyNywgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjUvMDMvMjIgMTI6MzZQTSwgU2hhaWsgU2Fq
aWRhIEJoYW51IHdyb3RlOg0KPj4gQWRkIHN1cHBvcnQgZm9yIHdpbmJvbmQgVzI1UTUxMk5XLUlN
IGNoaXAuDQo+Pg0KPj4gQmVsb3cgYXJlIHRoZSB0ZXN0cyBkb25lOg0KPj4NCj4+IDEuIFZlcmlm
aWVkIGZsYXNoaW5nIGJpbmFyeSBpbWFnZSBvbiBzcGkgY2FyZCB1c2luZyBmbGFzaHJvbSB0b29s
Lg0KPj4gMi4gVmVyaWZpZWQgT1RQIHN1cHBvcnQsIGJlbG93IGFyZSB0aGUgdGVzdCByZXN1bHRz
Og0KPj4NCj4+ICBsb2NhbGhvc3QgLyAjIGNhdA0KPj4gIC9zeXMvYnVzL3BsYXRmb3JtL2Rldmlj
ZXMvc29jXEAwLzg4ZGMwMDAuc3BpL3NwaV9tYXN0ZXIvc3BpMTYvDQo+PiAgc3BpMTYuMC9zcGkt
bm9yL2plZGVjX2lkDQo+PiAgZWY4MDIwDQo+Pg0KPj4gIGxvY2FsaG9zdCAvICMgY2F0DQo+PiAg
L3N5cy9idXMvcGxhdGZvcm0vZGV2aWNlcy9zb2NcQDAvODhkYzAwMC5zcGkvc3BpX21hc3Rlci9z
cGkxNi8NCj4+ICBzcGkxNi4wL3NwaS1ub3IvbWFudWZhY3R1cmVyDQo+PiAgd2luYm9uZA0KPj4N
Cj4+ICBsb2NhbGhvc3QgLyAjIGNhdA0KPj4gIC9zeXMvYnVzL3BsYXRmb3JtL2RldmljZXMvc29j
XEAwLzg4ZGMwMDAuc3BpL3NwaV9tYXN0ZXIvc3BpMTYvDQo+PiAgc3BpMTYuMC9zcGktbm9yL3Bh
cnRuYW1lDQo+PiAgdzI1cTUxMm53bQ0KPj4NCj4+ICBsb2NhbGhvc3QgLyAjIGhleGR1bXANCj4+
ICAvc3lzL2J1cy9wbGF0Zm9ybS9kZXZpY2VzL3NvY1xAMC84OGRjMDAwLnNwaS9zcGlfbWFzdGVy
L3NwDQo+PiAgaTE2L3NwaTE2LjAvc3BpLW5vci9zZmRwDQo+PiAgMDAwMDAwMCA0NjUzIDUwNDQg
MDEwNiBmZjAxIDA2MDAgMTAwMSAwMDgwIGZmMDANCj4+ICAwMDAwMDEwIDAwODQgMDIwMSAwMGQw
IGZmMDAgZmZmZiBmZmZmIGZmZmYgZmZmZg0KPj4gIDAwMDAwMjAgNjgwMCA2YzY1IDZmNmMgNzcy
MCA3MjZmIDY0NmMgZmZmZiBmZmZmDQo+PiAgMDAwMDAzMCBmZmZmIGZmZmYgZmZmZiBmZmZmIGZm
ZmYgZmZmZiBmZmZmIGZmZmYNCj4+ICAqDQo+PiAgMDAwMDA4MCAyMGU1IGZmZmIgZmZmZiAxZmZm
IGViNDQgNmIwOCAzYjA4IGJiNDINCj4+ICAwMDAwMDkwIGZmZmUgZmZmZiBmZmZmIDAwMDAgZmZm
ZiBlYjQwIDIwMGMgNTIwZg0KPj4gIDAwMDAwYTAgZDgxMCAwMDAwIDAyMzMgMDBhNiBlNzgxIGQ5
MTQgNjNlOSAzMzc2DQo+PiAgMDAwMDBiMCA3NTdhIDc1N2EgYmRmNyA1Y2Q1IGY3MTkgZmY1ZCA3
MGU5IGE1ZjkNCj4+ICAwMDAwMGMwIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYg
ZmZmZg0KPj4gIDAwMDAwZDAgMGFmZiBmZmYwIGZmMjEgZmZkYw0KPj4gIDAwMDAwZDgNCj4+DQo+
PiAgbG9jYWxob3N0IC8gIyBtZDVzdW0NCj4+ICAvc3lzL2J1cy9wbGF0Zm9ybS9kZXZpY2VzL3Nv
Y1xAMC84OGRjMDAwLnNwaS9zcGlfbWFzdGVyL3NwaQ0KPj4gIDE2L3NwaTE2LjAvc3BpLW5vci9z
ZmRwDQo+PiAgMTA2ZDg5ZDZjMDQ5MTEwYmM5NGMwMTUxN2NiNGNlMjQNCj4+ICAvc3lzL2J1cy9w
bGF0Zm9ybS9kZXZpY2VzL3NvY0AwLzg4ZGMwMDAuc3BpLw0KPj4gIHNwaV9tYXN0ZXIvc3BpMTYv
c3BpMTYuMC9zcGktbm9yL3NmZHANCj4+DQo+PiAzLiBUZXN0ZWQgZmxhc2ggbG9jaywgYmVsb3cg
YXJlIHRoZSB0ZXN0IHJlc3VsdHMgKGxvb2tzIGxpa2UgdGhlIGxvY2sgaXMNCj4+ICBub3Qgd29y
a2luZyBhcyBleHBlY3RlZCwgc28gd2hlbiB3ZSBkbyBsb2NrIHRoZSB3aG9sZSBjYXJkIGFuZCB0
cmllZCB0bw0KPj4gIHdyaXRlLCB3cml0ZSB3YXMgc3VjY2Vzc2Z1bCB3aXRob3V0IGFueSBlcnJv
cnMuKQ0KPiANCj4gV2hhdCBzaG91bGQgd2UgZG8gd2l0aCB0aGlzIHRoZW4/IERyb3AgdGhlIGxv
Y2tpbmcgc3VwcG9ydD8gT3IgaXMgdGhlcmUNCj4gc29tZXRoaW5nIHdyb25nL21pc3NpbmcgaW4g
U1BJIE5PUiBjb3JlIHRoYXQgbmVlZHMgdG8gYmUgZml4ZWQgZmlyc3Qgc28NCj4gbG9ja2luZyBm
b3IgdGhpcyBmbGFzaCB3b3Jrcz8NCj4gDQoNCklmIHRoZSBsb2NraW5nIGlzbid0IHdvcmtpbmcg
Zm9yIHRoaXMgZmxhc2gsIHBsZWFzZSBkcm9wIHRoZSBsb2NraW5nIGZsYWdzDQp1bnRpbCB5b3Ug
aWRlbnRpZnkgdGhlIHByb2JsZW0gYW5kIGZpeCBpdC4NCg0KPj4NCj4+ICBsb2NhbGhvc3QgfiAj
IGZsYXNoX2xvY2sgLWkgL2Rldi9tdGQwDQo+PiAgRGV2aWNlOiAvZGV2L210ZDANCj4+ICBTdGFy
dDogMA0KPj4gIExlbjogMHg0MDAwMDAwDQo+PiAgTG9jayBzdGF0dXM6IGxvY2tlZA0KPj4gIFJl
dHVybiBjb2RlOiAxDQo+PiAgbG9jYWxob3N0IH4gIyBtdGRfZGVidWcgZXJhc2UgL2Rldi9tdGQw
IDB4NDAwMDAwIDQwOTYNCj4+ICBFcmFzZWQgNDA5NiBieXRlcyBmcm9tIGFkZHJlc3MgMHgwMDQw
MDAwMCBpbiBmbGFzaA0KPj4gIGxvY2FsaG9zdCB+ICMgbXRkX2RlYnVnIHJlYWQgL2Rldi9tdGQw
IDB4NDAwMDAwIDQwOTYNCj4+ICB0ZW1wDQo+PiAgQ29waWVkIDQwOTYgYnl0ZXMgZnJvbSBhZGRy
ZXNzIDB4MDA0MDAwMDAgaW4gZmxhc2gNCj4+ICB0byB0ZW1wDQo+PiAgbG9jYWxob3N0IH4gIyBt
dGRfZGVidWcgd3JpdGUgL2Rldi9tdGQwIDB4NDAwMDAwDQo+PiAgNDA5NiB0ZW1wDQo+PiAgQ29w
aWVkIDQwOTYgYnl0ZXMgZnJvbSB0ZW1wIHRvIGFkZHJlc3MgMHgwMDQwMDAwMA0KPj4gIGluIGZs
YXNoDQo+PiAgbG9jYWxob3N0IH4gIyBmbGFzaF9sb2NrIC11IC9kZXYvbXRkMA0KPj4gIGxvY2Fs
aG9zdCB+ICMgZmxhc2hfbG9jayAtaSAvZGV2L210ZDANCj4+ICBEZXZpY2U6IC9kZXYvbXRkMA0K
Pj4gIFN0YXJ0OiAwDQo+PiAgTGVuOiAweDQwMDAwMDANCj4+ICBMb2NrIHN0YXR1czogdW5sb2Nr
ZWQNCj4+ICBSZXR1cm4gY29kZTogMA0KPj4gIGxvY2FsaG9zdCB+ICMgbXRkX2RlYnVnIGVyYXNl
IC9kZXYvbXRkMCAweDQwMDAwMCA0MDk2DQo+PiAgRXJhc2VkIDQwOTYgYnl0ZXMgZnJvbSBhZGRy
ZXNzIDB4MDA0MDAwMDAgaW4gZmxhc2gNCj4+ICBsb2NhbGhvc3QgfiAjIG10ZF9kZWJ1ZyByZWFk
IC9kZXYvbXRkMCAweDQwMDAwMA0KPj4gIDQwOTYgdGVtcENvcGllZCA0MDk2IGJ5dGVzIGZyb20g
YWRkcmVzcyAweDAwNDAwMDAwIGluDQo+PiAgZmxhc2ggdG8gdGVtcA0KPj4gIGxvY2FsaG9zdCB+
ICMgbXRkX2RlYnVnIHdyaXRlIC9kZXYvbXRkMCAweDQwMDAwMCA0MDk2IHRlbXANCj4+ICBDb3Bp
ZWQgNDA5NiBieXRlcyBmcm9tIHRlbXAgdG8gYWRkcmVzcyAweDAwNDAwMDAwIGluIGZsYXNoDQo+
PiAgbG9jYWxob3N0IH4gIw0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoYWlrIFNhamlkYSBCaGFu
dSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBEb3VnIEFuZGVy
c29uIDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQo+PiBSZXZpZXdlZC1ieTogTWljaGFlbCBXYWxs
ZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gWy4uLl0NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFBy
YXR5dXNoIFlhZGF2DQo+IFRleGFzIEluc3RydW1lbnRzIEluYy4NCg0K
