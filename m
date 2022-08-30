Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3D5A6270
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiH3Lug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiH3Lua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:50:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE79C52DF7;
        Tue, 30 Aug 2022 04:50:27 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UAaIw7025955;
        Tue, 30 Aug 2022 07:50:08 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g67aqw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 07:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brfIdGgepGDftV/Em6sgaXl4niiLGer8cqMEDO6/YQJVOi8aG+bylwSMsJYQkrfHAsWeOzNNbhHYWiRGsQqc96eFSn+J1xYzWm3FCmUNQyYMvlgu5sOzhL8iuGJBdcl76kbwRdpbAfhGGUWJXwVNDHXonbnYi8Yz9/6nr6Pphk9PvL0ydn4bMiuyJBocr15F94gcyKynIhc/4CaVMfhp3YDiq3/jeNMLCT5Jfrs3TEknztEbJsprFOlxf1Vst4Rv7S7P2Il4D4An0yCKMJjct7QiRS/SwJowXWDqYwO/8Z+hENADmMxPZS2iQdrPbhRmoaBiTUXjtQUSVzwuOs9TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az+c6kAm3vi9N7x82vJ+wBLVGlIGcAIr+lTZ6eAOi00=;
 b=Gs8u2JnWILsE6zB8eEgDf7no15uwU7JTmNKyh3+Cwwnaga+6AvIxR6s9A9ASqikFnmVET2w2bdvQIu0TWRQGIHBJodkMMGRYeOSs5Ph1VF75OgZ9hNLE/3QJ3QgSCIGODrxmfNioY9RP2zoUqdexkellVIGAaMnFQLx0w+d8y/nrc1Hr/12Ed7ZJSegfl9q2E9denfM5oWHrs4skgvgEQstbR/vi25nT+LzLHTbbtj/jJD2EEXVNoJJXwfx8PtVyuBQCO/OBgU9xNd05iW0I00jOYK8GM8nnTDrSsd1zQPjiqXFq13KQaXVBBL9Ho7QllxQVafB1O9pBtZSK1HvYNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az+c6kAm3vi9N7x82vJ+wBLVGlIGcAIr+lTZ6eAOi00=;
 b=R0SC1SvaUjXSER50NGFeOPxQsYzV5wVRIzrP4oCJesTN6Q2hEQs0K4y6zRYMFPkM+QiL0moEDbBsT2l4x2s1Q6SbmgIqV17+eMQY3ocfvVdYOinHsmZZESYXFoU3HQyCVSoVqq8c3jjzS7V8tN/SRN3LA8aqR+NuGfFu7VaBqvo=
Received: from SN4PR03MB6784.namprd03.prod.outlook.com (2603:10b6:806:217::17)
 by BN8PR03MB5139.namprd03.prod.outlook.com (2603:10b6:408:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 11:50:05 +0000
Received: from SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe]) by SN4PR03MB6784.namprd03.prod.outlook.com
 ([fe80::6c7f:65b9:118c:7cbe%3]) with mapi id 15.20.5566.016; Tue, 30 Aug 2022
 11:50:05 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 13/14] iio: max1363: simplify using
 devm_regulator_get_enable()
Thread-Topic: [PATCH v3 13/14] iio: max1363: simplify using
 devm_regulator_get_enable()
Thread-Index: AQHYtAEC7rW5f9osf0isaCacRnkXPa3HZR0Q
Date:   Tue, 30 Aug 2022 11:50:05 +0000
Message-ID: <SN4PR03MB6784244D8746B352AC7F411999799@SN4PR03MB6784.namprd03.prod.outlook.com>
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <1286ea127d190e5708a0aaff271819b2d3f8802d.1660934107.git.mazziesaccount@gmail.com>
In-Reply-To: <1286ea127d190e5708a0aaff271819b2d3f8802d.1660934107.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZTI2YTNmNmQtMjg1OS0xMWVkLThiZmItZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGUyNmEzZjZmLTI4NTktMTFlZC04YmZiLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTEyOSIgdD0iMTMzMDYzMzM4MD?=
 =?iso-8859-1?Q?Q0MzA4OTU5IiBoPSJvdGFFTFFNeWR1QjhnTE5IVklGeC8zNjBtVUE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURmUGNLa1pyellBVkR1WXRXUTJVYnZVTzVpMVpEWlJ1OERBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQUpyakpJUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4944dfe8-f871-4ea5-e089-08da8a7dc7cb
x-ms-traffictypediagnostic: BN8PR03MB5139:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tcvZL1N7IfyyEedHldp/AW7UrNg4nYpp4sZthzPVcA+6/FNUywEImS9OhrEILbnVevbBHuqWeJ9r4T0LaObwzibh0Qzg8f3GkypRgcE5cwD+sjKNdYXwd2FWoRcF6IhnhIZRr6ZWQ+/bmHqqUBRjTCcEcQ13+OdWztiTGlpsoOUwmouq8q1M4dFshisH4YLZzposGDBQ9rmvdfELkvLVv8XKex0WbaJ17T1w1EzcyZIDF9yg46TA4+0/URwmOqGJcltCiQnnGDrDx9C+SCIPXDX9ah82D7BH8qKAgIFlt8Q8z9b72wW4ABctD/+XmfVi878YesLW/5b8xQwvPe6ANOYIMoHBTt4m++B74wzy3cRxlcQ5AV85dKmmdPsGXcD2jKCB8H9EySAd1VkTjh37rIh/octCw4ITw2OPr+jch/Rd5A4EoVeNUA8QuWKArZ3LTA6Jgz7PpAiSH9EOVCAt/rf1WgH7ZcwEag6HlX786eFvPxkMd8DcE0+Ust4xOX2UdpSFzFlNdtX7Hf7y25eNioJPF85ECWt5PKNzJgl4HdcODCgiJmpBH3uRLPLen4FjmGyFqX0PocI0M1yV9jFcwUu94tscgORCmQMhQNaqRAkiIpeo9fkVQOzsQBL800v0Ujyv7P0vQCeWeNtRNoMTAyh9owPCTkDem2faTzNqYiYUKb97HX+Wm5UIDG45T87gzsfppDlGO0LB3ZGSjmK87PVfd5wUx0rFEMjzP34U8AhYtocEDpDgEBU3U+Ld1MARqNArEFSSLEQqHJ/KQHMqeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR03MB6784.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(7696005)(122000001)(53546011)(6506007)(2906002)(83380400001)(4744005)(55016003)(33656002)(186003)(9686003)(316002)(66946007)(54906003)(8676002)(86362001)(66476007)(66556008)(66446008)(64756008)(76116006)(4326008)(110136005)(38070700005)(71200400001)(41300700001)(52536014)(8936002)(5660300002)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ai6r0FYFje2eQIFcyoAwmERZabELQ133rzEnCfjXLXct0/hMwu72Gt7E0q?=
 =?iso-8859-1?Q?/wpm7ZWQPsWkTEgO6C4j6r9XGDfzLsp1tQr1ImY4uYbhrMDVUp72TyWjgd?=
 =?iso-8859-1?Q?JQz0IQQ60HMcPKwjlSCccB5LIMihYwqiaycMlu7wc1BX89bDVKYxGTsErx?=
 =?iso-8859-1?Q?RhpJFVINlcEh1eRjNKsnO87IlrAQ0NCOARfzMRMSSbmjgAUSpC8YuD6dZm?=
 =?iso-8859-1?Q?Oze6ifnMm+fapUpCtE2/9zWyWk72HM4ozy2/Nt37ukE3HWf20PVan0XmxF?=
 =?iso-8859-1?Q?XhTP2U2Xwm7dlmaGPkf+Dvuy3S+Y9uAJ+ZclkuSbB2D3Hf94je3Df3kQwg?=
 =?iso-8859-1?Q?u/zCtxQh4G+CT3J+rl5jNOn7wseiSfujw37wl5evBxIpNI/cDsL3MPPQaA?=
 =?iso-8859-1?Q?p8VUm6BkFJ9k36/RfuvzmIghvimAAnzjGmbrN01g6+BEJUG4IW4MnsQzkT?=
 =?iso-8859-1?Q?zOotb+NpCf/ibDDTic12YWCLfP+VBHH3UzwcebyRD/tZ+oKbUi0jPP5HvL?=
 =?iso-8859-1?Q?FNfmRCi91JTHJmc8+L+V+gbNf2sl0TpE4qcCtNrP7Eq2ndX+Z4vyumwNqT?=
 =?iso-8859-1?Q?NhnYp1EIVcgXxT66rIU9/sDzp2jCCu9845NYrr0g4L1/oh84qn8cm6d4UR?=
 =?iso-8859-1?Q?kNrrAnrp7AYWlrqAJIqEzeKHAcFrPoEyex13aqwr4DC8L+U70yT7oUzWq3?=
 =?iso-8859-1?Q?0c0ONMczlWs7X9Eh/+A3A9PGMg/e+78kUqR2ITWUvsImwHzQCfVsWXcP55?=
 =?iso-8859-1?Q?tsZd0BnLZ3lIG7mxhuW+gl5uzJJVt951mNKn62lTSaXfrtnzq+wuSvSAK4?=
 =?iso-8859-1?Q?ylpNRb6P6TY0TrJzA9DwKlUaXrKhA1NEiNS8yg0rDU15PdFBvZxN28WWf3?=
 =?iso-8859-1?Q?PtaUdDYDGscS2xPOsu1PJU+vXZR6ZA+KZkKb9e6mbWBg/xwYwfvYXsHlMf?=
 =?iso-8859-1?Q?gbMPHSSh6MStzwj+sXKTqCnxmCTYIf+jiOn0+BzQphuhVhe+YPc6qCdWfC?=
 =?iso-8859-1?Q?BE/zhdBLuz/G1lZiJftVeSNg0VkE/lHI8MvnuxG/907T+y7+8WY25bOZGK?=
 =?iso-8859-1?Q?S7+dkKSqNj0sdEypD+V/7QrlX5Gth4jEzkEnUTroYs4xGfjzHsjSvSMo3U?=
 =?iso-8859-1?Q?Q3FZzT6W1qtTKneutWyswGBCKJmhO1GyC5qZCEopZdc0pPMIZVbqULYDvt?=
 =?iso-8859-1?Q?QLdkjxc2f8k/H8FBwQGrDv0pbOJO9vi50qNrTFzwZrbkrsci15SOyCRioQ?=
 =?iso-8859-1?Q?J7vRReS9DIrQ55FQ8LsAIEESbR0O6IGChRwX2avXA5Gbzur5v0CJx4sp4S?=
 =?iso-8859-1?Q?l397Wvd49bfZ2da62X4JStrcqDy/56Z3890VCIIGifbX5I0WUmj7TH3GKb?=
 =?iso-8859-1?Q?Z80S7rHQQNJ9elo5qLG+0sFL4GGH1ljJ2BckTDZzuKn0faA0o5f0KbXCdN?=
 =?iso-8859-1?Q?+gfpFJukhI4cfwkGTxomUvx0ddiZP4/Nt78DKnBnDYkDdSSeBEELdiuY7P?=
 =?iso-8859-1?Q?2uyv/MId6vbxXPVIe1hIrkr2C+hHAA7MAT2Cit/SPQI8onyr1YpK8flgbU?=
 =?iso-8859-1?Q?bghHnYurIllKLwfm0AfaFneDYFr4COb7RwIELs7tCDACJdd8BzNvND1XPc?=
 =?iso-8859-1?Q?U9DnlSu5qWgSgdDV11aSlH+VeGgXUPp5K1kp1zME/WtLYVuj52SgbhSdqe?=
 =?iso-8859-1?Q?4+8PKbDAYBNM073nKKh+3EF2v6D646EluSpYSvV6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB6784.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4944dfe8-f871-4ea5-e089-08da8a7dc7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:50:05.3762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yMYH44pbjz5KXHPughmee+TvhcP9faHTNLCejcTz2VrFbSIw3RSpTNBqbW7vnAlnfA6o3eq7AxRJCx/n12mQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5139
X-Proofpoint-ORIG-GUID: VWbxewkV7pv9IOXbOZCgNZsGMKv_DSjk
X-Proofpoint-GUID: VWbxewkV7pv9IOXbOZCgNZsGMKv_DSjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_06,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=677 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300058
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> Sent: Friday, August 19, 2022 9:21 PM
> To: Matti Vaittinen <mazziesaccount@gmail.com>; Matti Vaittinen
> <matti.vaittinen@fi.rohmeurope.com>
> Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> <lars@metafoo.de>; Matti Vaittinen <mazziesaccount@gmail.com>;
> Alexandru Ardelean <aardelean@deviqon.com>; linux-
> iio@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH v3 13/14] iio: max1363: simplify using
> devm_regulator_get_enable()
>=20
> [External]
>=20
> Drop open-coded pattern: 'devm_regulator_get(), regulator_enable(),
> add_action_or_reset(regulator_disable)' and use the
> devm_regulator_get_enable() and drop the pointer to the regulator.
> This simplifies code and makes it less tempting to add manual control
> for the regulator which is also controlled by devm.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---

Acked-by: Nuno S=E1 <nuno.sa@analog.com>
