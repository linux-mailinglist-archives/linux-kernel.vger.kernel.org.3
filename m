Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61D5A6787
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiH3PhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH3PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:37:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1869122538
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661873822; x=1693409822;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2mqTNWa5mwssDaEcyVElkseT6BLmXZt4ZO/uOZ3Gxmg=;
  b=DZEQFVEuOSlR074pm5eikqaXZ4QxrqlJMvOJDryu14p5/y0FjdkQGprq
   DooX2oyzIit/n1DRcVPNgxMoSVNv5hdq4VrM0ihtCpzzFbPhl353h2VFK
   cg9VERo2cVO4VFMaZsbWqyTBYwJPR4004+e87CAVGvRDiXT8L4caMN3PL
   iRREVaV7VLjCWgfDSJI8MbRCLIM0NMcHQ2kQgQQIDkGke9BMjBGfUmHne
   Ck8cSJkw2Mt3fQcxkvKZ/XL7QaqmFgJa/rfPFKAs2rLonEj4HgpUn6H10
   u6w73TsWq1hyM9uGQVsitETpduXegrD5hS9D7MTTHkQtC29ZhtGWRsG+j
   w==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="171617232"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 08:33:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 08:32:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 08:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW4QMJT/AvHQmHeF1ldet77N4GrWpqy6JywgXoLmCMJwRicfWoIso3/2VSC5RzYG0CoH0Wkkx7AcbuxLYCglCGDeNiUg2u+l04KPj90Hkg0wz4xLl2nzbIslnvaUr5f1qJA83wdoe6ScpLozBrRHM/tuRSDtISA4nfHiAfg1d6ohzZrkjCiN8JYpD+S9Ludtq0EwMGh1hBxdhlIR5IDzCrMtaA7KxzblU4EemuCw3G8NH4ebaQfvVycSI0MZCnmOxMMZrHnoM3Ec+wUByEJRy5zQpLKk+M5kbzYAwPyN1BpkrHYtpgE7mBC4AWfOUDT4bJCKa4dmjS1G1eBPHcIxNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mqTNWa5mwssDaEcyVElkseT6BLmXZt4ZO/uOZ3Gxmg=;
 b=E6iQDrCsEAYF542lIUOHdqs4FoAsESkLgGl4eorbytyxV+eYobUW18YSZft2hkmzl9B5y4ds/mugh8l91HPWlWLT9TCjarWsP+ButdvKatQaV5La6G0UDS6wxhC33uQuUd4zEzF9WmPi4IH20ejjgVJR8nMoMlmmwpVkSwdcugHphQf6SkJQ0VaLCAsJKivGMiKNFFdzM48sVc4cgiLjd74XqpCUiYMHvFlfBJ9bli7LGi7Jj6/V68YxoDeOiuw1/oR4ZwFvlRokR9Pp6lrAuc1HxVeh1YrKMFzWLiHG4BgMJeAh7Xh/l5/cTTCnrwEixoU8QIoM0vfQ/FvQCUqKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mqTNWa5mwssDaEcyVElkseT6BLmXZt4ZO/uOZ3Gxmg=;
 b=DbHz40BEYc9ON+vIEWdbD8TvyuFuc6GYjCSwY6TzzYcRtNQsAYWXvOqzLSJlPt0bxlqm2/ED48y+qNaOXpOOu61vLTWqF75YHmhGr4rgLkfwj4Fyb1JPnHXv8C+D93xrJh9TiZm0aZp2qW7cX9OYeLxEs7syLP2VHkVrUODUFgU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB0074.namprd11.prod.outlook.com (2603:10b6:4:69::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Tue, 30 Aug
 2022 15:32:07 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:32:07 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <atishp@atishpatra.org>, <anup@brainfault.org>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <philipp.tomsich@vrull.eu>, <cmuellner@linux.com>,
        <samuel@sholland.org>, <guoren@kernel.org>
Subject: Re: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
Thread-Topic: [PATCH v2] drivers/perf: riscv_pmu_sbi: add support for PMU
 variant on T-Head C9xx cores
Thread-Index: AQHYuWnn2Mp+lPZc6UGa6dEb3oyfda3Bd86AgAYQTYCAAAg3gIAACC2A
Date:   Tue, 30 Aug 2022 15:32:07 +0000
Message-ID: <df04cb3f-caf9-95f4-e54e-7b9f59e8bf3f@microchip.com>
References: <20220826163500.1748653-1-heiko@sntech.de>
 <5f72e3da-d87d-2d8d-bb4b-d95dca65d4f7@microchip.com>
 <3627040.SvYEEZNnvj@diego> <3973491.N7aMVyhfb1@diego>
In-Reply-To: <3973491.N7aMVyhfb1@diego>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce8dabc5-d0ea-4c44-ef1b-08da8a9ccc67
x-ms-traffictypediagnostic: DM5PR11MB0074:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gH5IyildAGqIqUSp0A8FT/o7Tde2jc7mGs+NPkN61DCRW3FmTB+Blak2zF/T9pq/jg/d/gnWp/2KU35g7UMTf18j0qZiMZB1AFImjOtyqyLHRm/nAmqL1YNNnQQbtAVNmBWVIlLw5E4EP4g7x0DAzq/s/co/LsVhEHFhWIZDXd8InjPy52l2VrbjqYwlRJwsxQHw0z2dE+HDvWx35HP7prWG4g212WQLLChi+OdWF/cteE9tni49JPwWUScYoOVq3xXo0+G5DZvwgOdelwke/U7debvcmgI5iJEkbzAcGffFhcQ5Gb+e2zsyX7i6nrwdd7wfipHGOOqNbsh9b8f6hfuUvf+FQDKhbsOR1N7c9BvrymiEsrRGeCy05cpimdMUEGKsaeWooL6tHeQHK9v1FJwTT0Vs/DkVGuedJSX3DZsWQLomXbsiVkp76+smo6c44NgH9hgYLr4wMmHKm7jWewWo1HpeDFjp4hykf3TKajFmreQybR4dNddTfyXCr0SSb13lRwZrKUCs+3PkJgxmOKMhR+Li2uPOUUxqp4VJrvY+rMnQzNI5ikEMuElgdJVdSG3ZuFCc/PTw4qlMALUfJ34/mZXH2Rg1xitKaWWH/bjqtg2WeWT8h3uwcB2mkd1b+Co+wqUwB2xj2joCf1nNqmhxK9wejjIXIy9NtakvJaraSVcX+XFYKYvzxz3fFGPeWCpHlMKGiV0ea02kbfy3aGES9DEw3rpPIaFIhsW9XyIdjlZPz7KLsIsWlQ5vUIsAnlpVWBJmEBsT5hZq2g3HS6NJRht4OnCI7+ql7iI0fW6qMCrSin+qvwaWahewTrwW4rhbk4K7MIMaf2SfboN8bA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(39860400002)(366004)(136003)(26005)(38070700005)(6512007)(6506007)(36756003)(53546011)(31696002)(478600001)(71200400001)(31686004)(66574015)(86362001)(186003)(6486002)(41300700001)(66556008)(91956017)(8936002)(110136005)(8676002)(2616005)(4326008)(66476007)(66946007)(316002)(76116006)(54906003)(38100700002)(66446008)(64756008)(122000001)(7416002)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkppNFZNRlJsaVV1TkxqVCtWTDUvcTVGVnZ6aDBpcisrZkJmeVBCM2ZBZkdH?=
 =?utf-8?B?U21KY1g2M0VZaUNPMnRudXZNMDErTVJEYW1KRFJuMkczR2JUM0JRNGVXQVN4?=
 =?utf-8?B?cVhhNkxZRkg1c3dmaFdQOSs0OGhaV2FpMVpoOVdQQld5RGF1Y3YvajNVTHVj?=
 =?utf-8?B?S2wzSTl3TXp4WXplRCs5UkVoMzlZaEYraXh2Tm1HRU5TbXpKbXpyVHc4RWJY?=
 =?utf-8?B?MWVUWFltRGxsU0l6L3prL2YxQWsrY0VQeVRyS0syYnBXQzA4WUdWR0VWajFQ?=
 =?utf-8?B?Mk1tNVJiYWd1Tk1MajJrdWNseUQwM29veEp0enZsR21uU2VPa0ZvOHJDVWlT?=
 =?utf-8?B?N1VjOXh2MXRhM2dkNzFXVFprY1Q3cEVXeTdPdlZlNEx3RVNqRVRzRnJXQ3Bi?=
 =?utf-8?B?M2JESTNPL2dxay9KZmZzenRIa0wxZkY3Sk9OUjZSbXM4Q2RxNFJiVXp6cXNX?=
 =?utf-8?B?QjZNOEwzWTE1R0hNUjY0bE5YVCtKOEs3dVpiOVhxWUFneUowaE5HRlE1eHpa?=
 =?utf-8?B?STkvcGxXWTlQUFBndGd6cHIwMnhpeGpIVmppSGNiQ2ZqdDQ1OHBna3I4cjE0?=
 =?utf-8?B?TkVlTlpJeVg3MzZ4VEdsTVhseXpMcEVYbkQxKzI4WnBsb0lFSEcxOURreFFi?=
 =?utf-8?B?YmErczdhUmZoWU5nQzhuRXlhelRtU2FaL0lGckc5SHpFaGNBR1Rja1VtcVE0?=
 =?utf-8?B?eExqeVBBbGNoZ2Y5bzE4MWk0Ym92aFh0ckxrS2NhRlFMTHRnM1NldkwwQmMz?=
 =?utf-8?B?NVJ0YmtlaGVPcERQVk5kMTRaUjVKYW5obmRiZVlMSmhiTE5YWnhRN2dMdUQ5?=
 =?utf-8?B?RjcySEhEOFV0eXlQU2djTzVtdDVrdGI1cDZObzc1ZGNRQlNHOUtjd0tTc3RN?=
 =?utf-8?B?QTVwRzF4RjJxRytRVHNiWExHa2lrYjVML0FJQm5rUnlJeEtIT2Y2T1FBZUpY?=
 =?utf-8?B?SU9tWWJKSUJzVkJqWS9OUlJvbXphdlJlM2FYekdGYVdMWnVQRzVkQzdMa09p?=
 =?utf-8?B?WlVTYVE1aGFuRkJZbHo5dHZCdG5zeWlKUHhLckhCRFhrWkdPZVRTbm5oU004?=
 =?utf-8?B?elNmSVFPZXlmdmROTWVuV05DM1ppUDNEMmpTeGZDNVJ6QWdsUHFrdlgxT2VV?=
 =?utf-8?B?bjhJNUxBbTJHc2JiZEp1UkdocG5nMGtHbDVZdTZVYmUxcHJQTFFubGQvOU01?=
 =?utf-8?B?NWZCSU02Mi80Q3hVb1J2emJhdnpqTFVMcTdKejNrNU1pb0tNZUpPNzd3NlAy?=
 =?utf-8?B?ZlYyaGZuTXY0bndoMHJOQmQzcC9CRFlIbWxQeXNSRzZPaU9KenU1OEc0TmR1?=
 =?utf-8?B?WTZlU1dpTm5IS2Y2Y2NlQXJJNnN5ZTFXTEdtM24zK3U5STNueUdlalhKUDhV?=
 =?utf-8?B?M2RsamxWczJ1T3EzVzJwZDlVc0JOcDdQTGUvQUlKd011RW4wVlM5UTIwKzY5?=
 =?utf-8?B?NU1rcHV1K0pmd3dSbndtbHRadjJGUDNFM2U4cGNVSUxTLzg3VTZvY29iL1Ri?=
 =?utf-8?B?VE4yY0tjR3ViM25XZWtkWklRNGo1dUtrbkZHeDBUMmZtdm5lbDNGQ3FERTBo?=
 =?utf-8?B?UDNMcEEvRGRwMkpCUFVCd01xOHVncVFFU3N5UmdYeXJIM3BEY1hkNitFcUFm?=
 =?utf-8?B?VXJNT05zSitRRjlDVHQ1Nk1zdDVVdHNCb1k1dWN5V3JBMDhZenhRVVNqRFQr?=
 =?utf-8?B?d1hEZDFqMHJIbWF0WXZ2NjNGVjBSUXZmNDJ4Y2pYaU1KeG1Ba3lnclBlMENY?=
 =?utf-8?B?aFpPc09ydUZwMFVSMXlvQklkTnptNVBHNE5KbE5DODFTcXd0Slo4cENobTZw?=
 =?utf-8?B?UVZ4V0ZrQjZtNWR0Mkthd1hCN1FPWXorR3p0NVJkWXIyL2x2M1o5aEl3VkNt?=
 =?utf-8?B?NlhJS3RWdThHdU5Td0xGZEJCRzBlcmwyQ2plRFFUVlFtS1E5d3p5NG5uNzlE?=
 =?utf-8?B?U1g1Z21uUzdqMUFWVXJpL0JBcEpFRWd3dS9ZMDZDRGxOY21sOFZZaUp4eTFS?=
 =?utf-8?B?MkVFV0lMYWo1di9NcjlodFdqbWNDVWhobWczRUJ5dVpPcndxd2RSRnpwbVJL?=
 =?utf-8?B?NXBxR0FXbXpocnF4MUNLMnN4S2c5RE9oakdFMU53OXVTbUVuN1RyQld1V2xJ?=
 =?utf-8?B?MUVrOTc3aENxZUdqcjBKVytOUXlUb2Fib0tRbWV4M0xFR05CVVBBYWJjcnhx?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B25A3DAF5E134244B33F81F6B418A3E7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8dabc5-d0ea-4c44-ef1b-08da8a9ccc67
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 15:32:07.4928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBgc0MkBQUiavgiUG5yO0Li32U+Qmz11y2Sen7/ennPiBYxYyZxMAuyrYKMiI86pMi9nNs6v96vQqlLEMw2oyXV6O5kMDA2D3KVoVTwkCDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0074
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxNjowMiwgSGVpa28gU3TDvGJuZXIgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQW0gRGllbnN0YWcsIDMwLiBBdWd1c3QgMjAy
MiwgMTY6MzM6MjcgQ0VTVCBzY2hyaWViIEhlaWtvIFN0w7xibmVyOg0KPj4gQW0gRnJlaXRhZywg
MjYuIEF1Z3VzdCAyMDIyLCAxOTo1NzozMyBDRVNUIHNjaHJpZWIgQ29ub3IuRG9vbGV5QG1pY3Jv
Y2hpcC5jb206DQo+Pj4gT24gMjYvMDgvMjAyMiAxNzozNSwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6
DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2VycmF0YS90aGVhZC9lcnJhdGEuYyBiL2Fy
Y2gvcmlzY3YvZXJyYXRhL3RoZWFkL2VycmF0YS5jDQo+Pj4+IGluZGV4IDIwMmM4M2Y2NzdiMi4u
ZTYxMDFlYWIyNWM4IDEwMDY0NA0KPj4+PiAtLS0gYS9hcmNoL3Jpc2N2L2VycmF0YS90aGVhZC9l
cnJhdGEuYw0KPj4+PiArKysgYi9hcmNoL3Jpc2N2L2VycmF0YS90aGVhZC9lcnJhdGEuYw0KPj4+
PiBAQCAtNDQsNiArNDQsMjIgQEAgc3RhdGljIGJvb2wgZXJyYXRhX3Byb2JlX2Ntbyh1bnNpZ25l
ZCBpbnQgc3RhZ2UsDQo+Pj4+ICAjZW5kaWYNCj4+Pj4gIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBi
b29sIGVycmF0YV9wcm9iZV9wbXUodW5zaWduZWQgaW50IHN0YWdlLA0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgYXJjaF9pZCwgdW5zaWduZWQgbG9uZyBp
bXBpZCkNCj4+Pj4gK3sNCj4+Pj4gKyNpZmRlZiBDT05GSUdfRVJSQVRBX1RIRUFEX1BNVQ0KPj4+
DQo+Pj4gSXMgdGhlcmUgYSByZWFzb24gdGhhdCBhbGwgdGhlIGFsdGVybmF0aXZlcyB1c2UgaWZk
ZWYNCj4+PiByYXRoZXIgdGhhbiBpZihJU19FTkFCTEVEKCkpPw0KPj4NCj4+IG5vIHJlYWwgcmVh
c29uIEkgZ3Vlc3MgLSBtb3JlIGxpa2Ugbm90IGVub3VnaCB0aGlua2luZyA6LSkNCj4+DQo+PiBV
c2luZyBJU19FTkFCTEVEIGFsc28gbWFrZXMgaXQgd2F5IG5pY2VyIGFzIHdlIGNhbiBqdXN0IGRv
DQo+Pg0KPj4gICAgICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19FUlJBVEFfVEhFQURfUE1VKSkN
Cj4+ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiANCj4gVGhvdWdoIGF0IGxlYXN0IGZv
ciB0aGUgQ01PIHRoaXMgaXMgbm90IHBvc3NpYmxlLCBhcyB0aGUNCj4gICAgICAgICByaXNjdl9u
b25jb2hlcmVudF9zdXBwb3J0ZWQoKQ0KPiBpcyBub3QgZGVmaW5lZCBpbiB0aGF0IGNhc2UuDQo+
IA0KPiBUaG91Z2ggaXQgbWlnaHQgYmUgbmljZSB0byBkZWZpbmUgYSBzdHViIGZvciB0aGUNCj4g
bm90LUNPTkZJR19SSVNDVl9ETUFfTk9OQ09IRVJFTlQgY2FzZQ0KPiBzbyB0aGF0IHdlIGRvbid0
IG5lZWQgdG8gI2lmZGVmIGFyb3VuZCBpdC4NCg0KUGVyc29uYWxseSwgSSByZWFsbHkgbGlrZSBJ
U19FTkFCTEVEKCkgJiBzdHVicyBhcyBhbGwgdGhlIGNvZGUNCmdldHMgY29tcGlsZSB0ZXN0ZWQg
YXQgdGhlIHZlcnkgbGVhc3QuIE1heWJlIHRoYXQgaXMgYSBmdXR1cmUNCndvcmsgaXRlbSB0aG91
Z2gsIG5vIG5lZWQgdG8gcmV3b3JrIHRoZSB3b3JsZCBmb3IgdGhpcyBzZXJpZXMuLi4NCg0KSSdk
IHRha2UgdXAgYXJtcyBhbG9uZyBzaWRlIHlvdSB0aG91Z2gsIGlmIHlvdSBkZWNpZGVkIHRvIHdh
Z2UNCndhciBvbiBpZmRlZnMtdGhhdC1jb3VsZC1iZS1JU19FTkFCTEVEKCkgOykNCg0KQ29ub3Iu
DQogDQo=
