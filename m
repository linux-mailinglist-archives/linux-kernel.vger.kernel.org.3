Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4353A5A7826
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiHaHwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHaHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:52:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F285F42AD7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661932308; x=1693468308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2k655qxtO6b6VDzAreApEsUggJtYCfvM7ozNxv71lzk=;
  b=wney//uGrmFCNNePmLEt234VI9tHjfz/I7EW1IRD0yWcKd6y+mJkr8Q+
   q7OJesRbfi9a3W/3mNMQoAofH5ChymK5C1RwJvUsVmPa8+BURC0rLIdTr
   coFgejpAU0d9UIKer/tB5LiCsIZns42leCj+FjcLOR7cuX/8pDgb/pGuk
   RZZOxRwULzu6jeYlKY2Uy0gamRAvv0KpgSKb1ufT1+Tuts92++XlB1bAM
   eCNMkjdKvNAvI+8XfKuWAfsQOEHUKybSnP6MY2Xydbf94wwCTchOW7pS5
   psHMAu+GoxX9RtRiz/vT0F+eldVlvZE3ELcN8W7rI3RxGQytwnQeSw6sR
   g==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="174951662"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Aug 2022 00:51:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 31 Aug 2022 00:51:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 31 Aug 2022 00:51:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCMgYHJ4oeaJQfO9+g+NaMIbnwgcSbEWTOs11GKl+IGaY4xJ8QTHpfHufYku5hjDXttmUiIN+6vs5VrdwYL+Rok1miRdxofaLfDvMxvSpK3AcCWM1cawNz9dqh3vk6EPqvzoV9bTYg2rZ/aRuUXs+RVo0dsXl2NuOGXNLiJ2vF8jXKR3PtF64FWPhEs7FBLomkxTAfqi2db+k6DjdwJ8PIwl7kj3yNGgoZkRyk/S/v+enIkIz3fBilwEw39tqKs/iJjNGzj2qkPKeB03GvbR33bBmz6JsN5+sQoPGTChSZ7QTNnDNTZDzBSi7BxmOw6eInrryM+Wht+E6vg1vVtz2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k655qxtO6b6VDzAreApEsUggJtYCfvM7ozNxv71lzk=;
 b=hDyNNdDxTidFEGS0/zpsaXzp4EQ61lZW30KjoSWJaAALMyOBt0NKx3/AGmiHFzKDF9tv6z9qYu2BFXsYYbk8r0NSx0aMrzskhK44z/A+4+sfkCzYTZBX4RQ1VSSnrmY0iZEecgqUB5GlyRyIHS8p8Ybu+pApExIZlPbGKMuyDNlW7XtHj+vHnyyAWafypqdJsGHjJIrm2z07AgsvZd8T8zt2EJDxQHXPFiCPuUguLewnS7hW/xxc+yOiR4m6Zhw+fK178Eu5RTrVCAYB+XvVEGrOJfsGXTzi9SOD2Vuhp8Mgub4vuQLsN08rsA+zV/LtwqOcfsft6jO2iLtRpTirYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k655qxtO6b6VDzAreApEsUggJtYCfvM7ozNxv71lzk=;
 b=Liu9QC0dK6nYdRb9q9LWwt5LEn8NxX3W3XF0jJa4mfUQ6+t/e5C0N0XZKrQRn3ZHqpZmr/vBGzGwDG9ZHMJmkM54zWc6KoqIcfaS5uWIjxnHwnW1NlTPXUd5EOAZT/P1FIwbY4VwA5aNlHRAWUdzkJNf+hE9Os/0tEjXY07SMSs=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN6PR11MB1649.namprd11.prod.outlook.com (2603:10b6:405:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:51:32 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:51:32 +0000
From:   <Conor.Dooley@microchip.com>
To:     <chenguokai17@mails.ucas.ac.cn>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <sfr@canb.auug.org.au>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liaochang1@huawei.com>
Subject: Re: [PATCH] arch/riscv: kprobes: implement optprobes
Thread-Topic: [PATCH] arch/riscv: kprobes: implement optprobes
Thread-Index: AQHYvO/eaHU6+YdQhkeJ6FHUUeiIQa3Im1yAgAAHpwA=
Date:   Wed, 31 Aug 2022 07:51:31 +0000
Message-ID: <d7729836-e50b-5ab6-464d-8bff87b54871@microchip.com>
References: <20220831041014.1295054-1-chenguokai17@mails.ucas.ac.cn>
 <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
In-Reply-To: <882e9efc-7222-c3af-e37b-f339789e94c0@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b6f92a4-591f-4401-32e4-08da8b259ec0
x-ms-traffictypediagnostic: BN6PR11MB1649:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Enq6In8dMHRZbq27JXwV1FnpGneEvGR0lmchj7u2Ogr8mHVSfByVr6px9cKY4vhjBb4SKBkS/Tx1UhcXef7Zfs1d+FI5B18QV+6SFQJ5RH8KxPyRQXX1zeSBdji9Bq+r4+Gu58rfY2BOz2dMxK18wpOY7l3ZcqXm0kInJ6mNIMbgJmJyHdramzo1v5alXDtMdSYUVuQxcDPyBczF20oJu7IfruBi/CGzeOTGqwfIsxURiR8+wQnTTngM0Lw3xkeIxx6rHr+QGrVBbqW9VQgPsjsfDjibuzQYGoFlpxXImOoFw2r52CR+h5mN8CthmutsC3yW0EeAYiKSh/BiRR2p2haRKmYa1bIs79lO05xjsn0/cFqxdhYVgiGkunRp9G+75wtzo5KSd5bS7ayrl9NPyzDjsobxvdrV4KMZpouaSCQIxH/12jGN1dj8QuW5VhthZrOFSJSRltK1cQA2Mb9wuBWimPn9AioC/WLrk1mjoc63dtDCzRYYVMBIAK9jNa9K4M64Nbs4+0VzooquqKpHSiXw5VRNryCaQt2A0ueA9qUGLy3ihq+ixB7goKq/yx+xqKyiDxPPTudBxT6bi6yNq50MLjualQdDtnNsUN6NGhETdmKuGgVLOfzTg2pv0Wb3L1jSTgZ7cDNg1jMRRUNPLDqaFit0h3CH7SfdZx1IuKF/gBxpzEFtIf2M1EptjNkyLwct2EvwHDkbbsEW2kqBs5kPhlZQrlyDICBhT5ywdnnxLSbcd/7zdl2p73xO22sUW28N+01jxhpQNgDEDZX1uAGdo00kiJuQTUVma12SkQGM6NzwVy4IDnNbdCNGjiNEgEVS0UGcy0CaBI7aXfJsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(346002)(366004)(39860400002)(4744005)(53546011)(5660300002)(83380400001)(31686004)(6506007)(41300700001)(36756003)(8936002)(478600001)(71200400001)(6486002)(122000001)(66946007)(8676002)(66556008)(76116006)(66476007)(64756008)(66446008)(91956017)(86362001)(31696002)(4326008)(2906002)(38100700002)(7416002)(54906003)(26005)(110136005)(38070700005)(6512007)(186003)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWQ0V05LNjNzMzlBWUd1Vi9WRit2SVcwM2g3S0Ura1hFdTBxSUpBajhCSzJn?=
 =?utf-8?B?S1QweE52c3ZuUFNOaTFwNVRsVi9vRUdhb09GWWZCcFBWT3lzVXMzVHRvd3JP?=
 =?utf-8?B?ZDcraFlBYmZwYXpUbjBHQ3l6T0VCRVQwNVFXazdPUXFtTWxJaW1BSXZnZ1J5?=
 =?utf-8?B?SXhQODNxZkxNdnIxSXJPdFlnS3pRQkJNdk5DVEdkd251NXIwQTdUNy91T2VP?=
 =?utf-8?B?ckZQbUZaVGxERHR6KzdwdkNhSDJoWlZCcHhBVUROT01UdUNuQndSdWUwbVc5?=
 =?utf-8?B?MGpXRGxyTHpKa1lqMDYwdXU2ZTd0bmVNdGlLbjdORkpjUG1oYXpDaXlsU291?=
 =?utf-8?B?VEVIQWZ1ZmdOQzcraWxqMDl0S204Qjd5TFlTSnNpWjNrZmgyYnM4WGhJQTBt?=
 =?utf-8?B?clJ6RTVnbGhXRW1LeHhmKzUxUUdLa08wNnNPcmpMbXdqQVpKZ0c2U1UvWUNX?=
 =?utf-8?B?MEM5UEF2WDhPNVEvaTcveUxHZlppbGRhTU8wSjZXOExmZzVvRTBtSlVmNjd1?=
 =?utf-8?B?bUFEeXNJbjNqRGF3aWdQUUJSQWc1V1dNcUxaVFhMUmNDaFNBaE1ISzg5bUhL?=
 =?utf-8?B?c3FlOHpqV21VTjBCUUFqNHZmL05ic3hiMUJaY3E5bk8zM3QzUU9RbmhZcDBG?=
 =?utf-8?B?U1dzR0tIaUFOV2x2YWlFL0hTM28xcXloblYrM1dtaFI5SFpZR3F6ZXA3UEZx?=
 =?utf-8?B?ZmoydWtHYWJSU2haN2JuYmp1VllkMHlvazRjT3h2ZkhiVWNpUVZDdHFOZm0w?=
 =?utf-8?B?WHk0SjhxVzUxdFBiRDkwSHVxVEN5NTc0THNxNFdVN2lWQzQ1dWdLMllnOEVQ?=
 =?utf-8?B?c2ptVi9SS21kL2trWnlobzRKWW5aZXZqaDA3VCtsYVVUNHZzZVZrQnJQV0VK?=
 =?utf-8?B?dFQ5VDQ2d0RjTWp6Sys5bWg5WUFWVTNENWd1V1lpUGhmUmJOSlB5K2tjNmxo?=
 =?utf-8?B?MzJKQmZYSVBRMER0VDdHZ2RSOHVNQWhNTXZQRE1tRTF3T3J3NHlMakZTY2k2?=
 =?utf-8?B?bWtoUncydEtpTmx6VWFmVmk3L1hrU2p2K0dPTjBZSzJ0MjdyZU9tWFFFbHV1?=
 =?utf-8?B?WFpwNVNTcXJ0K01wOVpMaVpLU3c5azR3K1BOd3lzTkxnME5iSG1wa1hlRkRF?=
 =?utf-8?B?dVgxeWRlOXZhN3UxUG9WaS9sNGpJWlA0eTd1a2ZOaE5tL1dFY1NCd0MvVmdi?=
 =?utf-8?B?YWFWQ0tYek94VGM0SFR0TjZIMkgyNXZJdFZXNkNIQnVrNGUyc2VVcHNjUzcv?=
 =?utf-8?B?YmtjNUVieVNwOHVCbjBoQ21QL0RWS2JBcHUrOHJuNGZXTjlBRnBGdDdSNFVF?=
 =?utf-8?B?YUZNUEZPdWw5N0ZLcVpvaVNKY0RDbU8zRnl6WTgyS2EzaENsZno5ZEI1bnlt?=
 =?utf-8?B?TU4ydG9pUlNLbVk2Q0s1UVV2UFpIbFVkeXJYMlZSanZPeFNwRGNQTmplZWZN?=
 =?utf-8?B?Wk9IZVJ2enN6TTBlQ3RCWHEyYTNtNktNN1hBV3drWXUya0RSRG1WSzIyM0M2?=
 =?utf-8?B?YTN3MllNQTRScS9jbXVyOWQyMXVRaDVLK0Z1RUcvK09UWjZBbUs2NGlaZlM5?=
 =?utf-8?B?cHh1bll4c1NuOVE5ZkFzK2h5RS9FTnRqOVRaelFTdHpNQ3E5by93ZjMrd1lT?=
 =?utf-8?B?OEpHL2M4UENrTDNHRHVSUjZGcS9pZUUxdHQ1dzRuY3V0V21Ed3g5azlZN3JL?=
 =?utf-8?B?L1ZOS2VqdU9VSy9qZWM1Vi9kYy9XWlFYOTBQNFR4L1cxYzZ6Y3d2d0YrcW53?=
 =?utf-8?B?MU0xQjJKak5WQVVsZUJ3SGwzUEh6T3hvM0ZWVC9takFHOUtDK3lZU1BXSTEv?=
 =?utf-8?B?U3YwRWJFSkViWHVRZ1Z4bUYwcktZUUgwcGw5RFpKcEFrTnJYUFdQcnF3eDF5?=
 =?utf-8?B?RUQvcVhOWXhLT0NRbG85dXg5SnNramFLQ3dqL2NudTdLWFVEYjZsVTM4SU96?=
 =?utf-8?B?aDU5bFFFbmZySHNkem1IcjFIL2dXRFRnTFBacDU1dkxqcUJKaWdKamhmTHJL?=
 =?utf-8?B?bXdCV0lmdXZST0xidXNLNnpRWDRkc1MyenZhME9IQ3pPMWwwZENJd1llbUk0?=
 =?utf-8?B?VkZaZWhmb3NBTHB2MFpzdDJ4TEtCNGxWZ3V1eFZTRW1aRGZ5aGxKdFI5a2o4?=
 =?utf-8?Q?WJQH3BbxrqLAF0+c5pDnEmWqc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <894B1EAC18785F4E8B9FEA4BDBD14EBC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6f92a4-591f-4401-32e4-08da8b259ec0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 07:51:31.9480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eybxfdGad3zqGvu21q3GYR83hWH7RSN/hoYaO3pTWuh3Q4OR3/bZPqbolkaj+OetvJmXdmK5O3GM9h//cqRdq1k9JB9uOOLcpKioboyr1d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1649
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEvMDgvMjAyMiAwODoyNCwgQ29ub3IgRG9vbGV5IC0gTTUyNjkxIHdyb3RlOg0KPiBIZXkg
Q2hlbiwNCj4gDQo+IEZZSSB0aGVyZSBpcyBhIGJ1aWxkIHdhcm5pbmcgd2l0aCB0aGlzIHBhdGNo
Og0KPiBhcmNoL3Jpc2N2L2tlcm5lbC9wcm9iZXMvb3B0LmM6MzQ6Mjc6IHdhcm5pbmc6IG5vIHBy
ZXZpb3VzIHByb3RvdHlwZSBmb3IgJ2Nhbl9rcHJvYmVfZGlyZWN0X2V4ZWMnIFstV21pc3Npbmct
cHJvdG90eXBlc10NCj4gIMKgwqAgMzQgfCBlbnVtIHByb2JlX2luc24gX19rcHJvYmVzIGNhbl9r
cHJvYmVfZGlyZWN0X2V4ZWMoa3Byb2JlX29wY29kZV90ICphZGRyKQ0KPiANCj4gQWxzbywgaWYg
eW91IHJ1biBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1zdHJpY3QsIGl0IHdpbGwgaGF2ZSBhDQo+
IGZldyBjb21wbGFpbnRzIGFib3V0IGNvZGUgc3R5bGUgZm9yIHlvdSB0b28uIE90aGVyIHRoYW4g
dGhhdCwgSQ0KPiBoYXZlIGEgZmV3IGNvbW1lbnRzIGZvciB5b3UgYmVsb3c6DQo+IA0KPiBPbiAz
MS8wOC8yMDIyIDA1OjEwLCBDaGVuIEd1b2thaSB3cm90ZToNCg0KPiBbUEFUQ0hdIGFyY2gvcmlz
Y3Y6IGtwcm9iZXM6IGltcGxlbWVudCBvcHRwcm9iZXMNCg0KT25lIG1vcmUgbml0cGljayB0aGlu
ZywgY291bGQgeW91IG1ha2UgdGhpcyBlaXRoZXIgInJpc2N2Ig0Kb3IgIlJJU0MtViIgbm90ICJh
cmNoL3Jpc2N2Ij8NCg0KVGhhbmtzIDopDQo=
