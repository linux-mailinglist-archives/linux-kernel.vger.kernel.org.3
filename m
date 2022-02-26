Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234BE4C56C8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiBZQVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 11:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiBZQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 11:21:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DF91E7A63;
        Sat, 26 Feb 2022 08:21:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aozd6/efbvEPq+vSn3LldptDmWo6jw8iMR/TSYFCURJVcQ0wFIfmZpItibfK0gs9hX5SyGAEorkxVNJgSpFJSeh+eDizrBKLqslicMlEbtaOsy94aU2oSpjuyCf6jVVJ1rHNR9daFOtwPi6iBaYDmvBOZjlH/XwSIYYt2BayzIy0PXpFRXWFmcm1hM2s0gl3xdq4QbV5TygQgjUYXuGfmef9ncJy/BXnTjvX2iM2qmfDEkB5G+noHYcAJjmcCU0p3pPpE0KwnNpVBSPp6Wk71NlkLWBGNVSi2D/JxID2eA9GntKvMQ+djKPde768aP3tqyzaQxu27r0XeS0+Tgh2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk0odrzELd85C1eaS3t0QYb9eC4EwJUTlWIQSXzvsYI=;
 b=GdyXGOElm3qYNn3g3bVM2py3glBA6zVlUwyvja+XtmDweFnVs4SmgQ8OflCJHCNd3SRoGJ+H8M89kuPYV4HAP1Z0a1K3vDL7zKtJrdOOFIVwih9OK1oQN3v30zBqZ0zjTU4hVjm0KV6qCSGMgxolbPZy7SatfUX250poh/AivTs7KVP8DBDSHn8sn+3POCJajS4dq+qyf66ws8hq3hLu1Ay6tEKVYaLbIJf28cgZjH8yquL4xgiZIBFijo9qwgJJlkbUjR7qUeXveJHZ0H4pM/CponApU8pVOhTKc9IpLLCRbJa76gZp3qJXFdEv5mwu/wdEMJdwXAl/MVGCOekdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk0odrzELd85C1eaS3t0QYb9eC4EwJUTlWIQSXzvsYI=;
 b=tuk6bSDQIgoqjQhm1LMIlWKyFXaTHfDKI5/3aS5JkcbE2aNeQbzfyFNH1XGlOWcbX4xKKAkWUvCPljv4uakPfqxFZbdUxrkHtDYtUHFtfiNAEB435zaJzwV9qB3AjreuHLvYcLeGZXav6D56AqAqHVAQJz+frrklsKfovwnmlglgIvfkZSurQudLRwWz1mnuNzS0vMQvRU4irxo8ve/lIYyB5sj6/8f9G0FgHYFOrafxPv3auJzEUgswMc9cT6J7VU7qhf0rYKfFkgtNNF3JgZruvAPS6/7+w/5Z/QytBl94SjNLec1GpwzIMKbjxHaI5/FX+YTvqP6PYC3Ye+oLxA==
Received: from CH0PR12MB5089.namprd12.prod.outlook.com (2603:10b6:610:bc::8)
 by CH0PR12MB5281.namprd12.prod.outlook.com (2603:10b6:610:d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Sat, 26 Feb
 2022 16:20:59 +0000
Received: from CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860]) by CH0PR12MB5089.namprd12.prod.outlook.com
 ([fe80::2158:bc32:112a:2860%2]) with mapi id 15.20.5017.026; Sat, 26 Feb 2022
 16:20:59 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Topic: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume
Thread-Index: AQHYKhd7AopZ8pn1EUiip/DzNcJli6yj/JuAgAH/8D+AAAgX2g==
Date:   Sat, 26 Feb 2022 16:20:59 +0000
Message-ID: <CH0PR12MB508950A481EA325581A94945AC3F9@CH0PR12MB5089.namprd12.prod.outlook.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
 <20220225071506.22012-1-henryl@nvidia.com> <Yhied+G/K8MndRfk@kroah.com>
 <CH0PR12MB50897BE5D8841C27DD769580AC3F9@CH0PR12MB5089.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB50897BE5D8841C27DD769580AC3F9@CH0PR12MB5089.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 7da19dee-a09a-04c0-cf1b-b3089b2e16c1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5514dfe-9673-4190-bc34-08d9f943f9d3
x-ms-traffictypediagnostic: CH0PR12MB5281:EE_
x-microsoft-antispam-prvs: <CH0PR12MB52810FABEE4A8E57C3BAE44BAC3F9@CH0PR12MB5281.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5l7NSsGQKbRgy94U2Zzn2zpuAbPz7mLp+S/L3NItXe4CuJbtlrEhCz/b3cULHFxnGGw23vNwwQdbNkLTHCZNnuqmYfvDuEvyIGLJRs05yURu2FsEPU99AD5+kFEDPUr4lkCPvgbiyKmi2ylwj8nt7m75kOTjlFMWCXXu425VLoF4CAcg/2NUc0gF064WsV4MZfBZuk2AXu4/CtfuyWB8a2r3TBsQxa9xA8MXS2GhCp2bb3hsBz/oNqkkh7NWWjI5LP/FNq7IfYaK2sII1nJ5aiqxSWyfqIcPR8JYyJMoQmpR2HPhrgxlAZuX2IHGDfw+aD7JKiqVGnr7tMkXsumqmLSF4Hyh+1E4MFHriBhRE0wlcfUY2FeaL099Y4P1hBNncgmlNEASz0RjEOG3c84TAL2rO4Sm1w5yIRe6yugnl1H/PB1j8HjOwY0t7Lrnsdrt2bSNssEKZzNprP2sInVNTjPMqQIRGxGSoNTjwfABu4SJneRi9GZ1o08j5kqgzQKed+/frG4vfY6SfVQhZY9omAdOXD487eRfANZ5l6xeQeeu6iyOg7ZkLchxlTNxPghQi26vSKqIdKkRtWKIihkYhkm0cu4SBH2XlSKkQRL/Eel50mIxYIRr1xibDTb7l//ZYz9Uap9Xdswrb1wt4cwIvsR/k8BJyiUb81rZ8bxcbecfKNKn0nkTn3zNagF5E+dosS5+swuAiwFggemxm+YXzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5089.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(83380400001)(64756008)(8676002)(71200400001)(91956017)(4326008)(122000001)(38070700005)(9686003)(7696005)(53546011)(6506007)(2940100002)(2906002)(186003)(26005)(8936002)(66556008)(52536014)(66446008)(66476007)(5660300002)(76116006)(66946007)(508600001)(316002)(54906003)(6916009)(33656002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kVvIPL2SdXHZ39rgn9E8uoZa7Qwpft9YqnxlcibFU2LRdPI9ges1X+fyAmBU?=
 =?us-ascii?Q?qLV+TAS3AGStBTRBkDRcwogCGjc6R3yqp9AMyHbjyfbvU9MpypwjoXC+v2kw?=
 =?us-ascii?Q?6uDq7S+6krfRKXWx5ZP855ERtt5ngARQPbD75m8L96JYN+PXnW2C6FD+1owt?=
 =?us-ascii?Q?Wbi7UEjKFKVBnm0xHrCzfFJqLyKa14BBeE7WCJXSjcsrPQTYL2vmUSkDTbZJ?=
 =?us-ascii?Q?TgCjtQDXcUHOVFN0tz2oIwvLlbGBNremjip/jvUhgXfASfsh++hucmmToDXY?=
 =?us-ascii?Q?Axdq5hsK3dsLrqKsPq5khjJtOsSp9rmJwiaxsNipOa/e6+IAF9aBKYhMpYzO?=
 =?us-ascii?Q?RhK2zWzDpSd7rFHd4X7lk57ZNOXVAhB+k/NKmZxKhCClSTRZqpwSss5iFBLi?=
 =?us-ascii?Q?Akd7aGYrRcK9YUy9tISxuf3WBNDEkypzpJx3MNFegGjRlC3u9LA4c5VBEJqK?=
 =?us-ascii?Q?eSWg+jeBdt0KFM0hpPbsaZhgQc3MXn1m7RkncAOSLCT6fZL6KbTHzen3K4+3?=
 =?us-ascii?Q?hfOomCwrsV2RSFeXm/JKeGb7SYo8bX2zre9AKtzRRLCxD7/MVoZ28Ct+PWIO?=
 =?us-ascii?Q?jBfmcwKRhHtl/QfS9tjLXMCEsyDlc/2oGdUQfyPOUjI2F1HZ802pW4JPklgr?=
 =?us-ascii?Q?rS0rv8GObphSvslLRv2AQXxKBnaA0C+g38zehp9shcuBz/LagfinXhZqln1V?=
 =?us-ascii?Q?PzaZYg9RGinLkzgPel4WjvuT2cLZsVTEqgDRmSSlrtE/5rVnZFbyfrHenh9c?=
 =?us-ascii?Q?Uq9sqvGUgOldwnYlHNqnz3Kwzw+w5oDL47OJAA0Rm5iph/o6B78c13tyJvMl?=
 =?us-ascii?Q?LGcFg+dQ+yU+hdL7B9lVK60G7aULFv81harJPaqf8CMdeHzabb4B1A6kO9lh?=
 =?us-ascii?Q?/TYPMKXeC8pIndjUl9lQGUENKS4G4myibK8xahTsLQCSmlgH79FYrkCJvszQ?=
 =?us-ascii?Q?GLR7KXDUFoOASP5Cm/3zzD15iB3ZXRu/xab+CHIeypCwg91UgRC0pvZqKboA?=
 =?us-ascii?Q?OxhIkTdY5q30aBX6TMPIOwUUaOK4TBiGnMK94Bp/HWTABS/B+BbMHE/mOFaB?=
 =?us-ascii?Q?J9hAJYbo+FEt3kB/wuiZ2Q4fcGgMKjEvHtfVcBriqhcSmm4WcSi7fXrfeO3F?=
 =?us-ascii?Q?w6iHF98uSempHFwSpYU6tqHdCUey08wsUS6ZO9UfJVsP7UsUKCCMuQ6FOH/M?=
 =?us-ascii?Q?Vexv7kRGfEXOkgaV2omLVJV1zOMGVnj+3Ch/tJ9z/AwWVVF5K+2Qt5Oom1lR?=
 =?us-ascii?Q?rWdJAR7O3OE6W75kQhaoJBoO51tsTRjMub7SlOYErgfw0CrLugYc/ZazQ+TA?=
 =?us-ascii?Q?aXkaUdN8TOz82fD60P7oBuuVD8QhXR1QNNv6H7NACFKnq3AX+OfCBbXn5i/L?=
 =?us-ascii?Q?D81g883WogheH/e0VVW3lIJH7elbD/TNlBVC1+uZHK1NykpEIlY6kM4DmLq7?=
 =?us-ascii?Q?CMpHUI/h2khu+1dwG/tg580ERxm0Dz1hb1r5N+/0LYVaMvpIBty0mAVD804O?=
 =?us-ascii?Q?Nvlg//TLx43S69wO1xWxe4ApAaij7a6jN5w4SC76On8RSTJYdhLsxWhe+1B6?=
 =?us-ascii?Q?WabahAC7MSoaHiOgxRh7QHDNtUncch//TEEuhX2b+iVbhGyVHKTo8uNOI4fC?=
 =?us-ascii?Q?qQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5089.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5514dfe-9673-4190-bc34-08d9f943f9d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2022 16:20:59.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q0ooALH17D+ehoxG9rjMUVNxojxQA/9IeCMahcdDQO9AluyAAb2YV5ySpg37RBvvJKjcS72oPM/iuO4Rik+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +                       usb_hcd_end_port_resume(&port->rhub->hcd->self,
> +                                               portnum);
Tab indent is broken in this version. Will resend this.

________________________________________
From: Henry Lin <henryl@nvidia.com>
Sent: Sunday, February 27, 2022 12:06 AM
To: Greg KH
Cc: Mathias Nyman; linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xhci: fix runtime PM imbalance in USB2 resume

USB2 resume starts with usb_hcd_start_port_resume() in port status
change handling for RESUME link state. usb_hcd_end_port_resume() call is
needed to keep runtime PM balance.

Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_sta=
tus")
Signed-off-by: Henry Lin <henryl@nvidia.com>
---
V1 -> V2: Added Fixes tag in changelog

 drivers/usb/host/xhci-hub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index df3522dab31b..4a8b07b8ee01 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1090,6 +1090,8 @@ static void xhci_get_usb2_port_status(struct xhci_por=
t *port, u32 *status,
                 if (link_state =3D=3D XDEV_U0) {
                         bus_state->resume_done[portnum] =3D 0;
                         clear_bit(portnum, &bus_state->resuming_ports);
+                       usb_hcd_end_port_resume(&port->rhub->hcd->self,
+                                               portnum);
                         if (bus_state->suspended_ports & (1 << portnum)) {
                                 bus_state->suspended_ports &=3D ~(1 << por=
tnum);
                                 bus_state->port_c_suspend |=3D 1 << portnu=
m;
--
2.17.1
