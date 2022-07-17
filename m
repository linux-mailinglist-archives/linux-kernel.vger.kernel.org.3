Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C9C577724
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiGQPq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGQPqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:46:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC2D96;
        Sun, 17 Jul 2022 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658072813; x=1689608813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P+rz1JuhmU23sxx67dkitcEIB+Uub/rxWcBwxRn2iu0=;
  b=e4AnATTBwYuCz3qUiDN037mhCnLayZvD/e7ztyjVO9lGm5jWfJfBJoDF
   sa5rdqaFxqPOTLLLhIWc1hs4xGUj3B7SY5BO2rBOvgLLv42sGBoA0OPRU
   yYxwLYNqeV/7lAgLMQd61PGztEWgqHQwIXokcaq47i3ztuf0Rv4exUBVD
   A6z10pi2m85vzvaRnRxxKmwGyTslJ58NIXoFS2MhA+AaId9x3ramJP+E7
   I/0TOONL0/WR6A6AIezaJ2hhnBBCPyOUsNApFy8uX5rF7t8w1lu0KWghc
   sNN6p9dwsfmJ+X+KZ11UaRt+Nx4iB4lMwbwhfsqzS0qxM8RAhT6zEdGVk
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="182532157"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2022 08:46:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 17 Jul 2022 08:46:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 17 Jul 2022 08:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SddeibbZeEJ0B4Q1Jrv7JldwmDa8KmP29toVdRzh6myA8R7af4LJkLTWy0UGCI9jItGC6JX9Cqv4BMuW6otoWINibs7m1N18DHLc59/knN9ThuB0ngDQC5H80gFFVqGenHNrKad5bI01iRQyNH9wiaROkgv/eGB+2ErxXacCNx6DA8peV8ozUigPYQBChlmwi6uVzyx/mf64Wce+jsL2IaG/zXFh1eBojH8qj42RF5NgvTg8EJojuzNO5sfbSHp4jt/EdKatw4/VzRqzkU/VBcC/u9hg8vyyqI77U8f+095V+L2EjJ4X1zO/u14Oox7QkpsB+2q38eVEGlKZcpehVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+rz1JuhmU23sxx67dkitcEIB+Uub/rxWcBwxRn2iu0=;
 b=gg1KlorE3gXIhbLS5jbkWw1CEkj30JRtKlS6NEnGFe0KXtM+PU7mjBExqHzl3IoD5o9nBkza0YAnl7oYnK5LYA9i3VfMY+EEUL0C4RNNf0WlPkrJxuPpMG5Bd1Om+EAFGU+Bi/gwyP05evSMnu/tRbTECbEfcJG1V3LwaP9ExXx8ZoNcDZs3pQdktm1kXLshAh3MvX5i9UJg6bQ3IhtKZTX5okWLuXlCMiYeKk1O4GJsF8POIIcmXSfP/KiZa70CG9gAs69goZRPtZeaxXYymAlnB7LAQ3wyjn7bSDO1zCwTuug0k2LNrk9fRNwVqeidHIO8l0VD74WCkccQ+/62ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+rz1JuhmU23sxx67dkitcEIB+Uub/rxWcBwxRn2iu0=;
 b=OGgeQWDEdEKh7ENqRXUJbRMvbkW9A3H7V6FfG8sBkysikQWIEyErCh6wvb2ESJrXCsql/mcR9xgroIpk77LZb/J+f/dn0+iYECMEAVpP984xD/APeXXmMcjB6kmKrGcxKJ8XAYSlmpEQOhSgfC7eVpQrR5DetdKzXy+Q9SZE7tU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB6573.namprd11.prod.outlook.com (2603:10b6:a03:44d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Sun, 17 Jul
 2022 15:46:41 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.023; Sun, 17 Jul 2022
 15:46:41 +0000
From:   <Conor.Dooley@microchip.com>
To:     <maz@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <Lewis.Hanly@microchip.com>, <linux-riscv@lists.infradead.org>,
        <brgl@bgdev.pl>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <palmer@dabbelt.com>,
        <linux-kernel@vger.kernel.org>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Topic: [PATCH v3 1/1] gpio: mpfs: add polarfire soc gpio support
Thread-Index: AQHYmONENpwHvjgotEKXOSINBvKPca2AzRoAgABQpwCAACn4gIAAC0QAgAFZ34CAAAougA==
Date:   Sun, 17 Jul 2022 15:46:41 +0000
Message-ID: <528e8935-4929-863a-ef5e-5b49d1d8aeba@microchip.com>
References: <20220716071113.1646887-1-lewis.hanly@microchip.com>
 <20220716071113.1646887-2-lewis.hanly@microchip.com>
 <87r12l4aaj.wl-maz@kernel.org>
 <2d7f72d3e89686d3ba5cff5df8cfe443d04fc5f4.camel@microchip.com>
 <87o7xp3pz2.wl-maz@kernel.org>
 <a50d0f6e-0b35-4090-2ba6-9de680d23aa2@microchip.com>
 <87v8rvzsfc.wl-maz@kernel.org>
In-Reply-To: <87v8rvzsfc.wl-maz@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b96548-63f4-4ac0-1bc1-08da680b8b5c
x-ms-traffictypediagnostic: SJ0PR11MB6573:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3iH3yvDhS+lBgNZhWComvfJMuDzUvwbllspE47CUCX6u0b+619q7IRoK/yK3/bLQcZ6GtrUC8t0WWq0ognxCLnoI5LrrVPvYXcyD5oRzXWbneJTVBqQ7Omh0kDtlEz+aM6nGgULSJc0lTw3NC0o5YiG23z9q/Q+9b8lajXjsFQAnpnhHrpVOBASfzDvL8HFFytnJFDFtCrDiq15pWplgngXpdJPyY5SJ7AVccsYsC6P2O+WzX6iANHyvCPwQf9OiJF+JHe8qyzZoyCml1ba3ov4Hci8jM0tIsCE/iwbc4bTJyuYCl41o0xREwb+AHueCPribYRCwBJ0dox5eWQifVj4ZjfTKeEInV2AA5nWjTaq8/cwd0J4TBOfqkKrQd1wn69UJm8e/cD+J6FW7dtejHv5G+qHJFIKRnu33TMd/+fCEhqWOjbmsa/2BVLHLjq479EMQL13jm+u8rSfvHgD+rTS9QJJ99z4pKAT50GnHO0Z2EcSCCHxjJyArRO5LANFPDKye3fAtt0wC/zqoJpzmaD2+DKg9ysWTy+GgwQ+j91o8QDyXSoVzdwmp5Knpu2zs0aopJ2yHuOJIzIiHQHh67qRQFYWoo3XW+cLiBrYK8HEP4J4JTHHi9801UfiiGMT6Oz8Qkff6ps0DJtZ09rj7n5YC2UXYpWDII8yuHRo94OlDt+gygl0Fu6351zS7LcgnxuhkueW1uAlNBWKKlmtQy592kbs/Iq9qxcR8W/POWTJF7PVe/r/sziVHd4qnixeHGP85xBirJGrDXobbX0MPIvZ9dWulhRnWr9AZGomLQko2mwGLbzp1VfGV9CPPJ4PKmAHb4/3Ysg+7Ywexjpo6fs4o1NOmyyAF59A7JC/pCrmzJLwc0U86OWnkGYtAC/tySL4CN4KugBMSXzpj73M+f+gAi0xT1cdpwOy3sh/yFFa32jrCySvbhZriO45+VXk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39850400004)(366004)(396003)(346002)(2906002)(91956017)(53546011)(66556008)(41300700001)(64756008)(8676002)(71200400001)(38100700002)(4326008)(66946007)(38070700005)(6512007)(6506007)(122000001)(6486002)(110136005)(107886003)(316002)(76116006)(36756003)(66446008)(966005)(31696002)(31686004)(8936002)(478600001)(186003)(26005)(66476007)(2616005)(83380400001)(5660300002)(54906003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVNraEJOK1h2NlBjRlNXVW1OdDRJaEIrSW41cURXOTgydG1WdTI5UW1Scksr?=
 =?utf-8?B?U0hCL1A5U3dadWZsSkMxdXczVlZ5MUJZd3k0OGx6b3hVL0Z5ZExrVjhaRFpw?=
 =?utf-8?B?c3NQOGhnN0oyMURTWlNLL2dHbi9QZHR1YzdBWkU0SGRWUGhIb3lHd3ovd0dt?=
 =?utf-8?B?QmhUbHlYL3pXcjZvcE45SEVMcVM1d1lOOSs0T0pPYkhMZEw2MGdMaGNHU20x?=
 =?utf-8?B?dm5iSU5XNGdDTWFTZGhuamd2T1NpTnR5UE0xUHBDWERlMnB5Y0hEeTFkNE5q?=
 =?utf-8?B?NjgwSytoV0oxUTdvSCs5UHpGTGZKcyt2Rkd5UVhHL3l3RGp1U0syMGZLV3NR?=
 =?utf-8?B?VVJnYVptazEzSmhWTWlIUjc3TkV6UzJpWTRyQjI1YmxzbWpxRGhFMlcxMGh6?=
 =?utf-8?B?bVpMaWlsTHJ3V09jTEZWc1htUFJyeGtPRUNkbThMNEhDcnNPWHJhdWNJZmJv?=
 =?utf-8?B?QTdKS1pxYU9STFU2WG94cWNOZ1RPenBiYldQbXFibDFmVlJGVlNaaVdYb2l2?=
 =?utf-8?B?Y1VmajA1aHFBSEcyalE5U2FHWUQzY1BnNnFYdUpmUHJzL1d3cEhNSlN5KzYy?=
 =?utf-8?B?Sk5RRGwwMG82V3VTbzkraEtocTVBV1BJVlNaalRuS2lRNFVUZEtSc1VQSFFF?=
 =?utf-8?B?V3R4cWQ3Q1E1QWJxeTdTTmRLZndPY2hOV1NJWitiWTJjcjR3TUpoQUxjVWhx?=
 =?utf-8?B?WFFEOWpNbUREOGJrRVNTVmQzY0pkYmVHTmdWdzZrK3o3N21MbW9PUEFTUitV?=
 =?utf-8?B?N0ZyRWE2aWZ6RlZpb1p2U1pPY0VrMXlpRGJzUmplZ0xteTUxY0tnVzZTQTJp?=
 =?utf-8?B?RU1pN0VPN0JtQk5aQ2lsMUdsQy9abWtRQXorcUhnKzZHcTAwUGR5L3VtVTk3?=
 =?utf-8?B?SWhySVlYMHRjNUNmMWRXRDcveGU2dVV3SnFkMnp0aEYrWE5YWnc0QXpUT0FQ?=
 =?utf-8?B?MmJ2RURIUVNwb0VpaU1GYXdQQ1FQRHJtWWpVaENIYzRHcXZneE5hdlkvYXVU?=
 =?utf-8?B?S0VrakVqcE9NdC84ZGErZ1p2eFV2MW1iS0svdGQ0WW9jMlQzNUJZTmJpQ2N6?=
 =?utf-8?B?SHNHT0pTQzFzeElpQTBvMVdWV1o4ODh5MmJYbnNCRFNWOWJ2YnVDdFc2VVg1?=
 =?utf-8?B?V0hwa0hxQjFPanQ3ZVIzdmJXcnlwNmpTWmF4MUNxWlVsSGlTOXQ4UXgycDhl?=
 =?utf-8?B?YWt5M2hRN0VveU1hTzFSa1NockdPK08xWTFnbWQzOG1pa3h4dFIweFBuRlRU?=
 =?utf-8?B?S1BxQmRLSlh2NVBCNTJ0OHUzRHphR0g5eTA2d0FNSGZBVWFXd1JmelRNU0c4?=
 =?utf-8?B?K0ZuZ0x6LzB6WnBvYytPWEh3U29ndmNiNEFQeUhjVWk2VFpCVDBSa2tVZXZv?=
 =?utf-8?B?dGNiZjdWcW1zdEc1Ny9rU0VCOTZCdWlRbzBvQmZQOVZjWU04MVpmNTB5Nlps?=
 =?utf-8?B?WFJYb0d5UVJ1UVlsU0h3aHNGWDRsUlpPMUVCSWRGWm5sbkxFRVFFdVNJZ1lZ?=
 =?utf-8?B?NEd6R0RJZEs5dkxzd2grSkVlWC9MUjQvTk9JTm5PQTlsNEZIREVldzc2WTVX?=
 =?utf-8?B?bHZ6OGJqN3ByakdySWVBOHdjbzdSc3lkYkJNV1RoU1I4WjdtNEFXc1Y2UkRa?=
 =?utf-8?B?RlplMWxIVlZpV0lrVWZHb0tVVzlHMURHVkx0QkY1dEFNWk0vU2tkZWo4UHlx?=
 =?utf-8?B?ekNCbTZjd3pIQUtqdW5XUlpiaEt2NEU4MHRSZVQyNEhLNzBMTHFiQXV4VGxm?=
 =?utf-8?B?T21HUWNla3FkVVVkbE80ZGZiZWdYb1JBZjFDV2Y2aUFmZS9rdm5tUmdMOVA5?=
 =?utf-8?B?VFBETTR6UGNpU3REOTdiVWgva0dZNE5neDUySzBPSkJaVkh6aXh4TXh4aysr?=
 =?utf-8?B?TGM2Z0ZoL3JkMlBtM0FtQzJOS3A2QjlFY0lDUDlZaThITWd5a0pZUGZDaFhJ?=
 =?utf-8?B?aDRsTUNXU1hvRFk2WmFLaTlkUWNiQ2Fxb0VaazFBd2N1d0FHRUJwSFNrbUtx?=
 =?utf-8?B?cE9qL2VhbWtTY1B3djU0a09HU2t5RUoybmtRQ2lLdHFBNk1WcGJXZkFzZXFt?=
 =?utf-8?B?L0RDTHI3dVBsbHpuSlBjQ1E1S1A3SUJ5d25QaDdvSGRrQU9oOExiYjAxYnRT?=
 =?utf-8?Q?Qepp3wyxn1SOrx+ZWSbgkU6ce?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1855194603AD94DB67EEA4AAB64BAFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b96548-63f4-4ac0-1bc1-08da680b8b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 15:46:41.8032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hb16HYAGeIA6AD3lFi/UfHyayGc9jPjLhPi/9cHUqeNp0DBWH1ccU5Ik4VHHbukrwGEXhbggekKFbZfeJ+IlaM+wxtRBL90umN36bX6/BWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6573
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTcvMDcvMjAyMiAxNjoxMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0KPiBPbiBTYXQsIDE2IEp1
bCAyMDIyIDE5OjMyOjIwICswMTAwLA0KPiA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IHdy
b3RlOg0KPj4NCj4+IE9uIDE2LzA3LzIwMjIgMTg6NTIsIE1hcmMgWnluZ2llciB3cm90ZToNCj4+
PiBPbiBTYXQsIDE2IEp1bCAyMDIyIDE2OjIxOjQ4ICswMTAwLA0KPj4+IDxMZXdpcy5IYW5seUBt
aWNyb2NoaXAuY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gVGhhbmtzIE1hcmMsDQo+Pj4+DQo+Pj4+
IE9uIFNhdCwgMjAyMi0wNy0xNiBhdCAxMTozMyArMDEwMCwgTWFyYyBaeW5naWVyIHdyb3RlOg0K
Pj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+Pj4NCj4+
Pj4+IE9uIFNhdCwgMTYgSnVsIDIwMjIgMDg6MTE6MTMgKzAxMDAsDQo+Pj4+PiA8bGV3aXMuaGFu
bHlAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gRnJvbTogTGV3aXMgSGFubHkgPGxld2lz
Lmhhbmx5QG1pY3JvY2hpcC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBBZGQgYSBkcml2ZXIgdG8gc3Vw
cG9ydCB0aGUgUG9sYXJmaXJlIFNvQyBncGlvIGNvbnRyb2xsZXIuDQo+Pj4+Pj4NCj4+Pj4+PiBT
aWduZWQtb2ZmLWJ5OiBMZXdpcyBIYW5seSA8bGV3aXMuaGFubHlAbWljcm9jaGlwLmNvbT4NCj4+
Pj4+DQo+Pj4+PiBbLi4uXQ0KPj4+Pj4NCj4+Pj4+PiArc3RhdGljIGludCBtcGZzX2dwaW9fY2hp
bGRfdG9fcGFyZW50X2h3aXJxKHN0cnVjdCBncGlvX2NoaXAgKmdjLA0KPj4+Pj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNoaWxkLA0KPj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50
IGNoaWxkX3R5cGUsDQo+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgKnBhcmVudCwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCAqcGFyZW50X3R5cGUpDQo+Pj4+Pj4gK3sN
Cj4+Pj4+PiArICAgICBzdHJ1Y3QgbXBmc19ncGlvX2NoaXAgKm1wZnNfZ3BpbyA9IGdwaW9jaGlw
X2dldF9kYXRhKGdjKTsNCj4+Pj4+PiArICAgICBzdHJ1Y3QgaXJxX2RhdGEgKmQgPSBpcnFfZ2V0
X2lycV9kYXRhKG1wZnNfZ3Bpby0NCj4+Pj4+Pj4gaXJxX251bWJlcltjaGlsZF0pOw0KPj4+Pj4N
Cj4+Pj4+IFRoaXMgbG9va3MgdG90YWxseSB3cm9uZy4gSXQgbWVhbnMgdGhhdCB5b3UgaGF2ZSBh
bHJlYWR5IGluc3RhbnRpYXRlZA0KPj4+Pj4gcGFydCBvZiB0aGUgaGllcmFyY2h5LCBhbmQgaXQg
aXMgbGlrZWx5IHRoYXQgeW91IHdpbGwgZ2V0IG11bHRpcGxlDQo+Pj4+PiBoaWVyYXJjaHkgc2hh
cmluZyBzb21lIGxldmVscywgd2hpY2ggaXNuJ3QgaW50ZW5kZWQuDQo+Pj4+DQo+Pj4+IFNvbWUg
YmFja2dyb3VuZCB3aHkgSSB1c2UgdGhlIGFib3ZlLg0KPj4+PiBXZSBuZWVkIHRvIHN1cHBvcnQg
Ym90aCBkaXJlY3QgYW5kIG5vbi1kaXJlY3QgSVJRIGNvbm5lY3Rpb25zIHRvIHRoZQ0KPj4+PiBQ
TElDLiANCj4+Pj4gSW4gZGlyZWN0IG1vZGUgdGhlIEdQSU8gSVJRJ3MgYXJlIGNvbm5lY3RlZCBk
aXJlY3RseSB0byB0aGUgUExJQyBhbmQNCj4+Pj4gY2VydGFpbmx5IG5vIG5lZWQgZm9yIHRoZSBh
Ym92ZS4gR1BJTydzIGNhbiBhbHNvIGJlIGNvbmZpZ3VyZWQgaW4gbm9uLQ0KPj4+PiBkaXJlY3Qs
IHdoaWNoIG1lYW5zIHRoZXkgdXNlIGEgc2hhcmVkIElSUSwgaGVuY2UgdGhlIGFib3ZlLg0KPj4+
DQo+Pj4gVGhhdCdzIHVuZm9ydHVuYXRlbHkgbm90IGFjY2VwdGFibGUuIFlvdSBuZWVkIHRvIGRp
c3Rpbmd1aXNoIHdoaWNoIG9uZQ0KPj4+IGlzIHdoaWNoLCBhbmQgc2VwYXJhdGUgdGhlbS4gWW91
ciBub24tZGlyZWN0IG1vZGUgY2VydGFpbmx5IHJlcXVpcmVzDQo+Pj4gc3BlY2lhbCBoYW5kbGlu
ZywgYW5kIGlzIG5vdCBmaXQgZm9yIGEgaGllcmFyY2hpY2FsIG1vZGUuDQo+Pg0KPj4gVW5mb3J0
dW5hdGVseSwgdGhlIGNvbmZpZ3VyYXRpb24gaXMgbm90IGZpeGVkIG9uIHRoZSBzaWxpY29uIGxl
dmVsLiBUaGUNCj4+IFNvQyBoYXMgMyBHUElPcyAod2l0aCAzMiBsaW5lcyBlYWNoKS4gVGhlIGlu
dGVycnVwdCBjb25maWd1cmF0aW9uIGxvb2tzDQo+IA0KPiBMZXQncyBzdGFydCB3aXRoIGEgYml0
IG9mIHRlcm1pbm9sb2d5IHNvIHRoYXQgd2UgY2FuIHVuZGVyc3RhbmQgZWFjaA0KPiBvdGhlcjoN
Cj4gLSBHUElPOiBhIHNpbmdsZSBwaWVjZSBvZiB3aXJlDQo+IC0gR1BJTyBibG9jazogYSBzZXQg
b2Ygd2lyZXMgd2l0aCBhIGNvbW1vbiBwcm9ncmFtbWluZyBpbnRlcmZhY2UNCj4gDQo+IEFzIEkg
dW5kZXJzdGFuZCBpdCwgeW91IGhhdmUgMyBHUElPIGJsb2NrcywgZWFjaCB3aXRoIDMyIEdQSU9z
LCBmb3IgYQ0KPiB0b3RhbCBvZiA5NiBleHRlcm5hbCBsaW5lcy4gQ29ycmVjdD8NCg0KQ29ycmVj
dC4NCg0KPiANCj4+IHNvbWV0aGluZyBsaWtlIHRoZSBiZWxvdzoNCj4+IEdQSU8jICAgICAgICAg
ICAgIHdpZHRoICAgIElSUSMNCj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4+IGdwaW8wLzIgICAgICAgICAgIDE0ICAgICAgIFsyNjoxM10NCj4+IGdwaW8xLzIgICAgICAg
ICAgIDI0ICAgICAgIFs1MDoyN10NCj4+IGdwaW8wX25vbl9kaXJlY3QgIDEgICAgICAgICA1MQ0K
Pj4gZ3BpbzFfbm9uX2RpcmVjdCAgMSAgICAgICAgIDUyDQo+PiBncGlvMl9ub25fZGlyZWN0ICAx
ICAgICAgICAgNTMNCj4+DQo+PiBEZXBlbmRpbmcgb24gd2hhdCB0aGUgYm9vdGxvYWRlci9maXJt
d2FyZSBkb2VzLCB0aGVzZSBjYW4gYmUgY29uZmlndXJlZA0KPj4gZGlmZmVyZW50bHkgKGRvbmUg
cHJpb3IgdG8gbGludXggc3RhcnRpbmcpLiBCeSBkZWZhdWx0LCAxNCBHUElPcyBmcm9tDQo+PiBH
UElPMCBhcmUgZmVkIGludG8gdGhlaXIgb3duIGludGVycnVwdCBsaW5lcyAmIGRpdHRvIGZvciAy
NCBmcm9tIEdQSU8xLg0KPj4gVGhlIHJlbWFpbmluZyBHUElPMCAmIEdQSU8xIGxpbmVzIGdvIGlu
dG8gdGhlIGNvcnJlc3BvbmRpbmcgbm9uLWRpcmVjdA0KPj4gaW50ZXJydXB0LiBJZiB0aGV5IGJv
b3Rsb2FkZXIvZmlybXdhcmUgY29uZmlndXJlcyBzb21ldGhpbmcgZGlmZmVyZW50LA0KPj4gYSAi
ZGlyZWN0IiBpbnRlcnJ1cHQgbGluZSBjYW4gYmUgc3dpdGNoZWQgdG8gYSBHUElPMiBsaW5lIGlu
c3RlYWQuDQo+IA0KPiBXaGF0IGRvZXMgbm9uLWRpcmVjdCBtZWFuPyBNdWx0aXBsZXhpbmcgaW5w
dXRzIGludG8gYSBzaW5nbGUgb3V0cHV0Pw0KDQpub24tZGlyZWN0IGJlaW5nICJub3QgZGlyZWN0
bHkgY29ubmVjdGVkIHRvIHRoZSBQTElDIiwgc28geWVzLiBUaGUNCmludGVycnVwdHMgd2l0aG91
dCBhIGRpcmVjdCBjb25uZWN0aW9uIGFyZSBtdXhlZCBpbnRvIGEgcGVyIEdQSU8gYmxvY2sNCmlu
dGVycnVwdC4NCg0KPiBDYW4geW91IGluZGl2aWR1YWxseSBtYXNrL3VubWFzayB0aGUgaW5wdXQg
bGluZXMgdGhhdCBhcmUgaW4gdGhpcyBtb2RlDQo+ICh0aGUga2VybmVsIGNhbGxzIHRoaXMgYSAi
Y2hhaW5lZCBpcnFjaGlwIik/DQoNCkVhY2ggR1BJTyBsaW5lIGhhcyBhbiBpbnRlcnJ1cHQgZW5h
YmxlIGJpdCBpbiBpdCdzIGNvbmZpZyByZWdpc3Rlci4NCg0KPiANCj4gSG93IGRvZXMgdGhpcyBz
d2l0Y2ggYmV0d2VlbiBkaXJlY3QgYW5kIG5vbi1kaXJlY3QgaGFwcGVuPyBEbyB5b3UgaGF2ZQ0K
PiBzb21lIHNvcnQgb2YgZXh0ZXJuYWwgcGFkIHRvIEdQSU8gbGluZSByb3V0aW5nPyBJdCB3b3Vs
ZCByZWFsbHkgaGVscA0KPiBpZiB5b3UgY291bGQgcG9pbnQgcGVvcGxlIGF0IGFuIGFjdHVhbCBz
cGVjaWZpY2F0aW9uIGZvciB0aGVzZSBibG9ja3MNCj4gcmF0aGVyIHRoYW4gcGFyYXBocmFzaW5n
IHRoaW5ncy4NCg0KR1BJTyBpcyBkaXNjdXNzZWQgb24gcGFnZSA4NSBvZiB0aGUgVFJNOg0KaHR0
cHM6Ly93d3cubWljcm9zZW1pLmNvbS9kb2N1bWVudC1wb3J0YWwvZG9jX2Rvd25sb2FkLzEyNDU3
MjUtcG9sYXJmaXJlLXNvYy1mcGdhLW1zcy10ZWNobmljYWwtcmVmZXJlbmNlLW1hbnVhbA0KDQpU
aGUgcmVnaXN0ZXIgbWFwIGlzIGhlcmU6DQpodHRwczovL3d3MS5taWNyb2NoaXAuY29tL2Rvd25s
b2Fkcy9hZW1Eb2N1bWVudHMvZG9jdW1lbnRzL0ZQR0EvUHJvZHVjdERvY3VtZW50cy9TdXBwb3J0
aW5nQ29sbGF0ZXJhbC9WMV80X1JlZ2lzdGVyX01hcC56aXANCg0KUEZTT0NfTVNTX1RPUF9TWVNS
RUcvR1BJT19JTlRFUlJVUFRfRkFCX0NSIGlzIHRoZSByZWdpc3RlciB0aGF0IGNhbg0Kc3dpdGNo
IGEgbGluZSBiZXR3ZWVuIGRpcmVjdC9ub24tZGlyZWN0IG1vZGUuDQoNCkdQSU9fKl9MTyBhcmUg
YXMgeW91IG1pZ2h0IGV4cGVjdCBhcmUgdGhlIEdQSU8gYmxvY2sgcmVnaXN0ZXJzDQoNCg0KPiAN
Cj4+DQo+PiBTb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nICh0aGUgaW50ZXJydXB0cyBhcmUg
b2Zmc2V0IGJ5IDEzIGhlcmUsIGFzDQo+PiB0aGUgZ2xvYmFsIGludGVycnVwdHMgZmVlZCBpbnRv
IHRoZSBQTElDIGF0IGFuIG9mZnNldCk6DQo+Pg0KPj4gKiBnbG9iYWwgaW50ICBHUElPX0lOVEVS
UlVQVF9GQUJfQ1INCj4+ICAgICAgICAgICAgICAgICAwICAgICAgICAgICAgICAgMQ0KPj4gICAg
IDAgICAgICAgR1BJTzAgYml0IDAgICAgIEdQSU8yIGJpdCAwDQo+PiAgICAgMSAgICAgICBHUElP
MCBiaXQgMSAgICAgR1BJTzIgYml0IDENCj4+ICAgICAuDQo+PiAgICAgLg0KPj4gICAgIDEyICAg
ICAgR1BJTzAgYml0IDEyICAgIEdQSU8yIGJpdCAxMg0KPj4gICAgIDEzICAgICAgR1BJTzAgYml0
IDEzICAgIEdQSU8yIGJpdCAxMw0KPj4gICAgIDE0ICAgICAgR1BJTzEgYml0IDAgICAgIEdQSU8y
IGJpdCAxNA0KPj4gICAgIDE1ICAgICAgR1BJTzEgYml0IDEgICAgIEdQSU8yIGJpdCAxNQ0KPj4g
ICAgIC4NCj4+ICAgICAuDQo+PiAgICAgLg0KPj4gICAgIDMwICAgICAgR1BJTzEgYml0IDE2ICAg
IEdQSU8yIGJpdCAzMA0KPj4gICAgIDMxICAgICAgR1BJTzEgYml0IDE3ICAgIEdQSU8yIGJpdCAz
MQ0KPj4gICAgIDMyICAgICAgICAgIEdQSU8xIGJpdCAxOA0KPj4gICAgIDMzICAgICAgICAgIEdQ
SU8xIGJpdCAxOQ0KPj4gICAgIDM0ICAgICAgICAgIEdQSU8xIGJpdCAyMA0KPj4gICAgIDM1ICAg
ICAgICAgIEdQSU8xIGJpdCAyMQ0KPj4gICAgIDM2ICAgICAgICAgIEdQSU8xIGJpdCAyMg0KPj4g
ICAgIDM3ICAgICAgICAgIEdQSU8xIGJpdCAyMw0KPj4gICAgIDM4ICBPciBvZiBhbGwgR1BJTzAg
aW50ZXJydXB0cyB3aG8gZG8gbm90IGhhdmUgYSBkaXJlY3QgY29ubmVjdGlvbiBlbmFibGVkDQo+
PiAgICAgMzkgIE9yIG9mIGFsbCBHUElPMSBpbnRlcnJ1cHRzIHdobyBkbyBub3QgaGF2ZSBhIGRp
cmVjdCBjb25uZWN0aW9uIGVuYWJsZWQNCj4+ICAgICA0MCAgT3Igb2YgYWxsIEdQSU8yIGludGVy
cnVwdHMgd2hvIGRvIG5vdCBoYXZlIGEgZGlyZWN0IGNvbm5lY3Rpb24gZW5hYmxlZA0KPj4NCj4+
IFNpbmNlIHdlIGNhbiB0ZWxsIGJhc2VkIG9uIHRoZSBpbnRlcnJ1cHQgbnVtYmVyIGluIHRoZSBk
ZXZpY2UgdHJlZQ0KPj4gd2hldGhlciBhIGxpbmUgaXMgaW4gZGlyZWN0IG1vZGUgLSBjYW4geW91
IHN1Z2dlc3Qgd2hhdCB0aGUgbW9zdCANCj4+IGFwcHJvcHJpYXRlIGlycSBzdHJ1Y3R1cmUgZm9y
IHRoZSBkcml2ZXI/DQo+IA0KPiBUaGUgdG9wb2xvZ3kgbXVzdCBiZSBkZXNjcmliZWQgaW4gRFQg
b25lIHdheSBvciBhbm90aGVyLCBhbmQgSSBkb24ndA0KPiByZWFsbHkgd2FudCB0byByZWx5IG9u
IGEgZml4ZWQgaW50ZXJydXB0IG51bWJlciB0aGF0IHdpbGwgY2hhbmdlIGZyb20NCj4gb25lIHZl
cnNpb24gdG8gYW5vdGhlci4NCg0KWWVhaCwgdGhhdCB3YXMgbXkgZ3V0IGZlZWxpbmcgdG9vLg0K
DQo+IA0KPiBJbiBhbnkgY2FzZToNCj4gDQo+IC0gZGlyZWN0IGludGVycnVwdHMgc2hvdWxkIGJl
IGhhbmRsZWQgYXMgYSBoaWVyYXJjaHksIG1vc3RseSBsaWtlIHRoZQ0KPiAgIGNvZGUgY3VycmVu
dGx5IGRvZXMsIGJ1dCBkZWZpbml0ZWx5IHdpdGhvdXQgdGhlIHByb2JpbmcgaGFjay4NCj4gDQo+
IC0gbXV4ZWQgaW50ZXJydXB0cyAobm9uLWRpcmVjdD8pIHNob3VsZCBiZSBoYW5kbGVkIHZpYSBh
IGNoYWluZWQNCj4gICBpcnFjaGlwLCB1c2luZyBhIGRpZmZlcmVudCBpcnFkb21haW4sIGFzIHRo
ZSB0b3BvbG9neSBpcyByYWRpY2FsbHkNCj4gICBkaWZmZXJlbnQuDQoNClRoYW5rcy4NCg0KPiAN
Cj4+IEFsdGhvdWdoIGZvciBleHRlbmRpbmcgdGhpcyBkcml2ZXIgdG8gdGhlICJzb2Z0IiBJUCBj
b3JlLCBpdCBtYXkgYmUgZWFzaWVyDQo+PiB0byBqdXN0IGNyZWF0ZSBhICJtaWNyb2NoaXAsZ3Bp
by1kaXJlY3QtbW9kZS1tYXNrIiBwcm9wZXJ0eSBvciBzaW1pbGFyIGFuZA0KPj4gdXNlIHRoYXQg
dG8gZmlndXJlIG91dCB3aGF0IGNvbmZpZ3VyYXRpb24gYSBsaW5lIGlzIGluLg0KPiANCj4gTXkg
Z3V0cyBmZWVsaW5nIGlzIHRoYXQgdGhpcyB3aWxsIGV2ZW50dWFsbHkgZW5kLXVwIGJpdGluZyB5
b3UsIGFzDQo+IHBlb3BsZSB3aWxsIHdhbnQgdG8gY2hhbmdlIHRoZSBkaXJlY3Qvbm9uLWRpcmVj
dCBzdGF0dXMgb2YgYW4NCj4gaW50ZXJydXB0IGF0IGJvb3QgdGltZSwgd2l0aG91dCBkZXBlbmRp
bmcgb24gdGhlIEZXIHRvIGRvIHRoYXQgb24NCj4gdGhlaXIgYmVoYWxmLg0KDQpJIGFtIGluY2xp
bmVkIHRvIG5vdCBhbGxvdyB0aGF0IGluIGFsbCBob25lc3R5LiBCZWNhdXNlIHRoaXMgaXMgYW4g
RlBHQSwNCnRoZXJlJ3MgY29uZmlndXJhdGlvbiBiYXNlZCBvbiB0aGUgY29udGVudHMgb2YgdGhl
IEZQR0EgZmFicmljIHRoYXQgaGFzDQp0byBiZSBkb25lIGJ5IHNvbWV0aGluZyBiZWZvcmUgYW4g
T1MgY2FuIGJlIGJyb3VnaHQgdXAgJiB3ZSBoYXZlIHRvIGRyYXcNCmEgbGluZSBzb21ld2hlcmUg
Zm9yIHdoYXQncyByZWFzb25hYmxlIGZvciBMaW51eCB0byBkby4NCg0KPiANCj4gSW4gYW55IGNh
c2UsIHRoaXMgZHJpdmVyIG5lZWRzIHNvbWUgc2VyaW91cyByZXdyaXRpbmcuDQoNClRoYW5rcyBm
b3IgeW91ciBoZWxwIE1hcmMuDQo=
