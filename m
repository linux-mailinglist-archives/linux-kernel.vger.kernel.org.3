Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D4A4E612B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242598AbiCXJjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiCXJjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:39:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093369F388
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1648114654; x=1679650654;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y3UPW/SDXedR90NbtEX+BLz6j5obhBVZubDTYoHcgBQ=;
  b=0VLi11zF16JJBniG6J8RDGJnKreLKEFMYjnvDyXf4FnRE5S6bc9UKTPf
   FQgvf7TRUM8sdxGIbPW5KTB2cFj6RpIjv1xsg9u61l0rcsym77xiDnrdl
   4tZN5dYCy++Ht1/uXQQ2/8pZo/T37l9PIyneij45DDuuKq5IcpWSiVuw2
   fgVx608PUa5A0cjxyyr09a9cOtaBztnb7bNTG5WKaq+cNaiMlpE1u9ZSP
   wmzBN2RxJfFXMXUCZeVcZWJIxRa69jdLM7luErD4l9rnV/ZKPq4ebwLUJ
   jclTnfgPLqqisuePc2XaAyktl/Kwe5+LwJCIL/QsmcLHylzw2kfe6JRUb
   w==;
X-IronPort-AV: E=Sophos;i="5.90,206,1643698800"; 
   d="scan'208";a="166958635"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2022 02:37:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 24 Mar 2022 02:37:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 24 Mar 2022 02:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkv2jun2pUhy3DVeMXPwU994f0px9K/7PuSm5i2RSoMerPpv0KfxdYMfXujvblP6+FpxQpnhcmnCfO2JxfZCJinciBloLb063TgqFeXk/82QwIfPS5n40bmwP7Ivwl7KSB2/Ox/LJdC3iRIKgckUrP8ntHPtYNfmFSfjQapmrSQ7tmuAx4yoi71nFzbxepKAz+xHOWS3s1esWbIYAOJhpc36sZIZIhMqq3ia8kLRb82e8iFft5X7OuM9giD/0sqiWajWjYW+h2DEdby/TjrIKxiabQW/St7sqV7I4MBQLfVEz0LmuMRMQkndy6wddkUm7ICnd2s50gEWVH5fv/OjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3UPW/SDXedR90NbtEX+BLz6j5obhBVZubDTYoHcgBQ=;
 b=XrPaBKqIZbTuw2YX5jnwqekbWuYBVuWnzCXs44JXOuADxHlkCeVNcTrUFr2agOAKChhFqhBZeMwfSd7lzsmGQDDa5JF27zPgJvfZOUdeKxzkottuPI7pQYpKH8U9fxPxMzifnqyxqnBlLGNvlk1Z+YrjFLQGmfFb+Hzhge5TFA7i1h5UVHOzQMeCdwNxNLMHuQN/8IvBfSGo1txBkYEw3Jtb++jmHTPmOGErgDAHp6uXEV/bz21qDBxUU2GJy9E6D7clM8qT32r9vyh3BLFf2yrj9KVnAbI/OAD7HfC828MoAzvOrfYfMqD3DH6WzUltyJ6K4+cupXpQBCFWBhUngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3UPW/SDXedR90NbtEX+BLz6j5obhBVZubDTYoHcgBQ=;
 b=rN3ta8ekrKuXzk+F6Q3TN/psaqyJcLSaQ5Q+I4IRe4rTkmhZjK3CdTVW7B8jvbN15iWcwJndHiz5IB5B5H7ulTqVZqNOBBUjmPwuMrBp3Hi6x/ZqpodxcEBTvMVEb+NrgGbQavEtVGC8E65FcApkax4+QqFl5KaOxfQb3yp3YoI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:95::7)
 by SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 09:37:29 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::dc95:437b:6564:f220%7]) with mapi id 15.20.5102.017; Thu, 24 Mar 2022
 09:37:29 +0000
From:   <Conor.Dooley@microchip.com>
To:     <mick@ics.forth.gr>, <palmer@dabbelt.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Thread-Topic: [PATCH] RISC-V-fixes: relocate DTB if it's outside memory region
Thread-Index: AQHYPfD9vlSdDPqFi0CW4KmZ/C3YmqzOSr8A
Date:   Thu, 24 Mar 2022 09:37:29 +0000
Message-ID: <ebaa9b4e-9e37-e2f4-2bee-37d324e7302b@microchip.com>
References: <20220322132839.3653682-1-mick@ics.forth.gr>
In-Reply-To: <20220322132839.3653682-1-mick@ics.forth.gr>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d320fda-24a7-4ffe-49cc-08da0d79ea06
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_
x-microsoft-antispam-prvs: <SA0PR11MB452626385672FEC8FCDB2D1998199@SA0PR11MB4526.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iilojRwX+LK4A3lzWOgYzayyys9OAoTdUKMsXjtEz3UKQcNRQqKvow/W0ewB6Cy/DUGc6MTFTaBDGR7esBslKmhHIN6E8ASHULyXwHgT0fQMnFHafSYq0yccVLSCh1AORGPjmxRPZs6q+ONw8Gq21VsMnvACZBETH7x52tQECs5y8KV8JzH/kSa8l10bFrEHfEBPTDdYrHNRbyg7KDgmHOEWysfMBGMYJBNzBsTgLSPVC0LX09PqYzczytPhA/rDcAJFUJfNfP01KllZIsUZHFulmDtr7VnSCofY6214wq8xhSVyawsagtJBOcThIiUrUSQhPY/sGArjT3DDaTsXEYh1+xJYVZ4xFi5FCbltnb2uC0GkxusYJgPClUkav+daDyd9j0TPNcVXJqA3OLJyrP9Sb1Cts+yQ4G+b4IFSpTtCGGWCmHZCw/lWK6y2b5W8696P046IqMG+gJZ2Nd+RmwBC6yKsBNxh+YlEja84DsKyuD8p/Vlb7gcGZ+Zc8xMSAhlSpjISqwzhUnjr4M2LsVv4FKDS1pu5UXZ/hQYNcyIvrRKksLWMaGHQOWbPPictAGoh/UycAWQisooUs33ocWN7LsO6ve3h4+NcmoJIIjsouIEdbtiONDDmBekV1sgQOWTfXQkqWwo9ZoOU1d+KdP5NsHVEiMQpot8XDrz7Te/ivmoEwRw73RVt9ZS2MwZLh5iqtqpSSY00nthg1M5ZfWiiPKeNaHFLgDFC2dkV0pcaBZbXpy//tBj6RS9Gca0BBbwya+HZy5lyaXjEnlUwog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(2906002)(71200400001)(36756003)(38070700005)(6506007)(6512007)(8676002)(316002)(91956017)(110136005)(66446008)(54906003)(66556008)(64756008)(66946007)(66476007)(26005)(76116006)(38100700002)(508600001)(186003)(6486002)(5660300002)(2616005)(8936002)(31686004)(83380400001)(31696002)(122000001)(86362001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3BEeSt0UVRxQ0pwcGdUSHNMcUlHcU05amtuNEJiVHl3ZUoza1kvWi93Y0tx?=
 =?utf-8?B?ODJPU3cvWTNLTzFCT3IvclgxNjlNak5lNnc0VWpjcWpzQVlMbGl2RzBLLzZT?=
 =?utf-8?B?U2N2d0ErYWtJUDg2UkFZc3hJUFdHRGhjM3BnUzR4a1VLVmlvSXg1NHVqSi8x?=
 =?utf-8?B?enBTa3U3d0FEYTNQWk05b0p3clNZNVZQTTBoU3g2cGxBNHVCWE9QN2ZNMTgx?=
 =?utf-8?B?NForRmErODRVTXhWSDYvckdEaEt6UXRlend4SlBGMFlhSmprWFYzSit5RGlP?=
 =?utf-8?B?cU1pUmk1dW16VFVEVE9KSHY4NXlleHNSZVNBOWRKTVMzcFpQMU92U2VZbmh2?=
 =?utf-8?B?T2hzdGhQMzJQMDVPZlQwOVlad3dCMyt1dlhYOHBmSnFzWGNic2pncjFIY3lp?=
 =?utf-8?B?TFNoVWo0MDMyNlNldE54S2Vub0t5SWRtS1V5ZXF3aW1uUjVIbXZ5Z3ZyMUxM?=
 =?utf-8?B?Q2FJd3dqUjI1OXdzYSs3VjZ2M3IyMUZjQk45NXBVUFA2cU0vN0JKVXhKWWs2?=
 =?utf-8?B?K3hqc29VRXJTTnBRNThqTUFDa3RJZXNqeDJnbkphalJ5V1BVMXp1N2hBSnpn?=
 =?utf-8?B?dUNwKzVOYWJWeTNjUHExYUpNY1RRaHMxbXdtRzRTMzRRMzZEZkNRWVdmZUFJ?=
 =?utf-8?B?djZSTmhYQVhGMFQ0R3hydmNvMDFnQk9ydldnM3NhYUZIQlFMSDQ1cUY2NTUv?=
 =?utf-8?B?Tm41SjBFZGoxL0V0Vys5TGJYcXBjOXpLQkIrWmk4U0RrR1hvUzdDTitSYjE5?=
 =?utf-8?B?dUtucHhDZy9ncTNTRVJUamNFYUNWNGxJZDlRekROM3ZUSFdvMG5BNUN6M3lx?=
 =?utf-8?B?MzdUVzJxQkRHUjZXMWc3a3NYT2htTXljNURGSnIzVHdSOXlvVCt2R2JoeTlC?=
 =?utf-8?B?eGUzZ3VNM29JNkpuS1ZzZUZMUmhlRFI4TWxjK0hVQ2IwdjRVTGJLZjlnRVZv?=
 =?utf-8?B?bmJoUytNcUxwd2FsVGxiNzdYUUNYOVUvbTBJN2RjTnR4dE44ZnZQd1JrUkZ2?=
 =?utf-8?B?OVpVWmczSFBLWVdNTTAxL2ZwNHBkOVUrdDdGKzhnM1NjcGJOOUJrZVEwcFQ0?=
 =?utf-8?B?bFdaOHhjV1JaOG9XdHFadmVJRldyaExVUlhHbmxyb0Q1ZTFXa3V3T2ppVEhH?=
 =?utf-8?B?RHdQZmVXZHQyVkRKRXAxNHNoTUVxRzRiWHpMR0dNSXZCMVF0N1BkNUNYSVhr?=
 =?utf-8?B?VnlXRkFlYnovd0t0N05FdXA4VDN5S3RNWERPeTdPTkYyOENpOWF4Sk5PWmtH?=
 =?utf-8?B?SXFMOXZhYkFGMFlBNXNtSHBvck9oKzJVSGUvaVpjTW5hT1J5NTBxb1pVem9q?=
 =?utf-8?B?K0Zkek9xU3M5Wm4yQkEzMzcvblozTHZWM1J2bFlrZ3kwenladzlXdGw0MDRa?=
 =?utf-8?B?cWlmcit3dGxDL3FpbEgzSjFyT1MzR2ZPNGliTXRNZkc0WnVhN09JZy8wUXVY?=
 =?utf-8?B?empGaExhVVZDWk16aVN4c1VQZ3h4RzJJV2k3L2ZyaFJGNGFhc095VVVtYWtl?=
 =?utf-8?B?TGd4VFpleTJOK1VCOHp2Ui9MNkFuMElaQndxcmszMTE2ZHNSSmp3azNXV1FY?=
 =?utf-8?B?cjJ6b3ZnL1E3em51UVhqSmJnbnJoSDlwNS9NQmFQWUZ5Z2h4cHpVcUM3Vlpi?=
 =?utf-8?B?NjZYSjlvUlYzUVZxYjBCYkdlcEFqZkdjRnZBMlh2M2s0amdSVTFuMjloR0Vy?=
 =?utf-8?B?bTdHS1czYURqYW5Velc1bTZUNVBrbGpUamZNSWhPejJ0OWFFc3V5UHFCSzJ6?=
 =?utf-8?B?aWVoaEd1YjFFUEJQalNvRUx6ZGN1TzhiWEFjeXduVDNRZXNEd0VCeEhRM2Rs?=
 =?utf-8?B?Q3dWSExEK1dzVXVPdGE0ZWxqbUlheStQRVgzZDZGMmQ4R1EyU1B3RjltbnRn?=
 =?utf-8?B?NXVlUXh2SXduai85ZFp3U3ZBTzZ1dWR4SmpiNklBeTlsWVQrTi9KVjJ0b3Bt?=
 =?utf-8?Q?kePjb4zuadxoWg1tDhrUqg1HtEGYpuNx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0793EB7036045E43B4E19E9CE432213E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d320fda-24a7-4ffe-49cc-08da0d79ea06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 09:37:29.4207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErXRpiCU5wtW7utEUYjkONaJ7bcrEUyW3Z3L7ecCZ8ULecE5pCEef2XnxWwe4+d+GHPx5L+711q8MDnA6DheTK9PTKCND5fXb8qHhRmJxfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4526
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMi8wMy8yMDIyIDEzOjI4LCBOaWNrIEtvc3NpZmlkaXMgd3JvdGU6DQo+IEluIGNhc2Ug
dGhlIERUQiBwcm92aWRlZCBieSB0aGUgYm9vdGxvYWRlci9Cb290Uk9NIGlzIGJlZm9yZSB0aGUg
a2VybmVsDQo+IGltYWdlIG9yIG91dHNpZGUgL21lbW9yeSwgd2Ugd29uJ3QgYmUgYWJsZSB0byBh
Y2Nlc3MgaXQgdGhyb3VnaCB0aGUNCj4gbGluZWFyIG1hcHBpbmcsIGFuZCBnZXQgYSBzZWdmYXVs
dCBvbiBzZXR1cF9hcmNoKCkuIEN1cnJlbnRseSBPcGVuU0JJDQo+IHJlbG9jYXRlcyBEVEIgYnV0
IHRoYXQncyBub3QgYWx3YXlzIHRoZSBjYXNlIChlLmcuIGlmIEZXX0pVTVBfRkRUX0FERFINCj4g
aXMgbm90IHNwZWNpZmllZCksIGFuZCBpdCdzIGFsc28gbm90IHRoZSBtb3N0IHBvcnRhYmxlIGFw
cHJvYWNoIHNpbmNlDQo+IHRoZSBkZWZhdWx0IEZXX0pVTVBfRkRUX0FERFIgb2YgdGhlIGdlbmVy
aWMgcGxhdGZvcm0gcmVsb2NhdGVzIHRoZSBEVEINCj4gYXQgYSBzcGVjaWZpYyBvZmZzZXQgdGhh
dCBtYXkgbm90IGJlIGF2YWlsYWJsZS4gVG8gYXZvaWQgdGhpcyBzaXR1YXRpb24NCj4gY29weSBE
VEIgc28gdGhhdCBpdCdzIHZpc2libGUgdGhyb3VnaCB0aGUgbGluZWFyIG1hcHBpbmcuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEtvc3NpZmlkaXMgPG1pY2tAaWNzLmZvcnRoLmdyPg0KDQpB
bGJlaXQgaW4gYSBiYWNrcG9ydCwgSSB0ZXN0ZWQgdGhpcyBvbiBhIFBvbGFyRmlyZSBTb0MgYmFz
ZWQgYm9hcmQuDQpTbyBJIGd1ZXNzLCBUZXN0ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+DQoNCkFuZCBhIGxvdCBjbGVhbmVyIHRoYW4gdXNpbmcgY3JlYXRl
X3BnZF9tYXBwaW5nIGluIHNldHVwX3ZtX2ZpbmFsIHRvIGRvIGl0IDopDQoNClRoYW5rcywNCkNv
bm9yLg0KDQo+IC0tLQ0KPiAgIGFyY2gvcmlzY3YvbW0vaW5pdC5jIHwgMjEgKysrKysrKysrKysr
KysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9tbS9pbml0LmMgYi9hcmNoL3Jp
c2N2L21tL2luaXQuYw0KPiBpbmRleCAwZDU4ODAzMmQuLjY5N2E5YWVkNCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9yaXNjdi9tbS9pbml0LmMNCj4gKysrIGIvYXJjaC9yaXNjdi9tbS9pbml0LmMNCj4g
QEAgLTIwNiw4ICsyMDYsMjUgQEAgc3RhdGljIHZvaWQgX19pbml0IHNldHVwX2Jvb3RtZW0odm9p
ZCkNCj4gICAJICogZWFybHlfaW5pdF9mZHRfcmVzZXJ2ZV9zZWxmKCkgc2luY2UgX19wYSgpIGRv
ZXMNCj4gICAJICogbm90IHdvcmsgZm9yIERUQiBwb2ludGVycyB0aGF0IGFyZSBmaXhtYXAgYWRk
cmVzc2VzDQo+ICAgCSAqLw0KPiAtCWlmICghSVNfRU5BQkxFRChDT05GSUdfQlVJTFRJTl9EVEIp
KQ0KPiAtCQltZW1ibG9ja19yZXNlcnZlKGR0Yl9lYXJseV9wYSwgZmR0X3RvdGFsc2l6ZShkdGJf
ZWFybHlfdmEpKTsNCj4gKwlpZiAoIUlTX0VOQUJMRUQoQ09ORklHX0JVSUxUSU5fRFRCKSkgew0K
PiArCQkvKg0KPiArCQkgKiBJbiBjYXNlIHRoZSBEVEIgaXMgbm90IGxvY2F0ZWQgaW4gYSBtZW1v
cnkgcmVnaW9uIHdlIHdvbid0DQo+ICsJCSAqIGJlIGFibGUgdG8gbG9jYXRlIGl0IGxhdGVyIG9u
IHZpYSB0aGUgbGluZWFyIG1hcHBpbmcgYW5kDQo+ICsJCSAqIGdldCBhIHNlZ2ZhdWx0IHdoZW4g
YWNjZXNzaW5nIGl0IHZpYSBfX3ZhKGR0Yl9lYXJseV9wYSkuDQo+ICsJCSAqIFRvIGF2b2lkIHRo
aXMgc2l0dWF0aW9uIGNvcHkgRFRCIHRvIGEgbWVtb3J5IHJlZ2lvbi4NCj4gKwkJICogTm90ZSB0
aGF0IG1lbWJsb2NrX3BoeXNfYWxsb2Mgd2lsbCBhbHNvIHJlc2VydmUgRFRCIHJlZ2lvbi4NCj4g
KwkJICovDQo+ICsJCWlmICghbWVtYmxvY2tfaXNfbWVtb3J5KGR0Yl9lYXJseV9wYSkpIHsNCj4g
KwkJCXNpemVfdCBmZHRfc2l6ZSA9IGZkdF90b3RhbHNpemUoZHRiX2Vhcmx5X3ZhKTsNCj4gKwkJ
CXBoeXNfYWRkcl90IG5ld19kdGJfZWFybHlfcGEgPSBtZW1ibG9ja19waHlzX2FsbG9jKGZkdF9z
aXplLCBQQUdFX1NJWkUpOw0KPiArCQkJdm9pZCAqbmV3X2R0Yl9lYXJseV92YSA9IGVhcmx5X21l
bXJlbWFwKG5ld19kdGJfZWFybHlfcGEsIGZkdF9zaXplKTsNCj4gKw0KPiArCQkJbWVtY3B5KG5l
d19kdGJfZWFybHlfdmEsIGR0Yl9lYXJseV92YSwgZmR0X3NpemUpOw0KPiArCQkJZWFybHlfbWVt
dW5tYXAobmV3X2R0Yl9lYXJseV92YSwgZmR0X3NpemUpOw0KPiArCQkJX2R0Yl9lYXJseV9wYSA9
IG5ld19kdGJfZWFybHlfcGE7DQo+ICsJCX0gZWxzZQ0KPiArCQkJbWVtYmxvY2tfcmVzZXJ2ZShk
dGJfZWFybHlfcGEsIGZkdF90b3RhbHNpemUoZHRiX2Vhcmx5X3ZhKSk7DQo+ICsJfQ0KPiAgIA0K
PiAgIAllYXJseV9pbml0X2ZkdF9zY2FuX3Jlc2VydmVkX21lbSgpOw0KPiAgIAlkbWFfY29udGln
dW91c19yZXNlcnZlKGRtYTMyX3BoeXNfbGltaXQpOw0K
