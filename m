Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794104D2B81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiCIJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiCIJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:13:33 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE536C941;
        Wed,  9 Mar 2022 01:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1646817154; x=1647421954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ITjO4RpHatZ6ZyBWf9fqNSVZnKLco4Ob5c/pwH6ndjM=;
  b=QI++dQUZwtK02jowCDaPJTrwX9deQGOPqEPvqsOLYfe2cJKjrYPrxvcH
   cuS75sd1kznee809NSKXlLuHRZU2koJ8ZnJcoJcYBfPtYc36d1hGJMVsM
   LsxhlTlnSKF4+Okxk9/qwsC4X2+jn9+1V8vEIDJAJJW+YcRl/EPYkOgx8
   U=;
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 09:12:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4FMcqnsN/Ny2AH4bQMr+K+gf4J7Cbrf+RqsyPHGxvuRpIke10WUrdHmPUTLCG+qfmwwnNd5J4G6f0CPSEa2GwqqkzkWlhteifa+RHUfv7lwS3xna1norjTo8u+2Cuu7v5DWr/olvM5YMAc2a/N8yI+0UY1KLw9bZ0BG78RqF8r+jfkPJtkchPQ58+USk6ycRNNVpPdFOzMuhwMC7lwhRqpBhPWadxLtwaqhS0o4THIpXG9fFrskaFZPIcBRpvcC/ljlaBRm3CzWng3lzvjXp1Pt3CUhkJWM5Mb16csX5j8GEDfpgPCh2EbkFPo4rzB/5T0GRRZJoAPZPIpLIAA7hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITjO4RpHatZ6ZyBWf9fqNSVZnKLco4Ob5c/pwH6ndjM=;
 b=U4Dli2W5nbPyKcfqVme0ElesowwI5Qd5cZ1T4bMOnp99HXmRdHK3X7ZKOPA+QYSLU0O51Pnvcq16+GsmlO6kL1bQLucuW/48pXi5vNHoYptyCRX8YhWXvXmKSRVwXhTJ2wxFuSfM4+nIXVAYus1ox8xKZPt+15n6bBUvphTGq2v0IGkDThR6aOaIrrI15/o4gU7N6eUPNdNwrn0fX/xJ5r8IR5HtzKXBt04rJd5UWl7DHSLZWiVigBNwxE3KhWx04n33PEUQfcZLeM+EqS1CzYJ87G2sLADfmjx/U+DnCNKqSoxnUAC197wtuEay6Sa1SRXLScqULk2lDFhbnGdX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BN7PR02MB3988.namprd02.prod.outlook.com (2603:10b6:406:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 09:12:29 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 09:12:29 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "Sarthak Garg (QUIC)" <quic_sartgarg@quicinc.com>,
        "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>,
        "Sayali Lokhande (QUIC)" <quic_sayalil@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V1] arm64: dts: qcom: sc7280: Add GCC hardware register dt
 entry
Thread-Topic: [PATCH V1] arm64: dts: qcom: sc7280: Add GCC hardware register
 dt entry
Thread-Index: AQHYLV1D1arvUHfPNkyZds19x7k8g6yqZk8AgAxqOwA=
Date:   Wed, 9 Mar 2022 09:12:29 +0000
Message-ID: <SJ0PR02MB8449ED1B4026A60F8285A80CCD0A9@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1646133123-22256-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <02d97f5a-b711-6e7e-abd5-ab2387dc3bca@canonical.com>
In-Reply-To: <02d97f5a-b711-6e7e-abd5-ab2387dc3bca@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4a83e7a-5631-4cdc-6919-08da01aceffe
x-ms-traffictypediagnostic: BN7PR02MB3988:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN7PR02MB3988201A8D022514E794AC14B10A9@BN7PR02MB3988.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jfcrhwG+7lKrvvyCjOFT0w8byIs5stLYkCKGcd8Wp8F7ET0TfYTTis8kSq3GrgPI1yQkJdG1xv8jxN1wI9ffT2m0HyHs+LNMsceJgOsazsll+xNvbK7n7rgivgjRKv43x1VWGcMAHkPDnCQAIfQt5PCO416FU8MSUIba5F0pbfN97knPUfEbAhBYvHDInj+pOoqWdjtUzIDxHA2D3+V/zaHzp88ET/tzFeTbjfWndCc19UWATPgktJ9RXpWwd2ESvIMCPWJZM1ihXqCKcxLqtsjpwNlnxxLCoSlzPreX/HBLPgVoKb3Ez8QYtFlxkKxPS1vvCX0t8ZdRRWVwFzTfq+Cv4FbnqnGQ+NiC+gBvjaxVXhIQ9tTH+e9Zpdy6MCUbyXCep10OEpT/J8I+7qPCFRtLJqA4lsLynI1kMhz1LoE22CiAfWVAEYzRskBYQUKilzrTNy0/s4U0xCz1Rr5PyfOMhAHjaETOxVNUowCoieXWmjwoDo6O9WaNlw4Xag1jtReX4Yy9EmiFx+70nyt5oXgLEKBdkc9JKC7OhK/dBlnBKXTMNWCU/fI2uPhhZWeX80dI0fS4S75cRzX/k3rHNPUxM/y1AjcuB98NA0Mod3oTm1e4aSl8tBYFkVUXyzn6Y36aSK6o+04HYCkRnkFwm0qcgEcYpiNfOpiW+lFPwAzmm2xTPPIizaxx3AG0Eo32HBbJ9q1v/U5XxiLXRWkvTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(52536014)(86362001)(5660300002)(7696005)(6506007)(8936002)(53546011)(316002)(55016003)(71200400001)(64756008)(9686003)(508600001)(76116006)(54906003)(66946007)(110136005)(66476007)(26005)(186003)(8676002)(4326008)(33656002)(38070700005)(66446008)(38100700002)(2906002)(66556008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWdTUFVMajRFSWx4bkVQUnMxWmlXb0pEZlhrYTRZcFpEVFBQL01zQ3NQMEg3?=
 =?utf-8?B?OXRUUzRZZ3h4SXZ4OTlzdk9KaUNuVGNwVXQxZUFLMEw5UUJvMEtUbTJnV2tI?=
 =?utf-8?B?WWI5M3gzTmV6bVNMVTJWMklFaFBKU0M0K0ZZaXVvZTdXYnpVeU1zRUMvNFZI?=
 =?utf-8?B?Vk5lZWdNVzlwQkNkU1dVY0JMRUJkNGJOUkxndXNvT2dud2pBUW8xL2dyMWNY?=
 =?utf-8?B?WFp1Qll6Q0dTMFdGYkZDUkVQdVBYVUNxcmltTHk4Z0hSVkQ5WCtZMWRobHdY?=
 =?utf-8?B?V2R5N2VFTDhSbHFnRGJCRkdNcjkyWGRyNkRSMUJlbVhNekNrSkx1aGk1aXJq?=
 =?utf-8?B?dlFRL2RTQnRFVjRaNGRjckF5Mm5ITlJscWtoV0ZvVW5FTlJlRGFQUHJEdlZr?=
 =?utf-8?B?cW4zbkl5dExNKzVVWDd1VjhJc2ROWUZUc0JFbmxNSlFvUE5DM2Fkam5UTWVF?=
 =?utf-8?B?WFlhamx3NmFOUEdOUDJDL2gzYlk5ZVhOR0RSWnRlOG9kdjB5aW4rakNrLy9z?=
 =?utf-8?B?VUF3b1ZTNXJpZEwvbXZUVlg4ZmJxUi81b3ZTUmZHeEJYM3ZtelkwVVN4S3Rp?=
 =?utf-8?B?NnFIcGhDSXliVWhsNXI0MjIvSzNrb3RZQUdiUUFmNHVjOXAyWGVYS2VweGRQ?=
 =?utf-8?B?SEI3M1ZSbWFKd08vZWNMYWNVeEd1NFgvSnVUcFZOcjBoeWZyT1pHMHZhdXVz?=
 =?utf-8?B?SVAxYSt5THd4QndqN0xib0ZCWXpaSU5STkxFTXJWc1NYOEVoTkt5YW9FdU9I?=
 =?utf-8?B?aFpXK2hOL2NmbXNrd0xNNWNMMlpYNUV5TUVOTFJVR0NVbEVqd3lFWXRELzFU?=
 =?utf-8?B?UE0wSEw5ZkcxNWN1WTlCdlpkMUQ4Uy9RVlBxSkVKSnd6Ti84dEkyN2wrSlo3?=
 =?utf-8?B?Ym9hRFJnZE1pNWZGNEwwTEV3ZUs5cTd1OVlzMmxnTDMyS29CQnZneDZNUGtP?=
 =?utf-8?B?cEU2RDhCcVoycVAwbnlDc2ZoNXlxZDJpWlp6ZzR0ZHo1Y2hjaWVGdG5GRnU5?=
 =?utf-8?B?OU43bFFvaGEvQ2xOc1N1eHV0MlBmdXNYMmRva0JwbUh4OWpIOFRpQW5vUUtQ?=
 =?utf-8?B?QjQ3L0VpcWZZNWxqaXlnQXNFY1N2bW9taEpVR2xDd3kvOXdWUk5VMm9JU0o0?=
 =?utf-8?B?c2JzRWY1NDQ0c200bHd1QWxoSUNMVXRCaFlEZlBVOWFzL1luK1Y1OEJtanh3?=
 =?utf-8?B?NUZIdi9oVHN6d1N4K05kanFrNHRiblRLUllUQ3VhMk1OQnFQT0ZRcjQ0d1lE?=
 =?utf-8?B?V2JMS2tOM1FHSldnbDJzeVBXemNneWJGTzZreFh3UU85Y0dGS0tCZmFKbDZO?=
 =?utf-8?B?b3lpTCtWLzBXRXd1cFVzbkswVWZDbTNiTVlIMkZBU2FJbU95OEdKa21FTVpD?=
 =?utf-8?B?V2labUI3WkJoeGpBclRoMDQvR21XNGc5M04xSG1KVWpZd0ZzUnBmRTlVZ0l5?=
 =?utf-8?B?SC94cHRKYzNMdHg2VEsvMWVWS2hua1I4T1hSV09uUTJFYnVtQ1VmeGxBbFJC?=
 =?utf-8?B?TDhWVWhNMC9BYjhUMzFYYzVJTmtJektlcU4zeVhKNUV3OExIVVBibHFCcTBt?=
 =?utf-8?B?am1CbytNaDh6MlFDcXJsNldTQlpPSmhZRmFKcEhTTkJYMjE2b2xFTm1xYlN4?=
 =?utf-8?B?MUluSDg3ZEo0K1lqUTI5TFN2cnVtdU56bWZSdnVUVDVTb1ZvaStNNUJKc0x4?=
 =?utf-8?B?MjZUWm5PN25LWDVHdWdQSVpBcENrVHRDaEIya01hUEhmNHBxUHkxeEg1aFRV?=
 =?utf-8?B?QlNWV3FDMGh1N0pFa3lPVENPemswZUpOdmhNU1pSMVQ0cFRrSk1hRFUxdmZB?=
 =?utf-8?B?T214NHNCLzIwL2twcTRYVGQyWEs5Sld6VHVicUtaRnNLZlJ3ZlNMRVh1MkZV?=
 =?utf-8?B?ck5vNE45aDBWQ3Y2SDZvTlNBeU9pVzlzSVE4QkVFekp6VUJRK0pXRVJWckNl?=
 =?utf-8?B?bXRTNmgwcDRaZjdud2poMXFhSFpDR2tzRFNYK1NsUGJRVGpaYkErUTJIZVdB?=
 =?utf-8?B?NnF6L1dzQTZzd0lKelFHZ3JoSVkvVEtoUWxFK0FKYkExbzVESXZpV2FiUzFS?=
 =?utf-8?B?M2pHemxMOG9jdy94OVgwdlhHSkgrakV6YTI1QnNtZnlEQ1lZSDNNK3VNK3pP?=
 =?utf-8?B?TXlha3d1dHZ1ci85dFNRWTF6QTNVV0NSa2NLeGQ2UUtyYk5MamQrbDNPbnlj?=
 =?utf-8?B?bktQM1FZRm9ENkIzQ1pxU0hrQ0lwMjgwV25YbXdSa2Z6bTB1dXZ1SVI2NHI3?=
 =?utf-8?B?Rm1hamU2ajZSeTcxMEhtY0pMMVFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a83e7a-5631-4cdc-6919-08da01aceffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 09:12:29.7120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U8WFDJwbY9DjDkr5P8Py3TFKOyR/htna/1GBnthXUoE+mX910mzMHMS85nb+T0YWHlqXJfP4y8rIVGsErlzASn0kkmp+L2xNx9oGu6M5cOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3988
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
DQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAY2Fub25p
Y2FsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMSwgMjAyMiA1OjA2IFBNDQo+IFRvOiBT
YWppZGEgQmhhbnUgKFRlbXApIChRVUlDKSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT47DQo+
IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyByb2JoK2R0
QGtlcm5lbC5vcmcNCj4gQ2M6IEFzdXRvc2ggRGFzIChRVUlDKSA8cXVpY19hc3V0b3NoZEBxdWlj
aW5jLmNvbT47IFJhbSBQcmFrYXNoIEd1cHRhDQo+IChRVUlDKSA8cXVpY19yYW1wcmFrYUBxdWlj
aW5jLmNvbT47IFByYWRlZXAgUHJhZ2FsbGFwYXRpIChRVUlDKQ0KPiA8cXVpY19wcmFnYWxsYUBx
dWljaW5jLmNvbT47IFNhcnRoYWsgR2FyZyAoUVVJQykNCj4gPHF1aWNfc2FydGdhcmdAcXVpY2lu
Yy5jb20+OyBOaXRpbiBSYXdhdCAoUVVJQykNCj4gPHF1aWNfbml0aXJhd2FAcXVpY2luYy5jb20+
OyBTYXlhbGkgTG9raGFuZGUgKFFVSUMpDQo+IDxxdWljX3NheWFsaWxAcXVpY2luYy5jb20+OyBh
Z3Jvc3NAa2VybmVsLm9yZzsNCj4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGxpbnV4LWFy
bS1tc21Admdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYxXSBhcm02
NDogZHRzOiBxY29tOiBzYzcyODA6IEFkZCBHQ0MgaGFyZHdhcmUNCj4gcmVnaXN0ZXIgZHQgZW50
cnkNCj4gDQo+IE9uIDAxLzAzLzIwMjIgMTI6MTIsIFNoYWlrIFNhamlkYSBCaGFudSB3cm90ZToN
Cj4gPiBBZGQgR0NDIGhhcmR3YXJlIHJlZ2lzdGVyIGR0IGVudHJ5IGZvciBlTU1DIGFuZCBTRCBj
YXJkLg0KPiANCj4gQXJlbid0IHlvdSBhZGRpbmcgcmVzZXQsIG5vdCBhIGhhcmR3YXJlIHJlZ2lz
dGVyPyBUaGUgc2FtZSBpbiBzdWJqZWN0Lg0KPiANClN1cmUgd2lsbCB1cGRhdGUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhhbnVAcXVpY2lu
Yy5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcyODAuZHRz
aSB8IDYgKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Fjb20vc2M3MjgwLmR0c2kNCj4g
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcyODAuZHRzaQ0KPiA+IGluZGV4IGMwNzc2
NWQuLjJiODQ2MWQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3Nj
NzI4MC5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzI4MC5kdHNp
DQo+ID4gQEAgLTg4MSw2ICs4ODEsOSBAQA0KPiA+ICAJCQltbWMtaHM0MDAtMV84djsNCj4gPiAg
CQkJbW1jLWhzNDAwLWVuaGFuY2VkLXN0cm9iZTsNCj4gPg0KPiA+ICsJCQkvKiBBZGQgZHQgZW50
cnkgZm9yIGdjYyBodyByZXNldCAqLw0KPiANCj4gVGhpcyBjb21tZW50IHNlZW1zIHVucmVsYXRl
ZCBhbmQgZHVwbGljYXRpbmcgY29tbWl0IG1zZy4gQmFzaWNhbGx5IHlvdQ0KPiB3cm90ZSBzYW1l
IHNlbnRlbmNlIGZvdXIgdGltZXM6IHN1YmplY3QsIGNvbW1pdCBtc2cgYW5kIHR3aWNlIGhlcmUu
Li4NCg0KU3VyZSB3aWxsIHVwZGF0ZSANCg0KPiANCj4gPiArCQkJcmVzZXRzID0gPCZnY2MgR0ND
X1NEQ0MxX0JDUj47DQo+ID4gKwkJCXJlc2V0LW5hbWVzID0gImNvcmVfcmVzZXQiOw0KPiA+ICAJ
CQlzZGhjMV9vcHBfdGFibGU6IG9wcC10YWJsZSB7DQo+ID4gIAkJCQljb21wYXRpYmxlID0gIm9w
ZXJhdGluZy1wb2ludHMtdjIiOw0KPiA+DQo+ID4gQEAgLTI2ODYsNiArMjY4OSw5IEBADQo+ID4N
Cj4gPiAgCQkJcWNvbSxkbGwtY29uZmlnID0gPDB4MDAwNzY0MmM+Ow0KPiA+DQo+ID4gKwkJCS8q
IEFkZCBkdCBlbnRyeSBmb3IgZ2NjIGh3IHJlc2V0ICovDQo+IA0KPiBEaXR0by4NCj4gDQo+ID4g
KwkJCXJlc2V0cyA9IDwmZ2NjIEdDQ19TRENDMl9CQ1I+Ow0KPiA+ICsJCQlyZXNldC1uYW1lcyA9
ICJjb3JlX3Jlc2V0IjsNCj4gPiAgCQkJc2RoYzJfb3BwX3RhYmxlOiBvcHAtdGFibGUgew0KPiA+
ICAJCQkJY29tcGF0aWJsZSA9ICJvcGVyYXRpbmctcG9pbnRzLXYyIjsNCj4gPg0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
