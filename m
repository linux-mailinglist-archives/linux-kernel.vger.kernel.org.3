Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8D5448E4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiFIKaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiFIKaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:30:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2076.outbound.protection.outlook.com [40.92.107.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214920A080
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8i4Re1EoJeWuL1mYdy4xJ2JwCwr1SfaVSoeArM2Hn2yaDsz5A8aXE/5flKi/jQDqHyYCw6P5bNpm4AWIOcZm5yJlACkmlhNXzJeKyiPjcOqv4MORjfZ8m1VccIp1t/zGEUTilZ+K/SSWCrVo2GdIKAbTwyjIFtkURwPZFeiY9xENjro/izolZuyeM+jy9l/9iNMbJ1wX8T2NM7nsNoiP8PmD+aKubrXw0tjmtqsJjKmlHb+P8IrsgagYZ12mEqbwC9q2ik5+H69DcnB6HbQiplNAKna80aIomOD/b8bsJwdjSFBcGcMQFx8uZcP88wfnoywXrUvMKPqeqiC3/OdBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvgOYuOPv2moA19OINoxDOjiZIr8ezSiG6KJfoBeH44=;
 b=JtN0pqUITyQYyyYpZwGrNgTwdjrFBfkoj2QYUhQ0qKbXS4ZbNgJMEtj+kuvxkfTBxtC544qHRu+sHCid7x2Hf4Qelxh5/GnsyHmvvrk+Q/7RGtTWNligV1FId2ryoXsL3cjzlt5TOJgLUs8N/7G4ZyMFnVVVEo9PgsP4FUYghpIA07F1xQqKQS9ogIg6i6cS1CX0U2R3kV23X6I3L3oW23sd9ROWJD05SjjZTfBQq6+rQFkpG1z2JZgaLZ/YQndO7zqboxh65CLxxZWCzHSS0O1ljgN3oYyHoQBjE+m4KnEnagp8ACOVqzQIxfO0fxWW2YhO/S6ahKB/qwCP1ZYEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvgOYuOPv2moA19OINoxDOjiZIr8ezSiG6KJfoBeH44=;
 b=QU5y3jf9Mec32A+ahiMK5rFe/JYMPxEzu6Uq6xhyeV+4vUzBJHp0Lpbeom07A4nkgAWjujB+eEwya9VU+pGxXKho3qekZTEbLCclWX5oNzDYEPoolT055C1CszgQ574cbVUiw7Xx4z0agUxAyVIMynqMDFyMEOkmk8mK9puRfYWZv5K3Zkf20B/rwpm3k6Zjv2nDLq6vIvJCSM6SWShAzgb/mIaGJi0iOAf8zYlcx0dYFvXUUjXVeGkEvHx6A9fGzmNlM7hyBsLpNZWxCO+pkvTlSvxn0u1MKMRaD81rEJlxfwEBuwcSCDxsJamvY6kfACcPzR31duRNAHKb+ijm+g==
Received: from SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 (2603:1096:4:76::15) by TY2PR0101MB2607.apcprd01.prod.exchangelabs.com
 (2603:1096:404:b6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 10:30:16 +0000
Received: from SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 ([fe80::a1f7:b32:baa1:3d12]) by SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 ([fe80::a1f7:b32:baa1:3d12%7]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 10:30:16 +0000
From:   Wang Wenhu <wenhu.wang@hotmail.com>
To:     gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Wang Wenhu <wenhu.wang@hotmail.com>
Subject: [PATCH 0/2] uio:ppc: cache-sram driver implementation
Date:   Thu,  9 Jun 2022 03:28:53 -0700
Message-ID: <SG2PR01MB2951A22F0FB4B17E284898B19FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [1NoisRLF5HCMdrjJSB3qNTU1k+sQDIVr]
X-ClientProxiedBy: OS3PR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:604:db::12) To SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 (2603:1096:4:76::15)
X-Microsoft-Original-Message-ID: <20220609102855.272270-1-wenhu.wang@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10846fc5-e50f-4555-4d86-08da4a03094f
X-MS-Exchange-SLBlob-MailProps: EpEO96k6WonAGWAYIHxzt372mDgmmxv3apB7nGlCULGCj68c1CUhNkYVlEMpm0/HC6qtSlQRwOuTlOIrvKMbVfMI5vDXOkpC7dXGopjFNb5Deog2oGYXQnuLpFbYJy8cqJxPJ4vkzSQK7JD6uSfSlLcf3SMeMudGSP9Di8+6R71LG7bvHJwwPWTiwAldqWfzkea93MobM7sLodLSZgv7g4b9JhskPM0jnqPZSEtpRjgdQlAVkwIkufAK2Ru8nIMw+39p8LXKY1LIsejwYBtjjFt97Ml5ICq/u4PsrOxc9xFJ2LB3zI8fm71YrK9CiN3xuJB9kkLPaTkBptcCAokKtdKTKfLay0BzL3X0sJu5ebRVDoys9sbLyajBWWcEhhIlt7cIEvyJVWjLMY2YJ/DtUR7OfdvvjjN8yg8Vdo2tW2GvZGs38KArWr3QPe4nbgG79fmx5cpBUWuyr2MNFq5hXjAjF44CzMzuAkdztRYtBwmO/C3ta/REuNTs5o+tVuyAS6hdQzbO0doJbjcoM+NCey8dv/v0SjM9Ipwk/aHKPNrU3HEHlCfHf4q4zXHz9XXyW8y+REUppJ140I/6UGcun+yiECdySts6MiMUZBe4SSb/q9NSlJ/THhrQ/ySmw3F23MmMCcT1d5cfwnoGUhbh6n0BdrSePrfsIVz8J6FKeoQHUMQBhMzVqfKRrPlDBGQidsHboi94oSyj87dTPL89uEeEig2jJvNq1WEhN+dU7FnTg92w3KmiETHiIZgodZEB5lZm/IVrlM0=
X-MS-TrafficTypeDiagnostic: TY2PR0101MB2607:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5YkcuhvbyQzp9LCwX2j5227vRL9gi4gfBgXxXq+7jqRVGtAQVPIWxc29UWA2bPyortbrki26sQRYI6vFPz3lpQl4/OO5Kls2jt7KWqdZ8brPQXQ7gKaqR5sn9VYJyNrJNU+maN7Yioidpwrao2qEwC3XHAfyezNm5B5wN/lUM2/TDs9eYW6t56eL5Bxkvb79kNC4zmMAD8hxvOY3Vk2egHcqSPbIsGimXhk1wzec9HBCW3aLD0g2cvCc3FmUuNrHixAu9Ggzqd0A0KalpmjOuvFdKFfBcvxAW4iJIli0VQh0M81ZsuyvHTedq9bEUuB5WCCKSMAz//lwoCmVVWqXHAM7pu24EkqMIP1ldyDJCadJfyoIemFAPyLANr93a9ta3kevCtowOE7IN9b3+Zw0ltpGu3DW2EB3ya+StfhIIjefk3hLv/aWvqHAmcaRRYHuaqMQddcj2tSrF6A7gJAJlWs8r/qJzauTtlLkfDg6hOio1ZE7YuNKv4ONAprYy3YljPOqYeXa6ITV6Do035Cv2GZYi81Ibt2tZZA/bMa56QS6QteOWw6qEGuj33RII/iqtMkg40uAkGOQS+h2ZSPVIQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHO8dDJuazR/jVZI0t6wRNY6QBcMywnE39UjsJBD9R4v6fA2GI9nXl6zb7fm?=
 =?us-ascii?Q?GNURr2VnYURTiWUjacGSWwOleNxVVXhU3l0V4xqVAu91DOxmUgfGKujOaSxL?=
 =?us-ascii?Q?0f75U5AcNyW2XqQmHfp+sWE9zIXz+rmi/kEfElC1ssvy61qA/f5GsRPzx3O6?=
 =?us-ascii?Q?ZfihzJej3fnxSlaEzoC0pO2E5sito5kJiwSXr6/CpplnoTjH7nCCnLkPwWoe?=
 =?us-ascii?Q?foerHybU6DsicclVEK5nwP3A5sRhw3PlOP0ko1xD2lHyjyeyLHMwNQha/8Mq?=
 =?us-ascii?Q?yDBXvQquZ32N7LgPOSxdi24sys7lEYqa/tOsxlfws/Dmo0pDyJv3wHKpCB9z?=
 =?us-ascii?Q?muG1WS/1nbwyz0REKAkDDllWgOsFdksqKv2DuRTF3MX4bm8QzWejWmIVQwqi?=
 =?us-ascii?Q?VSIjdnyQSkVViC0/DAG3Wcj5tI8J2/GrC13Dl4S3XgrngfRXUuGSYr5tFsq3?=
 =?us-ascii?Q?8t6RFRwSNIaaZBXZXxLuKjvzBpNgvra9nWPK4VyonNdAFKMybRSNPvw0/UOM?=
 =?us-ascii?Q?eUM2Y+Q8h1O+2xZNQW1b1OCzwsb9qQ4Trl6ftByfvd1LHaslDwh0dSYyq37N?=
 =?us-ascii?Q?RccGWf/i4uIot7qte2PAvjvNGtyuhVC0olMmeNgE969+KKyK+jpnLd0SkyR+?=
 =?us-ascii?Q?sEWl+ShnvCJ86JkI8TSgJ6otZO2h55+njY/sM7mTIW8OwBBBmjGi8cHBBFe/?=
 =?us-ascii?Q?CrEm0ZvK8oJTfxuJ9YS40TBIwdTwwr2mfSz7hhDS+Lt6WlHsdRK0aRy0CPmE?=
 =?us-ascii?Q?H4IT3wwHwH6feR7yrs7UXLyWDQf6R0T6OUtWZaqFRv5gSiFaUHKewjU20rVm?=
 =?us-ascii?Q?csGIUX+y43djbXj52rs3SN81d3fMzbEESGwMCpHcNqp8jehTx0fUw+4f8zUa?=
 =?us-ascii?Q?iApd4+6+xLrwaasCx2C17VCLVZiNtdlmypRkuVHTGAW/RnfFNHigTHZWFF/G?=
 =?us-ascii?Q?H9HImyusF1q+cF3JzhWtuq+fDhiRti60Tj3yySznyJYKbVbFaq0Lg/3AsyYN?=
 =?us-ascii?Q?H/Na2kVbAGc3oX07jvRepgrB2YO8kkA0WTeL+ufrwzmeBzfKQzWksEPQxFFe?=
 =?us-ascii?Q?AKIUbxb2E2bASfsoiJSAEFeMKbphSjMCktI2Gu6RqAY6VomWzvxs+jJZKAZK?=
 =?us-ascii?Q?c2cGeK2WatshsCLVnFDN0wVxdT/TwSVsHUx4qDHrusl0hSVGGb9E5HinniaN?=
 =?us-ascii?Q?Cu4nSCw/oad+ObtP7wRa/JjgCTqUPcspVqQuyytJL+Y/+vsoanRNMsKDf2cf?=
 =?us-ascii?Q?ynazAXvCqpgEjKGb/lGJ33aMKwN2Rq2pxtB9mV0Nnr+Y9U5TrO7748BRV47v?=
 =?us-ascii?Q?yI9JvR688PJiZYcrXT64UBylnmlOXxs44FZCpHUVERMoCwtHv+oPaIVeTnlM?=
 =?us-ascii?Q?uwymY84NC9klrCR/ctf7dQLP9EtTGP/HQl/fdD1pS5aF74xXhSDxOMhyulLn?=
 =?us-ascii?Q?qM15r7jj2cQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 10846fc5-e50f-4555-4d86-08da4a03094f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2951.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 10:30:15.6018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB2607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 exports the symbol ioremap_coherent which is used by the driver.
Patch 2 is the implementation of uio driver for freescale mpc85xx.

Wang Wenhu (2):
  powerpc:mm: export symbol ioremap_coherent
  uio:powerpc:mpc85xx: l2-cache-sram uio driver implementation

 arch/powerpc/mm/ioremap.c             |   1 +
 drivers/uio/Kconfig                   |  10 +
 drivers/uio/Makefile                  |   1 +
 drivers/uio/uio_fsl_85xx_cache_sram.c | 286 ++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c

-- 
2.25.1

