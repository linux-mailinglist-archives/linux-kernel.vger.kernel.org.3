Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA114D081A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245258AbiCGUCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbiCGUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:02:31 -0500
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941E8A31F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:01:36 -0800 (PST)
Received: from 104.47.1.56_.trendmicro.com (unknown [172.21.10.49])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 5D04C1025CC7D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:47:56 +0000 (UTC)
Received: from 104.47.1.56_.trendmicro.com (unknown [172.21.201.50])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id B76D91000008C;
        Mon,  7 Mar 2022 19:47:53 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1646682472.178000
X-TM-MAIL-UUID: c1e9ce45-c89d-4ba7-a23c-a578b9c5da7c
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (unknown [104.47.1.56])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2BC6210000E5E;
        Mon,  7 Mar 2022 19:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjR6BgDDy5BbZRfckv0kcyTDxk+nHa/zJYR8IMgw2A2lea0i/+7d1/fd1v9p/T0vpPtId+/nvVkWRlO8EGU0Z/sNo8h6LPLaQMh85737nWUNK0OPq4kkBwORk6TyR+34LYimbrK2bTQ4pLO/1o/J4c+d351EdeHE9e6qq4EojC3TWY5PU5g45OUPuvWtJZid7n9kbR8nfS7dAcToksn5us4iIGcRpojX0qbkR/yzJ41paZRv3oqtuwPGc/Wvyb4DjICHeN+CjwnqJ1uVpQuTKzUwQeIhD65n1I6EUgdbxMFYkVCX8ZI1nXf7rBwBgXnrB2n9DrPsru3+aTfD99rtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjUPToFh/OWDiTxKWHg9wYdliPJQ9jNn4VhimQzSkQE=;
 b=oBQZWnCwvhRBD+9oJA5/ygo6BnReMFwjUA/z997ToFFrCt6IiyzvB4Nuz75Px4D2n91syP0Aer5+o1OhH1nFWJLVB8sF+yVZTFZRd2bZ5FuacGKJp7gf+PxcvIcnBaDtiXo9fIbvpLv3V7SZXFpWQIq0xZppG4crNufM7HDN1g36KD4a+B7H0nb+g/sOeXL81s6tEduMX56J3H4J5LIRAq/y/iyiV28VlmIrgxpMo3DjVuOLSq6fPgMRJH1IQEzQPKtt8hGbNKDtwKCpHq3O3LEQ5HLz2aamCEzfc3/huSs8psRnXMZeT2WHOypocI+QyLRBBvzQKXGuS281lUKgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, virtio-dev@lists.oasis-open.org
Cc:     Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] ALSA: virtio: add support for audio controls
Date:   Mon,  7 Mar 2022 20:47:14 +0100
Message-Id: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR1001CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::17) To AM0PR04MB5891.eurprd04.prod.outlook.com
 (2603:10a6:208:12e::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a9c1d6-ea46-43ba-30bb-08da00735c15
X-MS-TrafficTypeDiagnostic: HE1PR04MB3210:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB3210E14B964F9079589F7E9E8D089@HE1PR04MB3210.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zo8YluaHGR4gKRjAaFNVkS/oFYDH/EEM1HpyXMOTUxgDvpJRJVrRbNt/toNldolfCF6d1TXCce/T8Gb+lP0/m6QcTbMHeP4PcRBUIxW0IgjFs/mzFC2lewtYFABsRdiFNDwgB1yWjqM1lpo151KRhUWJgAa4o/e4FBd7yy6ALiFboyrEdIpYfCxrEW+UmekHsEleas0S5508ILwh2x+epGMFE+Ff+HaxfFaqx3OcPaIj7F/9xZZMromUhI1ldW/KOq8Vu6Q5nKlYK+ri0SsdQ4U9rihjTaHL/PZslhqEing7hxWmxj9zZbAcT79M0nYcYQONr349+Ld5hE6ktuhvu+kyGCpckxl7jsqHa+Q2IMgWj/uk1PhAQ1KhtWj7cwJ3DwzqSjXXXDUSCRsWpgO8/6hvnFKiIKe1LfXg5gS2L/Iby9kkYW+rQwDPv5z8fnePaPwzSwZEVIY8coSL1rTm2MCWpEnQenjcR7PE3+7XKHHOC792egK7dbPXZvslvc5RpM7zkSyUgAiQS446YJ2tqFCNpe0EPWF9E1oPtKWumIAnpt/gxg5UEnkQeDblRMvnC9L5qVS/BsijlqRYifG4clALF+ZarSadb3OjF1SHD3Q+l6o1lvvBIL998OFoKHT2jRYlk6NmGMKRq5dDC+injwU9cs+LGrmsfO+nTb4CTbB3l4ac9sJhILQj3RIBx8WXbs+gQcGBhWB8Ua3fzMrjScZ1PXaznDN4hOGUla73+8aewjIfvFr7BxrgEjQARMQxVQrj/1fS6H6bUVciwDyeNFTnNrj0xkmvHzWDzJQyL6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(966005)(8936002)(8676002)(4326008)(66946007)(66476007)(66556008)(2906002)(52116002)(86362001)(38100700002)(316002)(42186006)(38350700002)(26005)(1076003)(186003)(508600001)(5660300002)(44832011)(4744005)(2616005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWk2K2NEUFhRVzZPYzdkbWJaazJ3cmZ5T3Uzb3lPaHhGcWhXQWpUM1Y5c2J6?=
 =?utf-8?B?eXdiR0RiWDhKUWdBeExDUVJQLzlidnFOaVNOUVJXVldVTUtkOGNVbnBrM3R1?=
 =?utf-8?B?VHZpQTRiaGdJMmdxbU10SURMbHhJVlhBOHJmUE1Pa0FXSFJLQ1hqWDB1V1o0?=
 =?utf-8?B?dXhaREVGQnpuMExHa3cydm9jRXp2Z2FNcCtCMFpxa3JEV1ZsckNxdGhwU3A3?=
 =?utf-8?B?NTBsUzVLdm5pcmpiOTFObzNaaUM1SGFaTmdWc2IycEtCK0l6anRxQXFmWis0?=
 =?utf-8?B?US83N1RJam1FT0I2bkNtQ2t0RFM0Ync0dkYrcEY5OXh4T0lrdjZYeGVjU1pQ?=
 =?utf-8?B?SFJwU1RJUWluZkorR0NSRzVIdVdZc0EySllSbXpKYWE5bXkyNXdCSWVJNUlK?=
 =?utf-8?B?OEtXNGVRdGZpc3VPZjJ5cG9ZWTBNRlR1ZUk1ejJxOWhWVHQxd3lRcEtFVEtJ?=
 =?utf-8?B?eGNnTCtOOXNHc1VNRnpQejdHbzdSTXRKc3hSOWI5dkdWand2ejR0ZmtmMmFx?=
 =?utf-8?B?ZjJqNEt1N1NYc0VORG81N0pLNmxNdTVzNEw2ZzJWSGxQQW85VEt6UXVUWlZk?=
 =?utf-8?B?RGQzVUV3Y0Y5ZzMreXJjaWpEdVFxa0Y0MlV4aTdMZ0F5cEpaMWhJMmMvL001?=
 =?utf-8?B?TWYzVmtGbWZRWFJKMVN4ZUd3dGtaTzdKbjNqdlAvQ1J1WSsvZFZIaXoyNysv?=
 =?utf-8?B?dlZqM2tTbEZaQnRsdkEzMDV2UkdvYlVzY2RvV0ZBN0l5ait5R2pqbUlnQllm?=
 =?utf-8?B?QXBIVHZFS1pEWm9BTk9MRElWV1N1MGFDZmdISTNOanl6STFuSUlZdGxLWmN4?=
 =?utf-8?B?YkZ6OWorMDYzVnNDbmUzV1ZPekRzVzRNbDkwbXd5ZlZBbDlRbndhYU9JM0NE?=
 =?utf-8?B?OXVhM0VJRnlpdkpSVmJhWUxBR2x4WnVQSUJaVmFVeHVsRDRFdVNlamg0Mjc0?=
 =?utf-8?B?TG9CVnNZUjk4K1k3bm10ZklvMGs0dUN2NFRHRmNoM29VQ2huRE80UHVMUHNU?=
 =?utf-8?B?ZlpsZi96Ti9BWXc0aXMyVWlDZG90a0w0VStkV1ZUaDlibHFDTS9MNDFmTnh1?=
 =?utf-8?B?WUh6UjIrcjN1WWJteUFGcDdSY29oUDVTUlJLOWVmaWM2bk0zZG94OS9nRytk?=
 =?utf-8?B?Z1RlQTAraURHZnJGUW1ZVXhMVnM4VklNaE5RNVlzSkNGeG16TjFxK2NmUnJG?=
 =?utf-8?B?T2dsL1loWS9qUm1VZDQ3WHlDOFBsbGZWNldBWWRldmhkeHJJVTZKL3NWSmc1?=
 =?utf-8?B?RzBKZGhoNGNSWWVmdzZvU3RsdEhPbzF3c0JNTXpVOWFqU0xDMGlXLytKNUQ1?=
 =?utf-8?B?Z2xCeVpCL3dHWTFMY0w1UCtmUnc4UGlmYUhtZHNRUE5qeFhMVkVHbUxKeGpE?=
 =?utf-8?B?U3NtWUVvWmJkemVQOU1xcFRrbTJUM3ltUUJIeGxPdkdubDVoTGVtci9EZjBP?=
 =?utf-8?B?N2ZjbTV3WVVaSDVCa1cyMzc0RmpGMjhSeXZ4NTEzRmtJWFBDVGo4ZngxTzdI?=
 =?utf-8?B?NmphK1hPNWJ3bVRZUWFMQ1JWcDlGZFg5ZnJhcXM0cnR0TGc4bk0xZlE5QSto?=
 =?utf-8?B?b201VkRhTzdZZEJaZTVNbldETjBMWlplVUpINFptU0F4N09xdWhEc1F6Tng0?=
 =?utf-8?B?bG9wMElXRWVOR0ZKQmxuTnFKcE5wR3RmeGtGUDhpQ2xZMjlFam1EeFQ5MHlT?=
 =?utf-8?B?VTNkelNXNHBka2UxbVlwd215L2xGQ0hsN0FKVXBMYVc3QUdsTDRQVEphZVZW?=
 =?utf-8?B?OUZBc3BPL0xHdFJaQ3FwdUIzcHdYWFVYdE1MTmIrMXl5bkRjVkFTZjZoZkIv?=
 =?utf-8?B?WEE4aFA1d2Fpa3pHQWxPaHM0UGUxbHpkd3dESjdpaURpaFcxcmh5aWlrZ09l?=
 =?utf-8?B?dlN6WXVSVytSUnhxeERsTDhSWEZxeFZxRnpjbTQ0ZlkrbGxFY0xhb0phazQ3?=
 =?utf-8?B?eHBGcWRxc1dmbzA1b2MwQ0hCMWd5aVh5b0NSRGZBYXBzRWdhRDRzek5FQms1?=
 =?utf-8?B?c0NNOEc5QTlneGZkWVNvc0l2RDN0d3NmcUNsMThLKzN2aElYTm5YeWI3UUlh?=
 =?utf-8?B?ckNURXA1bC9tRWtDR1RtdUZzZmZCenI2NkJrb1EwekJrQXI4RkxwNkJYd3ZX?=
 =?utf-8?B?cGh2enZiY3Fjczg4U0k4N0EyajZBRWxEeHRQbGI2cmtQU0crREs2OFllYnAv?=
 =?utf-8?Q?3SSe9+ct5YfbPa3owo+4t60=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a9c1d6-ea46-43ba-30bb-08da00735c15
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 19:47:49.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zv9RFFmTUgrF4RLeFn+Sf7GQ6v3DobXJgo6nyMcwV9AADR9o62EaO6GXQxwF/lV+WExHMNef4naOcTv+fYJKkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3210
X-TM-AS-ERS: 104.47.1.56-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26758.002
X-TMASE-Result: 10--2.784700-4.000000
X-TMASE-MatchedRID: 54gb2yeIOXQJjCNolxOpSRFbgtHjUWLyj0jXY9STMgFMotU/QFIFGxdQ
        uJNGYGeyepwUk+Mcqyzw9R28AIPLSN/K1ikJIsLOnVTWWiNp+v8UifIaLms/Arll+XI+GnGsz6Q
        Q8NT1Ir7gr0WZ6u+ypaEfeQTpODV8Wjws5pdLmBZ+yskgwrfsC30tCKdnhB581kTfEkyaZdz6C0
        ePs7A07R/88i/oAaosL4UK21n4bZNGPXbj2YgVSIYcCinNIrsbfq+djo4+I88=
X-TMASE-XGENCLOUD: 019a98ef-3284-45a8-8ac7-44879e005d8e-0-0-200-0
X-TM-Deliver-Signature: 7926671C3F134244D7B3EC49FB0C59CE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1646682473;
        bh=8okE+Q6K/W8wsvu5pO4GARMCWw8koKY+P9+H4M0XCMI=; l=1037;
        h=From:To:Date;
        b=Xr9xf5+6rjFcZ9mKXl6ltOIF7ur1l215X4n3eUBACyKmifXRur5CMqV9cdU+RZ2aM
         +t9XnWBnW4m0pGNtotsg74DGbcuSUSNHC3ciIhMA/V5LVc1v9wdP2tsg8FVHmS6NYX
         ab1iUaJMHRhpkRxZYTYASnuKKuNVtk6Hv4wuVJ6woPo+gmYrm2gNwtqRsuiKcJoqxA
         UiavIGn7dhM6scggyaFOLGxf5Q6u47IVLJyTd+oK3CVltlkIt8VrW9B75pkDEASh5w
         zL+JSdOyLUt9PzDvSjsQaeD4gY+VWHd4DmrNZS4RD8u8dLg0FfBYLineZIIOWk8PiO
         MYSGgRMJBBeqw==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of support for audio controls in accordance with the
proposed extension of the virtio sound device specification [1].

Design　of virtual audio controls is based on and derived from ALSA
audio controls. It allows the driver to perform all standard operations,
such as reading and writing audio control value, as well as working with
metadata (represented in the TLV form).

The driver part was tested on top of the Linux 5.10 kernel.

As a device part was used OpenSynergy proprietary implementation.

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html


Anton Yakovlev (1):
  ALSA: virtio: add support for audio controls

 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

-- 
2.35.1

