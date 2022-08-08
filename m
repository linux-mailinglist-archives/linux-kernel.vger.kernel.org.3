Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4819E58CDA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243690AbiHHScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235853AbiHHScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:32:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4739A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659983530; x=1691519530;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Eo7wa1CCAn3nR8WBzw97l4YOjCotJvEvobkM3o4yht4=;
  b=L1n2FRMOiKJ5h0Uc27xfAhltaSwKRxdZc5DKQNvY7Wbiuq+hE5Mevdeq
   cdGYEd7uSoQEAfugS0BpcCKREn9YkcGoT8sXE7LlzAgXR8urQYF/gwnKR
   gNk+4S9oQicb41ycLai7biuTuqjjd9sANYQ/8TEpEfdYf+5KVk8kBpw39
   rcH/L6luiCLjRc/zB234r8GQalszPYt3vmeSepOPei3y0ltR5e+BwK1JH
   r8NRx5QQ0+3YVVR4iJ5xcnsPVnFMEAJ+pkmmFJ+RA1IKVxFfyqjQmQEMa
   +0cDwwmLay6/vvCXfKWU4icfQMLHcv37qus/VrM8gIHIiSG3XhDew3QiB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="288229230"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="288229230"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 11:32:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="780590754"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2022 11:32:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 11:32:09 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 8 Aug 2022 11:32:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 8 Aug 2022 11:32:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 8 Aug 2022 11:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEu1AEjzavWRH1+1ayPAcoIp4CIe4mHtn4Kb/X/lYkPvaWjrM+npaGGjBmi0ILLuC5NKWUmmQHnWU/OjhSLeztx11+o4opmr2vcQl8gN4jWoHb1Bze55MhE+LKCSAjSLmJFIN9vyV1AY47e7L89HmQvt88jtJfZ3/joi5lv/NFVGMQFCd4ukTPlu8kXwm8kBopjK/NNmdZXx+VnA/upLICrOOneI2Ysq7PCCZPaiS/hsIsSbRJJKf5a4JYtr7WAJEx4gROt4B2UqgMa3/to+MUYlGYboK7l/LgvP9ok1NOxEoQYPAThgheeyW+3r1sPQ5mGkJ/fWGa2cY5+9drvAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrGDajRxIo8dGleG+kC5O4jE72e+7AgIlhQmKAYcU+E=;
 b=VNg3Pwxe4BTKOh7LTR9GV3XiimM3O9XJOqk/RVLm5/GMFVH7+DKNYV6VNgLC3HdnFomwWBlu7lvZlSikPwvFVWVQ57zbMLtzSBEbapRZDUqfARgNldEqUd3jyy775OuopcpojjUCBtu+fUnA3l6y1Xnpqlb2rYSKu869ZRWJcOcXHyXlDlGKxd1PGySEzJmk7jV/H4umyfmI1Vf7Tjhf+7GvWZiMj90ZvYfEUnSryT/nSu9+KQiLGjUR+r7V0XPFKz+sc0cno0WYm2NuTubUApVtrMEh6lUufpndJ8vSdH55wHz7rTB1cwnUarAVsTehAoHf4lracW+CTalr4WTx7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DM5PR11MB1964.namprd11.prod.outlook.com (2603:10b6:3:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 18:32:06 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 18:32:06 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "groeck@chromium.org" <groeck@chromium.org>
CC:     "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: RE: [PATCH] platform/chrome: Adding support for visibility of alt
 modes under their respective 'active' attributes
Thread-Topic: [PATCH] platform/chrome: Adding support for visibility of alt
 modes under their respective 'active' attributes
Thread-Index: AdirVRLNn/pHkgH2S0CKDG6Mjchicw==
Date:   Mon, 8 Aug 2022 18:32:06 +0000
Message-ID: <CO1PR11MB48352BEA7C0C40F42BBB561196639@CO1PR11MB4835.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a241e7a4-e463-4bb8-8961-08da796c4c0c
x-ms-traffictypediagnostic: DM5PR11MB1964:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1WQz5fc0RL/gEk4xLnPr8qQZoyMt+XFAl5x867gtaHiFFemzzJkAOrqRVfMy7IEKoaxDb78iPwYDpHN+eSB3kLf3T+p5gCprcdKujCct1rEbN1G0C0AGnbe16GeAMWbBfJPpmfpsWB1oWabQ1N6GJnjPSHty0pfkjkzDwJ4L4+kftQxaKO6xsMaAF5TzWa/tP/vKvBN3vZvvWkHv3IRLChDFfLDyXY0p0L4sfcyZnVmWgWOhlteDEvk8hw17nd6njlfMsCBv9TZppgcLj9F3W04G5WpO15uCarL4Rilg42y+pVlJlJb9a+M1BNh79aEXnUM8ussFL4w/M0JGEGzT/+yVBfczhbsDPAFzGVorhf6DkPYygvujiddmaG2KbxJifqFAVCd3co5KTxd4374J89SymqvCbzULsaHUTH2Fsf5hYXA2sYLOdmJYV2v1uOEGVDwbnEiFJFR3VewB2WQRcDNvTEXh7oN9HX+IowMJjGANJe6NQjITUDFLxrveGLxqahAIvgHgmGNY2+tY198DdWSFCPM7yRtP9uiCePdXE5ofVTkkJeW0hr2RnVIdBQYPMWq5iMBc8vbrCo4U/x3ummxRnIfuClmINmNiC/IChlYSgEsTS0jy0MG4y5QlsgObqkqq+QPCmHmpLypYmAUDEjeTBajLsgFURdRP+Q34KeM9oryH4kWAFoup9tm8HKKD37QEr0ONXNk4wzmUn4Hy/vYS+1WCsHtswAOSvOR4J3t2OBbeTUtCzCIKAaEcauJgb4ZJFrsx0MLpl33If1IYqVuRcqcNXLw+MSGVEBcJy65IpIV6wqW0Z76zNWGMMMu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(39860400002)(396003)(136003)(366004)(55016003)(66556008)(8676002)(4326008)(66446008)(2906002)(76116006)(64756008)(66476007)(33656002)(66946007)(71200400001)(478600001)(316002)(54906003)(110136005)(53546011)(122000001)(38100700002)(38070700005)(82960400001)(41300700001)(9686003)(6506007)(7696005)(86362001)(26005)(5660300002)(8936002)(52536014)(186003)(107886003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rir+wv4w3UOG9IdIVFYptk5U4MB1biDk4C32zM3/T1DlsY7+2z0V9iSrL42W?=
 =?us-ascii?Q?5jqtu+EduSC8ZPpuY4J7fGZtMqagQR0syTKCWOScRTBXHrm7bhAyzWJBHALr?=
 =?us-ascii?Q?gQTb0kaCikJTFjtvW6JxlAt/R1wm+lXo1eoTegq1ovR6WuDfwYm1Of9Zsksd?=
 =?us-ascii?Q?ckhVcdhcKMMyiQpfJT7K961AKaXXo+ats9dDJ9SYGAKKkTpcScjDiTmjszVA?=
 =?us-ascii?Q?LuvXB2RL6oQqC62PkvjByTk/pHn1HbIh0HrD8Bd92uj+lR1uhWs3fpui/1eT?=
 =?us-ascii?Q?jX9/oID0PzPVT5mGaJqd4bY1c8EwFv18CMGF9Ei6M4HJ1FFa4opTYjeQnRHC?=
 =?us-ascii?Q?DJIA30F7Xt7wc2tXWOpCGTj60+qOoerJUCszwKDosA4BSvZjSloxuiOTlol3?=
 =?us-ascii?Q?jvosxrmxufReFOT0Le18v3V1t+MWL0xK8+C2Ov0IKwXl64ILRAxXtBNJNgy9?=
 =?us-ascii?Q?7c5quOMSiTQq1/0AD8le54GDMABtp1RbFLaEdC9HXNpleARWeJU7YvlqB2fN?=
 =?us-ascii?Q?dyKP+qTKdy4RlO8S8vKJPywr8VcyPgQuvVy0pB0lcOzVYvyoWcTTP/jMR+XB?=
 =?us-ascii?Q?Cb4MjXwZW3RqCf8/cCb+zVWt9L50ugBEQo01iyOWS83zHyE1xjNF6KyZSlqI?=
 =?us-ascii?Q?5gVjLxJrFA+B9uU2Hq/C1pkozeZ640YE+az0+1/YcrIDd9/jaxCp4XCCzRxn?=
 =?us-ascii?Q?VYrCboFXI3yERm92SC67ZF4uolLJ/1ZPuvdXaCwKu5INJlX11jcAcmHCYY9J?=
 =?us-ascii?Q?SZySVNg6m5PPpuZ0SYCTjR+MvJQzXJTzTBmLM5M5Bc5cAsK/x5gWddTqhRYP?=
 =?us-ascii?Q?Vu/cPi7kEl6Nn63+bbzKkFAmG+o6yP83mbAykbvzyCq9gAN5WegrVhZOQGEI?=
 =?us-ascii?Q?KSeGGyd+9oMj0Sz6oYxdMvCdXb1kiNtEQlq7w13KuZIZ6jPIXnqDxGNnuLRO?=
 =?us-ascii?Q?d079+6xR6rQLQjNeKP3HyGT9SMUh4vi06yVzkU9FCR3MSpN08fP/XDQXMhri?=
 =?us-ascii?Q?cKAgyoQ/I7wNEya6kkQueT7ecQSDYiZ95LLbH7Fb3WykHkNJoydMwlWS9ux2?=
 =?us-ascii?Q?jHrWHalit0BVSyvolYuHyYjRiprRv0Gc0JmNFdC+TRtgCCXgr1Y5GYxAH4j/?=
 =?us-ascii?Q?fJMA7T9ZqxFge2jMYCjAJFZyH7n8mIi8DVvqKhymbWJGwrMB0Yc3xPXFPmsm?=
 =?us-ascii?Q?fAt5MbVSzthADYPxdJRoTuR4+YVboi7FFwSegUEBs50sFDxxMhMOvsdv/ruH?=
 =?us-ascii?Q?hl3nzZqhP2aH3afYtechr+a2Vhpy3GBKvA1KzORLVTHr0kBlCWWvc2oGEEDT?=
 =?us-ascii?Q?qfHd4n0ZSmzj0Jy8eNKw804PezWzK4qqLq+9mkkiFiXWdZ5DWpx45frXHgwl?=
 =?us-ascii?Q?6yQTQA8eHtL1Zwb2wVe7jT3rHb/P+cZug8nrr8C63BwKOjadxkIT+yPtNreH?=
 =?us-ascii?Q?5QWgmFFLIHxB/oqb1kuy4MHjwIFd0bHEUjkPMnN+iUob1CYyRDYGN8ppwDQY?=
 =?us-ascii?Q?NK/f2hjHUUXD044nndt39rJY8CbFAPSWekZfDrItUxbbY0qVZuXJRUf0QTWS?=
 =?us-ascii?Q?6A6pTRoUP4s2RgeUFj3wm//601pnNH8MkDF/TXMFmgIncH7yQeqiyv7mO9K6?=
 =?us-ascii?Q?GQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a241e7a4-e463-4bb8-8961-08da796c4c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 18:32:06.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NuuQwsRgsymhhpt4MKJfx7doebfonC2hccO+bnUOFomxLivInHnGJbbtd/YR2yTs7jJn0H6rGSHsN4FUe6b6h/tHg3sdrrwZECZTvt7B+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider the replied thread for review.=20

-----Original Message-----
From: Khandelwal, Rajat <rajat.khandelwal@intel.com>=20
Sent: Tuesday, August 9, 2022 3:19 AM
To: pmalani@chromium.org; bleung@chromium.org; groeck@chromium.org
Cc: chrome-platform@lists.linux.dev; linux-kernel@vger.kernel.org; Khandelw=
al, Rajat <rajat.khandelwal@intel.com>; Rao, Abhijeet <abhijeet.rao@intel.c=
om>
Subject: [PATCH] Adding support for visibility of alt modes under their res=
pective 'active' attributes

In the current implementation of cros-ec-typec driver, 'active'
attribute of type-C class doesn't reflect the current status of active
mode. It's hardwired to 'no'. This patch adds the functionality to
userspace.
After this patch:
localhost /sys/bus/typec/devices # cat port2-partner.1/active
yes
This was just an example of DP alt mode reflecting it's active status as
'yes', not 'no'
Same goes for TBT alt mode.

Let me know what you think of this as the userspace attribute currently
has no significance.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 52 ++++++++++++++++++-------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chr=
ome/cros_ec_typec.c
index 7cb2e35c4ded..0de221ea22db 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -32,6 +32,12 @@ enum {
 	CROS_EC_ALTMODE_MAX,
 };
=20
+/* Supported alt modes and their SVIDs */
+enum {
+	CROS_EC_ALTMODE_DP_SVID =3D 0xff01,
+	CROS_EC_ALTMODE_TBT_SVID =3D 0x8087,
+};
+
 /* Container for altmode pointer nodes. */
 struct cros_typec_altmode_node {
 	struct typec_altmode *amode;
@@ -514,25 +520,14 @@ static int cros_typec_enable_usb4(struct cros_typec_d=
ata *typec,
 }
=20
 static int cros_typec_configure_mux(struct cros_typec_data *typec, int por=
t_num,
-				struct ec_response_usb_pd_control_v2 *pd_ctrl)
+				struct ec_response_usb_pd_control_v2 *pd_ctrl,
+				struct ec_response_usb_pd_mux_info resp)
 {
 	struct cros_typec_port *port =3D typec->ports[port_num];
-	struct ec_response_usb_pd_mux_info resp;
-	struct ec_params_usb_pd_mux_info req =3D {
-		.port =3D port_num,
-	};
 	struct ec_params_usb_pd_mux_ack mux_ack;
 	enum typec_orientation orientation;
 	int ret;
=20
-	ret =3D cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
-			      &req, sizeof(req), &resp, sizeof(resp));
-	if (ret < 0) {
-		dev_warn(typec->dev, "Failed to get mux info for port: %d, err =3D %d\n"=
,
-			 port_num, ret);
-		return ret;
-	}
-
 	/* No change needs to be made, let's exit early. */
 	if (port->mux_flags =3D=3D resp.flags && port->role =3D=3D pd_ctrl->role)
 		return 0;
@@ -945,8 +940,14 @@ static void cros_typec_handle_status(struct cros_typec=
_data *typec, int port_num
=20
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_=
num)
 {
+	struct cros_typec_port *port =3D typec->ports[port_num];
 	struct ec_params_usb_pd_control req;
+	struct ec_params_usb_pd_mux_info req_pd_mux =3D {
+		.port =3D port_num,
+	};
 	struct ec_response_usb_pd_control_v2 resp;
+	struct ec_response_usb_pd_mux_info pd_mux;
+	struct cros_typec_altmode_node *node, *n;
 	int ret;
=20
 	if (port_num < 0 || port_num >=3D typec->num_ports) {
@@ -966,8 +967,16 @@ static int cros_typec_port_update(struct cros_typec_da=
ta *typec, int port_num)
 	if (ret < 0)
 		return ret;
=20
+	ret =3D cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
+			      &req_pd_mux, sizeof(req_pd_mux), &pd_mux, sizeof(pd_mux));
+	if (ret < 0) {
+		dev_warn(typec->dev, "Failed to get mux info for port: %d, err =3D %d\n"=
,
+			 port_num, ret);
+		return ret;
+	}
+
 	/* Update the switches if they exist, according to requested state */
-	ret =3D cros_typec_configure_mux(typec, port_num, &resp);
+	ret =3D cros_typec_configure_mux(typec, port_num, &resp, pd_mux);
 	if (ret)
 		dev_warn(typec->dev, "Configure muxes failed, err =3D %d\n", ret);
=20
@@ -986,6 +995,21 @@ static int cros_typec_port_update(struct cros_typec_da=
ta *typec, int port_num)
 	if (typec->typec_cmd_supported)
 		cros_typec_handle_status(typec, port_num);
=20
+	list_for_each_entry_safe(node, n, &port->partner_mode_list, list) {
+		if (node->amode->svid =3D=3D CROS_EC_ALTMODE_DP_SVID &&
+		!(pd_mux.flags & USB_PD_MUX_DP_ENABLED))
+			typec_altmode_update_active(node->amode, false);
+		else if (node->amode->svid =3D=3D CROS_EC_ALTMODE_TBT_SVID &&
+		!(pd_mux.flags & USB_PD_MUX_TBT_COMPAT_ENABLED))
+			typec_altmode_update_active(node->amode, false);
+		else if (node->amode->svid =3D=3D CROS_EC_ALTMODE_DP_SVID &&
+		(pd_mux.flags & USB_PD_MUX_DP_ENABLED))
+			typec_altmode_update_active(node->amode, true);
+		else if (node->amode->svid =3D=3D CROS_EC_ALTMODE_TBT_SVID &&
+		(pd_mux.flags & USB_PD_MUX_TBT_COMPAT_ENABLED))
+			typec_altmode_update_active(node->amode, true);
+	}
+
 	return 0;
 }
=20
--=20
2.17.1

