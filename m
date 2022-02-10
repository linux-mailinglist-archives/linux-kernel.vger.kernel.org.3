Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062F4B1406
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 18:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiBJRS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 12:18:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbiBJRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 12:18:57 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B6E6B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 09:18:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ds9KRlNHJ3yha1yUMttc+yNJPrdyz2SAAd0xaBl6MU9hlifEKQXWla/JaLz4pRc/7G2lNIPqBd6irQCjkpCsEpf+oQMcmtp70/VDgEel92xzamQcEKGvkTAjZ7pvFdbr3DWzRcQn/OLtdvL5k3R37zlCvPre6KX808Lp6ihmQKdkJsMomdTn0AjH7hvFQFYc/L/td4n9kmwwp/JPFrBKEnbFb2X+wxSHkirsg2mD0NvBOohDoCZoyv2sT0ckfSEnUFgZ4GsDTY0HJ3qP/7mC8Oa5QKgn3fzEqOAWtoTAdWKPVWPvZW6TyNc5moeBAo8M7xMK8fMR0+UgDTu7WLaiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlOMkPIoNhWK53TWJSwVygN3xRPxUNlUChxtztQxkxs=;
 b=d3EQ33hIa8FPtPXQXABIGZE83v/okc8+ioMbvzV4KBKCBWv9gsEhpMzQh8Y5sYd3O60t+GBJC47OSYSPmH7i52fTv7q26UCfCCXOAyqLgoLQTLOekTcH0G9wjXEAetrUl4N8VNsAhHgTKt1pEBrFZRkf9kOzVbIQj5K/iXIAVXZXZxfKPRO5sh9xzUiP7sw7Dunc7oekPjVZweAWZ5onFGaYbI7j6uU1RsBSfdcu/Uwe/u6fK0M3mKwdVrYORJHRpJY6LM8i9RtuKtdUydOIlq4YvQCVK3ITIQH2bss9hLQX+Q3zM/gYRyFlraFbm8eNIN/cZwjayVAipM79SE00sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlOMkPIoNhWK53TWJSwVygN3xRPxUNlUChxtztQxkxs=;
 b=bu0X6OSCZIFXylJEGAb6PdkrbJN3VGAeXhDduG5Nkb46+ahOusKGR5UhSrAxN6mI239JwQ1/DUZ5/Ylu8Gs2ZQKKMbXxbC/O6SGEJKNKS//+oggnuLHTyhSeDn1QiANmldTBQAaMNJOFw/zB8Uely/P1erjX+g040Us1ZcPM48M=
Received: from AM9PR04MB8555.eurprd04.prod.outlook.com (2603:10a6:20b:436::16)
 by VI1PR04MB7136.eurprd04.prod.outlook.com (2603:10a6:800:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 10 Feb
 2022 17:18:54 +0000
Received: from AM9PR04MB8555.eurprd04.prod.outlook.com
 ([fe80::5df9:5bf0:7ac1:a793]) by AM9PR04MB8555.eurprd04.prod.outlook.com
 ([fe80::5df9:5bf0:7ac1:a793%9]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 17:18:54 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Diana Madalina Craciun (OSS)" <diana.craciun@oss.nxp.com>,
        "jon@solid-run.com" <jon@solid-run.com>
Subject: Re: [PATCH 0/6] bus: fsl-mc: fixes and .shutdown() op for dprc driver
Thread-Topic: [PATCH 0/6] bus: fsl-mc: fixes and .shutdown() op for dprc
 driver
Thread-Index: AQHYHPx/7MxTE5vBGU+39ZsO3BhU6ayNCpUA
Date:   Thu, 10 Feb 2022 17:18:54 +0000
Message-ID: <20220210171854.ktkqhbv54bibq3i2@skbuf>
References: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20220208145928.12468-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71b5a503-b6ba-4c37-6003-08d9ecb96a7e
x-ms-traffictypediagnostic: VI1PR04MB7136:EE_
x-microsoft-antispam-prvs: <VI1PR04MB7136C48DA13F50E48E9068EFE02F9@VI1PR04MB7136.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dXgWYknKS+GpuO/NdEH6Y/3v6vBu/OQ+nr1QQiuQA18tqIJKypYu1PPBWybYteItjs1CDnPinB61WH8UDY9eeKjWQ+4oM4L2BjEvh2FriVuR8i1pS4csZoJSFUYjd9i9KrhTJk6xrC9KqdISyHTrtltNC0c1ZUFb6ggtV/NNba7Whv0GOMxpgJgsLZy8HduZsK9YByrSyvekLtniKngozWF7nqMU4Hxii6FUMs/hA0TvG3NyU0TYD/SkzGo3++8Gi+4lzHV09PkNp77nr016b1sr+ih2jMQj+6mSv6hIAQ1sPUbC3Zdijq7BtPn3jebPRBOGnnGxwAKmTtLL+4PDCDBip/Xmmhj4I1KgcfillmvR8X2qDWzjR5Wz+92a+RJ7jMTtWxOd1J23hHuwV56Ran+oMipqGxeBX7m/6GQR+mSpP66tU6ftqyatCdnsWkJyjuZKdZwOHqcPqYmpJL90mmgCH1ZtMW0+0o8m6PkKD1lrsOzPc+yQnY0Q8isT/ZswDUb0VeR58Ai5aRThNSedR743/aCG5XNAVl09yWd+AhexA5Ff2h77iegvkcjY7m2oZbVMZvnGzsgF+IzhCH82YL0+NVWiTkUsnMg+u2CkphcAh45l9t7yQGwMA3EyMFgUTDYTuq7lh/ToEaHzoUgUS0Qzi1dMuWwxrVI32Msmx450Jyzt74BB3BTLhhiXFLE0PSaXI2G3lvnr1zLVJNDphCHmQiuE+pdq/c6XzoL2jEE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8555.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(508600001)(316002)(54906003)(38070700005)(6636002)(71200400001)(38100700002)(86362001)(6862004)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(122000001)(8676002)(6486002)(6506007)(8936002)(4744005)(5660300002)(9686003)(2906002)(6512007)(26005)(186003)(44832011)(1076003)(33716001)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8CyJhfuc9SlurH2blxBmmHWJ3N8XcVfi7pjoZiD1Zml4+oJowRC2Rfv09Cij?=
 =?us-ascii?Q?iBtaZdon0OR0TX0vXGzR0o3fRG9/OfEmjAERg4e3U0doYMAd9IIVHXFuqtJf?=
 =?us-ascii?Q?xkbmj0XqJCOWsXd+hKQ/Ix+25/kbieJYugCeskr5LYpRLRI6ESalIQIU/+N5?=
 =?us-ascii?Q?9uYsuNp2AWL51IULEruv8G7UmYl3280XnVlIIp2KbQLrEN1wiXqRVJlMB3Sm?=
 =?us-ascii?Q?DaAx4vPQ6WGaIwlPaLEfvgQRgjD8Iy2QnDiWTZy+w9GQS81qMBqsRzQXX1nU?=
 =?us-ascii?Q?OjhW3bqqP/ihOU2kULeNDA0jki1emjyyjOC9w44+AfEGpbVqXjW+rQsoyh7/?=
 =?us-ascii?Q?DWtDqhe90wSvUlPpg5qzzZ3NIanLbU/CWBWi5FSssLsNBgHS9AiINxB7AHdX?=
 =?us-ascii?Q?rIiSk2thnalzftVVGeSyy0WCRsNsONUfkJNPv8a9cBKnfnAlYnDMgjhWBeKE?=
 =?us-ascii?Q?dK5m8MC9DJ6X/QsjTr6Z6ZOvhC+242WoSjdBzHAJnU+8gx9hRr92J5QXA13V?=
 =?us-ascii?Q?CJ0fjJJ29Pafc75f4S+AhLUn4B6JiCu5TnORrpcYtUqqcHWVDRpvudl7kmMH?=
 =?us-ascii?Q?1g+VElFmSYCJSyQPQqYuBlTnz7EuMZzxXLx/P8WrYX0U5iOVoOYUVis3aEjv?=
 =?us-ascii?Q?Nn2ym1/Dla4sIkU5QbsebJdaFQhPTQaEQUgCYm+wn0RLqIEe2uDJgok8VyXT?=
 =?us-ascii?Q?bKQD/pBeiDpzb5ASMh2UpJLVqS9aozxx3JL+LvSjxEyPe7aK2jaLNmoUd4R+?=
 =?us-ascii?Q?kkxmTZD8ieVi7LOE7JHDTsGpjmcZhVnqEnMw2JJ1hnTKbmnbLegarmcxkWx4?=
 =?us-ascii?Q?i6Dk1qc13v0mbNzzxhQJlAtUi/0p87sUP88IXJNc4Xezytku09vupmZq8o3k?=
 =?us-ascii?Q?Q1XzMyN+tC7d/dHYOhzPDeDk7jOm3SxWUA+/rENbKblBVFGZ72TCtt/LUE53?=
 =?us-ascii?Q?PFwIlJuM8ALeDrxX7Y5wAAlgX8QUXBUc4T/hpeDpGjrxCesxWZQGxnRzdTWq?=
 =?us-ascii?Q?i2rQoG1qE72zmzxviMIWf98o9ajw0Hv5Dklx94HfeFuP9xcyod/H6slH8fUq?=
 =?us-ascii?Q?o5EtRvhqmvL4MtyvTX2bMWNIqmZtQbzRzOxQgRLPEp8nAZaGO39i3mI1C7bf?=
 =?us-ascii?Q?ysGeMcwl00U7cU5edQUXZQgtAxPUhRtoG1lIloRiyH0qDjSKGYgjwuNR0eI1?=
 =?us-ascii?Q?uN8858KlVIVhb7WUaGYUJcc8NoXYA+I0tpOD/ctJIc4HwjSShugx5jPlfreV?=
 =?us-ascii?Q?0XxKkAMY24Kzz0D7tNrqwq/36HXK6Ok07PjRmqm+4M6sBBcAjqRIoL9LsjBl?=
 =?us-ascii?Q?vDPGURN+0fBdBSqTDbihHA+LmOq+tM6J+UfXYrrje8bMdsir065Czlz+dB7E?=
 =?us-ascii?Q?+KxWV884YOV3h6pcnGg02rP9AWbPtlYiGHrl56FOjwIF3LAPOmx8wj/yAC9w?=
 =?us-ascii?Q?42WA+WLbsPtcrcXhOBrdtVFTBHYOFfJ05xzMHQuMNIITav56f2v9XOqjO27m?=
 =?us-ascii?Q?jt5s2cDrZFojcFjl/UQdFjXybvZ9RtdsT0vDJYaAk75AxlmzRa+/leor61CS?=
 =?us-ascii?Q?AXR7U1evxNFSGBuWAz5LXK5/tdSOnSVuXjQTrmIY92dXX/LYBuCd+F9ubrlw?=
 =?us-ascii?Q?uU+3n6DMx8bTtD3Voe4mJhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D42B6C0F12EB0C409FAA3803CE37DD6C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8555.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b5a503-b6ba-4c37-6003-08d9ecb96a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 17:18:54.8782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNZMz0dziIXxUj9fP1o3UEfjyNPNjBiGuy8HXZGF7RiQ26J+GpgJx1UtaziWS3fMwf0O1w6ItilPLqAkvmruYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7136
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:59:22PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> The patch series addresses various issues showing up on DPAA2
> driver bring down, fixing scenarios such as kexec, bind/unbind
> and halt/reboot. Most notable change is the addition of the
> .shutdown() op for the DPRC driver.
>=20
> Laurentiu Tudor (6):
>   bus: fsl-mc: drop useless cleanup
>   bus: fsl-mc: fix a use-after-free issue
>   bus: fsl-mc: fix double free of the root DPRC fsl-mc device
>   bus: fsl-mc: check for null irq array
>   bus: fsl-mc: move uapi misc dev create/remove in probe and remove
>   bus: fsl-mc: add .shutdown() op for DPRC driver
>=20

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>=
