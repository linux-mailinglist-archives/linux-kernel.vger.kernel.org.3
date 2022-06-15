Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8F654C929
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiFOMwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiFOMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:52:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864772A273;
        Wed, 15 Jun 2022 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655297538; x=1686833538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SBBAEKF8ziXwY56WphsstN1O90f9a34hpkYQlZeoSe8=;
  b=ArC9jm6pg7faBhA/4ir2q4Dcink+vnKtquX5hiJVmJPsmqYBZ0PJ5Kew
   hkV49ASkQs5ZVB1RGDbu7oLn9GmefBz9brEjRMb9rimQRNz9nldC95OUT
   U2K88y7Z5d628bLgG4H4bMW+OLgt761XJy1mdXT+t1gZm5MJNs8HOcS/H
   8/z7UKWGSCIQY77SIDyAktngWf0ELq2+daUoHezTqTbcV/aLkj3aiY3MX
   1GPvnVpRBb7gX+TaO1qsNdxM9U9W3Kf70w7d+V+Mg4daUAEbDhS2W/m7D
   3N9sVqAtpAUiV6/GfaeKTOmB6WaF5VbmuDYdjB3LHNoY5bam2U61PyjYT
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="163467544"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2022 05:52:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 15 Jun 2022 05:52:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 15 Jun 2022 05:52:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuZ/4uKkPxvQw2ZMZYWi3ci/yfmQUxCcLCQ8x4ZLm1XFj+6uWWay8QxuqDbp3v2KxX+xC72aPrDO1T5P1LqrcmSp9GBDskeeAlK/MmC/CixQwE6QQw2zdNku5h5qeP9+IM2mmzOAIiN0n7tHlCk1xLvDDdDXLS1JDt7riz9BrCzep3bNHw8GOchurWUBXUgjruLWr1nYarSVdnr5b+Jchve8b8ZNmO+Hdz8/NWJatqLD7/HlOZn69aKkZbeptkfGsWRqS/Htq7NDjtSwPzpvLzuPj/4PfQD75BeocQiNgp9TeiZ/WYnEf7X/TzcA/eBQY7ftHOH2UompfTAhMTbQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBBAEKF8ziXwY56WphsstN1O90f9a34hpkYQlZeoSe8=;
 b=gVviPD6S1FVHeU+qed6pnhpBM9Nc1hnfL50I99rVlIZPj8pSDeobj3eYbe48B1GUE8X/rTrv5umdxyqwvncuArMJreLSlEW0/4vV9mJnXukCaeKbPsQTaNAsO36QQxPnUYguDsNJC6cw2jELv5B28xYTp9gMJdlnXfHiy5EyBQZb33uW792tj9GSsDC6DQsa7dI0TC7/g/0V//dcRgs5C5MMc/dPGO6dYYA+hjwGg0u+kL62+YmlZjnnaprqqoWCMXCC0yofs1rwo6aJ+FlNJTGba+1sH8AHKRg2J1slKd9OPpAcN1h97PcaMkzPv9LR91pirbaHIoylaeDAiDSuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBBAEKF8ziXwY56WphsstN1O90f9a34hpkYQlZeoSe8=;
 b=QUoy97n45hu/nBCIIGVnS2ECt1i2jXyE5VXR0BupqvoSsriowwI7A7lebnscvTcioKxTVy8euGM5bi0J4NYatTAAAXT7KRSCcrz//2xyz7h8fHB2rkOLGew8KSetCBcOa4XfO3SP10oBfnv3V+WmmEJwI+iHBzxQEkPsLkKJByc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1785.namprd11.prod.outlook.com (2603:10b6:3:10d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 12:51:59 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 12:51:59 +0000
From:   <Conor.Dooley@microchip.com>
To:     <broonie@kernel.org>, <Conor.Dooley@microchip.com>
CC:     <Daire.McNamara@microchip.com>, <Lewis.Hanly@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
Subject: Re: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Thread-Topic: [PATCH] spi: microchip-core: fix passing zero to PTR_ERR warning
Thread-Index: AQHYgKu0NnUyv6HMX02qK3OEv15VZq1QWBQAgAAEXYCAAAueAIAAAOiAgAACYgCAAABHAA==
Date:   Wed, 15 Jun 2022 12:51:58 +0000
Message-ID: <39d7b387-905b-d1a9-85da-ce30501be8e0@microchip.com>
References: <20220615113021.2493586-1-conor.dooley@microchip.com>
 <YqnFLCbvrTxNbG1+@sirena.org.uk>
 <7eda95bd-c7f5-767a-fe88-9f7109467cd8@microchip.com>
 <YqnSlIcAadwxt1Q5@sirena.org.uk>
 <630d60bc-1322-21a9-e4d1-3eb5af40f8a4@microchip.com>
 <YqnVVizga14qNxkt@sirena.org.uk>
In-Reply-To: <YqnVVizga14qNxkt@sirena.org.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29861162-9096-47ad-e304-08da4ecdd5df
x-ms-traffictypediagnostic: DM5PR11MB1785:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1785093D6326FA7AB1F35BAE98AD9@DM5PR11MB1785.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jV34YwcPcEZADSOUVU6XRc+LLfHnJlaq+uom3Bk6tuB1Sc2+XMfTsOls9CW9pXBqx84yORDL4SSYaVw1BtpaWLhaNKPprjkYDjtxkAa1ZJ2YFhp5o1asOwszfhKQWhEKZMQZxAfQitH0irQNIHTwW/e7brfV0mA9Xt7D+gE6WnHk+ZgDmwRCiTMImqd4aCce+ympcXtl9t65SeSDQ2BIkRPlMNurVwS+tLy6l+hCFu/fzESdfKREi+szOpVnlZbKvK2auDw17Rx7oeGKegCJMYIo+fjaHQqZH9VGYHFExpB5CW9nmtOPWYI0EOpi44VzmYGhmS2Ao9n6pKleqXYRrrZ9eHovXXRJvMF+5Yoze20DmC8NnKj7H2xdCqH0oyktZ1Ax3J30QSo0SqQRqIE9FEuDxMnKREFMV1ASZDFtuKFiOoGrxnCz9eidwtmWLibZcwh7sS5wXwldm/KXoyYGhNGFjrqnRFr12ImC4KPyqRa6A5y7irQ86/qn5ylBkWzInijjTKC32hLOTNQUs0w1ndIz1fJV/2c/i5Tas16jkxAgv9yZj04JqG0eeZLjK28/nwGUTj4bW6hFgk0n4e/+PBb7E0+fwrSWvBjs/0X7IiFBj242HWLkH3LlmZOCc65C2lvYSLWVqYFEGNxPpFOhMujw+zTnL7OTulckfI5Iwus2lq7LXqZNHEAI/GtvY7iTcS7tVXHhMXh+UB17GacQ5JY+Wzj5FFgtBUarLt0OH2sNy60P/3dTaUsv3IFdUxHgwese/KL4Wpqml6MuMk1qNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(64756008)(4326008)(91956017)(66476007)(8676002)(66946007)(31686004)(66556008)(38100700002)(316002)(2906002)(6486002)(86362001)(71200400001)(66446008)(83380400001)(31696002)(2616005)(76116006)(186003)(508600001)(8936002)(36756003)(4744005)(5660300002)(53546011)(110136005)(26005)(6512007)(6506007)(54906003)(122000001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnIvRjFpWDJ5bktlNzNNWXNYZ2xHM3Y0NkVJUzg0bU9pR2dYWk5QbHpjRGpE?=
 =?utf-8?B?YWFaZlI3OGw0aG9mb3c1NXVjemtqV3loOFFIWGRVYWszVU5kcWZMZEVoTSs1?=
 =?utf-8?B?ZlFmNGYxN3ZsL1BTSnFRWSsvMGtHWlptYzVGeVFXZUhIYWtKbzlOb0ZHcmZN?=
 =?utf-8?B?a1VFVlBwYS9NMVdhaElkYjFpNFNyc3FySG1Oa2hzcy9zQmFRbEFrMUhQZzZl?=
 =?utf-8?B?WnR1VkdKTy9lZ0pwL2ErbHc3QnJSSXhoQ3pQS3d3K1ErVnNlWnpGeTVoQzlY?=
 =?utf-8?B?VHF5eXlpbWpCdWd0MCs4RFdtU0ZiL3hFUGtoZFpTdXRURFFDNngwcHhhcDd1?=
 =?utf-8?B?OXNQdk05akpBOVVGaGREZUhZZ3cycWtOaUhaTm5EZ1hMbzhDZVF0bWd5L1Ez?=
 =?utf-8?B?bmxwdlhtajB5cVFDMGRvN3BJYVBETTNrVkNHOGZTTzNwa0RFZkFoelRrcUty?=
 =?utf-8?B?dWdFblF6SzhGeFF5b0QwOU5kTkRKMHRVNi9uaVB3dUg3MnVPZXVtZW9zRlJN?=
 =?utf-8?B?YUpYVjA4SEtwazVaQ3JvSmZ6cXhqQXBlcnYyUWpJblhUMy90WUhadXRiVjgr?=
 =?utf-8?B?V012ZGhCcmZPb3dyWGpuZXdPZ1FyTkI3VUNOOHNoTHFnY0ptdXpUSEordFha?=
 =?utf-8?B?QVcvTUYyK212LzFpZC9GeEhZdUc5VFFPb2w4SUV4NjFlTEE4OHBKOVRwamF3?=
 =?utf-8?B?REkxZGVVWnN2ckpmcjNkcnovcFpxK1pWSlBaZnZMQ0djK3FvUm5kRkRyb2lr?=
 =?utf-8?B?WGhiUVVKVzNqaDg3UmF0T25RTmk4ZWhuYm5GS0M2Q2k0OEpIUmpzU0x5M29X?=
 =?utf-8?B?MVJvUXhwUWh2bXdOWVdrUk0yYk1QOG1hTXlETVZDdVZHVG1SWkM4MFhaWUFC?=
 =?utf-8?B?ZW0xYk1OZC9hQjBBWk9FZGwzamFjUUVweW5Tc0N1WFcwMndKMmUzRFlBQm9I?=
 =?utf-8?B?N3JjNldkNHErUTBMR0JhWm1aZnZnMzIwbDJEeVhpSktTc3ZTNlUwUmRtMXk5?=
 =?utf-8?B?M3RaQWp4Z2xGdEp6M1kwb1V3a3F5SHVtU1JKekhDa1BTb2xTVURjYnQyTTVl?=
 =?utf-8?B?RnRuTzhWeHVXQXUwK2QvYXBxMm8yVnY5OFZhVHpPTXNVMnlkT3VIMGM2aEtB?=
 =?utf-8?B?ZlUvMkJjSyt0ZCtPNnlMR3AzdUl3M2RaeEhxc0RGVUpXT2x6YUlYNUZBRG54?=
 =?utf-8?B?UWFKQ2JmWlV5OTg1cTJrc3JWUzQ1ejNLN3JZcjkwUGZwcmQrMndNRlRTbzlh?=
 =?utf-8?B?YUI4UzNNUFE1N0kxM2h4V0dMd0VqTjNCU01CVDVpK1ZSSjNZOGdJclRpTExM?=
 =?utf-8?B?QWRUcExaVFNzNjJvaW9hKzhwQ1B4MTlqTWgzWlB6MWNVMEMrQ25lSThXQzNm?=
 =?utf-8?B?R1lwS2QzWDhTSUlnR2E4UU90N0FPQVJDM2pudGZ1cGcxTlJDSHR6c21YaXcx?=
 =?utf-8?B?R29YNzVuSUlsV0t1MlNwa3RielhnTGNudmpuUnR1RG1ZSXFmaUx2RXNkL0pC?=
 =?utf-8?B?K0pDYml0dURNQlRTQnA5ZGdxeVh1S05uZ3g3ZE1qdkVKVGZFL3BzYU9pU0tN?=
 =?utf-8?B?T21TeWdXME16eFRwN3c2VXlmL0FRd0FlOWU2YzFreENwQkpadXZUS2lyck5n?=
 =?utf-8?B?MzJtcStiR1c3T04xTXJ4ZHFpVEdsVkdORXROME13Qk80d1dXNlRRZnkzbnFC?=
 =?utf-8?B?U3R0dElDbm5wZkNPUG52M29JSlB5eTQyTldBUlhzblNWM3RUelVCSEJWbng2?=
 =?utf-8?B?ak52QzRFb0VPZmtDL1VJNHZ1SVNQQ0RRSDhCVzJzWCt5Sjd4Yk5QZVE2TnRw?=
 =?utf-8?B?OXgzd2F1bWtzN1I5TXZoa3l4V2JnRFRkRCt4cTVlVUpVTXcxbmxSdko2dGdO?=
 =?utf-8?B?S1AyVWZVdml6Zi8rLzRmOGFhSXVkYWhxMUlVM2ZPQ0FnREo3ajZocU14RUVY?=
 =?utf-8?B?MGt1TWFLVXpZYzZzaEF1K3FPLzBsVlBtUDd2UE1uL095N3R1RWxhakJwcSsx?=
 =?utf-8?B?MjZnS2JRU25HSXdHcjdvc0R5bGpobWFFaklUbFJDY1o0eTFDdmtSaDVMdktz?=
 =?utf-8?B?bDZaS2ZVaENaUDdacnh6SHVmeFZQdXpMRVJLbFZWdTVQb2t0ZDV2UTh3LzRa?=
 =?utf-8?B?S2FkaXY5UTRibER0WUVQNy9mdzdKVmZMeEpTSkl1WG56TENIcEtMYklwUmJq?=
 =?utf-8?B?cWk1Wk9jTHRaNlVkZG51eWl3dnJ3UXN1aVN1eHliQmU0T2g4UHhraGtSNHB5?=
 =?utf-8?B?M3VKcDJ1ZmxuSmNjdGNDSzFIa2tWVWhUWDhqZUJKbTA5RFVRZ01NWDEwbDB3?=
 =?utf-8?B?Ym5NNTVJbHFSTmoxS1l0RUY3aU52Mk0xalgxUE42Y3NsMHlSOGNEQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <708F6F8AFB87584E9CFF2B3B706858B9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29861162-9096-47ad-e304-08da4ecdd5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 12:51:58.9515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwX+evjcy4otWYQG6gaUSSwccilHZRi8Zvbz4EOHmzetjQbe+mLJY0deToU4R79tP7n5I6Wov9GMgdKdyE9mwpS3DkKgN4yxOzlk20DPU68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1785
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUvMDYvMjAyMiAxMzo0OSwgTWFyayBCcm93biB3cm90ZToNCj4gT24gV2VkLCBKdW4gMTUs
IDIwMjIgYXQgMTI6NDI6MjdQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+PiBPbiAxNS8wNi8yMDIyIDEzOjM3LCBNYXJrIEJyb3duIHdyb3RlOg0KPiANCj4+Pj4g
QnV0IGlmIHNwaS0+Y2xrIGlzIE5VTEwsIHRoaXMgd2lsbCByZXR1cm4gMCBmcm9tIHRoZSBwcm9i
ZQ0KPj4+PiByYXRoZXIgdGhhbiByZXR1cm5pbmcgYW4gZXJyb3I/DQo+Pj4+IElmIHRoYXQncyBu
b3Qgd2hhdCB5b3UgbWVhbnQsIGxtaw0KPiANCj4+PiBPaCwgaGFuZyBvbiAtIHdoYXQgZXJyb3Ig
Y29uZGl0aW9ucyBjYW4gY2xrX2dldCgpIHJldHVybiAwIGluPyAgVGhlDQo+Pj4gZG9jdW1lbnRh
dGlvbiBkb2Vzbid0IG1lbnRpb24gYW55Li4uDQo+IA0KPj4gSWYgIUNPTkZJR19IQVZFX0NMSywg
KHdpdGhvdXQgd2hpY2ggaXQgd29uJ3QgYm9vdCBvbiB0aGUgY29yZXBsZXgpDQo+PiBidXQgSSBk
b24ndCB0aGluayBJIGNhbiBiZSBzdXJlIHRoYXQgQ09ORklHX0hBVkVfQ0xLIHdpbGwgL2Fsd2F5
cy8NCj4+IGJlIGVuYWJsZWQgZm9yIG90aGVyIHVzZXMgb2YgdGhlIEZQR0EuDQo+IA0KPiBUaGF0
J3Mgbm90IGFuIGVycm9yLCB0aGF0J3MgcmV0dXJuaW5nIE5VTEwgYXMgYSBkdW1teSBjbG9jay4g
IFRoZQ0KPiBleHBlY3RhdGlvbiBpcyB0aGF0IHRoZSBkcml2ZXIgd2lsbCBwcm9jZWVkIGFzIHRo
b3VnaCBpdCBoYXMgYSBjbG9jay4NCg0KQWhoLCBjb29sLiBJIGd1ZXNzIEknbGwganVzdCBkcm9w
IHRoZSBudWxsIGNoZWNrIGVudGlyZWx5IHNvICYgZ3VhcmQNCmFnYWluc3QgYSBkaXYgemVybyB3
aGVuIEkgYWN0dWFsbHkgZ28gdG8gdXNlIHRoZSBjbG9jay4NClRoYW5rcyENCkNvbm9yDQo=
