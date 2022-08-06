Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F1958B4A9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 10:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241765AbiHFI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 04:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHFI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 04:58:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80118.outbound.protection.outlook.com [40.107.8.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F5F13DE0;
        Sat,  6 Aug 2022 01:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaeO36OZrr61x9RFTJJk6zECUItGkknsIgRUBK+MVuN1TXFss9OBXsU/sFzhol9ZMPhCrwIrM751oJmv1hMNy5qRU4wycmKcnqmQbevcakFlqs9sTMQFAuYcSK8nU56he9ETIgaSFU47nmkZ8/WOUv6y838lDoZh0bD5Ehip+Z0GUI4b5n3KSF3JGMooSdLn3W8A0hNcA0R03o1OMpkbOPJ+qhfIGXoyfD6Nth5dKz0ko4ec/oH7dbkGZjx1nEqLSCBu+Z3su7juPbDzQjqenU7+oB1o4DNbF9c55er7BEMZGbtMQNZNVSU6clY/eLqePe1tBwxpT3aNATF2l+5Jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLrQNMXk6wk4LeCcR5HW/CSQ67QPKhPcTf/f9Z6ewKo=;
 b=VRDs/TQ2Dmtt8HBOiqchZQ7t0xPwFlLwC+lQ5uXDdEjEe8OGy3vWItVzjDsjQobcROkoqgTo2GYvDjiGNa9VfBfXT3S4Yk8uFgJfl/h2ojvL4372Is4gzjJulYNkw1atVhkkcpPmvys/ZlX1vjNv8Q0h/qlwMyZhzBHOdjesoT0bqkl3AVvLo/E0nO+2WIG7a+mFCtr2MY9h2w31KuVRuChGQ0l98QZdo2S5fEkhYRsgSXJpgmtSd1fqttjHWyl7Lx2G3jbnVupGFXvT1eYlA9rL530iS+2kJxP1+i6KHSDaR7hVcj/Tth4+lTts00N/ZYL8aVHLV8uftpGwllI9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLrQNMXk6wk4LeCcR5HW/CSQ67QPKhPcTf/f9Z6ewKo=;
 b=hPDOMzr9745STfwDogCzMVGVcc2qyJjGVURkL1Kg5h5zvbrbAKIYNGa6/XSFlCAWQ2uS8mbEm5ZAI4/MZ+YKh8WF0L8VVyHvwZG/kvnuZzgabcThxT+K1sWl9CbA1/6C9qhKjbgOyXtJYPLIKiVTMpAsykxHyACNQ6GN1B54UDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB9P190MB1098.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 6 Aug
 2022 08:58:51 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::80b1:f2a0:4365:3c59%3]) with mapi id 15.20.5504.014; Sat, 6 Aug 2022
 08:58:51 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH 0/3] mmc: xenon-sdhci: Try to fix 2G address limitation on AC5 SoC
Date:   Sat,  6 Aug 2022 11:58:11 +0300
Message-Id: <20220806085818.9873-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f139fd46-4920-422d-95b6-08da7789e1a2
X-MS-TrafficTypeDiagnostic: DB9P190MB1098:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UANE5UF2JRb3BGWkk1tW5i402ZfY5FA5Ip3WI73jDZMz8rnXsKvbAbh/yeg/z/ur16zLRVwc7Yub4abdXbq0jwAyO3TZgKBF1AXB+s9W0fU5qeMINHvVqJkuqly2IRWANYPa7loLycLSFvvi2i1RKjFsnqGx0ESqy76J2Z/HlQDweoLVLkH92IngGGOLHwQewil9w0hkWH6Q4hH0gaRbxhkimpOFtQ264gPCZsUhL3Iw8NZNaEEhSjTc46KocE0oyGw7grnXKlABMnryLkwN3XjCwaIIgnJhfz0xysHoHkgTvLbd4B2ihsBkKGlDSFGyBtQm1J/fyW+lGE/M0kEyKKehdZbuOllcphJdU6FvKXBHFOUpSdsdpEiOAIujjbvR+Jz5MgSBzvt4Z/LEY4VkEQf3IoM1p1sd6ulk7KYHsrVoWQgdkWGcVswwx8ccx2iKNf16KtLiRbRFAjmdUQdE79iZcny0JnQ07nKm7dXhVZUcY0ET/rrKPdQ8Q9pkRtV3iRHwTgVXblhgaechy70jfz6x2koWZTeDoz0m4aZu3Uzkdv2fBpzwIwxuBNl7HO52IgZ+5X/HRHWm7CE8OHhNTkgwgmvx+ugsJlYv8fARQMwbIvVK+zaYY9V9fUIvF9I83oCV6Verzw0xEiRiweCO7xy43NspMXTrIvdQ9Gz+QV5B4t46DTRoUrpKWgZmd7o6GwW4FwLfqVYZcQ8d2isWBaojpv2ydfrRTPu91gH0fyoMcPd3VE16V01oDGz0U595Kye58qVEmCh//st7hxQArCmbKzwQA0rCwYT7n1C4Krk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39830400003)(34036004)(366004)(396003)(44832011)(2906002)(41320700001)(8676002)(66476007)(66556008)(66946007)(4326008)(508600001)(6486002)(316002)(36756003)(110136005)(38100700002)(26005)(41300700001)(52116002)(6666004)(86362001)(6512007)(6506007)(8936002)(5660300002)(38350700002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?96KENcWC7hCSKAJjBx2JsX9c2T7rm+S/AFnHI/YkoY19de997LilaVu4QL25?=
 =?us-ascii?Q?+ptmuoINFAf1/T+a5b4s39WORNOwLbnVV9we8/26nLDSoDsWfPyL5cqOrZYK?=
 =?us-ascii?Q?yX4hePTYBfhtAzRA1Ur26DiI53WG1fLFnuzYbddpxsESDaX/vIXW+7Xu/1eZ?=
 =?us-ascii?Q?VcRpkvSMU7EG5v36AMtXKtmvdf9tEzWG3cI4oP0SelPKb9Lnq2LN/rpLzViC?=
 =?us-ascii?Q?q9QItBKmoj5PsupJvchq2JCOmljWC1E4M8YvEDHGxceKE69qPvFLG+wnYu6t?=
 =?us-ascii?Q?YKAbCUPEJuBLbclmvlGN8zSsAIhumfymjR9L2MRf/QaFAU+Euo4U0p3Zhl3R?=
 =?us-ascii?Q?Dz/lLWgoFPDv3yX2xInuQzAG8wQHIfEyIKs+qxvQwTIoAmzOZ159SzKL/toE?=
 =?us-ascii?Q?tkTLCz2LlYYQVqRE7Jtct0QYuJrzKNsPV4dNTdmEsTjeIgAM6FntLnpf8Gcq?=
 =?us-ascii?Q?zWBBIWkCxzHnUNwFYFfc9OvPwO4dsw1JTiJft1QlR6mwTn0N1kozIx47wYnq?=
 =?us-ascii?Q?gcaYN/lBkXC1tMS9awZIZT6CSX+Qys9MzQR75oPoHQb5l3bAYLF7m4Ugxf2y?=
 =?us-ascii?Q?OLVx3Qha6hUEOLsACy6vs6I1kH+iQKtB/BJhLXij3vTRSJnSs8//uv3C3aEb?=
 =?us-ascii?Q?0QdE4UDDpVRtooLOekXOZrXywR/9/di1jHSxirSFdnc1bQLDcfpWxYz2LTkJ?=
 =?us-ascii?Q?/G8wRMZuy/TNh9BjrqIsM+/gWHYdoSAjMMElhBOn1P5j9XkHUeOCrIwE94kU?=
 =?us-ascii?Q?WYH2BAkXtFWucWaSIZYFqJc/Z+6NUC8ybbTegu3VIxKuRgRkjd7fi1AMMtLt?=
 =?us-ascii?Q?I+nQOASwxlGM7verUqmfa4xmU4wHzKWG7vdZpqedBVv8+hrx7LUuuXqeh+QR?=
 =?us-ascii?Q?nYlH4Hp3jR5jdUcsn9hRAVKeS0OD+DFFn3RZ7moxIVFboXVlHKgqsK2vgR8r?=
 =?us-ascii?Q?v602qoswQWi4oaI5mrXhh41klVQ5reziECtpscRfWWY2JQrMHOdX+PRmerDc?=
 =?us-ascii?Q?M6wt7rWVyXCdmMAJ+VAUTY/wlLBuOFMpSMthkHNBKeoNYVgW869JVIEUQGqn?=
 =?us-ascii?Q?ZEnw1AHqprPxuK/9bqOhyjNmA/sDZ6b+e4pnT0HylWA2AZUmpuldVFjE75jT?=
 =?us-ascii?Q?SDQ9JbIBeStnK7EGBKBd/z0rRuj1Ba+e3BScegHZjKOIPx7Ex5rExq2raKNN?=
 =?us-ascii?Q?bMmq8kyy1hLl8MfCTieiR6OfXq5YFHB5quoLBuzavOp1OnAQpkptFQIYMfu8?=
 =?us-ascii?Q?wzgVwavoXZ3C+76+U5m75hjcWfOkeKJp0Esnt4ZONxes2xT/4QtVVVLQO/1N?=
 =?us-ascii?Q?zyBL6K7dcXGzRsnfU+PsUsGCSWkhNDyYIYf4tvdPVVC1u6OutqH6ttCAJzG1?=
 =?us-ascii?Q?LscjkAYiR1H6Wi2i6Ra454dfVgUocPL5/BkNG1vlWtQ07y4Hg3qSfFyc9sqU?=
 =?us-ascii?Q?il5HcuQhRRszQhfDDpIYxjPRAayOtkII3QsS/y3MSpdAgcK0dMYSj9tXF1+u?=
 =?us-ascii?Q?pt8VZdDQocIf5y2V6YFjNRU7HftfOlXMf1O5UWEXe1op3nzMItDbLFRhV4rj?=
 =?us-ascii?Q?xN671uzD2U8lDMkTzCIbLC+sAeSpDX2TrrYDQ7Z7CiaBs57dH2hFseljyvR1?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f139fd46-4920-422d-95b6-08da7789e1a2
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2022 08:58:50.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va16yYAS2mqK/Kt1eWhP4TeLJk0RDdLo/YqgjtTPHQWxmC3+YRkb+/9dTsxtQTh/9nOv8HuzPQoyQiOZuFvV+L9rJfg7sWiOcDcuEMomhSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a limitation on AC5 SoC that Xenon SDHC can address only
first 2GB of memory. Turning to the SDMA mode to use the bounce_buffer
causes ext_csd recognition to fail on init.

Using of swiotlb=force also does not help as it is allocated at the
end of the memory.

So it was decided to use reserved-memory as a bounce buffer in case
if the board has more than 2G of memory, or turn on the PIO
mode if such memory region does not exist in the device-tree.
There is a custom property which is used to attach bounce memory region
to the device on demand (only if more 2G memory is used). This is a software
property only so it was not described in the dt-bindings.

Separate DTSI is added to reserve memory only for boards with eMMC cards.

It was tested that this approach is 1.5 times faster than PIO.

Vadym Kochan (3):
  dt-bindings: mmc: xenon: Add compatible string for Xenon SDHCI on AC5
    SoC
  mmc: sdhci-xenon: Try to fix 2G address limitation on AC5 SoC
  arm64: dts: marvell: Add DTSI to fix Xenon SDHCI 2G limitation on AC5
    SoC

 .../bindings/mmc/marvell,xenon-sdhci.yaml     |  3 ++
 .../boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi  | 40 +++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.c                | 36 +++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx-sdhci.dtsi

-- 
2.17.1

