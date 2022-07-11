Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC59F56FFD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiGKLNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiGKLMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:12:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43649691E9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657535090; x=1689071090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RloprTTXVAaRvjv+bbx4CzBYrdBDzXeOGhc4mt+Y5lo=;
  b=z7CjLBFFLcBEm9Hqp1A4P6Ke7tKqzl2xlwES5AE5BnpN6aw0JYgvqGCY
   VndT7L2QS1ccLJ/wXCyXmbxhW9q7VOflks3NhXw+fhiPF1HOMxDb3cSo2
   DPmkz1l+eryexs4g6uDFpEXU7KQPkNTT5br6WEhegdv9dDrWADYjziZ7C
   /oJLEGWPWDAwVRW+XBSfZ8cU3uY9w54gyohDKgvByS1SodX8f2oCD76+h
   /i8PO2zJxCgFZQq+0How0Yzw71ZI2HErq7lmh2Ai63hcdoCr8ztPDonWU
   0fQ2PmSyXun+On5rcRqXHRUTDByc3txu+dYhm1agiw4Z766CnnTjAUHN2
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="171852485"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 03:24:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 03:24:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 11 Jul 2022 03:24:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFrqi2ValJQ0IXvXSiID8dknrOESzNqK2wt9yKjwGR042YZm7orgNRoI5+Q2Jhby9oo2psLBYLt1qe0MPZB9+qcDk3z0jIY0zTMbP6PCCGv2gEvceqKoYfNCIod9VA1J/T6QdTY4SfPVYONH0epcFeG1PM8x/doDmQFa98CtQlgy7Gdrlip1fnoh31lyldVpqpDMgXzye648NX9/qBvdo2aWih5FkyFdQrcntVEnvyOvsZfUJu1Kj1X9L/1UGrpsfTrVY03xoQqurFmh+s+DxN7LFUc/QOU4eKFJ0sQwM4X57fVnIdRKaA3QLLIQPS8zqKY14ulPGoKOJ3LHfad5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RloprTTXVAaRvjv+bbx4CzBYrdBDzXeOGhc4mt+Y5lo=;
 b=cet0UmCQoLfS+FHBpJeA3waABRIiefNv+aILSeEIK6xdK8etxZyXJWrVVxgFhbGF6zgAq2toVMNffRjd120Amsp1U/ijiIpvVZ83xxkfIwj/qwUGyQUCMtPcbZ/d+Gj4FoMzHoWhEWjWx6G5Zn4SnkGvi6OSJH8VzsYCu+Khk+Uq8LIEjNZk1FBOfjeVIOzD5gpqtI/X/ogfq+nfQiBXJ/w8Muvo0xhwpjOiu+KPn4YYT6XbFhSw3WJ61b6h/fHoB4HVgdU+IBZFBV7iN4wTJGADWBfU9wZbYbl+l5qNwJVwwB/wltq4zzdJRQsVmspNXACloEmLIFVE/ujJQeuGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RloprTTXVAaRvjv+bbx4CzBYrdBDzXeOGhc4mt+Y5lo=;
 b=pmjzGOKUnwxZK7ka5kruwWasBERki/0LYXz1bJ7NUCvp/kw+LtGTUnfTPHFOelrjtgkawnhFh0Xukr+gveoOA2PQTHCAYZ7Mjvd3u+QDE/nFG/O1RggU9CYvGMhERjR1up+RILhpAz3Uw7a2tSVLFEckI4T18didoY7kro7ZBec=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB0037.namprd11.prod.outlook.com (2603:10b6:910:77::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 10:24:39 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 10:24:38 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <Conor.Dooley@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <palmer@rivosinc.com>, <aou@eecs.berkeley.edu>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>,
        <Daire.McNamara@microchip.com>, <niklas.cassel@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <geert@linux-m68k.org>,
        <zong.li@sifive.com>, <kernel@esmil.dk>, <hahnjo@hahnjo.de>,
        <guoren@kernel.org>, <anup@brainfault.org>,
        <atishp@atishpatra.org>, <heiko@sntech.de>,
        <philipp.tomsich@vrull.eu>, <robh@kernel.org>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Brice.Goglin@inria.fr>
Subject: Re: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Topic: [PATCH v2 1/2] arm64: topology: move store_cpu_topology() to
 shared code
Thread-Index: AQHYkwoSKn1B1/DCVEW+Ox2TaLu0fa108T4AgAEP+oCAAvM+AIAABlmA
Date:   Mon, 11 Jul 2022 10:24:38 +0000
Message-ID: <24e3d8a0-c998-4a68-af28-57dcf15682ee@microchip.com>
References: <20220708203342.256459-1-mail@conchuod.ie>
 <20220708203342.256459-2-mail@conchuod.ie>
 <fb8534d9-baaa-2643-5119-602dfa5de758@microchip.com>
 <efa89122-b428-7691-49d3-f5867206f05a@microchip.com>
 <20220711100204.bj3r3g6xs577kuul@bogus>
In-Reply-To: <20220711100204.bj3r3g6xs577kuul@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 181eb554-d0a4-4b39-7d25-08da63278f67
x-ms-traffictypediagnostic: CY4PR11MB0037:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgXE6i5Fotws1U6OgaG9G3PG4RXDZdzkZDM+0/UcIoOVf9v7BAw5ZsHCWmD6gKAYbVwWqmr6EN8g4wWNhxXd6Qzb9FRChCkN22pUlT1GKLBHoKI4HuGiY10CK0qkCgtRlZxT8v+qPiv4ZAdgdGjtXwn8R/m8Lh/GcrIoqQ8O7L5R8ANYQrfZm8zvclUbSkc1GnEWmGCc6KtUp9uOoT6Ev061QrxlHB9cBq/BMGbkYvIY9orwg+mjq8caMUaZmOLwoJJvzVeoCXtW3XgXSe6QzypcDRBrjRMbgUFkL2VCJWpl/VMtM/j0EL7Ke6OazWmpNpvPZd18ULap+2EoimrTzgtM9YXQiXVtH6B6IBDSImi0xNzIL8PDAugFcK1ofPGrZCVsZI8xp4cBsgrSBOfN1yR/N9jg3Afi51Bdnpe8XlbO0DLuGWAg8EL826/pCvLOJq8PEh2gJABoCpMGVgdjv4+MgjHQmmTdpzzH6usGqyg2zeSm5MuKe/cy0/YTpupZjpVQgxPFzC+jes6632nvq1YdI8tXtxz9kmcId2IJgBA0M0cmu6nznAVNbw8v4j6uC9fgeCQ1g6rObM2XjpKo5uKDDjOPahli6Nq8AHiKEeCJSnYXrDbGeA0glc+MH5w6RqwtWwbfh469XrByVv01C7bFoT/ZT0xGapaboUOqU7UCwp12qX0bbg+yrtbtR18fCIiHK5phXRR8ZQy8ChNuFe0Wjx0yBjzyYBnvUzPREbQyvLQoFKLyKTt7rFMiX4beekzsZE/ev5Xe+TxSn5/mcqNHBoyfinRF7QxNfYhh84Vjmb0HtGQW4H4qm4JYKgMAOFiIQ5ZsuF1DLtsaa4rydTKxVhRdYvBe6yN8zNPEeLNJqJ27RL7rJUDufQhQOHIQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(366004)(346002)(83380400001)(86362001)(110136005)(76116006)(66556008)(66946007)(4326008)(8676002)(66446008)(66476007)(91956017)(64756008)(31696002)(54906003)(5660300002)(38100700002)(316002)(38070700005)(8936002)(41300700001)(36756003)(186003)(2616005)(26005)(71200400001)(6512007)(31686004)(7416002)(6486002)(2906002)(478600001)(122000001)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TThDZ1FQNE84aHhOb2Q4Rm9qVDlIZ2tmSnh0SjE4MU5PUnorSTlxekxpQ21q?=
 =?utf-8?B?M2w1cFN0QXFrZEFXdzVOdDEzYmZGcVlTVWJHaDZYdmY1dkJSUjY3MlhUbHNX?=
 =?utf-8?B?a3I1cVZ0ZWpTck1oYXFMZUpFSWJCWEJLWStIT2NkRDZscmNVL2NiZ3RxVGhS?=
 =?utf-8?B?ZUw3VktzMEZWeDE5RjUydy9lYTJNN1FwRy96a0dEdFpNZzRScitMQlJRRFRV?=
 =?utf-8?B?UWxhSWJ5bE5YWktxdXpoTkJtY2dvaXFuQzdpSUt5VkwzWFB6cWF2V2gzZmp1?=
 =?utf-8?B?QXJteFIrZWliaCtEcVcySWdWMzJWYWRCQStRLy9yRnpkZHpkOHEzY0pQa3ZN?=
 =?utf-8?B?bE54aFZLUCtUL2RsNVdlcTdweFZHaVkrSndIT3kvQTM5OWNkNi9PcXYvSWxw?=
 =?utf-8?B?c1NEeUFhVFNaUkRlYkVvMFkzYzRLQ2twdERrOEFhUmQyZU1Td2pXSjJsa1FN?=
 =?utf-8?B?WTNHYVdGNDFUM1dyN0hlY0UyZGUvYUpUUDFtZktrTlkzNU8xL05ZU2NvMlZa?=
 =?utf-8?B?bEFUYmpUYithZGE2RjNyZXpBVUZYaHNzOWdBdGhKSkpIWVBCeTNqa1FseEtF?=
 =?utf-8?B?bC9CWkxiVTNKTmozdlBRWUJuYjRzR0JuM1NiRWI2VFFMc2xCRnprYjA0SEln?=
 =?utf-8?B?a1FjODZkQ2pqaXRyWWFsMVNqaDc0VUs0TzFaYTlOaTQvTkZodUtlLzI4RExm?=
 =?utf-8?B?REhSTHBTVWFpalBtOFQzTkk1NDNXOXk4TGN6Wkl3Rjg4d0kybXFkWHRtYU1S?=
 =?utf-8?B?S3VGZW9MU1FIa1gyVzYralUxSzJtS1AvcnlOWlA0dTdHNGpHUFc0SitxVjJt?=
 =?utf-8?B?b3pPMVA5TStod01PbjZvN2MwZ1dudGRnWjByY3RGcGtsemVudTlUNDJIZWhF?=
 =?utf-8?B?cmNLNjdDN3hmV1lUYkNIR25WZE5OMnRQMjFYSXdPSzF3QzB1Zm5EbWFsK0JO?=
 =?utf-8?B?SmhyY2lzNGRjOWdRak5tY1RUYnRCOXZST1JjQUlBbmtwUitMVEFEdDRNc2V5?=
 =?utf-8?B?dkRySnY1OUpEb1B4VC9jaWc5RjlXMy9DQjg2V25ZQnVsSFZaWWtBNm95alJ2?=
 =?utf-8?B?VUQ3QXQ0ckdpQllEeE5IclpnQlFCTjRqRlJXQkZlZllCTlFPSWxnV3BseC8w?=
 =?utf-8?B?WU5IQ1NScnRpK3hUaGx1ZzZLa2ZkL09KRXNrMlRZQmY4eDBPRit2SkVTZSsv?=
 =?utf-8?B?SnZ3RW8wY2pyNzl5eWtHRUxyalkyL01kVU5MemtWaHFFeWVVR1kxakpNRmtT?=
 =?utf-8?B?SXB4TXRoTEViNmk4SmFzbm5sQkxibk9kT01HdFg0c0syN1d2eUlxUXNiSVZa?=
 =?utf-8?B?cksrSUd5RTF1YWNDK0RZRXhlNjdiUlEwNmppdUZhaTVSRWh4aXlvZGduWldO?=
 =?utf-8?B?Tm9VNm1lTUhBQVVHSnoraGVodDJad24rUG1ieEVZSXlPVnlPOVNzWEMvVG8w?=
 =?utf-8?B?RUorZDRuaXliYjQvMnAxT3RwejVYWUhTUjdwQWdOSDhvTWRMcWFXbVo4aEJR?=
 =?utf-8?B?YjBoU2ZGT0VPWGdaTEJMaHdWMkpXeTNwUW5aT3gyRUt5WmwxS09lRXE3Ui9D?=
 =?utf-8?B?ZHB1a0d4SkFYenJjNWRJSko3UHhBZGlTNnJTd0p6SlRWNzVKaWo1aytKcTlu?=
 =?utf-8?B?OTMxbzFLUEExOC81RVpiT0t4MzdEakRqY1lTSVhURHUyTFRlM2NocTduWGRr?=
 =?utf-8?B?Z29UYTVIMTZxV2pGa0lVSlhPT0ZSaS9IMm5EY3pEVDZubVRkSTJJMmhvcFZI?=
 =?utf-8?B?K21zUzIvdCtad29GWUZmWU0xV2l4OThlUkdVL0Iwc2hYLzRCL2szZllFZnh6?=
 =?utf-8?B?NllHbWp6QVVrcFp2SWp0NS9jRzBmdTc0VitGNTdhQkUyVldmYmZJMUdBOXZF?=
 =?utf-8?B?VHYrdGJ2NjNMSnVvM2ZpWGVJemU3UUhYS3JNWEZnSGgrUGgvTXoxVGVwUmN4?=
 =?utf-8?B?ZDRRbzQvWGZ2SE9od055YXFJYmJLWEJIVElVVG1MdHFlZU83akVIM1J2NkVh?=
 =?utf-8?B?eTl0YlIxaVlxNzlMZHc1ZmRIa3BpMGlRL3YxcGlKMGo0aER5MENBM3R5RVFI?=
 =?utf-8?B?cGIvVm81NEM5ekZpZE4vKzBEWTBOT2Q0OW9OU0h0UTBtN3FlUDhlb0xZQXQ1?=
 =?utf-8?Q?GRZHg0B/oWsCQHov+0znmLNkF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFB2E607CD531C41932132939B6D00EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181eb554-d0a4-4b39-7d25-08da63278f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2022 10:24:38.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owbnck2YWs37jXKsjrV/DfMrefPeGJxstDFgE5CVMiIG0Wn+tNbuwsNrCTE74J1E/2AxCY6mBpdBahLMn+yvODlDjoSf2miRE8FBpwRMu4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0037
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA3LzIwMjIgMTE6MDIsIFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4gT24gU2F0LCBK
dWwgMDksIDIwMjIgYXQgMTI6NTg6NTdQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5j
b20gd3JvdGU6DQo+PiBMb29raW5nIGF0IHRoZSBhcm0zMiBpbXBsZW1lbnRhdGlvbiAtIGl0IGFw
cGVhcnMgdG8gYmUgbW9zdGx5IHRoZSBzb3J0IG9mIE1QSURSDQo+PiBzdHVmZiB0aGF0IHdhcyBy
ZW1vdmVkIGZyb20gdGhlIGFybTY0IGltcGxlbWVudGF0aW9uIGluIDMxMDJiYzBlNmFjNyAoImFy
bTY0Og0KPj4gdG9wb2xvZ3k6IFN0b3AgdXNpbmcgTVBJRFIgZm9yIHRvcG9sb2d5IGluZm9ybWF0
aW9uIikuIENvdWxkIGFybTMyIGJlbmVmaXQgZnJvbQ0KPj4gdGhlIHNhbWUgc2hhcmVkIGltcGxl
bWVuYXRpb24gdG9vLCBvciBpcyB1c2FnZSBvZiBNUElEUiBvbmx5IGludmFsaWQgZm9yIGFybTY0
Pw0KPiANCj4gSSBkb24ndCByZWNhbGwgYWxsIHRoZSBkZXRhaWxzIGJ1dCBJSVJDIHRoZXJlIGFy
ZSBwYXJ0cyBpZiBhcmNoX3RvcG9sb2d5DQo+IHRoYXQgYXJlIEFSTTY0L1JJU0MtViBvbmx5LiBB
Uk0zMiBkb2Vzbid0IHVzZSBpdCBhcyBpdCBtYXkgYnJlYWsgb2xkDQo+IHBsYXRmb3Jtcy4gU29t
ZSBvZiB0aGUgZnVuY3Rpb25zIHRoYXQgc3RpbGwgYXJtMzIgc3BlY2lmaWMgYXJlIHJldGFpbmVk
DQo+IGluIGFyY2gvYXJtDQo+IA0KPj4gVGhlIG90aGVyIGRpZmZlcmVuY2UgaXMgYSBjYWxsIHRv
IHVwZGF0ZV9jcHVfY2FwYWNpdHkoKSBpbiB0aGUgYXJtMzINCj4+IGltcGxlbWVudGF0aW9uLiBD
b3VsZCB0aGF0IGJlIG1vdmVkIHRvIHNtcF9zdG9yZV9jcHVfaW5mbygpIHdoaWNoIGlzIHRoZSBv
bmx5DQo+PiBjYWxsc2l0ZSBvZiBzdG9yZV9jcHVfdG9wb2xvZ3koKT8NCj4+DQo+IA0KPiBObyBw
bGVhc2UsIGxlYXZlIGFybTMyIGFzIGlzLiBJdCB3YXMgZG9uZSBmb3IgYSByZWFzb24gbGlrZSB0
aGF0IGFuZCBpdA0KPiBoZWxwIHRvIG5vdCBicmVhayBzb21lIG9mIHRoZSBvbGQgMzItYnkgcGxh
dGZvcm1zLg0KDQpUaG91Z2h0IHRoYXQgbWlnaHQgYmUgdGhlIGNhc2UsIEkgd29uJ3QgKGFuZCBk
aWRuJ3QpIHRvdWNoIGFybTMyIQ0KDQpUaGFua3MsDQpDb25vci4NCg==
