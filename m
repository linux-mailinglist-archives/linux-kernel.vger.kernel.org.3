Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19C8596061
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbiHPQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHPQhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:37:05 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBC08050C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660667822; x=1692203822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AjywHmQttnW4Icgnxk6aRnicPMKgwI1pwefk4i2byQs=;
  b=DW4YP9K4dWmkpaCDhuFkak4LgF+Mztd9IctRFgC0rHCE1GycwwKDjxFa
   Z9BsxZIIR0QJIdF0X9dXq3CjiXSpvkiPlwtTVzUgMc3yhEWgUDWSFIDAp
   S0moWBHxRbDdzan9RS1sgvJ1pJtP1bES506GeFr1If3b3VzniaSexZldJ
   Ar4E+KSIyy+lc9+VS2wNVPv0l8RiPW5/Z4n3dVatOeakWkIZuPVsFBPby
   JcYehqeVHiroyRVR77EKTmqMwgujXwUuumyANEnrzLkqosz0X6TutN8Xy
   doiLWEgYDC1pLTtyI27Xzn6OysEBaHYnzNgudEMqfslfLwC+yZ+XQBZvU
   w==;
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="176480184"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2022 09:37:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 16 Aug 2022 09:37:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Tue, 16 Aug 2022 09:36:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RepKIrNKAmNtRFVaYFWuaA05gr5Senyp0KsAL/56sS9DublCnPq6kSbQunXOxZOzLyso25LplZMjn2f7C3fqWZ5ZJf/2COabcoynnAgA5UQLdlN4bGh6S+ruEtzwMbJSlwmgSiTBD63L28nqt/k+fPC+eDO37STukQrAvrYYWAfg/eTxyukKbib6cTHZ24PB+yfayB1MWx6Ux6zwTfxf+RxJyEBx9IAsULEFwVKix984UsqMc4rDCOu0oiqhrcXR/j8tFjjk/Pze8hUfsjsleYqTfu+JVQ6XMAwcRAc3k30EEZVDBrVGeT+zTmY9qWDDB5IJ55n7qwfO/lT4X+M+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjywHmQttnW4Icgnxk6aRnicPMKgwI1pwefk4i2byQs=;
 b=W2W4OD3oS+v97pSP5Nn+7etIjdCqhmIfS6kAMfmFS6oXWE+VbLKAlJ3D/AcVs/kTaCa1qZkWNS+/fvy6WOXPB4bkiWlDviVRJT+iGBdaokIbhQ9nJLe0QPz0eLA978tXIyRFMCzPtz8V/2WaySP0RvihRD6ZsNBF8r/p3PgsFt15M1N9PqvE/m1zJQItE15Ck9YGuynMUcPPLh0U5JXLy2SH8QJxby4Sx4dvO0j/h2lS5TnCiW+7fxHsD02AActKs2pBuIK0Mjx9WYw3hlMmiIJFu1/uFrxFC6r2FF+4yFbCu95nsj8+5XrW1kENhrdWy4UuYlPFmwqygzv3uWH0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjywHmQttnW4Icgnxk6aRnicPMKgwI1pwefk4i2byQs=;
 b=chlbjntdC9a1bRqt/wKvTVhkxYPCJMBmU92yegnMGsD9QXdbk7T8cYovlF1ueLMvlTaQDjN74IGauKCSzFWB4E5TgBjZbh67V1+0tTGv9fXpbLqQuNBC82tUqCGrTPeTywC6ZlyPlE4MNeToHwmSpDZgVbGA77dHzKyIDrJg5Sg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5195.namprd11.prod.outlook.com (2603:10b6:806:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 16 Aug
 2022 16:36:55 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 16:36:55 +0000
From:   <Conor.Dooley@microchip.com>
To:     <ajones@ventanamicro.com>, <linux-riscv@lists.infradead.org>,
        <kvm-riscv@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <daolu@rivosinc.com>,
        <jszhang@kernel.org>, <palmer@dabbelt.com>,
        <Conor.Dooley@microchip.com>, <re@w6rz.net>,
        <apatel@ventanamicro.com>
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
Thread-Topic: [PATCH] riscv: Ensure isa-ext static keys are writable
Thread-Index: AQHYsY2eGYLw8iAi7E2kcFjuy+7hb62xua4A
Date:   Tue, 16 Aug 2022 16:36:55 +0000
Message-ID: <bef1a711-506a-d07b-dbd6-3a0c5f90aef2@microchip.com>
References: <20220816163058.3004536-1-ajones@ventanamicro.com>
In-Reply-To: <20220816163058.3004536-1-ajones@ventanamicro.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad2352db-5e62-42f2-470e-08da7fa587fa
x-ms-traffictypediagnostic: SA2PR11MB5195:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0el7w4ga0l4iOlp4iQJtSqHDKxYlRrCHQ/JhcoU2igBnr2X2mtyB1KycMWhrNRGx3sERbBKFo5XFCn0RyReI010wj2LBV24TBwSAVyKY/EPKP58orQWPbhWu1TLoqFE1thxvZLvDtNP44G8vJBXNsh3zCM388VoyJfPCVh/4X+zxgd387g4cfRUxmCtOj9XAuF9JIdQQBRTUNwyC7M3WL2YGWcRy4p8iieeFrQNdel1084Y+vFdig98SBKdSnhOjBpGJEH6Or8JNnjOqEs1Vr/yDvJngfr7XSQIFHAEusSh//KGmd+LHmIml9A1IbCXTFWyqA5HhN7rFlIBiW9h9w0zGUlpNSrvJipinwg7O60nVW3chmEd2y5W4WIx0jTGwmC+gQJV9ZbcorCeADHjqcUQNaQ+lzX/aJbOU8c8ktgDU71z2G6P86seKdt1QfW7Fa3np8DrYjax696QOwnf3oWXnmko9jcmMTqSW0UiP6DHKnuRdq1DP1vS41YX5/gd+yWZQhQzSbFn3TkbixR3B7n96JZcD6a+Cyt30IQMnLl0w9TthC4Lr18XCKCHl1/Lfyfh6HfC2Bc/O0sMd8L2frhJxnAuLJ89y2C19dUnnHr/rcy870Iwuaam1rQ10ptpV46Vt3VUdG0dK58Saf0FymAg99tTla8xWDD8QbJP2Ox02ZsTX5jmD6rOUE6BzLH0zhUbpUuPVygYP+9C7HL+vW3IDyDJ/+39kGZ146d0WutV+JJ2vuri/NVa2f/5TcSG74b1M7uHRypqHBMcAAr12ZXWvU16oH+E9J2vCE5TBZC9b9va4a7XVmO0n3I4kyNNhZszm4oklHnV8xF1f+n1qoe6c6vTW2pkZiK8LZ9V9xDo53CL1kmwpNhs5EMnSw50d
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(366004)(346002)(6512007)(186003)(26005)(5660300002)(8936002)(53546011)(6506007)(41300700001)(31686004)(6486002)(478600001)(2616005)(71200400001)(36756003)(83380400001)(31696002)(86362001)(38100700002)(38070700005)(122000001)(110136005)(2906002)(91956017)(66556008)(4326008)(54906003)(66446008)(8676002)(66946007)(66476007)(76116006)(316002)(64756008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2J2VmROVTlSL1ljRW9vSXNpbmRtODZTTTNKNVp3cmRkRGlwZEdvQy9kUFNJ?=
 =?utf-8?B?OEhzWEtQcVdjTFl4Q1h5clFWYzhUOERYMmdxV2RadGhoc21taEVvV29GSm5p?=
 =?utf-8?B?aDNJUGhuazJGQTZjMVdHaEdNdzJXdENyNnhCa09XUUdhMHg3dzdCYVlseDB0?=
 =?utf-8?B?SFFmUVhkNlA5WEpjSVBudHR5Q041MFYyZEhsaDM3L2FsYzhyc0tvQmdoYmNZ?=
 =?utf-8?B?K0xsUkpmWDhWbmNvY1AzdUZ4d1dwN2ZTSmlpbEs2TG9TdnRPYVk3dkxoQThh?=
 =?utf-8?B?bG1RdVJER3Q4T1lJVi9ick1WN3dUazViSEJCQ2gzdi92QWVRRVA0c0dTVzlF?=
 =?utf-8?B?MzJzWThEempFeG1uaXF2UG4xOFhPbWpjQTVVMXFWSnYxZzlmQ1RmcDhjWUZr?=
 =?utf-8?B?aUh6bDhvK2hXMHBJR2E0Wk5jZWpTUEl1S1RzV3IwZmR3a3lHcjlUSmNxS1Bv?=
 =?utf-8?B?VVdiZVg2TUdlcUpMZDQ2SVlmWDZVODhEbXJSV2crOXRwK0pHUlF5R2k4SHFT?=
 =?utf-8?B?MWlCTGoyeEpKQnhUclkrYldzUXNqeGM0b0xlYWNpSmNPKzlRdVl3VDhoRzhS?=
 =?utf-8?B?c1ZRcU1tcHgvaE5zVUpoMDlkUG11eGdBdm9HZ0d1OVJFaEdXK0tyMEFSc3R2?=
 =?utf-8?B?OWpha3JvQVduUEpZVTk5aEF4UnY3WHNEYWdHaDNpeW1HN2loRUNWS3VtMSts?=
 =?utf-8?B?emtzYlUxUElYMFhGZFpOSVRpU1VQdGFtMFR1ai9VY1Npdys1SVpKSHBmeXE2?=
 =?utf-8?B?czJvNmIrelY0eFlBdGxzYlBvYUZPV2hCTWdLQmZTbVF6RURlck1CcGhrSFlL?=
 =?utf-8?B?bExtSWxSVDI0RGpnVnNDbGRkY2JYa3RlZUJwUi90S2tMMFlsK0NzT3htbkFa?=
 =?utf-8?B?M3JUR2FjWVBkWFlOeDNnS1BiU2s0L1ZvS3p6di9Rcjg4ZjgwUnZUMVB4M25s?=
 =?utf-8?B?MEdlUFF0ODVFUE5obkRqN2xjbkkyalkvYkhZaDB4c0EzWXEwVDNRQ1gxbzVT?=
 =?utf-8?B?NFdkM1lwQjltZHZBa3BLN0x0UDVySWJPL3ZrSlp5aHR0V1FpRTMvejNPNDZa?=
 =?utf-8?B?MXFIWWQ1SDVCUW9LaEVCcVlodVdia2xMbWpZOU94SDhSNUx6cFVUZXNSeDdR?=
 =?utf-8?B?TGlsTmVXZEs2Qk0rbzBnajNDekdjUjQ0NGo3V3RiNFlsWlB4c2FNd3VLbzJK?=
 =?utf-8?B?aE9BRDFCVFJ6NUlOSUhpMk1lVTNFTUNLd1VtUjd0VURpL0pMN1BDT1lwaUlB?=
 =?utf-8?B?dTFSS0xKL2NQdVVEc2RyU0hreHR3a1NaY1BtTU1iN1pia0l1bVZ3V1JYQnJN?=
 =?utf-8?B?Mk5BZkNYMmNWcGRWa3FCSDZTc3R6Vi9sL0ZYNWRGZEcyY2JsVG5NTjJ1cXBy?=
 =?utf-8?B?OVdpUHY1bjFZWWQ5Um90MFl3c1hOck4ySWdpb0R5ZjhIc3JGbjRKWVYzYmpO?=
 =?utf-8?B?MkVOT3VXbkpxYWQ0aVdBWFVZT0pDTkdKaTJ5bWh3elBRRGxQZVlGVmJyelY5?=
 =?utf-8?B?NHFDUFdYcExRYjNtYTBudE1ORzM0dDlNejdDWmE0a1VXOVJscGZvTjhOdm5j?=
 =?utf-8?B?TWxvbU8wRkI5ZUQ2VkplM1NwaGhGNlhKalBjeW8wSG9JR1UyQlM0TlVLcWFQ?=
 =?utf-8?B?cStOOU8wd2Y2ejFmaEZlTlVhL2VYVFRBR1lvZTR3UzhQWC9GdHAwVXA3eFZ4?=
 =?utf-8?B?MkRmKzViZ0ZSMFJ6ZW1SbW5nRVdINmlHV3dqOWR5ZmVCUlZ1RGdteXBJaTRm?=
 =?utf-8?B?K3hGZ2VoZlNuRE1GcTluOHlYaERlZnhQSy9Qa0N0TTEydmlYbldPSUVrUUg4?=
 =?utf-8?B?ZlZyaU1oU2hjTkZjZnVrUGZNVisycWZUVjZJK0M1blZGbER6SlRJNXFQUms0?=
 =?utf-8?B?UjZndGVOZFVJY2orK2gwbkJkQzQ3OXNROEI2MkI3SHcrb1lSUDBiQUtPcTlW?=
 =?utf-8?B?aEI0d2FGajR1bWt1MStXZWUxQUhGQTR6RVB3bVN3b2RVNEJHS2oyQjNEbDEy?=
 =?utf-8?B?blNmd2xjWDdOcWdMLzd6VXhMbHZFRDBiMmUvcVdGbU1Jb25tWm53d1k4eUpG?=
 =?utf-8?B?NWtocjhOMElDUTR1eWRLeHhmR0xLSmpOMnExeFlpczNuL25iTXdOL2g0YWhM?=
 =?utf-8?Q?FBC2rCK5DUMKCqrhRbGW9uVY/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A50C426CB1ACC4598609A661654BB22@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2352db-5e62-42f2-470e-08da7fa587fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 16:36:55.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tN2GDFO32OOSPaBkjZgcgAW0mMnnNMysCCkKH5JaNpYAxaH0IhJyVMbphP20EFQJ+jIE4rgxXp0HH4yA91P7tpqSqJibw93DdQdYFtVhRSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5195
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDgvMjAyMiAxNzozMCwgQW5kcmV3IEpvbmVzIHdyb3RlOg0KPiByaXNjdl9pc2FfZXh0
X2tleXNbXSBpcyBhbiBhcnJheSBvZiBzdGF0aWMga2V5cyB1c2VkIGluIHRoZSB1bmlmaWVkDQo+
IElTQSBleHRlbnNpb24gZnJhbWV3b3JrLiBUaGUga2V5cyBhZGRlZCB0byB0aGlzIGFycmF5IG1h
eSBiZSB1c2VkDQo+IGFueXdoZXJlLCBpbmNsdWRpbmcgaW4gbW9kdWxlcy4gRW5zdXJlIHRoZSBr
ZXlzIHJlbWFpbiB3cml0YWJsZSBieQ0KPiBwbGFjaW5nIHRoZW0gaW4gdGhlIGRhdGEgc2VjdGlv
bi4NCj4gDQo+IFRoZSBuZWVkIHRvIGNoYW5nZSByaXNjdl9pc2FfZXh0X2tleXNbXSdzIHNlY3Rp
b24gd2FzIGZvdW5kIHdoZW4gdGhlDQo+IGt2bSBtb2R1bGUgc3RhcnRlZCBmYWlsaW5nIHRvIGxv
YWQuIENvbW1pdCA4ZWIwNjBlMTAxODUgKCJhcmNoL3Jpc2N2Og0KPiBhZGQgWmloaW50cGF1c2Ug
c3VwcG9ydCIpIGFkZHMgYSBzdGF0aWMgYnJhbmNoIGNoZWNrIGZvciBhIG5ld2x5DQo+IGFkZGVk
IGlzYS1leHQga2V5IHRvIGNwdV9yZWxheCgpLCB3aGljaCBrdm0gdXNlcy4NCj4gDQo+IEZpeGVz
OiBjMzYwY2JlYzM1MTEgKCJyaXNjdjogaW50cm9kdWNlIHVuaWZpZWQgc3RhdGljIGtleSBtZWNo
YW5pc20gZm9yIElTQSBleHRlbnNpb25zIikNCg0KSGV5IERyZXcsDQpIb3cgYWJvdXQgYWRkaW5n
Og0KDQpSZXBvcnRlZC1ieTogUm9uIEVjb25vbW9zIDxyZUB3NnJ6Lm5ldD4NClJlcG9ydGVkLWJ5
OiBBbnVwIFBhdGVsIDxhcGF0ZWxAdmVudGFuYW1pY3JvLmNvbT4NClJlcG9ydGVkLWJ5OiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MsDQpDb25vci4N
Cg0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgSm9uZXMgPGFqb25lc0B2ZW50YW5hbWljcm8uY29t
Pg0KPiAtLS0NCj4gIGFyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYyBiL2FyY2gvcmlzY3Yva2VybmVs
L2NwdWZlYXR1cmUuYw0KPiBpbmRleCA1NTNkNzU1NDgzZWQuLjNiNTU4M2RiOWQ4MCAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1ZmVhdHVyZS5jDQo+ICsrKyBiL2FyY2gvcmlz
Y3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBAQCAtMjgsNyArMjgsNyBAQCB1bnNpZ25lZCBsb25n
IGVsZl9od2NhcCBfX3JlYWRfbW9zdGx5Ow0KPiAgLyogSG9zdCBJU0EgYml0bWFwICovDQo+ICBz
dGF0aWMgREVDTEFSRV9CSVRNQVAocmlzY3ZfaXNhLCBSSVNDVl9JU0FfRVhUX01BWCkgX19yZWFk
X21vc3RseTsNCj4gIA0KPiAtX19yb19hZnRlcl9pbml0IERFRklORV9TVEFUSUNfS0VZX0FSUkFZ
X0ZBTFNFKHJpc2N2X2lzYV9leHRfa2V5cywgUklTQ1ZfSVNBX0VYVF9LRVlfTUFYKTsNCj4gK0RF
RklORV9TVEFUSUNfS0VZX0FSUkFZX0ZBTFNFKHJpc2N2X2lzYV9leHRfa2V5cywgUklTQ1ZfSVNB
X0VYVF9LRVlfTUFYKTsNCj4gIEVYUE9SVF9TWU1CT0wocmlzY3ZfaXNhX2V4dF9rZXlzKTsNCj4g
IA0KPiAgLyoqDQo=
