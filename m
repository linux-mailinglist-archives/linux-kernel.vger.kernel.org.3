Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE964CD84E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiCDPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbiCDPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:53:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE01AF8CA;
        Fri,  4 Mar 2022 07:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646409133; x=1677945133;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nYfuQCTQzy/6zrWpyCpV1qTuyOHcUSbXf3iAV/PSlno=;
  b=roCj9xfTYmZDLF7fcdAajrKwn9GFMz4qqsWebpL7/f9UyA2nndd4TwOe
   B2cYEf069n/grii2NwXMCHoM/npUvXG7GvnOpKgShLcaawIeBmbHAJoz2
   Vt/VvrYLoAGWO3hZBhSA+NguYhpc+zRQ9jKtRNEJDlO0SIXJ+rjBflKWi
   9c6NV+8JAsLghkQuCW9OaQ9FDI8Iv7stfiPOBNhRYx/hKz3YMN7b90gxt
   V0lHYbNS7jmz8XirfL57XwqTSGojde5mePqUajxMIX2bz+KwltI+gE9SW
   idX470CUwoyscDT4rWJco4dDiMqeGlPPlovUvF7W9BeyGis+voc8udeqA
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="155282590"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 08:52:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 08:52:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 08:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWkqryYONL7lwIimAmOYyj5iPHb46EdXx3Gh7YN4ZCuf+07M8UhWMMn0QFf4ROAPxc1i0E2ZEkOw5Llom/ZTh8If9BHz1UtctdwWi6SvDtqAVveYoHDkSRi7KXVy+E9qrXLFapEQ7SLUcI2AuICD+rVQf/BXNYs1RLnmYCldPZ8B9mly6p2NE106zx2mhUSBS13LLJPrnsJsK3rXxGQbOEn+VGTUt8Cf+qOPoV9TFwgjNvtQLubqOC1ZguNv/Srkv0+VraP5Igw9K/ycuW39KER3W8Wc6g6MAs+Yk/Pmjp/fJC6SKcj65hntBdLJf90m5aBi15h2rClX8LP/p1US5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYfuQCTQzy/6zrWpyCpV1qTuyOHcUSbXf3iAV/PSlno=;
 b=kbh7vt9rWZ5z/zs4y9GF+qn0JXcXCqlidIKdYUnbGfrC89uyV3UE3271Te125dAciaodN18OcA/8Jt/d2hisv6kjLCp9CxoVMicT4hJUxuwxrzgTXGgOjenXxC17ulKJtFJhjfsnYZz/F/KnZCtGO6bFNzPEdXKAR43cyXOhCXQORvS9W3bUj5W6ZKKcoWRBaPDqJ2SEnGctuLZ2YrzDFyc938r3faVtOnNOr3O/iQoOsZ2+GLbPMZMaV+NddvLl+D+xE49mIOShWgz6ePy35MdF+CjxCjFDeu9+RHPEksSyOZEtgHEf0mM3DCqszfK7NHKxV7T9gR9aqfcVkj0YTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYfuQCTQzy/6zrWpyCpV1qTuyOHcUSbXf3iAV/PSlno=;
 b=fFTafbvy1NpIZijaEpcIFd2DBwA8NiSAuVBEZmoTHIZf8XMfeDSXi78SO5ik9iterglNakqjYOPYDWI+nygLxvvXo4AnRlIaFkF3hGiAQhQVkQMZRysWIFootDQ2nNi8NqAcoobdqE/wZnfwMC0Pokg5jVxrsE7bX5jxyBXpC5Y=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM6PR11MB3993.namprd11.prod.outlook.com (2603:10b6:5:19c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 15:52:00 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::381d:1e0a:2ec0:38b6%4]) with mapi id 15.20.5038.014; Fri, 4 Mar 2022
 15:52:00 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@canonical.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] dt-bindings: rtc: at91: Use macros for the IRQ
 type
Thread-Topic: [PATCH v3 4/5] dt-bindings: rtc: at91: Use macros for the IRQ
 type
Thread-Index: AQHYL9Q/MSY+PHo3w0K2yXXwKt1wFKyvTOyAgAAS+4A=
Date:   Fri, 4 Mar 2022 15:52:00 +0000
Message-ID: <629e9f45-e258-1069-b2cf-b8e1d33e9d8d@microchip.com>
References: <20220304142746.121947-1-sergiu.moga@microchip.com>
 <20220304142746.121947-5-sergiu.moga@microchip.com>
 <e97cf184-4e38-c540-da5a-28c762d8d21a@canonical.com>
In-Reply-To: <e97cf184-4e38-c540-da5a-28c762d8d21a@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbaaf2f8-09f2-4e8e-7302-08d9fdf6eb74
x-ms-traffictypediagnostic: DM6PR11MB3993:EE_
x-microsoft-antispam-prvs: <DM6PR11MB39934B7FFD66103FC2DEE90BE8059@DM6PR11MB3993.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dzly22g4ATNCezxiDzFt2YTiDJdffL85oaKu4AWYoVD1cpqgGIvUhYTLZGblRNJx+wqjgq/dyd3FsJ/ONV82PwG4aKeXE+MiRQLTQwEkxqL5UiPG0Vilf5GPiOUAbdsdu40F/dcthp97Aq6efGhogXekHb8/RkEDvb2uXUH3tjU94wA8UxvRubUzYvIeb9H7j6/p7bfgz7C0Jpdi+APElQZv+Il7rz56eRa7cch2I2iP9uVurK87c6olRXvOsybc4c9k3MjQtzjsUxWV/FYiKsVmQPhL++I924lEtAmNXIYY8UxT73Dm8Ic5EtTdEROfunHxLKVU6999zXwg9c13kvUgdlD6RU3xz3PPvHRZARYZ2S6ATOwgD/cZFMYG9n4Wo+vW58aktgQY42VZRs52tTeonFp5/XRL5j7MKXwhZFjp8AZJcxd3b4rE7bXEVFytOGFCr3GQrnNn2HTzjivwoObwLOWN1v/s7PiFkUZA2FcJF+HO70gmjGK0oIhG9FowP5Tb5vsufjMBUnn1DChnD3iqAhrzTD+H0Fz2ifSNUXBF5Crb0QFUE9v2GBGZga6nllukE4v7GIhpIyEBOYsemLzAoyKsN+ikPYQ0T1MecO7auSktFViN7Vka66UO8aFD2GcKztKBffU8c5dLjI6jSMm7XWwZ/PkkvQBNhhN3hh2Yb6daVkSF52bfRj2hA0TuHFVWjUk0smgq5Dq9iGveHJ8ubeA+Nrzf1jr/7yJneiEMa9W7m9gAaObqPiR3SQfq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38070700005)(316002)(54906003)(31696002)(86362001)(6512007)(64756008)(8676002)(66476007)(66556008)(76116006)(66946007)(2616005)(2906002)(91956017)(186003)(26005)(66446008)(4326008)(36756003)(53546011)(6506007)(38100700002)(6486002)(508600001)(122000001)(6636002)(110136005)(83380400001)(71200400001)(8936002)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGxDTmNXcDFNQWh1MTdDMkY4dldrYkFiaGJMQytnZ09GcDZLdlV0UzNXdVJ4?=
 =?utf-8?B?SHNaeUxUdVo3eXZPMTNEN0k4QWoveXlpd3NiTHliTGxOaVlDUzZ1OXJ0dzN4?=
 =?utf-8?B?Yklnai9jd3pzK0FWc1BKMzZ6ZzdrQnY5NUZFTmtzZGQ4ZWFBeHlCclNLM21h?=
 =?utf-8?B?NjZvcm5KUUlSY3NjQmtVVzNJMllGMVZDeCtEemg3SGloSTFGeG03TmJWdHg3?=
 =?utf-8?B?TngxUEFJeFdYMUFaT0NHUjRnNTVYa2Z4Mms2UkxzMGU1WVJPNDZtMkVISEJW?=
 =?utf-8?B?WWZxdy80a3o1WHNQT3IvV2l2Y3JqSXIrMnhBKytQL0NOc1JBVDExSGo3Ui96?=
 =?utf-8?B?OEFjdmNOOGNQTlljVTV0d2lRNWJydkgwYnV4clJyMmFOKy9IbThrM2dLajZW?=
 =?utf-8?B?aW9ETUVpV04vTXlHY3dwMzM0V0xMMitXWFUrTXdsS0l4N215aHZVQTFyelpT?=
 =?utf-8?B?dVNXb3dCMEkzQ3E4dlhDWW5mb2hUUkxDenY3N1hXMThOaU1PSk4zSWRhcDN2?=
 =?utf-8?B?ampJYUxiK3RCQ1dvSFE0b0UwU21SakhhUHRpeEMyemhlZXJvL1ZvdjZOcWls?=
 =?utf-8?B?SmxmQWVLbERwa0dxZjhsYXp2L3BabUZteXNpVkFWT0VwZHpGY3FXdVVvVE1V?=
 =?utf-8?B?c0E5T2RqcGFVNHdUaEQ4Smorc0s0ZEdRbG82QU1CZTMxM1lDV2UyRTRZRXA3?=
 =?utf-8?B?VFFzSmFIRFlOc3dsNUwvZ0VjWEJadU9XNkZGNlkzS1R2OEhJcGhINVhrNSs4?=
 =?utf-8?B?c2RlTW1mREZOUUxBWkJadUhwUGlNZGIwaUtPK0NFbXBvVDZiaFZqeXNmd0Rr?=
 =?utf-8?B?eSt5OUIwNk0vVjhhTmhTS3MxVEZlOEQ0WkZhZ2gxd0Vld0NBRUNBN25EdjJN?=
 =?utf-8?B?T2d5WnBnVlJJWHV0RmpjampNeGhOUEQ1R0JFanpzUmpKbktnRkFLSnNiaTRQ?=
 =?utf-8?B?RFZOT2wwelVNMDJhb0NSdnFDektsTVFBa2tDOHp6cVYwcGdUVjRzZ3lYNWVG?=
 =?utf-8?B?ckEwOGx2L2R4QVQ0Vi9QTGFjY1VpWG10d1ZNODhLVHNndGEyeE5FWUdiQ2NO?=
 =?utf-8?B?M0dIQlhtRWNOSjJKcEVWZTBGVWNLVkZkSlh0ZSt0K2Q4ODJsd1RQaDlDVmF6?=
 =?utf-8?B?QWo2TENlVW5BZVdnUXdsb2JMU0FlVjdHa1JER21hdmNSMStWOXROUDJKWnUw?=
 =?utf-8?B?REkwcm4zR3JDdGtSdkdsUi8xUUlzNW1WSEVYOXZPdUhaVmhsREJMNFQzemNv?=
 =?utf-8?B?VUEwT2o1bnZqdGpzYStYZ1NtZkwwZGt4eDlyOExaWWpSVi80UzJydHhpWkpJ?=
 =?utf-8?B?T2Yvb1V5d2tERit5azhMc1FMcHoxVTlmRlhRK0RsUmQwdEdZVGlCR0xsanNB?=
 =?utf-8?B?U2x6VTBzL053UUQ0K1RFQlZCNG8wM0dmOGZ6RnRhQU9zNU5JN2J6dTg3Z2Ro?=
 =?utf-8?B?N3h1UzdXYkg0dVIra3hjcVUvOTdSYkhmUWI1NzY2eFJsYnBzRzZPUEhJUXdn?=
 =?utf-8?B?SmNSSHhKK0w4RmRGTjBpcHlUK1BMdS9qMDRHcVBIbkNWSjNMbHgyVlFDV3di?=
 =?utf-8?B?ODllSmpocEMxRXFEZ29kaE1IR2NXN1ZoM0JQaWVmSnQvVVlkR21QOHJ2Y0Z0?=
 =?utf-8?B?elk4Q2ZGY09qMFNVdFRlMjcrazBlekYvSmxGdWxaK0JBZGJxNTcrTWdwL2pJ?=
 =?utf-8?B?TGpMU0Q0bGduUFRqVGxOYVQvZlRVVGh1cGtqMDNlK3JwU0syWmN5RjE2M1dK?=
 =?utf-8?B?VVBMU1huNklrTUhrOUcyWm90ZUNBUDc3NHhmSWZ1NXF1RmJFNkc3TmxLem9E?=
 =?utf-8?B?WXJwSE1ZN3Y3ZUVnbVlZSUF3MEJ5WFpFVWRrMGk5aTZINCtIZTgxZ0dOSk9P?=
 =?utf-8?B?c0dJTUIxS1ZTTkFSdmRtQWV6ZzBLVzNVMXdKRnl6Y3RaZk1QNjhmTTBFR1Q1?=
 =?utf-8?B?SVI0c1ZhZEdrSlB4S2h1K0NXT0M4Vlp5VkM0U0JZY0Z1TjBnWFRRdDlybTVH?=
 =?utf-8?B?QjBzclhQZFBlTmhjYVIyMDlwNjI1U1BOMWtkMlJRTlJqMi9jSHhGR01aYXBa?=
 =?utf-8?B?SzlxQnVOOUxSc0xMZXIyL2NLREkvM0k4dEIxVzhXM29HSkJwcGNjeEVWSVlo?=
 =?utf-8?B?cjQrSkh3S0pNV1NuL01vdEJnTUVVU1h5cTV3c05KeS9sK21LYjRHRUlKZTBa?=
 =?utf-8?B?Y2NXSWZOdnh6VzZBQWlXbGtyVU9ZRHlMcVl0dG9uSmE2WmJnRXozQ1pOSXZI?=
 =?utf-8?B?RDVCVlQ3NDNxMy96blB2Q2p6UUFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <260A6D19EC97CD45B80AB0D6C5696F86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaaf2f8-09f2-4e8e-7302-08d9fdf6eb74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 15:52:00.2757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sE/bW5iJ77b77d8F1vy1b2x/5xeldOb9ADeNcEA6h53eDvVvQC6ykyGbe/kGZy22XSJBTM/xSUmVbWUhNsaJ4dG9FsSxRQ0URix7I8LGgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3993
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMjAyMiAxNjo0NCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDQv
MDMvMjAyMiAxNToyNywgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBQcmVmZXIgdXNpbmcgbWFjcm9z
IGZvciB0aGUgSVJRIHR5cGUgb2YgdGhlIGV4YW1wbGUgbm9kZSdzDQo+PiBpbnRlcnJ1cHQgcHJv
cGVydHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogU2VyZ2l1IE1vZ2EgPHNlcmdpdS5tb2dhQG1p
Y3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3J0Yy9hdG1lbCxhdDkxc2FtOS1ydGMueWFtbCB8IDQgKysrLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRj
LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFz
YW05LXJ0Yy55YW1sDQo+PiBpbmRleCBhZjI1Y2MyNzUzNTYuLmQyNDUyMDY3YmZlNCAxMDA2NDQN
Cj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5
MXNhbTktcnRjLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwNCj4+IEBAIC01NCwxMCArNTQsMTIgQEAgdW5l
dmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPj4NCj4+ICAgZXhhbXBsZXM6DQo+PiAgICAgLSB8
DQo+PiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEu
aD4NCj4+ICsNCj4+ICAgICAgIHJ0Y0BmZmZmZmQyMCB7DQo+PiAgICAgICAgICAgY29tcGF0aWJs
ZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC1ydHQiOw0KPj4gICAgICAgICAgIHJlZyA9IDwweGZmZmZm
ZDIwIDB4MTA+Ow0KPj4gLSAgICAgICAgaW50ZXJydXB0cyA9IDwxIDQgNz47DQo+PiArICAgICAg
ICBpbnRlcnJ1cHRzID0gPDEgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gQWgsIEkgc2VlIHRo
ZSBjaGFuZ2Ugbm93LiBUaGlzIHNob3VsZCBiZSBzcXVhc2hlZCB3aXRoIHByZXZpb3VzIHBhdGNo
Lg0KPiBUaGVyZSBpcyBubyBwb2ludCB0byBhZGQgaW1wZXJmZWN0IERUUyBjb2RlIHdoaWNoIGlz
IGJlaW5nIGNoYW5nZWQgYQ0KPiBjb21taXQgbGF0ZXIuIEV4YW1wbGUgaXMgbm90IGJpbmRpbmdz
Lg0KPg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpVbmRlcnN0b29kLCBJIHdpbGwg
bWFrZSB0aGUgc3F1YXNoIGZvciB0aGUgbmV4dCB2ZXJzaW9uLiBUaGFuayB5b3UgdmVyeSANCm11
Y2ggZm9yIHRoZSBmZWVkYmFjay4NCg0KU2VyZ2l1DQoNCg==
