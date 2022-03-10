Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C594D42D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbiCJIuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiCJIuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:50:23 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885011595C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:49:23 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22A1XW5O020681;
        Thu, 10 Mar 2022 03:48:15 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3em2ka958x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 03:48:15 -0500
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22A8j6ga003539;
        Thu, 10 Mar 2022 03:48:14 -0500
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3em2ka958s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 03:48:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n86qD9fkv6ut6Ycd4xJ/sQI4+cOTFCBGPrkv3bnqb8txn262Lb59lC+Mr5CMENZt3O7YI0S/V13r1uYa2rX8+U2C9a7b1+dKQSaWz0M6fZCK2ttfSxjNi9wWwUb1fagPEdr2IxN6GbY/KJpUlNfmQhIDnbramDiNvmYNc94g+ePwGJAah2Rr1bKYSwx/4v6Byn7RSeM5m2k83e0MMROa3546b2cgg70MLTdgES5oGMqZ91coCaHlfXRb5PWFMhdqDsRqKkdITdivP637zOdEC0CMqanVETe8hnnITe8rNMDjpSsb/c2LznbSacUzG/GrV33xwwJB1dUXg2kMDYsxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fanJ5ll1sfX4RC31nPguBGJk/WCWyF+ucfE4eUpokQw=;
 b=mYAGh1Ko5zbWIUAHoZzSWGuz3pulSZfNeLcHWmwT5kt1yelLMH2b5ysnnSkITOj5zoE3voVltlx01vV0jP+uG3cTLZ3d+UwvJAfGDdvT4hadvRNQFa5HPh4aCGhAeHl/uGITxuaG5A++BCKAxKK1EcRARNxLunkorVScBAfQ9HrgVElLCvhNztLhZh9kJIs2nWpkAJP9HvoVK8VEwdSNrKJ4vjI6dSLNqhjNkZe5HeNnMJjYbctfikGpw8w0ulxzOaPRorKvJbmeQiid1h4eQ9/XEiv7U7yAIXVu3TCSYcZjcg9z6aLX829grGr73aV8OwE7rbXfz9kHC5vDGj/RUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fanJ5ll1sfX4RC31nPguBGJk/WCWyF+ucfE4eUpokQw=;
 b=kT4M+VehgN8zJ6aZkK36WaWJFNt4bUlsmyu4mfn1Z36A8mTzSZlYzQR9P1tIkc5LNC+ySN3l8P15n5PHFfnY6a8BRYLabz0lFlbjgaYq+bxzEOEvA0vMNpeozNcMHVfkugL6J1e6p5N/VjHH/tFyB0iZBDofRSNq+zhEG6gq5kA=
Received: from SJ0PR03MB6779.namprd03.prod.outlook.com (2603:10b6:a03:40e::5)
 by MN2PR03MB5021.namprd03.prod.outlook.com (2603:10b6:208:1a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 08:48:10 +0000
Received: from SJ0PR03MB6779.namprd03.prod.outlook.com
 ([fe80::148f:e07d:a5f2:c71e]) by SJ0PR03MB6779.namprd03.prod.outlook.com
 ([fe80::148f:e07d:a5f2:c71e%7]) with mapi id 15.20.5038.029; Thu, 10 Mar 2022
 08:48:10 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Steve Lee <steve.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "steves.lee@maximintegrated.com" <steves.lee@maximintegrated.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH] ASoC: max98390: Add reset gpio control
Thread-Topic: [PATCH] ASoC: max98390: Add reset gpio control
Thread-Index: AQHYNFccgr40UHo4NUKAxl3T8tSFjay4TIUA
Date:   Thu, 10 Mar 2022 08:48:09 +0000
Message-ID: <SJ0PR03MB67794358405FA661992A206D990B9@SJ0PR03MB6779.namprd03.prod.outlook.com>
References: <20220310081548.31846-1-steve.lee.analog@gmail.com>
In-Reply-To: <20220310081548.31846-1-steve.lee.analog@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctY2UzNmU3YzctYTA0ZS0xMWVjLThiYzgtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FiXGFtZS10ZXN0XGNlMzZlN2M5LWEwNGUtMTFlYy04YmM4LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhYmJvZHkudHh0IiBzej0iMjAzMCIgdD0iMTMyOTEzNzU2OD?=
 =?iso-8859-1?Q?c5Mzk2MjIxIiBoPSJybnlBNVd0alFLSHlRWXc5NjRYWURJMEZtdVk9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQUI5SFkrUVd6VFlBWUNJR3RkaUdjbW1nSWdhMTJJWnlhWURBQUFB?=
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
x-ms-office365-filtering-correlation-id: 34d428cc-be68-4763-2de9-08da0272b45c
x-ms-traffictypediagnostic: MN2PR03MB5021:EE_
x-microsoft-antispam-prvs: <MN2PR03MB5021283FD93030E3D591D616990B9@MN2PR03MB5021.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E4NGYB0kokf5WVgWRMm9Ul5KZiEU9wV2ybCJ3zNv4z6R8dCHI4udsaAb4LhDufiukZvr4Ro2eYtaSoiov7Rb6cO7HksS2HcYlTLCjz68DbpvGl//3Jj4wdeHQq/hnIpfva+9WMJy8yI1cihvwBgX6Li4cot8sXWm6/D0kIud3uUlsdRoAzKRPDflD9CtKXqD6CspLYe6k6fEECZxEU5grFAalHrJtsiVCwPIR+PBBqSPnMo9Q1D54TquMP4qEBK9EspU2M6UmW9Sf9TabFSAbV/bxeGZ4laqeVUUgvzNHgJHf1tqJ80rR0PV9EzHqHwH8F6dW02onu+C/DdnPsXW2ehBVjMhDdqDsLgP8qUfvQnlM6eaCQdqkc3/qKN42mbba94WYJlFhcny+3PkcKJAWA9SLuC5R3xuYOABCV2xfLW5k6gXQw/r1vx+FQ65edjFjyc+r/cSw9B0a5h/21I8WDPHNSe3CE5ttdP6P8fT/4pF+FPYOOev0B2W5G1463HXykvdx05/pMJhbneaPCY4PoVm20nuEY0EaVkEBcUU/GCHbPAy+WMxwQOjcFI7HvNgp5+U84aPkcx8J23VtWtiUoOWViLfsZmHHVys6gPGC909N09bskqvhSMvKPwHN67zO9ul01rpo85VPhYHLJho0tBDrr6ZmNKOfQfFoMFIa19lfNxiJVEcbhwSjyEj5vgUw+CiDC23F87235bIeuD/YhSRwk6euYschonzgxrHlKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6779.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(316002)(122000001)(38100700002)(921005)(52536014)(508600001)(2906002)(66556008)(64756008)(8676002)(66446008)(33656002)(66946007)(7696005)(66476007)(6506007)(53546011)(5660300002)(9686003)(76116006)(110136005)(38070700005)(55016003)(8936002)(83380400001)(26005)(86362001)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oCRQDjaD4zBkWdx1IBT8xqRhlB03qffoV1wQZ9wuWo+qzyhVnwwSp8d4Tl?=
 =?iso-8859-1?Q?MSoPmuf3HN8+2Zj4Yq7ielacmdoXfdKfEHNTKJGVF8NZ0ajosDkLTrAFw/?=
 =?iso-8859-1?Q?ZQf6ecxNlVkBzxIOkEg79DEmg3nXB0w39VWZEeLFAiw4eolPw1JIY6D+z6?=
 =?iso-8859-1?Q?0LD6+7ZK4lTlMGJ/5YDJ4ZE6ft1ze1S2RWGE31fY5jC4Ovbq/CPBL3aLWh?=
 =?iso-8859-1?Q?hCJejcosngOGmsAAG/B8bgKK9cxFdcVxUVKDmVUUQ/J77lz3FozvXgwbWG?=
 =?iso-8859-1?Q?omTCVqPTLcSubXD/Zq3QlXHn6LamOT+VbqU9muan8a3E6x8HO0nzzxHVfw?=
 =?iso-8859-1?Q?Sp72ac5+2/6NJh0RaHyJGYo8Bpsmu8PiQAf60rvmRq9C0MJYjFUhMC+ytv?=
 =?iso-8859-1?Q?BgO1nI0Xmixjehe2u/3S6EV5nxJSPQ7Jd+vyZBnGX+fi6T7wJVnnSi/QG4?=
 =?iso-8859-1?Q?io95yUi1xS0i7RCLKXF9hfdqnhYJsZk+tSI6AHkVQhOBnISHLtOf9EWBPz?=
 =?iso-8859-1?Q?oRNWqvtvdj8L58WsFDAFba69fejObdLO8qki7wTwpWQ8hC5zyg2RbImeJo?=
 =?iso-8859-1?Q?qA7h/3qs8Qr0vOigiFgTJcArz43bi9HqkQx/OmvhWiZJAeOCUgdGBKsFhL?=
 =?iso-8859-1?Q?9mxZXDKLhmptU07mntM3SA43uGrZnBcQ1tDDGcsJHqAFAWuwChOCAUMswB?=
 =?iso-8859-1?Q?2T0I9oqDkOVU/DxiuiCEPEVD+pkwfLdXilkPkbYfwbp5q+n/6FHkyT5K6f?=
 =?iso-8859-1?Q?LR9YK+K1z9iBcEARRTxE42++rCbo6HtDg7VjEykVoT4aVjIMg3BVXwFFp/?=
 =?iso-8859-1?Q?RrbM1wdWZZhLnr4mCyqLw3N1/bBGnk/RYaQxjQNjV0yLhFnZF+2Z5nAJ2e?=
 =?iso-8859-1?Q?YJxCzHGZqqf0cJXyFtk1DsRfw+RayUJjU2mNCcoPXDADK5Y+9El+5Q2Oqf?=
 =?iso-8859-1?Q?nSQSeKeux+k54eGTzdomAxlw4dnP1V1mFm8VPMCm1FXzjgvSu+1B/rj/9c?=
 =?iso-8859-1?Q?Q4gb/5WgjlRwtJuQ8ITqQ3QXC40iOc2PgCmtPz0Ou/z9Cyv/8Eud/232HG?=
 =?iso-8859-1?Q?w2V8K0dv6IkKPpYptylzYp8KePg5WgZvYrl89Zz7v0A+eOj9GZ+n6GvEH8?=
 =?iso-8859-1?Q?Ft/KfqK+G+2Kv5xLb0BT+m0rskVnH9tiWWwP3zpBnHi+fH6LrI7fWiOF+E?=
 =?iso-8859-1?Q?4VG7d0mdsCE+XvGMWl0SM7gycsJYmT6AlXyioBA8eaaqba21rE9rmJMBOv?=
 =?iso-8859-1?Q?pk0MsHWDI16X9dB/PByR4nyUngmhiwQpfYlQLr3rbEuJ9+iurjPxKcuc1n?=
 =?iso-8859-1?Q?mIQ+LiqfiRXExE9pT+/XPIKLGhgYOe8aIlM6vKxX7c7KFjhnM2kTzPf/4z?=
 =?iso-8859-1?Q?kJcUpArxf2ylqVxNTH4fG63bhfCC1toFbaTn0Dd6Xk7wNrMpWaZZ/lmSEJ?=
 =?iso-8859-1?Q?5lIdnUSp2Extf57MZEbqEy2hvbw0SEC3+tKdT5XJepRR+dCLOREhPwKVca?=
 =?iso-8859-1?Q?uXIdXAWXPZ0EdgU7c1nqpePFF4nPATbd8oGKKhwZVaMRnsCpSYjTWqQEqD?=
 =?iso-8859-1?Q?PGDTfIcUuXjSxnvnvFj4+QKZD/E8XtJ09bLQvYCG4my+xXLzP89MJ5w/lc?=
 =?iso-8859-1?Q?UVX3z1WdIU3uGh/Hxj1AIByfUvdgHJEiu7LUdPced4mnCXMC7CehevXQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6779.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d428cc-be68-4763-2de9-08da0272b45c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:48:10.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYAwg32Fvt0kzIqyoQy5RGjE+qyFoIb9edaRk4CF0LImeSf/eejFNO2qD+DHA/d8OH9gMvAtlPRe2ReXQu5ekA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5021
X-Proofpoint-GUID: krt4iCSzukgnmeIMsrRJ9tXWXfnHTam5
X-Proofpoint-ORIG-GUID: rLg2IVzfTRFW5s_ZYVg-aG-lVxJ2C_dV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_03,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203100045
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

> From: Steve Lee <steve.lee.analog@gmail.com>
> Sent: Thursday, March 10, 2022 9:16 AM
> To: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; ckeepax@opensource.cirrus.com; geert@linux-
> m68k.org; rf@opensource.wolfsonmicro.com; shumingf@realtek.com;
> srinivas.kandagatla@linaro.org; krzk@kernel.org; dmurphy@ti.com;
> jack.yu@realtek.com; Sa, Nuno <Nuno.Sa@analog.com>;
> steves.lee@maximintegrated.com; linux-kernel@vger.kernel.org;
> alsa-devel@alsa-project.org
> Cc: Steve Lee <steve.lee.analog@gmail.com>
> Subject: [PATCH] ASoC: max98390: Add reset gpio control
>=20
> [External]
>=20
>  Add reset gpio control to support RESET PIN connected to gpio.
>=20
> Signed-off-by: Steve Lee <steve.lee.analog@gmail.com>
> ---
>  sound/soc/codecs/max98390.c | 18 ++++++++++++++++++
>  sound/soc/codecs/max98390.h |  1 +
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/sound/soc/codecs/max98390.c
> b/sound/soc/codecs/max98390.c
> index b392567c2b3e..574d8d5f1119 100644
> --- a/sound/soc/codecs/max98390.c
> +++ b/sound/soc/codecs/max98390.c
> @@ -1073,6 +1073,24 @@ static int max98390_i2c_probe(struct
> i2c_client *i2c,
>  		return ret;
>  	}
>=20
> +	max98390->reset_gpio =3D of_get_named_gpio(i2c-
> >dev.of_node,
> +						"maxim,reset-gpios", 0);

Why not using devm_gpiod_get_optional()? We could request the pin
already in the asserted state and make the code slightly better...

/* I guess there's no need to save it in our struct as we only use it here?=
 */
struct gpio_desc *reset_gpio;=20

reset_gpio =3D devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_HIGH);
if (reset_gpio) {
      usleep_range(1000, 2000);
     /* bring out of reset */
      gpio_direction_output(max98390->reset_gpio, 0);
      usleep_range(1000, 2000);
}

Also, do we have this on the bindings doc? If not, it should be done on a s=
econd
patch on this series...

- Nuno S=E1

