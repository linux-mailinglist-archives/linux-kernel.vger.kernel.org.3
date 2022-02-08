Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5504AD7A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358788AbiBHLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240375AbiBHLWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:22:49 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300094.outbound.protection.outlook.com [40.107.130.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C13C03FEC0;
        Tue,  8 Feb 2022 03:22:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYEfZhs2INsqVuhmNJK/pL5iC0fj1PrnOqiak2qpRd1ZYw7L0PRqB9vQ4Yb0Wndk2III659F05JUVgLrDJSz+jOzLdQ8UMkYv5qp6751MIUjZPMIHDKsfSPT9Awr4oBxXfFhVCsq4SYAHkU3bJr9DgxTeh7XOiv9cZ1uAdUFOGgNo+epXbnl9MhJeeuEDGZigRKp+ZwmAZiaEMKyibSdFLXukkUXL+mhd9YJiR318HmwxNprb2U4NJdcaDnu1H6cu7soascHZL8cxpiWi9n4XkWt3UvtVfZT/QYyDex2th6HMB/xZ7PUjeL+zGyQ3A/BInaT9vSOqTjtxTi7aIl4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgkJPhZdxaN4k8YfU7okIPfT6UEZXl2XOC5ZCMGyn84=;
 b=YzetKVzSEQSZP3gFpPIocojhFkWcVMBCB0ElHhWsKbxEGBVB0ijoT4QoMYLRx2iJozgj+OmiNWg/en5KKmFwAfiPO7yHBMl2Cz/79QYUEEkhgAFGL1yQPaAydFNDokq9Xbe2heoekFeHv6ermNcwFM3wnsJcfK5FLmW1XLnbUlS7+7uWE/+hy6XSa2ERt/s5LwCK++zcQltjytIfH9KDA/ZhuY3bHp0wPOFxgRQZ0iFGJEZV1OysJVyoEkR9zSDlepcmqfl5tGaiYOuxztq88JsqJDaXbztY3ImAplLZYkPpm6VIv+4Luk3gIerocVCRKiDbIwnLlw3GksV2y7z/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgkJPhZdxaN4k8YfU7okIPfT6UEZXl2XOC5ZCMGyn84=;
 b=kRQ5PCabRjZQTGyDnL+Zj5Co9As5k2hj1mkcBnacqDEaN+V5WXXJOMUN+bH8mYXUBnsAV3gmx8jDLjzZK/Ai8HJfK51riJ8mlu/wo2s5KxU8YUSU5tgkhabQ5KkZzVfXSwAzEK6p6hJkkpSmPkJLW+wQ2GADu5giEndbSAwN4+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3805.apcprd04.prod.outlook.com (2603:1096:404:f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 11:22:43 +0000
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
Subject: [PATCH v2 2/2] usb: typec: fusb302: add support of supported_pd_rev
Date:   Tue,  8 Feb 2022 19:22:26 +0800
Message-Id: <20220208112226.9108-3-potin.lai@quantatw.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1c5831e7-589a-4a3d-4a91-08d9eaf5525b
X-MS-TrafficTypeDiagnostic: TY2PR04MB3805:EE_
X-Microsoft-Antispam-PRVS: <TY2PR04MB380551231D6847BD49A963318E2D9@TY2PR04MB3805.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 241EjccOd12q0/+gVlYuphEIGGOXzu6qmECMVarDmxlyt3CfieqNjVno4ncxwVVNz43Sc3JeLDF6gQxKrE7QBbTOLu6gF+3qlmEkM9w7K75TmroM7cQNkeHBey00hjbBvnvl6SIOmYl5XRLXaNJDuo6DVqZmLg46RwdyIxbB45o/G4X3Uzd089cTc2pFtaoArpWo66JK2yjnD/0WDHsbwwWoV/5XmO9IHdYE8F7RfXLEZPN16S8PPew5MYUX28QXJoYz0XGXu3BPoDXR+kvRDf7OYjy4uvCNBHRDF1X7m0KMZAQi6hoj4bqV6wVXxZYTCzDCXsQiahGpk73XP6zNq80jXKvbSLmH4RHurD/OkQ84T7eFEDiztcOEkk/Qmlo7bJrWAzZ0kUaIXvzBsx0vhthiyTpYwDDInyuFA1LbxZMsf2O9CynC2AF966ZGmOeGuDujoWYjyyeuNi2sItCSozGA0ADa0nk0Q2jO7naXeM/kAA/4mPSuH9UuHN+tQqMRK6vxlNG5hiNw4bQk6renYjhxugQGHzxm3J2lI4CPLy9TjjTICpawcGx+UR4AXl5GkCGkmK8zZzwjS2DFVGrWJQrDKur3B2Tg82xLpMtJIvlsYzhIuZMO/pFBthMu4yQG842eHua9sxGixkKz8rjrZ7swDzk0fkdr/MCNhK1P4rdKboL1gB9NalVK4aMKCDC4s27hNjsL0Rb2EtGuY5DHkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(1076003)(6486002)(38350700002)(38100700002)(2906002)(186003)(44832011)(107886003)(86362001)(2616005)(36756003)(8676002)(8936002)(52116002)(5660300002)(66476007)(66556008)(66946007)(54906003)(110136005)(6506007)(6512007)(6666004)(4326008)(508600001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ChB2UqIjI5Stlq8LtDQKYbToKXgfFs8MudiehoKi5OoOH3aGS2h3CPdc3LxH?=
 =?us-ascii?Q?7doDwUqmEgWuQfowkMgAB5qn+L5oJsC6uQDnbEU2DMQgRPImZdha/hwmrvSP?=
 =?us-ascii?Q?REZXi1TBky7AEcjitK3SNPze8dd6I5f5aF17MQ2LXYddMFQVC40sRC5qqi7E?=
 =?us-ascii?Q?Wpp+RDuBh85jIoMI9Xs8Zl8qC+6IsvdVpQ74JvZyysKkbA3FkIhTkaxtz+tv?=
 =?us-ascii?Q?EdgxmnuDkaLvkAl8YmKj1PrafmUItEECzSZZBTsWtgM7dBSe/Iy5LHdRC7c/?=
 =?us-ascii?Q?Hh8bg0KW3DBcq4td/SdMPj1ZgzeZ7GFhd5W8C3KvJE94zg1MTG5YRt0vPu0G?=
 =?us-ascii?Q?U7nZ6+t7BwaGHDlLmKtrdNb0i4XP9P3tqPbiyU9Fnda4N0Ri4ymeEZNUkdb/?=
 =?us-ascii?Q?oxO/5J3XIm8uLUlDkXs6wvzhzbqW1q/A30VM7HXb8fjaLGroApAb4KccAjUF?=
 =?us-ascii?Q?feRyWAb+bsfdmxs8bXl8JlwzRokxtg8JXwl2N2UJzyjMsE0fB0yJz9J1mYGA?=
 =?us-ascii?Q?vI6Z3NrHgJRgpitiO1EkfmyK5u4w5ZlKeVjJunA61UU6h6XY1v9hlO/OV9qp?=
 =?us-ascii?Q?qOP80wraa7IXx3I4ETuKA3O4CYFL3I/bDiD6rTm01zenhu25E5Ynf1PpcBlY?=
 =?us-ascii?Q?UGVmNLdW4K0R/GpFoaOhQHJJQDibZogcekaD+FYEI2h2MzObUXec5TEjlKRp?=
 =?us-ascii?Q?O3DdOiPsUoKLVLZAzXkkTefoHXIStsEOc69oAGv9XLIUECZp9LPGb60O6ipV?=
 =?us-ascii?Q?BbyU0nzhf2TCyGapiXPIDOl74t/hTdHZ44aKrKm8O76RW4yS3DGjlru+qiIl?=
 =?us-ascii?Q?haPs2vL/4U7hLceeAje4o0ERmzGlqSi3A7Aho2ewNsQlsk7FHHNPUaVOoHdq?=
 =?us-ascii?Q?11iXsIoOjQ6oZJ+8C5249v/mnFIbTBvqG44yuzLDjgOrEOhwsl1PtPLhhjqd?=
 =?us-ascii?Q?6aEu4pprTkucESzblt3A7J8bUgFCuVXYJlZvXFNmHNMhsFGQHuzeWIGkk0So?=
 =?us-ascii?Q?CnOiGpwa5VkbbhLVw1m8SlweMN8OiuLNrEEwlyhOTYDrt8mNxpIOhZPTPE8l?=
 =?us-ascii?Q?k/NvKIKMUgznqI2q8I/pFp9DfVSTB4VDSs+wsjJfWjH2/AonhhGX/UnPtv6n?=
 =?us-ascii?Q?5tKhwBN8vCVxKlQKVTiZV0Glc39oxJ4fs4Xv6I/cbHUe6fHyCDlnJrPvdfEy?=
 =?us-ascii?Q?tK4rZoeOGUENcTnn53U3rHzVKD/LGyk0eOnvo5mibKQ6sXqUT+HbsKIiWFP8?=
 =?us-ascii?Q?B55gDGR8GpBzhNgogZoIFbsqGRMn5TdGBzGZXx5YPdaraR5YPbYfzNVTnZMU?=
 =?us-ascii?Q?mkNEEWt+hS8q0ThxASr541g415HpqN9hdi3br5zpOlLSqDPuAY01DyXmF8x/?=
 =?us-ascii?Q?xTSpfsbMJ5AuqDRXwUL700jduZCpFJ+z3ZjG6BiMa438M+n1UlCYiGpE3r3U?=
 =?us-ascii?Q?qagvH00/oJdpvJ22e3G1UPWudzSBWU1e1JGnoFp1Gp5qY7CrXoBKetknU93+?=
 =?us-ascii?Q?7345xPgJn4w5dKPOwC+EJGlznxEM46jj82OkbtNubP0JtiVnl97KgLcbCbPW?=
 =?us-ascii?Q?DPDhjLvDH3ifn9cD5+Mp3IBSUaiTMyzWQuGJOC0BNm9Y9rzD+ISW39PpYMh+?=
 =?us-ascii?Q?hrx2N6dgAvGNBJYvuoBxoC8=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5831e7-589a-4a3d-4a91-08d9eaf5525b
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:22:42.1893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C66qSUlGvPWrkEWJqAd8wH+JUMb0eSVjjhdkbewDPdsdscFFGcofUfJ+QijW0w1JhT2u4/lt0182tl6bqDVJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3805
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

