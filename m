Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B414A4AD7A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358647AbiBHLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357472AbiBHLWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:22:48 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300094.outbound.protection.outlook.com [40.107.130.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E458C03FEC9;
        Tue,  8 Feb 2022 03:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqdxFlCfSXMxOaiH30ddkrfRQaIdzxUM+ojgLGnmkFlijhEbJI3kCxBfhEJ8hIU9oQTi5gPY4fPs0Zr48yfRUg1xq9BVPlssXQTKyU7hF5z346mOv7BTvB2gl3mpRdYblL8mynxi70fA5MPP7L1a9uUdKXheps6w0FygSFzt+5I07K7dVSX2XD4nstZUqeafNUimrXBqMywZGrUDNvSl4lq9NZfBe3hinG61U9Wa93OnKdHlLrxslMK7w83iKrEAtzk7hv6yUAabcyG26ntdV10AOm8K+2Ya16D015gCFqyYbb5FdE4J0cNXormGsJeIXK8GeEkP8Mr99Jm5HhFsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uekJxh1tQ7952yJtKrgo3y5Evjjxfb7/STpLoY/VKOE=;
 b=g9gywf9TfdXCHbbWZmFl/18yo5R6UDc6y/4ig8oK2lB9nUX/11jaYBahwcvgt1Tyu1FVf9qEhGbEZj2sKO60D4deZTrVIaT89TXKmkrqwqY6Ik864fJpEt7Id0r/m5bIfY14f0D6hLefWTdE/3FewJ96IWohPYRoGpsuWDsQCdujw/pNJ/OHE2Xx0E6ZFA5E2rSV0BATG+tR5hU7zy74U3rDZQfSWOQGOcLimYQO/pBkUJsFKpVjW1mrNNc+nVXNKFsatqW9decVk/5ji6IwHdvDf7kjkW8vV5XP8R5aAMxhK1KsTunOzH+oNLEpm2+uKhTvf1NX4f6cFv3KiaRHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uekJxh1tQ7952yJtKrgo3y5Evjjxfb7/STpLoY/VKOE=;
 b=soKrtgKChQI1WdFIz0CXLelP1dVMWy6gMIqv/EqtwlIJiMLu6wE2v0+/gSHMTPTcNeDlsr//kH5jzzT9lfrJkYLEKIw/hhYoU6iHXuy+WEKt5/2QpZ7ERSSlh9T7UFU/y4aN3rC1amPkwVtkFOOtCROrNIbgWekzN0dy8lcbVAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3805.apcprd04.prod.outlook.com (2603:1096:404:f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 11:22:42 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:22:42 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 1/2] usb: typec: tcpm: add interface for passing supported_pd_rev from tcpc_dev
Date:   Tue,  8 Feb 2022 19:22:25 +0800
Message-Id: <20220208112226.9108-2-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208112226.9108-1-potin.lai@quantatw.com>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
 <20220208112226.9108-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb8e16f-bb1f-4cde-008e-08d9eaf5520f
X-MS-TrafficTypeDiagnostic: TY2PR04MB3805:EE_
X-Microsoft-Antispam-PRVS: <TY2PR04MB3805977B5947592F70A938078E2D9@TY2PR04MB3805.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPD4MKOA2OxqtQDSpCB1+/EQmZjt4C9HC1KQpAFrIMkxfz3Fvi5bun2s7gtb5C3YGQAEK/bJKCNG8bU2i4jo7tuTyOB3D9cCKJVlRC0RzGm+S1gxGrzY81eqvu5UX8VnUWKMx+i6mekf9f4jKxJPxHBP0LqQHzS5X9WSoEU4gh0cNCjq+HK4MD7KyduzuKKVrc3BlTmB+DsyMKHTzitbOkAtQluHZWgkArcoX40UMYiwdydQHcJ6VfY25bEJqh6iI7EpuPlD2HS1h/utstQa8GLZPNtHGStGEGmfeMU44B3msTz8UZd2e2YjNN5xTkFQA+Mxil4jD1W7nV4l13zUVlKgHo2bFJYirFoAggh+LKCUyvtpo6nkFhyDzh5O2rDWv9jc5daO0CpTSgE5QFHl3mwf8IvDWVa1NCCzQKuGSWK4IIH1eK68QEjMqimFQawrMou9EvaZftyUHuoACvHzf7JBZgj7lrjrePrRs1oW8M9du47DzrxZwxMd/MjfXn/uUpQ83l3cPwyzJBfRkSyE4dE6zTouZk2ZJwqBLvkhK2KaH9BKsVXkgnF2c8uuZ5TWuUneq5c7jDFFpT9uZWD3WAy+RF3fPFwHYn3X+QMl79AWP1c02BRWzEeZlDLCpOfxWFTyozFkoPL1RJW5rHz/cVkUFZA0iWvte6AfioefFauE2Mei1Up9oZdU6SVAFRkOZpjeeB6zHjVL10YBkxy5Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(1076003)(6486002)(38350700002)(38100700002)(2906002)(186003)(44832011)(107886003)(86362001)(2616005)(36756003)(8676002)(8936002)(52116002)(5660300002)(66476007)(66556008)(66946007)(54906003)(110136005)(6506007)(6512007)(6666004)(4326008)(508600001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNLbUzXMvwiOZEDMS08T8x7lz/LukVueJWdtftiKb/SZoXuCf8brDU+XPW/z?=
 =?us-ascii?Q?ad0GIxG6lRspEeyQAXwFJtbEP4oErFjg6GHYLThhfqKHBwG/UmfrcQeTcOiw?=
 =?us-ascii?Q?tI2YRj/u+IHBH3LMkBJnwH373btTR00/mEixzuDePU7Bz5SX47fkJODkwmmj?=
 =?us-ascii?Q?ikB3fzc5qjUXIS3Hxoqlb4/wQWwl6PH6uVtNy8F3T2hnuecXcMh598LzvOCn?=
 =?us-ascii?Q?w72OIBRvPsnYtDcbj+tNejWr1yXMe94HLmuhHTS8uxJ97Tn3gx/bh2gnUOUc?=
 =?us-ascii?Q?/FsDlBiHwPxfasLcp3hlsF+hcJ0ZTO2fobEQ5PvdvWBm2es0Bp5HxpJJha1A?=
 =?us-ascii?Q?Ka/Bkc0+TiK1zjsc2CK5yVp8FDyQLWgGgwtOnrzz8WJqMb7tdjUSPMivSvdT?=
 =?us-ascii?Q?Yk9snNQ1AmC6ojog10nZlII2UY6IlOzZrvIU8IptxKb3bdCojujQcbcGxdgo?=
 =?us-ascii?Q?zZFgd8Vp6Pum0mvNnBybTLnn5N5b+3vjny1liiqEXr+uwcfB5tuhYiERMaOq?=
 =?us-ascii?Q?SGOWjhSO5VgSMH9kr7cy1wTvMofLQvdTkVCLSCP1YMZQt2plVpJT5LyPBAK2?=
 =?us-ascii?Q?TGnrqzxNGTTg32ZuP344uUK3Sl6awn/eP3+QP5LgUH+JDQWGWe836QUER3tD?=
 =?us-ascii?Q?j+JP5ApYitAsvtN+UbB8+NCy3GUg3RAHR8R+sRuC/fZRcD+SNp8hYj58Duto?=
 =?us-ascii?Q?uhu0SUVCuQYF900L4KMIpqYw0SjnuBwMqP4uIQrxPgeDo70kVnrrwnlkcjlR?=
 =?us-ascii?Q?CADz+eVSmekuFyLBB3vPisLVuLzfsGq3/vyhHpzSvI+XWiWquJB+wy+GDYDB?=
 =?us-ascii?Q?UVMQIAum6P7Rl8cIoC2Hb8vDejW+SZGZobYkxDAhocsJolYlMHZvj5jrQv2/?=
 =?us-ascii?Q?xL+Ho9ZNBJy0h7o9NO4uCbjAmki200GBsOOJ1fhrKcNu4/08rOygmCRAKL/8?=
 =?us-ascii?Q?U+UEtet4DclMicx9yy8rfTwC2NxVGUpPxWYAhKUoXTVGgHrYUXiZ1TcW6vqX?=
 =?us-ascii?Q?7ZmE/2OotC7ompWFnm9fKMkLTvo2R+ifEIoGc7UTxdBPrfXVIAKP4GowaJU3?=
 =?us-ascii?Q?tEyGci9lxFr+JeF5hqAiyFTcpckl52WCXrctPUZzEa+bT4ICZ0usKM/0d3kf?=
 =?us-ascii?Q?DXopdUvBnb/3Dm4mLXSDi/Hu+/eO/4+H9NjQth9G1XcKbsHFhZUTJaVLmrCi?=
 =?us-ascii?Q?UrAmchRqkbQTVmQvR4bJsDSdNAINNiZ4J623rM+fc0EUg0mJYAx2Zm5q+f7D?=
 =?us-ascii?Q?OEaRSghMDHVbRIBEHrJ9WKi+GwDjFpaua8eEO9WM9NlSsY/Q96gajLp+SGR9?=
 =?us-ascii?Q?Z6WewJtQvP+9l8UjqwPkr6cDjxdD8DOT4CSNNUAMVuO8kOhyoRskYULaucp9?=
 =?us-ascii?Q?TcEImzr/rZmF+5vvhred9F0323LeNZ8h2BzI9oZ5GBwvFZsgHl8MMwvq/55A?=
 =?us-ascii?Q?cM5D34OixoaRONfidcHOZiDF2iFPeZyGCOLnabkAkJgmQCYIklbi0Ysjoi3r?=
 =?us-ascii?Q?o5HzDRSZm6wsxQsA0mDbnuoTVGc3AI+GVUimkRIN4cSgO37i1M/XVigm99qY?=
 =?us-ascii?Q?LipJtSZOsof+61PiNyoss87sDhDybpG4HATDdd+1spzR/xpYlCrD6DlUudyA?=
 =?us-ascii?Q?COF5F40HkwHkjJ3is4uvYoc=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb8e16f-bb1f-4cde-008e-08d9eaf5520f
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:22:41.6112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkV0pvcNaJwGx3rFbDpABC0RB7YE/KkLIvO9V8p6Qb8+mV4rEm4VdbPQTrIaXqAYGbVGyOBgBOtbQol9+uBw2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3805
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
index 59d4fa2443f2..22e7d226826e 100644
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
+	return min(rev, PD_MAX_REV);
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

