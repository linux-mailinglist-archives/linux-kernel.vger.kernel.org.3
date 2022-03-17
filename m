Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B24DC9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiCQPSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiCQPST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:18:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F9205BC3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647530221; x=1679066221;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gU+XGJaBviqxFZ77g1tgKIO4vczQgn2I2S9XpP7ADik=;
  b=PRVQu3Y0AjgGEBNT48/Z/m32ycpKRm9ujF3yKtfvClqIcig8brK30Ovd
   Z9LTAS5UG11TqhehGZaylspyepJykrUg2kN4FjFdTrLUUI80rHpMehRby
   S410qfww6qCBvfcx3VdyYNtSBy7HCtmKTrUql0QQ1mkA5GenT9M07JjJB
   ixT+y7NX7V0EQKHwjD1+OblQAbYNGQcDofk3tROSNlJZrcQ5W25n/oKyO
   c+INNDzPaiJO/JC6kfPzsijkVqB1MHufo9ciyYyE8VOEzCDJE5aI+Anrp
   26KB5meUOdCr7vhDqPiIk6LTgvOrReWlVRgRdMlGhfUm93OChciTCss8r
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="244343239"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="244343239"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="599131199"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 17 Mar 2022 08:16:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 08:16:46 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 08:16:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 08:16:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 08:16:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRR1PEGa0yRQPM23lJHgqmU2UKUEBVPJRO526kM++0dIKuPFqd6kfbq9+iGGSDc4pu8cHVBS/HyXM7KCuF7RhTCH8RMPN3rPmEPfOxG7QfGVIDr8l/ijYe2LyQTeaH/hFQHuarLhpaOxeeWXG0R33VU+fjbEA4Tc6/V1CuWIlM8CSRx55r/5XfNKRw/1vjZnCQ2gNIuLtmnZM20Bh9AIzeTdWVLmWF9GavbVwBcRG/AOPjO9bVOyKWCPdn8DZHrEatBEjODzej/M/XWv8SjpcF2Dnr4/7CmvAteJmGHYqnB58OFC9wmmeE/tfIU03JcMx5BxyG99EzsG3bnlLLWocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67fXdy4Ok724C/z2Wl3M7rnY1Cdf1i4el7eIUAyFkoo=;
 b=l9pVBBs8vLxd5jJRKzqT0f7T2BBqy+FEp2ODiY+z6hLt1bv/g8AbS/6PwR5WMAtxhWwHco0UxahFcnUNo0oHstYg7VdNX6f3hgvx/BUxC4FNROTHDFkIKiil2XpDfwNpdmqwsz99DzIi3ryxS+tfPU+b5vjXTUl2I80Pb2ThCJsGf7BnN8TK/lq4SgzitMOoFb2WbO/Q0UJjE1YUh6zBF24FxjF2j1xKcJtY5Do8EwEqNMgH3uLvR9DbZwDDoZRugr9jVlyDNdcWhAXdapUBlpr+i9lPnWEH2j2BjKd69siNa4w6dfRPMAseTIRdqzEtWoNCbOe2YkjO2MiHa04kWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by SJ0PR11MB4815.namprd11.prod.outlook.com (2603:10b6:a03:2dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 15:16:43 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::fdae:50ef:a0cd:b1c9]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::fdae:50ef:a0cd:b1c9%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 15:16:43 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: [PATCH] "Active" sysfs attribute of typeC class should reflect
 the current state of active mode.
Thread-Topic: [PATCH] "Active" sysfs attribute of typeC class should reflect
 the current state of active mode.
Thread-Index: AQHYOgwLvZiU/qLGfUSkQB00qNXW76zDr9Jg
Date:   Thu, 17 Mar 2022 15:16:43 +0000
Message-ID: <CO1PR11MB48354543F7894941A843AD6296129@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20220317142731.3526-1-rajat.khandelwal@intel.com>
In-Reply-To: <20220317142731.3526-1-rajat.khandelwal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e572ef04-69fc-4b17-204d-08da0829252e
x-ms-traffictypediagnostic: SJ0PR11MB4815:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB4815F96B2896C42DB509EEB996129@SJ0PR11MB4815.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdJ7JWDk/KVXHIYsvrq9G24lrItNYAPc9eyM5zvlu03Lxry5ER4dpKPMTZheYusNaH4EtTehLwgH/1gyN8dqBQMX8XrmvR63u1J6HvtqloaXHJ83gmABiYN4ka77PiIDZnh/sJzVL4mFAfbqTHxBkVgSjUJSPbUHfAc36sKv3h5Jp/DzwD1571+aqIs2Bec/aUez0Gp82X/Ka77F7p4fGNKErrep15efJWfDb9+DuvXAYDk1pdmBT5O+TfF+IM62cOPsavmhZIQVy4qaL9jK4+73FLjA9KGdyuwxSGeOlON+uNUhU8sovymKGw1jjTwZmi4Z3i+qCmanZbgmXAhTM7irNLO/XDjY/69eC49IJ86+LkEShFDKw55x723pTWagO2aZeJveZObTf8ne9CaOf30B5b96SHexePLekXjuDid7kS1FLBJYHgFxMc9FgkzB0k/D+pIpXm+LTrSwzmk4hWxvZI6I/ld6brKcV2v3Ntx2XXZVuYypVzQMW+PHS7dnQuQ2RH5u7NiM4fwDg/vy8YC4cP709vvSO3zD2VtRKTW7P+iwm44KuGFEEvSKyWAyGb78LQeGScMno9hPrA5udf4GDxqRB7A9oz0heWetET3D92unGg0YGeGoczrT2MJPZ7sV+PQildmP9PbjWqOCKAMyg0jGuC4k+C8srs9obrERKe9efrzxRtwExxrzIrwBeSWuwIk98NVd0aQ8q98HcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(83380400001)(5660300002)(66946007)(66556008)(66476007)(52536014)(71200400001)(122000001)(54906003)(110136005)(316002)(9686003)(6506007)(38070700005)(53546011)(38100700002)(55016003)(107886003)(7696005)(8676002)(76116006)(508600001)(64756008)(33656002)(8936002)(186003)(26005)(4326008)(2906002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7feMr2i3HhB3hzPZXOa0XFM8RnHtMD8fOQhv/jIjleZj2Px2MnE1Zh/TKSBj?=
 =?us-ascii?Q?jqDcMOtodYZIfasKt4y9Lz8h5lL7O9vp5N/d9lHs3aVGf1xIvLPoic5JTeZi?=
 =?us-ascii?Q?j59TLIaU5MQlcudQzTjtU7yErN0zfGjWgihuOl63cY+khgSB/cJ29HrTNX10?=
 =?us-ascii?Q?UbZh4UXAPxAtRry2ukN3h7j7hI8z/M+LioOjnFLCpB2LaY4tNRNKg8zbFvXh?=
 =?us-ascii?Q?nuHEqdSzrsSgIN1jxGehXhP23XWd5i1AEX7FOiKtVo9B1xZKll/x+PnpTskN?=
 =?us-ascii?Q?hT7N8g/DOl2inGc72xFu/p56OOWvOj4yqLDY7Ci6xNQvG6SEr/hzW/1qlNV1?=
 =?us-ascii?Q?TFUulNtQ0Lx8OuL1JMauNB3aa+zCw4vSEVBagi8odJKA4eLke4h4iEyxlQuZ?=
 =?us-ascii?Q?+3b8ee7izbt7lDLTjrXxwy2LYmB0cx6L69yblzRoTS4Ulz5L30ixsnILjpRS?=
 =?us-ascii?Q?4QnBic2fTBvclll31+fYigCe04vW5fqI/RGevYGAMCyi+8RCvaoWHTokkP+D?=
 =?us-ascii?Q?+SOj+4RSfd9bxMafmSSXLfkj6DlHaDtjq3eEGR+70NWewfkJlZdmbc316j+A?=
 =?us-ascii?Q?dSliGhxqGW7I596xWUQVvWYkeb9DVMEUlfR9ueSohM3nFv1N0G19RRemqgUq?=
 =?us-ascii?Q?96ZOT+ELHoOhelI21HTZi+fkNLAsAcPPSclwkA115dAei0vutsKSqwnshVWB?=
 =?us-ascii?Q?LPwCL6nyINjrt3bcCtH01gAthZ9P9r0MmjBpCYWNJMVhXzT+7pWJlu3el70I?=
 =?us-ascii?Q?z/qUjV1XdnrYZ1kIT0Ur0c1PL2WmOlVkXeIZLJYe4dFWpHf251RfOlB2ftTl?=
 =?us-ascii?Q?YcVaGvD6kUNYXsJgT1NZkAYV9c5YpwEx8XN+EVJ3K1P3EtCFvpkHC9895trv?=
 =?us-ascii?Q?QzmaF+v2XJSbd6/jkhpybou4iB/cmMj6lQGzwuhg/flVWynkcxvoL8aSQfGy?=
 =?us-ascii?Q?px57/Ia5Nne3xY3oFKsXCCoT4YwBwM4PDBGaytcA/7Jyyc2OWHJ/YDOiJWsY?=
 =?us-ascii?Q?SlBJQ+Zo+P4AuUTD+vzE4Z3Xekwhl0bSc+IuSM4zRZTxUCGBGG4uvxeaZI3o?=
 =?us-ascii?Q?HicjoiHVVhbKDhPTz1gdUocf+33UV47Crdr0DJnFJomFPZnfD6qG1NFRikpM?=
 =?us-ascii?Q?BtK151IdYt/yqVUbJng0epsBx63SiYwmMega4ECMzf6FTC/5ZYBfm5CL8kgA?=
 =?us-ascii?Q?oiNbpmDpEQgOTlS9lokn3gm1aDA8zzTUNJXeDjdvGD/8KMSod2jmlBgDv3jG?=
 =?us-ascii?Q?knqrDFaf25yHoEtkdz6cEyiUQeEQslxWO5wTvCQY0enbr9cW5j23Gu+mjktN?=
 =?us-ascii?Q?/9hn+EKRdujuVlxxMwpPc8w0jF27zNDmeg5GehLYy6En8eZzKGc34ukyMGvh?=
 =?us-ascii?Q?THdDwb/yWVbctMuJ7RJtGZQNf2gRKL4MmTRywHo4JK8FX52aWtwiHqYXX7d1?=
 =?us-ascii?Q?RJxgnzkVGvFegblQjI5J4ved6IXYZYHDH0nK1hhaWzY0VOu9Vx8g/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e572ef04-69fc-4b17-204d-08da0829252e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2022 15:16:43.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zDXA3DJi5Ceynk2woUINAurBMWSoX0FILQP4mJzGsN3jyFBd49XPFTWJMAXZCPKOZqNqYgZF/VSIjYaPgNIaDRs6nXSGc+9V8GHI2Ba9zZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Abhijeet

-----Original Message-----
From: Khandelwal, Rajat <rajat.khandelwal@intel.com>=20
Sent: Thursday, March 17, 2022 7:58 PM
To: pmalani@chromium.org; bleung@chromium.org; groeck@chromium.org
Cc: linux-kernel@vger.kernel.org; chrome-platform@lists.linux.dev; Khandelw=
al, Rajat <rajat.khandelwal@intel.com>; Regupathy, Rajaram <rajaram.regupat=
hy@intel.com>
Subject: [PATCH] "Active" sysfs attribute of typeC class should reflect the=
 current state of active mode.

The "active" attribute of typeC class doesn't reflect the current status of=
 active mode. For eg., if the device is in DP alt mode, the corresponding a=
ctive sysfs attribute doesn't reflect the output to be "yes". It still disp=
lays "no". Same goes for TBT alt mode.
As an eg, cat /sys/bus/typec/devices/port0-partner.1/active --> displays "n=
o"! port0-partner.1 is the partner SVID created for TBT mode. On entering T=
BT mode, the active sysfs attribute should display "yes", but it displays "=
no". This patch fixes this.

Signed-off-by: Rajat-Khandelwal <rajat.khandelwal@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 41 +++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chr=
ome/cros_ec_typec.c
index 5de0bfb0bc4d..798c58c75a7c 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -32,6 +32,12 @@ enum {
 	CROS_EC_ALTMODE_MAX,
 };
=20
+/* Supported alt modes and their SVIDs. */ enum {
+	CROS_EC_ALTMODE_DP_SVID =3D 0xff01,
+	CROS_EC_ALTMODE_TBT_SVID =3D 0x8087,
+};
+
 /* Container for altmode pointer nodes. */  struct cros_typec_altmode_node=
 {
 	struct typec_altmode *amode;
@@ -396,6 +402,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data=
 *typec,  {
 	struct cros_typec_port *port =3D typec->ports[port_num];
 	struct typec_thunderbolt_data data;
+	struct cros_typec_altmode_node *node, *n;
 	int ret;
=20
 	if (typec->pd_ctrl_ver < 2) {
@@ -438,7 +445,14 @@ static int cros_typec_enable_tbt(struct cros_typec_dat=
a *typec,
 	port->state.data =3D &data;
 	port->state.mode =3D TYPEC_TBT_MODE;
=20
-	return typec_mux_set(port->mux, &port->state);
+	ret =3D typec_mux_set(port->mux, &port->state);
+
+	list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+		if (node->amode->svid =3D=3D CROS_EC_ALTMODE_TBT_SVID && !ret)
+			typec_altmode_update_active(node->amode, true);
+	}
+
+	return ret;
 }
=20
 /* Spoof the VDOs that were likely communicated by the partner. */ @@ -448=
,6 +462,7 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,=
  {
 	struct cros_typec_port *port =3D typec->ports[port_num];
 	struct typec_displayport_data dp_data;
+	struct cros_typec_altmode_node *node, *n;
 	int ret;
=20
 	if (typec->pd_ctrl_ver < 2) {
@@ -480,7 +495,14 @@ static int cros_typec_enable_dp(struct cros_typec_data=
 *typec,
 	port->state.data =3D &dp_data;
 	port->state.mode =3D TYPEC_MODAL_STATE(ffs(pd_ctrl->dp_mode));
=20
-	return typec_mux_set(port->mux, &port->state);
+	ret =3D typec_mux_set(port->mux, &port->state);
+
+	list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+		if (node->amode->svid =3D=3D CROS_EC_ALTMODE_DP_SVID && !ret)
+			typec_altmode_update_active(node->amode, true);
+	}
+
+	return ret;
 }
=20
 static int cros_typec_enable_usb4(struct cros_typec_data *typec, @@ -518,8=
 +540,23 @@ static int cros_typec_configure_mux(struct cros_typec_data *typ=
ec, int port_num,
 	struct cros_typec_port *port =3D typec->ports[port_num];
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
+	struct cros_typec_altmode_node *node, *n;
 	int ret;
=20
+	if (mux_flags !=3D USB_PD_MUX_DP_ENABLED && mux_flags !=3D USB_PD_MUX_HPD=
_IRQ &&
+	mux_flags !=3D USB_PD_MUX_HPD_LVL) {
+		list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+			if (node->amode->svid =3D=3D CROS_EC_ALTMODE_DP_SVID)
+				typec_altmode_update_active(node->amode, false);
+		}
+	}
+
+	if (mux_flags !=3D USB_PD_MUX_TBT_COMPAT_ENABLED) {
+		list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+			if (node->amode->svid =3D=3D CROS_EC_ALTMODE_TBT_SVID)
+				typec_altmode_update_active(node->amode, false);
+		}
+	}
+
 	if (mux_flags =3D=3D USB_PD_MUX_NONE) {
 		ret =3D cros_typec_usb_disconnect_state(port);
 		goto mux_ack;
--
2.17.1

