Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4115D464843
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347427AbhLAHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:31:37 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:31310 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344395AbhLAHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:31:34 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B11ulAe010635;
        Tue, 30 Nov 2021 23:28:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=nr54qxrzbmMmpKmJuo6g+BX+u7/XckwPMNV40NKFrME=;
 b=r8AkzfHVr1mJI1S8oq4JL6vGnTEDKyBv58P8i2q8bnLqoytGbHhhxUy7fDPzJs9dVCQk
 XePgJNZ9ATeWsFPdXkPHJq+ZkQwY9+agsc2h5WPE8I9NWU30EZot4EhS647EXhSW3gqF
 dnpDJp214tNgBAa92sIncgh7866H1KQewtChJURoY1URE97uw72po9+7oHVJaBU1xqbA
 MiOv1nAaCqELwraqVCuznvBNtm6YZ81XpLp6un5RjVJaZco8qWOJtiFmJPpxy77GUC2z
 B0y30sz5teehINZKl5HHkGoIk+pr037i5VVAO53LYVdwsBO5Sn/96a/GfZOXX3QK1Iv1 8Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 3cnkmvks61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 23:28:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RoxQc8pX0VlN5C6TEhwLsGeM9bj4FouQ5Gpi8HlPGlQhQ7HrDGBo4zFtuhZSbV7LIw4+l507B9RD24roBfRCQ7hyNdS6fj1Z2t5VgK6eLpDidlyYZzUYkn1lr3LqeiAVagwojOU25rp7Dff4KNzmdDJ/sbBjXGCT9eHsMR0/VRRlPlvgMluIkIGJy/BmSmEomlQA5BsIKWzR9qGk5MwyKMfprjW54NejOqMZmU9CivIL4/DmjGwjUKuAPGGqLBrhaE62edvrIU0oR4EXo8EJpFycRG+6pyAMORMelUQyzd0Jnfm/e4rP9I4DgW94rtN8FzjanNWqO/naS4BQQrUelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nr54qxrzbmMmpKmJuo6g+BX+u7/XckwPMNV40NKFrME=;
 b=l6gUvODsMvZWOX8IF/ofuhTuYhTtKpT+r1WvedxQyHQg0gyV8ZFU6i+ZT3FDXAxLeOIyBvX1qPcY6s7G+jZZClay+UtqdRkGNotkitfaYgooGYQ5v7yDZlCrYOIAgEPlxUo0ZwrWRpG5MhI3z++sXDV//QtIaNjSiOJScp3qbck84LrwExhmjPixIaI2e5S4RBl2LJOovPMdivaSVTxrPWVUa++vKDGLrWJxTKZZOBDIMR/N8rMJJJWT8sKAlPsDd9ZacHjFavjQhRpv1GHxi0wJM90rfCcd5mvaouV/6LQ5nwfttDp/uj67L2FAWjySqFxp6JrAYVQWSNqPd6uB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nr54qxrzbmMmpKmJuo6g+BX+u7/XckwPMNV40NKFrME=;
 b=fPY0hhPhN3Y4DXAEyLJQp1TtX/3tFZD5OxiyWPLgmLFNYKmK70eqOrhLCs3JxiaZM/4diQnbBKzZUuV3qLcWmuYqrth6vDMa+hqmrwKONVSbRb2NVYkt6qs+rnGpIBQMHrifJTBu1kHs3Dnhadwq6MGWZgp61xHjTcJN5RTHNbQ=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BY5PR07MB6546.namprd07.prod.outlook.com (2603:10b6:a03:1a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 07:28:06 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::241f:218b:e5aa:9024]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::241f:218b:e5aa:9024%7]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 07:28:06 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in
 cdnsp_endpoint_init()
Thread-Topic: [PATCH] usb: cdnsp: Fix a NULL pointer dereference in
 cdnsp_endpoint_init()
Thread-Index: AQHX5g+EScFJGN+g50SE4yK10NJi+qwdPKog
Date:   Wed, 1 Dec 2021 07:28:06 +0000
Message-ID: <BYAPR07MB5381BE5297FA4905E8BD40C0DD689@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20211130172700.206650-1-zhou1615@umn.edu>
In-Reply-To: <20211130172700.206650-1-zhou1615@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzdjMGE1ZjYtNTI3OC0xMWVjLTg3YTYtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDM3YzBhNWY4LTUyNzgtMTFlYy04N2E2LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTc4NyIgdD0iMTMyODI4MTcyODM2Nzc5MTgyIiBoPSJxYndtT2xRYkw3VWVlOVBmZlV3NFIyYjdIWWM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 903b1f6f-e611-42cb-8660-08d9b49c1e1c
x-ms-traffictypediagnostic: BY5PR07MB6546:
x-microsoft-antispam-prvs: <BY5PR07MB6546BE08858F36DA58F3FE55DD689@BY5PR07MB6546.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CrNYM0DWpqRm6XKc4rAKMPcUvfMgxucZH/U47HCU/+rIUpFMe/CnTU/sVA4sly5lB7R6n2e6/9eMt/uLLf+EMwhj5xqYRpL7isqzZbWtvwWVu0lj4+UiVuhNbcbNlxRkwBXYghCXTejqhddUlNMdGHsaVwy+Appz/cvCfpY2vYlK6y3Yvjb/xeM7UjkcFYN1aukGxpj2JExaec/DIQrhUa5+Ido9Y5Y8QwDm74Kmh5uX8KnKP04L+L+SUu9Rn2/aCU9wR5ICmmj6aMMNIdCiVE87Jqxunut1A0muzeIQAjvmn1cET1oYkwH3N5FK3pmeWKQnxh0SsuBcz9eF5FB9qg0cfW6KYDrFm7nplsmda43A1DlwYbCFef0fBE4Bbljoe2hEgoaEKqvS1FUyyWI+yOoHiWzIThWw2AJ2Nje5XxlHY4vIbIJBIZRWg8YmIUil0g4VdNoXoUcvXpeAvVIoXdxUTTved1eaRq616qpXxHTWO8vBzCQIWvDnog9savAHCcAuHAOTutm9fkk8+h795kX8cl8X6J1lS4r9lDNL2rJ1PkSU6bk7we7+2h3MyXAEJJRwPhes4hA0qOI097hT4s3fd31yXRAxASB/o4KkivtuW8JkhfYfyoDs7WMiP9csig9xgFY7a4euICLcslbTJvrPfY2mBNYo8Vgcm/OiimZUvjXzS5+XtcPpR8CbFQM/dW0u/vN+ga1kdBloP/DvP6AT7bMgk33FiXlkLk3beP2LADA3M9K4G2JG+OPHK7rQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(71200400001)(186003)(76116006)(52536014)(64756008)(26005)(9686003)(8936002)(66556008)(38070700005)(7696005)(66446008)(66946007)(33656002)(55016003)(6506007)(66476007)(5660300002)(316002)(508600001)(83380400001)(6916009)(4326008)(38100700002)(54906003)(8676002)(2906002)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mggnva7Wd9fTKVGv12xJyQJeBid+9kdRkDywQz8w/kCKs0cv8R2jw/4eaGn4?=
 =?us-ascii?Q?Ei8FOUAdHvfDkE/+ECc4EbM3DQw5D8k0Mo8ZtPnWJc0sdLVO3+7htjCq9x7B?=
 =?us-ascii?Q?EmQU/vDEcIULpqzm0n/DTq6LN8WhU6Apzjyimp/6a/GrZY3Muk8eASLt6R1h?=
 =?us-ascii?Q?NO5W7hNW3ASNUjqBqdpoIHc2QNYmkJtaBkPH7LXwpHZmWUml4gigJJh3URTd?=
 =?us-ascii?Q?3i/hSqERZG798hVP2mL2ug+D6NRmMfKjufMcYxm9RihfpmU478AJ1T8dnwA9?=
 =?us-ascii?Q?hMBVBHA08KHhtll8j57MpbmEOdXG2rYqGSO0ctstrbxROlghKv+AtZeytZ7p?=
 =?us-ascii?Q?NKnGIh8SsM0plf5TJ2sOujC3i/T2ugZUQmPawT7hvz+m2cM5HHyg+9k/pHDY?=
 =?us-ascii?Q?tYhFed3flMtRX+jwpn7w/c33M6KDFkco/TNXAJG2sXQQVMSwhQDxcC0pBuXP?=
 =?us-ascii?Q?33N7jRIgm8+daNqgT/f2ZrQ1q9/2PzEPFRZ7cUd3aPmbAnVGRdkuoAx7AU04?=
 =?us-ascii?Q?8l1aCeBmbYYhNE/i1YGxr5HOjP9HluydVJoLFSZCT+pgqoExJoRSVKHj0OFt?=
 =?us-ascii?Q?NeUc7RIvG1Dowsi0m7QIqEuMVvRbB9BnzAN96YiT80H/WuWdVQD/gx7tjXzw?=
 =?us-ascii?Q?yXhrf6RqhTX8L8w8d1y39iw7ToSrdiWC1PFrfCEetASdts/Z2FCVyHJxrkkw?=
 =?us-ascii?Q?Xws2hLEGfnoBwMgZ9orKllIBIJLJ3fbVXgD3ABedj5vP/mVEj73c1yZulKSb?=
 =?us-ascii?Q?iLtBBhkot52wXqQVnXZIOpB1yjZMZAu3uaWTtnuRT+FA9WsGIVPyVkFbEheu?=
 =?us-ascii?Q?+iDvoNyBHndUFNQF6s/vG7y8t/ddHKjOVFAHkVRXlNhqNWMV6wpo30EEyK4e?=
 =?us-ascii?Q?g+bhLJEQaIeik4TwPfIYMSXjELNpbdrhArctooniYfvEeBfzlaG4ZgDT6w37?=
 =?us-ascii?Q?VSBcDyUataTuYjGphTkKXgKreKHTYoyXU9Ri0ukPiCDOPct7Y5fGYl2rTwxX?=
 =?us-ascii?Q?vyJSdlXuLE26jxciZsoAJYWvhjwcJw8fKjdrmfUsA4aSORzLhe5yr+yLC/+6?=
 =?us-ascii?Q?ppaFZMQ8inFN8ugWpZEZ45otQHNi+JbsOPLfuWpqOMYSO5X8XjeCKAw2Zb1I?=
 =?us-ascii?Q?yM+wPJPFL9T0yTyXeFOC1jH4Ml+8uSGcNYMlyePykAIsYLJsRzj033jZkam2?=
 =?us-ascii?Q?i2rcmteT4ywk6El8zczgmfB7X+QGmB00kPtqF4KwAhzup6nxglj5cAO1mVG7?=
 =?us-ascii?Q?bLLDDxxao7g7uile/G0QiG9GE+eDduiG9z1y0QEbqM38pGqUY7uIyy9AQ4rl?=
 =?us-ascii?Q?Sayb22nzWS7J+ADuC1avQhTrExHODffFKO7agOdKdSAk5+Igv4+lOQF7+602?=
 =?us-ascii?Q?R6A3Bm1YxlDLI1/IZ4HZCoCfH1D46IsY+l9ucMK8rRKkA5VC0pg9nSE5I5D6?=
 =?us-ascii?Q?R0t/xlxFVfwbZG29XRL3aS+6MkgS5pHGOzmTZ7AqfzURxOLKBYbdIQS7GVbt?=
 =?us-ascii?Q?U0r79Sm8jwyYpHvdOeavBe4Pjm6XjXJ78vkVkJARUnxW+67W1wxRP1cq08kk?=
 =?us-ascii?Q?pZobWn4qJmb+K1YEfxRvgXGMi2gvmtRCWw0EAHc1od+OU9AuHN6u9BAb6zNe?=
 =?us-ascii?Q?/GwSrgIkzEdY9dVW8Us+I7mkZtoCtYx8PC5YLI2eb1cbCbN63gROI7itiNYd?=
 =?us-ascii?Q?tQDFxQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903b1f6f-e611-42cb-8660-08d9b49c1e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 07:28:06.0920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjmYK+bbj0MI+Z+UkZXI6Fv07YkN9WJ1zJey/rgnZxaeXBKW4dJTqo6Jzf9/XDQZ+NCNBRFu2Z01G0MoMAfhgYkZg+7eHkN/nvzP7rp5f14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6546
X-Proofpoint-GUID: 1nzhVR7F0MOTt2d05GEGu-xdiSRL2UVP
X-Proofpoint-ORIG-GUID: 1nzhVR7F0MOTt2d05GEGu-xdiSRL2UVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>In cdnsp_endpoint_init(), cdnsp_ring_alloc() is assigned to pep->ring
>and there is a dereference of it in cdnsp_endpoint_init(), which could
>lead to a NULL pointer dereference on failure of cdnsp_ring_alloc().
>
>Fix this bug by adding a check of pep->ring.
>
>This bug was found by a static analyzer. The analysis employs
>differential checking to identify inconsistent security operations
>(e.g., checks or kfrees) between two code paths and confirms that the
>inconsistent operations are not recovered in the current function or
>the callers, so they constitute bugs.
>
>Note that, as a bug found by static analysis, it can be a false
>positive or hard to trigger. Multiple researchers have cross-reviewed
>the bug.
>
>Builds with CONFIG_USB_CDNSP_GADGET=3Dy show no new warnings,
>and our static analyzer no longer warns about this code.
>
>Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DR=
D Driver")
>Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>---
> drivers/usb/cdns3/cdnsp-mem.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/usb/cdns3/cdnsp-mem.c b/drivers/usb/cdns3/cdnsp-mem.c
>index ad9aee3f1e39..97866bfb2da9 100644
>--- a/drivers/usb/cdns3/cdnsp-mem.c
>+++ b/drivers/usb/cdns3/cdnsp-mem.c
>@@ -987,6 +987,9 @@ int cdnsp_endpoint_init(struct cdnsp_device *pdev,
>
> 	/* Set up the endpoint ring. */
> 	pep->ring =3D cdnsp_ring_alloc(pdev, 2, ring_type, max_packet, mem_flags=
);
>+	if (!pep->ring)
>+		return -ENOMEM;
>+
> 	pep->skip =3D false;
>
> 	/* Fill the endpoint context */
>--
>2.25.1


Acked-by: Pawel Laszczak <pawell@cadence.com>

--

Thanks,
Pawel Laszczak
