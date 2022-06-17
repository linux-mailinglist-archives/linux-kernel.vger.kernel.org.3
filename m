Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EFD54EF93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379835AbiFQCxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379898AbiFQCwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:52:54 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2034.outbound.protection.outlook.com [40.92.98.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B533DFA6;
        Thu, 16 Jun 2022 19:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvPB/aYu+270tCSYT+7KLoLz1TBhngJJ75ng9xMp5+oC2ccaFpFElWwE5EGvjnEDNzA/yWmaUYFVuwBDTbeAd+GeV3fszmtZjOb+531Ml0iOmWxk+nAB+xFFSnLEBCE6ErzKKlrXoMuBjKonXs0o2t7Dz7PfQj4d6t6WQiNMLvPgQBS5mmaK4rSG86GyhB2w5thirpE3/GDU9Yc+3Uh19Cv8rlIHJA2CrtYwSev84oRBDdrM/xqAgeW08ObbbGawgkW43HD290D4BXhWo3CPr8Xyu+rJsk80PkY7zwzK6BIGuopQLbK8mczR9FLomoq8gxRZL3Quyb9Z8qjFDdcgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUZAyrmTnAxc8dPl3kq0fLBG4H7+6qdOhlflpqwSD/g=;
 b=SKHCDf6mptHDpSGL5zGGrPA3lDEtJQbMwqlvMQg/SW04pbP204gkYq0caQH/fkPlPRWno46JG9iIRTvs6W4rDRfVHzEw5vppnZ08XCQkmp+g7OK0ZMORfULfYptrwChI/EMN7nLWnQMIkLDanvYpeyJdxuSsrUgZDFcCDoeEoCKzeDucaq7KTDW0CGmPgdT3wrde16YgnIJl/oMkMa2tEjsRSQh4uDrtPCDBGicr7Y+AzUzHQPQoj2PWl6FUx/FHkZOMAJPpVZ8rC2xl30RtWzGoUKEXw6J688UDxtELrUNlkykMhlCg8G78FxLhcxfmwwyFdChvy8XaWFG9UqbwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUZAyrmTnAxc8dPl3kq0fLBG4H7+6qdOhlflpqwSD/g=;
 b=AttUuBpvcP1RxSLjXeJvLK3HzBSND7PL5Xmv2fB/MOhotAjYBcpIN6fpIr+iZX3f+K6TOLyjeOYoSINzVNeWb3WK174+GR7GhfXQooqHNUlNq1b+fRV8HXo9cYpArRQzY1xQXnLykskD18W6yTHOyRbhrKIYaRqBf1HbOv0gcGYjGucVqtkX2hU/ZWwvPvhFfhmZhDHalX/VU5w9IolftkAweHjiRs2NWq9ScEjYtnzfifAnyHlWxsvDM3QlcbuDjosJLxkw81GUHAIneLD8wvLy/OGoeF6iU3PNHeeGVsWq1nLOsSbfb3PS03TpXaZ0DeK4EWGU9Ub15B72ScpfJA==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by TY3P286MB2787.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 17 Jun
 2022 02:52:37 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::9cb3:323f:e99e:39c1%9]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 02:52:37 +0000
From:   Riwen Lu <luriwen@hotmail.com>
To:     rafael@kernel.org, lenb@kernel.org, rui.zhang@intel.com,
        robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org, punit.agrawal@bytedance.com,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v2] ACPI/processor: Remove unused function acpi_processor_get_limit_info()
Date:   Fri, 17 Jun 2022 10:51:52 +0800
Message-ID: <TYWP286MB2601A75D517AE71EE569CE15B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617025152.1908638-1-luriwen@hotmail.com>
References: <20220617025152.1908638-1-luriwen@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qVOEq55Jm7sNdlDVWmjW5Fg8odwOK3GLvms6WHddSMM=]
X-ClientProxiedBy: SGXP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::23)
 To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <20220617025152.1908638-2-luriwen@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695331f9-4251-41a2-0820-08da500c7001
X-MS-TrafficTypeDiagnostic: TY3P286MB2787:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVgilwZJRWLIStDDW0QnB3mJppl4C4CCwniOQ1QdOGBRcbVS/ZFWRben4XNdfGhwEY0RK4fG95PsxEiu1T02pVuQfZiecXWdAoGBUeN9F6PfkdQBGMq2P0mGYUQn91RRF4vtaqHC3pIKF9eovbLcFGcx8HdLYF6C21KCGZs7NK32GVXa3Q/XEcRhmkjHrJQ2vjIRvsflnIt854wqKwWWfKkgIf+WjdB18PftmUHWJVjXn+ShEPDfpCWBAb89eozV4EGNeFU21U6t4PyfA0Ogwfq04r4N6l7G8PdfeB7ZVx5ZrZPYttHKSsqEbOvPffOENWuQZzjH//gL/ieT/7j87Tzs+Q80pBDp8+B0uhMl3esjL7dyXLyTG1CO6GFj797wd78Q7Pb6PyH5NQd9o8aba1q6PBh1AHe92eG1W5TfKtlVjiuc02MzHPnGzhM+UNJHGg6CKxsg9ilFIFcK+iuBXyhUB2t8V6LahUUfZuHc2CCyQ9ufIQlV87yuwyXNsZddSKaFjwuKfm7rjFA7BGknTJTBDBrOxOMsCuUuRCeqqyHPevmjWiCDxPvp1tI1ORbh1DJLg1dZmr/1SIO55dN08Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SWqZtTTqfO1wOwDpz7cHoJErWwdEH2tx57RB0TRVdBqioVRTVxYxYBNHlX9x?=
 =?us-ascii?Q?pTP9EmSEiea7dStIGhuGUwi97KRugP7MHQYZ9yUk6gxZe5mIryRbjTjcoOaV?=
 =?us-ascii?Q?mjvWFYJtagoOwiwrMilx/80pEP3bibxsLkQ+uaUccQeaVv8AW4ehV9vS6Nq4?=
 =?us-ascii?Q?U7mHPGjhJvO3Zh0KLlbWmkXyZ8BzBc3ceZRq9k1uQhfM9gNX9oFrAaL+yx4w?=
 =?us-ascii?Q?aaNhg6ykIfOq5TboVroqJZHN90CxVcNIyYpV4DdC3MSI/yfcECCFduj6a+51?=
 =?us-ascii?Q?X3g47JTyaj/m+iUeHGJrSNhzMg2JVylFI9sm9VU5PiPOaItE3IumuLRUcBTr?=
 =?us-ascii?Q?PjuGgFZAr6+cIWISEYHhqoi0+goOImBxL9rpnNEmeuslfAedGuurrVLJ1x98?=
 =?us-ascii?Q?8V5+E28vMF6KC4uEyn5Y0XrpI4KPd43NxAoe4+JNXmZT4jrKm7Ck4kpzbuVq?=
 =?us-ascii?Q?HtAK9wKxeatjYYbMUAzP3LtZcxAaEVcDZCX3rz5BGvCM49EUqAhO2eC8NkMj?=
 =?us-ascii?Q?R+1mXFw/VBfZ/FzCn9yiO+C4oYeL9NjhHEPHD6liqRG4sXkQRSyJarIYxUay?=
 =?us-ascii?Q?ozz+PJ5yn/UbP8Ef48bX40E56qGU0FONr28nAtcvuZJ0pllgOKbErdP3Co4r?=
 =?us-ascii?Q?1DOcuwNGle5Hv0faulbLp8uoH3Mm1XgKBtylgXSgO0lhWwu2T9xJmRJtidZa?=
 =?us-ascii?Q?FosUkIzPWREoYL859MGr8oHRRtkGQQKb9BLG3ZpTb8UIiuVYtAt7yNwB0Fhb?=
 =?us-ascii?Q?Ec05Tx8hMhfLmiyDPJwEosP8wF/qwgv0m0lIHNzGHCy9kvAPYzS9n9amaOp3?=
 =?us-ascii?Q?Lkafk+svAoHqKBNq2LOC9XAfWr3hMMsy53io8qkqUm5JdvNtDz2SjsCtmzR7?=
 =?us-ascii?Q?xo59LWp1kV56+DLAHonr4sEQgM4TR7fV5rjoy2hATFPnsP2yaBmod7hqYtpI?=
 =?us-ascii?Q?skjus4cqURSpaXaC8HzAVezq7L5t6+TF1hEUJcTMWGqboQUAALBw9ohI/WbU?=
 =?us-ascii?Q?Uxue5mlGbwwZsISVt4dHbZlQnO/ofkJs7Pca44f/LoHRWdnkgxhFA4Hrb4DM?=
 =?us-ascii?Q?hcSyDunV2+OK5oAkPNmImJCNEq7YaPar/6hJLnMs3Kh8pZyWuG91oXbJM07b?=
 =?us-ascii?Q?nQLt+F6HMPH8Xc1iGqN0FGlucpIpinWAPSv0idllUG2Qic4F599uKDW6uFV6?=
 =?us-ascii?Q?+XLKZs6zs+OUqFr7gBryXZmYx4aKS29INBvpDrbCjX8uM+nZmE90YuLQm8Tc?=
 =?us-ascii?Q?USY9HBd7wt7dN6ipH20NNXE43BkHz/QDCQukRchnHq1AOO3O5/t/Cc+9Xgs1?=
 =?us-ascii?Q?eg3/nV4+/2Ws9BCsvuQn0IJ53AxVim77ba2lv/c/a+r+Jy4r4mmu04HxF0LO?=
 =?us-ascii?Q?01j9n4L8FJrSLLqEKtjMaNAqrnAVgXk4q6alf6VgKFfKo70dk/lKz7HRJf76?=
 =?us-ascii?Q?ICf7x9d9WU0=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 695331f9-4251-41a2-0820-08da500c7001
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 02:52:37.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Riwen Lu <luriwen@kylinos.cn>

Commit 22e7551eb6fd ("ACPI / processor: Remove acpi_processor_get_limit_info()"),
left behind this, remove it.

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>

---
v1 -> v2:
 - Make this patch base on ("ACPI: Split out processor thermal register
   from ACPI PSS").
---
 include/acpi/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ba1e3ed98d3d..9fa49686957a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -441,7 +441,6 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-int acpi_processor_get_limit_info(struct acpi_processor *pr);
 int acpi_processor_thermal_init(struct acpi_processor *pr,
 				struct acpi_device *device);
 void acpi_processor_thermal_exit(struct acpi_processor *pr,
-- 
2.25.1

