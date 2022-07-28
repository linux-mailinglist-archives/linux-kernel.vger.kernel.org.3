Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA6583732
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiG1CwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiG1CwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:52:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0831252FEF;
        Wed, 27 Jul 2022 19:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658976721; x=1690512721;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=dsMASH9Ml/ViiRhBb0SVmWBmRL3cDl1TbpVHWbhgN1w=;
  b=yqHS7xaCILwPpbyahVZ5ntYryOLo0GscW4/dATOk9ABPsWsbmyE6Iwch
   juKGngvr4+Rb7hykrK5+bOyu/0HwQCR5K5KEedsldoj9yQObPCP8djVE3
   3eHy4zu8xOWC0bCtzQA+/uC9DtRWtEJ65+5YF5vI8k83iQfHd/yj9bFT7
   saZaOzRldndYRdWoe7CroLTK+OHvRHyLf690mtZF/zwj+gDgHiDAYrC63
   ySwgA2nQ4sqaXAqnba8PUVQW0t8OZJH4aiUMzCv5tD1QHXSi/AmJRZLV/
   NKyLsUnSM+4nLi3bWTzbz2IOXwlHfgSuXVRgKGZCiD31gTQv93zN8QZwV
   w==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="184061216"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 19:52:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 19:52:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 19:52:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdc2PjEamY2sheS5112gVRjiSfzhNBGsB2+AOiyt+5VgLjiaNl5AUxip3AkEeuOfOAKp91KDrJGS0Tn0GDx2Qxlo6aXJoYgD1FYaC2SS1Eh+bAkHWUlUIE2MRzvoroQ/XysC+q7ACjsk+3IvGvzO3S9pUEpHhRF6p8S6ZV/7PZrgoeZxJCEhYuAaPvpUo5W2ddXzu6iFD/nRndJrFrRS4PURmDodvwMm7qwUGNPfAQMc422Ro+t9KbzntUMqF0eBWvQVjrKozsZm8ilHAsjctgsIV9R37VMV/uLGijjTPg38sTMzcK2eu8YqFv2xFKZtSKYnHKzt6rbqDmVTgbo0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsMASH9Ml/ViiRhBb0SVmWBmRL3cDl1TbpVHWbhgN1w=;
 b=V6Zsj0IfXL7NMhFlfpWqPW6xGJcWthTob6vAzNgZ2pQ8HFsaS4zRPwlMGToCQyd9r5zhPK7qyvp5e7/vVQPSXCYHU6HR3Yz0mmvf1KTdqZmElSDnu5Qu/FDa0tXtZpGmLWQjyqipACai387oYFNHlXq8KPzk3nOFx8VQ0oQe7lFtVKT7r6lEZC2/ENbQ7BNdZxCWXnDIjvQ/WWekAcJYNgwjinLau3Sd3+lvHnDqyAFvt12PvuYySEhgvln1HSndJOwbQv0aXoMcFEIOoSQb0FQBLk7a/zQ7sjjsSPtxTQSoNPh3j7zSMiXymlWNXjL76Ktddvg76iwwCaxszArzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsMASH9Ml/ViiRhBb0SVmWBmRL3cDl1TbpVHWbhgN1w=;
 b=FWeQu7S87fieogczGsM7m33BcnBmZb1TdDgv2DEtC+qUpMMcBX//9ee8pod2UEZ1WoXUK3mleS3/80Sm9fMmHlABU1v3Rw2VszUZ6VsqAgtcc9zh0d06u7b4e6s9BYsxoR+NUS1hYGUsodhrQEv3QsNp7qNfHobAMYRaou8h6Bo=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.6; Thu, 28 Jul 2022 02:51:59 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Thu, 28 Jul 2022
 02:51:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <hs@denx.de>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd: microchip,mchp48l640: use
 spi-peripheral-props.yaml
Thread-Topic: [PATCH] dt-bindings: mtd: microchip,mchp48l640: use
 spi-peripheral-props.yaml
Thread-Index: AQHYoi0AWP2mceo9e0GmyHApqQWCHA==
Date:   Thu, 28 Jul 2022 02:51:57 +0000
Message-ID: <333ab65d-6717-29dc-72c7-968817090d22@microchip.com>
References: <20220727164148.385476-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164148.385476-1-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae20f0af-10d5-43de-6b1f-08da70442315
x-ms-traffictypediagnostic: DM4PR11MB6429:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?T3k3ZENtL094NzhwRWZFYUZuYVgxVkhrS2RTbzc1S1BNUG51YnhXTFphQ3Rj?=
 =?utf-8?B?S2N6cFF4QWV5bmdpQ3ZSb0dORVgxOVZ1WkZGMHBaS3kwRjhHTW8zNFErQ0Rn?=
 =?utf-8?B?VHVEd2NJS2lIdDNaYzNVWHExMFJFSmdvMkN1VmJha2lqOHBBMURxODdpc0li?=
 =?utf-8?B?K0pTZWtWdkVNK1hhYXEzaFBCclFJckh1WklMWi9WZk9QUVBDYVhPZUFnRUFR?=
 =?utf-8?B?bnBvSEtkbkx0ZUhSaTkxT25TTDNoSjA0bWMvL1VvTDNyQ2ZPOHkwOWtEN2Fy?=
 =?utf-8?B?SVVoTm9XZVY1UDlYRElyRURmbFBUL3NiSElDZXhpRHI4Z0h5V01VeVplLy9t?=
 =?utf-8?B?RXM3QW9QNU13TjQyNzhMNVBITXlBeTV3dmpyT2ttL25abk9oeXlPWHBoM2Vp?=
 =?utf-8?B?VFpKSCtycGdxdTkybldwU3Z1cjFYRXNkbFZST1pKcnQ0ZzFjbS9Mb2VOT2tG?=
 =?utf-8?B?RytxemRLM296cU9uSVF1d08xblowQTgxc05HNFFyeUNNQ1QyelV1bWlEL2sv?=
 =?utf-8?B?R0kzYzFsbUkzdzR1UmF6ZGtKQ1o4K3NSV3oyRzJzd2x3QWM3dkJUcjFuQmo4?=
 =?utf-8?B?UjNITC9OSm9UaWM0cmpYZmFkeUxsTWdVd0xFcHltL1BTTFBrRlRNZG1yejZo?=
 =?utf-8?B?c3A0VGFJcmNDUHkxRHVSaFpOQ0RvSlBkVGkvK1lVTHRsWEMwWDl0MC9EbWhz?=
 =?utf-8?B?YW15bWRiUTd6VG1CSGxnTmdaNXl1N2dDT0RCOFRsWEFyRHBxRG54MmNBQkcy?=
 =?utf-8?B?RFZXK2k5R25mcm5zd0VZY1JucDB6M3ZHdmZ5Mm9UaWZFMVNvNXdOWG45dmhn?=
 =?utf-8?B?TTZ4ME12SHExNzFkTzR5TXVTSVRLSlROZlRnclJPdWxOOU1ma3dXWDgraS8y?=
 =?utf-8?B?NUtTT1RVTEd2R1FWeE1BWnpwTklZWkNwS28zVDZyVmw4UUZnaUU4ZWg1dytZ?=
 =?utf-8?B?bTlXUEdQZExTTkQ2WklQaSs4dVR3eG5IVWVMcWI5NmJBZWdOblJKL0VkTlNu?=
 =?utf-8?B?MGI0MGpadDFwWTFJVUhBekF4S0R0NnVEcUVBbnA2QWhQUWJXeE82VVdIRTV1?=
 =?utf-8?B?YWpYU2lnNW5NU3J0VzR4bUJqSkhoRzh1VU5NZTdidW5rOHp5QjJ6NG1mVTBH?=
 =?utf-8?B?MklQcXIyTjFXUWFuaXExdms2d3plTFM3YWJHb1JoNmVYYTFNUjB1bkFBejEy?=
 =?utf-8?B?SHNPV3QvSWlscWNCZjJ5ZUV1ZlV3bHJhd3JWbWgzY2RzUHowWm0xOW9aTXVW?=
 =?utf-8?B?WE9TOE9vdHJGM1B0VGg3c25YRlRJRVl1eXdLVy90M3Jsa3ZuZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(376002)(366004)(36756003)(2906002)(91956017)(66476007)(921005)(7416002)(64756008)(8936002)(31686004)(66446008)(66946007)(76116006)(38070700005)(31696002)(86362001)(110136005)(316002)(66556008)(8676002)(6506007)(71200400001)(6486002)(966005)(5660300002)(2616005)(478600001)(6512007)(186003)(83380400001)(53546011)(26005)(122000001)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekVWd0NGN1Q1VEp1MWhvVmwrbElXbUFSOUhGTnJhQ1ZlRVVhUFp4dDJZVDcv?=
 =?utf-8?B?a0VUR013cDVRZ2FXb2lzUTBWb3pmaUg4QlRXRlRMMEJSdG0xVjRVdU11dVVE?=
 =?utf-8?B?ZmtEbEZEMlFrUVdGbVhsVGEzQytYdXF3SEFocHZybEcrcXhLZTROd3hRR0wx?=
 =?utf-8?B?TE51ZEZqTXBiVWlJZXB4RXdhcjB4VG5sd3ByK1cwY0JBR016dGJjYXBGMlFt?=
 =?utf-8?B?cVpYSGFncTljUW1aUFV6ZGVsZ1lUTHJLenlnNWNxM0l0NWc5V1JxdTh6cERI?=
 =?utf-8?B?QW1jaE1icTVzdnYrNkhSZUd2SkZYWHB1aVl1M2YrSXRGNDJWTjBQM3o3UHpZ?=
 =?utf-8?B?SHRDeURpMTYyZ3N1UjF6YWg2NzczWEZFUDArcENsdmZBRWxodjBJNUY1OXI3?=
 =?utf-8?B?K2swSVZZWWNqVjV5eE5YWGsrSFR2cWVmSmRJbWVyYzJLc1lPYzdTbkM4WVhR?=
 =?utf-8?B?RXFnT1BBSHJ6VjYxc0lrcDNuNGJ5clhraXdrUmxwbk1CVWI2Q1dvdzQyalgr?=
 =?utf-8?B?UUx1RjBzUjF4NjNQc0tSbGp4cTcwS3p4TnVOdWVhTzQzejU2WEJPeHBhUTRh?=
 =?utf-8?B?TU0wK1JaR3J0OHY1TXBTS0dTNTA0UHJYQXFlUUUwWG9ubHFFSGZ3RmFFYnFa?=
 =?utf-8?B?bWRaYXJrMlB3L3N1SGRBWmtjbUZqV0ZuckttZFpKR2pIUkVyY2hSMnk4MXpY?=
 =?utf-8?B?VE80RllPSG5DdDRjZU1lL0pCZGhlZ29QVXRQbGR4bG1qbGEwYnM2MjRlSVYz?=
 =?utf-8?B?eHphK21Fem1CYm5RM2VYeVM3UUhsYjZXenJES3hkUXpBZHJUMnZ0NlVDbUFv?=
 =?utf-8?B?dFRPRlAwd0t1OXZCTFpJNHRWMEkycXZyUWphU1gxejdLMjRHemprZVRlcDVl?=
 =?utf-8?B?bld6Tk4zRUtFUTJJYnNsMEtOdUxCekI1SHBGeUs4bUVTWnE0NlVta0VOTWdD?=
 =?utf-8?B?OHFTN1FlTm5vTkJXVVkwWnlSTHV5THFVaEoxd0U1Ukx5RzBwSXNSOUt1K2cz?=
 =?utf-8?B?bXkrZ1NVeGZMUENpM2tTSHNLZDAzTmVuR1IzZHN2U3B1VGw4enJNeElHT3Fx?=
 =?utf-8?B?SXdJUHFReGZyUkZKZnpSaWc1amNxQmR3bjJ0MTZQSWQ4T3VkYnB1YUJvT2g4?=
 =?utf-8?B?NXl3T1lWejVzUWd5Wjh3WHl5QkR2TzRWdE9ROFJBcFZrRnFPQm5iNXBPSDJQ?=
 =?utf-8?B?UUV3b3B0M3hGR3BobXhzZFF0czg2b3liZjFWUGxXb1dGYkpFVXN2R2Z4czQx?=
 =?utf-8?B?cG1IQ3FWZDdFQnQvQjRWcC81Z1dTa25iYko3QkdEL1dmNHV0SktuOU1qcC93?=
 =?utf-8?B?YU0wRkVpU2QvOTVCdzhiQ2ZBUFA0aVJHZ3h2bklGNmMva1k5T3dTdWJqNDI2?=
 =?utf-8?B?QlNoRmxLM0hUbGhxU3VXVGJ6WXdIWFY0V0xnUXN4R0ZQOEh4TG5xaGtwNXNu?=
 =?utf-8?B?a1FTRFF1VlhlV294ZEM4bDNCT1RzaVNiOTZHa1Qvd3FlcTI0RWZCcHJ2Z0RN?=
 =?utf-8?B?ODRSY3hlYU91VmoxV1hHem1xbVBxY1dBL1I3QU51N1hFWmUvelV2a3FsZmQ0?=
 =?utf-8?B?SUtqVkpDWG1WbTV6TEI3ZGtEMHZiNGZJUDRieGdTY0w0bnVTcWVzY0F6eVZu?=
 =?utf-8?B?d09mZ25wcWVpTDJJYjJ3V2R5bTJwOE1jUk9PTFFCd09JejZPWDJjR2NpMFd2?=
 =?utf-8?B?WUYzOXZmL2w5N01hTE9sZjJrb3RVQ0VBbDluYm1xSi9LekVETHFXdFhUckl4?=
 =?utf-8?B?MkU3S3NIVVNHOG9jQVd5dVNTc3hIdmxIeXpNbHJrclBmWmlLbkRPZkliendX?=
 =?utf-8?B?bkFpWkR5S0QvcDN6SThWVVU3ZEx2bFY4RXoxc1BVMlJEVHNmV3NvdjVKNWNp?=
 =?utf-8?B?dldXZXN3ZzU5ZHF4TTM5TXY4bDFLOUVieXcvbm5KRVBLdi9oR21DcWFDd0lX?=
 =?utf-8?B?UGRuY2d3MFh3aUdLcHA0VUd0eVVHKzVLRGFCK2Z6dEY2Tk1uY3JsSThRQjFD?=
 =?utf-8?B?bUhIVHAzWU5OeTZyRjY0WisvSERIV0Z6UjBDQXZwdFkrZnBsd216S1lxL0pY?=
 =?utf-8?B?WVFvMWU0VlZ6SzVlcWMyM3NMdit3VnUzekFaOXFERjZEcGx4dksrRndjQUJB?=
 =?utf-8?Q?yFzQwg0wZMZwrH1nPxE+9RC7e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <393DFCF283F7C24BA3C9C8F8CF9B0D55@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae20f0af-10d5-43de-6b1f-08da70442315
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 02:51:57.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qf0gkn6rLMXePiRjWzINyoQEnfYDVkBpIk0RI9gZ91zcAjNI1/tezdFUbgSZOKidzKXABH4M1CdHnW/T/NaJXVqHD2bgY7sMh5g3cSK1Yrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yNy8yMiAxOTo0MSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbnN0ZWFkIG9mIGxpc3RpbmcgZGlyZWN0
bHkgcHJvcGVydGllcyB0eXBpY2FsIGZvciBTUEkgcGVyaXBoZXJhbHMsDQo+IHJlZmVyZW5jZSB0
aGUgc3BpLXBlcmlwaGVyYWwtcHJvcHMueWFtbCBzY2hlbWEuICBUaGlzIGFsbG93cyB1c2luZyBh
bGwNCj4gcHJvcGVydGllcyB0eXBpY2FsIGZvciBTUEktY29ubmVjdGVkIGRldmljZXMsIGV2ZW4g
dGhlc2Ugd2hpY2ggZGV2aWNlDQo+IGJpbmRpbmdzIGF1dGhvciBkaWQgbm90IHRyaWVkIHlldC4N
Cj4gDQo+IFJlbW92ZSB0aGUgc3BpLSogcHJvcGVydGllcyB3aGljaCBub3cgY29tZSB2aWEgc3Bp
LXBlcmlwaGVyYWwtcHJvcHMueWFtbA0KPiBzY2hlbWEsIGV4Y2VwdCBmb3IgdGhlIGNhc2VzIHdo
ZW4gZGV2aWNlIHNjaGVtYSBhZGRzIHNvbWUgY29uc3RyYWludHMNCj4gbGlrZSBtYXhpbXVtIGZy
ZXF1ZW5jeS4NCj4gDQo+IFdoaWxlIGNoYW5naW5nIGFkZGl0aW9uYWxQcm9wZXJ0aWVzLT51bmV2
YWx1YXRlZFByb3BlcnRpZXMsIHB1dCBpdCBpbg0KPiB0eXBpY2FsIHBsYWNlLCBqdXN0IGJlZm9y
ZSBleGFtcGxlIERUUy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBLb3psb3dza2kg
PGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NClJldmlld2VkLWJ5OiBUdWRvciBBbWJh
cnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+IFRlY2hu
aWNhbGx5LCB0aGlzIGRlcGVuZHMgb24gWzFdIG1lcmdlZCB0byBTUEkgdHJlZSwgaWYgd2Ugd2Fu
dCB0bw0KPiBwcmVzZXJ2ZSBleGlzdGluZyBiZWhhdmlvciBvZiBub3QgYWxsb3dpbmcgU1BJIENQ
SEEgYW5kIENQT0wgaW4gZWFjaCBvZg0KPiBzY2hlbWFzIGluIHRoaXMgcGF0Y2guDQo+IA0KPiBJ
ZiB0aGlzIHBhdGNoIGNvbWVzIGluZGVwZW5kZW50bHkgdmlhIGRpZmZlcmVudCB0cmVlLCB0aGUg
U1BJIENQSEEgYW5kDQo+IENQT0wgd2lsbCBiZSBhbGxvd2VkIGZvciBicmllZiBwZXJpb2Qgb2Yg
dGltZSwgYmVmb3JlIFsxXSBpcyBtZXJnZWQuDQo+IFRoaXMgd2lsbCBub3QgaGF2ZSBuZWdhdGl2
ZSBpbXBhY3QsIGp1c3QgRFQgc2NoZW1hIGNoZWNrcyB3aWxsIGJlDQo+IGxvb3NlbmVkIGZvciB0
aGF0IHBlcmlvZC4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA3
MjIxOTE1MzkuOTA2NDEtMi1rcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmcvDQo+IC0tLQ0K
PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21pY3JvY2hpcCxtY2hwNDhsNjQwLnlhbWwg
ICAgICB8IDcgKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbXRkL21pY3JvY2hpcCxtY2hwNDhsNjQwLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbXRkL21pY3JvY2hpcCxtY2hwNDhsNjQwLnlhbWwNCj4gaW5kZXgg
MmNkZjZiZjNkYzRhLi44Y2MyYTdjZWI1ZmIgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWljcm9jaGlwLG1jaHA0OGw2NDAueWFtbA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21pY3JvY2hpcCxtY2hwNDhs
NjQwLnlhbWwNCj4gQEAgLTIyLDEzICsyMiwxNCBAQCBwcm9wZXJ0aWVzOg0KPiAgICByZWc6DQo+
ICAgICAgbWF4SXRlbXM6IDENCj4gDQo+IC0gIHNwaS1tYXgtZnJlcXVlbmN5OiB0cnVlDQo+IC0N
Cj4gIHJlcXVpcmVkOg0KPiAgICAtIGNvbXBhdGlibGUNCj4gICAgLSByZWcNCj4gDQo+IC1hZGRp
dGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gK2FsbE9mOg0KPiArICAtICRyZWY6IC9zY2hlbWFz
L3NwaS9zcGktcGVyaXBoZXJhbC1wcm9wcy55YW1sIw0KPiArDQo+ICt1bmV2YWx1YXRlZFByb3Bl
cnRpZXM6IGZhbHNlDQo+IA0KPiAgZXhhbXBsZXM6DQo+ICAgIC0gfA0KPiAtLQ0KPiAyLjM0LjEN
Cj4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLw0KDQoNCi0tIA0K
Q2hlZXJzLA0KdGENCg==
