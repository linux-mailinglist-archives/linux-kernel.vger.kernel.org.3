Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87275474821
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhLNQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:33:15 -0500
Received: from repost01.tmes.trendmicro.eu ([18.185.115.14]:37807 "EHLO
        repost01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230368AbhLNQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:33:14 -0500
Received: from 104.47.13.56_.trendmicro.com (unknown [172.21.200.248])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7F81510001919;
        Tue, 14 Dec 2021 16:33:13 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1639499593.138000
X-TM-MAIL-UUID: 13c6e222-a717-4be9-a1b0-faccb15f29d8
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (unknown [104.47.13.56])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 21EA2100002FA;
        Tue, 14 Dec 2021 16:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oajyihcOsaoOmlLrxrjIJeJVc0ekZkU8he/tVPeq8IsrseosR95i0+fM7BHySCLaHiY8UXCSUlnBm854x1h86+YVwAri+zyebHVz2ozeI5kYTEujtyeryK4YIrYYyktOhW9Yg/1+jcTGvBUSsrKALl8QTuOa/SWNnidihnI6AOaDkred0DT+TmSccFe4G1bS76GR6Tl1BxXtdhlQJpZdZKuE+pcyys8UqePI/54leI8p/9ADek5jPp9QWWSHLcDqj10UEXUDfCgbFtzD7df6572GpUJGp4CwcAL3x/duuNZd2UeMElroX9awZtj8tSnGbcQ67lhIgEWaGVAzo76o9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvVRJAZeugWupJM7HvjkWy7FV2ubfcmWh7a7Q2zOz38=;
 b=X9/Z3RVpLPOEcp1Ar7YeWh+6EfnnwHch/BAHOyv0GrPDQnDAIz44zZWjcueOc2tlcwDxZAdiHQqnyaBO1Tx9CQRUWDxOlPlJnW3qF6G8EAtOP5YKXAJSDCW3Js5SA3DZYT4V4y4xNmTlElZaHhiDEs63f5iZKEiTVh0Vx9ZYzurbn5/gJJlYPR8K5iA8erahALvj0Ikw1+T9kdwGbdM54vUVMHof6dEGpIvE0M60mYIcgRrCdY58FpY68mlP2XLgqpmE1mahR04xsbmVFF1SBfzzDlv5NeyRqQsF3Z9cWDXfemO6uXjhM4aR/KxcHo9iT6WDlqwyIboJKf/S22lrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Date:   Tue, 14 Dec 2021 17:33:05 +0100
From:   Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: [RFC PATCH] virtio: do not reset stateful devices on resume
Message-ID: <20211214163249.GA253555@opensynergy.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: AM5P194CA0001.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::11) To AM9PR04MB8415.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e5c0bdd-60f2-405b-53ab-08d9bf1f6b33
X-MS-TrafficTypeDiagnostic: AM0PR04MB5810:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5810EEAEBEB84F353CF840DCE1759@AM0PR04MB5810.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUb7gVbHg+ZS6kDRZOISyJIJXeuso6TZXs8ZmPhFHLE2dSbig25DUwtUC47nbxmvr0l3qXniMQwYV2GZ9Nn9TQOyZUob2lXoFfZ5iKaCo0z0oQoCuN9mtE/+1XpSBd2RaijTicE6+3nmbB0tOjiKPxHhYif6imydUEPQIiTxOzV3JiFR0HG+e0TDgqoqz4592eDocJFfgUzDTsEASPxiNo/xI8tmGXASJ2D+WTeJoL1kDxVvnVGtATXlKRvZXKFuwoIasRAVr49BxQLTFIMe8z4QJNukTJqdXLhlq8z6hQT++sq15iNn2iqOPUX0g0q6RnmvD5Ja98zWfECM8WHrDfwYgyXIOynmBeguOvjoI0X0T46SXQiX49lJwzhbBgLSmsGI1fetovMOKBYgOb2ysVysos01w9JFlf5KQWXzl6ygOXCXH3Xr2EAIYNxoRKuqX4ZS8HM6l5wExusk1Ah3Tuu6EGMjyC7jolvRJhcbyIq1bCXz9FtsY36K/t5gZwqZ+v3J/BlViazpAxO/wBYeHkGeF+lP39gngd+FBapFci990fEP+tKipd4p0V8yUv26Dyr+tyZm7BuzXAWbHMh91sgyBgru3EL7OP7SbGSvphI4aboV6Vt+5x1T1cCRW1UIZHcoWHyNjK0W+/uQQ52qRKPAhBBMqau97T6DmOFe1LBaNSr6182TGT18GDj8ZSNSrd41nsU85ilaNQxhEWTCYulflY33WDIr+LTLr0uXS0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(136003)(376002)(366004)(54906003)(4326008)(33656002)(110136005)(5660300002)(66946007)(36756003)(8676002)(52116002)(38350700002)(38100700002)(42186006)(1076003)(316002)(86362001)(66476007)(66556008)(26005)(8936002)(83380400001)(107886003)(186003)(508600001)(2616005)(2906002)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xBM3NvdEM5dWtEYklXa1NuSzRsbmlHNWtMcTNCMEtBdzFuUFZ3UHF5NnJN?=
 =?utf-8?B?aEQrM2RFaWpKNENxeHhta3lCYVl3SFdNK3RON0toSVZmRDdMeTlCMkVzaTg2?=
 =?utf-8?B?VEREdnBVVmg5NWRyWXRPMmRybVp6SWdDcVZ3WHdxaU5LY0J5ekllcHVXYU5r?=
 =?utf-8?B?OS9mWUhiM3RndzM4RDNhUjQ2T2JCMTNQMyswRUJyWXdtYXN4S3BPV1E1L0lQ?=
 =?utf-8?B?Kyt0cWN6bWxqSGZtNXY0cTNLTG1EMUxWTmJiZ1hPbCszZDRYdjVRUnhWRjJW?=
 =?utf-8?B?byt2WlNuUktmbGdkK1pnb0Z4TjZaWFpsR1IyQmxLOEQraGNGVUJhM29iRFN1?=
 =?utf-8?B?YVRNQlFKK1BxWDJWeUVSKzF2VkU2ZU9uYTRVbmpITTNMUVZrV1hJWERJQzhC?=
 =?utf-8?B?YzlSWVhXMktqMFRLbnFDeVJ6UndMS1R3RkQ1czhzQzFremNpKy9icUFSUE1x?=
 =?utf-8?B?d1VkYVFWQkYyUE54TS9XdCs0UDE0RHZkK1hhYzFHblMxSUZJMEdVWnluNG9o?=
 =?utf-8?B?UlRjVFBGWDlNcXZOSTREbjFaTWxXSUIxYzdsM21wNWVEckQxSGJJaStJZy80?=
 =?utf-8?B?MktENlN2RnZjeGkxU3ZhQUgvakgvaGJ3V0dybnUzdkJCZEpoc3M0NEJVYk03?=
 =?utf-8?B?cFE4ZXNjeUJ2alA5VTZiOFpuMUd1ejNFVTFKQy84ekVENGVZVm8wZjREaGZs?=
 =?utf-8?B?NFRVUkwwMUtnSHBNTUJETmFjTkZGakt0ZDQ1VGJ5ZldhU2dQYlFuWnhqMWpJ?=
 =?utf-8?B?SFNPdmp3c0pRTlRrbE8rSVpuVnJid2VVVkNxSkhjdWZZNTBPRFdFaFJBWTVz?=
 =?utf-8?B?VUpVaEZwNEJ4QU5rYVdsaTg0ZFN3ZTBFY1lyUmgrQnhwMGovVVZiMWFLNDg2?=
 =?utf-8?B?SXVmRndPQXZMUjRxNHhueVNXb3pmbHBpMHp3WkVwdjg0RTBDQ2pSdWZLS0NH?=
 =?utf-8?B?NVY3YU1QUkRGZVNPM3ZOLzBKMWZnNTRyYjZ5SDU1LzFtTTNubEtJaHlhUSsx?=
 =?utf-8?B?UWVlWlh6UFArREhpa0xPYkhrYXQ0RDNtTG03eHF3cFMzUFYzTlJGZTIzdnZD?=
 =?utf-8?B?RTVET1RoN2dNUkFqWUZEaC9XSDViMmtvenJ4Wi9tOEo3OTFzZlhPSXpJSDNs?=
 =?utf-8?B?enVlUEFWekFHejd4RGRSQlNUTjdFZm1TbitMS3d6d1FOVEdILzJSd3hDRmJS?=
 =?utf-8?B?bG5sekRhQTBLeEppaEk1elpSTCtZblcxMVlTTWhpcktEZm1rMnlMcDJqVVY5?=
 =?utf-8?B?eWNXU1FLVmhEcDgvWnpPWUZFanYySlQrSVRnZGM1NUYvVVhXaFpyYjFQbUtu?=
 =?utf-8?B?NE5PWlBjcFA4L1NQWDFURTFNaFRYcFF2aVNkdzFPUVFPRUVOMlNKYkpEUjJi?=
 =?utf-8?B?NDExQS9scDlIMnFQb0dheHNxaTZ4NXFoaHdQdTRLQmR4cG5JbDdCVGxNZmRu?=
 =?utf-8?B?TkpyT3Y4aWlXWlNLVmhaQmlMT25Da2dKdlFGMDJjOW12MjNhTHJKR2hyblhI?=
 =?utf-8?B?U2REdnF5cmJCL1NEQm03QlpiS1dmUzc0TXFvK1Y2Vjc0dDM3aE9pb3hYejNK?=
 =?utf-8?B?RmlrSThxcHRuNE5BZDNmVFpJRVc3bUNIcUtvQVJ3bjZ1QjFyVHI3OURwekVx?=
 =?utf-8?B?SWFuU0RPa00xZFo4UHBqdVVSNDVRVjArMnpBcisremQzVTVBM3ZKZVVQdUIz?=
 =?utf-8?B?OWMvbVcvQUphRUQ0NC9WdUhrc0ZrbUg3RzNwc0Z5N3E2NTVBbDJYb0l6S0Vy?=
 =?utf-8?B?cVB2bGZIWk1kY2FhVDV1eC9HcDVUemc4R01TNk5IK2NQenFkaUZGNWxJNlA2?=
 =?utf-8?B?eHdJT05DbTg5QkxaaUdMMXVEUnBTYmdlOFhrMGNJNm1iaEJKZ0xKR2YvaUVU?=
 =?utf-8?B?enJOaHhkNkkwSmpFOGNFYnlpQmhPOE0wSld5MjlaS2NMZkU5Z1VsazFiN05y?=
 =?utf-8?B?RUZuRm5mWUMrZlhQNmhMMDVWM0U1Mys2UGVhNlNwM08reTd0QUtONllzeVNr?=
 =?utf-8?B?WnpyMmhBQWhOTVVsZnlBT2RMWkp2WGgySDVtYnBXaGxEdldZTkpCbjl6ZEFZ?=
 =?utf-8?B?ZHkzdGNFb0dXc29rbHhvRitJMHdUOXRvbDl6dUh5WXdtc3JOMTFGT1RzMGlZ?=
 =?utf-8?B?N3lta0VCcDE3ZG90MzNxTlRRTFluR1lUcjUwWDR1Z1JuZVI3VGc1TFZJbU1y?=
 =?utf-8?Q?7TtFXUjGBh/MiJBOWuYUdyc=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5c0bdd-60f2-405b-53ab-08d9bf1f6b33
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 16:33:11.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTepdR+rUiPeFuz9gDgEFJ4y98rpjFldhKwCCfWg8nXmBNxnBSLnJCk06At7XDEkiXbFAbsBHF3+TCpbu8B7lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5810
X-TM-AS-ERS: 104.47.13.56-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26590.001
X-TMASE-Result: 10-3.141700-4.000000
X-TMASE-MatchedRID: py9qPmzeLNbK7XOHo8djb9x8Z0HZQbHVAajW+EL+laOeEPi9wVyFrvly
        aWpQNxU2RRHvyNamCiom8AYiyPTqsSIOuxx4sxXhkPZB3+Nsm2R6i696PjRPiAdkFovAReUogK6
        qCGa1Z9dTPjgJlbianPFNNy48ZgsSO5k/PxBAvv4gCPGiZqtI8GDPbOrcMjcJtkXnWdcKOMgJAA
        SM1H7bnOgc6mX1lwNHX7bicKxRIU23kKuphdkuP90H8LFZNFG76sBnwpOylLOYyStVapYsh99uR
        W9tY2CBlYaZ25COiKJXKBufOQOUJWGvpmtbVFgowL6SxPpr1/I=
X-TMASE-XGENCLOUD: 34f066d0-cb07-42e9-97b5-fd48ab8e9dcf-0-0-200-0
X-TM-Deliver-Signature: 92C2AADF7387D170F15EC1C14BD04128
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1639499593;
        bh=P+Nhb2xqhuL1PDHvTKFBFlOyIxhXfhOv8mH+cfrreKc=; l=1479;
        h=Date:From:To;
        b=PQU/rVZJcG1pQ0Z0Ch4PJqs5/SMpU5YAgqG88DS2rDJk1wZZIMolgXQsm3GByVCDp
         h/WiB66pikfsG/Gy60/Dh45Rrlpk5S/iXxlJrtmGZNF2+4hiDfaeTXircKJCt54lBS
         w9jw7Wj6pi4BeAlnJICSb1cmnG4Y5iTG9aKius9GyWrlszO58JY3dZRw4UySIhXDQj
         4j6rWXioisTVvuxQxGv0EW0gx3BkV1HCrt00FJuL+tpstwxD39rpb0wMRJN0kD1NKx
         OSjnnq8Qg5o/euMooOuRxmm1dYZEe3dPToCD/CzSIqhJcmzYJqjmLoGukrLDE07PGH
         JeXejWouT6fWw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>

We assume that stateful devices can maintain their state while
suspended. And for this reason they don't have a freeze callback. If
such a device is reset during resume, the device state/context will be
lost on the device side. And the virtual device will stop working.

Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Mikhail Golubev <mikhail.golubev@opensynergy.com>
---
 drivers/virtio/virtio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 236081afe9a2..defa15b56eb8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -472,6 +472,13 @@ int virtio_device_restore(struct virtio_device *dev)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
+	/* Short path for stateful devices. Here we assume that if the device
+	 * does not have a freeze callback, its state was not changed when
+	 * suspended.
+	 */
+	if (drv && !drv->freeze)
+		goto on_config_enable;
+
 	/* We always start by resetting the device, in case a previous
 	 * driver messed it up. */
 	dev->config->reset(dev);
@@ -503,6 +510,7 @@ int virtio_device_restore(struct virtio_device *dev)
 	/* Finally, tell the device we're all set */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
 
+on_config_enable:
 	virtio_config_enable(dev);
 
 	return 0;
-- 
2.34.1


-- 
