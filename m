Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04203508554
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377440AbiDTKBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377403AbiDTKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:01:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9AA38BF0;
        Wed, 20 Apr 2022 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650448699; x=1681984699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9mcX9GjTa4EAP7jlXmda/t5QvG+Gj6tO7dlqgHJ8Ncc=;
  b=ag429FYBPX/oOKiJWEw0W1EC58Ue4LTsv3x3NMpz2RopQYp4+I023Qcj
   BkllBgSqjr7T5u9ibB5QGt9mATZ3P9sDflIVKiH0kigG3RmdtOcFmX1O2
   6UlEbu0tZu8HZVzYJIfmpetGSa9MBOLEu8551oNDoI4Pd1xDInwbsle7i
   qPGXFmcyrz1+V5Dy/2ZBfxSfC+LvmiAdvB9n816UyknWvXA+erMWxl3th
   VLai+5KD40jw6x4SbkcBL9Pj95Cvsfxgj16LS/g70SGJp5Ipw5hc78/jS
   wZs4lib3MQES+CFXP4Oo3i2diWkNtLIl4epbT4A1ElEY13tna1Nle+Flk
   A==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643698800"; 
   d="scan'208";a="160674514"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2022 02:58:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Apr 2022 02:58:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Apr 2022 02:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBriRIGfH+AccAM2SXtKwuC5Zh7go0mrYqGalYyuFNqoNjVyRiT9tCBzAl4I+QtBWBMgyEralC11kVV/vPUp3XHpBveKbN5wvuQ7gndyi/6/DfcA8bQMKqkqOpiU0lohO4e9qx3eEYsGSfBdVWDlIkobCM9REQKc2JH1bUsAb3RG00ER8l71pVLm5vcy5x723EF/cyZoUoaaWhibx7CT4TkM5hrh5guvAkJohihy19NXncoPdQODCGY+9VG1wKp/ad4Fb73CoL+LYGRu/PHOchuflSS4cn/taILzl3N7e1uRXpFnhgSPQkoTK7YHWTJryi0iFIq3PdDeyuLQ0Mlywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mcX9GjTa4EAP7jlXmda/t5QvG+Gj6tO7dlqgHJ8Ncc=;
 b=ZMOisUwVGajXOfAcHrYyGExzYC2JCBEvwtSF/b2yGWdKB83cgaLSRXyE/0jZc+L5M4q8Y6B5NiUCDdta2Pr/FyhjI9HDB4jhvVM5nCnR64X/J67imTwWBHV84zq20qlGieDU8PN0tw2PnNLm4E8HiLqJN13OykoIgRetN1zT53zUb0ZaBYtS+BClbNGzFxCyz7TFC13s6B5g0Ma44m92p1icMhR07Br7sZ7EqLmOZeFxQ3M8RM4YAQLwCCUGgmReMtU48rvgOIiK3MEOdYTNDAay9EkZneHKw3IzdIg31jbwnIbJxXBm/R6woAMWhpD0qBnDksDO9UQcb8n0Blr1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mcX9GjTa4EAP7jlXmda/t5QvG+Gj6tO7dlqgHJ8Ncc=;
 b=NvpwjRbSgF2MkjLFHKG6/87vfjMGEA8r7XHdj5cwCKhNa0mDT/FSJgD0HYRLs+h++xPHH1z4T6at+gKQR6ANjbxAb2pM1otF9giQMQDXs0WqFeZMlw4xiOQ1ietR8/lq152882EV0aEA3Ae9BZvowkgBembXZk2MpMoHbI0k56I=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 MWHPR11MB1439.namprd11.prod.outlook.com (2603:10b6:301:9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.25; Wed, 20 Apr 2022 09:58:07 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::e18a:23c1:abed:64a0]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::e18a:23c1:abed:64a0%6]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 09:58:07 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <sha@pengutronix.de>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lars@metafoo.de>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 1/6] ASoC: dmaengine: do not use a NULL
 prepare_slave_config() callback
Thread-Topic: [PATCH v3 1/6] ASoC: dmaengine: do not use a NULL
 prepare_slave_config() callback
Thread-Index: AQHYMh4Pkh3Y5IW9SU6WaYlYzxi+6Kz4yjoAgAALzQA=
Date:   Wed, 20 Apr 2022 09:58:06 +0000
Message-ID: <968f9bfb-bddf-a8f0-6d8f-18b92d865aa2@microchip.com>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-2-codrin.ciubotariu@microchip.com>
 <20220420091552.GD2387@pengutronix.de>
In-Reply-To: <20220420091552.GD2387@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f23ae43f-6f90-49e7-e57f-08da22b444d9
x-ms-traffictypediagnostic: MWHPR11MB1439:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1439B6A32F8D730708B4A477E7F59@MWHPR11MB1439.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBffF2lF7vKeOAhyjyTp6gtYdJVC24RwTnTh06/73Veh8DvQug7diUyo1i5RhsMGGUDHMWr9pzKlHxEMgYCFCHzwzm+lUAruUr2Ngzvjce/iIP4xXUuckM+4euWsWjBUCqimkJNNnpl/lu+fO8DADJ3GHH4mgjqRkrFo0yWPKAUiB3a3uA5woty5WnfnQeXFycm/pWp4g7JBshQ5DLa3Q/90CdeXB1kdgUSsYJByIYbt+LnML1CL8Pnpt0Kj8cLKTJOCT6zqvJfxW55geJHfJxeizTVN3KrHJX562DrKq6ZgjEf/NSyfs1aDOrUBZ56x4LZ437a+fbO1bAkUHbGGOx3PAO7YYNFoD9DwopBbUqpMgYTnWZw36VvlOeqKohBQicQooqcVVW3+n0uhRHgdL8it3FPmnDOW3fqYn+y3SjigSfB/X99U6gy0ldUR+gZdVGVZqLjJgalC+0t4EefpRlOIXxNrbtKouSvgg9XJmW7+/NkYpTfgMbFn2ERzEd2lK/fUDMJkO8Zy3jZbbBvJevt0F7ZOWqWC7RvD9bh6X3J0PMM8vvk9IKd6/gLi57XUX7xUh6guWrOHsDly3bHdJmlj4lsjCqlm1YegmU+1UNNDjk8ANzWOb3UapDRnRJzPraO78QEGRdFTR5J9Q6vvEJBzS9x991hEbKzubgl3lwJDVrHyfJ4Uvx62yQciMMbwpCwh3bDuooHXjSrw8HEt58q4oofBL7ZrEaN7PSykZQoFRBpoW9Cbdr7q5sm9MdcghtBGHeGvqgndCW/ZUlL9UqTznt/I36Ofm9JAu8GZ57p9Sdhqhwb7fgS0LgSEyliU/GlWHT/gsPItvOn0jJBgsPR0JYLkoynsZWAvVOiWuR4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(122000001)(53546011)(6506007)(8936002)(31696002)(2906002)(36756003)(31686004)(5660300002)(6512007)(7416002)(2616005)(38070700005)(508600001)(6486002)(38100700002)(316002)(64756008)(966005)(86362001)(6916009)(54906003)(186003)(66446008)(83380400001)(66946007)(8676002)(76116006)(66476007)(66556008)(91956017)(71200400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkNlNWEzT0VGdWVieXExOWhrd2dxOEU5VjQ3Wk5tbVNxVnZ6cEZ6cXJRcEVj?=
 =?utf-8?B?eEhWclhld3FMc1VIZjBIbWt6WXdqazNCZmtHL0g4enN6ZldqVngya1ArS2hv?=
 =?utf-8?B?RUoxSFZ0by94OHFVYm1LbkRMZWhOUkFUL3NoTWg0cGZoQnJKcUJBUDBvN2VX?=
 =?utf-8?B?bG8vaTFibjVxUXdJVkI2a2V1am9qeUNqMCtXWFh2Tmp4TTZPNGJUaS9CVWdC?=
 =?utf-8?B?NXpkLytsS3Awbk9JWHcxQmpmOCtCZ1lnUEVvZEFnVWpZbUdSVHdIaUM5Ynpm?=
 =?utf-8?B?a3VMYS9CY2s3Q1pnYmRJQVZBZXBaOWpPVFNFTW11WS9sZ0VvNDk4ekNIc0t5?=
 =?utf-8?B?R3F4TmpiMmMzOXkrZWYrZm82dkh1RGd2UFVWeTE0Y0V1eGRGWXFQMHF6UWhS?=
 =?utf-8?B?RDlnV1FHN0FyYkdSSmx3Q01qcksvd1F5bjBqdGFraVN5SFBYQkZOeEwvWUtO?=
 =?utf-8?B?enRZUVhTZmxXTy9JWGxmTWJoR3VFQm1tZ2NRbm8vS3BMSWp1RkZoRXQzRU94?=
 =?utf-8?B?U1g0blAyOG9HN3F5clFxaVNqYUZZamdMdVRLRE5IMmFmSmJIck9sY2tYdnhP?=
 =?utf-8?B?L1NlWDF5QVQ5RlRWYUNxaTdSdFF2R1hhTjJCRE04NXFSNTlpM1VTQXAxWEZh?=
 =?utf-8?B?RlZZdTNYZEd1Mk9TT1IzNEF6dEc4ZlJ2RVJOYUtRRjBnd3hvbEZPOVBSbVhv?=
 =?utf-8?B?Q3AwM3l0NG9OYUZxRFRxdjB5QnpranhZUjBlWEVXSW1wYW1zMEVtWEVzL2JG?=
 =?utf-8?B?VEFlN3NPSFRsVjdEREkzWlZtTEVqZC9BUVhpVjZtZzk3a0ZGUGY3WWhHNFor?=
 =?utf-8?B?ck5Nakx6Zk5CbmFDRVZIb2dFR1F5OGVvRldjQVB5TUdRU3VGbi9ZNE9yNk8r?=
 =?utf-8?B?QlpKcisxdFMzYmllWmEraHRiZDZXK2NqYk9NZlI0M202UURUMmI3ajF2U1dF?=
 =?utf-8?B?dzRNcmxZUUZCQ1FUM3VQNGVOeGQwWFBYa212OHpTZjBoZkxzM2puV3N2WWE1?=
 =?utf-8?B?Umxqdk5BUFFUNTk3Z2t4bSszWEdhR2tMRG5ldjl5eVkwY01zU1VvQjMxdDFL?=
 =?utf-8?B?MzlkNnp2NFZENEF4Qkt5b0o1Y1hWUXFScTJKaHR5eHFHQXpJNzNzcld2UnRa?=
 =?utf-8?B?UUhlZmw4Z09FaXdRRmNkUzVTS0FnRzZGQ3lqSHJQN3h5elc3SUxDMEN6NWlr?=
 =?utf-8?B?TytPT0JzYTE2SnFYRmNDK1VpcE44bDY2dkpxZEk4TDhJMkcxUGtXdDR3R0NH?=
 =?utf-8?B?bVpqUVU4RWVRQ1p1NkNyLzUrU3V3SHY5WkhLblRWUXQ5eUNDa3ZIMVRFWnF1?=
 =?utf-8?B?QW9YNXhodnljNUJsS2tSV21yVDhyR21kaDZ4U0UvZnNxcXBwWWloalFCS1Y5?=
 =?utf-8?B?V1paakFxL290OVlBRFlCV3I0TVpEcUd6ekhEUVpoaStNK0VmM044OS9URTIr?=
 =?utf-8?B?Rk1ZcDh6alpiSEdieG9lUndSL2hkRmlTaWloU21yK2lDWkY4UUZPZFJwd1Ux?=
 =?utf-8?B?YXErUitjdHpiNUNPN0pMM3pvRzNKM0VsVEx1WHNlU2tmaitqNi9MZGw0clNP?=
 =?utf-8?B?ZXlDUGgybk5hV05RNWQ2RTFMTGxZVm4wM3REWlF4ZzFtUmQ1YUpPekEvdytT?=
 =?utf-8?B?ZVZ3djA0ZXJGVlNLWFhCTUtRU0pnWFFUNHQwWXhpbmQwaVIyamNvaUw2aGsy?=
 =?utf-8?B?M3JCaUE5djAxWXN3aVRZUmNHOS9VdlZPZU9tL1RjZi9oU3NtaE41Y1BmQ2pj?=
 =?utf-8?B?dlF3SFhNSDk3SC9WMUQxMkhZdDVBQVJ6WjBFeUtxM3FndmNJYkg1RCt4QVZ5?=
 =?utf-8?B?TVF6UC8yWldBZ0hjdlU0V3V1SjA3YUl4TGs4Q2lYRlJEeDhOZFVOcDZhcVAz?=
 =?utf-8?B?SHprNitrR2JsM25ld25Jbjhaemh2RHp1MFJuTHlRdmJ5YSt4UW8rTVRlMnZV?=
 =?utf-8?B?cU9vVldLeEFYZEV4dC9iUmZIZTdYTHdjNnFHMVFSZk11eU1HaXNqallGeGZI?=
 =?utf-8?B?ajZCUENSOWFEVXFTRFlOOThTNzlxemFzOFJoblk1RERobTZqTDA5TERvMmhO?=
 =?utf-8?B?eWpoVjlOYmF3dldPRFJocHo1aVd1eWxOeHROb05YRnRRai9lOTVKOW1XbkhJ?=
 =?utf-8?B?ZjNka1dRWUxTeTdadk5KWFYxdFdyQlJzYk9BL3RBKzNLQnp1TXhNQno0dG90?=
 =?utf-8?B?ZE4wMlZrOE9jZzQxbXRvbHNLcTdWbUhXMmRIYStqUXZnaWVmRVdLSWIxa2dW?=
 =?utf-8?B?Rm1SbmhlRjV6bloreDFBam9EcmJqMndoQWh2cVF3QUJMZjJ3akNwOXRqS01i?=
 =?utf-8?B?dkdzVmxsRGdlbXNRNFMzOE1qYmoxa1c2UEs1d0dmeGx3dnc2dDBuWWlsNzZ3?=
 =?utf-8?Q?bs748QCKtXNMIa9NOeKRKDb8Rmqos4WatjvDJMFHdedKY?=
x-ms-exchange-antispam-messagedata-1: PXzsTdYEeHCWv1O60JyXUjHUmAc+VQTxTFw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15088BB7EB99634A94E6BE1A123A88A3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23ae43f-6f90-49e7-e57f-08da22b444d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 09:58:07.0153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+Obn/ZzJ/TUhV/EHSUZakWPHMEQKJgvf2EcM7RgLVRH+/BuuNLX+7Q/X4WG800hnjOKxf+oXqZZxjJ8uDgHsNhVUSusx1yPeOVpNkjdQMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1439
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDQuMjAyMiAxMjoxNSwgU2FzY2hhIEhhdWVyIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KDQpIaSBTYXNjaGEsDQoNCj4gDQo+IE9u
IE1vbiwgTWFyIDA3LCAyMDIyIGF0IDAyOjIxOjU3UE0gKzAyMDAsIENvZHJpbiBDaXVib3Rhcml1
IHdyb3RlOg0KPj4gRXZlbiBpZiBzdHJ1Y3Qgc25kX2RtYWVuZ2luZV9wY21fY29uZmlnIGlzIHVz
ZWQsIHByZXBhcmVfc2xhdmVfY29uZmlnKCkNCj4+IGNhbGxiYWNrIG1pZ2h0IG5vdCBiZSBzZXQu
IENoZWNrIGlmIHRoaXMgY2FsbGJhY2sgaXMgc2V0IGJlZm9yZSB1c2luZyBpdC4NCj4+DQo+PiBG
aXhlczogZmE2NTRlMDg1MzAwICgiQVNvQzogZG1hZW5naW5lLXBjbTogUHJvdmlkZSBkZWZhdWx0
IGNvbmZpZyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNp
dWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IENoYW5nZXMgaW4gdjIsdjM6
DQo+PiAgIC0gbm9uZQ0KPj4NCj4+ICAgc291bmQvc29jL3NvYy1nZW5lcmljLWRtYWVuZ2luZS1w
Y20uYyB8IDYgKysrLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2MtZ2VuZXJpYy1k
bWFlbmdpbmUtcGNtLmMgYi9zb3VuZC9zb2Mvc29jLWdlbmVyaWMtZG1hZW5naW5lLXBjbS5jDQo+
PiBpbmRleCAyODU0NDFkNmFlZWQuLjJhYjJkZGMxMjk0ZCAxMDA2NDQNCj4+IC0tLSBhL3NvdW5k
L3NvYy9zb2MtZ2VuZXJpYy1kbWFlbmdpbmUtcGNtLmMNCj4+ICsrKyBiL3NvdW5kL3NvYy9zb2Mt
Z2VuZXJpYy1kbWFlbmdpbmUtcGNtLmMNCj4+IEBAIC04NiwxMCArODYsMTAgQEAgc3RhdGljIGlu
dCBkbWFlbmdpbmVfcGNtX2h3X3BhcmFtcyhzdHJ1Y3Qgc25kX3NvY19jb21wb25lbnQgKmNvbXBv
bmVudCwNCj4+DQo+PiAgICAgICAgbWVtc2V0KCZzbGF2ZV9jb25maWcsIDAsIHNpemVvZihzbGF2
ZV9jb25maWcpKTsNCj4+DQo+PiAtICAgICBpZiAoIXBjbS0+Y29uZmlnKQ0KPj4gLSAgICAgICAg
ICAgICBwcmVwYXJlX3NsYXZlX2NvbmZpZyA9IHNuZF9kbWFlbmdpbmVfcGNtX3ByZXBhcmVfc2xh
dmVfY29uZmlnOw0KPj4gLSAgICAgZWxzZQ0KPj4gKyAgICAgaWYgKHBjbS0+Y29uZmlnICYmIHBj
bS0+Y29uZmlnLT5wcmVwYXJlX3NsYXZlX2NvbmZpZykNCj4+ICAgICAgICAgICAgICAgIHByZXBh
cmVfc2xhdmVfY29uZmlnID0gcGNtLT5jb25maWctPnByZXBhcmVfc2xhdmVfY29uZmlnOw0KPj4g
KyAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICBwcmVwYXJlX3NsYXZlX2NvbmZpZyA9IHNuZF9k
bWFlbmdpbmVfcGNtX3ByZXBhcmVfc2xhdmVfY29uZmlnOw0KPj4NCj4+ICAgICAgICBpZiAocHJl
cGFyZV9zbGF2ZV9jb25maWcpIHsNCj4+ICAgICAgICAgICAgICAgIGludCByZXQgPSBwcmVwYXJl
X3NsYXZlX2NvbmZpZyhzdWJzdHJlYW0sIHBhcmFtcywgJnNsYXZlX2NvbmZpZyk7DQo+IA0KPiBJ
IHdvbmRlciBpZiB0aGlzIHBhdGNoIGlzIGNvcnJlY3QuIFRoZXJlIGFyZSBkcml2ZXJzIGxpa2UN
Cj4gc291bmQvc29jL214cy9teHMtcGNtLmMgd2hpY2ggY2FsbCBzbmRfZG1hZW5naW5lX3BjbV9y
ZWdpc3RlcigpIHdpdGggYQ0KPiBjb25maWcgd2hpY2ggaGFzIHRoZSBwcmVwYXJlX3NsYXZlX2Nv
bmZpZyBjYWxsYmFjayB1bnNldC4gRm9yIHRoZXNlDQo+IGRyaXZlcnMgZG1hZW5naW5lX3BjbV9o
d19wYXJhbXMoKSBwcmV2aW91c2x5IHdhcyBhIG5vLW9wLiBOb3cgd2l0aCB0aGlzDQo+IHBhdGNo
IHNuZF9kbWFlbmdpbmVfcGNtX3ByZXBhcmVfc2xhdmVfY29uZmlnKCkgYW5kDQo+IGRtYWVuZ2lu
ZV9zbGF2ZV9jb25maWcoKSBhcmUgY2FsbGVkLiBBdCBsZWFzdCBmb3IgdGhlIG14cy1wY20gZHJp
dmVyDQo+IGNhbGxpbmcgZG1hZW5naW5lX3NsYXZlX2NvbmZpZygpIHdpbGwgcmV0dXJuIC1FTk9T
WVMuDQo+IA0KPiBBdCBsZWFzdCB0aGUgIkNoZWNrIGlmIHRoaXMgY2FsbGJhY2sgaXMgc2V0IGJl
Zm9yZSB1c2luZyBpdCIgcGFydCBpcw0KPiB3cm9uZywgdGhlIGNhbGxiYWNrIGlzIGNoZWNrZWQg
YmVmb3JlIHVzaW5nIGl0IHdpdGgNCj4gDQo+ICAgICAgICAgIGlmIChwcmVwYXJlX3NsYXZlX2Nv
bmZpZykgew0KPiAgICAgICAgICAgICAgICAgIC4uLg0KPiAgICAgICAgICB9DQo+IA0KPiBJIGRv
bid0IGhhdmUgYW55IG14cyBoYXJkd2FyZSBhdCBoYW5kIHRvIHRlc3QgdGhpcy4gSSBqdXN0IHN0
dW1ibGVkIHVwb24NCj4gdGhlIGNoYW5nZSBvZiBiZWhhdmlvdXIgd2hlbiByZWJhc2luZw0KPiBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvYWxzYS1kZXZlbC9wYXRjaC8yMDIy
MDMwMTEyMjExMS4xMDczMTc0LTEtcy5oYXVlckBwZW5ndXRyb25peC5kZS8NCj4gb24gY3VycmVu
dCBtYXN0ZXIuDQoNCllvdSBhcmUgcmlnaHQuIEkgY2hhbmdlZCB0aGUgYmVoYXZpb3IgZnJvbToN
CmlmIChwbWMtPmNvbmZpZyAmJiAhcGNtLT5jb25maWctPnByZXBhcmVfc2xhdmVfY29uZmlnKQ0K
CTxkbyBub3RoaW5nPg0KdG86DQppZiAocG1jLT5jb25maWcgJiYgIXBjbS0+Y29uZmlnLT5wcmVw
YXJlX3NsYXZlX2NvbmZpZykNCglzbmRfZG1hZW5naW5lX3BjbV9wcmVwYXJlX3NsYXZlX2NvbmZp
ZygpDQoNCkl0IHdhcyBub3QgaW50ZW5kZWQgYW5kIEkgYWdyZWUgdGhhdCB0aGUgY29tbWl0IG1l
c3NhZ2UgaXMgbm90IGFjY3VyYXRlLiANCkkgZ3Vlc3Mgc29tZSBkcml2ZXJzIG1pZ2h0IG5vdCBu
ZWVkIGRtYWVuZ2luZV9zbGF2ZV9jb25maWcoKS4uLg0KSG93ZXZlciwgaW4gbXkgY2FzZSwgZm9y
IHRoZSBtY2hwLXBkbWMgZHJpdmVyLCBJIGRvIGhhdmUgcGNtLT5jb25maWcgDQp3aXRoIHBjbS0+
Y29uZmlnLT5wcmVwYXJlX3NsYXZlX2NvbmZpZyBOVUxMLCBidXQgSSBzdGlsbCBuZWVkIA0Kc25k
X2RtYWVuZ2luZV9wY21fcHJlcGFyZV9zbGF2ZV9jb25maWcoKSB0byBiZSBjYWxsZWQuIFNob3Vs
ZCB3ZSBhZGQgYSANCnNlcGFyYXRlIGZsYWcgdG8gY2FsbCBzbmRfZG1hZW5naW5lX3BjbV9wcmVw
YXJlX3NsYXZlX2NvbmZpZygpIGlmIA0KcGNtLT5jb25maWctPnByZXBhcmVfc2xhdmVfY29uZmln
IGlzIE5VTEw/DQoNCk5pY2UgY2F0Y2ghDQoNCkJlc3QgcmVnYXJkcywNCkNvZHJpbg0K
