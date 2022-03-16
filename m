Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D04DB0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbiCPNRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiCPNRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:17:10 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F851403FE;
        Wed, 16 Mar 2022 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1647436556; x=1648041356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J7S/ubNWXC/WYsjDQaaUbps1gWkDxKIUhcQULD7HhnU=;
  b=K+LbyXu71yeQ5jzaFS/Q96ufjtBa+5dQUovIIuW/NbDqdXd7jcx/uQJM
   y8UTQb1YwIryubra6+28t403wNqNmGK1tgNo9yiJuZ3DGVHYbgCPA/1Vt
   bGSJqK49ZkAFGZrIn2D9NOSkqTvbpgWG2phPMm36gOJvuhPIKZhOVCoSt
   M=;
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 13:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiKTV5wqlEiYU88slqVIXRsIFzWQ40uA6h+zbpLEBOJn2wAgE3YRE7jA8s/t3vRIYQ12C72tOTWhyXIQn9Ahi5KWvp8zV97YzsZeSVbPBnxYEFTUUb9I9ZxLi3jpiAKf+AlqDlNQKzR0+hovtrygvqqrUQ9E+0PUqCsa2Y/9qckNob0q5U3o4hbndmNTEKbug5a3WR/Nr64osyzwOYKP2kRU4mvZkKkqaEAJKZIwpRp2i/43jEIOsPPDP66O0jDsuON5z0N/B8A3p+x+6lvbSSofI8kiyk5TsiBKWsnUj7+qem7p52dKRsv66kXqsF9MooL0g2W3lOZWlAsn3v0jSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7S/ubNWXC/WYsjDQaaUbps1gWkDxKIUhcQULD7HhnU=;
 b=KlAvJDmmY5bqZalR1KnhnJI9mktUzZr7Ufmck2kXKUCe1avW9T+Lh/uKbBAS/KQASLOsrlj0PkQITnL7JrqVR4jcE7gJ5QceH1f3V2AUgfLYhjno43ZIc91ksAPqTCeGXpc2iOmSDHU7lnI3bw5hArFUmxKz/BX3/eZXDJ5O1oyX8bt+rsU3kryDMClHoi0mCZGDSNoPKTiXBlhC6E1JBQIbGz0m3kW3JtL4g365YC5zSpIqOjSKYCgyNnrSVGRnOWVTGF+kjUaWLmR2JH4YLj9rQ0ZLrrOI0YvAzUWScOWVeHH/eGHO3xjn6tcLcuDYqbrzF4vmpQJhGdSWVZZR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by MWHPR02MB3248.namprd02.prod.outlook.com (2603:10b6:301:69::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 13:15:48 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::7c0d:590f:5903:371c]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::7c0d:590f:5903:371c%4]) with mapi id 15.20.5081.017; Wed, 16 Mar 2022
 13:15:48 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "chris@printf.net" <chris@printf.net>,
        "gdjakov@mm-sol.com" <gdjakov@mm-sol.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>
Subject: RE: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Topic: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
Thread-Index: AQHYNJVIWeyx/fyaRESKmIwhuGDfK6zAOooAgAHMLOA=
Date:   Wed, 16 Mar 2022 13:15:47 +0000
Message-ID: <SJ0PR02MB84497927196D953D113F8337CD119@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <daecd30e4798e7d1e4b74dfe37d67b74a6f3cde1.camel@pengutronix.de>
In-Reply-To: <daecd30e4798e7d1e4b74dfe37d67b74a6f3cde1.camel@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a1fcdb6-7f97-4911-8536-08da074f1626
x-ms-traffictypediagnostic: MWHPR02MB3248:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB3248E7937710B98CAA36AB23B1119@MWHPR02MB3248.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wm9UlhOPwReBaBjRxXlO6f7RtTTlng2Ajv9So8QKdkCsxl4rYt4QJsGx7ctw/NXKsH6bmwZ48iU46ObZf83wd8obb7IPDwpl16xcCzSbWa8o31aIZ6sBT3loAhbj8urJmco554yARZ/PUvNal8DiAdNRCajfWGtq6IUkXn7VO204iMg/0Q3FsfJCGb5TJDRCW/FQsHWQUvWIxJ1oRV7dwi0zmmlvdYTeOJQoUzh0J04SELn34wRKyiuykat3yHRqbHR04Qaz9ba1QJ63vj4AjM1vMloop0vX+0grkcCEBSmKtb6ya234etBqS0a2a8vB7SHJap4BygUULn+Feu8BqhTniR5Yy4vcMcNXBGuX4ZYk5iO79FEl1ob8pA0BoDFzGSEKzaGtCRHZnhdbZYEOsBnala1wjx7E0GzQuYzZeSIJvXWpLL4KKlI+SR6rPY2SUmzqXG/w9ERJAjHovpwNx/1KXL8Yg6d13Ss8YXTcyaBs0IEnif5ELLoj51pLjgLx3ewO+hePZfVHw2c/dRDrcB56LqNchCyZEjnt3c0DOrSeytjZSU8IZVA1ohc0iLhCNQ4Z7xiJAOZEm332GYeSIY+UxiR9yEybh+/z4oTBsmkhdtTDie8YbQX5oYlIvUaOX0iHZmB6vA29C/OX7prfRApg+lQM2rF8mrPpZAQX0Bumrn6FgXkPzlXR+ixtZdD+DKQA6MryLgaGV46PlVoMug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(26005)(316002)(55016003)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(107886003)(66446008)(110136005)(54906003)(186003)(86362001)(2906002)(122000001)(4326008)(508600001)(83380400001)(33656002)(6506007)(7696005)(8936002)(53546011)(52536014)(9686003)(7416002)(5660300002)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTUyWFhKZ3dueUoxQlRNQWx0UThjT21aemg1djNiUjZSQ2p6QmdRbUw4RlB5?=
 =?utf-8?B?Rjl5ME5MYzlCVk5kUGJNUVVWR0luVkVvQWdXMXZwbjNXbG0vMHBpVy95WHI2?=
 =?utf-8?B?YUpzenlRY1N0U29keWVsS1Y5cmgzOU1vY2RkSkdrTUlrbzlHTjBkTUVOVEty?=
 =?utf-8?B?M0ZmbW5kT1E4TEdSaVVCYW85ZkpuYjM0bStIWFVDYTJhSDVtcHpLWkpKVzhF?=
 =?utf-8?B?NEtYNnNuRUFHK2ZFdWx2ZEJCdmFSVHZSWGMreHlLSHlDMFFnZm1POVZ0MVhZ?=
 =?utf-8?B?bGJ2RTRLRUs0R2dVZXNERDEyRFo3eThxM0o4K1lPZkhoV095SUcrcmU1by9t?=
 =?utf-8?B?a29YTVk5STNHMjAvL3puUDJCSzZVZjgrQXZDTTg5S3RrSHdKbS9oODBGd3pJ?=
 =?utf-8?B?endGQ1U5YmlEZ3pUSDM3ekJNQk1tMXJHZ2ZJUjZ1Z0xVcHhGSjNnWkM1QnBm?=
 =?utf-8?B?WDkxSnVxYTU0eC9YMW1jVnBacXFWUjBjSlFkOU1KVXU1ZkNMNVlsTkFUaG5p?=
 =?utf-8?B?MzBTSktMcmRUQVZHZkFwSUthcnB3V1dvZGlwSzhOenNISlQ1ZmNnQnlZZ0h5?=
 =?utf-8?B?Sm54bEUvVmNSdHo0dytHT3VmWHZGM2hLdjMvdHRYOGcyWi9WRDZvNTlGMXRk?=
 =?utf-8?B?OGh6em0zNmo0UlZESzM5SUNBeW9PSnFvQ0FGa2grVmx1ZmltWk1zMktjL21i?=
 =?utf-8?B?UHlKN1pxT2RTWi9jdnlFaWhYOGZGWmVIdk1QNnJHWlVWTUsrdlp0NWRKMWZ1?=
 =?utf-8?B?MklUZVNVaWxIaUt6eEZhd01ld0FwNDZaT1dCTTI1Wkt5aWVoMW13Z0F0TVFR?=
 =?utf-8?B?U0ZzODlIb1N5cjVscmt6eStZRnMxUWd1WGd6ZWpBdUhyNGpHTkVaVjZCSVpV?=
 =?utf-8?B?RVdmWktnR0haOE56bWFHa0tuM3BsU1VWaVliRk5rSTNsUzkwT2xEZ05xZWhW?=
 =?utf-8?B?WWxlYTh0clpIVkVHMDhGUUl0Yk9lMzZMK3puN2lZMzF6RTFxcWtJQXR6aDh5?=
 =?utf-8?B?TGF3WHRhalFud2d0em9UWnQrMk9qY0tMWjZkRDh0WFNzWUdBNWtMb0NiUGYz?=
 =?utf-8?B?K2JjT2NGMDU1TlpaclJkV2dITVVVVStJWGFVV1dlbDRoUUxnRTJEMndNQTFr?=
 =?utf-8?B?aEJJc055TGVkNm01UDZUNTZPQm1zbmRXS25Zd1FYQmJLbkgrUFhrQ1JpSmFF?=
 =?utf-8?B?VEVuTzg4SnYrSitPVmVrR2tnaGJ2bkxMcDhyTWRYT3p2aGRNWStRUldHa2li?=
 =?utf-8?B?MEU3bnBFUVAyY09RSnM5emZPbGs2TXZ6RXYyYUwzV2dkWUFHUEJnSFhCczNs?=
 =?utf-8?B?TGphWjR1SjJGTmhRS21SOXJucWU1ZmJuYjY0MzlXcFRCRy9CNGozd0Erck16?=
 =?utf-8?B?NDBRd1o2aytBQjkzSUxKejE1NjhVSW9LcDJMcjJ6ekkrVU5NaUpheWlHMVlJ?=
 =?utf-8?B?N0lWUWhQNmx2MmZaOGlnZmVUeEk5WWxZSXJlNlY0YW45OHpvejdPbzg1Si9G?=
 =?utf-8?B?d2Z1eEQ2a1V5ay85YTJDbkN5ZWx5VDIxd0xtcUxpOGNoZXZ3aTE1Wks2cmhE?=
 =?utf-8?B?ZFl5aXhTcy9PRzZBMDlOQi9mb1lmbEl3a2w1Y1dJTnEvdkhBUUtOSzNvSzlZ?=
 =?utf-8?B?RCtjRlluT1BNbTF4MUNSb3dQKzdKNW5HbHZFc2tJQjBrYzBPZzhIeGFyWC8x?=
 =?utf-8?B?Z3BwY1QvY0l1elYwQUh5c0h3NFFHSFNabTgzUExpbzhMNWxjZjNwSU43ejlX?=
 =?utf-8?B?WUNObUR4V2tNNmNMTy9YVW04WDIzTVdvYmpKWjluaDRlZ1JrNndFVEJJNzc4?=
 =?utf-8?B?Z3BXdWc0SXgvaG9BWGVKRUFMYnFDU3NyUXp6aWluS1NUWjllWUVGWFlnZ1JJ?=
 =?utf-8?B?ekMvRkh0Z1VyMThJaGJUcldkdG5UYWxodkJMMTZYRmxLV2s3WlBzaXRtM040?=
 =?utf-8?Q?FzaQXDTCpzTCY5henZTLvyOHPLdhK+ma?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1fcdb6-7f97-4911-8536-08da074f1626
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:15:48.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OXvKRN3GyhZwtdinN/odfq6JQe3sdlr8wCtGsWVGQ0CvB3KtSUe6fjDPRO5cITYSyJ/pFJpUAaclN2NGFoTt9MJpTVThbRenP584DHGOfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3248
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
DQo+IEZyb206IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6
IFR1ZXNkYXksIE1hcmNoIDE1LCAyMDIyIDM6MTkgUE0NCj4gVG86IFNhamlkYSBCaGFudSAoVGVt
cCkgKFFVSUMpIDxxdWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPjsNCj4gYWRyaWFuLmh1bnRlckBp
bnRlbC5jb207IGFncm9zc0BrZXJuZWwub3JnOyBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsN
Cj4gdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgY2hyaXNAcHJpbnRmLm5ldDsgZ2RqYWtvdkBtbS1z
b2wuY29tDQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tbXNtQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFzdXRvc2gg
RGFzIChRVUlDKSA8cXVpY19hc3V0b3NoZEBxdWljaW5jLmNvbT47DQo+IFJhbSBQcmFrYXNoIEd1
cHRhIChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWljaW5jLmNvbT47IFByYWRlZXANCj4gUHJhZ2Fs
bGFwYXRpIChRVUlDKSA8cXVpY19wcmFnYWxsYUBxdWljaW5jLmNvbT47IFNhcnRoYWsgR2FyZyAo
UVVJQykNCj4gPHF1aWNfc2FydGdhcmdAcXVpY2luYy5jb20+OyBOaXRpbiBSYXdhdCAoUVVJQykN
Cj4gPHF1aWNfbml0aXJhd2FAcXVpY2luYy5jb20+OyBTYXlhbGkgTG9raGFuZGUgKFFVSUMpDQo+
IDxxdWljX3NheWFsaWxAcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjJdIG1t
Yzogc2RoY2ktbXNtOiBSZXNldCBHQ0NfU0RDQ19CQ1IgcmVnaXN0ZXIgZm9yDQo+IFNESEMNCj4g
DQo+IEhpIFNhamlkYSwNCj4gDQo+IE9uIERvLCAyMDIyLTAzLTEwIGF0IDIxOjEwICswNTMwLCBT
aGFpayBTYWppZGEgQmhhbnUgd3JvdGU6DQo+IFsuLi5dDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktbXNtLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLQ0KPiA+IG1z
bS5jIGluZGV4IDUwYzcxZTAuLmNiMzNjOWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS1tc20uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbXNtLmMN
Cj4gWy4uLl0NCj4gPiBAQCAtMjQ4Miw2ICsyNDg0LDQ1IEBAIHN0YXRpYyBpbmxpbmUgdm9pZA0K
PiA+IHNkaGNpX21zbV9nZXRfb2ZfcHJvcGVydHkoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
diwNCj4gPiDCoMKgwqDCoMKgwqDCoMKgb2ZfcHJvcGVydHlfcmVhZF91MzIobm9kZSwgInFjb20s
ZGxsLWNvbmZpZyIsDQo+ID4gJm1zbV9ob3N0LT5kbGxfY29uZmlnKTsNCj4gPiDCoH0NCj4gPg0K
PiA+ICtzdGF0aWMgaW50IHNkaGNpX21zbV9nY2NfcmVzZXQoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNkaGNpX2hv
c3QgKmhvc3QpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAq
cGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0
IHNkaGNpX21zbV9ob3N0ICptc21faG9zdCA9DQo+ID4gK3NkaGNpX3BsdGZtX3ByaXYocGx0Zm1f
aG9zdCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgaW50IHJldCA9IDA7DQo+ID4gKw0KPiA+ICvCoMKg
wqDCoMKgwqDCoG1zbV9ob3N0LT5jb3JlX3Jlc2V0ID0NCj4gPiArZGV2bV9yZXNldF9jb250cm9s
X2dldF9vcHRpb25hbF9leGNsdXNpdmUoJnBkZXYtPmRldiwNCj4gImNvcmVfcmVzZXQiKTsNCj4g
DQo+IEkgdGhpbmsgdGhlICJfcmVzZXQiIHBhcnQgaW4gdGhlIG5hbWUgaXMgc3VwZXJmbHVvdXMg
YW5kIHRoaXMgcmVzZXQgY29udHJvbA0KPiBzaG91bGQgYmUgY2FsbGVkICJjb3JlIi4gSXMgdGhp
cyBkb2N1bWVudGVkIGluIHRoZSBzZGhjaS1tc20gZGV2aWNlIHRyZWUNCj4gYmluZGluZyBkb2N1
bWVudD8NCkZvbGxvd2VkIGV4aXN0aW5nIGNsaWVudHMuLi4NCk5vIGl0cyBub3QgYWRkZWQgaW4g
dGhlIGR0LWJpbmJpbmcsICB3aWxsIGFkZCBkdC1iaW5kaW5nIHBhdGNoIGluIHBhdGNoIHZlcnNp
b24uDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChJU19FUlIobXNtX2hvc3QtPmNvcmVfcmVz
ZXQpKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IFBUUl9FUlIo
bXNtX2hvc3QtPmNvcmVfcmVzZXQpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBkZXZfZXJyKCZwZGV2LT5kZXYsICJjb3JlX3Jlc2V0IHVuYXZhaWxhYmxlICglZClcbiIsDQo+
ID4gK3JldCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1zbV9ob3N0LT5j
b3JlX3Jlc2V0ID0gTlVMTDsNCj4gDQo+IEFzIEJqb3JuIHBvaW50ZWQgb3V0LCB0aGlzIGVycm9y
IHNob3VsZCBiZSByZXR1cm5lZC4NCj4gcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWwgcmV0dXJu
cyBOVUxMIGlmIHRoZSBvcHRpb25hbCByZXNldCBjb250cm9sIGlzIG5vdA0KPiBzcGVjaWZpZWQg
aW4gdGhlIGRldmljZSB0cmVlLCBzbyB3ZSBvbmx5IGxhbmQgaGVyZSBpZiB0aGVyZSdzIGEgcmVh
bCBlcnJvci4NCj4gDQpPaw0KPiBbLi4uXQ0KPiA+IEBAIC0yNTI5LDYgKzI1NzAsMTMgQEAgc3Rh
dGljIGludCBzZGhjaV9tc21fcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+DQo+ID4gwqDCoMKgwqDCoMKgwqDCoG1zbV9ob3N0LT5zYXZlZF90dW5pbmdfcGhhc2Ug
PSBJTlZBTElEX1RVTklOR19QSEFTRTsNCj4gPg0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHNk
aGNpX21zbV9nY2NfcmVzZXQocGRldiwgaG9zdCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJl
dCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKCZwZGV2LT5k
ZXYsICJjb3JlX3Jlc2V0IGFzc2VydC9kZWFzc2VydCBmYWlsZWQNCj4gPiArKCVkKVxuIiwNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0KTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgZ290byBwbHRmbV9mcmVlOw0KPiA+ICvCoMKgwqDCoMKgwqDCoH0NCj4gPiArDQo+
ID4gwqDCoMKgwqDCoMKgwqDCoC8qIFNldHVwIFNEQ0MgYnVzIHZvdGVyIGNsb2NrLiAqLw0KPiA+
IMKgwqDCoMKgwqDCoMKgwqBtc21faG9zdC0+YnVzX2NsayA9IGRldm1fY2xrX2dldCgmcGRldi0+
ZGV2LCAiYnVzIik7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoGlmICghSVNfRVJSKG1zbV9ob3N0LT5i
dXNfY2xrKSkgew0KPiANCj4gSSBub3RpY2UgdGhhdCB0aGlzIGRyaXZlciByZXF1ZXN0cyByZXNv
dXJjZXMgc3VjaCBhcyBjbG9ja3MgYW5kIHJlc2V0cyBhbmQgdGhlbg0KPiBpbW1lZGlhdGVseSB1
c2VzIHRoZW0sIG9uZSBieSBvbmUuIEl0IHdvdWxkIGJlIGJldHRlciB0byByZXF1ZXN0IGFsbA0K
PiByZXNvdXJjZXMgZmlyc3QsIGFuZCBvbmx5IHRoZW4gc3RhcnQgaW50ZXJhY3Rpbmcgd2l0aCB0
aGUgaGFyZHdhcmUuIFRoaXMgaXMgbm90DQo+IGFuIGlzc3VlIHRoYXQgY2FuIGJlIGZpeGVkIGlu
IHRoaXMgcGF0Y2gsIGFsdGhvdWdoIG1heWJlIGl0IGNvdWxkIGJlIHByZXBhcmVkDQo+IGZvciBp
dCBieSBzZXBhcmF0aW5nIHRoZSByZXNldF9jb250cm9sX2dldCBmcm9tIHRoZSBfYXNzZXJ0L2Rl
YXNzZXJ0Lg0KPg0KIFN1cmUsIHdlIHdpbGwgZGlzY3VzcyB0aGlzIHByb3Bvc2FsIGludGVybmFs
bHkgYW5kIHVwZGF0ZS4NCj4gcmVnYXJkcw0KPiBQaGlsaXBwDQoNCg0K
