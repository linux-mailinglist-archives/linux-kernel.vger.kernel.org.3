Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A126B467362
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379269AbhLCIpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:45:41 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:28011 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379268AbhLCIpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1638520936; x=1639125736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I0LfhEynr4Ds2Aj0zG72uyI45R7H3Q0XYKcIJFzTXpc=;
  b=S2aFnpq0RYvpfbF6FeT0x6LqfS+pk/7M9SjMbcbDosTG/RbW2nDkAu1x
   Cy0pYsOOxcksvkhlw5NcMGELbEE0Nl9a5sMv2Aa7ooWAdOsSbJBafJWES
   n9Xbi17UTrISC0wGHYJgLgCzGo2rO14F1CAn6zyhYGr28SYkMXnoR/LLF
   A=;
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 08:42:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLCBxPbkocVg3xCDE86sTEvlItZ/6nWNd/Pmc8inqLaJcxqiPHnQWACY6euZKI9wwoYfCEiElMaZW+niffR9zpyD6i8LLFlB3MQy+vVWRlC4L8u+heE4G22CBl6jc2MVlp5rT3InYbQzgAnaqUcDuZ8s9JqEK1di8vz17wvSOhkc5DMbQ2Y0xGS31hdifI5TyvLIkv16lOOeBhI+4AJNNh4+yGFA9HXmNHxZz4+jNQMHUeJTUrtXewH4YZOBR+OpFJ9W84kTj80lNm2uXrFoH67lS20gbpvDuHkU3PoqzqThW9GTZdVnRR3+bte6zdjCqpzPt7Z+mL0JkY+TS+IWbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0LfhEynr4Ds2Aj0zG72uyI45R7H3Q0XYKcIJFzTXpc=;
 b=IF4npaw5Yug4mljTOOMzU0ayGz2GeyC9/GjSWHqaIe0vmYgdfYZy1rCKzMpWqi0sbeJzyH5e4ej8J5IvNDNSI8HpR7cswCX9zrf4KTI3jIiOOCk7X8F6jHeG5+oOiH/92IT2VbSzX6u9ifs90RsaXIQB1M01H8KS/C+Ayr9x6D8rwaeH9mokgJsYc5XXCDXYPQ1g9DX9SPR/VT1o//sW8kS7O0DleoGxcja1P4q93G5xQap4px0Xb7CIZ4g79fxADpYSCoIKXmB2BlQZ4jjj06p9ztBkdQ+PvYDyAwSWMowbK3NIRAn6/nxvzFtJbBYDN5Cp6hth0iKGzJB0hIExvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by SJ0PR02MB7727.namprd02.prod.outlook.com (2603:10b6:a03:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 08:42:11 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::a9b8:2e0d:5cab:a641]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::a9b8:2e0d:5cab:a641%5]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 08:42:11 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>
Subject: RE: [PATCH V1] mmc: sdhci-msm: Add eMMC and SD card err_stat sysfs
 entry
Thread-Topic: [PATCH V1] mmc: sdhci-msm: Add eMMC and SD card err_stat sysfs
 entry
Thread-Index: AQHX23styyZWglN9ME+SX3fXkkHNz6wUKMiAgAEr25CACYQBIIAADNGAgAAKSICAAZyWQA==
Date:   Fri, 3 Dec 2021 08:42:11 +0000
Message-ID: <SJ0PR02MB844996EAD138FE57F0B54517CD6A9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1637130012-21846-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAPDyKFqd9ThDUPAYom32w4D8nZYxbvYnJgA9dmQnFu2qEhhMig@mail.gmail.com>
 <SJ0PR02MB8449A2533CEFE1B7EAFEA023CD639@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <SJ0PR02MB8449B93CD2752DC3263DD529CD699@SJ0PR02MB8449.namprd02.prod.outlook.com>
 <f178a0db-c978-42cf-1335-09b19d9574cc@intel.com>
 <CAPDyKFpihKExf2qiPuHtbJitP-q21rFCY-MNMdvAvbQd1C2_jA@mail.gmail.com>
In-Reply-To: <CAPDyKFpihKExf2qiPuHtbJitP-q21rFCY-MNMdvAvbQd1C2_jA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e02ba6c1-bb98-4ffd-d77d-08d9b638cc55
x-ms-traffictypediagnostic: SJ0PR02MB7727:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR02MB772740B4AB363008BE6395C5B16A9@SJ0PR02MB7727.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cL+Zc1FX56S5zHB/s93G2IhfJdcUg/4eaOqsn5H/5wEu0zQUCd4QxkorBDgDuoBw3Wy6UQYHi5FeOgxpY8uGqjTln5ADqaxccXe7afI9M26oGyOo0J087Ia4dE7SDYthcFPGGs1xOWMliCrmgYSOPjcvOj9lZdiPgmszy5fW72FvASsncpm9qYrU4z48CTCZ+TswhTRLibXoArWtGkQtlwoxidhijT7906E9D6aSuMLHPOK/ZnmzJ6UMC5dDtaT5LuYTN0kTLpwWltYfLvVk9DZ22VI7rWprTsoE2hyJQTopRFs8fr8HnEaYcmNwl4vEPB/dIzDnb7o7fVpbp8ByWox18MSoeimv2SUWkrHVhEdp2WTH7+PWC0nuzGlFgRBUfqCilqYVjJ3xflaKAnvwWhkqiy/hdL1kQ93+9ExpptNgk/Rtw1PtQuKGrxJhvVBHgIWllhaSnYY6BNqH5+HfGSTPaeIzZh9qmUTzpdJTDKnhYb2f+WOLl/tcvuMu77UT75TFinkcE+7BncTcyuDD55fhTBKRZ2DHwmdOwmJeo6vLp6Xv9OJ6BdxdPs9w8jvch950bb+MQ+zUa5Ks4X2Rja9b/Oxvob0eWFOgGIzZ/6pDb5bRhgF+f3J1gDnfQLAFX1CnIqPlWSpaEw5Kzr6PBIiE14uZcIXlS088kF9gONKm0BJrJ/LI4ff8TpCdQqjTuxo7M7enRb7Xc3dZLb2MIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(8676002)(55016003)(316002)(53546011)(2906002)(8936002)(26005)(66946007)(6506007)(64756008)(66446008)(5660300002)(7416002)(122000001)(71200400001)(9686003)(508600001)(66556008)(66476007)(86362001)(38100700002)(110136005)(83380400001)(54906003)(38070700005)(7696005)(33656002)(52536014)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0NtdnMyMEZBUTYyRU5HTk5TWUtoSUgzUTBEU1U5YUVUWVVObnBTY0svMlpY?=
 =?utf-8?B?SUlwT0srM2dZY1ZUNlA5Smh5bElOVzFsWW53Y3ZoRkxTQWxpSTBvcStBdVhw?=
 =?utf-8?B?WlVPMG1RYTBzd1NkNkpuWWtHaVdob29OMC9qQ0Jza0F6Z2lmb2p5SUlQd1hP?=
 =?utf-8?B?eDJuMjdnRTNhSFIvQ21qampEbG9EZ1l5TU9ocUx0VnNZT3Z5Z0tqWlFTNVY3?=
 =?utf-8?B?WE8zOG11MjdqeVE1NGZnQTJUZ05qb1hrbzI3bURocXJFc0U0bHBFcjZ3MWRU?=
 =?utf-8?B?dko1TjIxajFnN0tGNEFaZm45RzlkWmU2ZXVaYVBkOVRWNHdCV3A1bFJNMmxl?=
 =?utf-8?B?RXRjbkxNVnYzdW9BSEVxREdmQlU1Mk9HdHFwWmxLQWxSN3lCWDBKdTZGdk9z?=
 =?utf-8?B?TVFCOGE3WnJBODlhMFpaSG9iTy9iSi9oRE5lM082OG1EU3ltMEZuNlNOZU93?=
 =?utf-8?B?OVUzM2ZwSTdCVUpzblNMM3VKS3RVUjdLSlVic2NTbUR2czRac3kwa0FtTFJs?=
 =?utf-8?B?THdHK1ptU2tsclliQ2pOWm5ab2lkOTl6eHBsV01YcU9RSm40Rm5aM0JiRHRC?=
 =?utf-8?B?UVdoRHM3TFpXdndSd3I0QVhJWGNJbXpobTg3cUx4bGI3TkZqZHlrcFZGU1RI?=
 =?utf-8?B?NjhmZkcvdnVSdFM4WHV0SnNlekhKa085MElhOFFSSVR2SmdNVFVUQ1EyTXA3?=
 =?utf-8?B?OXJFaGExU0dYWS9NK1crUTA1Vk91bStXb3lUNXVWSWV3bjNHK0ZXNE9JTU9R?=
 =?utf-8?B?YnZWbldSZDVrb0cxTS9hR1ExRVhYeWVrWlorZ3haUk95MldTL1hWZ1pVTHdS?=
 =?utf-8?B?Zys5Rmc0K3JiNHdkWUFoYTdxSE8zcWkzS2w1c2hVTlp4cmp3dHFkL0lUWUNi?=
 =?utf-8?B?Y0hPL0psV045Y0FoV05zWVFxVDNralh3NzZYcDNNMTkwV3Y0cWNHOSt3STNV?=
 =?utf-8?B?aUVYZk95ZHRPR0lITWlDcWlxNUdUUUdtbTBGM05TbXlkYWpEZzd4ZCtDSlhs?=
 =?utf-8?B?Qi8wOVFncG5wOWVsVTRhVCtkMmVpdHRMSWNDT3hRZUl6QkRTMk14eEQ2NjRx?=
 =?utf-8?B?UHptTkttSkJidStySzUzSVFVMVlrcVFHNEtQNnEvTXhLZytBZm5iZmtwb2x3?=
 =?utf-8?B?dWZqTVJLMy84ekRaVE93UFBYZUlqRXBhdzNPS1E4VVpGVlNvM29xVER5QnFW?=
 =?utf-8?B?N3FjQk9aakdTN0c2YUIvVE9mcXl1d3FjblYyaXBOSnRwTjZLaWFjMEVJdXk3?=
 =?utf-8?B?WDJPVGlBdnlzbUoxd3o5QWVqQmlkdlUwVW1JZXNiMmJCTEd4TGVPcUxleXI0?=
 =?utf-8?B?MGV6czEyN096MVFSWlZmU3p4RGZCRDM2RHhsRlVnNks3VW9Nbjcyek16bGNk?=
 =?utf-8?B?Z1VsYUdYaDA1MHluVEErNlJicHdVNHg4MDZObkY0K3pjcW8zUFhVZGpwSGhl?=
 =?utf-8?B?cnY2bm00TGpYOWpSS2JyUy9iZmNML0w1dzlzYXJ3bjlqWUtwb2pNcElDK2Ry?=
 =?utf-8?B?WUhzc2d2Y2JEaXJDYUwwZDVwNDJMbmpUWC9uaTlqbDdIUEZZM1dseU9pb1Rm?=
 =?utf-8?B?MUo5TExIQmlzRlZ4VVB3MHNLdUtzNFE2QTZIUml6Tm5GM2p3aDZNckMzOGh1?=
 =?utf-8?B?eHRVRmhCWExCSmE4Q0JiOU1xY3EwTmYvOWJEWFoyT3RtWE1YTFVlZjEyeGFK?=
 =?utf-8?B?bmlNRTY1QzJRT0lsME5meDVzRFdlRit2RzI2eEU1bVBDMWFjR1RsWUJIQzBS?=
 =?utf-8?B?TjBLYUhNTTJFaTBEUlc5YjRYMVQwNXdtOUtoczVNTTJCS3NwSzU3Vjl0bkgw?=
 =?utf-8?B?TnM0SHRHK0dXZ29ZS25ROXluaXR1NjRjMGtHV0ttZkNyNnZCcGw1SWNBN3FX?=
 =?utf-8?B?b25VWFZJSFdCT29LazRvWS9XclZqak56Vyt4OHdsTTg5ZFVBQ2RVQXpqdDJH?=
 =?utf-8?B?QzhvZzAzYitDUVBTL3FUampGQWJKUklJbEttKzhDZkFCNWJlRmhmek5OOGtK?=
 =?utf-8?B?cmQxMFJKNitrMFFuam12S05GR3BkZGo5VU1ocTlnS3F3SlUrbm8wcGZBR1Fh?=
 =?utf-8?B?V0p3bGVFVENEUFBVbTFnanNPSXJtbVdnNS96bVphRFR3dnp0Y3hTNGU2WW4y?=
 =?utf-8?B?d3pIMHpSUUlNVi9NUlhJMUl4aFVIc0xZOEV0ZTBqalN0UEYrWFJuZms4S3RK?=
 =?utf-8?B?MGw1aVJBc3UvbEhlMVBqbXZhNDM2NXdFeWZmZDVYYW9wSTdvWFZySkJLU3l2?=
 =?utf-8?B?a2ZQWUM1YTFaR1R5TG1TdjZqVzJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02ba6c1-bb98-4ffd-d77d-08d9b638cc55
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 08:42:11.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9XIdXJX9U+OUaikZ2CfcJm0XxIfPG+TYvVRSSVV/2M7nbbZlaltz3eNq+Kc24x/qu8nYWYvevATTGdl8pVU/8DkL3O0CWWl1cx7dZRv85n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rIHlvdSBmb3Igc3VnZ2VzdGlvbiAuLiB3aWxsIG1ha2UgdGhlIGNoYW5nZXMg
Lg0KDQpUaGFua3MsDQpTYWppZGENCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBV
bGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4gDQpTZW50OiBUaHVyc2RheSwgRGVj
ZW1iZXIgMiwgMjAyMSAxOjM1IFBNDQpUbzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+DQpDYzogU2FqaWRhIEJoYW51IChUZW1wKSAoUVVJQykgPHF1aWNfY19zYmhhbnVA
cXVpY2luYy5jb20+OyByaXRlc2hoQGNvZGVhdXJvcmEub3JnOyBBc3V0b3NoIERhcyAoYXNkKSA8
YXN1dG9zaGRAcXVpY2luYy5jb20+OyBhZ3Jvc3NAa2VybmVsLm9yZzsgYmpvcm4uYW5kZXJzc29u
QGxpbmFyby5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1tc21Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdHVtbWFsYUBjb2Rl
YXVyb3JhLm9yZzsgdmJhZGlnYW5AY29kZWF1cm9yYS5vcmc7IFJhbSBQcmFrYXNoIEd1cHRhIChR
VUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChR
VUlDKSA8cXVpY19wcmFnYWxsYUBxdWljaW5jLmNvbT47IHNhcnRnYXJnQGNvZGVhdXJvcmEub3Jn
OyBuaXRpcmF3YUBjb2RlYXVyb3JhLm9yZzsgc2F5YWxpbEBjb2RlYXVyb3JhLm9yZw0KU3ViamVj
dDogUmU6IFtQQVRDSCBWMV0gbW1jOiBzZGhjaS1tc206IEFkZCBlTU1DIGFuZCBTRCBjYXJkIGVy
cl9zdGF0IHN5c2ZzIGVudHJ5DQoNCk9uIFRodSwgMiBEZWMgMjAyMSBhdCAwODoyOCwgQWRyaWFu
IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+IHdyb3RlOg0KPg0KPiBPbiAwMi8xMi8y
MDIxIDA4OjQyLCBTYWppZGEgQmhhbnUgKFRlbXApIChRVUlDKSB3cm90ZToNCj4gPiBHZW50bGUg
UmVtaW5kZXIuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gU2FqaWRhDQo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBTYWppZGEgQmhhbnUgKFRlbXApIChRVUlDKSA8cXVp
Y19jX3NiaGFudUBxdWljaW5jLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI2LCAy
MDIxIDEwOjU0IEFNDQo+ID4gVG86IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
PjsgU2FqaWRhIEJoYW51IChUZW1wKSAoUVVJQykgDQo+ID4gPHF1aWNfY19zYmhhbnVAcXVpY2lu
Yy5jb20+DQo+ID4gQ2M6IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyByaXRlc2hoQGNvZGVhdXJv
cmEub3JnOyBBc3V0b3NoIERhcyANCj4gPiAoYXNkKSA8YXN1dG9zaGRAcXVpY2luYy5jb20+OyBh
Z3Jvc3NAa2VybmVsLm9yZzsgDQo+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IA0KPiA+IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gPiBzdHVtbWFsYUBjb2RlYXVyb3Jh
Lm9yZzsgdmJhZGlnYW5AY29kZWF1cm9yYS5vcmc7IFJhbSBQcmFrYXNoIEd1cHRhIA0KPiA+IChR
VUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChR
VUlDKSANCj4gPiA8cXVpY19wcmFnYWxsYUBxdWljaW5jLmNvbT47IHNhcnRnYXJnQGNvZGVhdXJv
cmEub3JnOyANCj4gPiBuaXRpcmF3YUBjb2RlYXVyb3JhLm9yZzsgc2F5YWxpbEBjb2RlYXVyb3Jh
Lm9yZw0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjFdIG1tYzogc2RoY2ktbXNtOiBBZGQgZU1N
QyBhbmQgU0QgY2FyZCANCj4gPiBlcnJfc3RhdCBzeXNmcyBlbnRyeQ0KPiA+DQo+ID4NCj4gPg0K
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAy
MDIxIDU6MDEgUE0NCj4gPiBUbzogU2FqaWRhIEJoYW51IChUZW1wKSAoUVVJQykgPHF1aWNfY19z
YmhhbnVAcXVpY2luYy5jb20+DQo+ID4gQ2M6IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyByaXRl
c2hoQGNvZGVhdXJvcmEub3JnOyBBc3V0b3NoIERhcyANCj4gPiAoYXNkKSA8YXN1dG9zaGRAcXVp
Y2luYy5jb20+OyBhZ3Jvc3NAa2VybmVsLm9yZzsgDQo+ID4gYmpvcm4uYW5kZXJzc29uQGxpbmFy
by5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IA0KPiA+IGxpbnV4LWFybS1tc21Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gPiBzdHVtbWFs
YUBjb2RlYXVyb3JhLm9yZzsgdmJhZGlnYW5AY29kZWF1cm9yYS5vcmc7IFJhbSBQcmFrYXNoIEd1
cHRhIA0KPiA+IChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT47IFByYWRlZXAgUHJh
Z2FsbGFwYXRpIChRVUlDKSANCj4gPiA8cXVpY19wcmFnYWxsYUBxdWljaW5jLmNvbT47IHNhcnRn
YXJnQGNvZGVhdXJvcmEub3JnOyANCj4gPiBuaXRpcmF3YUBjb2RlYXVyb3JhLm9yZzsgc2F5YWxp
bEBjb2RlYXVyb3JhLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjFdIG1tYzogc2RoY2kt
bXNtOiBBZGQgZU1NQyBhbmQgU0QgY2FyZCANCj4gPiBlcnJfc3RhdCBzeXNmcyBlbnRyeQ0KPiA+
DQo+ID4gT24gV2VkLCAxNyBOb3YgMjAyMSBhdCAwNzoyMCwgU2hhaWsgU2FqaWRhIEJoYW51IDxx
dWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gQWRkIHN5c2ZzIGVu
dHJ5IHRvIHF1ZXJ5IGVNTUMgYW5kIFNEIGNhcmQgZXJyb3JzIHN0YXRpc3RpY3MuDQo+ID4+IFRo
aXMgZmVhdHVyZSBpcyB1c2VmdWwgZm9yIGRlYnVnIGFuZCB0ZXN0aW5nLg0KPiA+Pg0KPiA+PiBT
aWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5j
b20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9tbWMvaG9zdC9jcWhjaS5oICAgICB8ICAgMSAr
DQo+ID4+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW1zbS5jIHwgMTkyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2kuYyAgICAgfCAgMTcgKysrKw0KPiA+PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oICAgICB8
ICAgMSArDQo+ID4+ICBpbmNsdWRlL2xpbnV4L21tYy9ob3N0LmggICAgIHwgICAxICsNCj4gPj4g
IDUgZmlsZXMgY2hhbmdlZCwgMjEyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IFRvIGFsbG93IGFu
IGVhc2llciByZXZpZXcsIEkgc3Ryb25nbHkgc3VnZ2VzdCBzcGxpdHRpbmcgdXAgdGhlIGNoYW5n
ZXMgaW4gc21hbGxlciBwaWVjZXMuIE1heWJlIGluIHRocmVlIHN0ZXBzOiBhZGQgaW50ZXJmYWNl
cywgaW1wbGVtZW50IHRoZW0sIGFkZCBzeXNmcyAtIG9yIHNvbWV0aGluZyBhbG9uZyB0aG9zZSBs
aW5lcy4NCj4gPg0KPiA+IEkgYW0gYWxzbyB0cnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUgYmVuZWZp
dCBvZiBoYXZpbmcgdGhlc2Ugc3RhdHMgYXZhaWxhYmxlLiBDYW4geW91IHBlcmhhcHMgc2hhcmUg
YSBsaXR0bGUgYml0IG9mIGJhY2tncm91bmQgb24gaG93IHRoZXkgYXJlIHVzYWJsZSBmb3IgeW91
PyBJcyBpdCBmb3IgZGVidWcgcHVycG9zZSBvciBkb2VzIGl0IGhhdmUgb3RoZXIgcHVycG9zZXMg
dG9vPw0KPiA+DQo+ID4gSWYgaXQgdHVybnMgb3V0IHRoYXQgd2UgYWdyZWUgb24gZmluZGluZyB0
aGVzZSBzdGF0cyB2YWx1YWJsZSBmb3IgdXMsIHRoZW4gSSBhbSBpbmNsaW5lZCB0byB0aGluayB0
aGF0IHRoaXMgc2hvdWxkIGJlIGludGVncmF0ZWQgY2xvc2VyIHdpdGggdGhlIG1tYyBjb3JlLg0K
PiA+DQo+ID4gVGhlIGVycm9yIGNvZGVzIHRoYXQgYXJlIHByb3BhZ2F0ZWQgdG8gdGhlIGNvcmUg
ZnJvbSBmYWlsZWQgcmVxdWVzdHMgYXJlIGNvbW1vbiBlcnJvciBjb2Rlcywgc28gd2Ugc2hvdWxk
IGJlIGFibGUgdG8gdXNlIHRoYXQgaW5mb3JtYXRpb24gZnJvbSB0aGUgY29yZSBpdHNlbGYsIEkg
dGhpbmsuDQo+ID4NCj4gPiBLaW5kIHJlZ2FyZHMNCj4gPiBVZmZlDQo+ID4NCj4gPiBIaSBVbGYs
DQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXcNCj4gPg0KPiA+IEkgYW0gYWxzbyB0cnlp
bmcgdG8gdW5kZXJzdGFuZCB0aGUgYmVuZWZpdCBvZiBoYXZpbmcgdGhlc2Ugc3RhdHMgYXZhaWxh
YmxlLiBDYW4geW91IHBlcmhhcHMgc2hhcmUgYSBsaXR0bGUgYml0IG9mIGJhY2tncm91bmQgb24g
aG93IHRoZXkgYXJlIHVzYWJsZSBmb3IgeW91PyBJcyBpdCBmb3IgZGVidWcgcHVycG9zZSBvciBk
b2VzIGl0IGhhdmUgb3RoZXIgcHVycG9zZXMgdG9vPw0KPiA+DQo+ID4+Pj4+Pj4+Pj4+Pj4gVGhl
c2UgY2hhbmdlcyBmb3IgZGVidWcgcHVycG9zZSBvbmx5IC4uIGlmIGFueSBlcnJvcnMgb2NjdXJy
ZWQgd2hpbGUgdGVzdGluZyBlTU1DIGFuZCBTRCBjYXJkIHRob3NlIHdpbGwgYmUgY2FwdHVyZWQg
aW4gdGhlc2Ugc3lzZnMgZW50cmllcyAsICB3ZSBjYW4gZGlyZWN0bHkgZ28gYW5kIGNoZWNrIHRo
ZSBzeXNmcyBlbnRyaWVzIGFuZCBnZXQgdG8ga25vdyB3aGF0IGlzIHRoZSBlcnJvciBvY2N1cnJl
ZCBpbiBkcml2ZXIgbGV2ZWwuDQo+DQo+IEkgd291bGQgc3VnZ2VzdCB1c2luZyBkZWJ1Z2ZzIGFu
ZCBhZGRpbmcgc3VwcG9ydCBpbiBtbWMgaG9zdCBkZWJ1Z2ZzIA0KPiBlLmcuDQo+DQo+IHN0YXRp
YyBpbmxpbmUgdm9pZCBtbWNfZGVidWdmc19lcnJfc3RhdHNfZW5hYmxlKHN0cnVjdCBtbWNfaG9z
dCAqbW1jKSANCj4gew0KPiAgICAgICAgIG1tYy0+ZXJyX3N0YXRzX2VuYWJsZWQgPSB0cnVlOyB9
DQo+DQo+IGVudW0gbW1jX2Vycl9zdGF0IHsNCj4gICAgICAgICBNTUNfRVJSX0NNRF9USU1FT1VU
LA0KPiAgICAgICAgIE1NQ19FUlJfQ01EX0NSQywNCj4gICAgICAgICBNTUNfRVJSX0RBVF9USU1F
T1VULA0KPiAgICAgICAgIE1NQ19FUlJfREFUX0NSQywNCj4gICAgICAgICBNTUNfRVJSX0FVVE9f
Q01ELA0KPiAgICAgICAgIE1NQ19FUlJfQURNQSwNCj4gICAgICAgICBNTUNfRVJSX1RVTklORywN
Cj4gICAgICAgICBNTUNfRVJSX0NNRFFfUkVELA0KPiAgICAgICAgIE1NQ19FUlJfQ01EUV9HQ0Us
DQo+ICAgICAgICAgTU1DX0VSUl9DTURRX0lDQ0UsDQo+ICAgICAgICAgTU1DX0VSUl9SRVFfVElN
RU9VVCwNCj4gICAgICAgICBNTUNfRVJSX0NNRFFfUkVRX1RJTUVPVVQsDQo+ICAgICAgICAgTU1D
X0VSUl9JQ0VfQ0ZHLA0KPiAgICAgICAgIE1NQ19FUlJfTUFYLA0KPiB9Ow0KPg0KPiBzdGF0aWMg
aW5saW5lIHZvaWQgbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2luYyhzdHJ1Y3QgbW1jX2hvc3QgKm1t
YywgDQo+IGVudW0gbW1jX2Vycl9zdGF0IHN0YXQpIHsNCj4gICAgICAgICBtbWMtPmVycl9zdGF0
c1tzdGF0XSArPSAxOw0KPiB9DQo+DQo+IEFuZCBhbWVuZCBtbWNfYWRkX2hvc3RfZGVidWdmcygp
IHRvIGNyZWF0ZSB0aGUgZXJyX3N0YXRzIGZpbGUgZXRjLg0KPg0KPiBzZGhjaS5jIGNvdWxkIGNh
bGwgbW1jX2RlYnVnZnNfZXJyX3N0YXRzX2VuYWJsZSgpIGFuZCBtbWNfZGVidWdmc19lcnJfc3Rh
dHNfaW5jKCkgYXMgbmVlZGVkLg0KPiBjcWhjaS5jIGNvdWxkIGNhbGwgbW1jX2RlYnVnZnNfZXJy
X3N0YXRzX2luYygpIGFzIG5lZWRlZC4NCj4NCj4gVWxmLCBkb2VzIHRoYXQgc291bmQgcmVhc29u
YWJsZT8NCg0KWWVzLCBpdCBkb2VzISBUaGFua3MgZm9yIGhhdmluZyBhIGNsb3NlciBsb29rIQ0K
DQpbLi4uXQ0KDQpLaW5kIHJlZ2FyZHMNClVmZmUNCg==
