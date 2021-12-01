Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6604648F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347800AbhLAHmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:42:40 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:58460 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347744AbhLAHmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:42:39 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B11mM6p010643;
        Tue, 30 Nov 2021 23:39:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=p9s0/HxpTbWHacxINvuVaOp3RQCfScgMNetPfdH/SPw=;
 b=LbSXtmsLluKB/oVSE4Vz9wIfgE2yuV8ktewyjiQnBThy8HBS8sV1N1hlaMS6cczaTrNT
 /hRhMZkOr1PU74DHZ606D8Og7cAu5LQZhdDt07ekX4XmxT0XIx0AV2MtKl1IeklJMonu
 Tx48XI+e6guvHmEHuni70UDiI0hxeInVvhDpZfgiLKPTFz+rXz3j24Kg84/638MrDJhH
 +BascE4kX6VmBeZLMX5k7HDMVRza2P5b8xwan0/pc5NP9AQLZNDR399b+tRqpLBb2SYr
 wXWWQT+99px6/qcX3VL64KgV9EYv51RvIZ671QDDvxM0mqJOS12ArlA5KNeL52cxhbOX uA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3cnkmvkt6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 23:39:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmA8olostSncraHPsR4b5eOXgGr4kMtJJOErmoXsFyDo3vNqqyEfd1NoIVB+1T4M8zun52pT06T73fjYmQPTGGVyCCl2lag6M9mEUiTH7hJHuLZOdIL5CGMP/1pPc/eVBZgyRpFZfFjJ7orZKkmAaY6qSil5p6topqNcx4is9Z70itlyujo21XXWH82OXVWLLqk4ZpJLSksdJ8QccFM4fNLeNMx5f577O324nUqCnAeIUUoh83j6icWBp8KTm+XpuE0eLntoRJidEuFl3W+cU1KUHkd+ED2XiMtIhBM1xtOLYvUMXKGP3grUFhWC2kwsrWWu18H4kQGXsBgvHTFKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9s0/HxpTbWHacxINvuVaOp3RQCfScgMNetPfdH/SPw=;
 b=Hcu+4/U6EpWHoFAFQiISFx76IvkarOOlEmZOlNAtb8XqaHQx8B2nIbbqD6OnnjwAaqEoL/KJLEY21KPpkU3xBlawkTY1vDztASIKi7U7pQo0MSCmQxPERdAg1sQdSxz9EYmBXybE2QKP6Tx5jtxYOHJtOJBjcslOzPwf+wFVCL0cgy27k0kENDL4UZrJrgKooy6u5TF+rupuRuIhclVJbmcSBOLOx5hhvbgkf+/xdJkQynNrttVuijxt929qdIxKQaIh9slXI4ZiPz7Wy41M6vKAtqnLpeRrvfjnwOWQ87YK5PWFepUpMiGmEdvJvCTmX5+BmyTPvOwl2VpMNFZ/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9s0/HxpTbWHacxINvuVaOp3RQCfScgMNetPfdH/SPw=;
 b=rXDqFapoUhJVloHvPGPVD/GoqC/ZcN8hH92hxDhqHIoPvlHzRMJ52wmFtRaMKAV6aIaFSyoqHAy5IcbfWBTP7Qtr+xLK45r2cG0DC+zjOJgOK276ZqyH4MV0aOSi12itv9R/q6AQzSslcMTvfm2a/cJkU318lJ3bQ3ropnKX39o=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by SJ0PR07MB7568.namprd07.prod.outlook.com (2603:10b6:a03:279::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 07:39:06 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::241f:218b:e5aa:9024]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::241f:218b:e5aa:9024%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 07:39:05 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in
 cdnsp_endpoint_init()
Thread-Topic: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in
 cdnsp_endpoint_init()
Thread-Index: AQHX5g+EScFJGN+g50SE4yK10NJi+qwdPKoggAADLjA=
Date:   Wed, 1 Dec 2021 07:39:05 +0000
Message-ID: <BYAPR07MB53815000E619C1E80BFFD275DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20211130172700.206650-1-zhou1615@umn.edu>
 <BYAPR07MB5381BE5297FA4905E8BD40C0DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB5381BE5297FA4905E8BD40C0DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzIxZDdmM2ItNTI3OS0xMWVjLTg3YTYtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XGMyMWQ3ZjNkLTUyNzktMTFlYy04N2E2LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMjMzNSIgdD0iMTMyODI4MTc5NDUzMDQxNzk1IiBoPSI1RG5QZGRIbjZBMFhsTS9yalZJdnQ5Z21DbUE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 053f82bc-b481-4dac-9923-08d9b49da74c
x-ms-traffictypediagnostic: SJ0PR07MB7568:
x-microsoft-antispam-prvs: <SJ0PR07MB75685AFFFD48155502808C6DDD689@SJ0PR07MB7568.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZk6FCynlso/eJX74nsX2MNqQ+uI47A3mAWETCviuLvsEOm0MjyuqjE4TfH42ovGggp8BarGLkuBvT+x4iu1cCzvBsGnj74t9VD5oJoycApHfUQv+LV1xVNu83h7dQt3Cpkt4xeIsyQ+9c1DMuysOziZ9x4ETiGSJ78tP9/NgK8LG7Ji2eeH5qaao2sX8A8wEn7Tx4pqBpTwIKzIUizhO0MPRRjtj+6wcsgtP4HNSaFcfrURorPTapbAHVgSLz/7Skm8XzU/4S860cyU7H8kytAfikeFzy6Xeyu22yWVd6m4uJMbdhfv8CNNuBQSUnjUqb8Z8NJtsElXai/7v5NCqlKWre3rGXBI4ObvPvjUbzNNygK+RQsm6cdarZmNBxMxdJd+byt5ck90AsUV5uy4vxAyp5SOL0XNWVyJIasObMf2Qfr7orIcskz01SWHof8TimB5FI+ObBhhsZHUNPtGRr+lIvvYLsp+DGGH3PGfYonJH9et1lKhCrsdyiE8M7qwzBfdvPugoLYTcV/U8qcm+9v2gQYaX7KdMj/yWGl3iPd23lRC99UgoLo648YDmRLGeb1gohokzapvYMUSxhUD+m3dMTTb0BB+rbLql8ugAF0LN8yeI2W7xLejnJQ4D0YHtAXSpqXKIVubHk+htO/K/LC1IskxJJGqOBBZlepdgP2ehQSu5l3rXD76tYa/p1rlGnlxtwJRlCGp5Og1lL7QRRh46qFABQEXlNBO0U8OhkvDaCtRS+pL4Ca4Mn0+YHQr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(2940100002)(86362001)(508600001)(6506007)(52536014)(7696005)(38100700002)(316002)(71200400001)(8676002)(76116006)(54906003)(38070700005)(8936002)(4326008)(2906002)(6916009)(55016003)(66476007)(64756008)(5660300002)(186003)(66446008)(66946007)(33656002)(9686003)(66556008)(122000001)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VTB9RqBhTvNNVXUoGJq66gJmIkHpzj8sdZXjZgo/LYfem9naAKyqEA1Ie9Tb?=
 =?us-ascii?Q?8+pxamZikKGSh1SyZNdeNUw1KcVbQ4IYVeFG4PcO0OItBUkhrub0rBYebuXv?=
 =?us-ascii?Q?kn7OW47n+JDWUO5kNFrKFqtAFIDPW+K92i6FfXxWuEfOL5jehdTVXkwgTdMT?=
 =?us-ascii?Q?B+xPEtC762smDSyXbfQiJRvtyKkj9GX+994n5TBXkNhleqdeLALRuKQfX4WH?=
 =?us-ascii?Q?Lyg5nVVt3b/l0TUXIZAA350OiYDKD12MmAdl3X0o7N6uEdsN6hPMWB2BEzuZ?=
 =?us-ascii?Q?guEhGp43ANYk0exXlyC1VoIiS4pl+ia39MEJVeZMVy3LaiS6/EiJBod+8UU2?=
 =?us-ascii?Q?YtPnMKZjK+1hnHJNwUu1UET5Y/yiCYOuySB8SSmspgf3++IufBUkpeoFy/H3?=
 =?us-ascii?Q?lncRazV23JTi58StFfoyJQCApRfXFjyuVD1jBw0XbOjZjIXJTxzbg+0jBWVe?=
 =?us-ascii?Q?SheB1b+8FhxLMwYF0CkctfRLr3kZrgETCeUt/0y/4j6oovl7Q47h2SzhsdLK?=
 =?us-ascii?Q?ppx44Ifih+pgvrPJD5LLT83YkH4DuIlwfUuCW4c71cMlay+TokYfv19W6C0D?=
 =?us-ascii?Q?k/dXx4zVfcrr3ip7OrHOah3Q+8n9BM0pteqkW+9Yh/Y7e8meP2kQa3ZeDahH?=
 =?us-ascii?Q?lkgygEceJMgsAK5LnWveNYa9VV/Gd4s77Cd0eFxwjp8xLJ8u0mbLM/zc3dYO?=
 =?us-ascii?Q?7qwAW1PgkLU92eYwWLGHf8rrzElGcGqGUCYgpEsGq2WxgA+4imLzjxRbGwS5?=
 =?us-ascii?Q?3mmJhn3pgYM3TEjFnlxg5VTweO+u3iRCv8CcoNoBq5Ur0XWMco39NPVjM7pb?=
 =?us-ascii?Q?oWdcNy0ttTMTbGPA2moMfg24xZaH201DUyvtGpetPpPBB3E/nUZXr3Y1oj6/?=
 =?us-ascii?Q?dfZDJXjznZrWxaqNQRL+9MvoLpRRXcVVUQDtpcmj85b2MLF+Y2OZDNtRG3pW?=
 =?us-ascii?Q?eCcGFrmjGjWHq+C3bqalu5PsJsQzRzv6k4WGAowr6k0abAWn7d/4aA200S2B?=
 =?us-ascii?Q?TeisWrKv9R4KQq7DeFt8eXj1TZgd+NtAvwEKZJyAJNUyv693JibAc5wODRns?=
 =?us-ascii?Q?NmzZBYLmHuaDxjvx58q+u/GqJE4gxSOyirX/A2fuJ+yP0Uj9RZ0OJU66GAu3?=
 =?us-ascii?Q?7AjoYnqLOrs/A8oUCZJMAaW+ifCBHl8FX0DWXBDhRUtl1vAiLy3qtkWHmkJB?=
 =?us-ascii?Q?PTqhU63yQ/b+hnk7j1M7xvW6QGyVZsHHmNGnHCAzEDGlMVN/g6ty6dBAT3QK?=
 =?us-ascii?Q?ZzRVxW2k/mCzsHrnbUvA10IDZ5KGJckRdFMq3w3NhT17OHdkyIo1fjE/xakw?=
 =?us-ascii?Q?bwiXuFc8z7mXe78PTZRtOqeUYU5uZSq/q6IhORS7NvAgxRwEIvnW3Djb84LS?=
 =?us-ascii?Q?1r0eHiPO9SHmm7AVHZtY6dsfywXvz9ZQZd2cW+VGjMkAnDi31UUjZBEoanHb?=
 =?us-ascii?Q?1NwNMeIR+HmWlYoCEYURVOlzP6V0zu6VMALMeS/dqfvi9vc2i2579PfIEWHy?=
 =?us-ascii?Q?0B+1FUT3yRiFabbxZsKvyrdIlavisTGTe3KPmwPElJIv4BYvD4e56fiiAEmU?=
 =?us-ascii?Q?NItWmUsNAK99lTyN5KXPjKGx9P3MQLuIMFWxuyaVbFFKmhGZQsxwsZD/cbId?=
 =?us-ascii?Q?5iAaGxzIY2ccXrMOiGoPEBWY/hcFIEWb8/9mVJy+eD2zbWZZCUpM19zx1JnA?=
 =?us-ascii?Q?5Xq9+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 053f82bc-b481-4dac-9923-08d9b49da74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 07:39:05.8126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FCnlAp3K11QC5GgWnhgZe08MZjmM6kswQOGtcUppKTJJRZBSDD7TXkp/Ge6PmzaHUv7Su15Y7EyyUNQ7GUeXXseXpfqEoYlnNpsUZOKIwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7568
X-Proofpoint-GUID: WqwK5vmreq-Yt9ZJ5E88BoGjl_yY6vBq
X-Proofpoint-ORIG-GUID: WqwK5vmreq-Yt9ZJ5E88BoGjl_yY6vBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only fixed Peter Chen address email:
peter.chen@nxp.com  doesn't exist, should be peter.chen@kernel.org

>-----Original Message-----
>From: Pawel Laszczak
>Sent: Wednesday, December 1, 2021 8:28 AM
>To: Zhou Qingyang <zhou1615@umn.edu>
>Cc: kjlu@umn.edu; Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Peter C=
hen <peter.chen@nxp.com>; linux-
>usb@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: RE: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in cdnsp_e=
ndpoint_init()
>
>>
>>In cdnsp_endpoint_init(), cdnsp_ring_alloc() is assigned to pep->ring
>>and there is a dereference of it in cdnsp_endpoint_init(), which could
>>lead to a NULL pointer dereference on failure of cdnsp_ring_alloc().
>>
>>Fix this bug by adding a check of pep->ring.
>>
>>This bug was found by a static analyzer. The analysis employs
>>differential checking to identify inconsistent security operations
>>(e.g., checks or kfrees) between two code paths and confirms that the
>>inconsistent operations are not recovered in the current function or
>>the callers, so they constitute bugs.
>>
>>Note that, as a bug found by static analysis, it can be a false
>>positive or hard to trigger. Multiple researchers have cross-reviewed
>>the bug.
>>
>>Builds with CONFIG_USB_CDNSP_GADGET=3Dy show no new warnings,
>>and our static analyzer no longer warns about this code.
>>
>>Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP D=
RD Driver")
>>Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>>---
>> drivers/usb/cdns3/cdnsp-mem.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>>diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.=
c
>>index ad9aee3f1e39..97866bfb2da9 100644
>>--- a/drivers/usb/cdns3/cdnsp-mem.c
>>+++ b/drivers/usb/cdns3/cdnsp-mem.c
>>@@ -987,6 +987,9 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
>>
>> 	/* Set up the endpoint ring. */
>> 	pep->ring =3D cdnsp_ring_alloc(pdev, 2, ring_type, max_packet, mem_flag=
s);
>>+	if (!pep->ring)
>>+		return -ENOMEM;
>>+
>> 	pep->skip =3D false;
>>
>> 	/* Fill the endpoint context */
>>--
>>2.25.1
>
>
>Acked-by: Pawel Laszczak <pawell@cadence.com>
>
>--
>
>Thanks,
>Pawel Laszczak
