Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CB4F4E88
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449497AbiDFAas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349975AbiDEOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:42:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DAB2183B;
        Tue,  5 Apr 2022 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649164792; x=1680700792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4T4wIJV0pV2c2K/i4Sllo48nAVXDnAMGswMCOevd3IY=;
  b=e/38/WLUsoiGvkEOuKKPqxk7Or49RYWHO2tTdbKO0Zni/w0lv/GJP+zw
   6f//j2EtbyUotAnnJzyuT9pgslETtZQOeVj/TirDXFzBV30myZQwS9XQe
   y23heYFbblBgfiDe3614GBV7KGy7IXXHkn2hciUTbfwLpx3Anx5YOf0zo
   vtKQoYRnzrCtXO5nFSR/SA9Lpkz3eHWPUzM8aGSZQjWMdT1UboLkq2SxU
   yujJkK135JgiIYCv+FVRsKeHfHjzg74AWliFPiYY5Z+gqPpf75WI4QIBc
   0OUutEoNQdKGQ+yHbchpnvOXfdVeFR9gFD26VbVQMwR0rda7FKVWlqCZJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="158931354"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 06:19:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 06:19:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 06:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDK56q5BU2wbCRVVIPva7wPxRwIWMzftrz2evbtBgWW/FvkaNVr/4HTdhQLO0Gfe2vsugw1aIkALzYJrOnry+1QVEk/JgoKousCGTcy1hB3YTHm13WW0+iQ5IdBnfoIMoBQ4tiB7ZfYNlQKfW2mT66KCBJwyw8lCQIGe6rzam104eFEIdZF8sC7wvkougtrhYuXxiMtiJQxfUkCp39YZlTOtVEIFuXZtQW4rC/AA2AozZSyq05V4aAozyGfEUpQv3hhHS7umqqOY+Q7GjkkimM7KVrmywPzj3jPRLk5/zluG6mUWM8VhPVX5z1UI2pl4wm3Cvt6utrHoVZyhe1nyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T4wIJV0pV2c2K/i4Sllo48nAVXDnAMGswMCOevd3IY=;
 b=ErhPIlz7VLicSamX2T8ePKvsW2MJKpcL2/3YyttEygFhEgEpKEN/lIrRlo0sU7/MkK3jbaWVuL5tHZVBMVRlhjDYwb3apVp3NAGzWGp0vRjBmVF9SPvxBqy2TdW742Zn9QgP6dWJYa6PsuxeOYZG8EQ7J/NCQ//yb9TAydttaHn41MYtBM8xfaK2DJbZvYupH01n72g8RiWvQTItCOhRwRkbBkQWJSytnkAhvXOrVb3ERbFdohS5isVaGRhmk7fd0E3U0irIox2Hey/GkXGEpUgB01HpTyLutgQSlXJlPat/mBXKnOnnBrD8BtwSfeUvPD8M9B06RpWMBx2zrI+J8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T4wIJV0pV2c2K/i4Sllo48nAVXDnAMGswMCOevd3IY=;
 b=PH9TZUV3frlDTYZIVP4xNtjqwSBg+0/nqMjMINnNezWDic7tdV+Wz/I5udz06ykhKj7TfFzoWLLKkiSc5njdcJLpppZiLHtlzi2FpLAzKF5x0RV3veyq8kcHaXbGdD7ymgYrM2Bdvu8L96d3Y24qzSmlUZbzNHP7KgxrStt2fHY=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by CH0PR11MB5235.namprd11.prod.outlook.com (2603:10b6:610:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 13:19:48 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%6]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 13:19:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
Thread-Topic: [PATCH 6/8] power: reset: at91-reset: add reset_controller_dev
 support
Thread-Index: AQHYSO/S63noJBr7cUyVHBDjjcHiyQ==
Date:   Tue, 5 Apr 2022 13:19:47 +0000
Message-ID: <4bcc1d16-2e78-1cf2-2c7e-68b377d2677d@microchip.com>
References: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
 <20220405112724.2760905-7-claudiu.beznea@microchip.com>
 <0ff9a7cd2e6261a0de32db3bf16901e3737efef8.camel@pengutronix.de>
In-Reply-To: <0ff9a7cd2e6261a0de32db3bf16901e3737efef8.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebb8d605-59a9-45c7-33b7-08da1706f577
x-ms-traffictypediagnostic: CH0PR11MB5235:EE_
x-microsoft-antispam-prvs: <CH0PR11MB52359EF578445C7A9531848687E49@CH0PR11MB5235.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOHt/hwr7OYBtXbWy0hWVhYwzTh6PLng79Y9AAKcoEZTtecFojZHi6knsIyhD8OM1YRr2w+a2DB+KjLnWwiQYBHkYLXAOjWkdduV8PrSWPFIPx2hzpvfvX6FuYCwxn3lsNbL7oMbbapRyqPaKfstPKQNC0vmHlF52k3wbQg1N54DWzpxHbLD3vDX5Py/oCSAZPDBM/5M4odbeH4B5qvD7r5ro3HJpPRGOW2rREJRpUtfQuckgjoHYv21/FNLLrM6mVi/IqBc5p0hUluhM1H5Sr1qJvxFaD4CFTU/us4r1BsFNxSwl9Igu9pzdsbK4VHjjwkmmlgF9dnSKRWN+Ng7X5cpQSa0JzWJiIIndt/iVuyKSnTPd7mrdh1XASF8ef3cmh/OiEcVo0/EEr/LB5BjjrAHpXHqjYl8owxUMb4PN/PtGAkWrlCxFoDcU8uMtoqH4MwAiFmCsKN7BhFGHV3E7tcmj3sZK8WFAA3z8FAuA0uxuZbbROOR+TXVwTkmm2KpvXeO1KdBx6alRWMUWgzaxkH3lWdvlVSGTJWcqz6v/cKpnqpkIjcQNtx6eLsrPDeYHkL4gXSvlIQ+lp5fAL4HTwmufS0HNkicssIbp4iSNAZpMaY77aYJFKu9dYaCmN5g6i+2VdqL3utPpVcCOOJLmvkOvNhshkWkN6wcg4XCvVCBmFs8kBVujldvGzjNRQwBCeL9cBBh103t8xpGe0xDUS63PBzH505tXiWiRe/L9e7TI9MscAKxxjvdcRjpxQzCPSwlXYCL00V1cRyxKCq1D6oUrn2hHe55l8Z6+fKYtI0HJ8yR/bna+AWSw7z9eMcD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(122000001)(31696002)(66556008)(8676002)(66476007)(26005)(66946007)(4326008)(71200400001)(186003)(66446008)(64756008)(6512007)(76116006)(91956017)(31686004)(86362001)(5660300002)(83380400001)(53546011)(6486002)(508600001)(6506007)(110136005)(2616005)(38100700002)(8936002)(36756003)(2906002)(54906003)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEJoRGVwbnlJT1YzVk9VT1lTcXJFS3NwaSt4WEpqS2lQMXRSOE5oeEJCa2c1?=
 =?utf-8?B?b0poQWRtbGwxL3ZUNEpVdmZvYjRITnZoYkM3b2gxQVgzMGZrZEMwMHFXck5K?=
 =?utf-8?B?QTFac0hzTUJWYUMwZU9PN1BjalJMRmxqRjIyeFBYdkpiZWc5akNoNmY5VG1r?=
 =?utf-8?B?aStzZlVtU2JKQXVaS0ZqUktHMXJnbStLU0ZFVXZhU055elFVdEdVUHdjWWkz?=
 =?utf-8?B?UXBBdTZ1RFdsQVdUWkg3Y0JiU3BSeFAraVVmLytlNDE4cXFsMkdXcnBpZVR0?=
 =?utf-8?B?L21hS21ZNzZGb3ovYnJHVlFpeC92WlNZU215RDJzbzZHdzY4K2luOStRSXJX?=
 =?utf-8?B?VEhOMVkxR1BxaUt4RWhlaFhWc3g5dlFiayswbmlxRUZQQ3JIQk1JQ0xWZ3g3?=
 =?utf-8?B?b2JuSkphYmhpTCtMak5aMzdlU1VmbEFFU0czM3p3OG5aSThQT1gyampibStv?=
 =?utf-8?B?ZHhPcng4dG9xTVBzWEw2aVFOc3lac3NQU3FMSGxrREYvTHJzWDI3czNxMkZ6?=
 =?utf-8?B?SHM3Z2JaNGJDbmpVUVZmTDFUaHNFMVY1dWh6bnEwbFFUZHgyL1lQMDZBaHJZ?=
 =?utf-8?B?R2M3MnR5UE1yd2Z4a0JZNFh1R21aaHJtRTdUK2J6c082dmJGL3Z0OC8zSGFF?=
 =?utf-8?B?bG5lTUxReEpwR0lDT0tocDF5cHJlQ1BMQnpuV0VYWU52d1JpRzdhNjNRZHBB?=
 =?utf-8?B?K01oTncyeUl0Um1aVjFMc3RmbzR3RUFPejRsd0NCWlU1SkFpaGV4KythVUUx?=
 =?utf-8?B?NWNoazNINFFpNTlXZ1A5RXBwWHcxZUQ4QjVUT0dUajJwY25WcHNuc2ovTGFL?=
 =?utf-8?B?M1BCaS9IcHhUSjlQVTNEcnU3NG50U3IzWEZVNnlyWUdpekpEVU5qV04xTVJR?=
 =?utf-8?B?QmJjazhKQ2laZ0hjVTRKaFN2bkYvZzhlZzNtZmhFUDQyRkdDWU9lU2owSEtL?=
 =?utf-8?B?clF3UERKUVhpWXpsOUhSOXhMcGhEd2cyRHA2bDl0a01GU0loWTM1TmJzRjFs?=
 =?utf-8?B?ZGJ6SkViampVUDlqZzRxMEw1MWlWZVNUdlRZQXFuY2FpZDBodXVhb05ZMG5N?=
 =?utf-8?B?MjRVK1k4VVdnMVRsZmEzV1B1b1lZeXU1V3NvODBZUGc5OEVTOGV2ZG5IRGI0?=
 =?utf-8?B?RktWSno4Z0doSWdqbTYyYUZiVFBETVVxL3pleUE1amtKS3NEekNucVlIRE9X?=
 =?utf-8?B?Uy9oTVE3bjQ3RDBXL3ZRMmUvWTJieGpIR1hqWTU0SVZ2VWJxRWNHdzZVTDZs?=
 =?utf-8?B?UmFWMXQwQkl4SGNvTG1nemJ3S2JJck4yemg0enhjS09DMEdIaEEzRVRqb0hO?=
 =?utf-8?B?VFZHTHdEd09LUzJJNjNlNjJZN2U1cmdodFhDOHRqUlpyS2dTelRoVFRhb1Za?=
 =?utf-8?B?UXFXeGpkejVTeERvaHlOd2hNVG0yTlgvaXlVNlhJLzM3TllWby9CeXhRbEY0?=
 =?utf-8?B?djVCZEZkcHJmTmNzRlRZK0JDZFFxcE1EaU5jSExwTnlnc1lZeW8vSlQxcytS?=
 =?utf-8?B?MEZIbnJRRHVxTzRUZ3l3Q0JUakRlL2FhNmhBVUFmTXBlQU1aWjBrVHA1TXdi?=
 =?utf-8?B?ZWFKb1dxcGZWRXU5NGJGRGNCSVZEWmFuc3BURHk0cVE1Q1NrNE9NdU1hbkda?=
 =?utf-8?B?WklNUUdFNG1XaW4zb2hQL25GZDYzTms3VW1DQXpCUVBRNEJ5YmRYS2trZkJC?=
 =?utf-8?B?WFZOQ1hzQnlaVGk2amlDUVAxdkdJeml2VGI3UEpjOStrSWJtbEFMUTZicWJ0?=
 =?utf-8?B?OGdCL3JLemtEalBvcTBldjhIaU9hSU1RT0lVSlFMN2t6NkNhQjZ4T3FkNzZJ?=
 =?utf-8?B?a1Nwcm81TmRZUkZhZlp3bGd4dTltV0lBSlkvNnFjaFRDdTdPemg1cHNyNU1Q?=
 =?utf-8?B?WFQ3NlBTWUU0ZEU2Zzlhd0V2WGxVeVRVMFZHSVU3SjlmR24wSGcwU01lcDEy?=
 =?utf-8?B?ZERqN2lRWUdSV00rVk90dGZCZkNZbGd1QWtDa3c5UmZjU2Urd2lmMlZSY29B?=
 =?utf-8?B?a1loVUhHT1FZT2U5Nzh0VnFPTzRLamVqbWp5aUw1ZXRFbmdmamdXb0pyMStZ?=
 =?utf-8?B?ekc3WElpWVR6SnRWakNEUzNFY2xRbkJYNHFiQW9NUW1OT0JtTTc1R1U3Sno1?=
 =?utf-8?B?S3pSVnFDbG9aZkUyeGE1RzNlWmxwTDArU3lGTW1DcElEUmVHMEx4V2JtdlIv?=
 =?utf-8?B?SmVOandtdWc2REk3WUc5NldLUGRwNExYd0ZKQVhWMlZDYkhyV0RwelJ3aHhM?=
 =?utf-8?B?SzNLKzNXRmRTbjIwRjNFUktvNHBWY1ZPR0Y2Z1hibndFTjBYL1Y5ZFRML3BN?=
 =?utf-8?B?SEN4Q0FvL3Z5N3E0bWE3cEJmaktDZzIyamVhVzhCNGliMkNyZ2V3SzByMHYv?=
 =?utf-8?Q?vM6DsSqSJAA5kjCs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F550DD3D76DBCB40806534F0F9CC8936@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb8d605-59a9-45c7-33b7-08da1706f577
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 13:19:48.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niIAgkvGPPFAGCaTEbicPlaHUZSL//O2ychvtOIst6zcrnHIu5+o/sIHynHYdcqyIflKQBZy0lq3Uy3eZFRygz2Dch92C6UHySN01wVyOoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5235
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHAsDQoNCk9uIDA1LjA0LjIwMjIgMTQ6NDcsIFBoaWxpcHAgWmFiZWwgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGkgQ2xhdWRpdSwN
Cj4gDQo+IE9uIERpLCAyMDIyLTA0LTA1IGF0IDE0OjI3ICswMzAwLCBDbGF1ZGl1IEJlem5lYSB3
cm90ZToNCj4+IFNBTUE3RzUgcmVzZXQgY29udHJvbGxlciBoYXMgNSBleHRyYSBsaW5lcyB0aGF0
IGdvZXMgdG8gZGlmZmVyZW50DQo+PiBkZXZpY2VzDQo+PiAoMyBsaW5lcyB0byBVU0IgUEhZcywg
MSBsaW5lIHRvIEREUiBjb250cm9sbGVyLCBvbmUgbGluZSBERFIgUEhZDQo+PiBjb250cm9sbGVy
KS4gVGhlc2UgcmVzZXQgbGluZXMgY291bGQgYmUgcmVxdWVzdGVkIGJ5IGRpZmZlcmVudA0KPj4g
Y29udHJvbGxlcg0KPj4gZHJpdmVycyAoZS5nLiBVU0IgUEhZIGRyaXZlcikgYW5kIHRoZXNlIGNv
bnRyb2xsZXJzJyBkcml2ZXJzIGNvdWxkDQo+PiBhc3NlcnQvZGVhc3NlcnQgdGhlc2UgbGluZXMg
d2hlbiBuZWNlc3NhcnkuIFRodXMgYWRkIHN1cHBvcnQgZm9yDQo+PiByZXNldF9jb250cm9sbGVy
X2RldiB3aGljaCBicmluZ3MgdGhpcyBmdW5jdGlvbmFsaXR5Lg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0t
DQo+PiAgZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMgfCA5Mg0KPj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgODggaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9y
ZXNldC9hdDkxLXJlc2V0LmMNCj4+IGIvZHJpdmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMN
Cj4+IGluZGV4IDBkNzIxZTI3ZjU0NS4uYjA0ZGY1NGMxNWQyIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9wb3dlci9yZXNldC9hdDkxLXJlc2V0LmMNCj4+ICsrKyBiL2RyaXZlcnMvcG93ZXIvcmVz
ZXQvYXQ5MS1yZXNldC5jDQo+PiBAQCAtMTcsNiArMTcsNyBAQA0KPj4gICNpbmNsdWRlIDxsaW51
eC9vZl9hZGRyZXNzLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0K
Pj4gICNpbmNsdWRlIDxsaW51eC9yZWJvb3QuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQt
Y29udHJvbGxlci5oPg0KPj4NCj4+ICAjaW5jbHVkZSA8c29jL2F0OTEvYXQ5MXNhbTlfZGRyc2Ry
Lmg+DQo+PiAgI2luY2x1ZGUgPHNvYy9hdDkxL2F0OTFzYW05X3NkcmFtYy5oPg0KPj4gQEAgLTUz
LDEyICs1NCwxNiBAQCBlbnVtIHJlc2V0X3R5cGUgew0KPj4gIHN0cnVjdCBhdDkxX3Jlc2V0IHsN
Cj4+ICAgICAgICAgdm9pZCBfX2lvbWVtICpyc3RjX2Jhc2U7DQo+PiAgICAgICAgIHZvaWQgX19p
b21lbSAqcmFtY19iYXNlWzJdOw0KPj4gKyAgICAgICB2b2lkIF9faW9tZW0gKmRldl9iYXNlOw0K
Pj4gKyAgICAgICBzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgcmNkZXY7DQo+PiAgICAgICAg
IHN0cnVjdCBjbGsgKnNjbGs7DQo+PiAgICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsN
Cj4+ICAgICAgICAgdTMyIGFyZ3M7DQo+PiAgICAgICAgIHUzMiByYW1jX2xwcjsNCj4+ICB9Ow0K
Pj4NCj4+ICsjZGVmaW5lIHRvX2F0OTFfcmVzZXQocikgICAgICAgY29udGFpbmVyX29mKHIsIHN0
cnVjdCBhdDkxX3Jlc2V0LCByY2RldikNCj4+ICsNCj4+ICBzdHJ1Y3QgYXQ5MV9yZXNldF9kYXRh
IHsNCj4+ICAgICAgICAgdTMyIHJlc2V0X2FyZ3M7DQo+PiAgICAgICAgIHUzMiBuX2RldmljZV9y
ZXNldDsNCj4+IEBAIC0xOTEsNiArMTk2LDc5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkDQo+PiBhdDkxX3Jlc2V0X29mX21hdGNoW10gPSB7DQo+PiAgfTsNCj4+ICBNT0RVTEVf
REVWSUNFX1RBQkxFKG9mLCBhdDkxX3Jlc2V0X29mX21hdGNoKTsNCj4+DQo+PiArc3RhdGljIGlu
dCBhdDkxX3Jlc2V0X3VwZGF0ZShzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGlkLCBib29sIGFz
c2VydCkNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBhdDkxX3Jlc2V0ICpyZXNldCA9IHRvX2F0
OTFfcmVzZXQocmNkZXYpOw0KPj4gKyAgICAgICB1MzIgdmFsOw0KPj4gKw0KPj4gKyAgICAgICB2
YWwgPSByZWFkbF9yZWxheGVkKHJlc2V0LT5kZXZfYmFzZSk7DQo+PiArICAgICAgIGlmIChhc3Nl
cnQpDQo+PiArICAgICAgICAgICAgICAgdmFsIHw9IEJJVChpZCk7DQo+PiArICAgICAgIGVsc2UN
Cj4+ICsgICAgICAgICAgICAgICB2YWwgJj0gfkJJVChpZCk7DQo+PiArICAgICAgIHdyaXRlbF9y
ZWxheGVkKHZhbCwgcmVzZXQtPmRldl9iYXNlKTsNCj4gDQo+IFRoaXMgcmVhZC1tb2RpZnktdXBk
YXRlIHNob3VsZCBiZSBwcm90ZWN0ZWQgYnkgYSBzcGlubG9jay4NCg0KUmlnaHQsIEkgbWlzc2Vk
IGl0Lg0KDQo+IA0KPj4gKw0KPj4gKyAgICAgICByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAr
c3RhdGljIGludCBhdDkxX3Jlc2V0X2Fzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYg
KnJjZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGlk
KQ0KPj4gK3sNCj4+ICsgICAgICAgcmV0dXJuIGF0OTFfcmVzZXRfdXBkYXRlKHJjZGV2LCBpZCwg
dHJ1ZSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgYXQ5MV9yZXNldF9kZWFzc2VydChz
dHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgaWQpDQo+PiArew0KPj4gKyAgICAgICByZXR1cm4g
YXQ5MV9yZXNldF91cGRhdGUocmNkZXYsIGlkLCBmYWxzZSk7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgYXQ5MV9yZXNldF9kZXZfc3RhdHVzKHN0cnVjdCByZXNldF9jb250cm9sbGVyX2Rl
diAqcmNkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIGlkKQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IGF0OTFfcmVzZXQgKnJlc2V0ID0gdG9f
YXQ5MV9yZXNldChyY2Rldik7DQo+PiArICAgICAgIHUzMiB2YWw7DQo+PiArDQo+PiArICAgICAg
IHZhbCA9IHJlYWRsX3JlbGF4ZWQocmVzZXQtPmRldl9iYXNlKTsNCj4+ICsNCj4+ICsgICAgICAg
cmV0dXJuICEhKHZhbCAmIEJJVChpZCkpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHJlc2V0X2NvbnRyb2xfb3BzIGF0OTFfcmVzZXRfb3BzID0gew0KPj4gKyAgICAgICAu
YXNzZXJ0ID0gYXQ5MV9yZXNldF9hc3NlcnQsDQo+PiArICAgICAgIC5kZWFzc2VydCA9IGF0OTFf
cmVzZXRfZGVhc3NlcnQsDQo+PiArICAgICAgIC5zdGF0dXMgPSBhdDkxX3Jlc2V0X2Rldl9zdGF0
dXMsDQo+PiArfTsNCj4+ICsNCj4+ICtzdGF0aWMgaW50IGF0OTFfcmVzZXRfb2ZfeGxhdGUoc3Ry
dWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzICpyZXNldF9zcGVjKQ0KPj4g
K3sNCj4+ICsgICAgICAgcmV0dXJuIHJlc2V0X3NwZWMtPmFyZ3NbMF07DQo+PiArfQ0KPiANCj4g
Rm9yIDE6MSBtYXBwaW5ncyB0aGVyZSBpcyBubyBuZWVkIGZvciBhIGN1c3RvbSBvZl94bGF0ZSBo
YW5kbGVyLiBKdXN0DQo+IGxlYXZlIG9mX3hsYXRlIGFuZCBvZl9yZXNldF9uX2NlbGxzIGVtcHR5
Lg0KDQpJJ2xsIGhhdmUgYSBsb29rIG9uIGl0Lg0KDQo+IA0KPj4gKw0KPj4gK3N0YXRpYyBpbnQg
YXQ5MV9yY2Rldl9pbml0KHN0cnVjdCBhdDkxX3Jlc2V0ICpyZXNldCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBhdDkxX3Jlc2V0X2RhdGEgKmRhdGEsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
Pj4gK3sNCj4+ICsgICAgICAgaWYgKCFkYXRhLT5uX2RldmljZV9yZXNldCkNCj4+ICsgICAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4+ICsNCj4+ICsgICAgICAgcmVzZXQtPmRldl9iYXNlID0gZGV2
bV9vZl9pb21hcCgmcGRldi0+ZGV2LCBwZGV2LT5kZXYub2Zfbm9kZSwgMSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMKTsNCj4+ICsgICAgICAgaWYgKElT
X0VSUihyZXNldC0+cnN0Y19iYXNlKSkNCj4gDQo+IFNob3VsZCBjaGVjayByZXNldC0+ZGV2X2Jh
c2UgaGVyZS4NCg0KVGhhdCdzIHRydWUuDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcsDQpD
bGF1ZGl1IEJlem5lYQ0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0K
Pj4gKw0KPj4gKyAgICAgICByZXNldC0+cmNkZXYub3BzID0gJmF0OTFfcmVzZXRfb3BzOw0KPj4g
KyAgICAgICByZXNldC0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsNCj4+ICsgICAgICAgcmVz
ZXQtPnJjZGV2Lm9mX25vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4+ICsgICAgICAgcmVzZXQt
PnJjZGV2Lm5yX3Jlc2V0cyA9IGRhdGEtPm5fZGV2aWNlX3Jlc2V0Ow0KPj4gKyAgICAgICByZXNl
dC0+cmNkZXYub2ZfcmVzZXRfbl9jZWxscyA9IDE7DQo+PiArICAgICAgIHJlc2V0LT5yY2Rldi5v
Zl94bGF0ZSA9IGF0OTFfcmVzZXRfb2ZfeGxhdGU7DQo+PiArDQo+PiArICAgICAgIHJldHVybiBk
ZXZtX3Jlc2V0X2NvbnRyb2xsZXJfcmVnaXN0ZXIoJnBkZXYtPmRldiwgJnJlc2V0LT5yY2Rldik7
DQo+PiArfQ0KPj4gKw0KPj4gIHN0YXRpYyBpbnQgX19pbml0IGF0OTFfcmVzZXRfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICB7DQo+PiAgICAgICAgIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KPj4gQEAgLTI0NCw2ICszMjIsMTAgQEAgc3RhdGljIGlu
dCBfX2luaXQgYXQ5MV9yZXNldF9wcm9iZShzdHJ1Y3QNCj4+IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4+DQo+PiAgICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIHJlc2V0KTsNCj4+
DQo+PiArICAgICAgIHJldCA9IGF0OTFfcmNkZXZfaW5pdChyZXNldCwgZGF0YSwgcGRldik7DQo+
PiArICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgICAgZ290byBkaXNhYmxlX2NsazsN
Cj4+ICsNCj4+ICAgICAgICAgaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKHBkZXYtPmRldi5v
Zl9ub2RlLA0KPj4gIm1pY3JvY2hpcCxzYW05eDYwLXJzdGMiKSkgew0KPj4gICAgICAgICAgICAg
ICAgIHUzMiB2YWwgPSByZWFkbChyZXNldC0+cnN0Y19iYXNlICsgQVQ5MV9SU1RDX01SKTsNCj4+
DQo+PiBAQCAtMjUyLDE0ICszMzQsMTYgQEAgc3RhdGljIGludCBfX2luaXQgYXQ5MV9yZXNldF9w
cm9iZShzdHJ1Y3QNCj4+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAgICAgICAgfQ0KPj4N
Cj4+ICAgICAgICAgcmV0ID0gcmVnaXN0ZXJfcmVzdGFydF9oYW5kbGVyKCZyZXNldC0+bmIpOw0K
Pj4gLSAgICAgICBpZiAocmV0KSB7DQo+PiAtICAgICAgICAgICAgICAgY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKHJlc2V0LT5zY2xrKTsNCj4+IC0gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4g
LSAgICAgICB9DQo+PiArICAgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgICAgZ290byBk
aXNhYmxlX2NsazsNCj4+DQo+PiAgICAgICAgIGF0OTFfcmVzZXRfc3RhdHVzKHBkZXYsIHJlc2V0
LT5yc3RjX2Jhc2UpOw0KPj4NCj4+ICAgICAgICAgcmV0dXJuIDA7DQo+PiArDQo+PiArZGlzYWJs
ZV9jbGs6DQo+PiArICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShyZXNldC0+c2Nsayk7DQo+
PiArICAgICAgIHJldHVybiByZXQ7DQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgaW50IF9fZXhpdCBh
dDkxX3Jlc2V0X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiANCj4gcmVn
YXJkcw0KPiBQaGlsaXBwDQoNCg==
