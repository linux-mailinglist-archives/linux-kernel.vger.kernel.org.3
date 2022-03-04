Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7572B4CCD64
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbiCDFlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238123AbiCDFlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:41:11 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2127.outbound.protection.outlook.com [40.107.243.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA5C151D26;
        Thu,  3 Mar 2022 21:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQfWbWlFyYYZun7c0C9mOAEskZHgHBuoXM5qhobELJN5U7lCHDEONA0n5d7lsHYwZIhNZDfVx8ubBrc4MMx4DDQ6MClM6WW0dGMx78Fwx5kQvyXKOP0n0kP08IClh1+QhgntBmGQMoWcxTywJM4G53bKzsxFaZU7xYFtpuAm7LIoJs3Q43bGi2emuPkJ5hx9lY8yW4jik3G19xiwTXET4H0PUs/PgqcBdEBsmQYfuM4oecSr03M8PtpFx6WwEmYgLGNl0ghDfs+gxiwxn83XgQFTzwhvOtgj9syyP4cWmgcjtl0EB6Dhhx+CH+sO30lQJ3H9QxK0H6nSRJC7A3Z1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Mnt0BVzRyWj/Pd9UarkC1p5dfib/C8yCO0tbyIgLpY=;
 b=IucVU/g/UYZSJoqvYTXFpYcXtLYFlylrmldB+EGdS1SwvRqaDwT6an9DZHtoAgl/Y9u+5wNXhkQ5BJsp2omeHglSRRTYf+nbOztCCKbyTQD6QVQCSrlZJvz0lx5im6vUdj43bvxEQXQdoKR614xHv+w6I0X9ju8q7j6Wd4n4Ez1QlmnFBUow9WahAX5HJhVMe3LD2MCc4ON1CBIapdfFoklZqJo+xzLeauNbQQBJfApqxfQ0Goe3VhJNxAv/dJj2p6GkxZeI//P/Q3Rl+8hoNTLskahvE4zFr/YgAgHfPcE2cu3MU/ZRlShFrwJm0j7ajicq82nexZ8zE1mmVP44jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Mnt0BVzRyWj/Pd9UarkC1p5dfib/C8yCO0tbyIgLpY=;
 b=ND2/YGeQM6ClWX6vAktInEB7lVvHTWfdrNbTX6p/DusfbJiwG+dliuXc5SStCQ/BLxgjPMPBOuttt06iK6qAyBRsLae1sGXDOJ9CEjnSox8zUQXEXZRshd3BpoeNwh001XwJ+Bhe5+LF99v0WtgoPHlgjdqiitZUO6Mgh2Ggnno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM6PR01MB5596.prod.exchangelabs.com (2603:10b6:5:156::32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.25; Fri, 4 Mar 2022 05:40:20 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::181b:1522:26bc:c243%4]) with mapi id 15.20.5017.026; Fri, 4 Mar 2022
 05:40:20 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, linux@armlinux.org.uk
Cc:     lenb@kernel.org, robert.moore@intel.com, james.morse@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        scott@os.amperecomputing.com, darren@os.amperecomputing.com
Subject: [PATCH v5 RESEND 0/2] ACPI: Arm Generic Diagnostic Dump and Reset device
Date:   Thu,  3 Mar 2022 21:40:01 -0800
Message-Id: <20220304054003.152319-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da64e6f-fdd8-4cc0-a109-08d9fda17835
X-MS-TrafficTypeDiagnostic: DM6PR01MB5596:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB559620C0AF6AF6D8CED645439D059@DM6PR01MB5596.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zlNU426eOQArVMzOAA0z6tjrd05JQjhJUuoEGtOv2ZnvIc1DKAscJQX6U5hyZsZePXFvaiNCj/uJg3ah9YpRTO6RrErtAnb1gBSlhXowwdoDDTKSmhrcgkNnlnhheDjZeCi/nrljC9bVfiaWtv6XnlDbnmLhOLh0hz8xXn3CdYfw31L2vcSGy3X5Y8GjFl2BaGLXKk2bKHXQT+tRcpEFsOw6D5prFQ6N5gDJDjHeKOpk5KUeE3fgvsywtCS+G+1LwENZlSfjd0sdT0rMSFJX6PyXyFDmCJwjoCJNBw9dMpiHFa/jB55FjeyEhSHdYDHccQeEMcRAR7snfeuSrglipbME6cQIQhrjr5Y1OiFy8SwjMneLxf96FE7BwVVU7FtiIlPis/HuoxJOMYXijPqn2mvChybfJj/Y1tlxkzxE8IV/zxHP4Qj93aPP+7MbiaaIOzqmuboo79OdnN3x5HAdZMvguSDP1Pom/pLegfTLyaSB91En/jn7DvCkwYXpfeC/pGIvnQ7U9tVkX8cA6MkBn5Xyh3d8+ecubDhV2A57oFrdzzLdYjMcUVHkasvWHcqtW0wEcqCmzD3b2YnNyvZsOh2x2FBPylaPbasvGXdUBL0JdPFxlfPnYDAe+RPCd5jN0rm80Yq+CrbP/r/h2oEixneG8o4HaCeZo8+Mjm9sU11s/NBmxJqj/2JFiSUxY3uYfse6QPBym1TfQajVcDLQTgkMHmgYTKDyKc55Lin9lpuuXFM9+IVd0A+kvIC0tbuERQst+HuYmnffO3ZtAbKaTBgEmNJe+ztpXVaqwzywWP1T8eylMigV9B0gxv9obHi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(6506007)(38100700002)(38350700002)(508600001)(2906002)(6486002)(966005)(66946007)(66556008)(4326008)(8676002)(5660300002)(7416002)(8936002)(316002)(66476007)(86362001)(186003)(26005)(83380400001)(6512007)(1076003)(52116002)(2616005)(107886003)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAXyXlKm//XG0/BX1k95zzoeJxRyK8wEfVACr+q322F1Q5sVJFDyzx2IHMxx?=
 =?us-ascii?Q?IAgGIzEXKGNHa0cxE2E03ru40cQfBt4aBzztPRG3um+Jkb//CutACw7Sq0n9?=
 =?us-ascii?Q?wl0XoZ+CA87hJZmWXAh1TlRqsUKKwiYrCspv1kNyOqoRlS0w3L4ynvLxPzEf?=
 =?us-ascii?Q?XfWMPBlXETYXKYQD/4Bpda8vvRoLaWIZJ6DRtBgfNiyKgXjt0tUa4ly2AgYP?=
 =?us-ascii?Q?66R3r60FhorZ5w5ssIDDU9fwd6eT8Kjw5SUVXh6xk1nZVjy88+yYGiNl//UK?=
 =?us-ascii?Q?YA3mim9IPkyQhzxv2+Q3ZGvYvJkGcC6Ynpwyz8belwhPE2S5pZbhFVG4+2AR?=
 =?us-ascii?Q?Aspzif0AxgP3kTc49/oZW876kM9O0OHLY0olD5DymgRY8f1DBJR8FQEUtVaW?=
 =?us-ascii?Q?ddJPhdmj0kH1zT/SmiE4MbQx78J8Q0uaXOg+nFqD5j8MFCvnZfGXzssHz1KP?=
 =?us-ascii?Q?tHH125zM7gfo/TqhnZxd1P2XdLFRkp2m7QQX+7yCPKOxMW63swIoVYpqWrjc?=
 =?us-ascii?Q?U8coz+HEGF8/eqviYzazMbe3fzApF5WSrLxlwrQoEJRbRBg/FO+OgXK1B+gj?=
 =?us-ascii?Q?mnw098t8BbgfFjnkcW4RdQsdiLNAmdBhvKTYw/UETXgjeeEfNdqiUyleHXdn?=
 =?us-ascii?Q?18H3D2kYsoU8dBAY6chJ9rGPiZ773iRHhqSxwdDCPfTJND4Msq2VZ2N30axc?=
 =?us-ascii?Q?eyMCDa4F6wRercTRKhbqb0yZQ+hQU7/kRlnF8pvlnKUJ+OKC8/NlZhqKXuaB?=
 =?us-ascii?Q?Cn3bMYl+DmjXia0a/MQ6Fussaj1Mj22vVWJZJ3TjNn75WLFHb0TprgBzTInu?=
 =?us-ascii?Q?/sgKues7Tf8+JZ3zrRjZ2SBSkmRXtWiQO9ANOO2wwi9BXKwEEk16Rm+TBayP?=
 =?us-ascii?Q?JUPVp2/Hp7IgLb6KyvBosIGCw3Bv8emIazMrAjlkvFAIGVO3dn0wy23hnKxp?=
 =?us-ascii?Q?DmThcKI3bWlhZAISl/EO2MDNPdp0EghcrdUvfkAxT90q/mVHLJ/l4hRvAvt9?=
 =?us-ascii?Q?Igdx34kz/O2C0FJT+fFyoiizVu5LfI1D6W4j9bIQ2ZS9J5+nyeFgZgWW5dP1?=
 =?us-ascii?Q?xhPV8ufzEAn6L+spOQdsGlKMzYJknpXs7XcWc0lpGKUYz1iJrTMRDHXr9IYE?=
 =?us-ascii?Q?sfamZzfTMqSOl5L0iir1has83x0bCLyIWxCQYTCz8JoJdo3O3P2a+X+BQhfB?=
 =?us-ascii?Q?T1aXkPuJNNYc1nMGgx6uZhtZXK+2Pa8JUv7p3aKnyKsm2qHp0SvEQe/b0ZrR?=
 =?us-ascii?Q?QO7sRAtF7+OVwsaWxuPDTGIu8z+g6xRz8GOPZPnZaoFOVOgxNiZLmpCWTDyn?=
 =?us-ascii?Q?Y24gO74WO0eoIIhDqdOZaTKaqOaf6XN3yItXk7O0HI7U2J8qs0vQVx3qO46G?=
 =?us-ascii?Q?ouzQbMv3lfaqzIEg4PtWtufpHv8MgFlH2eU8af3IDPH1cYxXeWy9ffDRKQDL?=
 =?us-ascii?Q?l7HVww0tae8I05yOAQMTdlgsOWPpavwgJALCKes93CMj5avsT/y1SvWUdtvi?=
 =?us-ascii?Q?a9mKzldy7UJgXB6e52Wxlf2dfqWfs1oTGBXwfMHwBDKZldueZrFe8D1223fH?=
 =?us-ascii?Q?jIP9icB/NhgtsbledFIlxNE3fiAdzDu+fVNNR5Ek23YT7bGjntnjuJLImfDm?=
 =?us-ascii?Q?JkSp/4MKOEIQ7++qbhiUC5+SQDd9lzwAOIU+OxKgprcl1Zvn0WNbs1WyRdAs?=
 =?us-ascii?Q?NKe513YaRcRZgjaoX43drqTB1ZuJELpYQqBIWaY3361ETGiEH3hWxvj7CBcu?=
 =?us-ascii?Q?HwV8fM3q/g=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da64e6f-fdd8-4cc0-a109-08d9fda17835
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 05:40:20.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSFZmEKTQASoLRgp1JeeEL21v28PZc+VYuB59rxGvW7KXGWUAzjuNd2vvYStr3S4oMBMK61KmFopngfLB/58i9hAeeqoGpmocKEYAyGA7pKtnj+exqmCfc0rml5CjrzG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5596
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

Would you prefer this version, which doesn't have platform device/driver
any more?

--Ilkka


----

Arm Generic Diagnostic Dump and Reset device enables a maintainer to
request OS to perform a diagnostic dump and reset a system via SDEI
event or an interrupt. This patchset adds support for the SDEI path.

I do have a patch to enable the interrupt path as well but I'm holding
it back since AGDI table is missing interrupt configuration fields
(trigger type etc.).

The recently published specification is available at
https://developer.arm.com/documentation/den0093/latest

The patchset was tested on Ampere Altra/Mt. Jade.

The patchset applies on top of
  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm bleeding-edge (9db71e8e3027)

I also tested it works on top of Shuai Xue's new patches in bleeding-edge branch (c6f4ba2d2b9a)

From v1:
     * Moved pdata to the stack and dropped unnecessary kzalloc() in agdi_init()
     * Changed the ACPICA patch upstreaming order comment in the paragraph above

From v2:
     * The first patch was split. The most of it was merged to ACPICA project
       at first and later ported to linux-acpi
       (fd919e37cb15914c6fe13e13d530a4f732407c6d). The rest are in the first
       patch.

From v3:
     Fixed:
	* Moved header files in alphabetical order and removed unnecessary ones

From v4:
	* Platform device/driver stuff removed
	* acpi_agdi_init() call moved from device_initcall to acpi_init() 
	* Slightly modified Kconfig text to keep checkpatch happy

Ilkka Koskinen (2):
  ACPI: tables: Add AGDI to the list of known table signatures
  ACPI: AGDI: Add support for Arm Generic Diagnostic Dump and Reset
    device

 drivers/acpi/arm64/Kconfig  | 10 +++++++
 drivers/acpi/arm64/Makefile |  1 +
 drivers/acpi/arm64/agdi.c   | 52 +++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |  2 ++
 drivers/acpi/tables.c       |  2 +-
 include/linux/acpi_agdi.h   | 13 ++++++++++
 6 files changed, 79 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/arm64/agdi.c
 create mode 100644 include/linux/acpi_agdi.h

-- 
2.17.1

