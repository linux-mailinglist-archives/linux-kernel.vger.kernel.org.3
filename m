Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3750A2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389549AbiDUOnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389537AbiDUOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:43:14 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222F41332
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:40:22 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23LBr1h2031618;
        Thu, 21 Apr 2022 10:39:56 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3fftq3pghw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 10:39:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4GxI0dlHOp0ey35fmGWEaTYJRfAjtjk6DRyxxrMq41HP9v66137i7NtRiCXwZDSH49o/iERgHM/fClOyfCovY6WJgXgFfKGWt2U9MQ3iCgJtecSM8VriNjUvnDNE7KalE6EqKCn92oXFNz82TMMxuXSro2YOqgVrGxhsgCGULiWSGTlpjFdjTazMMmgFN4Zq12cnkQ+vusHSobvSsizeVd0z80+a3wiZrMSyA3i18Ny7WK+goYUPFaTDxLZv+VfBkkHPuw0NdkGf68/mv8QBtc+3g4idKrmU+Ly01YcovsGmrBm7ZbHdalGmik6FyV+mAJbQ/ZpQ75CEuDaVCRm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeSOHy/7p5p6qVS4ItBNGgnpx6u1QBLEuhAOH9GAQes=;
 b=j/zl7VLoeLG9epjVTYCc3HQWWEqeA2iQQoWCsng7c3aNjgxT4AOVau2ElGq7Ww3Ys/5FuATCumCnQ0fio12DgUgrGXko8F7YqTUrsfD69mpgau9lI+1vOO7YAxQ/OgmJM1x3joRxMuJmLewI2YqrMS5X8f0ncQBpXFdDgX0ImTt0Axeqohp0Hl7trBc7IU9oKuaPhwApS080NgWhJassNk45IJafeGwukKC2OgWv+vdj1cLRb49GNA/oZnA33ua3J2k024XcTH1gx4U1uKPx3035K4RkGe/eRReYeWhu7NKhGgLz2yTejRqLiG2eMp2jZfuSmSQiIiVuLem2owrsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeSOHy/7p5p6qVS4ItBNGgnpx6u1QBLEuhAOH9GAQes=;
 b=XXFc2KQ3n3g2psrw8OKS+ahSjVUEy0iY3WM1AMlnzsDAHqqoZij5nk/36WaeFTGhy9h0Re71+S0imK8LzjLZkdtVq/BTwBbTmhS7X1lAosEV3UMmDFfeVtxUatyQ1Rkm77yU1xzQnEC1I/MqBe6piVNTjizjp/853TAzjYtU5Y0=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN8PR03MB5139.namprd03.prod.outlook.com (2603:10b6:408:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 14:39:53 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%9]) with mapi id 15.20.5186.013; Thu, 21 Apr 2022
 14:39:53 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Steve Lee <steve.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "krzk@kernel.org" <krzk@kernel.org>,
        "Lee, RyanS" <RyanS.Lee@analog.com>
Subject: RE: [V4 1/2] ASoC: max98390: Add reset gpio control
Thread-Topic: [V4 1/2] ASoC: max98390: Add reset gpio control
Thread-Index: AQHYVHIA5PedYalhXkCP+ziHPq/giaz6cgPQ
Date:   Thu, 21 Apr 2022 14:39:53 +0000
Message-ID: <PH0PR03MB678610A794CC939AD3AA117999F49@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220420044900.2989-1-steve.lee.analog@gmail.com>
In-Reply-To: <20220420044900.2989-1-steve.lee.analog@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZTU4YzJlM2YtYzE4MC0xMWVjLThiZTEtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGU1OGMyZTQxLWMxODAtMTFlYy04YmUxLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMTkxMSIgdD0iMTMyOTUwMjU1OT?=
 =?iso-8859-1?Q?AzMTE0NjMyIiBoPSJTSXd2d1U0RkNoNG9nQjl6STluN1AxdjVhREE9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUNJQmVlbmpWWFlBUlErS01zdjNudFhGRDRveXkvZWUxY0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
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
x-ms-office365-filtering-correlation-id: 0a73646b-72a9-4886-36c8-08da23a4cc4b
x-ms-traffictypediagnostic: BN8PR03MB5139:EE_
x-microsoft-antispam-prvs: <BN8PR03MB5139D337DA838E23EBBB888E99F49@BN8PR03MB5139.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nc8QGMPTA2FEJzsfhpX0Njsgq01wmSDm2WU8dkGY+Cq+i5FyASD3cmZ5dhDaZENF1Mj66LLHQPFztmlHH+EA5s8sHMUZfIqgsASF3bf9HbygruBGhM5aF4Zooc2ijsbvIpHWUVNL7sOufDRsiqezoll/SUHOxqh/7dk7sXlMciY51VQ1V2dxX3R0xSFzWigXOa6c4hA740Cx5uYb2qwyl2xOnKiko2eahfvTSn2JEmuP48RwvW/l2suzhdxBGsSJ6xuZe8/ev3Dx7G0cLJGEruIdO6s3AVCBcruaQbknuI4G0BDV5BAAp0hqX84f+bVvzmA26/2vmck3rWJn6a1xvpxC0bTbP2Ubw3ksVaLRkxdqkG8VLcA4PK0FmBzy6zddDgDbAPXPWJBOu0TrM2R27/18wPvSEtag0fdvMTOS2fJE4nSAhNAeSuZINvhwh31TNr36ARrFHWyr1rXeN8HP4uvmacjdEaMh4/0t8d8HO82yF1e5FQNzpBzRXx4229R4b7cVxDMNRdilADc4oTkHfecseR+aTDA9LJCU9FfdL5CJDTcqBUqVmu+1EVXPNUX7ObDpF80LlBcBrTxpZ5Ll/4QJSPfPO+/HbfDPoUFRTuFLS3EIctlEIMYz66NUM4bi9kzQOr2ZGhKoRyYLyEBEE5dthvIImoN7cXQP1RQxvRWEXBs/eS6gyw7xR7ZJ3GCs5kEi2/v/olX59Tl2hlcTuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(9686003)(53546011)(52536014)(316002)(64756008)(7696005)(66446008)(5660300002)(71200400001)(508600001)(8676002)(6506007)(8936002)(33656002)(2906002)(110136005)(38070700005)(38100700002)(4326008)(186003)(86362001)(122000001)(83380400001)(66476007)(66556008)(107886003)(76116006)(55016003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fRzohBXKZTjSUreAn/pWKsUZodbl1T1GkK/sOxzcu0fRsSIzG2TcvaZr1N?=
 =?iso-8859-1?Q?+wwf3E/Fq/KS+XFhNttXpmTQViyH7xBa1FVMycGYgJql6ZQEmGmx1Hl+9z?=
 =?iso-8859-1?Q?YMlyQrZqBPFTvsJPIA3AAKd6Y07tDGcTDsWp1koQ0Ey0Q+jhuf0QZAuyDn?=
 =?iso-8859-1?Q?ez/WU56PNq5zBJy1eXd4xITzo2uhrfevqCE/7C0Gfig3EX/OjjlcGcZciF?=
 =?iso-8859-1?Q?KwAobFnNwp2Ui+81qEMc/E5e7G3uKXgpKbtlanq/gEj+jTXvLCVN901wLj?=
 =?iso-8859-1?Q?6ZHQfZW22K+ZfJ4jyYfoETk2tTSG0vw9Rl4nalm9OSMuheqJFdXIijK872?=
 =?iso-8859-1?Q?kZbFsPhA2Li14o/AzKdsvrVmId/5gLSK6zv5t2hik+B3tJ00JufEf6AdY/?=
 =?iso-8859-1?Q?j9l9zbeW72tduy4h1/UB6/sLAr3jN2IDMOvwyjRsgbepyYr2M+91dYEDoa?=
 =?iso-8859-1?Q?4ETazTCALkJy8V0gvUNN5inajfXCDakZTqh8cHeavlP2/6OQuqDui4iBc3?=
 =?iso-8859-1?Q?b1RoekgI/meE/RjW18jhWEGJwjbyCKsSpe8JeVy78Px4EzaefVIt1tQC0o?=
 =?iso-8859-1?Q?aVc+YGRf5k2yXc6NDU4AkMBGefgobsNXdhg35uox2Ac1XXfhgmGOKOEyaN?=
 =?iso-8859-1?Q?ndTFq9uUpqxpfi1RoLG4YIUm9bXjl9gU2x+i1XdXF7j/249PsXKmsBbDLy?=
 =?iso-8859-1?Q?hJVXvcJJyQiKWaNTjGlT8xzI6nNxX39/IOgRFBVa5zD1TvD6QXXcUUwnSX?=
 =?iso-8859-1?Q?DUKuc4DLVU2HyCD9qPMi0phkvavwRTkebm1CfpU2afapKrr71/ita04U/M?=
 =?iso-8859-1?Q?v3//kM3cEmZfg0ZpLHsLu5EVdxq7daal+cmGKuzrFFiUzl6PLlM5BH+kW8?=
 =?iso-8859-1?Q?WUKLHEEWN6oseKsGFGpFwJywsTlOwjA8rbqlKb/zwYoJU7ENMra5sKrUee?=
 =?iso-8859-1?Q?3B3UcCK67Vrgr2jsiCxxyw54HA0BOSKrh629XC9NDJTJwI87BhbYdafy2x?=
 =?iso-8859-1?Q?ov0UV0K57FgFDjbZidyRzE+Jm3IJuFaYZx3jqmI/hURLo4KUXCEkt1shau?=
 =?iso-8859-1?Q?jAi/65OJ/usGpLqNMS0eS79WlfC+zhrnn6/i+sn3dW/OHCrG1o9yIuYauh?=
 =?iso-8859-1?Q?+qkYJ3uk/YIAa8qjD5Hy8DrWPW3giZs9KyffPJKccViLyxm8xF0jsAmZB8?=
 =?iso-8859-1?Q?DHUPdt9IDDdx7qSQI4SCbQx2RxPLudYegSY3UM/BdFVu5GF559X/G2uaz7?=
 =?iso-8859-1?Q?VoqZKypihcM7evPk7fPw7kNLOKQZiqbN+CWXiYRkzmwOptflz/f6gAsU92?=
 =?iso-8859-1?Q?S5rHF30xU1V9iw/s9vmb61ZbbB3Xie33KojgiQdClQ4n7cUCOQhA6hGOsj?=
 =?iso-8859-1?Q?JcJJZ6TK4+jNbOsqKUNGDRSWDNjOLnLAmaJx1MQC2Gn0WoIEZWClDYmd1G?=
 =?iso-8859-1?Q?mmjqtaAxiYzyvGmA16f8Jq7L7flPj6XK5oZBr7a0UveHNHZ9GgSK9j7BKU?=
 =?iso-8859-1?Q?iaicVaRa6fSnpSWl18HEXdslSn8A0xNejNHUGpErEQFxGgk9q0EaKik3Iw?=
 =?iso-8859-1?Q?myEUI5SYTAbqyesGl1m9HBJEmzgW7ofV14Gez22POUiO8JGucnuFPVJx3l?=
 =?iso-8859-1?Q?aM8xhPdbMJnIywwlPK6S7YqxQp5tDDiPqecdo0S2VrbxgXS4YsqfhpHDIi?=
 =?iso-8859-1?Q?YNXkaVXyCbJ1ONNQa89/1t7iKen/UpqpYsgIjzuvdbSJzRdwo1WHgA6l9o?=
 =?iso-8859-1?Q?ZCVp4naWqQG4um+t0z6FCAuKE793l8EtMzZNKaMnSKNgDd+mBMz5MqyhIH?=
 =?iso-8859-1?Q?B8j7POOwKhC0FzRBFomhaIK2Q/ZrRRaeqMSNOJ7q6VTmZMlV8cELdGX6GX?=
 =?iso-8859-1?Q?a0?=
x-ms-exchange-antispam-messagedata-1: vVo6qHbK1sdPgw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a73646b-72a9-4886-36c8-08da23a4cc4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 14:39:53.5280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYFaBfyvEqdD7bLOeTp/CqJcOQZyUMgzmYzVkIn7yoxu0vgI4IvSVQEP6dXHa5NdWEcat71aFfDdGUtWeaC3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB5139
X-Proofpoint-GUID: 4_0jq2GtbV-C-VZcwW5VJEovHPpDBJip
X-Proofpoint-ORIG-GUID: 4_0jq2GtbV-C-VZcwW5VJEovHPpDBJip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_01,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210079
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Steve Lee <steve.lee.analog@gmail.com>
> Sent: Wednesday, April 20, 2022 6:49 AM
> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; linux-kernel@vger.kernel.org; alsa-devel@alsa-
> project.org
> Cc: krzk@kernel.org; Sa, Nuno <Nuno.Sa@analog.com>; Lee, RyanS
> <RyanS.Lee@analog.com>; Steve Lee <steve.lee.analog@gmail.com>
> Subject: [V4 1/2] ASoC: max98390: Add reset gpio control
>=20
> [External]
>=20
>  Add reset gpio control to support RESET PIN connected to gpio.
>=20
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
> V3 -> V4: change reset gpio control as GPIO_ACTIVE_LOW in DT
>=20
>  sound/soc/codecs/max98390.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/sound/soc/codecs/max98390.c
> b/sound/soc/codecs/max98390.c
> index 40fd6f363f35..bdfd6cccc3d2 100644
> --- a/sound/soc/codecs/max98390.c
> +++ b/sound/soc/codecs/max98390.c
> @@ -1022,6 +1022,7 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>=20
>  	struct max98390_priv *max98390 =3D NULL;
>  	struct i2c_adapter *adapter =3D i2c->adapter;
> +	struct gpio_desc *reset_gpio;
>=20
>  	ret =3D i2c_check_functionality(adapter,
>  		I2C_FUNC_SMBUS_BYTE
> @@ -1073,6 +1074,17 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>  		return ret;
>  	}
>=20
> +	reset_gpio =3D devm_gpiod_get_optional(&i2c->dev,
> +					     "reset", GPIOD_OUT_HIGH);
> +
> +	/* Power on device */


I guess this comment is redundant as you already say
"bring out of reset" some lines below.

> +	if (reset_gpio) {
> +		usleep_range(1000, 2000);
> +		/* bring out of reset */
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +		usleep_range(1000, 2000);
> +	}
> +

Anyways,

Acked-by: Nuno S=E1 <nuno.sa@analog.com>

