Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C157A4D7060
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiCLSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:16:50 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27811E5304;
        Sat, 12 Mar 2022 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647108943; x=1647713743;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5XWun3qkHyG2ipGhTJnJnlhTAsTqL7zeEzMHBCfEr4=;
  b=0gD+wmoPknVuSC7GmqjYN3ygdmF10b3jqszqe7xyqJ20yyV+v8oMCk5I
   oOdPx/xOe5cSH/We1cP1gCYywCEXq6E0q20pdwedcPaMce/3O9Gq9SLet
   4KSCLhOISJpG/VbdphmoFr0KiODDwzJN+38ONVDP34bdzGwa5lx9X4c7r
   8=;
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 18:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx5pE9nDPg1wZ82dCyNjNbg4Shq0qW/FglyYhmAEQVASMzJp8lxdgtpwwQqBvPVeyZrBtE6+Ufpbzf1Gxhf1CAZBEz9sgEH1aAuZy4RwjNWjMZ287dNgW5vLvbXFoPVCL0b3qHjx79F+XVoFI+lcrHjeqi8EEIAeg5GePKmY8fxtQ/IHUMwtg3UNhniAxObcot/VcILTxHA1Q7p2PsPQdZEZyDBhtK4xPrbZcBeF33FAxnsP9D8I3o0O/cd9uqlhArMjR1kFePeCZuN1sim+228wMZkrzIwANBmZqjh4KnaF9ZTrFDljG1XXp1AKUYkWLiNNjdnWWbav3kyDR9uyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5XWun3qkHyG2ipGhTJnJnlhTAsTqL7zeEzMHBCfEr4=;
 b=hvTV7rJ4Rjkgx8BWUnY6UlJzrlQNGzjbSNW6r35snO2PKMoabZuebCbceIb5UuYsLyAfs5tmsGIe23YG+6V2qklH2dDQfk8vD7K3hSMIhZn9R32pI7JTEDKtALwmGV7+Xf7l0suQKuwB2mtnFasbzSGLCVKLH/2F1S0lXeTruuCKx58n4Kh3g7QNUZo1DVGpFfux6yL72OZ81odrPGk6IxOkzkvoriIP6O/unCvgJ0cFEqgm69v2X5utaf6ThR4RiSR02YzZ/Ii+vvTkr7kg68AViWb4buWnDzejJ5pM8ROZ0u/NooTUj0rmA/yeHjyZRNTPPc/66hveCNpI1VqODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by PH0PR02MB7750.namprd02.prod.outlook.com (2603:10b6:510:5e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Sat, 12 Mar
 2022 18:15:36 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.5061.026; Sat, 12 Mar 2022
 18:15:36 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "Asutosh Das (asd)" <asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Veerabhadrarao Badiganti (QUIC)" <quic_vbadigan@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Thread-Topic: [PATCH V4 6/7] mmc: sdhci: Set error state for mmc driver
Thread-Index: AQHYLjYRZaxmExKfPkmW2RHozg4LWKy1S+sAgAbR/YA=
Date:   Sat, 12 Mar 2022 18:15:36 +0000
Message-ID: <SJ0PR02MB8449518ACEA501523DB8E558CD0D9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646226227-32429-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1646226227-32429-7-git-send-email-quic_c_sbhanu@quicinc.com>
 <01515ee6-b312-7f81-43f0-e72a0d290046@intel.com>
In-Reply-To: <01515ee6-b312-7f81-43f0-e72a0d290046@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73ac7eec-a12b-48ab-9061-08da04544e79
x-ms-traffictypediagnostic: PH0PR02MB7750:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR02MB77505877EA7A2F8A08212EC7B10D9@PH0PR02MB7750.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b5smU+NggEBIYpYUZDrfeTzNnzMVp3WEkECVx6WEi7g4zoEESxHfV+NdqcsyOgHcudMP32q1OCHiik7VQMwyRGXxcBG7hJYAa4hXFS8SRIzzUxMcSEHlPnISpsmi3yKrZz8iClwsAOpRYRonyUqI8IGILjqEoqm3McFWtW88c/mGI5NRYaxSZVZm5B8VkLuSY2ibBNtSkpzidWNVZsesuPdkQtDCTyEOxETxtVyHk6C57Td41UGuoYLxrv5W1qZhJu4JzkNoECtdOuiLpkDfgtBcZvq+NwUnV+17b2xPO4oZObSqusqzpPo9REdnYef97ltv37ugLsWnrT2Pnk1bhi/e6dtZQrEYNySMmK2O18S7s84rL5gxXeYTrsOI+JCzeL9vhXgw7vU2EHLPfvDmhntyNF3/MLTVJ0xcr1GfPzDEwe4F0KQ6mC8eSRJ65PRS29+LT/BgG9j234Q9As/dttVsPlI4c8wlOODboD2V+YVatJV2ZOreNfU0Hta+0nkLZmwhvtA7erMRjrv5eULHq3ilLcHdthsDq1Rhwc4Oa6PpuF33o45FKiRfR8rihfg2mmi4kWq30yNurJ/wDMzQtpPFw0IGd50liG++oEm1uumeE9ZbZTWNrD2khlT1y0z3oyKziPlM2Ex6XVMr07YYbWTXnBpdgAkPKfuVr+Fd1YoeD/akM4fF+WexLgnrbZd2gSDi0UljGw6tn94kEzx4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66476007)(66446008)(64756008)(122000001)(8676002)(4326008)(316002)(66556008)(66946007)(5660300002)(38070700005)(8936002)(52536014)(55016003)(38100700002)(86362001)(53546011)(7696005)(6506007)(2906002)(9686003)(26005)(186003)(83380400001)(54906003)(110136005)(71200400001)(508600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU9rOWUrSG80cTgrNHVZWWovZzFOTGJXMEF0SkRuSEwrQ25EMzducy9wdi95?=
 =?utf-8?B?ZGdJOGVWbFFkZzB0SGVOMUI0dmplWWxScmlTR2ZoMUEvUzEzVnI3TUphVVoy?=
 =?utf-8?B?WnVXN0szcWxrN1pUNTA2K1pkOEJvVkZydGV5cEp0V0VTZmRzMWFycEx4bXFt?=
 =?utf-8?B?aDdFZXNCUEJUL0tBVnU5TnllcTY3b3NTOUFxS2pIb1pBeW1UbERNa2ZmVXNl?=
 =?utf-8?B?RW95MHVSSVVuNlF5NUZqWTVwMGhock1yTzVCZXBFWnAzdTUwYTAzRXJJT05m?=
 =?utf-8?B?WFcvRE9nREVGYkkxZjRDS3NDeWFjQm5uSUtkd0Irczk4em5pZytRSWhrTjRm?=
 =?utf-8?B?aHMvcm5qVDFNRXluMjVOZHNSRld1RlJXejF4K1BhN0w5b2hma3d3QmdxT1N4?=
 =?utf-8?B?amUwL1UvUWM5VXRLWW5odGUzYWs1dlVBU202TE81NFMyR2w0N29scm42OFN6?=
 =?utf-8?B?eHVRSjhyUkRBQ2ZuYlNZMFFzRVI5aWorQ2NhTUswM0c5czBNaGpvdVFYaS9D?=
 =?utf-8?B?MHRSYzRTUlM4MDdtMUVBM2ZjTHNyeFNWN2xaOSs4NHRXdmVkZU14TWdQYW1l?=
 =?utf-8?B?RWNIbDFUVXdyWUd2amJYazYybjBMdjQ5YlZ0SGJFQnFtNng0aWNTeDJweURZ?=
 =?utf-8?B?b3BSTzBWNE9TQnVkcmphaEVuKzlsY0xXT05UUUptOXBMZnlNYlBOMGgwN3pF?=
 =?utf-8?B?c1ZZb1MvbzRtZHYzZFE0UHNMZnpRKzE0TmVFd25yR2R0M0FmWFZWL1l4UUF6?=
 =?utf-8?B?UkhKUHhLZDFrSkgwdkR6ajF3cUI3STQzUCtpNXJQL1d3R1RhRG5vZ0tIMENN?=
 =?utf-8?B?WUZFZXJBWlppSHZ0NnU0cXhCbkkxVnRnQUZHZkZIRk1SblZuc0FKKzUyU3VP?=
 =?utf-8?B?SEJ6cm44ZEJkR29LV3l2TWRNS2xUbTFETFVLZDVnWmxybGU1eUhMZThLZmtP?=
 =?utf-8?B?SHpaVlczRnVJdHJ6STZDd0lYUzRmQklWbHVPeEpPS3Z2WXQyN1pqa0RhMzNq?=
 =?utf-8?B?MWhYUVplTjZ6T2ZFVWZoa3Z6UWZvV0ZMa3g1SUV3SXZNUU44ZGQrWTE0RDBw?=
 =?utf-8?B?enFyYVpBVXg0eTJzSWxDaGw5SUJFbG1uTDJhN0RqOTVWRGZaUE1tUHpoYlUz?=
 =?utf-8?B?VFJYaHYxVlBnUi84MmlUL1ZBWDRzZHMwQXcwam5Ub3pKMDlUM0MyUVFDUEVU?=
 =?utf-8?B?UVJDR0lnMml3UkVGMEFSdmExY0xXa2IwVXo2VkhuRGhVb040cWZ5Qk9hdHll?=
 =?utf-8?B?UHFnR2RDOThFeksyaWlBSGRXZlljVWUzSzBmRzRsdDVpQlI2cnRDUkFxLzgx?=
 =?utf-8?B?dFpIVjBhVllJcVZGT3ZqV1RLc0VrNWVMR0hJUzEra1dsUHQvMUFOdlRycFJ0?=
 =?utf-8?B?ZnV2eFB2Y3QyN2pBYUg2ckh1OURBVTJ4N2hRNU0wb0VKMGk3REhsNkpNSTN0?=
 =?utf-8?B?TzFSUzdOR1lJbCt0TVBJQkEyQUpncERkZ0Ywb1NzWEozYWJTa2ZhWE1wRUhY?=
 =?utf-8?B?ZnBjOThId20vN1RYNVNUNjZCSmk0T0VibU5kd2hvc3d5RUZ4MldaaVBKTWdq?=
 =?utf-8?B?ZEdVZmNXUEFnZmNmM0ZkMmoyN2l6Qkl3bVlwOWVxblBCVjlmbXYrOUs2Wnc5?=
 =?utf-8?B?dHphRTNWRXhXTUNGeWVLdzJ5VGllbzhKQ1Z3M3JDM21JanZ1K1NldXBTdkN5?=
 =?utf-8?B?M0dKSGhpOUVVVUVRaXl1Z1VzZURlWlliSTlHUlBtNmpVWGVOeCs0NGFYQjRK?=
 =?utf-8?B?TjltaE5NZlUwN01SczQ3N2ZIanBkSEZINUtwcjY2RkdQWk9hUmo1S29ZL2pj?=
 =?utf-8?B?cTVwUkJ5NzZYMGxnV1BlVklpdlhHTlVMWTJlcWpHL1dGVGVoTk94eVIvd3Qx?=
 =?utf-8?B?NnFlcmxxSmE5TWJsT1d3RUdVNUVpYnlxUmxxS0JDUVl0UTBPVFNpUWJLcGhh?=
 =?utf-8?Q?j5SWMas3wieu+ffYoa9AQFYkbaG9YdD3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ac7eec-a12b-48ab-9061-08da04544e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 18:15:36.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5b0iEeNyx/RDROBnUgHfNdCb5tqYXlAY6oMHDKMuExh/pSQHhRCCbgiRQiNwFHhcIEI80ekrb8jG9AIjy1aZMcYDYFYuqjCCAl1+l1PiGDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7750
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KUGxlYXNlIGZpbmQgdGhlIGlubGluZSBj
b21tZW50cy4NCg0KVGhhbmtzLA0KU2FqaWRhDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBNYXJjaCA4LCAyMDIyIDM6MzYgUE0NCj4gVG86IFNhamlkYSBCaGFudSAoVGVt
cCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPjsgQXN1dG9zaA0KPiBEYXMgKGFz
ZCkgPGFzdXRvc2hkQHF1aWNpbmMuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gYWdy
b3NzQGtlcm5lbC5vcmc7IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBsaW51eC0NCj4gbW1j
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBWZWVyYWJoYWRyYXJhbyBCYWRpZ2FudGkg
KFFVSUMpIDxxdWljX3ZiYWRpZ2FuQHF1aWNpbmMuY29tPjsgUmFtDQo+IFByYWthc2ggR3VwdGEg
KFFVSUMpIDxxdWljX3JhbXByYWthQHF1aWNpbmMuY29tPjsgUHJhZGVlcCBQcmFnYWxsYXBhdGkN
Cj4gKFFVSUMpIDxxdWljX3ByYWdhbGxhQHF1aWNpbmMuY29tPjsgU2FydGhhayBHYXJnIChRVUlD
KQ0KPiA8cXVpY19zYXJ0Z2FyZ0BxdWljaW5jLmNvbT47IE5pdGluIFJhd2F0IChRVUlDKQ0KPiA8
cXVpY19uaXRpcmF3YUBxdWljaW5jLmNvbT47IFNheWFsaSBMb2toYW5kZSAoUVVJQykNCj4gPHF1
aWNfc2F5YWxpbEBxdWljaW5jLmNvbT47IFNheWFsaSBMb2toYW5kZSA8c2F5YWxpbEBjb2RlYXVy
b3JhLm9yZz47IEJhbw0KPiBEIC4gTmd1eWVuIDxuZ3V5ZW5iQGNvZGVhdXJvcmEub3JnPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIFY0IDYvN10gbW1jOiBzZGhjaTogU2V0IGVycm9yIHN0YXRlIGZv
ciBtbWMgZHJpdmVyDQo+IA0KPiBPbiAyLjMuMjAyMiAxNS4wMywgU2hhaWsgU2FqaWRhIEJoYW51
IHdyb3RlOg0KPiA+IFNldCBlcnJvciBzdGF0ZSBpZiBhbnkgZXJyb3JzIG9ic2VydmVkIGluIGVN
TUMgYW5kIFNEIGNhcmQgZHJpdmVyIGxldmVsLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGlh
bmdsaWFuZyBMdSA8bHVsaWFuZ0Bjb2RlYXVyb3JhLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
YXlhbGkgTG9raGFuZGUgPHNheWFsaWxAY29kZWF1cm9yYS5vcmc+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQmFvIEQuIE5ndXllbiA8bmd1eWVuYkBjb2RlYXVyb3JhLm9yZz4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSYW0gUHJha2FzaCBHdXB0YSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2luYy5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8IDIyICsrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmMgaW5kZXgNCj4gPiA3NDFmYjA2Li40YmEzNzk3IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2kuYw0KPiA+IEBAIC0yMjQsNiArMjI0LDggQEAgdm9pZCBzZGhjaV9yZXNldChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzaykNCj4gPiAgCQlpZiAodGltZWRvdXQpIHsNCj4gPiAg
CQkJcHJfZXJyKCIlczogUmVzZXQgMHgleCBuZXZlciBjb21wbGV0ZWQuXG4iLA0KPiA+ICAJCQkJ
bW1jX2hvc3RuYW1lKGhvc3QtPm1tYyksIChpbnQpbWFzayk7DQo+ID4gKwkJCWlmIChob3N0LT5t
bWMgJiYgIWhvc3QtPm1tYy0+ZXJyX3N0YXRlKQ0KPiA+ICsJCQkJbW1jX2RlYnVnZnNfZXJyX3N0
YXRzX2VuYWJsZShob3N0LQ0KPiA+bW1jKTsNCj4gDQo+IEkgcmVhbGx5IGRvIG5vdCB1bmRlcnN0
YW5kIHdoeSB0aGlzIGNhbm5vdCBiZSBhbm90aGVyIGVycl9zdGF0cyBlbnRyeSBzdWNoIGFzDQo+
IE1NQ19FUlJfRFJJVkVSIGFuZCB0aGVuIGFzIGJlbG93Pw0KPiANCj4gCQkJc2RoY2lfZXJyX3N0
YXRzX2luYyhob3N0LCBEUklWRVIpOw0KPiANCj4gDQpIaSwNCg0KZXJyX3N0YXRzIGhhdmluZyBh
bGwgdGhlIGVycm9yIHR5cGVzLg0KZXJyX3N0YXRlIGlzIG5vdCB0aGUgZXJyb3IgdHlwZSwgaWYg
ZXJyX3N0YXRlIHNldCBtZWFucyBzb21lIGVycm9ycyBvY2N1cnJlZCBpbiBkcml2ZXIgYW5kIHdl
IHdpbGwgZ28gYW5kIGNoZWNrIGVycl9zdGF0cyB0byBrbm93IGV4YWN0IGVycm9yLg0KDQpUaGFu
a3MsDQpTYWppZGENCj4gPiAgCQkJc2RoY2lfZHVtcHJlZ3MoaG9zdCk7DQo+ID4gIAkJCXJldHVy
bjsNCj4gPiAgCQl9DQo+ID4gQEAgLTE3MTYsNiArMTcxOCw4IEBAIHN0YXRpYyBib29sIHNkaGNp
X3NlbmRfY29tbWFuZF9yZXRyeShzdHJ1Y3QNCj4gc2RoY2lfaG9zdCAqaG9zdCwNCj4gPiAgCQlp
ZiAoIXRpbWVvdXQtLSkgew0KPiA+ICAJCQlwcl9lcnIoIiVzOiBDb250cm9sbGVyIG5ldmVyIHJl
bGVhc2VkIGluaGliaXQNCj4gYml0KHMpLlxuIiwNCj4gPiAgCQkJICAgICAgIG1tY19ob3N0bmFt
ZShob3N0LT5tbWMpKTsNCj4gPiArCQkJaWYgKGhvc3QtPm1tYyAmJiAhaG9zdC0+bW1jLT5lcnJf
c3RhdGUpDQo+ID4gKwkJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfZW5hYmxlKGhvc3QtDQo+ID5t
bWMpOw0KPiA+ICAJCQlzZGhjaV9kdW1wcmVncyhob3N0KTsNCj4gPiAgCQkJY21kLT5lcnJvciA9
IC1FSU87DQo+ID4gIAkJCXJldHVybiBmYWxzZTsNCj4gPiBAQCAtMTk2NSw2ICsxOTY5LDggQEAg
dm9pZCBzZGhjaV9lbmFibGVfY2xrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1MTYgY2xr
KQ0KPiA+ICAJCWlmICh0aW1lZG91dCkgew0KPiA+ICAJCQlwcl9lcnIoIiVzOiBJbnRlcm5hbCBj
bG9jayBuZXZlciBzdGFiaWxpc2VkLlxuIiwNCj4gPiAgCQkJICAgICAgIG1tY19ob3N0bmFtZSho
b3N0LT5tbWMpKTsNCj4gPiArCQkJaWYgKGhvc3QtPm1tYyAmJiAhaG9zdC0+bW1jLT5lcnJfc3Rh
dGUpDQo+ID4gKwkJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfZW5hYmxlKGhvc3QtDQo+ID5tbWMp
Ow0KPiA+ICAJCQlzZGhjaV9kdW1wcmVncyhob3N0KTsNCj4gPiAgCQkJcmV0dXJuOw0KPiA+ICAJ
CX0NCj4gPiBAQCAtMTk4Nyw2ICsxOTkzLDggQEAgdm9pZCBzZGhjaV9lbmFibGVfY2xrKHN0cnVj
dCBzZGhjaV9ob3N0ICpob3N0LA0KPiB1MTYgY2xrKQ0KPiA+ICAJCQlpZiAodGltZWRvdXQpIHsN
Cj4gPiAgCQkJCXByX2VycigiJXM6IFBMTCBjbG9jayBuZXZlciBzdGFiaWxpc2VkLlxuIiwNCj4g
PiAgCQkJCSAgICAgICBtbWNfaG9zdG5hbWUoaG9zdC0+bW1jKSk7DQo+ID4gKwkJCQlpZiAoaG9z
dC0+bW1jICYmICFob3N0LT5tbWMtPmVycl9zdGF0ZSkNCj4gPiArDQo+IAltbWNfZGVidWdmc19l
cnJfc3RhdHNfZW5hYmxlKGhvc3QtPm1tYyk7DQo+ID4gIAkJCQlzZGhjaV9kdW1wcmVncyhob3N0
KTsNCj4gPiAgCQkJCXJldHVybjsNCj4gPiAgCQkJfQ0KPiA+IEBAIC0zMTYyLDYgKzMxNzAsOCBA
QCBzdGF0aWMgdm9pZCBzZGhjaV90aW1lb3V0X3RpbWVyKHN0cnVjdCB0aW1lcl9saXN0DQo+ICp0
KQ0KPiA+ICAJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19pbmMoaG9zdC0+bW1jLA0KPiBNTUNfRVJS
X1JFUV9USU1FT1VUKTsNCj4gPiAgCQlwcl9lcnIoIiVzOiBUaW1lb3V0IHdhaXRpbmcgZm9yIGhh
cmR3YXJlIGNtZCBpbnRlcnJ1cHQuXG4iLA0KPiA+ICAJCSAgICAgICBtbWNfaG9zdG5hbWUoaG9z
dC0+bW1jKSk7DQo+ID4gKwkJaWYgKGhvc3QtPm1tYyAmJiAhaG9zdC0+bW1jLT5lcnJfc3RhdGUp
DQo+ID4gKwkJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19lbmFibGUoaG9zdC0+bW1jKTsNCj4gPiAg
CQlzZGhjaV9kdW1wcmVncyhob3N0KTsNCj4gPg0KPiA+ICAJCWhvc3QtPmNtZC0+ZXJyb3IgPSAt
RVRJTUVET1VUOw0KPiA+IEBAIC0zMTg1LDYgKzMxOTUsOCBAQCBzdGF0aWMgdm9pZCBzZGhjaV90
aW1lb3V0X2RhdGFfdGltZXIoc3RydWN0DQo+IHRpbWVyX2xpc3QgKnQpDQo+ID4gIAkJbW1jX2Rl
YnVnZnNfZXJyX3N0YXRzX2luYyhob3N0LT5tbWMsDQo+IE1NQ19FUlJfUkVRX1RJTUVPVVQpOw0K
PiA+ICAJCXByX2VycigiJXM6IFRpbWVvdXQgd2FpdGluZyBmb3IgaGFyZHdhcmUgaW50ZXJydXB0
LlxuIiwNCj4gPiAgCQkgICAgICAgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYykpOw0KPiA+ICsJCWlm
IChob3N0LT5tbWMgJiYgIWhvc3QtPm1tYy0+ZXJyX3N0YXRlKQ0KPiA+ICsJCQltbWNfZGVidWdm
c19lcnJfc3RhdHNfZW5hYmxlKGhvc3QtPm1tYyk7DQo+ID4gIAkJc2RoY2lfZHVtcHJlZ3MoaG9z
dCk7DQo+ID4NCj4gPiAgCQlpZiAoaG9zdC0+ZGF0YSkgew0KPiA+IEBAIC0zMjM2LDYgKzMyNDgs
OCBAQCBzdGF0aWMgdm9pZCBzZGhjaV9jbWRfaXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LA0K
PiB1MzIgaW50bWFzaywgdTMyICppbnRtYXNrX3ApDQo+ID4gIAkJCXJldHVybjsNCj4gPiAgCQlw
cl9lcnIoIiVzOiBHb3QgY29tbWFuZCBpbnRlcnJ1cHQgMHglMDh4IGV2ZW4gdGhvdWdoIG5vDQo+
IGNvbW1hbmQgb3BlcmF0aW9uIHdhcyBpbiBwcm9ncmVzcy5cbiIsDQo+ID4gIAkJICAgICAgIG1t
Y19ob3N0bmFtZShob3N0LT5tbWMpLCAodW5zaWduZWQpaW50bWFzayk7DQo+ID4gKwkJaWYgKGhv
c3QtPm1tYyAmJiAhaG9zdC0+bW1jLT5lcnJfc3RhdGUpDQo+ID4gKwkJCW1tY19kZWJ1Z2ZzX2Vy
cl9zdGF0c19lbmFibGUoaG9zdC0+bW1jKTsNCj4gPiAgCQlzZGhjaV9kdW1wcmVncyhob3N0KTsN
Cj4gPiAgCQlyZXR1cm47DQo+ID4gIAl9DQo+ID4gQEAgLTMyODksNiArMzMwMyw4IEBAIHN0YXRp
YyB2b2lkIHNkaGNpX2FkbWFfc2hvd19lcnJvcihzdHJ1Y3QNCj4gc2RoY2lfaG9zdCAqaG9zdCkN
Cj4gPiAgCXZvaWQgKmRlc2MgPSBob3N0LT5hZG1hX3RhYmxlOw0KPiA+ICAJZG1hX2FkZHJfdCBk
bWEgPSBob3N0LT5hZG1hX2FkZHI7DQo+ID4NCj4gPiArCWlmIChob3N0LT5tbWMgJiYgIWhvc3Qt
Pm1tYy0+ZXJyX3N0YXRlKQ0KPiA+ICsJCW1tY19kZWJ1Z2ZzX2Vycl9zdGF0c19lbmFibGUoaG9z
dC0+bW1jKTsNCj4gPiAgCXNkaGNpX2R1bXByZWdzKGhvc3QpOw0KPiA+DQo+ID4gIAl3aGlsZSAo
dHJ1ZSkgew0KPiA+IEBAIC0zMzc4LDYgKzMzOTQsOCBAQCBzdGF0aWMgdm9pZCBzZGhjaV9kYXRh
X2lycShzdHJ1Y3Qgc2RoY2lfaG9zdA0KPiA+ICpob3N0LCB1MzIgaW50bWFzaykNCj4gPg0KPiA+
ICAJCXByX2VycigiJXM6IEdvdCBkYXRhIGludGVycnVwdCAweCUwOHggZXZlbiB0aG91Z2ggbm8g
ZGF0YQ0KPiBvcGVyYXRpb24gd2FzIGluIHByb2dyZXNzLlxuIiwNCj4gPiAgCQkgICAgICAgbW1j
X2hvc3RuYW1lKGhvc3QtPm1tYyksICh1bnNpZ25lZClpbnRtYXNrKTsNCj4gPiArCQlpZiAoaG9z
dC0+bW1jICYmICFob3N0LT5tbWMtPmVycl9zdGF0ZSkNCj4gPiArCQkJbW1jX2RlYnVnZnNfZXJy
X3N0YXRzX2VuYWJsZShob3N0LT5tbWMpOw0KPiA+ICAJCXNkaGNpX2R1bXByZWdzKGhvc3QpOw0K
PiA+DQo+ID4gIAkJcmV0dXJuOw0KPiA+IEBAIC0zNTk5LDYgKzM2MTcsOCBAQCBzdGF0aWMgaXJx
cmV0dXJuX3Qgc2RoY2lfaXJxKGludCBpcnEsIHZvaWQgKmRldl9pZCkNCj4gPiAgCWlmICh1bmV4
cGVjdGVkKSB7DQo+ID4gIAkJcHJfZXJyKCIlczogVW5leHBlY3RlZCBpbnRlcnJ1cHQgMHglMDh4
LlxuIiwNCj4gPiAgCQkJICAgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYyksIHVuZXhwZWN0ZWQpOw0K
PiA+ICsJCWlmIChob3N0LT5tbWMgJiYgIWhvc3QtPm1tYy0+ZXJyX3N0YXRlKQ0KPiA+ICsJCQlt
bWNfZGVidWdmc19lcnJfc3RhdHNfZW5hYmxlKGhvc3QtPm1tYyk7DQo+ID4gIAkJc2RoY2lfZHVt
cHJlZ3MoaG9zdCk7DQo+ID4gIAl9DQo+ID4NCj4gPiBAQCAtMzk2Miw2ICszOTgyLDggQEAgYm9v
bCBzZGhjaV9jcWVfaXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1MzINCj4gaW50bWFzaywg
aW50ICpjbWRfZXJyb3IsDQo+ID4gIAkJc2RoY2lfd3JpdGVsKGhvc3QsIGludG1hc2ssIFNESENJ
X0lOVF9TVEFUVVMpOw0KPiA+ICAJCXByX2VycigiJXM6IENRRTogVW5leHBlY3RlZCBpbnRlcnJ1
cHQgMHglMDh4LlxuIiwNCj4gPiAgCQkgICAgICAgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYyksIGlu
dG1hc2spOw0KPiA+ICsJCWlmIChob3N0LT5tbWMgJiYgIWhvc3QtPm1tYy0+ZXJyX3N0YXRlKQ0K
PiA+ICsJCQltbWNfZGVidWdmc19lcnJfc3RhdHNfZW5hYmxlKGhvc3QtPm1tYyk7DQo+ID4gIAkJ
c2RoY2lfZHVtcHJlZ3MoaG9zdCk7DQo+ID4gIAl9DQo+ID4NCg0K
