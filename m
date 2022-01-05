Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8D4855F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbiAEPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 10:36:38 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45164 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241552AbiAEPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 10:36:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 205D5sYR021383;
        Wed, 5 Jan 2022 10:36:10 -0500
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ddbwu0crx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 10:36:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLV4W1N6eMra3rFUfPYT7fjk/5q2qAA1pKWFwlZCCiK0i/eDn07a22OCxp/Y3sEFGRC3QvFZkPl/csGazO3hVy0sIcs2bsVaOlvR/DCSfLH0Ly17NsDIg6DfogUQObw6xejNSHvPUma5Yc2axvF646kkN8wPQ2FJN5q4eHom/Yvqjo40pLn9KQYqhpQjzIJE6TvTCc6FQ6cteLYsCXjfYhdnHtSe/13JDusrZTSEah7vZZVeVzZEZV6kJ1Ii+/uoFSBJn7mE+Q5dhECUqsiZH6uRuL3S/6xE34g6dusIoC2uACxc9/nITpSk22+3ezXRgOukH7l+wFLb95Gvojn1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQuvhP51KKPKGKpYj8t7DwgCL07KxIXHj8GSlfpfT9g=;
 b=MMrVFjqRUvV9HPrqEVDC4GZXcF8emKTLgdURUYrB85sqQ9C17HNsmGuPQObmVfznIDkQGQ1KrWgGPaC9MCeiXAj7WLCGso/WbV7gdd1HtJyf9XPSZDgweUMFJVHwXZ4jKNLnvd9Z82pkvg2Bnr6AQfmAnHA/HJnPgDIYThcpbyReCFg2veL81HNIHcTyGIfD/cRshKnll7OJhUxrRZlqqm8c1ypNKIiqYX2EH7Jp4TUt5Q/AG/MTIvf2Vp9fFtlhSAfLbhBo3v8z5hliNrGIaB1taiFEwuKusZ2PC2RGaQxscnWeBbVusGBQ0cyxM6ME2SRN3lAWD//UASYU8qMGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQuvhP51KKPKGKpYj8t7DwgCL07KxIXHj8GSlfpfT9g=;
 b=1o4F16cHxBBofPtML77y0hUasKhapEi8XNUVjAzd1O9VCdMvUk585YBTqTCjQnqC2iuQP3PxaoYKFEOKYqyJLRrr93OqniGn9PWlJUzbjyCstxeGphyc2CfdjM2lLiuimFrJW1MFzMo8nqnyH2tM/3/0FNGRABbSzkheEqjD6VA=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by PH0PR03MB6606.namprd03.prod.outlook.com (2603:10b6:510:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 15:36:08 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::c5c3:7910:36e8:73a5%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 15:36:08 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Chindris, Mihail" <Mihail.Chindris@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] drivers:iio:dac make expression evaluation 64-bit
Thread-Topic: [PATCH] drivers:iio:dac make expression evaluation 64-bit
Thread-Index: AQHX9p/cLc4s/J6ln0K/DMRfDN267KxUhfMAgAAfOwA=
Date:   Wed, 5 Jan 2022 15:36:08 +0000
Message-ID: <PH0PR03MB67867EF2E5CE7CAA69F04B71994B9@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <YcIpAKV7Cmi0o7PU@debian-BULLSEYE-live-builder-AMD64>
 <20220105133902.GD7674@kadam>
In-Reply-To: <20220105133902.GD7674@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctMzE3Y2RkZjItNmUzZC0xMWVjLThiYWUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XDMxN2NkZGYzLTZlM2QtMTFlYy04YmFlLWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMjIzNiIgdD0iMTMyODU4NzA1Nj?=
 =?iso-8859-1?Q?U1NjY4NDEyIiBoPSJnSDVIWVVwL2RtZ3dxT25lYS9WV0R0dHI3UTg9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUM4bnV6elNRTFlBVnYwT2YxODZBakpXL1E1L1h6b0NNa0RBQUFB?=
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
x-ms-office365-filtering-correlation-id: f61ec95e-59bd-4533-3fcf-08d9d0611807
x-ms-traffictypediagnostic: PH0PR03MB6606:EE_
x-microsoft-antispam-prvs: <PH0PR03MB66068523B80897A7ACEE3B9A994B9@PH0PR03MB6606.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNT6oJL80Gg+k++zbCYz6eEw6ApqxXVZh44n4gOq1jHYT3waxWlfwcVeVQPFRAO743TGYFSbprtiHMjFD54mRswHYVTz86fl4ujbzZqixT4nKtwxjA3XI4G9P0mg2AVCgUn187QQoOjLGpmsOrFzmCJEr0uMQZXf4w6+o8ZPTFMca4raAzV+HdRONLbizZEtlT1IJQpyCn1wX2RUGR31+Vqr9A1fEd3qn2H1kmhuFprgVuZjJZlmO5LP/5+XE/m4T1tkfuBmL/sKQQiKtuXbxYhh5wa7yiFex2sUN0+vHKltfUSL1Wi2FWrHFzdLr1OPMnGZ4iriki2B9ZHzwjdJIJ15gwK1Wu2UVyE3VPNyDHNTG8dSYkVZDzqCd89M/z+eQd0ZfZfGV+jxn84iOGSjC3licMdFHMsD1phDljN3L4rPV1GrUTVUgDQOApkr3aeg6Aap7dptlS9vxxv3RVSrKF5CmgQTNICh3+izq4JFpwN5ByjRYtihjL5JzSLOhGSOyFVSe62KIqIvTEDc4DU36e/RjsFR6msqEnS3w0cOfD2R8iUv6sSEZM+avlfbE2HX+90CtLHQ85DuVkABUxLZhCd2qxXWxGxLIXsZbzpoH340ybEgdWruaGER5wGmATxKhw4VZX9bqIk52Rs7rSp87kDKPPCT2bEn0UGQYq1rTp5o/Nj4VHc7S28Raz5MbdnbwX/2m4QTnTvifB6f31MjGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(6506007)(66446008)(66476007)(86362001)(53546011)(66556008)(66946007)(7696005)(9686003)(71200400001)(8936002)(76116006)(110136005)(316002)(5660300002)(83380400001)(508600001)(55016003)(33656002)(38070700005)(54906003)(52536014)(186003)(38100700002)(4326008)(8676002)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UeALXzI8g310zRXmHBoC/gaJo9EUW+yv8JC+tx7SEKWI69Rn0aK1TAJ35Z?=
 =?iso-8859-1?Q?JkNc94cr13sWkN3rntvQ6DWOfRKT4/Sp5b22BIb3vOcrE+ZZlyUzKWowJo?=
 =?iso-8859-1?Q?7Uf1wx2PvENftrJkMzyV092ahfV7K0HHlsdAxGdHjsvwZBGNJTeTdhIzks?=
 =?iso-8859-1?Q?QBWdaJQapiWcq9jDxwkIUNc1JphGqJqJiI9rMEIMMXaCS2g5yF6a0eNse7?=
 =?iso-8859-1?Q?yAIBRvvF1VrdwsYHCMSCXzexzG+6f0FTqKoc7Vnia0jOaE2QdNCvfdJTvm?=
 =?iso-8859-1?Q?6oqlIMEH99bz2OXK8hfkWqh6hKTEYTpbs+KNnjkkYj5+jh4LdleFJY0RwZ?=
 =?iso-8859-1?Q?vgrZo0fUGuzJt6dRUoB16C6twqa1zCtXSHD0ozoraHXCNyL0hgSx7lpR3F?=
 =?iso-8859-1?Q?PGcvpb4ivZVyaOsMrmivHfV4jEsCLHxhfrjD0cjS97J6oP/qYSqIvtqGFS?=
 =?iso-8859-1?Q?KGfarJFsz4zh2nypaGyC2GahgAFxtXG0tlhsvK/Thi/YQoHO3TZoEh/nwT?=
 =?iso-8859-1?Q?jQFi1NdNKXw/W9Jh6KT19iuKcC1qf17T9TCTOfzqEyhfIozA/6AK7Tw/oh?=
 =?iso-8859-1?Q?XYEh8YZ8IthE9OvZxsY0oahM+9PXC6QOd6Txaxe/Atjzg2J6pe5hbVoqpw?=
 =?iso-8859-1?Q?JKlPRp3t+Ot1TtXoRh9mRwh28T0dfIDquA4T4jnMOSkMlsVITI1Fprt1R9?=
 =?iso-8859-1?Q?KpgtVp4aFkyX6wGUh8RPAPZLLobpWPZPMi7PEyObiep5CbJaiC/6eJ3xts?=
 =?iso-8859-1?Q?aQMMG74d8xokLEnOeOV1Qo2gI1U3AwOj7WRGF7YBItmRHWPBGrOSctyE8U?=
 =?iso-8859-1?Q?AHn5OnJ3UHJLSLD2VqLQmQf32BbDC9oIpCxhC2qo0leDJkEy9bBdU7Wwy+?=
 =?iso-8859-1?Q?OescyWMoi0GhTKCyxVgwQcppAMDQkjMwiIhS0rNXcr3wJb2GfDDN3bfp5R?=
 =?iso-8859-1?Q?Ti3JlrRaO0bZwjI/rXvfOK0PHN4muSIOjjT2MyUymEsSqxEm4SKIwy4jX9?=
 =?iso-8859-1?Q?633uv3qkVjau2EerZONUWXPkaDRHWgKwhoztzZoYhARpa1n2PJdEQLMTGZ?=
 =?iso-8859-1?Q?3e46lBiZ7vsJ1AphHKdp/SJb5L+xn6jYlbFF3fFN69TgdCBdfc+P9z7GTM?=
 =?iso-8859-1?Q?YNvxIaE54LunrdUsDfB1rXxcEL/oH4jCLkFTPGwhhCbdJbP04fr10n0k6l?=
 =?iso-8859-1?Q?/QtU+FFz2dkr+6+FclbZQ2b0PVXCzmuzvLKB8pS2/S8fiAaysiSHfAJHF7?=
 =?iso-8859-1?Q?4YFl7tB//ohDDW3i9Muq56wrw2LP/jC3lIG945k+dbreloUhv0G1hruVxL?=
 =?iso-8859-1?Q?S6ay3MX+YYxRkGWmjcQJTXMI62k3neY0nR9FG3Ep8rNU32+DaIEnNcdnPa?=
 =?iso-8859-1?Q?oFzc7oYiNdTYaZtmLrSOtUXISUNcvSa1v5VGh5WzrmKYPweLZSeOI+JOlY?=
 =?iso-8859-1?Q?D9P4HNg35ApnyhbL5vnPqtsBkWS7rEG5LOIv2ocbH1/Ai22wxCxchpg0W5?=
 =?iso-8859-1?Q?HHRZKNfFrb1zd1+/1HUa0vnFSQtaG+YWPA4SHczYAWCivg5K/gfiAqqhmi?=
 =?iso-8859-1?Q?HKENkuVBnFDX9HzmG8Q7Xc3ahyCBle58S3mBYW1EF0coOSog5KjuJjCR2Y?=
 =?iso-8859-1?Q?i8WgX6MTQ27kVmV/OTvvhJKF2ry3Tu0lm6e0ESDkYnR9jkImha3xepynzs?=
 =?iso-8859-1?Q?2Qp+zK8XqJA1kLyrLuYHXrRBiukpB1fs30zaOhG1uhUO8bNjeNbj/5gsLI?=
 =?iso-8859-1?Q?Ta7XXYhBZkyc/XV9w2dlJ9HSQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61ec95e-59bd-4533-3fcf-08d9d0611807
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2022 15:36:08.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yc8Gb3wmXEHWAaY4VpwJ7djJjtv/grffWCfprLpwXBNj8RP4PWgwuRK/PsG4hcrC9a/nGl1DUPMg/yA9cGEGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6606
X-Proofpoint-GUID: hjLrlTVDNo-MdAbGz4LCRY93WXmQ49Ls
X-Proofpoint-ORIG-GUID: hjLrlTVDNo-MdAbGz4LCRY93WXmQ49Ls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_04,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201050104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Wednesday, January 5, 2022 2:39 PM
> To: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; Chindris, Mihail <Mihail.Chindris@analog.com>;
> open list:IIO SUBSYSTEM AND DRIVERS <linux-iio@vger.kernel.org>;
> open list <linux-kernel@vger.kernel.org>; kernel@collabora.com;
> kernel-janitors@vger.kernel.org
> Subject: Re: [PATCH] drivers:iio:dac make expression evaluation 64-bit
>=20
> [External]
>=20
> On Wed, Dec 22, 2021 at 12:20:32AM +0500, Muhammad Usama Anjum
> wrote:
> > Two 32-bit values are being evaluated using 32-bit arithmetic and
> then
> > passed to s64 type. It is wrong. Expression should be evaluated using
> > 64-bit arithmetic and then passed.
> >
> > Fixes: 8f2b54824b ("drivers:iio:dac: Add AD3552R driver support")
> > Signed-off-by: Muhammad Usama Anjum
> <usama.anjum@collabora.com>
> > ---
> >  drivers/iio/dac/ad3552r.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> > index 97f13c0b9631..b03d3c7cd4c4 100644
> > --- a/drivers/iio/dac/ad3552r.c
> > +++ b/drivers/iio/dac/ad3552r.c
> > @@ -770,7 +770,7 @@ static void
> ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
> >  	dac->ch_data[ch].scale_dec =3D DIV_ROUND_CLOSEST((s64)rem
> * 1000000,
> >  							65536);
> >
> > -	dac->ch_data[ch].offset_int =3D div_s64_rem(v_min * 65536,
> span, &rem);
> > +	dac->ch_data[ch].offset_int =3D div_s64_rem(v_min * 65536L,
> span, &rem);
>=20
> "v_min" is relatively close to zero on a number line so this can't
> overflow.  There is no way that this change affects anything at runtime
> (except making the code a tiny tiny bit slower).
>=20
> And it should be 65536LL for 32 bit systems?
>

If I'm not missing nothing obvious, 65536LL is the right thing to do...
I did not really checked, but if v_min * 65536 can never overflow,=20
then yeah, this is not really "fixing" nothing.

- Nuno S=E1
