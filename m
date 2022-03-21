Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD84E22FC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345687AbiCUJLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbiCUJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:11:37 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE0A2E08B;
        Mon, 21 Mar 2022 02:10:12 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22L83WJv025700;
        Mon, 21 Mar 2022 05:10:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ew915w2w7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 05:10:04 -0400
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 22L8bWa1006333;
        Mon, 21 Mar 2022 05:10:04 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ew915w2w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 05:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQdIdJKPF9+lePSITizG+gSZC4HH6YX3LT5llqQ89FINDMZDER2rXIQJqxOLWab1K0F6k2KNhuEwsqQDCbg8tMlCT0pHxRtvMZ9CAiObbbDOEXpTCmQ2g0EPMzfxo+RsQYfgEHbVfgwVGCNfvvAUBl6ClTJ80a6e1GMAeLj1m+6AbD5vbFz1QFygMdRFJo3rXkcQ8fufKXyCRo6EXDWB0R6yVehQGF5Mh8byN1SvXUShO+KC7KqvYFr66PAb0hRFHLS7c2PA5F6bs39SyLphVUvJ/UrIINI+Ut1DC8JB8l7apQ6cVphGOTWUytZbZH+tTjynOhmMTO2zI4BgKV0tYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7YTQu/jMZxXAeW0LHnWJtO56ibn9Um0jdtCKdmTQFo=;
 b=AqnUxK3vr0BJTDltWpiDiUq3Oo1i0Vj4w5y9XyQShKVw7xSgw5fp2C0FrRC42AwoBq2Ce9KMD+0bRBUSbvS7WD9umBolZv4Zj/LgCvkpy6WBJb64tOAP9rM8yK6RX8TZKT+5F0AVJQ1DHAy5hEuiwv+9bJS8BSapxUAOoZ6XZhuVXWICvCQbkPGftA/D/QqKPbgOMAzu3mgSLN2n5kRwB69EKSTKQ0Et5EfElxuz1ylAJzf6ZT/k1asrdzL/n2XdOYnqH8WSpZdof5J969iLNPZ0w7XP3D4p8hEKDh1lq3I35qsVYZ3bDcuiPLHD4P5u7s3WOhrx2xh1q27IAH5fCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7YTQu/jMZxXAeW0LHnWJtO56ibn9Um0jdtCKdmTQFo=;
 b=eae1JX1+iOUMtOlNezFtMJN+rtbAdQBONnRqNaI8DjPqkgX7uc1sewsLmzHtJz0f7y/ZvVr1Mt+2OsEbdOdmahbHKCqQT0yIkkDyshsYw6pN//6ZfkCvdGlrxPZLIrjcRg6nb1fMAotGSWHbkcSbFV25+zGz5C70aUa9OmvkkSo=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by DS7PR03MB5480.namprd03.prod.outlook.com (2603:10b6:5:2d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 09:10:01 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a566:1d77:f902:df97%2]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 09:10:01 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     "cj.chengjian@huawei.com" <cj.chengjian@huawei.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2] iio:filter:admv8818: select REGMAP_SPI for ADMV8818
Thread-Topic: [PATCH v2] iio:filter:admv8818: select REGMAP_SPI for ADMV8818
Thread-Index: AQHYPB23E6Fbi/deBUOA7YXvt/EGrazJjmXA
Date:   Mon, 21 Mar 2022 09:10:01 +0000
Message-ID: <PH0PR03MB67860473C10499C1EEED1C0A99169@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220320055457.254983-1-bobo.shaobowang@huawei.com>
In-Reply-To: <20220320055457.254983-1-bobo.shaobowang@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctYWVhOTU0NjktYThmNi0xMWVjLThiY2YtZTRiOT?=
 =?iso-8859-1?Q?dhN2NjNzEwXGFtZS10ZXN0XGFlYTk1NDZiLWE4ZjYtMTFlYy04YmNmLWU0?=
 =?iso-8859-1?Q?Yjk3YTdjYzcxMGJvZHkudHh0IiBzej0iMTY0MSIgdD0iMTMyOTIzMjczOT?=
 =?iso-8859-1?Q?k3NTU4NDcwIiBoPSJ3dW1WU3BaV0Jybzl2WEZRS3dRbUh3RC9JUmM9IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURHb2dGeEF6M1lBYWxxeUxCSzZBbEhxV3JJc0Vyb0NVY0RBQUFB?=
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
x-ms-office365-filtering-correlation-id: b721ac08-a0c3-45b4-a768-08da0b1a9466
x-ms-traffictypediagnostic: DS7PR03MB5480:EE_
x-microsoft-antispam-prvs: <DS7PR03MB54805C964A45A224F6296A8799169@DS7PR03MB5480.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 852NHGKJhzZXYk2g8ChSFgD/AE/jjTW7kg1QMhSdJjATFZyWWuAex5ubmlgsNqNJtTojPHmMwCulKfd6jSyocsrAIX7te2rYU+TC43HEupRQ+SPtS+H8zFJOa6jaNrH97vBu8AU/BCPKyCuLd3VH+zDO5CQNAopPkdWuVuODhSRcKFEFapkX7jVJTCAcskijExAoKj4UfYunAZ4fwTpYPYghS08+1Pwy4MZ7RFa+AR4GR3ieRm3Ygx0PUGPLuXdVzd43IY9s56Fh9o9U8WEVdHbSorXOs7A8Z/uVEf4CXuK+wy3JoWdAqsAjOhlkhW0zBumkcuX5+Mj9B3pyjqaqla8FZ4wsU/PScrjkiA/GvuKFgSNRI0zTR+NG32IIuSWRR6lBcIccaXlvsHRhkq0HZAqh15AnrPKgI+wzEv/kPIhNpZMTN4nd2V7n4SzWd+oDg4MCZdzinT3XRCR+o16ilA2p0CizTEOwGneVjrQlHbQAJdhe3D/ZId5usYQkY21z40jFU9RqleDEwY+SfUEqqp4Myj5+vzRUZblAO+da0Lk6hJkhLhHvYZ+vA25aHk30VT7DFkgAvhVjE0MO8tUoBMJq1TADZCVFKptvAm6E38/fT1iAWAhNDVpydnlLnR/itKqBzOfZkYV7soXDNo2wiFTs2Ew6CgwknEHlfqdrDFjxYJElA92G8cyA23+AUxMPtCvMxQfujmDz5f0wKXsiaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(83380400001)(66946007)(66556008)(8936002)(8676002)(66446008)(508600001)(66476007)(64756008)(76116006)(4326008)(122000001)(52536014)(71200400001)(55016003)(38100700002)(9686003)(2906002)(316002)(7696005)(26005)(6506007)(186003)(5660300002)(54906003)(33656002)(86362001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7XHERydz71NtGk80c1hhemSV/gZkdAuZY71ULOs03jbZ8SxTJpwlEX6TQ1?=
 =?iso-8859-1?Q?GEk2DAPgEWsya95B0f1FBLAIpc/qUQoiQV+3o7rhachC5P8yn5Gq2k934K?=
 =?iso-8859-1?Q?mFAxSYzDWEWL2xMsadKeKOrFAQLjtSjcfgZL0Ozy1sZIGlZfK34Na1HgpC?=
 =?iso-8859-1?Q?+TAqH8xvi7N44e0LaBcwpF9S7lbTg3iWWp7MirXvx6HIYZV8jgnOW1PrTz?=
 =?iso-8859-1?Q?32q+XFaCFqCyv8AaiONbBfeEfZ09y65KrGPar6kartJUTYEr7FTZn7I8r3?=
 =?iso-8859-1?Q?W3T27lxxHf/ow436GvJStMegb6uVd85Jc5s3MDImDGlWb4EM7p/5VAYUnw?=
 =?iso-8859-1?Q?CVVcfRevvwmECeZT8mswChEjbiTs1djvW1+2bFWgWuVHZr8PlW30HC9O9B?=
 =?iso-8859-1?Q?Qsadg62JHZok9WiPhyErAl6gSh3P4EF+TPBlKF+xM8PQfm5eSzetrznXOy?=
 =?iso-8859-1?Q?cyVuID9AlWc7fEOfQ5xXBcAMuLuyW/Q7J7nXhJmump8zEp3iiyt1gh+RBW?=
 =?iso-8859-1?Q?IVWpC74HHMZVCHB0FAVfzCv8+kAAm5oKM3x81KRXrtJ+Ny/ulzOFpzR2if?=
 =?iso-8859-1?Q?OQY4q2k38cO7bQDGfsNJ3FaPw+0/Z6OpndYmEYgRwdNcJ800ceJLOfbQOF?=
 =?iso-8859-1?Q?YBB7/RWEK+Y5+z/p54Y2bla7X8Nvy4RIAbHh3muUv1rFDgWdLdM2Lso5gA?=
 =?iso-8859-1?Q?tkTlZI7TeD1UlqVIci53ECuE/Dw9UnS5gfBxJ8WDCQP/DdbqSI4eJZlCJG?=
 =?iso-8859-1?Q?GbyL2alCVkK+Hjfi3p1r5ZoU7I0hWDCNlJR95fTyU4uXkIG/8/EVgoz8ly?=
 =?iso-8859-1?Q?ytFdHTt7mlf5NDxq32/+Jh/oOvqZAFbf8GwvbP+ECS1VQsFgQlt90N3lQ6?=
 =?iso-8859-1?Q?3ZPAgakHcXtHHIsjLzQFtue5CrslrZSxp05gHmgvHGxE7MxPlBsSlcnOnv?=
 =?iso-8859-1?Q?myeTCXkBk5jst7KViXVqjTp7ZoJ6LcEhw2zUI/lPb688RMBu2mKPKhfeCb?=
 =?iso-8859-1?Q?x5EfgAtceqIkGndk4jjONyJyDj+AQpW5ITY3tYqCFM/zC5zzxqBem8/7ni?=
 =?iso-8859-1?Q?pWaWSamDWfZDl9AaAr1hm0cssvs6XF4RPZftrugeGTPIIXl5Q7JgaYYgVq?=
 =?iso-8859-1?Q?kgCOIiAofzzs4pzfqveF+LEMtZpUKE4t5cabY5eifB8XOCcTvBZUULlFAl?=
 =?iso-8859-1?Q?3BHZYPJEy/fiqR1SC7nIpnY7rMY6PuIGdJHf1mEurn9UvszXjlFOJPVACc?=
 =?iso-8859-1?Q?4IJZ9tR26zWzSDGnQPjcBkA2SeiEm/GCkFmLfomyW6l2mPCFhloqA25ZSI?=
 =?iso-8859-1?Q?/GKe058yV6EeXoze8iqY39OTu5AjTBFczEBDMLEnHQsKB6CRpOdt5S393r?=
 =?iso-8859-1?Q?P6wnbfN4vfkSPRktFc6s7uyZ7osVZVa+kBwb14gie8KazdYcY5IgHDq5nY?=
 =?iso-8859-1?Q?t9qWyl/tsS14a2lvLP/f1r5ZIjIAsKxOFmWE1ArgGJu+ZIQRi5z3I0v+6T?=
 =?iso-8859-1?Q?/NlOQaUyhnMf6ATkUK9f5J?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b721ac08-a0c3-45b4-a768-08da0b1a9466
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 09:10:01.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nnIaWZ2lIrLCJr1YAvIU8Dh+72EHGTysTKkkXiqpS8dTkNKi7UI8Do3qUTWBGaSHLbc5t7IdyvrMrCFyq+rQGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5480
X-Proofpoint-GUID: XXe-ApptKFNXETpm3gEaF-RaW5ynwzIT
X-Proofpoint-ORIG-GUID: VV5Om9XxuzS5H94PighhmMFOzVt2-mi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_04,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203210060
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Sent: Sunday, March 20, 2022 6:55 AM
> Cc: cj.chengjian@huawei.com; liwei391@huawei.com;
> bobo.shaobowang@huawei.com; Miclaus, Antoniu
> <Antoniu.Miclaus@analog.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> jic23@kernel.org; Jonathan.Cameron@huawei.com
> Subject: [PATCH v2] iio:filter:admv8818: select REGMAP_SPI for
> ADMV8818
>=20
> [External]
>=20
> admv8818 driver needs __devm_regmap_init_spi() which is defined
> when CONFIG_REGMAP_SPI is set and struct regmap_config when
> CONFIG_REGMAP is set, so automatically select CONFIG_REGMAP_SPI
> which also sets CONFIG_REGMAP.
>=20
> Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---

Reviewed-by: Nuno S=E1 <nuno.sa@analog.com>

>  drivers/iio/filter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> index 3ae35817ad82..a85b345ea14e 100644
> --- a/drivers/iio/filter/Kconfig
> +++ b/drivers/iio/filter/Kconfig
> @@ -8,6 +8,7 @@ menu "Filters"
>  config ADMV8818
>  	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass
> Filter"
>  	depends on SPI && COMMON_CLK && 64BIT
> +	select REGMAP_SPI
>  	help
>  	  Say yes here to build support for Analog Devices ADMV8818
>  	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass
> Filter.
> --
> 2.25.1

