Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD84AD31B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349370AbiBHIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349401AbiBHIVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:21:54 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EB3C03E95E;
        Tue,  8 Feb 2022 00:21:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJbSRC2rDn5/fKCTv/ApTQ/Kju1TpAQ+thjhK0L3nfV5ZnltdE7uRnUFrpqcjap7QRVzom+Fj4asNT6uTBJcWNb9A++klza9fWJZENmCuk/lb0ygtWF7vJ3+DAudemCFnXdorTQOJX/qBljeWaZ6zcv2KPJDj2+RzcrjvBkkthJYhkE53q9LqKjZ3kdTnxQFrVlwzc+JWA7kPOYGsVilvlyyPcpxjtgfl+NsS7kAOjjARK80O1t41DE3NEPKm3E3dZ3BCwIFxxDgP/Drshz9mSTaBXpYNbQD67ZkIz/k2F7LAve6gm4f9L5L60tjw8+YZLI6l8MKwLy6YKpQ+ogXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYJaKg28B6zoRTJXO1MWDAZK5xVdTJW1cs5JYv/Zggc=;
 b=U+uqINrBCvSQYWidRPo8TQ8gnYUxgjEKaWGX/V2tfRNvgDI7pUQQ7a7xgtrdYMXxmLbziapRSsv5bRNfnXlP/O7gng+r2OyWEIBIMsepMCljiCfIGK9TcSGzGtvQq4Kjgi2iEfMCjSk+F8qN9SS/FqCDBcXMh9AhekCDGn0UeroSRvW1TwBWpS57t9Y1WmD/sOjWsX9knmF9a5wSMFaXvTfSorRvShT7zoJh5LAuRYNh7nRrg9iQSyrwz74n5S6Ugb480bU+Hs/M0ElW8IzYAh/Yhisg4Gufhyf4c11cFBgTjeQtK7KqvK6/5by2iCLbGQ7sy3jcfeDVi3f1h3fX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYJaKg28B6zoRTJXO1MWDAZK5xVdTJW1cs5JYv/Zggc=;
 b=PHwB+hUjez0On6xTemg7EiTiE6K4P2BQ0wV8W6w0nprN7yIruNTKXGZ940+DuODKl0+jl/b4v7fNSa2kU7FiKYrbJffLKWG+E+NtrPdc2gmbtHUMdHBZWxbJx6L08OSspicNZrxoPK85vWFC/HJmB+JwZS2o2S0dZ9pqYWIagrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB5735.apcprd04.prod.outlook.com (2603:1096:400:1f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 08:21:13 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 08:21:13 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 1/2] usb: typec: tcpm: add interface for passing supported_pd_rev from tcpc_dev
Date:   Tue,  8 Feb 2022 16:20:25 +0800
Message-Id: <20220208082026.4855-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208082026.4855-1-potin.lai@quantatw.com>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39853ba7-4a82-4f9f-d1a0-08d9eadbf86b
X-MS-TrafficTypeDiagnostic: TYZPR04MB5735:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB5735B63C77D8F4B68CED32598E2D9@TYZPR04MB5735.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+y4pLwGLxzdtImldH7hGsLfmho3hTCPHUfj0zKtTOdAHp8dJiLXEMjjorykyRE9zADiYdRmDvxO5ImStMV/7Yo7c26RGw0dF38nL9w4j35c+TY/BIuy0Gq4Lqa2SjV3jzYmIgEXK+TvkjqJPEHzY0ACI4JdDd6U3fCPtq4QfQ28S57ntZHc0rmrRmlMYxnVAPXkWv1KKsL102jVCNFnWHK/QmQrLQrWsKZh98XSZWVTN6TZsexydKyA74A/+aAujA7gRfKbtVCL7T7EdC3j51sS4PRZvhERto0HPBC6F08MDeHF8tMGZBFiyrIztXAKECqNi0Gbqc5jjJ3/YtROMZoRzdnvGSTxUhs2vde1wUgrHYmgo7oojzk5UI5OSjGYESDjVjk6yydRWUkdCQ+6i3dSFRXXm9n2m5SEREqpsPpyNH/uHs3e1S4QnT+w3pvyNpHAnOUZHsgjGvcpfFFAv1jOxXZwUemizD7YVqaFa6giwxkDtbPhpvxI42Rg4Ce5Ur1P74ByoPi0AxDeGmQm2A1ACx9NLYVhMH23DNiGSiD6CX581ejlK++q8vIvspQuQbUNnky7fYule3Py8YSaur2x4up01gGwBJYhkC1/K1vTJjcUJVnqcrWMmo8lWJnZyB4yr7AUto2zz1RLGCZ7odA0qCCZl5GmQJrdxUZnfizamwWJmxTLiyCSuWDaXlb3/vakyeFwUmV1Cz7BiTYnwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(8676002)(8936002)(36756003)(316002)(5660300002)(66946007)(66556008)(66476007)(6506007)(44832011)(86362001)(2906002)(38100700002)(38350700002)(6666004)(508600001)(52116002)(110136005)(54906003)(6486002)(1076003)(186003)(107886003)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MeBuOigpU3FNFHWSLnx755ix+B/eDFC1cDb1LEjmuVwsjuKFbcdpggDJwxz8?=
 =?us-ascii?Q?SqezXeQi7oRBQZ7sCexrRw1Mw5V3+zIv5yzKzFr/pLSqna/BuzjtpCC+OfFH?=
 =?us-ascii?Q?zEHWVGBcHdJXhi+McCHxthc1+G6UdT0rqJ7CqAXA6NZXWt9S4fVUV1paDRxU?=
 =?us-ascii?Q?OyX5SGvq+HgQSl3JijGIx1oKbo/8ZWGcdTAXdwXrWdGftCpDJPKhXbiiMsz8?=
 =?us-ascii?Q?7Nbw2abAY3NItpV7WsepvfazRUoD2tqDJdlGKiWaEI8QC1iwbY32KtLp+SJS?=
 =?us-ascii?Q?nf91TNq3Cgp1440qnHVmS/q155ncu0F4ZA8oO+AEI2hMALMzDQSsWfcU6iOc?=
 =?us-ascii?Q?ZdTbZZOY3NvJNBVaA8okAvTj0BtZtPuryawJa7HgZLmt5lhaQgDShHwLidvN?=
 =?us-ascii?Q?JOQ1fR/j1HbsnqQfVpr4ysdt8rC+/g28pFcecylK7BJOQqU0xH59/wxM2WU9?=
 =?us-ascii?Q?VHnSbK+yWzZeF22oj5aZNzqg4W8nXw7GQ1/clOfNk5tf+kgRisyeeXbdqqlL?=
 =?us-ascii?Q?IUhb501oQeAZxfbCe+mEPamsvtXCUyeNTcoef0QtLQYdQwtkhl1Q76K0dvJh?=
 =?us-ascii?Q?wt8WqID8hv9jm0XNHFtojjgeCWgPFt8JIk2Wf47ek6KAH0nb91O4gYydGkqQ?=
 =?us-ascii?Q?Be/PgpSTWqrNcmNTTz0QB0pvOUG3QHqKkHOReP43tkhnCrPNKAT2/SGsOot/?=
 =?us-ascii?Q?/zCIUc24Ek5PDgd+IntCajlSaV0EZ+Rfl7LIUf70T2ItjwAMR2pEBtn3gzpT?=
 =?us-ascii?Q?Pe0gRvgc/zGKjdz6YOc4lyTRrNL0UpakqnnYW44p/Le4fBgZn/8U8KnzemCU?=
 =?us-ascii?Q?uKAGEGvmdOp2P+V0SGVqtuhAnUJ543lV90z0ObHdEWchHc8xks6MquB9NEYf?=
 =?us-ascii?Q?I2WYGprvQzhmA63dFHNB/E9j4c7cVz5QbjSJ4DRLYi1K3R6HLHU9Z4ijnhE9?=
 =?us-ascii?Q?BRdaAopx6+XlHiGzgRbkT71w9SquPp7FTEujvSTQzfVUm2FGN6SkzexM/Vkg?=
 =?us-ascii?Q?Ah/e1F/DAle5Gyiih+QXLNcbeU2AMy2CCpbCDBnUb6QpMOvXXwsMJDOsSZjJ?=
 =?us-ascii?Q?nqZYmpoI/9sHRaWx0cc3uN/ZhVP34W2qDVZJTC3LirCZNVlWg5DZjJ2jG3d4?=
 =?us-ascii?Q?qmreN2MJmJL1Dds9Y0WqtVMprZ4nGgt4HDZvzrkHUv9B0sZnNcoF+JO0w0Ox?=
 =?us-ascii?Q?Y0x6/DvKBAdY5wWpUNe0VoJS2pJAB4KF5js/IxFY38ztDYz3bc/lxcSHen/d?=
 =?us-ascii?Q?Qd2Pd3zx3ZsJVovD3nk2ivSFU1+gGBstqxgfbINM7KAxvOP0GhvWmKCP7u6K?=
 =?us-ascii?Q?JODh7rHYmjNAyEKVDFE+iopQ0f3KYzvGMXd2byraxMZXZFv5p5r44+4bImAC?=
 =?us-ascii?Q?hApBZcmXE7d3k44SY1xf5ymm1Me5q4xYQGWQHoXoZfE7CiTJsxsOROpZl5e4?=
 =?us-ascii?Q?+rznKS5+9rbi3lCD2WduRRlG0XeSqpX+XKv4E1+4C0Y0h1Rb9J2WTj//gICg?=
 =?us-ascii?Q?mM4h6DMGWPFjaLwYtJmKGJGXXn9rk1IlTwUAxYIliIwoAqnJ31plW8dl75Gv?=
 =?us-ascii?Q?VfVY+Exr3h+W1w8rPh3Itb1tQ+/x7ukMbaw4eoC//jCU6Jnhxy7kFSzzwaLV?=
 =?us-ascii?Q?gVCRw9D2wzlfhlLaQWGitGM=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39853ba7-4a82-4f9f-d1a0-08d9eadbf86b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:21:13.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adWIdN9p4V/AS0O0ofwyI2oPPym9bt4Md+6P7y2rLdJFLI9ZOLY4L3R2cAW3sMzXcd5kCws2zosLupv7kRwGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5735
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current TCPM allways assume using PD_MAX_REV for negotiation,
but for some USB controller only support PD 2.0, adding an interface
for passing supported_pd_rev from tcpc_dev.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++--
 include/linux/usb/tcpm.h      |  4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 59d4fa2443f2..31770fa8643d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -571,6 +571,16 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
 				    port->cc2 == TYPEC_CC_OPEN)));
 }
 
+static u32 tcpm_pd_supported_rev(struct tcpm_port *port)
+{
+	u32 rev = PD_MAX_REV;
+
+	if (port->tcpc->supported_pd_rev)
+		rev = port->tcpc->supported_pd_rev(port->tcpc);
+
+	return (rev > PD_MAX_REV) ? PD_MAX_REV : rev;
+}
+
 /*
  * Logging
  */
@@ -3932,7 +3942,7 @@ static void run_state_machine(struct tcpm_port *port)
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode = TYPEC_PWR_MODE_USB;
 		port->caps_count = 0;
-		port->negotiated_rev = PD_MAX_REV;
+		port->negotiated_rev = tcpm_pd_supported_rev(port);
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
@@ -4167,7 +4177,7 @@ static void run_state_machine(struct tcpm_port *port)
 					      port->cc2 : port->cc1);
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode = TYPEC_PWR_MODE_USB;
-		port->negotiated_rev = PD_MAX_REV;
+		port->negotiated_rev = tcpm_pd_supported_rev(port);
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index bffc8d3e14ad..36282b2a9d9c 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -114,6 +114,9 @@ enum tcpm_transmit_type {
  *              Optional; The USB Communications Capable bit indicates if port
  *              partner is capable of communication over the USB data lines
  *              (e.g. D+/- or SS Tx/Rx). Called to notify the status of the bit.
+ * @supported_pd_rev:
+ *              Optional; TCPM call this function to get supported PD revesion
+ *              from lower level driver.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -148,6 +151,7 @@ struct tcpc_dev {
 						 bool pps_active, u32 requested_vbus_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
+	u32 (*supported_pd_rev)(struct tcpc_dev *dev);
 };
 
 struct tcpm_port;
-- 
2.17.1

