Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A853DE31
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 22:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347241AbiFEUiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 16:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiFEUiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 16:38:02 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2035.outbound.protection.outlook.com [40.92.53.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9656DB84F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 13:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxmpuXc7ba5VEViMJUOTI3um5HBn1kh0VXbaYtqnU1Gs0sghDL9Hu2b6IlAfvcTsUO8g5CopnpTSPGwb654R7cFfng85lDAP+CPtZ+BsloMfOpjob4diZ9NIdgzpNi8fM7nfyM45UlyoMJmkHjq6x0zuq8ub6Ja8F/Zs1QNpOVrBBuVaWxw1FnB9dc1UXyxhda21qBVdU6x2/TGtE8c7fiIjF/vKMZg2TzSxsf69Q8juaLpahwsRVb6EMr5Uh/1Xqw8XE8uBAg3ieHk/HZrNxixju5iUn7pVivYPnwlTWbCHeGhiXEVaLHOYBHQOq/Gvc4wYJcqR+zoz9CW4EABrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qills6z1f+1mHsaAB1WHPe5XPwGcXFdtFnI4bKjUPMM=;
 b=j5rNCTHnkxa5H/gmaX3yLUCpkClYC5O8fZG+sHKG3fShzU6QWZRqW/v5hZ/mlh1HsdQ5PAOIBEzaYn+ozlV5HiWjcn0d8ZRqBSC+QZMTGXQOKvaPqdGrAnRejztYx7kTtCN1c22UobJqG+Zs+2XZyZDDTkWGdQsxO8cceHiw0qWbamPjk2XVmKeHfoQU/8MzXYZhth2LqO+vK6snjEO3he9DVJ+/lQB3k8B10YpYkJfqvd9QbIVoTcKJjROYsE4OMwc1ZEc1l8mX+iD2/Po108LFjvyoZqifDJKd/BhqrsksRNQ/PXqQn8Yzd74xv5TvA1vKL7skwGuYYmHquoTbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qills6z1f+1mHsaAB1WHPe5XPwGcXFdtFnI4bKjUPMM=;
 b=pyjykIOh6EmOnZ1MvICWTBlzJVZuy2RC0o4BXbL6iYARJyiiOVtutK04xJ9nqW+0aUUTE67fUWdHf0CkRPsOig4mq8+D7u98afz4/9msIF0JQo7s37JG7z17GZoVI8N/mnBQyicGSuODntU73f5dLjauozFSoU4IOngAVWAY0fGwudur7Sesq6tVxH+d9FuzJ8B8O4IxNJecHn8QlMkdWrwayK53r0sUy/5Y2GSXPBzWqNhS+pKNf0qKunkTsClDlMuwvY3PQddQ6l074mw6DPoVTec8VBRi6wUrHTZacn0itXuo19ELxg8yQvl0zyGF1kGL4L+QUVdLtRfY3m3IfQ==
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23) by
 SG2PR06MB2889.apcprd06.prod.outlook.com (2603:1096:4:1b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.13; Sun, 5 Jun 2022 20:37:56 +0000
Received: from SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::f5d8:bc06:d3b3:ec06]) by SG2PR06MB3338.apcprd06.prod.outlook.com
 ([fe80::f5d8:bc06:d3b3:ec06%6]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 20:37:56 +0000
From:   Ning Wang <ningwang35@outlook.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ning Wang <ningwang35@outlook.com>
Subject: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI TiPro7000 SSDs
Date:   Sun,  5 Jun 2022 20:36:48 +0000
Message-ID: <SG2PR06MB33380A046A4E047A37B1153CCBA39@SG2PR06MB3338.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [G3/v4eLisil6Ln3vaNrBFMWJ6/xrdrnBxBC5EPqPEmA=]
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To SG2PR06MB3338.apcprd06.prod.outlook.com (2603:1096:4:97::23)
X-Microsoft-Original-Message-ID: <20220605203648.2834-1-ningwang35@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68eb1588-4c26-46b5-a18c-08da47334545
X-MS-Exchange-SLBlob-MailProps: YY3vQ8PrltJLNjumVosRLa8cXScuVLz2lCNqfkLeCpkm9pHHiphSyqyllYO7eEED5IqdPYfUn9Z42dPJWjYdlXlAVoPuTflbNQC+65a04vSO7Lw3mdMSEW2pdi9u4QUnn4sMOIffvG9hRq8xYlM8x0uD2JUSG9FsBoJvoCFJGCyAhTlcqLU/GUa5UMbzdFMGLnhntuhSSNQThHZcr3dqPi9bVFDcQTvIo6iE5d5jzW+aRj6iu/qCZ+JLkrnib0yge8/boI3izsPU0XBf8QDmhti2OE05bzMaS0QdGktJZLNgTYgc2ZTz/ilw6wAJrssRh/z7WFAkFLZp3f9hwQDJ79XDWCNqmmfnmQuz6RG9k00TCtGDsD0n5TMa6/uisGr4sCJ6OWO7KKZuGFfGIOBHo/0myLy6RwHD9TxPO4yHswGZkP1xvyJAqUxD8SMJUljb4n1Tc55zTzLpxm3XdTHCZgEbf5VEXzhkAXUGn5hmYv9Bjy5ph3X7IyEzT82P0wOLVsoJYDSalKNZ9uybiRQH/3jLz3P7wK+eJ262akdrQDfUaGuP78UzmB5koPW0tXQKKVxXF/0aKrSomDvY7nX8aZs1rpPDcuDBDMiDKnn2symOGRB2FpleQaHJg1hBT7vwZlmzRODHHF944S5wa0Qp+E2zqOKc1/Yejr/wuH7wom9yLmydibsIZkXaNmJtAfYHrC27IS9YzJfNPV2F/uiS4NlFFV2+S/NGxpfz9xgM713lttY1lbFfCQV8Ooh3KhAB5amInW35Ofqt6iaVV/aN/1czcTehe0JZh1PHVLMimFd/aOS13FWmgJ3yhTlEtbU2MdSNs7CDJosb4/BZFZFyb2V0KMQguvarkPZDl2fLRsZiZST6cVeD25k9516ADRxi
X-MS-TrafficTypeDiagnostic: SG2PR06MB2889:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaqdTJeHXumwETz1YEuePskzBsHNs5vUHgDq4I2ogQDsUX8pXvQrlWRTY9atGwH0PDHLCJv7xHiI3do2/tzABWQgbhdctlWxm2KhcN0uw+ngQg6Ijep2jQuMKLJpUVvvjYiTY0Guk7n1JdJaoXhHof8DZQIGueYWEfld5mzslvMzHESCKqq7ZVRnbQhfnsQRV7Jd2l4fryImogYlFumhBwHUFEmslQH2cABbF2nCB9Cepkle6RMANxJv3HnzA6c6VdbkQIudYiXuyJRk0VTO9nX+mAE+gjjlsABnoCLSBFmPIkOYf0VfwQK/M9Co3rO3Vo0iewdK0F9FAe+Dw05TwKmw5pKsrfAucuSwVnKdNRvq/qLhwQ2v9EcE3UC+ZAJZ2nvdPhigNbjCHLFavTlgNyx8+Wp+ceLwNkwuPa7zVh1c3CCzFWRA1b/xrO7xFaCWrUdmKY4Bg6PJW9bsebDWCqCl/N/6a/9XC47yyCoWvwiRrskcOurABJkZ4ahWwQ6KSOBsjLOcEbGbID/aWyHXgePK7Fgyea/V/MmlYHmkjQSA6/tpMiP8GxOa0V1bbeH8rUij4YrwMay9isMicy+QyMSQmhSvV1CgoF+SUo2ejX7lcxJUOcPTHaWPGTazeIu/SC2xuF5mtw9E2t/3uQbqabXOG/r5VUOee80TKjCrCEo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HMN8puPDajbhIolj5AvmO08NUXUOxWVZGUz2L7O9jn6md4CDm91m/8TUtvr?=
 =?us-ascii?Q?PEM2MkO3dyVhc2MguhuA/kayQ5EswtYfCR5DrZYTb8AiU727b9yu168X0x+K?=
 =?us-ascii?Q?0dRRMZj8xKz+HxOrcD6/NDFgBR9VSQwrvgGdVNcZ5Y7sFSVMtTeZO0Vt/AfK?=
 =?us-ascii?Q?ZTKTiTuKEM8Tfkpa2oph21Iey5gLNemOKjoQw/R8QKBxRTuwWZe81c9lskBe?=
 =?us-ascii?Q?zWnLDaETvKQql9nywMGahsGjTHvD2ZhW46iB+f9L/V1Mi1QfSTN/jmdmPgTN?=
 =?us-ascii?Q?yBbYQMSI/HxNYC2ZZ6TrPY+QJ+NMsNzDH9hLQdvSMyViwmjJVFOMQtNN9Me1?=
 =?us-ascii?Q?HGaH09OYBYtuzfU3mccM0HigpJVlBQME0LSbjdfenXMtbljVH06X5wIV+DZP?=
 =?us-ascii?Q?qOy7Dso6/RNAU0WJzJful/7MIbR5cRFRK8Vb9DwVZo0A9OAYhjwOXxX/U7qf?=
 =?us-ascii?Q?t3aA1zZgJWRPxuEDM4ItIEuX1oHMmkhhQR4l6IGc3fmY8jTbYbkaseB5mspk?=
 =?us-ascii?Q?xFgoT245VO1/q7OU6ryBe85YEcGDmeiN24HyOEemYXcl7Og/to8hAYAZ3MMf?=
 =?us-ascii?Q?Dmz14em3IPeyZZc2/7sadlKmHk8vz55QwwgqKaiYqQrp7CCfjlzpVtHVhwzZ?=
 =?us-ascii?Q?a2UPBRaYJ/bu8Xudz7PoEO3nSGQRYa6wwGtFbR0mYV2qyxOJL9+iGk+ECObK?=
 =?us-ascii?Q?M7ppuxmHVfTaWQjvhZ7xL/IwhQlL0VlsIibYMSuD1r3/8PChiW/HSXMRJ0Ta?=
 =?us-ascii?Q?Kcp1V3yi4qbWUhewGZymZ4SRecN+B52FwoPyLqo2QSipB9rjmzuLr68Hrio/?=
 =?us-ascii?Q?l4XBFn/8LBPa9y7++/OmC6fZJrwYWnPxDTSOKdMsyOwK9DrABe7YxCyfggVH?=
 =?us-ascii?Q?2wWWdL8MU94DN2v8BBRqsS2eakqZAceJ2MF97QYwVG69m9YansvWBsfJnbYh?=
 =?us-ascii?Q?WZ3JqhUibO1AMOr4kt+cy0uYlvs3Vjt9F5lsm7+vecLiNXu0YEhnEKA00a/B?=
 =?us-ascii?Q?0KvbPSJgZuYYWbPhWt2U+f5IQaDUCrpmNXe5of70YQgceXyUyFO6Jsf7XJQX?=
 =?us-ascii?Q?VpARMJKYAZIBKvtlhonU7AmGkmp8JD58irx9o8mAdlZwotaOuYK13Jgs9gvC?=
 =?us-ascii?Q?fNj8PxykYm4EGfH3sACHh8FA8rs46HvUaH/muiSq9u6H85z9q4z7C417F8NT?=
 =?us-ascii?Q?wjyexL5k+z7KlJBRa/XDQUPB7oGXO/dsQbDhTopU1w2jWfsvMpt0Ip5hI9WU?=
 =?us-ascii?Q?TwamtdziOPU2LFw1s+Z8UOnX655eFa+agkZAr7R7v7FHRlMfp2bjV5qDEhtU?=
 =?us-ascii?Q?8zqb7pe+vHE0jLOF6FN2XwytZkXgmboOczmxSFeFWBuzRGQalLej2lSoo6CC?=
 =?us-ascii?Q?sR9ucyRWkAsentsUvcVZs27Q+EDaYSmGtJrlsSOkJ102NColkDYSwJ0uyOTJ?=
 =?us-ascii?Q?q+e2cgVkEp0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68eb1588-4c26-46b5-a18c-08da47334545
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3338.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 20:37:56.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2889
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ZHITAI TiPro7000 SSDs entered deepest power state(ps4)
it has the same APST sleep problem as Kingston A2000.
by chance the system crashes and displays the same dmesg info:

https://bugzilla.kernel.org/show_bug.cgi?id=195039#c65

As the Archlinux wiki suggest (enlat + exlat) < 25000 is fine
and my testing shows no system crashes ever since.
Therefore disabling the deepest power state will fix the APST sleep issue.

https://wiki.archlinux.org/title/Solid_state_drive/NVMe

This is the APST data from 'nvme id-ctrl /dev/nvme1'

NVME Identify Controller:
vid       : 0x1e49
ssvid     : 0x1e49
sn        : [...]
mn        : ZHITAI TiPro7000 1TB
fr        : ZTA32F3Y
[...]
ps    0 : mp:3.50W operational enlat:5 exlat:5 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:3.30W operational enlat:50 exlat:100 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:2.80W operational enlat:50 exlat:200 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.1500W non-operational enlat:500 exlat:5000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0200W non-operational enlat:2000 exlat:60000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

Signed-off-by: Ning Wang <ningwang35@outlook.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..92afdea107dc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,6 +3463,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.30.2

