Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DAC483E70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiADIqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:46:03 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:36274 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbiADIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641285960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zig29lI0FBli9i07olSYzSOYhKOSKiw65K/bW14c/qA=;
        b=anVYUCHdkfISnLZZz9K/x5+MFSaGtFuITVffy9kwCy+wziJZzGuuwUpVSnLWVl7HmmwVVm
        X6TeGQcf7kEutCsbHLh76VX2FAdem5v6QvlzOhr4ypi+YzPnwawHl59WPx73JZZesEv7TD
        LUqa9fT0psj5xEEjOaoIh25T03QLD5w=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-t3HJhfBfOmKOvcbqBXHbAA-1; Tue, 04 Jan 2022 09:45:59 +0100
X-MC-Unique: t3HJhfBfOmKOvcbqBXHbAA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iItbHmjXrUL3FCXQ+Uow5VCtgmP0N8kaRb2bBh3bwXoxtOnAcDQIvc3ga/ev9oCoZ7eTjG56QNuocAmAOJAmTU5LpW6GjrimP8W4Dhf8tTLzaXi9y5ICdH+521jm9uhg5nl2uOr19agBQpcyeL6/6aYK7BCuQhAUJLxcwnYNP9yvrBJE48q4Poei9jC5NYYQLpEVoeozEpVu0h+nj/CPa0vqRuUd4Kaj03jxSERNt6q0zerskP7a4Lfny2bhKiR+d8hk67cSFrswaz1rDllT7StrxDebxIs40884ywDCCrK+xWnwmQlWoZv+Bpql0+zoiA2LSBtj/7YxisaqZcQmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zig29lI0FBli9i07olSYzSOYhKOSKiw65K/bW14c/qA=;
 b=DfzCodLg3azEFy6mavgpOHRojIX7B0m1PXsleSRpKI826tPzIvT6Jn8hUQaU47p04BEN7tTipW/v5zqCchWe01qHdFNui/or8L7i0WzW1xsGcTMZHvBFbinoOcb6XXvO+0lpPoLUG9eFQkD44pjrhwBJi09YM3MSMf14B4UYSUdSwCryzAZb7dwyeMi3qntJ/aOEGKh7Gy7RPtCozLcPsYE6pO7GewBuNgxdcGqPKzCbKVV9e14161kFgeFbeswKC0NAblDikcGdE7CXr6N7th0cGEO8GZqQLCqz9BN7V+zu3bV31X9g4UFo/TnllGaHPj67vFCjh4yVzZR7RUC1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VI1PR04MB5741.eurprd04.prod.outlook.com (2603:10a6:803:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 08:45:58 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5951:a489:1cf0:19fe]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::5951:a489:1cf0:19fe%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 08:45:58 +0000
Message-ID: <a3df8bf3-d044-b7bb-3383-cd5239d6d4af@suse.com>
Date:   Tue, 4 Jan 2022 09:46:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Subject: [PATCH] xen/x86: obtain upper 32 bits of video frame buffer address
 for Dom0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0035.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::11) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a21f6fc2-9f83-453f-47aa-08d9cf5ea0a7
X-MS-TrafficTypeDiagnostic: VI1PR04MB5741:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1PR04MB57417F83F16D85A2DBD60C38B34A9@VI1PR04MB5741.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbB91Ybudgq3IZF1Y7uwEMa1bVnXc9K79ttsAzPcFxc6JZYw5u1T9a8plhvl8EgUZxVaZTLIShmGfQ3e2QK1heKs/lwXSn+Vw2ZeEYcOafi42vltpSaLTf7s5kq3eGmCytgfD7hie9l1/ZUH/lxlwV0oXMG5Iq1Bc/bJR09QQghzh7bznrqsgS6ZnCghfzSQu2euaDnGO71JmI3Pm5d0tmC1U5AiP8OnwuGSPAdhDDg0fwV3pSoDZx78CsuIPeJrtJwfYt03E/z8K7yK4fKcHXQ6fvZ6r576k0uqZV4dGtcJi8hn+BOHTwnixfyvFKOA0nvYop8c7FPfcB6ZOpjWQXfPeilTv1l8iyChoL5d4DlqnozsqbZfsWc/lHGGkXV7zBAb7gCzRe3saUMcZ6XD/aDcwdUIuGzweeImLJGoGU1460V4vgOrORBBLGcvfIzPX5yDNqnwNOBw3tkBvPvI9qaWvtr+TnzODnT6OBIKvBairq6z8fIT13F/CqXUVY2Zf59lPTZigpi1RKXbZ4cb3ClqMlJqSJMChZ8Jrr6LJz+uiWwHxNDq1i/VbrbKgFukc4jDG0D7iNu3VAQzat9fRddcgQ5h3BqakiBRNJwkZ/vGqEEE495OGGaSQatSh8l0FFLgRAJb3OvID3HYZ9QBj3aUbW8+IqPNOn0HXw1BHF0yF+XIdHikZGNFDSbS0bHo5RBZ5DkVJ4PuA48vWslwlpIZ+3K9jZDVYsOCT1dBjtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8676002)(6512007)(6486002)(66476007)(38100700002)(66556008)(83380400001)(5660300002)(26005)(54906003)(86362001)(66946007)(110136005)(36756003)(31686004)(4326008)(186003)(2906002)(31696002)(8936002)(508600001)(316002)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulh5WWZoeTFKRUJteHpFRVZQTWhrWk1PUUd0N094UEJwc1lldzBLZXpUZk5n?=
 =?utf-8?B?aFlxNnJMK1NvR0dJWXVrbUZYdzRKZWJmRVI4UE1sRXhrcE8rdGVHVVB1Y3Rv?=
 =?utf-8?B?M01qbDJ3NytRTERtZWNRZENaQ0JEYzIwTERja0RSc1R1M05IRHZrMEZyTGY1?=
 =?utf-8?B?M1JYWW04VVc4bnE3N1k3cTY0emdwR0pMMlMvUTJzV3R2RkxBQTZoTnJBelRL?=
 =?utf-8?B?OVl1K296eTdZenhOV2hmZW5JT1czMkNRTmttcjNKMzlUb2w3dVB5dlNkVmxt?=
 =?utf-8?B?UlR0RkhnU0pCS1JkOUNzRlhlSFZjZGM4NXZzUE9yL3pmNHJkdWJGdTcxTml2?=
 =?utf-8?B?b0luYk1NdVdMSUJmd0lFbUk0ZjNNNEp1UG5lN2NpM2xRVkJCTG8vQUF5SE9B?=
 =?utf-8?B?YmRQaE16MUdiWndML1lscWRsQmZlVmRWTUdCRnQvRVBOUEYvS0M1cmQzenJz?=
 =?utf-8?B?eng2MnRVMm5Kbyt0T0tLcXhjc0tIWXRSYWRLV2cxY2JpdTMvcDZ0TE0wQnNK?=
 =?utf-8?B?cGtJdFU3WlFld3hLV3pHUHNpTFhoYS9lM3J6YU1lVkxLWS95RHNEWUJ5SlVz?=
 =?utf-8?B?STZPc3RoV0JFbGNPcWxydUYrSjdVd0FuMFZKbFdDbkphUGVuN2JrcEJpcHAx?=
 =?utf-8?B?ci9zQUwybHgvbVY0Y1Y4ZHpnME1lTHJMbjRLQmo0aU93bGdrMkJDSW5tSjFK?=
 =?utf-8?B?b2JMZzlDcUFDUWUrNjZRTE9ZOG1KOHd4RnFkR1h3dmVnSUNrRzVEMTZ4VWtM?=
 =?utf-8?B?aGVwNytqelhUSWJOcE4wdi9sYzhaUGxOUXFhU2VGVi95VEpKcmtqenJKNmJB?=
 =?utf-8?B?a1JWVmR3d0J1anlmQmhyNDFIT3BLZEIzL0o3dFBzaXh1M201Y1ZjSVRpbTFR?=
 =?utf-8?B?NXJiT2RDaG4xcmRLRGtIcnpYQXhZYy9hSjk2Tzc0UUxDUEFEcDJtbThBV3R2?=
 =?utf-8?B?RFp4MGZlbkU4M0xuUEx5cU9xQmw4VXdYMFdydlhIc0ZyVmY0VmpPTlQ0dkhz?=
 =?utf-8?B?ZHZwTlNLR2V4V1BtRU0zRlAvNk1tQ0dmZldLOTRaSzJmSFN2R2hXRWdwOEl2?=
 =?utf-8?B?UTZDYmZpRzU4czFFVUpENEFrQTBBaUFMTmJVaEg2RmdNdmRacXY0MVFIMVlx?=
 =?utf-8?B?Mnl6YWpFeFJPdEZyb2tzOXpoMFNDN0h4Y090YlR6dkdTM0pvemswNzlUcVdQ?=
 =?utf-8?B?K0lFZTNtU3JjaVBSN1pwSTJrampzVUZXcGxMdXdiZStvS2ZVVFRQYlExd3ln?=
 =?utf-8?B?VGEyV1JRWlpMVThRV2dZRlNORDVjVm54SGJjNGNYZW5lcExKRGpYV2x3VnFB?=
 =?utf-8?B?SHlOVjB4Unk0QmE5enJjWDY2SUE2dytkMUNWTUlrTVJDR2tSSlBLUmpHeGEv?=
 =?utf-8?B?cjBzUWlYVDV1ejVqZ2dyUmV6UDVwSHRZTjB6MmhybDlnOXpBWml6Vm85Qzll?=
 =?utf-8?B?dk82eDdEemluUlE4V0NLalN5TWEreVBBTmJPN2ViNEcxb25sbklKdW53dHVL?=
 =?utf-8?B?YzNPNWxaMXlNVHZzMlFOOVVQemU2SkhLUS9oVDhzeElKOENzVERZMEM3N2JK?=
 =?utf-8?B?RFFmR3lpVXU4M2s1SklVRGtFelZUanFtQ3RweHBLQzhjUkpxZzNpcExTanJS?=
 =?utf-8?B?cjlzcTlrS3RzdGMrZmgwTUUyVEJyQUkvZVdrWWYvWlRjMmxkakgzWFdUTUp6?=
 =?utf-8?B?dWMxNXVMN0Vrb0xxNFRzdldKT0d5ZW9hUHdpQTZKa1FVZDdaMXRhNG9qdXZB?=
 =?utf-8?B?MlNVTlloaDR3SE5tMm5vRG1HZkY2TUVGN1VaQ05ValZXYlh2N1ZDbGxGaXdq?=
 =?utf-8?B?cTJJS2RYdjltOGU4Zk9VeDVTUU5tTUxSY2NzWTRTMlMrdjhRUitJbmdGVXpE?=
 =?utf-8?B?cHVwM2UxLzdWa2MxZmFNNW0rSFRYK3ZsU0txWEkxbTdZV1BlK05rSGZBb2Nu?=
 =?utf-8?B?aUpTSXBnVkZ3aXZNV0ltZFloT1V4eWZoOHptb2N6alh5aTdPNXhFMDl2NW1I?=
 =?utf-8?B?a1MrR095TUxaNjExaHdJczdwRzFyeWxNQ2N1eU54SWx6VGxHR0pWaWJoYXZW?=
 =?utf-8?B?OEV3ZnlrYTNpN3pIWi9JOUNOVTJvYkRjbWsxRnc4TytxR2w3UWRzK0NiWnkz?=
 =?utf-8?B?cU53K0hqay9pQVVzam0yVWdqbjNYSTE3V0M3SmZNdlgxamU2RVlkaFpnT2Y4?=
 =?utf-8?Q?W3LWpW1gsmg29owOOuoki+s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21f6fc2-9f83-453f-47aa-08d9cf5ea0a7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 08:45:57.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: natWC3ljDtGmHAP882L/X1rrI/qShyae1aL1wGYqhPn+xJ+qaJ1N3nnobIEFaTIlBEfErNC7EmpKVNdXJo4g0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5741
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor has been supplying this information for a couple of major
releases. Make use of it. The need to set a flag in the capabilities
field also points out that the prior setting of that field from the
hypervisor interface's gbl_caps one was wrong, so that code gets deleted
(there's also no equivalent of this in native boot code).

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/arch/x86/xen/vga.c
+++ b/arch/x86/xen/vga.c
@@ -63,13 +63,17 @@ void __init xen_init_vga(const struct do
 		}
 
 		if (size >= offsetof(struct dom0_vga_console_info,
-				     u.vesa_lfb.gbl_caps)
-		    + sizeof(info->u.vesa_lfb.gbl_caps))
-			screen_info->capabilities = info->u.vesa_lfb.gbl_caps;
-		if (size >= offsetof(struct dom0_vga_console_info,
 				     u.vesa_lfb.mode_attrs)
 		    + sizeof(info->u.vesa_lfb.mode_attrs))
 			screen_info->vesa_attributes = info->u.vesa_lfb.mode_attrs;
+
+		if (size >= offsetof(struct dom0_vga_console_info,
+				     u.vesa_lfb.ext_lfb_base)
+		    + sizeof(info->u.vesa_lfb.ext_lfb_base)
+		    && info->u.vesa_lfb.ext_lfb_base) {
+			screen_info->ext_lfb_base = info->u.vesa_lfb.ext_lfb_base;
+			screen_info->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
+		}
 		break;
 	}
 }
--- a/include/xen/interface/xen.h
+++ b/include/xen/interface/xen.h
@@ -722,6 +722,9 @@ struct dom0_vga_console_info {
 			uint32_t gbl_caps;
 			/* Mode attributes (offset 0x0, VESA command 0x4f01). */
 			uint16_t mode_attrs;
+			uint16_t pad;
+			/* high 32 bits of lfb_base */
+			uint32_t ext_lfb_base;
 		} vesa_lfb;
 	} u;
 };

