Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797E449EAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiA0TAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:00:31 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:49655
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232813AbiA0TA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:00:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWGLTPB9zRu4cquC7yjhuelATT2nA/0hcFPdTBwHX0dIqhHBZfUcsRfPVyePi1JdzIvuDqrtjcNQEaqmN82RhE6rvrwihBwahN0307LtfQ46rHKDFCH0ap5edZORLsQUqhpbO3CHT6qHTjxppWWCLUwhR3VaqyozoHIoWYCa/YyvZpFJ7gYwz4CdSvNOBUwsBo5HXLdcytBpGnRrSKD6s084QIcRC0EXxgRZ6AdXAdvWUkNqm4QzXX/sHn3JoCIEiY8f1DQgBt5AfdfDraGTqTCnVdianRnKjNgcXgEJ/8UfajgJx4W83StTyT4HzynOTzznAQmTasX8RjyTZv7uNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRdr8lW74Kk8yIp0TXne9i+YHj8QmTB6IUhk5salUfY=;
 b=OhyY+qhhddQ6OjSiybJFyHv6IgFrYWdllfMzIz5zM7e7jqGxhzfiRe0Z7KzWTg0Sy9sv5R9BJNGRPoiNOsiWfUDrWu8cby6M6q5bDSkJnr69z+N6kxROQPore3s2U3hl+eONH9gNi/NhwpZO7OOh402XnTafDOpft6IxzuM6gwRZ13BhBXmok7yRrWtRL+uGnadjn1bO634S5I3hsjID+M2MAXJw7ZVcpcUUIscAST6f4yxaf8RU43OeiuOcBZU1fRgk08U7T+52y3pupZAglchmNtnOA54xViH6OfXeuvWceFWYwfFM3HPpM88pDz/TbMiPJiyIP53ja9Mskog6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRdr8lW74Kk8yIp0TXne9i+YHj8QmTB6IUhk5salUfY=;
 b=pli/Q4KPN5K5OKdyAvBWCwjeIXtUUEa6yot21LjEdB6kzAuVw3mfaMx8LxSaRdVUAsEDiYlmhpXeIgF/CbN6XkWGTHCxcXWZK7m7InroQ6GY3NiL2QJGR2xIWMoJXnVQnWdRtVXK+zD3gogIWm1Len8cCK3+ArQQ5t/PpTNSKWTb8zSfGaim/oTLmPkvLeTcl2lVa0bHizc16qtiRIkwVU8KvBij6C9MtNtctdDdIATSDxk1o4UMLWIbaXWhsUB9BOHeb4KVxSPRbdmBrC/8Qswz7LLnaO3hiJveskNbqlOpcpYjpPopnFRBIofUWWrIKeq8Xh2fc1yU93r3iSOkyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5466.eurprd03.prod.outlook.com (2603:10a6:101:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 19:00:24 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 19:00:23 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 0/3] usb: ulpi: Fixes and debugfs support
Date:   Thu, 27 Jan 2022 14:00:01 -0500
Message-Id: <20220127190004.1446909-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c788d5f6-b2f8-4882-e6ea-08d9e1c745d5
X-MS-TrafficTypeDiagnostic: PR2PR03MB5466:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB54667B00E16AD60BFDD5367496219@PR2PR03MB5466.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jvm3PUuVsYC+uFUKtstVBWLmKrWQ5DCLo4XlIVUD4oc3U3+WeZxREafLdB240aHUr0tpQZq7tLpg9V74d9WBzRTiyCgmQVEi0Mjz50deLvGMkYpaQmmNx8dJ2wWK8sRNTs9H1VOGs4RGunqVleD8Ad/sQ4mi51JxmLXkCsbl6el9wSIHs+eL8Ux49fm3X0OXf2wVE0oNHGUCdslll7yZBANrjSeF6/btXCzvw4td843snkqUuE3GxPe8Q5M22cV25VRVphyVE/oq0O2eJEK2GyLpXIgvJdIns93sWcKJ5EbBUki7ushGWcaUvH6dkcqlfU1pO6q8Hk+Snd7jz4JZQieZVlih29mE7HWjuSVWOVJ8mMXg3uBYqqpFmJN7NeAmw5kU5XHIVBkLXGkiNSnmumQvYuBrgouuiSk4ieKd8i3uioYMgncrZi15xJTuZb7NKSFuISWJQdlVvNDGR/pY0Tt/FJ1qOt+lIDWr2UHZViDO7MteSTG0/bIffWrDGwyrzPxtkGucM9apk1zyLCpZrQiPiwkG9Qk2/kYRp1DE8p17wfOnX7ba8ouZTnrdPlQ5BGq/nAEqDm6klSjLd0rCHi+h7MCO3EzCPfKnu+f3wQy6LDwlGmfQVmSjDfFdmti4PpP/nl7Sm7xrJEnecmlWuCaGy/gsZqj2ablOQw0vmBjg1bc8Qm0XK17yF3jjnqrpmTXSMp6geyQYzxvX8f+4BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(4744005)(36756003)(4326008)(54906003)(6506007)(5660300002)(8936002)(66476007)(316002)(66946007)(66556008)(38100700002)(38350700002)(8676002)(6666004)(83380400001)(2906002)(6486002)(86362001)(6512007)(1076003)(508600001)(52116002)(107886003)(186003)(26005)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7ac5UBHhBedHtMcTOd2Sg9tiP20lHpAr+dcNTQ0kcky5MtY6GDyEV/XXdWF?=
 =?us-ascii?Q?6isG3CUr0ZJgwt5juCmbYT6beqDfb+fcQ6kvnzgEH7+gCfQITTrI+zDhCdgQ?=
 =?us-ascii?Q?j/MX7hYezKvdILTWiehzosKYYsIkAhmYOLPQMGQAphPKBQvScJlrpX0oPg+D?=
 =?us-ascii?Q?9oSJl44wGrpqfO5kyL6MkKKFfZYgixFjTF7WiSnxgRZGSJlayWL97a9a9pAQ?=
 =?us-ascii?Q?ty0VOMzczx2PrvBnas6nXtvlHkdybZxK2EszegoIcrshWwH0laCY2tiPvANA?=
 =?us-ascii?Q?UvzhStwPTRJZgaiuYq7dK5m18pPdV3M1NGRRUM9+svfmeBAjqozqJTwI8zKq?=
 =?us-ascii?Q?9jvfRsSE3Tk/4mFTEp9UStRKHjkFiSDaCNM2B/WgXKZa7VuH0oN665isFq+D?=
 =?us-ascii?Q?UNWN6tEIG8YXEAvkTXajBp5udsK5G47b74X05MbgRV2eOCt7DJFD2l0TIHLh?=
 =?us-ascii?Q?HDvjWPTJHR9oRH1jNzHqHILpH54n9y01zzAmJG+QaqUVKaWrbQSGOoblkHqU?=
 =?us-ascii?Q?XrcGzyfMbKs8cEPusvBjibl8LNodlwBT4hrJR7v3qIMUUY5oJI5J1yMQ0v8F?=
 =?us-ascii?Q?ff2aFLyZP62Jn6fy/PD9s8LCRt1657jZvZ6gVoUv8BIQdlrDXbwMislRp/mP?=
 =?us-ascii?Q?QNii//amblU+uRUGzTk1DIGU3iuxDt1yQsju8/CgpAQjmbwZp1rMxh9a24nv?=
 =?us-ascii?Q?XDfpX4TA0HTW9TXwdCKfFFzONb2rmeJG1E5FIp2e78Xnlf5z+S5c842H7P2A?=
 =?us-ascii?Q?w2X3+4/AI+zubrPZ48F47yM1odfecCGP0x0gnyTLDjaM7b0HP03W/zxz7RSO?=
 =?us-ascii?Q?tbC5gJvMkULW4IC8/RQdlhYtco1QiBPizGppMNnvyjTpaDhA6g9GnbMqdCGp?=
 =?us-ascii?Q?VbE8y9jcWBKWPv1cuwSKBeE4bb6TlTqkhH33NBgxxWRD3he3djhFfUsp2ewv?=
 =?us-ascii?Q?wxjnyREGbQSrfx2bwPB+YXDI3FHUqJ2xSBJZUqpi7k7809hUYV15GiK3pJnK?=
 =?us-ascii?Q?7Y5i4cS+wypXsTJwPoZzzzzeX/idcknrgmgUdoyzNUtlxe5W4JCO8pjrAsG5?=
 =?us-ascii?Q?W6uysTVAOph/BjVSYyryC7TTeq0KVurbtRjl8m1RntZXGgewOpGEdJDTs2d+?=
 =?us-ascii?Q?LWn00rPoVQZOvxjmXDiotDB+GsTOp8MIhL8QjSFqf+4VBjJ+vjHPExGFVD9Y?=
 =?us-ascii?Q?S+XV5zc8M981eJhvr1xjjjATr0TQYM0meDeMizAchCPsn52TUvzYaWNyn36+?=
 =?us-ascii?Q?j/XOw+QRiz9Uscuc63jVMPs00IJohRb46a3ibGfOhQdiYYn2eFH1wjt2bFxY?=
 =?us-ascii?Q?sUyFg2mNhSgl9LRhCeEf2vKtRZuQO4MpnIs+VFkbMHgsRMVLuJxlsgU1eHV6?=
 =?us-ascii?Q?JA5izJO0h3/jgtjDupBWvatS0WXd16Ks7AoVCE4++TI4MaVMpK8VqNDtOTYI?=
 =?us-ascii?Q?B+TLYZERDblq8wUJ4gn31u3VD0Og1JpUMRZfvBM/9TWCLvJMmyVL7CXNrmih?=
 =?us-ascii?Q?kM661HeNr/7iJtvMhFAiapi+TUkB4N0XfdRoikjkOkQ3VTyLVycPdh/MQYIE?=
 =?us-ascii?Q?rQYSSlIACADj4cbRblBm09gtYylEbJSZd+CfytdfihOvWf/3iv1YHE7c5V+O?=
 =?us-ascii?Q?vystOzejiKoh4Ik8vZtw0Qk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c788d5f6-b2f8-4882-e6ea-08d9e1c745d5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 19:00:23.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdQLibQGXxLbNbaAH7h+lueiDYzUsv5Jr4IfCdbWVEanO5mIYOS6RguE+GBE6LGVGgPojDh47Aj1LGBPPBdu1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds debugfs support for ulpi devices. The first two patches are
fixes and may be applied independently of the last patch. The last patch
depends on the first two because it modifies adjacent lines.

Changes in v3:
- Use separate patch for moving of_node_put from unregister to release
- Add Fixes tag
- Call put_device if device_register fails
- Re-order patches so the fixes comes first

Changes in v2:
- Call of_node_put correctly
- Always create debugfs files and ignore errors
- Look up dentries dynamically

Sean Anderson (3):
  usb: ulpi: Move of_node_put to ulpi_dev_release
  usb: ulpi: Call of_node_put correctly
  usb: ulpi: Add debugfs support

 drivers/usb/common/ulpi.c | 81 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

-- 
2.25.1

