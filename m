Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2A955D7C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiF0M0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiF0M0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:26:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552962AF6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656332804; x=1687868804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o0hlgqge4vBLcDbmlxxHLGco8WrvdV4A0094ftULd7c=;
  b=FF6lGTizgDWqN3W4MQQvqqRpoNj5MzqCm6yO0gcaWsFkMFoR9XDz0yXV
   LUpYqqC/mySLrqsoy0pyGecgf9QLD3yFiHWtWQV3jxP3iABvwIqBxgVqP
   1mJgjFmn2Ade/v4Ow54RRilk+1K9J7jQXnuN5JbqhkLP0cCFKcVTpp0Px
   VmQKwvA62v1nERBNqlJ5zipEuOAeKMUmWYpNk/42UUgF2FJDFMI38bU+Y
   FEeedRyYUb6J7GjxuonW+T3MoFJF1L5qmsvz618ztZ5FUZbYVOyJXxckp
   L4aI0M9w53GqaQCt6jxhWCIoaIZUVIR/7CAXbOcr+akeo0S+PB3pztHjb
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="179648349"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2022 05:26:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 27 Jun 2022 05:26:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 27 Jun 2022 05:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOKoxTVFQELP8iPDtbkzgm2BE0HSvpeoTctG3BHtiDziUjpYFqIA5szVtydQo5hUI5K2RJS9mZT6Qpmex0Rol1mvnoc+UrNPrG8vCQ++UuvFQHCVBZX8d9D+8wfMErgTwPjanoyK6QMC4J4SQa4/UDFyl1EqpJzuUgDInqnWXXL9uUtyboVixEB80OM22WlZA6DnX3Cs8vd4IH4GapLFF372nea56h7PmQCtBGeWNbUFQjU+5l+olqE63YbtBiW/AwSrVmJceoAbGTS1FoEqczZzAjchEoxrf9jAoK+R62oH9YJRfKMJaSfymzwAJbFSu03+Qc1TFqNBh/BOy/4KSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0hlgqge4vBLcDbmlxxHLGco8WrvdV4A0094ftULd7c=;
 b=icX2kmACTBkRsVzMVjjV9D6RzrjmZTNJzf9Q5PBKAKUu2O+nHn9U+0zXdfPIAnvaT1pHNMP+HpvKFPyQ0OBDTo9aYZ9QXf8WksOqYt9rhYjtEPc7PwX/g5y9LnC3dUz8h81HKtCYYhfIWpiQNXJoI3k22KlMRruHrPcwpW0ji9gJcpz5X9KjhnFTzUhTylbzo7Q7EQ+xJC6x1va2jBv4EuJNk0v0mrg2+Yo79kwenYhplh5inodHXmGescZG2KEemJiUw4XwxmY+o7wiwwIRwmN8a3St3um5kh5rneZhoSH1tt8jrgts9+gf/rMSfEY8KKEqdrwtYlFvb1WqqYbm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0hlgqge4vBLcDbmlxxHLGco8WrvdV4A0094ftULd7c=;
 b=djaTfzoFbaOgMPzO1ACUDNwp9KlmrFJ/fB8qfzg89ki3L8CJUEu5QBAZqaPyBuQ9njIW1ugMNV54rHkXOZLIsevhk1NvVPKYL9b8eQCVADsT1hYsGdG9Y60k3nlkSTeqLoP7OaCMNyOQ+eR0li30xYzRMoAOd7DG8UEhmto18hc=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB4300.namprd11.prod.outlook.com (2603:10b6:5:1dc::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.17; Mon, 27 Jun 2022 12:26:39 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 12:26:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <peda@axentia.se>, <regressions@leemhuis.info>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSfw==
Date:   Mon, 27 Jun 2022 12:26:39 +0000
Message-ID: <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <b5c57978-212f-55c4-2f0b-b38a8f157ca3@microchip.com>
 <a024180a-493c-af20-0910-da30dd5fe364@axentia.se>
 <6d9561a4-39e4-3dbe-5fe2-c6f88ee2a4c6@axentia.se>
 <ed24a281-1790-8e24-5f5a-25b66527044b@microchip.com>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d4b9657-4084-4563-0a75-08da58384914
x-ms-traffictypediagnostic: DM6PR11MB4300:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpa716N4YuYGWcix3/Fz2GT79r9lFetIDkk7YTRlQqUIENosYKTA1MekbCyDEvLYfxLxKZaSP44tqe5GkmvxwjHFhETsUePBMVB3NLZ4bJRz+Lu//XAr98PK6/DdHgI/LFqKd+nVOcMufmjHJBp8UTNaXJIfGB9nenUlg/hW7Pvl/T84lnrruQcKUD2DH+ie2HaUDN9seBtjz75cTJ3Km8Hb0hHDmvtxchRpJLwoLfFwvr2EkhyujnKd0HPzqwO057ICo6kjkhHavrNAqpQFOgM/OTGvgaAy+7FVzoJoUWRGmnrUsxXwq2FczdK6KEdv7b2W3uffLbKIzIGxGILYsUuRxE4tcT6IqxoslXh/N3myOnf0IGdpXIecWaZqQ1GK273tg9V4U8Rbej1F/rz3esD/qKD4gnAtS7CF0A3foFCj0ope/8mxJJbRIe9TNuIYnie2u6B+w9yJfaPUTlvN4fxVn0QreqRBrJTe5F0fPK3nm7jEZv0Y3wsRVGVA96zpvqbS68LxNyEkVxY//p3bDoxGntEYS1SIDdv/4j6bkVubwXpWcDyiGTbBa+r7GYHK8n03SxutR2V/fUBxT3ZUAHAP7NqfbbSMU9z3oQEUf0AOwkx+Qxy0pd9nF0NAVn3zFOCIfzxTFTibTFlhtv7WsLIBWq9kgLmuPODrtRV1oSZb4KkjKfxa2DISlhJS4sqEOYkQijhSHtDdkITpM+AU3SwQt0xi1XEMh+PGZ1EP4gfrajSAgs+VryEw21eSzPKGE6Taj1yGFM+TpiR2/KlUyR7VhYnhXUCEeJJYomCOsqU59PviYxiSYR073NHIbcUPB4kPvhApMACLlIreB+YDVIiJyuNgntGON2CdBEy0Tgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(396003)(366004)(346002)(6506007)(6486002)(53546011)(478600001)(66476007)(41300700001)(6512007)(26005)(5660300002)(66556008)(38070700005)(2616005)(122000001)(186003)(86362001)(66946007)(31696002)(38100700002)(36756003)(8936002)(83380400001)(316002)(2906002)(31686004)(64756008)(4326008)(110136005)(71200400001)(54906003)(91956017)(8676002)(76116006)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXdjME8weHh0bG9HT01peGlYejQ0OXR5aUtKSG9zam9mZmdGcjRFMXNCMTRH?=
 =?utf-8?B?a0tuTTdmVDBGdDE1K1FrcXh1SHpUNndVVWhwU3hLb2hJOSsvVUg2S240ZXBi?=
 =?utf-8?B?dlVvb3hFeXpjZzQ1T2Ewc2tRWnhzSVVoYUlHMVpKelVXUmlsbFJ3UUFzRHh1?=
 =?utf-8?B?TTBNakY3WCtpOWRIQzh4SXFWTHdXVmk3TmxxQXBsRUNrTlRmZGhmbDByK3FR?=
 =?utf-8?B?ZHhaN3hJM1NKVWNpOWVxRlM5Q3pXMk9EOHh3OEV6cjdvRkhSVlc5UXZ0Rmlv?=
 =?utf-8?B?UXloUEJTQVAxQytJcUJJSUFsb3puTS92VFNMQU1hMlhtekw0SXhYTTVNdkZx?=
 =?utf-8?B?NitzV3F4ZXNDNWI0YW9MRUhLOHBldlJoc0JPLy9JZk1YN2tVWU15Z2V6MHhT?=
 =?utf-8?B?VHl5Um8rWDRRaWl4ZmEwS3dScmx2aFVqKzVoOGdyK1lXd3JZVEswa1ZSdnBi?=
 =?utf-8?B?cytXa1RIQzNicDhzT2orTmQvWjZlTUpGZ1lmcHdWUmJQQ3QvdStlclZpUHZZ?=
 =?utf-8?B?TlpTWVRCbXdSNXV1aEVnbXJCbWVhQXRjS1l2VTV1V2YrbGFqTVd4alJFZGI2?=
 =?utf-8?B?b1kyVzZIdFdDUHNZaVZwSGNWTTFpRG02QmRSYUlVYVd2NmQzMmhrSDBSRVBM?=
 =?utf-8?B?cTAyZVMyZUNITTliaXFRa2QwbEhUamxFVGV3dFF1ckQ0YUM3dFd1OUJiNVVW?=
 =?utf-8?B?TmhMWFlPZ2FiKzRKTVkxd3VVdlNNUW8wcVBFclhhNkFhTkM4NldlbXBBMkFz?=
 =?utf-8?B?UDRjcjB1bW5aZDNYdzVqWk9vbzZubHp0RDFvL2pxcTNEZHZUUzNFTUlqcEFi?=
 =?utf-8?B?V2lFME1mS2RSVFdMZWxnZHBEU2hmY1RtaFdkWFUrakZ6UkRGZVB1aWxud3JF?=
 =?utf-8?B?bm9MWG9VeXZJWWhNVDlkVE94bGd0R2d6QXdKaGpGbmhYNVZ2STdPNzUvU3Qv?=
 =?utf-8?B?K2FlZmFXMmxNdFd4dWhVZGo1ZVIxQ0MreTI3TjZBR1FSR0praHlRaGg2YUlO?=
 =?utf-8?B?c2tQcVd4WXk5Vm5PYTQ2akhNVTY3Vzd2RUk1Y2E2enR4WnBLUzBNZGhhT1hM?=
 =?utf-8?B?Z2ExMVhETTlQSjllemZPejdVSkh3VXN5ZXNzU0o2TldHeGhUSTBXaE5JQVlV?=
 =?utf-8?B?UGo5Z0U0Sk9ncGh5MFR6Z09GRWlQU0V6VFp4UUJsQ2tKVFdqeEpQcXlmeDly?=
 =?utf-8?B?Mm5mdEQ1dGVBcE4xZDVjYy91NEVlYWZEVXNJSHlVVlZqYW1mY3ZDdXhSN0FP?=
 =?utf-8?B?cGx6WEN2N28wSUZCb2lIbWpPbHRoSEwydm93UFlBTEQ2R1BVWW5FMDNCbkxR?=
 =?utf-8?B?aE50SFRXNW5QT3B4ZlE4ZjB2eEx4WHhURTArUWt4NTY5TjNkYUttcnQzWFVl?=
 =?utf-8?B?bENQWTY5UXVzVm1GK2FhT3dpY0ZyUzc4RGVaMkJOWk9KYUFlc2xiYktodzFS?=
 =?utf-8?B?RzB1MFpmQTlZVjNlbzVYRWdiSjFWNERjVXRJM0oxejZjeHh2WlY3VjdTR2VO?=
 =?utf-8?B?NERqekJFZWdHc0huUnluS0NlMXZxcU1JZytLU2Vqb3NqVnJ0UE9sT3orSE1Z?=
 =?utf-8?B?VWFxNVZVek9hdTB2MERhS1RoWEtpcU10R04zME96c0hEWmRxblpOTGF1b0Np?=
 =?utf-8?B?Nm8veExDUHBmNk9mbUJtSkFWZStMQ2JieENsd3loazVvR2dGK0taTUJ2L3Zr?=
 =?utf-8?B?OGczYzFIWHgxTS83NDA4SWR0WDRiQVNvZXkwYldENVNLZzBWTER2NlkwcXF4?=
 =?utf-8?B?QjFyNUx1Nk5NL0trTTV5aXhQM21pSWtFb3JOY201eXdRODY1OE1kYVlla2VW?=
 =?utf-8?B?VHU5ZjlNZGZBY0hlNzl3MFhhMjZTbXlRTmVzakw4RlZvWnAyKzNrRVJGaVNE?=
 =?utf-8?B?TUpGM2EvRzhYOVg1VElCbk9rZzFURnhUc2hxd0k0NVh4aW9GWnJSeS8waEZi?=
 =?utf-8?B?cmRETys1aE9yRVA0RGVPVTBKdEtaWFlMWWpDcEMzZnlyV0RBYmU2ekRRRkN1?=
 =?utf-8?B?L1NjTTE2alRmRDl0Zm94eTdSTVkyNnU2dW9LNmFabVNYSTBBcXdXd0gwd0gw?=
 =?utf-8?B?VHp2RW9IaFlQWHZaSjFRVHNrV3ZLU1I0SGRQZDNEOHh2Ky9nYVlXMG5rN2xr?=
 =?utf-8?B?TzJIdHVEeVpqUER3RjY2UG4xaEFyZVQwcUVoaFZUUGMvdjkxYlRRVmozTHRZ?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73270A8768037B4ABF3896C07C09F600@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4b9657-4084-4563-0a75-08da58384914
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 12:26:39.3653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcJ4lXgLPBY0Bs5PGg54s3CrRtUIlsnY5Mq/L+tKSqt1QzsIH7GOTWJ95I1Em3ONZrGGP2luttLKkdps7HPamzvooIb58opn00i0qIBVVk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4300
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yMS8yMiAxMzo0NiwgUGV0ZXIgUm9zaW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gMjAyMi0wNi0yMCBhdCAxNjoyMiwgVHVkb3IuQW1iYXJ1
c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4NCj4+Pg0KPj4+IGdpdEBnaXRodWIuY29tOmFtYmFy
dXMvbGludXgtMGRheS5naXQsIGJyYW5jaCBkbWEtcmVncmVzc2lvbi1oZG1hYy12NS4xOC1yYzct
NHRoLWF0dGVtcHQNCj4+Pg0KPj4NCj4+IEhpLCBQZXRlciwNCj4+DQo+PiBJJ3ZlIGp1c3QgZm9y
Y2VkIHB1c2hlZCBvbiB0aGlzIGJyYW5jaCwgSSBoYWQgYSB0eXBvIHNvbWV3aGVyZSBhbmQgd2l0
aCB0aGF0IGZpeGVkIEkgY291bGQNCj4+IG5vIGxvbmdlciByZXByb2R1Y2UgdGhlIGJ1Zy4gVGVz
dGVkIGZvciB+MjAgbWludXRlcy4gV291bGQgeW91IHBsZWFzZSB0ZXN0IGxhc3QgMyBwYXRjaGVz
DQo+PiBhbmQgdGVsbCBtZSBpZiB5b3UgY2FuIHN0aWxsIHJlcHJvZHVjZSB0aGUgYnVnPw0KPiAN
Cj4gSGkhDQo+IA0KPiBJIHJlYmFzZWQgeW91ciBwYXRjaGVzIG9udG8gbXkgY3VycmVudCBicmFu
Y2ggd2hpY2ggaXMgdjUuMTguMiBwbHVzIGEgZmV3IHVucmVsYXRlZA0KPiBjaGFuZ2VzIChhdCBs
ZWFzdCB0aGV5IGFyZSB1bnJlbGF0ZWQgYWZ0ZXIgcmVtb3ZpbmcgdGhlIHByZXZpb3VzIHdvcmth
cm91bmQgdG8gZGlzYWJsZQ0KPiBuYW5kLWRtYSBlbnRpcmVseSkuDQo+IA0KPiBUaGUgdW5yZWxh
dGVkIHBhdGNoZXMgYXJlIHR3byBiYWNrcG9ydHMgc28gdGhhdCBkcml2ZXJzIHJlY29nbml6ZSBu
ZXcgY29tcGF0aWJsZXMgWzFdWzJdLA0KPiB3aGljaCBzaG91bGQgYmUgY29tcGxldGVseSBoYXJt
bGVzcywgcGx1cyBhIGNvdXBsZSBvZiBwcm9wb3NlZCBmaXhlcyB0aGF0IGhhcHBlbnMgdG8gZml4
DQo+IGVlcHJvbSBpc3N1ZXMgd2l0aCB0aGUgYXQ5MSBJMkMgZHJpdmVyIGZyb20gQ29kcmluIENp
dWJvdGFyaXUgWzNdLg0KPiANCj4gT24gdGhhdCBrZXJuZWwsIEkgY2FuIHN0aWxsIHJlcHJvZHVj
ZS4gSXQgc2VlbXMgYSBiaXQgaGFyZGVyIHRvIHJlcHJvZHVjZSB0aGUgcHJvYmxlbSBub3cNCj4g
dGhvdWdoLiBJZiB0aGUgc3lzdGVtIGlzIG90aGVyd2lzZSBpZGxlLCB0aGUgc2hhMjU2c3VtIHRl
c3QgZGlkIG5vdCByZXByb2R1Y2UgaW4gYSBydW4gb2YNCj4gMTUwKyBhdHRlbXB0cywgYnV0IGlm
IEkgbGV0IHRoZSAicmVhbCIgYXBwbGljYXRpb24gcnVuIHdoaWxlIEkgZG8gdGhlIHRlc3QsIEkg
Z2V0IGEgZmFpbHVyZSByYXRlDQo+IG9mIGFib3V0IDEwJSwgc2VlIGJlbG93LiBUaGUgcmVhbCBh
cHBsaWNhdGlvbiBidXJucyBzb21lIENQVSAoYnV0IG5vdCBhbGwgb2YgaXQpIGFuZA0KPiBjb21t
dW5pY2F0ZXMgd2l0aCBIVyB1c2luZyBJMkMsIG5hdGl2ZSBVQVJUcyBhbmQgdHdvIG9mIHRoZSBm
b3VyIFVTQi1zZXJpYWwgcG9ydHMNCj4gKEZUREksIHdpdGggdGhlIGxhdGVuY3kgc2V0IHRvIDFt
cyBhcyBtZW50aW9uZWQgZWFybGllciksIHNvIEkgZ3Vlc3MgdGhlcmUgaXMgbW9yZSBETUENCj4g
cHJlc3N1cmUgb3Igc29tZXRoaW5nPyBUaGVyZSBpcyBhIDEwMG1icHMgbmV0d29yayBjb25uZWN0
aW9uLCBidXQgaXQgd2FzIGxlZnQgImlkbGUiDQo+IGR1cmluZyB0aGlzIHRlc3QuDQo+IA0KDQpU
aGFua3MsIFBldGVyLg0KSSBnb3QgYmFjayB0byB0aGUgb2ZmaWNlLCBJJ20gcmVjaGVja2luZyB3
aGF0IGNvdWxkIGdvIHdyb25nLg0KDQp0YQ0K
