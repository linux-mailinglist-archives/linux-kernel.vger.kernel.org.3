Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED73F5787F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiGRQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiGRQ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:58:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A752BB15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658163502; x=1689699502;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RCwbr2BbQokkWDr4KHfYnxB2vrL1wsEIixFC8E9p7vY=;
  b=W7I16tfA9JeJDUQKVBj0TR1YIZlEV1lGXCdSUllpqVb5waHXaDYf7moo
   K3WiihtC792ArZIQYBkaZLJRrqyZONEGvDG9L+DspH4XFeGS3CPdCUI3l
   rDZk3OqaEHYWGA7atokW9FmqITt8lP6wXFsPGYQLwS5BLswsffNHibrYr
   yAcxFroj5ju7SqL+M9fnwhrJwRG28Q/gHc1jFfITC5X8Btt6SGJHi/P1J
   5GNzi23z1pHwVnicMU4B7dlcIk9iINIciq5YHiVx2NlwNP5zbwJr18N+4
   ZihGKGv/LkNcqTjjE3M2jKVrgRvoMqtMuDr5fwl5GSZVYh6wbNfsXqh05
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="168350937"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 09:58:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 09:58:15 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 09:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgQctPSqOZK6rr2+gJJNShHaKAvYcbHkv+1wUeYcDTZr/Uy+i6KBj5eOBoZcIbgSyeLfvbwe0CRa8UQtTLcFeoTYzmNnNKLUJvQVrQt1y+yI0qekA5ghcpbfiCy/3cdE9pQhu+ByJ3O8fH5Dq6TIPyzKftj5cr014gBESQ9KRgEmvMc+vkYAt+ctgadOB1PJGd9CybKtxC15r1EBD82r/UvzXwys0QXLPHiCCeELtIrLvg8Rr16tDdxl/y7U2F5frhCvUfL1pLMcbwxtxKxu45FgrXm9lOmftmISnzNX7xICSfF7aUJ+t9xrVEKmchPvE+GWGIb4DiByR0KC5sdfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCwbr2BbQokkWDr4KHfYnxB2vrL1wsEIixFC8E9p7vY=;
 b=ANv4WI5ZCOuC2o0Dn7tt1TaSWfULm3eXdVH2VDW7NQSZvRd8X9u7RHVmMhftv+4y4ZAcXuJ+FXCJ5z0t/hPPyy75omPxRmZd9Frp2BpY9jHMRGyLdU3d8aAnSldGI//K4SV5hgaiQXpkCJF3Z7IMDJh/ccDkoU2oJYohZdJE4oW/M4Mn2h35T/wJ6aZnOFYl487Zfo2C9CjE/ZLYsR45MeROeIyVxAvPCh3DIla8IkJmeNUuACtjvYuID5tEqrsvWEGa4WJrd6EPLmzjJc9ImRsf2kJG2o8X014fss3oL5nqPPIiV7FU45Osd+kIBRWbq5xquxWdpasL+qso+HqGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCwbr2BbQokkWDr4KHfYnxB2vrL1wsEIixFC8E9p7vY=;
 b=LA8bH0gYE8HlSJzM/Gi2flKoHE2QXcvTB3Ll7tq3TvCaYFz9L/Zzl47T33BptGs/WTeQ7id2ncNgDmXSFr6D3+vpDO2mybC5vgnV+A+qm7HK1D/UifE74GZ81GGnkX6hdpGRxPV/D7vTgsD5BIl1LMw72jhYt32o0AWD4xbk8xs=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SN6PR11MB3373.namprd11.prod.outlook.com (2603:10b6:805:c6::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.23; Mon, 18 Jul 2022 16:58:09 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 16:58:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <sudip.mukherjee@sifive.com>, <p.yadav@ti.com>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <greentime.hu@sifive.com>, <jude.onyenegecha@sifive.com>,
        <william.salmon@sifive.com>, <adnan.chowdhury@sifive.com>,
        <ben.dooks@sifive.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: extend no_sfdp_flags to use u16
Thread-Topic: [PATCH 1/3] mtd: spi-nor: extend no_sfdp_flags to use u16
Thread-Index: AQHYmsePzRkwROJ3Fkqot+zf8xcldA==
Date:   Mon, 18 Jul 2022 16:58:09 +0000
Message-ID: <d3903d95-d76f-b9cd-b927-d175afab31a7@microchip.com>
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-2-sudip.mukherjee@sifive.com>
In-Reply-To: <20220712163823.428126-2-sudip.mukherjee@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1731c295-5359-4b33-4689-08da68deb190
x-ms-traffictypediagnostic: SN6PR11MB3373:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhZyw0FVnRqiV3SVJG8bECZV+H6DpKJoGD7Z+NSpeiXrrvyGIsFUcoPanNccQ4kQmHFt8UXzjyAWTylJFsq1ALOPjDFklK64GVwaZ/dqfru7WxAJAePugR5LTWBL6VS4Rc5bzUDbKuArQCd++vR1/0fw2Di6ckplhsiMCYw6Cfrve3EIxTKoYHyPd0etfs0CnFQo1T2OjM1fwsKkUmKKywNotHPG1MzIotouln7RmimeThE9ugVINAwrUnA0z53ObCeQ39UiRM3ilHTXG/YNgAmPQJ86GRXYB64d6ib3mQhwCuP3wKbTHKkgmyA4Cj/glNMV5MnACwprZKWJjdR08UfCliluYJSB9/2iykBj7x5VzhdgArdGhgz/IcelvoI874mF300NjpF9oG7ziR9iJXISIs1yQGjOPc0kzSTDlbSX7zJ3NO/iSZXuU+eOOpyOz3wycgY9p1lW/ceiBmrPKHacYnfNpkvlcRGgWgeHoEtuefIzd2C9noNxUst4UycqshEyPltBti/+yQXaFhg193qzcpnPNvS3qkql0StroNcew2ZCahpdkjtHjdXCHnPd7XV6ASldk4cmMKMHLuLjyfHjBtAPnrPY3SnOhycIHywEMRMHnmGTLPEPHBOFo33Jwd6k9qOKu89mXqWtI0EbWL6dgNyj+xvbieW1PiAb9Kg764N+Ov4EZkubqMs+GFG/7MORcQDffHu8nwNhNNNvQ0PadQtByLKICmA/IjHb+6D0We2fYbqy0CZICDZIspaWptPa8ddBWn5GGUeIehAfhkfBAxDkW0ar9RdiCkgxBeKCXRHaCEH4hUFEgAlOVYcfPzXyL7SCflRz58QyyJcEqN0Z8A6v1SIPdEgWnHFen+Q9TJ6nypD8gwTDHfTDbPDH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(366004)(39860400002)(122000001)(31686004)(36756003)(316002)(38070700005)(83380400001)(186003)(38100700002)(478600001)(66946007)(7416002)(5660300002)(4326008)(76116006)(91956017)(2616005)(71200400001)(66556008)(66476007)(2906002)(41300700001)(66446008)(64756008)(8676002)(6512007)(26005)(966005)(6486002)(6506007)(86362001)(31696002)(53546011)(54906003)(8936002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2tmSitMMTZLMms3b3NMOGtMbUw4WFdCRkRlVFNMOUxUS1Z5aFoyUVdCbzN6?=
 =?utf-8?B?cjVWVk1aYktneFlMVVZvMGtWY3dKeW1OYXpOM3pHMjdQcUJnSmtlZEFJZ1Zi?=
 =?utf-8?B?M0l1QnlXbUdjR0VxUU5EZmJDWHQ4cmtUN0FnaTd2NGdOU3p3MTJkbHNqb3g0?=
 =?utf-8?B?QTBTdENuQ0xCUVBBbndnOVpZRlI4RWlDVGo2bGp5emQ2ak85Tjk3SjV0WFhs?=
 =?utf-8?B?YUlrVFNEVDdVVHgvanFsd2dWeHA5WURGQzRQUjlsd3dONEpzQ21vUmQ1cFRu?=
 =?utf-8?B?dWVKNXRTZFRYazlFS2VUeEFjUkxWVjc2eXRYbDA3NUxyWkJvUjgvM3VqRlM2?=
 =?utf-8?B?NUFhRElybVZDbTk2eUQ5b2xrS3RTZG1LV1NKM3lOc0tJR3NrQXdweVhLL2lT?=
 =?utf-8?B?RW1zY2xiQzVkckorcXVqVWphMnZWSUttcnRJNit5UHJrZURHYXFzTDUzbTFx?=
 =?utf-8?B?bHFTOFZheEJmSW9LL1dBS3JkaFJqV2N1dVdVdHFTNHZTSVcvQXBmdFhvZTVR?=
 =?utf-8?B?VjhuMHFJc0pRS25VaDJSZTB2a3p1eVNhK2EwQWZsTldPMU5pYnVaUm5zN29Y?=
 =?utf-8?B?VTk3N0JMaTBvaldSMkxKVS9lNnJnT1hzWmtKay9sRXVKRU1IS2ZSaWZyTFcw?=
 =?utf-8?B?Z3dSRWppckZIZm1BNStRL0xDNmVhemtWZElZY29DbGVIb3krdnZTZUx4Zmdp?=
 =?utf-8?B?ZnZ2SGlBRHI3b3huek1GUEo5L3pvNHA1QnRUQ0RhbHFCdTFpWFQ2Qk9XVkdn?=
 =?utf-8?B?R0kvcngwTXJDdms1Qy8zclBEV0V4U0ttdHNrNWVackFSbWdTVUgrSm5VVkhz?=
 =?utf-8?B?TTZkd2d2UFMrT1F3M3Q5dFI2Y0g3T3BxVGl2K3U2NDVDWS9lY0VYdmJLTkJC?=
 =?utf-8?B?b09ONzR6VXlIbUJiVFMrMlFPU1V0UmxRckpGaVMxbmtEUloyWTJvQ04xaStB?=
 =?utf-8?B?a0VoQXFFd3ViTk9PdlY5eGEvcWVyTE5DcWcxT3pvbkVEOHNUKytRTCsrTno3?=
 =?utf-8?B?clMwN1JKVzNQUldQMzJNWmgrRFRZMGtWc2prQkM4Wm5uVmFXT1I5cXc5UmFV?=
 =?utf-8?B?ZXppVUxKbHZPZDF4T1FKU0tNemtGbTkxbnFUejJ4K3VtSEIwY1pxRE1jeDJ4?=
 =?utf-8?B?MTRSWitEY0pVV3ZCaStNWHNrdmgvS1lPbEJqL2RjKy96RTlKN0ZnNjkxSVhI?=
 =?utf-8?B?ai9Xemp3dDgweU00ZklaNEZET2FYbURMTzFxNHREMlA2cDFMNlpNUE1yS2ti?=
 =?utf-8?B?NUtOcUhCODZhbDFwSzF6bk16elVrc0ZjaEhMY3B5dlVub2RNREZVbHp1MzY0?=
 =?utf-8?B?TmxOZ1J6KzYrQ0N5TFBtWGVhTm9uc04zWHM4aDJ4ZVc3YWRhYWE5alVGZTJE?=
 =?utf-8?B?cGVTZ1FKTGtBdDNTVVpydXZaRU1DS2ZCTEJjb2hVMVZGTkpxMzNIU09ULzc4?=
 =?utf-8?B?TDhDK1RreTF5QjJENjBwbTgyL2Z3RnMwQkJGSW8wRUtLekY0cExybWg5b2U1?=
 =?utf-8?B?Q2tiMkZIaG1iWTQrd1F3S3JlaXdCMzlqd2JnRDVHU041ZVlSMllycXVpTnVO?=
 =?utf-8?B?NnozVzBQMG9KODBSVTJ0M2hFLzFweGgvdHJOWVlmVHJrZWRHL1dDNlpzZ3RN?=
 =?utf-8?B?WGVlUUJzZ3k4bWk0Sy9FYzlXNlVGcWppQkJxemUzeHIzZ0tycVdTVVc5YWhn?=
 =?utf-8?B?ZUlqNEdNMUZYUXZ6WlIzVGVtSUhKTVU1ZHJINVczUGpvdXdtWDlpby9PUlB0?=
 =?utf-8?B?QXllVTlLUU9pL1g1bTFKZ2FqV3FHZ3UzeXJleXFvM2ZkUkdaeWQ2Q3VNSHV5?=
 =?utf-8?B?emhQZDNxWVp0SHhqeUdDWHYrUkJmYkpVbnRkVHhJZUNGUktOaVVHSU5hK1Iz?=
 =?utf-8?B?LzlSM1dqTUh1STZZdnlxamVrSmRFUnNTMFhKSUF0OFJTcEwzbkgrTWxsZFV2?=
 =?utf-8?B?VGpyVVluUmw5ODlra2NZYTFQQVhNZmFWU001NG9BLzVmczNrekUveWlUMEFV?=
 =?utf-8?B?MlN3UHRVVzZsb1BJS251Qk5MbUlielhwdjBzTWkzd3R6aCtHMHFpRjY5TDEv?=
 =?utf-8?B?eTV2WTBCRkFPblg3TmNLTmFwaFFlWkhNQXFKc05pRnF1UzZ0RDNKSE83dGFC?=
 =?utf-8?B?aER4Rk1KOC9ScFcwYUpmcWFVdXR1WC9PUXVWRWJLMk5xOCtYSGtlTGd0U2tE?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567D5518990BBF4390B58FE18B1107CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1731c295-5359-4b33-4689-08da68deb190
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 16:58:09.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbriJ79xkkUs1B/C7xCAaNi9VQZukmiKIFanbXJuSxdIUNEUfVyyM0rlv78AvRL0uMyCnrSZHd3D5rC9bn7VG96ie/Drcw2MfWpYE3KyzVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3373
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMi8yMiAxOTozOCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPiBbWW91IGRvbid0IG9m
dGVuIGdldCBlbWFpbCBmcm9tIHN1ZGlwLm11a2hlcmplZUBzaWZpdmUuY29tLiBMZWFybiB3aHkg
dGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50
aWZpY2F0aW9uIF0NCj4gDQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiAN
Cj4gQ3VycmVudGx5IG5vX3NmZHBfZmxhZ3MgaXMgdTggYW5kIGFsbCB0aGUgYml0cyBoYXZlIGJl
ZW4gdXNlZC4gRXh0ZW5kDQo+IGl0IHRvIHVzZSB1MTYgc28gdGhhdCB3ZSBjYW4gYWRkIG1vcmUg
c3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN1ZGlwIE11a2hlcmplZSA8c3VkaXAubXVr
aGVyamVlQHNpZml2ZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMg
fCAyICstDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8IDIgKy0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3Jl
LmMNCj4gaW5kZXggY2U1ZDY5MzE3ZDQ2Yy4uZTVmNzY5MWM1YmQ0MCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9j
b3JlLmMNCj4gQEAgLTIzMzUsNyArMjMzNSw3IEBAIHN0YXRpYyB2b2lkIHNwaV9ub3Jfbm9fc2Zk
cF9pbml0X3BhcmFtcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgew0KPiAgICAgICAgIHN0cnVj
dCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRlciAqcGFyYW1zID0gbm9yLT5wYXJhbXM7DQo+ICAgICAg
ICAgc3RydWN0IHNwaV9ub3JfZXJhc2VfbWFwICptYXAgPSAmcGFyYW1zLT5lcmFzZV9tYXA7DQo+
IC0gICAgICAgY29uc3QgdTggbm9fc2ZkcF9mbGFncyA9IG5vci0+aW5mby0+bm9fc2ZkcF9mbGFn
czsNCj4gKyAgICAgICBjb25zdCB1MTYgbm9fc2ZkcF9mbGFncyA9IG5vci0+aW5mby0+bm9fc2Zk
cF9mbGFnczsNCj4gICAgICAgICB1OCBpLCBlcmFzZV9tYXNrOw0KPiANCj4gICAgICAgICBpZiAo
bm9fc2ZkcF9mbGFncyAmIFNQSV9OT1JfRFVBTF9SRUFEKSB7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IGlu
ZGV4IDYxODg2ODY4Y2QwMjIuLjU4ZmJlZGM5NDA4MGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+
IEBAIC01MDEsNyArNTAxLDcgQEAgc3RydWN0IGZsYXNoX2luZm8gew0KPiAgI2RlZmluZSBOT19D
SElQX0VSQVNFICAgICAgICAgICAgICAgICAgQklUKDcpDQo+ICAjZGVmaW5lIFNQSV9OT1JfTk9f
RlIgICAgICAgICAgICAgICAgICBCSVQoOCkNCj4gDQo+IC0gICAgICAgdTggbm9fc2ZkcF9mbGFn
czsNCj4gKyAgICAgICB1MTYgbm9fc2ZkcF9mbGFnczsNCg0KPiAgI2RlZmluZSBTUElfTk9SX1NL
SVBfU0ZEUCAgICAgICAgICAgICAgQklUKDApDQo+ICAjZGVmaW5lIFNFQ1RfNEsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEJJVCgxKQ0KPiAgI2RlZmluZSBTUElfTk9SX0RVQUxfUkVB
RCAgICAgICAgICAgICAgQklUKDMpDQo+IC0tDQo+IDIuMzAuMg0KPiANCg0KeW91IGNhbiBleHRl
bmQgdGhpcyB3aGVuIGludHJvZHVjaW5nIGEgbmV3IGZsYWcsIGlmIG5lZWRlZC4NCk5vIG5lZWQg
Zm9yIGEgZGVkaWNhdGVkIHBhdGNoIGp1c3QgZm9yIHRoaXMuDQo=
