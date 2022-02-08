Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C74AD31F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349426AbiBHIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbiBHIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:21:56 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C376C03E965;
        Tue,  8 Feb 2022 00:21:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVvVK411rfi5211gggMZxVdSUG+EKvRGAdULK44KsHeoDixQfFDMLQGWgfNiXjw759zGVgF1EeTxR/Vvu9hunfW54ca07utaybNceOrH9bS8rkHQ3uvw9CROel6c+anpTgeN7rpaaJaVNoLdhpGYGq4W1MfBHF+3c3SVCyHwPK4V3GW6SlXlVJvT3edDHvRuHnl9aPRVz3JpEIQwN46/gbJzFVKyVJ36tiyJOeVlRzdPiyeb93p8DcCpDhQTQANRsX2cgz8dHCmRO2WlAgMgQadYCtt5nkFulxRLoT8UM412JgWC0wgCppMonRFmLQTVlDviFkpkd0+PphNlb2Rc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgkJPhZdxaN4k8YfU7okIPfT6UEZXl2XOC5ZCMGyn84=;
 b=gWDUraLGTxFlg00DRBrq1QH4Goz8dv8VHQ8K009gN8NP03N1uRSeZz8SYG4riV9HUn38QXdtX6Ro2QwW1iyx28YBwTaUhOi0sYbcApQSDJ23ymCo54Tc/N/8kTw3VITHccwKU4Q2QmO07gnEWCP1edojpTuVSUn/mLGzchPdRyaED9feER+e/V7b2sUMITHuz1LPi2+IJNJHvUPzLG9g5/mAOHcYHriLFHbTpwFof0WWY1pJf/2dZLaCL0dn3japa2h318cDolnheoSMi9A0Nd8nRNhuOyrWU24ftT9G13DtV7GzW408I8FcaJGlRovFI2eYUbjfZcj9QKaNyq0fcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgkJPhZdxaN4k8YfU7okIPfT6UEZXl2XOC5ZCMGyn84=;
 b=BpOS+0AHZp3oMD60tIbhMtVdH/SR/pe7IqQQITyTHxPwV3p9efomJJB5R3NcjpfpNnVQ3Zzw/vOHVx9R5A2TOiZVpV/bNLNWdbvkwYRJedK0xDAJcokgGX388iwkjts7rO8ANw/eigRLniiezKZDuxV3vJ4a7Q82HkdWr7mzi0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB5735.apcprd04.prod.outlook.com (2603:1096:400:1f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 08:21:18 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 08:21:18 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 2/2] usb: typec: fusb302: add support of supported_pd_rev
Date:   Tue,  8 Feb 2022 16:20:26 +0800
Message-Id: <20220208082026.4855-3-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208082026.4855-1-potin.lai@quantatw.com>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74f3b4c7-dc0c-4f37-5b06-08d9eadbfae8
X-MS-TrafficTypeDiagnostic: TYZPR04MB5735:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB57359F1DE56D75821FB4E8F28E2D9@TYZPR04MB5735.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LFUIIbcAEV8hVIck7gbxRgA8V6YVi4LLdm9G76i/KiMYajEEXrSzgLX67I3V0Dbuj6jymR/6LrMSBHJaMziLN4z7jV+Uo2rQCPM/ZIaKYNLupuC1027wTpiJ6gyLQoOn0++0oLhxzA0kQxj5Yjne1c/hp+80JcrM/1NWFV9DGlG8yjSxs/2CYpPkkuiPcFYlAUnWOgoMhZrh0Op6jlfCQSTmcMab/5LhCQW16NY5aXQr7E+ibAAH7KObGg74E4BKFV9Mmvi+oHmRJvUXt4mBwPZ0cfWDqC5D4wpHyqNBRFbrjxXmXhpMTBo6UzrUXA3gm8DJDhMnPZmV9Ftjp9FxiFh++ipg66TDh5SW6M1DXv3cC8MjAoUmVLOLM04eB0lcDybfV/VmWa91z2F5mIxE46n53GeRr2LFWUmeleGnKUr6tBSWcK9yyyCKjk78Z2f4i1p0IpaACIBblhc5w4sz39Y5wgrUn3jg7ZxTPIkzNKvzPvEPxg7fZ8CkafTorzx6g18nAAfFlctZ3ryIZDY1GQn3HNquIs1fK+LT8wiR1oGwnvjwC4AqUXcrbrrl6N7rWGD7PMxUdEMa30MnxPxHOanQqkDwYjnhwGBAGR71UF33PibFonntqyO/kiRMH/9HT9W/xYOz+SbNSh4cfad+pFmt0W3k4+Dunyf4Prj6ghZqVbwb4lOrrB+D/cPiyPPKoDj5xc6gwK4uzHpdKF7FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(8676002)(8936002)(36756003)(316002)(5660300002)(66946007)(66556008)(66476007)(6506007)(44832011)(86362001)(2906002)(38100700002)(38350700002)(6666004)(508600001)(52116002)(110136005)(54906003)(6486002)(1076003)(186003)(107886003)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dp/IwYyffd04eREJiR0qr4P359VmqIKgTAB2Kilo1+r/4RfgZ3NWSiLcMLfR?=
 =?us-ascii?Q?e+AhtCO9LdMpVrIEf9P74gdgZH09AdA3bY3kB5R93x5J69XxSJH7ELJhD7wa?=
 =?us-ascii?Q?5JFAdWg0/of2VhBZADl1JO0UEWxMdJs79dgFALWqnqITBHBGvPz8RIx/8LyZ?=
 =?us-ascii?Q?WuslMPqS7QXBlRZ0y2YJtjJYMkKbmGU8sgFj+tQp2i7mi6EyN1Al8VglG+oG?=
 =?us-ascii?Q?5iIVDKK2aQB8LDuOXYL7k/ABuqr55/qIm1yFqRgJWbIHmycbd6vhSohw60pU?=
 =?us-ascii?Q?RFwzxae4zLTiPqv29tpvn2T4IVXT1iixO87JMB4ogU7hyVuhU4nGu5F1/wF1?=
 =?us-ascii?Q?QwERK/kzFqz+6KkOT8dJ+GclusX5IIkACZpxjhSZP1aXIrAhUt+5kG1eGx5V?=
 =?us-ascii?Q?5RlUs12lauFBycCG937rkmsQKHSPdhTDV1oJ1CPKap5LbI/iO3vGW68tIX0x?=
 =?us-ascii?Q?fTn+uTbnv7VfzxAaWktSiIBna5CugABki1HSOiCdpgTH95IizJ/JYwhHGJnN?=
 =?us-ascii?Q?ctoGbGAQmgWFtP8Qv9FsvdlUMbhNG+nVyL8fs2MEtmKGOO/m6t+9yYV2QJOD?=
 =?us-ascii?Q?f+cAuFyxlQ3M6XYdFIvu0Xj+87uMe1i02dokrS2JgsnQX1DUxE4pCWEnPKX2?=
 =?us-ascii?Q?9NWISQfOp/xhJeQB6h8W/Zrf97f0bmt2Pk+EQO55+URIiPTH1eAB0wPXSRod?=
 =?us-ascii?Q?zhPDyE2cmBQJLdtaINzHGXxvHa9JpbCfrB11g43adVvmiWj1XrAuwFUmgphf?=
 =?us-ascii?Q?LAtVTm5Ts/D0iQ5FFJ71BFubzwITPWUe31iYeNh0or6xlzpFQMYHmQdHKNKw?=
 =?us-ascii?Q?R0WFmplXJizXqHNYOh/bzkeayi9mEPowSzwePLOc2Kt7wXCQAbcFzUM/EpLd?=
 =?us-ascii?Q?Nf4DH9OT5QnG7Cbtv4QhLrkUm5n3tlFPMK1G8ul5YltkleLDvcnPypfT2EpL?=
 =?us-ascii?Q?cgqcMRdVFj7CBx16Cblsb5i/1EQ/MyRXfPU4kav/JUmWFh0EzIk0zcx5Vq3j?=
 =?us-ascii?Q?K/7eyDA7HpVmNe8ukkKry36o9gIVs0LaYlHsIda01RH3BgTrM7uqhrsRTc5O?=
 =?us-ascii?Q?pVk0LS/QxaqVNVXaLPtakOl6/2tnPA/SpcS0MmBiSCSvfANDUpzD1RWjDD9d?=
 =?us-ascii?Q?/QuT/p4NpF5BkUjPqvBFp/6GqBXL+s/jWGhG8DJNjOw4b/C7Tv+ASfIQOStc?=
 =?us-ascii?Q?2TwWSfZvrbsFbEBVkmHeinLzn+pBau21ipVihTy5zv9FpFJUI2583FS/DhxO?=
 =?us-ascii?Q?189fSVXiFtaPDd17cCbgQEIjT1YX368k1eUS5onRQO51Fxk2N1ePqoDEhDN3?=
 =?us-ascii?Q?UROi0xOQxZwsUCuCkc7EEr3t09L5QyVE5SsgMTFNFIWYpACRIa0IlzVkzhsx?=
 =?us-ascii?Q?N5scWhQFfkSwZXoIZYh+hB/0plQSXS9rj5ZOcIMiEP1zXiHqb0ug6wdiMqzz?=
 =?us-ascii?Q?+/AeV3fS5l2mDKAGGg8bDNN3xZMHuyqAl1+3OLBKatAJKtkVZuQ5rSyaouZB?=
 =?us-ascii?Q?+YYnGSofbLXqDId49QWUwKhWwHOjxtL943YCkh9xJ4oFkoj7Qz/WLqdEYZf3?=
 =?us-ascii?Q?j8zl3NggAQIjn1B1Dp5RrFadzXtUwaNmi0BNYBLUVLGNmSpLIhVhv+MfJpoA?=
 =?us-ascii?Q?wY8rL0ZFSXQ+ex7O/EniXJ0=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f3b4c7-dc0c-4f37-5b06-08d9eadbfae8
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:21:17.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sc8tnzDqi+otD3Ce884DpRLUAaetE7kSx4zqTUGbVSlVjDAkpeTZS39Bgk4KFAYer1uN+1V8m/WMq1FdvQjX+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5735
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for passing supported PD rev to TCPM.
If "supported-pd-rev" property exist, then return supported_pd_rev as
defined value in DTS, otherwise return PD_MAX_REV

Example of DTS:

fusb302: typec-portc@22 {
    compatible = "fcs,fusb302";
    reg = <0x22>;
    ...
    supported-pd-rev=<1>; // PD_REV20
    ...
};

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 72f9001b0792..8cff92d58b96 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -109,6 +109,9 @@ struct fusb302_chip {
 	enum typec_cc_status cc2;
 	u32 snk_pdo[PDO_MAX_OBJECTS];
 
+	/* supported pd rev */
+	u32 supported_pd_rev;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	/* lock for log buffer access */
@@ -1056,6 +1059,13 @@ static int tcpm_pd_transmit(struct tcpc_dev *dev, enum tcpm_transmit_type type,
 	return ret;
 }
 
+static u32 tcpm_supported_pd_rev(struct tcpc_dev *dev)
+{
+	struct fusb302_chip *chip = container_of(dev, struct fusb302_chip,
+						 tcpc_dev);
+	return chip->supported_pd_rev;
+}
+
 static enum typec_cc_status fusb302_bc_lvl_to_cc(u8 bc_lvl)
 {
 	if (bc_lvl == FUSB_REG_STATUS0_BC_LVL_1230_MAX)
@@ -1129,6 +1139,7 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 	fusb302_tcpc_dev->set_roles = tcpm_set_roles;
 	fusb302_tcpc_dev->start_toggling = tcpm_start_toggling;
 	fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
+	fusb302_tcpc_dev->supported_pd_rev = tcpm_supported_pd_rev;
 }
 
 static const char * const cc_polarity_name[] = {
@@ -1683,6 +1694,7 @@ static int fusb302_probe(struct i2c_client *client,
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter = client->adapter;
 	struct device *dev = &client->dev;
+	struct device_node *np = dev->of_node;
 	const char *name;
 	int ret = 0;
 
@@ -1756,6 +1768,14 @@ static int fusb302_probe(struct i2c_client *client,
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
 		goto tcpm_unregister_port;
 	}
+
+	if (of_property_read_u32(np, "supported-pd-rev",
+				&chip->supported_pd_rev) < 0) {
+		chip->supported_pd_rev = PD_MAX_REV;
+	} else if (chip->supported_pd_rev > PD_MAX_REV) {
+		chip->supported_pd_rev = PD_MAX_REV;
+	}
+
 	enable_irq_wake(chip->gpio_int_n_irq);
 	i2c_set_clientdata(client, chip);
 
-- 
2.17.1

