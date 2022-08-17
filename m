Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A6596A14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiHQHKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiHQHKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:10:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583685B787;
        Wed, 17 Aug 2022 00:10:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GN8vOt003957;
        Wed, 17 Aug 2022 09:09:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=9Qc+hNxMWQhyIdZYIMPvfYpnZKa9I4gWfj66Nw3SwcE=;
 b=QKMfV/GrOAvuBo+rOjXWvNDeLM5UR0YbQk84ur/pHyvlGzROtWK2GfggnIk4575FSYKP
 6ANLeHN0UAo1O8ulMTiymg/4Y+P+FAOCKVgl44XOB1U0cTkZp9WnpMQ4ba5hT/2eNT1o
 LpYHTUgc4d6V5+C0uVyCj2V8vhfcASzcqCCZFBy6uzYCdMYaBMigYZnHv9NsDt7uOo6v
 42D20Ym8gR9hAzMhGMAc7wwHdQBRPgZP7vMPSnD/FcE4+Wb6dQdRxV8WbsbgZ1fnxN8r
 d6c2zSv5zyPXlhbTZ9gRbDXMdV5FUsDPeKJDuTvrIjO4z+WRQHpFHoVfhqsetqs+bmkN YQ== 
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hx3a134gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 09:09:59 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acx/txGybP1DgAU36oeKYYjxpTyHEUpwSUnObFGrlh1KcGZ6JrtDt+vUYiHhULn+eeg2eMHVIRhSpCZyPAESQSfo8ToRtxMdJBxOdF2EQExaAllI+tZSX+uC+z2s0YY3a8wRUJv9sVu4LKZ4RHuwBu06e1efXFisuFCiquSvFYus2/FhuYoNxyvysm/N332DQAYk6IAb49fBjgHEkzRh8hEpGLwLKHQx1pPfUybt6IuqGwE5hwGQ1xOBfV8NCJd2TPVIuE7SOdyIHcufMvRcXCtSLheb/hgxtamvZvVTzqtRlaPHbXvTUf7cLJH3rUN+NqWWXB2DOabqAMs/o6XdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Qc+hNxMWQhyIdZYIMPvfYpnZKa9I4gWfj66Nw3SwcE=;
 b=lBhx4VT2ihbxRTJEwO/IPGTY2sqGpIDTj2sF/FxxQYHbWuh46HMfr1XXSibFvd0JyD74X5nWeCOh/iOy7e+VnTg5olgKeMQRDZrWsWWjfj1nNxv9MtSgYcpzzkIlGDnh2q5tRKFVeSub+qF/cDstq7gEb0BdN5qYQFSeg9fWctY7k2FpYJL8REHTcyNrE5R10TNjDXnTTNeltFj3C5P0o1RNnPgH07IU4fV6E1lQH7+KKkh9FXAf6Mbx4r6TyWNy/S75hQBje5Qb435zQX901EoGrrqYUybB9t4WKXW2KEWA20t3D7tz0GJm/xA3zixGzJrReLBuhjEFiYGDfjPKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1da::9)
 by DBAPR10MB3995.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 07:09:57 +0000
Received: from PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f961:56a2:265e:ca20]) by PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f961:56a2:265e:ca20%9]) with mapi id 15.20.5525.010; Wed, 17 Aug 2022
 07:09:57 +0000
From:   Loic PALLARDY <loic.pallardy@st.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Loic PALLARDY - foss <loic.pallardy@foss.st.com>
Subject: RE: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Topic: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Index: AQHYkevVQuji0mJdiUaO5T+/y7MyeK2wZr+AgAF+bwA=
Date:   Wed, 17 Aug 2022 07:09:57 +0000
Message-ID: <PAXPR10MB48428C9241301E4ACFA9DF8E8A6A9@PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
 <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
In-Reply-To: <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Enabled=true;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SetDate=2022-08-17T07:09:56Z;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Method=Standard;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_Name=23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ActionId=508a97b3-6d87-4b45-972d-d14ca9e65115;
 MSIP_Label_23add6c0-cfdb-4bb9-b90f-bf23b83aa6c0_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e667317-bdea-459f-5800-08da801f7e5a
x-ms-traffictypediagnostic: DBAPR10MB3995:EE_
x-ld-processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6moAC93jritr9hgNftPfRhL0Vxu4QMqJYujA/++HtrHq/SeyFrbIpWWFO+L6IYL4D0fQwbSUWn7N8mntixbLjoiT0xLmFUdPPqjeeuvslks11N14XwG0pbz0SDxpmY3wJk6wO6IQ8ixXIz+Ddx77eh6GD/eRQLRUazMVTHGIQzvm81O7QjTcunpCaV5kp9PR1Leg4X7Ryf6fyL6y8IAGyZaJI/QgL3lbMoYzS4B00uSNTP8Cc7x2BS8mAunp5ZsJl5t2JFR6gVV/sDZNafwdt4XRk+yV2V2n2LXlhJab7WoYxlNVUiZljSJcm01cf7N1+SGMFtGtj4PDAdJTlADbnPrdgSzjUNQVv1F3wd4RxZsNzT8gGiSQiDZzH7JUTWnQTabLLYoZxMyKt712AEaiTl+hN1JNqiGGo3FJIz/zs/UT2EAm6amqpgV8Sbrec97lYmU0V3IznYBFW8gcp1Y1+nG68JS5FYd400q1zsTuUvE1ok/JcogOovkhIGbCf+6FwvCLccJSPC6eowKNK0snCstBxxwSdQWu/SSMtZwAHGOQlaln/oyiu0ZY9nYD8zFyzuCFbwtzllHdpbEqoMnE+kvzBDQYOtIozqo4S07Qnc13SJnyYpjjVSo/p4kSFJz55R2Fwhpu7HXIC84+FJKWVwhC3K/Njl0A3gtA4lBty2hPkAUREqHy0t1faob7PTkxb5AMI9bLvK/1kx6yNbFDxKCjaJgh6XKHggnPueY+r5yDzv6bi3+rTdOl5qm0+xuISyy4wVpsV1H6w5mabUCcBGw7uDe3bDLPqp6Zt6wpzakWYc1ovHzYxgI/lT/bj78gzzyMEhVMVVnyUnD8SGogeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(7416002)(7696005)(33656002)(52536014)(2906002)(8936002)(5660300002)(86362001)(55016003)(26005)(66476007)(71200400001)(55236004)(41300700001)(186003)(38070700005)(9686003)(6506007)(122000001)(478600001)(83380400001)(53546011)(966005)(38100700002)(64756008)(316002)(8676002)(66556008)(4326008)(54906003)(76116006)(110136005)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1liY0dQUFpnMFBTdHVibTZQbHNPVGhqUzlWNlhWZmdFcFRuMW5DcUc2OVRD?=
 =?utf-8?B?N2xJdTlUb1dacGlaaXZHc3ZCRnZ1OW9KVms2ODByR1RBQmJCYmUxczJTQXcy?=
 =?utf-8?B?c20wd1ExUjlVOEdmZW1TenRWb2tCSUlDQzBXVGppZE85ZVhUWkltTFVDVGVt?=
 =?utf-8?B?dFp2TUxUQ05FYmV6L2hwVHhDR0J4SXAwNUljdGdWUFRac0kwQ0ZLWmwrUE8v?=
 =?utf-8?B?aDR2UU5BWlR0TFZDK1JpNmt1bnFaTUNRWXRVUzFUV1pqaEpGak5KVGdQc1Bw?=
 =?utf-8?B?TU5tQXM4T2g3ZjFzdzhtTzRpZ09VNUo2dGNaOTE0U0hUeG9QRzFQUlFhb3Nu?=
 =?utf-8?B?NkNQV1JPVkZvVDhkWDVVNlByek9RTDl4TWd1MWM2VkhqOVgwL1FYYjIvdVVW?=
 =?utf-8?B?Z0dOUHIwcjZsTWVDZGNCMkRDb000NFUvWStmVDJjZCtWYjhrdElsdW1sVnN6?=
 =?utf-8?B?bTExbktmTHhQZVdrSDVWK1FUZ1ZxVFlERjRKOGN2QUQrQWJNRENtNzJUNGFI?=
 =?utf-8?B?b2E2KzI4RUh6M2NNZ3V1bmxIR0dUeXgrM1VzUEx3bVpmcDhiWTJPVUtHTG54?=
 =?utf-8?B?cUdjZ1pRRWRlZXRwb0F4UnZiU2YrdlcvcWk3S3RoTjZmRGNOMWwzT2s0Zkda?=
 =?utf-8?B?SGswek1TbzVDRk9jeEZTalRFY0JFZWg3ZGQrdVBPWGZUdG5tSmVoL1NZUlFW?=
 =?utf-8?B?ZmtMZFEvWnRBS1pmNjNwaUx6VTVsMHBvalBsTmNONFkvRlU5Y05POEVqc1pM?=
 =?utf-8?B?R2t0Y2hTdVNOYkF1Z3I1dDNwclhOTi9uN2lvNEwrVjVZRDluM1lZeXJENHBZ?=
 =?utf-8?B?MW5XaXI3QnkvWDkvWG0yZHIyclFkSFgxNUZiY2xFSW5rZUNac1laWVFCMGZE?=
 =?utf-8?B?Z0JQUmhNWGNCVDRmMldyQ3hwRUNvZjllTnVXaFB5Y0d4ZkpveEt2bzgvTnhC?=
 =?utf-8?B?cEkvVDFsKzFVRTNaaFJUTjRoTmd6UnZCeHgzMnJveVM0S0doUFpSOFZwaXV3?=
 =?utf-8?B?Zm1kUDB2c3VPK3kwQXJ4VDlzaG1LNHBHV3ljTVRCNVExRmlyWnY2L01rRnN0?=
 =?utf-8?B?NUxEQkVJTnp3TUVPREcrZUxIajU3NGExUkF4TGhXRllFT1dJRTB4K00wSVNS?=
 =?utf-8?B?dzE1RmljWmFnMDA1SmFEOWVDUFpLTjhiQTJXaGlFVlRWRHZCWGlNbnU1N3Jr?=
 =?utf-8?B?cHlGYTNCMTY3UG55emI3YkpBK2FXTm00THlYUHdUTjF3VXBCZmwvYUU1UUdv?=
 =?utf-8?B?MlVZOXl4OTUzVXZUTnlYM2ZNTXpQRC9YaHdpT3lQOEorb29PUGJoc0ltTjJm?=
 =?utf-8?B?RVp3LzhiL0g4KytYWjJQYUVVT3lYYVhtbDB6RkpmSXluNHpDdG9HcnU1Vjl1?=
 =?utf-8?B?MmRETC9pbmlNbHlnL2VicXB3OENSYUdUS1loQTlicTdSeXpkRUFPUWIxYkRp?=
 =?utf-8?B?SlhuZGVta29WLzRibENBbmVxVlVrbjJmdXRLN21lc09oL1JDT2NjaHVMN1F0?=
 =?utf-8?B?cFp0QzR1aUFMcC81SVFIM1djQkF3UzVoYXNVWHh4RTFyaG15aGsxRDJoTWxx?=
 =?utf-8?B?akowLzZUWlVSUWhvcUsxcHZPM1RNbC9BZzc2ckdKSFFwajA4QWVWeXZyMlk2?=
 =?utf-8?B?Ui9VNVl2UWNUS3JKZmVmWkdIUmpReFFWZVNHZUZ1d1RWY2svc1JCZFFlTzkv?=
 =?utf-8?B?ZDZLNitIa2MzSTgybm5XRzFMMmlBZjJQZGM2VGdORHR1MWNKSzc1a2xhT3J2?=
 =?utf-8?B?djlXS1htSGoyRlMzVUNuN2VleVVCZ2tpZGIxU0UyWlowQVJKVzN6cldWaFB1?=
 =?utf-8?B?Y1hDdEIxTUdxVGlWZy90RnlTd3hFaW8wTDVvR09JOU1kN0l0OHcxVkZjQVps?=
 =?utf-8?B?N3daU0I5VVYyS292TFdhazR4UVdKbzhXN0xPcmw3alYzQzRMM3ZvV3NDeEo2?=
 =?utf-8?B?ZjQxbEp6M3htOGxXVEZMajJXZnVqaGQ0UzZOTTlKNEtVU2JUY1ZmamhqSW12?=
 =?utf-8?B?MldiNUthYkdhbzBUWkU3TlhDcGx6YVluV0VFL0xXMWNoZUQxMzdXVWVtTCtM?=
 =?utf-8?B?WlVYeUlUZFhMT01XRUNoLzVuUGlycWxmRlZaa2Yvanh5ZWhOWjFETXU1eTAz?=
 =?utf-8?Q?R9lxZvEugQpp9gigDzB4Yp5AV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e667317-bdea-459f-5800-08da801f7e5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 07:09:57.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUZvXErTLNFwjulAbe5zC4M5ckhCo6ZaKf0iFb/22GJOmW272h9EiUFz3O4OWNiQ6OgaA7l00RFvGYJqJ2+iqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB3995
X-Proofpoint-GUID: 9QRQFTpEGVfseNWlmHEe7fYsB-Ssbgtj
X-Proofpoint-ORIG-GUID: 9QRQFTpEGVfseNWlmHEe7fYsB-Ssbgtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_04,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCg0KU1QgUmVzdHJpY3RlZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEFobWFkIEZhdG91bSA8YS5mYXRvdW1AcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6
IE1vbmRheSwgQXVndXN0IDE1LCAyMDIyIDY6MzcgUE0NCj4gVG86IE9sZWtzaWkgTW9pc2llaWV2
IDxPbGVrc2lpX01vaXNpZWlldkBlcGFtLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZw0KPiBDYzog
bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbTsgQWxleGFuZHJlIFRPUkdVRQ0KPiA8YWxleGFuZHJl
LnRvcmd1ZUBzdC5jb20+OyBsaW51cy53YWxsZWlqQGxpbmFyby5vcmc7DQo+IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgdG9tYXNlQHhpbGlu
eC5jb207DQo+IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBjb2xsYWJvcmEu
Y29tPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBhcm5kQGFybmRiLmRlOyBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBmYWJpby5lc3RldmFtQG54cC5jb207IExvaWMNCj4gUEFMTEFSRFkgPGxvaWMucGFs
bGFyZHlAc3QuY29tPjsgbWFyay5ydXRsYW5kQGFybS5jb207IFN1ZGVlcCBIb2xsYQ0KPiA8c3Vk
ZWVwLmhvbGxhQGFybS5jb20+OyBDcmlzdGlhbiBNYXJ1c3NpIDxjcmlzdGlhbi5tYXJ1c3NpQGFy
bS5jb20+Ow0KPiBTdGVmYW5vIFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8
a2VybmVsQHBlbmd1dHJvbml4LmRlPjsgUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5u
eHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAvMl0gZHQtYmluZGluZ3M6IEludG9y
ZHVjZSBkb21haW4tY29udHJvbGxlcg0KPiANCj4gSGVsbG8gT2xla3NpaSwNCj4gDQo+IE9uIDA3
LjA3LjIyIDEyOjI1LCBPbGVrc2lpIE1vaXNpZWlldiB3cm90ZToNCj4gPiBJbnRyb2R1Y2luZyB0
aGUgZG9tYWluIGNvbnRyb2xsZXIgcHJvdmlkZXIvY29uc3VtZW5yIGJpbmRuZ3Mgd2hpY2ggYWxs
b3cNCj4gdG8NCj4gPiBkaXZpZGVkIHN5c3RlbSBvbiBjaGlwIGludG8gbXVsdGlwbGUgZG9tYWlu
cyB0aGF0IGNhbiBiZSB1c2VkIHRvIHNlbGVjdA0KPiA+IGJ5IHdobyBoYXJkd2FyZSBibG9ja3Mg
Y291bGQgYmUgYWNjZXNzZWQuDQo+ID4gQSBkb21haW4gY291bGQgYmUgYSBjbHVzdGVyIG9mIENQ
VXMsIGEgZ3JvdXAgb2YgaGFyZHdhcmUgYmxvY2tzIG9yIHRoZQ0KPiA+IHNldCBvZiBkZXZpY2Vz
LCBwYXNzZWQtdGhyb3VnaCB0byB0aGUgR3Vlc3QgaW4gdGhlIHZpcnR1YWxpemVkIHN5c3RlbXMu
DQo+ID4NCj4gPiBEZXZpY2UgY29udHJvbGxlcnMgYXJlIHR5cGljYWxseSB1c2VkIHRvIHNldCB0
aGUgcGVybWlzc2lvbnMgb2YgdGhlIGhhcmR3YXJlDQo+ID4gYmxvY2suIFRoZSBjb250ZW50cyBv
ZiB0aGUgZG9tYWluIGNvbmZpZ3VyYXRpb24gcHJvcGVydGllcyBhcmUgZGVmaW5lZCBieSB0aGUN
Cj4gPiBiaW5kaW5nIGZvciB0aGUgaW5kaXZpZHVhbCBkb21haW4gY29udHJvbGxlciBkZXZpY2Uu
DQo+ID4NCj4gPiBUaGUgZGV2aWNlIGNvbnRyb2xsZXIgY29uY2VwdGlvbiBpbiB0aGUgdmlydHVh
bGl6ZWQgc3lzdGVtcyBpcyB0byBzZXQNCj4gPiB0aGUgZGV2aWNlIGNvbmZpZ3VyYXRpb24gZm9y
IFNDTUkgKFN5c3RlbSBDb250cm9sIGFuZCBNYW5hZ2VtZW50DQo+ID4gSW50ZXJmYWNlKSB3aGlj
aCBjb250cm9scyBjbG9ja3MvcG93ZXItZG9tYWlucy9yZXNldHMgZXRjIGZyb20gdGhlDQo+ID4g
RmlybXdhcmUuIFRoaXMgY29uZmlndXJhdGlvIHNldHMgdGhlIGRldmljZV9pZCB0byBzZXQgdGhl
IGRldmljZSBwZXJtaXNzaW9ucw0KPiA+IGZvciB0aGUgRmltd2FyZSB1c2luZyBCQVNFX1NFVF9E
RVZJQ0VfUEVSTUlTU0lPTlMgbWVzc2FnZSAoc2VlDQo+IDQuMi4yLjEwIG9mIFswXSkuDQo+ID4g
VGhlcmUgaXMgbm8gQkFTRV9HRVRfREVWSUNFX1BFUk1JU1NJT05TIGNhbGwgaW4gU0NNSSBhbmQg
dGhlIHdheSB0bw0KPiA+IGRldGVybWluZSBkZXZpY2VfaWQgaXMgbm90IGNvdmVyZWQgYnkgdGhl
IHNwZWNpZmljYXRpb24uDQo+ID4gRGV2aWNlIHBlcm1pc3Npb25zIG1hbmFnZW1lbnQgZGVzY3Jp
YmVkIGluIERFTiAwMDU2LCBTZWN0aW9uIDQuMi4yLjEwIFswXS4NCj4gPiBHaXZlbiBwYXJhbWV0
ZXIgc2hvdWxkIHNldCB0aGUgZGV2aWNlX2lkLCBuZWVkZWQgdG8gc2V0IGRldmljZQ0KPiA+IHBl
cm1pc3Npb25zIGluIHRoZSBGaXJtd2FyZS4NCj4gPiBUaGlzIHByb3BlcnR5IGlzIHVzZWQgYnkg
dHJ1c3RlZCBBZ2VudCAod2hpY2ggaXMgaHlwZXJ2aXNvciBpbiBvdXIgY2FzZSkNCj4gPiB0byBz
ZXQgcGVybWlzc2lvbnMgZm9yIHRoZSBkZXZpY2VzLCBwYXNzZWQtdGhyb3VnaCB0byB0aGUgbm9u
LXRydXN0ZWQNCj4gPiBBZ2VudHMuIFRydXN0ZWQgQWdlbnQgd2lsbCB1c2UgZGV2aWNlLXBlcm1z
IHRvIHNldCB0aGUgRGV2aWNlDQo+ID4gcGVybWlzc2lvbnMgZm9yIHRoZSBGaXJtd2FyZSAoU2Vl
IFNlY3Rpb24gNC4yLjIuMTAgWzBdIGZvciBkZXRhaWxzKS4NCj4gPiBBZ2VudHMgY29uY2VwdCBp
cyBkZXNjcmliZWQgaW4gU2VjdGlvbiA0LjIuMSBbMF0uDQo+ID4NCj4gPiBEb21haW5zIGluIERl
dmljZS10cmVlIG5vZGUgZXhhbXBsZToNCj4gPiB1c2JAZTY1OTAwMDANCj4gPiB7DQo+ID4gICAg
IGRvbWFpbi0wID0gPCZzY21pIDE5PjsgLy9TZXQgZG9tYWluIGlkIDE5IHRvIHVzYiBub2RlDQo+
ID4gICAgIGNsb2NrcyA9IDwmc2NtaV9jbG9jayAzPiwgPCZzY21pX2Nsb2NrIDI+Ow0KPiA+ICAg
ICByZXNldHMgPSA8JnNjbWlfcmVzZXQgMTA+LCA8JnNjbWlfcmVzZXQgOT47DQo+ID4gICAgIHBv
d2VyLWRvbWFpbnMgPSA8JnNjbWlfcG93ZXIgMD47DQo+ID4gfTsNCj4gPg0KPiA+ICZzY21pIHsN
Cj4gPiAgICAgI2RvbWFpbi1jZWxscyA9IDwxPjsNCj4gPiB9DQo+ID4NCj4gPiBBbGwgbWVudGlv
bmVkIGJpbmRpbmdzIGFyZSBnb2luZyB0byBiZSBwcm9jZXNzZWQgYnkgWEVOIFNDTUkgbWVkaWF0
b3INCj4gPiBmZWF0dXJlLCB3aGljaCBpcyByZXNwb25zaWJsZSB0byByZWRpcmVjdCBTQ01JIGNh
bGxzIGZyb20gZ3Vlc3RzIHRvIHRoZQ0KPiA+IGZpcm13YXJlLCBhbmQgbm90IGdvaW5nIGJlIHBh
c3NlZCB0byB0aGUgZ3Vlc3RzLg0KPiA+DQo+ID4gRG9tYWluLWNvbnRyb2xsZXIgcHJvdmlkZXIv
Y29uc3VtZW5yIGNvbmNlcHQgd2FzIHRha2VuIGZyb20gdGhlIGJ1cw0KPiA+IGNvbnRyb2xsZXIg
ZnJhbWV3b3JrIHBhdGNoIHNlcmllcywgcHJvdmlkZWQgaW4gdGhlIGZvbGxvd2luZyB0aHJlYWQ6
DQo+ID4gWzFdLg0KPiANCj4gSSBhbHNvIHdhcyBpbnNwaXJlZCBieSBCZW5qYW1pbidzIHNlcmll
cyB0byBkcmFmdCB1cCBhIGJpbmRpbmcsIGJ1dCBmb3IgYSBzbGlnaHRseQ0KPiBkaWZmZXJlbnQg
cHJvYmxlbTogU29tZSBTb0NzIGxpa2UgdGhlIGkuTVg4TVAgaGF2ZSBhIGdyZWF0IGRlYWwgb2Yg
dmFyaWF0aW9uDQo+IGluIHdoaWNoIElQcyBhcmUgYWN0dWFsbHkgYXZhaWxhYmxlLiBBZnRlciBm
YWN0b3J5IHRlc3RpbmcsIGZ1c2VzIGFyZSBidXJudA0KPiB0byBkZXNjcmliZSB3aGljaCBJUHMg
YXJlIGF2YWlsYWJsZSBhbmQgYXMgdGhlIHVwc3RyZWFtIERUIG9ubHkgZGVzY3JpYmVzDQo+IHRo
ZSBmdWxsIGZlYXR1cmVkIFNvQ3MsIGVpdGhlciBib2FyZCBEVCBvciBib290bG9hZGVyIGlzIGV4
cGVjdGVkIHRvIHR1cm4NCj4gb2ZmIHRoZSBkZXZpY2UgdGhhdCBhcmUgdW5hdmFpbGFibGUuDQo+
IA0KPiBXaGF0IEkgY2FtZSB1cCB3aXRoIGFzIGEgYmluZGluZyBmb3IgdGhlIGJvb3Rsb2FkZXIg
dG8gZ3VpZGUgaXRzIGZpeHVwDQo+IGxvb2tzIHZlcnkgc2ltaWxhciB0byB3aGF0IHlvdSBoYXZl
Og0KPiANCj4gZmVhdDogJm9jb3RwIHsgLyogVGhpcyBpcyB0aGUgZWZ1c2UgKE9uLUNoaXAgT1RQ
KSBkZXZpY2UgKi8NCj4gICAgIGZlYXR1cmUtY29udHJvbGxlcjsNCj4gICAgIGZlYXR1cmUtY2Vs
bHMgPSA8MT47DQo+IH07DQo+IA0KPiAmdnB1X2cxIHsNCj4gICAgIGZlYXR1cmVzLWdhdGVzID0g
PCZmZWF0IElNWDhNUF9WUFU+Ow0KPiB9Ow0KPiANCj4gVGhlIE9DT1RQIGRyaXZlciB3b3VsZCBz
ZWUgdGhhdCBpdCBoYXMgYSBmZWF0dXJlLWNvbnRyb2xsZXIgcHJvcGVydHkgYW5kDQo+IHJlZ2lz
dGVyDQo+IGEgY2FsbGJhY2sgd2l0aCBhIGZlYXR1cmUgY29udHJvbGxlciBmcmFtZXdvcmsgdGhh
dCBjaGVja3Mgd2hldGhlciBhIGRldmljZQ0KPiBpcyBhdmFpbGFibGUuIGJhcmVib3gsIHRoYXQg
SSBpbXBsZW1lbnRlZCB0aGlzIGJpbmRpbmcgZm9yLCB3b3VsZCB3YWxrDQo+IHRoZSBrZXJuZWwg
ZGV2aWNlIHRyZWUgb24gYm9vdCBsb29raW5nIGZvciB0aGUgZmVhdHVyZS1nYXRlcyBwcm9wZXJ0
eSBhbmQgdGhlbg0KPiBkaXNhYmxlL2RlbGV0ZSBub2RlcyBhcyBpbmRpY2F0ZWQgd2l0aG91dCBo
YXZpbmcgdG8gd3JpdGUgYW55IFNvQyBzcGVjaWZpYyBjb2RlDQo+IGFuZCBlc3BlY2lhbGx5IHdp
dGhvdXQgaGFyZGNvZGluZyBub2RlIG5hbWVzIGFuZCBoaWVyYXJjaGllcywgd2hpY2ggaXMgcXVp
dGUNCj4gYnJpdHRsZS4NCj4gDQo+IFRoZXJlIHdhcyBhIHByZXZpb3VzIGF0dGVtcHQgYXQgZGVm
aW5pbmcgYSBiaW5kaW5nIGZvciB0aGlzLCBidXQgUm9iJ3MgTkFLDQo+IG1lbnRpb25lZCB0aGF0
IGEgc29sdXRpb24gc2hvdWxkIGNvdmVyIGJvdGggY2FzZXM6DQo+IA0KPiAgaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjIwMzI0MDQyMDI0LjI2ODEzLTEtcGVuZy5mYW5Ab3NzLm54cC5j
b20vDQo+IA0KPiBIYXZpbmcgaW1wbGVtZW50ZWQgbmVhcmx5IHRoZSBzYW1lIGJpbmRpbmcgYXMg
d2hhdCB5b3UgZGVzY3JpYmUsIEkgb2J2aW91c2x5DQo+IGxpa2UgeW91cg0KPiBwYXRjaC4gT25s
eSB0aGluZyBJIHRoaW5rIHRoYXQgc2hvdWxkIGJlIGNoYW5nZWQgaXMgdGhlIG5hbWluZy4gQSBk
b21haW4gZG9lc24ndA0KPiByZWFsbHkgZGVzY3JpYmUgdGhpcyBnYXRlZC1ieS1mdXNlcyBzY2Vu
YXJpbyBJIGhhdmUuIENhbGxpbmcgaXQgZmVhdHVyZS1nYXRlcw0KPiBpbnN0ZWFkIE9UT0ggbWFr
ZXMgc2Vuc2UgZm9yIGJvdGggeW91ciBhbmQgbXkgdXNlIGNhc2UuIFNhbWUgZ29lcyBmb3IgdGhl
DQo+IGRvY3VtZW50YXRpb24NCj4gdGhhdCBjb3VsZCBiZSB3b3JkZWQgbW9yZSBnZW5lcmljYWxs
eS4gSSBhbSBvcGVuIHRvIG90aGVyIHN1Z2dlc3Rpb25zIG9mDQo+IGNvdXJzZS4gOi0pDQoNCklz
c3VlIGxvb2tzIHRoZSBzYW1lIGFzIHRoZSBpbml0aWFsIG9uZSwgaG93IHRvIGd1YXJhbnRlZSBM
aW51eCBrZXJuZWwgd29uJ3QgdHJ5IHRvIGFjY2VzcyB0bw0KcmVzb3VyY2VzIHByb3RlY3RlZCBi
eSBmaXJld2FsbCBvciBPVFAuDQoNCkluaXRpYWwgcHJvcG9zYWwgZnJvbSBCZW5qYW1pbiB3YXMg
TkFLIGZvciBkaWZmZXJlbnQgcmVhc29ucyBhbmQgRFQgYmluZGluZ3Mgd2VyZSBhbHNvDQpkaXNj
dXNzZWQgZHVyaW5nIHN5c3RlbSBEVCBjYWxscyB3aXRob3V0IGFueSBhZ3JlZW1lbnQgYXQgdGhl
IGVuZC4NClRvZGF5IHdlIGhhdmUgZGVjaWRlZCB0byBpbXBsZW1lbnQgYSBwbGF0Zm9ybSBidXMg
dG8gY2hlY2sgYWNjZXNzIGxpa2UgcHJvcG9zZWQgYnkgR3JlZyBbMV0uDQpJbmRlZWQsIGEgbmV3
IGZyYW1ld29yayB3YXMgcmVqZWN0ZWQgYXQgdGhlIHRpbWUgYmVpbmcuDQpUaGUgbWFpbiBkaWZm
ZXJlbmNlIGNvbXBhcmVkIHRvIFsyXSBpcyB0aGF0IGJ1cyBpZGVudGlmaWVzIHBlcmlwaGVyYWwg
dGhhbmtzIHRvIGl0cyBiYXNlIGFkZHJlc3MgInJlZyIgYW5kIA0KdGhlbiB2ZXJpZmllcyBhc3Nv
Y2lhdGVkIGFjY2VzcyBwcm9wZXJ0aWVzIGJlZm9yZSBwcm9iaW5nIG9yIG5vdCBkZXZpY2UuDQpJ
dCB3YXMgYSBwcm9wb3NhbCBmcm9tIFJvYiB3ZSBkaXNjdXNzZWQgZHVyaW5nIGEgc3lzdGVtIERU
IGNhbGwgdG8gYXZvaWQgYW4gYWRkaXRpb25hbCBiaW5kaW5nLg0KDQpXZSBhcmUgbGF0ZSB0byBz
ZW5kIGFuIHVwZGF0ZSBiZWNhdXNlIHdlIGFyZSBhbHNvIHdvcmtpbmcgb24gT1AtVEVFIGFuZCBV
LUJvb3QgdG8gdmVyaWZ5DQp0aGUgYXBwcm9hY2ggYW5kIGJlIHN1cmUgd2UgY2FuIGNvdmVyIG91
ciBzcGVjaWZpYyBTb0MgY2FzZXMgd2l0aCB0aGlzIHNvbHV0aW9uLg0KDQpSZWdhcmRzLA0KTG9p
Yw0KDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUt
YmluZGluZ3MvY292ZXIvMjAyMDAxMjgxNTM4MDYuNzc4MC0xLWJlbmphbWluLmdhaWduYXJkQHN0
LmNvbS8NClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMDA3MDExMzI1MjMuMzI1
MzMtMS1iZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20vDQoNCj4gDQo+IEFsc28gYSBnZW5lcmFsIGdw
aW8tY29udHJvbGxlciBsaWtlIHByb3BlcnR5IHdvdWxkIGJlIG5pY2UuIEl0IHdvdWxkIGFsbG93
IGRyaXZlcnMNCj4gdG8gZWFzaWx5IGNoZWNrIHdoZXRoZXIgdGhleSBhcmUgc3VwcG9zZWQgdG8g
cmVnaXN0ZXIgYSBkb21haW4vZmVhdHVyZQ0KPiBjb250cm9sbGVyLg0KPiBGb3IgZGV2aWNlcyBs
aWtlIHlvdXJzIHdoZXJlIGEgZGVkaWNhdGVkIGRldmljZSBub2RlIHJlcHJlc2VudHMgdGhlIGRv
bWFpbg0KPiBjb250cm9sbGVyLA0KPiBpdCdzIHJlZHVuZGFudCwgYnV0IGZvciBhIGZ1c2UgYmFu
aywgaXQncyB1c2VmdWwuICNmZWF0dXJlLWNlbGxzIGNvdWxkIGJlIHVzZWQgZm9yDQo+IHRoYXQs
IGJ1dCBJIHRoaW5rIGEgZGVkaWNhdGVkIHByb3BlcnR5IG1heSBiZSBiZXR0ZXIuDQo+IA0KPiBM
ZXQgbWUga25vdyB3aGF0IHlvdSB0aGluayBhbmQgdGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMh
DQo+IA0KPiBDaGVlcnMsDQo+IEFobWFkDQo+IA0KPiANCj4gPg0KPiA+IEkgdGhpbmsgd2UgY2Fu
IGNvb3BlcmF0ZSB3aXRoIHRoZSBidXMgY29udHJvbGxlciBmcmFtZXdvcmsgZGV2ZWxvcGVycw0K
PiA+IGFuZCBwcm9kdWNlIHRoZSBjb21tb24gYmluZGluZywgd2hpY2ggd2lsbCBmaXQgdGhlIHJl
cXVpcmVtZW50cyBvZiBib3RoDQo+ID4gZmVhdHVyZXMNCj4gPg0KPiA+IEFsc28sIEkgdGhpbmsg
dGhhdCBiaW5kaW5nIGNhbiBhbHNvIGJlIHVzZWQgZm9yIFNUTTMyIEVUWlBDIGJ1cw0KPiA+IGNv
bnRyb2xsZXIgZmVhdHVyZSwgcHJvcG9zZWQgaW4gdGhlIGZvbGxvd2luZyB0aHJlYWQ6IFsyXS4N
Cj4gPg0KPiA+IExvb2tpbmcgZm9yd2FyZCBmb3IgeW91ciB0aG91Z2h0cyBhbmQgaWRlYXMuDQo+
ID4NCj4gPiBbMF0gaHR0cHM6Ly9kZXZlbG9wZXIuYXJtLmNvbS9kb2N1bWVudGF0aW9uL2RlbjAw
NTYvbGF0ZXN0DQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDE5MDMxODEw
MDYwNS4yOTEyMC0xLQ0KPiBiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20vDQo+ID4gWzJdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIwMDcwMTEzMjUyMy4zMjUzMy0xLQ0KPiBiZW5qYW1p
bi5nYWlnbmFyZEBzdC5jb20vDQo+ID4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHYxIC0+IFYyOg0K
PiA+ICAgIC0gdXBkYXRlIHBhcmFtZXRlciBuYW1lLCBtYWRlIGl0IHhlbi1zcGVjaWZpYw0KPiA+
ICAgIC0gYWRkIHhlbiB2ZW5kb3IgYmluZGluZ3MNCj4gPg0KPiA+IENoYW5nZXMgVjIgLT4gVjM6
DQo+ID4gICAgLSB1cGRhdGUgcGFyYW1ldGVyIG5hbWUsIG1ha2UgaXQgZ2VuZXJpYw0KPiA+ICAg
IC0gdXBkYXRlIHBhcmFtZXRlciBmb3JtYXQsIGFkZCBsaW5rIHRvIGNvbnRyb2xsZXINCj4gPiAg
ICAtIGRvIG5vdCBpbmNsdWRlIHhlbiB2ZW5kb3IgYmluZGluZ3MgYXMgYWxyZWFkeSB1cHN0cmVh
bWVkDQo+ID4NCj4gPiBDaGFuZ2VzIFYzIC0+IFY0Og0KPiA+ICAgIC0gaW50cm9kdWNlIGRvbWFp
biBjb250cm9sbGVyIHByb3ZpZGVyL2NvbnN1bWVyIGRldmljZSB0cmVlIGJpbmRpbmdzDQo+ID4g
ICAgLSBtYWtpbmcgc2NtaSBub2RlIHRvIGFjdCBhcyBkb21haW4gY29udHJvbGxlciBwcm92aWRl
ciB3aGVuIHRoZQ0KPiA+ICAgICAgZGV2aWNlIHBlcm1pc3Npb25zIHNob3VsZCBiZSBjb25maWd1
cmVkDQo+ID4gLS0tDQo+ID4NCj4gPiBPbGVrc2lpIE1vaXNpZWlldiAoMik6DQo+ID4gICBkdC1i
aW5kaW5nczogRG9jdW1lbnQgY29tbW9uIGRldmljZSBjb250cm9sbGVyIGJpbmRpbmdzDQo+ID4g
ICBkdC1iaW5kaW5nczogVXBkYXRlIHNjbWkgbm9kZSBkZXNjcmlwdGlvbg0KPiA+DQo+ID4gIC4u
Li9iaW5kaW5ncy9kb21haW5zL2RvbWFpbi1jb250cm9sbGVyLnlhbWwgICB8IDgwICsrKysrKysr
KysrKysrKysrKysNCj4gPiAgLi4uL2JpbmRpbmdzL2Zpcm13YXJlL2FybSxzY21pLnlhbWwgICAg
ICAgICAgIHwgMjUgKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTA1IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kb21haW5zL2RvbWFpbi0NCj4gY29udHJvbGxlci55YW1sDQo+ID4NCj4gDQo+IA0KPiAt
LQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiBTdGV1ZXJ3YWxkZXIgU3RyLiAyMSAgICAgICAgICAg
ICAgICAgICAgICAgfCBodHRwOi8vd3d3LnBlbmd1dHJvbml4LmRlLyAgfA0KPiAzMTEzNyBIaWxk
ZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3
LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAgfCBG
YXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTU1NTUgfA0K
