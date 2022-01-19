Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3250D4931DF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbiASAZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:25:19 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23461
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350483AbiASAZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:25:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvLaxc7BvVf+xev5u41wCc2WBwaqo4iURwhQqGxT7K+e1Y5tDPx+ZfnynsfCvzAFBE+XUiWUmpQ9iG8Wng1EYbH1DP6Vo2mb4msMY4UNr75wOPIy97f/NIb3wJP4eWe60vFg6eCAzsMsvYhU85m2VtIBua4mJPU2RygpRRdW+RONoLfTJ/DXPpfG/TO9p+2mUZENxevxuEfTSg1yvP8mSVLZoyqmQY1bme59vhBhsCx8r60VePYGTRlRj9bqGoDwE0BPslkmQ+n0UuuVrYrfPbrOlItLjwqFPlhx4KpyvxoGOD5mIXy3BSgrw21dZ7x1aS7rC8q4L4IWmJUWKIETEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iTbNcgMHKQDn2UQ5Q4s8qZrx9GE3+86V4LoAq9OCT8=;
 b=QQsF3n236BkxMIvrdwA5uT/3JZlBE+UQQfGKpbGTs5w0QrwrTXqmfheJXbdDRqXPybb4Mj0ieq18RIIfDOqp4ND1wIpmEIk8iBuGltRE7+2S3kwTvvOMhz4n1a/ed90avceqTH94zZo6sDMsEGYYUUDSR58heeUDiBlzwhGth4Sb+rJSpJO011tLx/Hpf+9cx2MerdyfX35UG4DfTkwCBAA9ZfWnfV326xILt2KWcNXqUUkUfXa9yk42L1g3l1bYoPXLUnSy3qQtnAAUhMQL50/ELzQVZZymRbIrAyafrUAZqVnsmfdF7mpbkLcL0NRO7+vcrEQHNc9RleBOKHcljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iTbNcgMHKQDn2UQ5Q4s8qZrx9GE3+86V4LoAq9OCT8=;
 b=jj+ue/MVo79U3u/bjRZUS9q/xNtBLBOvRiRgXFZjs5hZzuqrXsQLFm3CBLhdESxh+ZNW5IGtn0Gy0AOUtJgD/awxVNxJaxLx05zR+oLq2tli9cXiWp1y7EVlPgO92pI9d3+K9RP/096qSR16OWK4Mop+U2Jngz6b3BWbIdOClb2+GYpMpgo/ee9bAHpZpEbvFyv+1/JvaQ81jRJjq26e6LXSSSyOic+2U4eKCTbbIQyHB9QTDDzKBLzXGTHkgbsU28xotM04sI04+9et5yQmMkcY3tXDf2SkbNibsfxWWZ03m0EtyAoU3ImCYEPmKSA6j+K3vES1mLSuW1+2VeZH8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB4373.eurprd03.prod.outlook.com (2603:10a6:20b:10::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 00:25:03 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::d47e:81b0:256:3005%4]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 00:25:03 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Robert Hancock <robert.hancock@calian.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Sean Anderson <sean.anderson@seco.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 7/7] arm64: dts: ipq6018: Use reference clock to set dwc3 period
Date:   Tue, 18 Jan 2022 19:24:37 -0500
Message-Id: <20220119002438.106079-8-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119002438.106079-1-sean.anderson@seco.com>
References: <20220119002438.106079-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7dffc1-b60e-48c8-0838-08d9dae222c8
X-MS-TrafficTypeDiagnostic: AM6PR03MB4373:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB43737C8203418E1F6786E8BC96599@AM6PR03MB4373.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDEjDsNFGNR1HZbz9XUBE0r/M9lUHyKdPO5IbVXZDzVT5O4f6k+Ew6Bk2rK7hFf2WYDCTLObexqgovjExEeASkSRLl2qgHnu3eFQJiewl8jsBdBNrckHsm1SnhHAqSYjrdOmxmuaPQxYH+tg6cZffIasIwPgww8Ko3KTsqOGUlaTZwCPdC0JuI+IdBU0SEuNVtYZ6UUdduly9LgqzMXMKhwZQglg+I+m4aoKgrtLkJ/m3s7TJFdkEZbpfP5ld3eGgfyDQ1DP09T7tsstsfQ4qbXmAiI1+q6D0aXFf9J5LokPrXUb7kt6ymSjlSUyosiAxtY6pnh4hoVldaeEUjsM1M9be77nN7KPCjkyBdIo8CqFyfD8XEa/DoS276EHhXrUgJ0sGsl3G05uqotBN6JV/lBz+GgCVmxVCxjnrngW179Sf1+SBSJIcPY7KQ2IwSjX9fW3ZLXvvmBxMVIFHOgW/OSCuCHB/TEovzy7I4y9pufxgHDZvkt0TmMa97fJhBu3pheH6eD9cgwqjSfkrvVzVU7AYiAFzTZKKTaqI6YxOZKVDrntKbDyjDB/Pvv3YbaT6REYDtTe5OK9oMpopJsAsmm0J4RXqymjZODQw+cR/2OjZDUK9cuBpvNA9UrMGe3kaZodVZ9WUqG09HhjpiJTTdtdSPDyZjKaIyfbls1rr1SQtGNDmNLSIhOl8nS0P90JXa0kxfMKmGXS65wSJYCqgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6666004)(5660300002)(186003)(4326008)(6512007)(44832011)(6486002)(6506007)(38100700002)(2616005)(1076003)(7416002)(66556008)(38350700002)(52116002)(54906003)(66946007)(8936002)(508600001)(2906002)(83380400001)(36756003)(26005)(8676002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T7nlWPx7Fbw7DQ5iBvqa7M71A+ZpE8cN33M3MnnjXBjzTS4On8/Uh6FHMLpt?=
 =?us-ascii?Q?VaslftwYzqwMBKjp7rtYz/nubaLZeRgHiFWRZ7MUK2gCyUQd1LRvxZW+G5b9?=
 =?us-ascii?Q?rYLFBFAbsZfT2Is4YyMy/w2MDwqgbkuyfzkYerVvsAn55so3y0KMGaOCKvXZ?=
 =?us-ascii?Q?7s8NqfgJDfJSXvp/WkOGWXP0qFatsKwomO/amKhLnBT4IBQIY0xhHsTI61PH?=
 =?us-ascii?Q?JJgREBvfg4vBtiGp5mCYs7qCAroHEXWaSD8aU0xqDZyEse/ZjflYX8hsvckX?=
 =?us-ascii?Q?90YeGKvazv5JSY2sc3GYpYZM5M6vKMeYKIaHXoTeyeNr8YpeDcnc1I67X8zu?=
 =?us-ascii?Q?8rGYe5h01qeJYzHw54zJKhpFE5yLV6uEa9ggyQGVYdhqQ3U/4KU9eVtmJI0k?=
 =?us-ascii?Q?HLTJ/4rGLRvCg/dzFuKW8JmurIiN+7l0ULOa/edskNns0XvHtw9Pu9zuEKEN?=
 =?us-ascii?Q?+TorUSUtqKhSRN8E1q/wDlqVrWlTE8XkAtga89MujRIhhY+cdv3Ba6qoD3Bh?=
 =?us-ascii?Q?5Yegx1baqLcxOByuR4F9bS8CS/WQDPzI1mOueTqXwm1cKT5QsCCLr4kUNfMB?=
 =?us-ascii?Q?Tombr9jiApsBtyD9duFfDeSzl2IrYGqycsm+4AhjBNG5rfDSAXNvC87elGid?=
 =?us-ascii?Q?HrUKU5ffuS4f4jCIAbKYAUcB5/u+AvTc6Ud58TEqh0p5VmM8lsLITjVuojI2?=
 =?us-ascii?Q?8xKujhqbnZ0+i7zkEXIpfxKpicPOVkWUufUfRs1zpOYBp1BYNzUZyFeQeNaC?=
 =?us-ascii?Q?RbuxRDdmSVr7SVifIGf6W9FS4aT7tt5OfZHX/fFjNR+r/wTCtiBC6r/SMxxO?=
 =?us-ascii?Q?ajChdfYHkaV/1xUU8Qt7w2DJwM/o4EE/AIK3mEiBGtqUui66lfdE8f+gYqtF?=
 =?us-ascii?Q?QMwoORpP2HKQvxdtFJaRwqObbyW0vxxizufvJ8chg8/TEo5o0AJ0R9awcxMM?=
 =?us-ascii?Q?MNclvIdB/TPzXYot8BAMDA72iNW4MjGm4aItF3eAbVUnmYPK9IypBbmW6roi?=
 =?us-ascii?Q?k8LB/Pm3cXgcrbjoT1lFznSiMtTcrw4wNQLa5QZ/4tvd9KwhDo76IfGezI+M?=
 =?us-ascii?Q?hU02uT65jxqYb4YtVWiyYiC+wW5H3j97brKldzJ4w0UZ6/GRyWnnB0mDVe+7?=
 =?us-ascii?Q?r+e3mk3132uV9XA8KIkWtTO5DHA6kUr3cbNixtaaq8lBVQ0j7QKNmJTM3qQC?=
 =?us-ascii?Q?j/mxLTrlAhCVwmjJp4s0W5fCuul0jn0ZyjmVUun52CfNf3VxCJupOlH3o4AD?=
 =?us-ascii?Q?iNdQtKFkWhCMEoI+RJFegFv4gbKz6FO6DLiVnx9IXFrhcPEspfDNJIh/ClpS?=
 =?us-ascii?Q?RysJ3pmjtqBOKw86SgckwA9A8wQFot48pZw+xn46wh7E7HTq5C6L3NFyL/Te?=
 =?us-ascii?Q?57Eh7yCqR0Po6HTlHr3wxtPzL4FxGNRKFdxXfvBDL878QrYMz0LO379Ly+nf?=
 =?us-ascii?Q?23VjdN/XkiGkYqwBWFWSEnqg8jn+W4+2rMEcyus/E4cr3B62OetVctMPN70i?=
 =?us-ascii?Q?hQXfmhz9jsDXt5PraeYMq54Ffli+td2xjRlEkzKiMXxzi4TQxUPWjuSewrVp?=
 =?us-ascii?Q?oSfKFVokLK5HGppoPSPt4P8XnRPknJ6COsGVwRvIh5n+07I71CZkpyNE905u?=
 =?us-ascii?Q?BspF3r1sCH9e6MFjV1nZOw4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7dffc1-b60e-48c8-0838-08d9dae222c8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 00:25:03.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37h3oD5KSX9LcoI0jw4j5/8S5D68Quho4R+zNFO821dzA4nHmhwL44pAdSZPaHSAx7+dyez48+YOZTsblR+rLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB4373
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually setting snps,ref-clock-period-ns, we can let the
driver calculate it automatically from the "ref" clock. I haven't
reviewed this board's schematics, so please let me know if this is the
wrong 24MHz clock to use.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 66ec5615651d..a614b9f73e2c 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -743,12 +743,13 @@ dwc_0: usb@8A00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&usb0_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+				clocks = <&xo>;
+				clock-names = "ref";
 				tx-fifo-resize;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_u3_susphy_quirk;
-				snps,ref-clock-period-ns = <0x32>;
 				dr_mode = "host";
 			};
 		};
-- 
2.25.1

