Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C267D482CFF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 23:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiABWeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 17:34:22 -0500
Received: from mail-eopbgr60109.outbound.protection.outlook.com ([40.107.6.109]:43591
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbiABWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 17:34:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQdife/YIEyCvE7y7aRdhYT2uLy5nKZQ9Cvz/wvhTv3KMvu3jHtxLh/6Sz+1xcRLSxl90PrwXvTQb2Ss23SSjVfFkcG/zZ1S9Y0kx8lCPzB4A0BW4LsaNCI0RchlnYptFF2cSRp1TZ6xsGOATNpQrql39JBszZFf4w60Tczd+LnidGGR3n4LrNfr8QIS6CRGB965vRg2/X+bltTGHGvWmMDSU45xNy0RRxrQCNgOcQ1n2Qn6diVNGr+H5fR4f3mmjWgvELMGQ34Add6syLhBpY0nFhrYXt5wTp1y65AfydbA7KZQMRkI0n86K3DRLxO9kKzTS0Qq9KjB/5v0XVTySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pe2cJERyyG/meI4/ziWqshN88Ol2fJ5QA2iIhDUsbU=;
 b=OeOEW/zkzYvw1wYPZDqc+dMzVs+WgSVdKwzeR4tFN8B67z6UGF/tDxRFyNCjKzYQgSP9d6oo2Ta6IqJsCBSrSo3RPdBkDeiVQ9am73iBJVCaF63EBmEG0cHY+U4drHcmgHBGWjCknEBD/Ae5dM0wECytU63KpYiVBZOwMyaDo3f9xBJOhcqP77aRJdaDEpW0ac6Cz8taAHJroF8aVo63JgJA+w9n8RyaKnbeRc0B59sj241Zc4v5FXQAQIamrhdwFNFZVNw7/i1NWUdv7RuKYKqQjmIbMWdDCfAYNK3k7dYdhqqwWNNTotKibPS52LFXsYQ2uFpaK16Xi5sL5cmzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pe2cJERyyG/meI4/ziWqshN88Ol2fJ5QA2iIhDUsbU=;
 b=bX/wGP50YMiMWV1LiU72hoR5zb8rqZIMxLebz0l0/0VhuFdzfUvp4Cn4ct54qL/IDN8emnlH5Z7TWRtJju8WNeiP9GupWCRhHWuREo3Moly+k4lIiVK5oO+ZduXJYRk/nCjAIo8Zf95L1SDwpJSOsqKvmqfX6egru5KScYZht7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2920.eurprd02.prod.outlook.com (2603:10a6:4:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Sun, 2 Jan
 2022 22:34:15 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4844.016; Sun, 2 Jan 2022
 22:34:15 +0000
Message-ID: <94ab71e1-2e68-def2-95b8-33162172f65c@axentia.se>
Date:   Sun, 2 Jan 2022 23:34:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Subject: mux for 5.17-rc1
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0007.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f314d018-6a6e-404f-bab5-08d9ce4001e2
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2920:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB292091C6F7B9B00316D0D758BC489@DB6PR0202MB2920.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTGbPxMKTs/43sVS3XhAOqmOwrwDLNQ3J00ZKOft3gi2QsVkh5Pys/9oRuy0FsmKWSgD19OTS8XrR1e5+DQB5xJePDafu9RwPN+PpwvH27WOTZSGuwP6Z/ICS7NclCRM9T8iwj8I1MFprB9/GbiOLL38++vLJ6qirKb+QZUKOaCmTa8ogIh8wsI9tCrSqp1P9ICbVgH70pmU0jaSDCvmlahPRO50l2Zijdxfa7eSp8iGCrel7DjxeblppoqePltX/bVPnZpKYhUKK4TFAuCQKGp0hvuY3t04dYVsxXN/rUNsuldECDkpCXeEh364gkXOXWCi2xWbymZsqZHWprV1AGAtBN3LbcWflHyQKqkn8mF1F5T05o+hRB1TCw1iqCda+jihoKUCcQBULFXZbL4N8NKBsqMctrmuXZ9GPyEpVE6sHea9qf4hRbMntmkKfh20NPWLpPU3SSEdRL+QR+ON1I7DLNB8bS/OsCpRHgsNRxMQA8RM8ebormxPAHPRTzs7hm6B3uQ9HO7HxximuGSAVbzMeKO39kTVaNL/5IX/jgZ8i/DhfPawAF3Pq1ck6fLm/7DzgXW1G9yEQK0f9KqVKszA3/7FCFRUJGsGTrsm67XtKDR4bBuNyoDG0JHf4uxB5kKKK1PhQoNB5KnfLsWcz2oj1CPK+s3T5kek3FRckCdc5080nTmJPpWnAW8f/HjYQjTnmPF3S1Yb9wKLTr2h1bAHYQ0gp34PSjrC9teC0XS5pvW1lz7q90XecMbDYcPI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(136003)(376002)(396003)(38100700002)(508600001)(4326008)(36916002)(31696002)(54906003)(2906002)(83380400001)(2616005)(66946007)(316002)(5660300002)(8676002)(66476007)(66556008)(6916009)(6666004)(86362001)(36756003)(6506007)(26005)(6486002)(8936002)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlvZyt5QXg5QUhTVERnaTV0ekpZUXhpdThUUVJwZDM0ZnpUTjVXM0RIRjRN?=
 =?utf-8?B?b3c5b1A4OVdBa0Nocm5OaUg0aEhUZlJHdk9lUjFJRjZha1NXYzh3a2NSb2NF?=
 =?utf-8?B?aWgzdmUzRmovTnRraVdBRHRyWENqaGdueHlvWHF1KzRjNVRtUU4wRC9NS2xh?=
 =?utf-8?B?akd5dldsTzBIUk91Qk80UW1kVzBBcEdzMDFydFNvSlFJcW5FS0xiK1VTNHUz?=
 =?utf-8?B?Zjh1ZGg1VWxDbTFFUERLbnVQcFQ5cUdHNUs2OW5GSWQwS1JDU3pPWHpOSFJ2?=
 =?utf-8?B?SGhZRThKUHFvM0ZkV25NYlU0bXZZQWtPb0QzcFZqbmF5RFpoVSttS2lIaXo5?=
 =?utf-8?B?OEI0SUZLU3hraDNvTnJzMHZEVEo2bGdpUHM4RmdpNExDR1F3Uld6UDNTOVNw?=
 =?utf-8?B?L29HWHdHYkZXU09ZdUhqc294VWlKcVFRbG1WQlJWejgvZ2pYQ2pTQkVBZVBy?=
 =?utf-8?B?dzA1cjF0VGtDc3ExdHAySUZyYmljeHNyWnVXMFF1UTh6V2tSaWJYVWhYTzJ0?=
 =?utf-8?B?MklSN0sycVlDZGpMWDQ5VC9lck9PUW9wWUlqb3laVm5lcHpML2oxY3pCRmVL?=
 =?utf-8?B?NmlaQVlRcUxYQk14Yk5DTVo4S3J1RzhuUm85cWVVQ2MzNFhYemR4b0twY3dW?=
 =?utf-8?B?Nmtob0d2M0F5bGtZb25MYUpqM2ovQnJRL0N5V2lJTEdqRkxCWHNKVkhlaGNn?=
 =?utf-8?B?SzNyNHJvUTFtWUE1dnRpQjJ0SExTakZRWmwvZE5jYkRISUdIQVh4cHRnbyth?=
 =?utf-8?B?VXpvZHZsVFhuRkRHeTR1aitvYUVNaWdHRGRBY1o3Y2M4VU10bDdsZmFmdTN5?=
 =?utf-8?B?L29Xcno0L0dZcUZkU3F4WUo1bExQNTUzRzlhYUlBWW0xM2hIbUUrL2dwYnEy?=
 =?utf-8?B?L0hkdTlBVW1pWXNNaEJOSERXTVVXWnptS1lpTGEzZDBIMU8xZVYyWGVjL1NI?=
 =?utf-8?B?c3UrUGNTcFB3SjJtYzZ6RWpSczBUWThSODB5Qk5Xdy9uWmdWZlBsY0x5TjZK?=
 =?utf-8?B?UXBGL0dsdDFrVkNySVdJRjFkUm5wKzI0aFdGS01PUjlyN3E3YW8wQkEvdzln?=
 =?utf-8?B?ZVpXMVQ1MkxEdXlTTTBPSG0zUHNPZFdHSURDQ3FrYnlEVXlmYjU2d0tKRnBt?=
 =?utf-8?B?R0VmR0pxOWxMbG0xOEdWdDl5R3kvcTVOMkIwTHI5a09sWGRsd29DODlFaUcx?=
 =?utf-8?B?ekdvczFBL2g2VkVzNS9WemNhU0p1Z0xvMWN5dktNK0p1cmlNcCtPalVXWDdL?=
 =?utf-8?B?Z2JnTUtZV09KdjJsN2JxMVdlQWI5bnVacFdmUVErakVpUjJrVW85SThiejl4?=
 =?utf-8?B?cU9acUNyNkxVM1JuQ0c3ZG9JS0NnakI5ejZsQkVhSjlIL250NjhPdXZmR2I5?=
 =?utf-8?B?Q20zVUQ0eUdZRmo2cWJLN2s1VTZYWmg2WUxhQVZlaUdtSzhDUTNSVmdPMlQy?=
 =?utf-8?B?S2FpWGUvZmZmcU8vNHdVRmloSGpEWWR6VXM4QzF6bGJWL0xxWEZ5Qnp5WGRZ?=
 =?utf-8?B?LzNaT3NYak93anlLeDVYNTZrY1pFaUVpR1l5cDYrL3k1MTUzVksrRVZRMWZj?=
 =?utf-8?B?VDFnMUJZVnFJTGJFdXk5eDduZHhTVnVaRFkrYTlUT3d1ajZ6UUFqY21ac3Zx?=
 =?utf-8?B?cVcvbkxwSExzMldNWUdhY0IydXJ6RWxBaHlPUW9MYXVkRXRYNXlaTURsR1Rs?=
 =?utf-8?B?akZ5bUdQM2FTdVdoT0JFU1EvS2VjWGVpMzFvd0tSckRGTm5MVG0ySHlEL1RK?=
 =?utf-8?B?Q0ZyTHBwaWNDSy82NllIamNXZjV1WGJCakVDbE9Xb0VML3Uza3FyQ2ZhZDBR?=
 =?utf-8?B?b09WaXdaMnFRSkExOUk3RW1tQ0IyZnBPSGswOGsyMFhsSzFqU3llNlhWRjlK?=
 =?utf-8?B?TlQwbFdWTWZnckQvMnhIMWtoN2gyRTYrOEFRQkJhYS80Rmo5eDhpbSt5M3Na?=
 =?utf-8?B?dHJjWWwxRk9CN2VJb25rekR2WUFzMEFqYURRWHNjUzVEWnp2aXpUd2FHelIx?=
 =?utf-8?B?UlhWNXNNR29pWVdhaGRKb3VBM2RVS0FsUno3UVlHMWhMYStBZzJiQU1hNFhI?=
 =?utf-8?B?d293V2VKNGI4MTQ5UHlHK3lMOHNUd1lVRnJQUEFFVXZnZkJNK1dTbE0yMDFT?=
 =?utf-8?Q?zCvY=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f314d018-6a6e-404f-bab5-08d9ce4001e2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2022 22:34:15.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvCo9THjVXsiJA1xBClxB3C385pmKjCbfB1Mw6r4FJlbDw7jTbIC+5TQuMIqGgYP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These have been in -next since around x-mas, and hopefully it's not too
late to push them for the upcoming window.

Patch 5/6 fails check-patch due to lacking a message body, because I
forgot to actually check that and now I can't find it in me to re-spin
for that seemingly insignificant issue. If it really is a no-no, then
please just drop that patch.

Also, I really would have liked to squash patch 6/6 into patch 3/6, but
I don't know how to retain credits properly if I do that. I did remove
the Fixes tag from 6/6, since the commit hash will be trash by the time
you make your commit. It was:

Fixes: xxxxxxxxxxxx ("mux: Add support for reading mux state from consumer DT node")

(In case you can find it in you to add it back with a proper hash.)

Anyway, the big change here is the new support for pointing at a
specific mux state from a device tree node.

Cheers,
Peter

Aswath Govindraju (3):
      dt-bindings: ti-serdes-mux: Add defines for J721S2 SoC
      dt-bindings: mux: Document mux-states property
      mux: Add support for reading mux state from consumer DT node

Peter Rosin (2):
      mux: add missing mux_state_get
      mux: fix grammar, missing "is".

Yang Li (1):
      mux: Fix struct mux_state kernel-doc comment

 .../devicetree/bindings/mux/gpio-mux.yaml          |  11 +-
 .../devicetree/bindings/mux/mux-consumer.yaml      |  21 ++
 .../devicetree/bindings/mux/mux-controller.yaml    |  26 ++-
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 drivers/mux/core.c                                 | 241 +++++++++++++++++++--
 include/dt-bindings/mux/ti-serdes.h                |  22 ++
 include/linux/mux/consumer.h                       |  20 ++
 7 files changed, 317 insertions(+), 25 deletions(-)
