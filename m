Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CC59E714
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiHWQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbiHWQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:23:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0418B10;
        Tue, 23 Aug 2022 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661258746; x=1692794746;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2oMU9AUvopiSBVmLWHRyZDhD426RdqrpjG2pZ+DatAY=;
  b=bSBcRqRRzAuSBARJZwl+A7djmTsJAzfendnns4cODifSL3Gx2QDh2ZKL
   a/c5AeZ7+uL3FJJRWFRDX6SDC5vuV1VeoE/58OWT3MTpZPIA1JzfsH8yp
   wPIk6++B/IugjYff8wmz/OikCdNO4h6eUxp6YWfDV+ycEuy0BST0h1oN5
   iQ8/2GlV8FfiW/+3qNlETFJ504Ir+icnEjiubK7miUdOm8Ea2yqwXArUR
   PJxZt+VUVqiFNOzZLhzg8UBK/JPWXYpwbgQx5lucCGw1pEqHu2jIfJaxh
   CO73C9u48N5hVP39P11qHcalcLKweoQvj8uBSYRwMH2/GcQjvmKUwd45Z
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357654385"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="357654385"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 05:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="605647672"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 23 Aug 2022 05:45:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 05:45:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 05:45:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 05:45:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 05:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAQnP96G80k3C3igMkHfrFdllx8xHzHbw/wzpEIefCQUEZdLZG/rCInXk0Ks0vQCSLMummUTFH9yUhjjTIlZMqfm7OVlD525/WqPtF0EzpmB7NfHvHzkP7zEqrioVeJ6AcHkKXMQ98eY/aoJC4A8Zs7Wt78AXyB8Wfz2Saqzb8uHjYprJiU7a2S0A0lzbEwSHfx+V69Trk2s5djQH4NMHnT1Mrn3XRviVgx5jWDtooR58MGXPnuTBYtu6y2qoygKuDzg/vvVXTMy022BNn9XwdRHb0RAHrn9/r1nBxLRVQZAzcgB2nCXsVMZVwc6OWtWTXrfhlxmngsTw+gqv2lttA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63WD3K5Eohq84njNFLHvelX/qxFIkfe3dvpSAFXyxe4=;
 b=OVZmZZO7+h29OhvuN64DXSrHxr5Fi0bY+IirKuod5pfLyFYyIg3yEpeKHiqv9IU3j4OgPZfodO/G079nAXOebs1fCc+IlbE6hwaA8ovwnkR4kekejoMzYn7jJvsUXh7OJVgsheH28m9gV20vwkJATt/bM9rmA+76nr7WnaQOJgLIbadENBm8r+fZ3enDdrid1gosnHW+2i9FsJ5bO2MEUgmCc/jTa3JI/D9OGTTkWJMD6br36iKqVE950QInlJqoMzysA0NPiegP2FDYnWxJWVW2INLhvZjOujkc/uhdYFHAdboQWDvpkFPs0liXFCjck7dp6VccZqKWKwRoEDfVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by BN8PR11MB3570.namprd11.prod.outlook.com (2603:10b6:408:90::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 12:45:42 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537%9]) with mapi id 15.20.5566.014; Tue, 23 Aug 2022
 12:45:42 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "Lee, Shawn C" <shawn.c.lee@intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Enter safe mode only when pins need to be reconfigured
Thread-Topic: [PATCH] Enter safe mode only when pins need to be reconfigured
Thread-Index: AQHYtelA4IPzLtluIEe/qp4RNZSZMK28cDlg
Date:   Tue, 23 Aug 2022 12:45:41 +0000
Message-ID: <CO1PR11MB483551294EC9A0E1FF2C2BFF96709@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20220822054019.GA32363@abhijeet-NUC11PAHi5>
In-Reply-To: <20220822054019.GA32363@abhijeet-NUC11PAHi5>
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
x-ms-office365-filtering-correlation-id: 05a4174f-4304-45f8-4cd8-08da850563b1
x-ms-traffictypediagnostic: BN8PR11MB3570:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWN4+b9TL8+yJ+G0f5cfh/PzENKi26cf1qAd9x2l2T95GvIPHGITP1s2lKoi+/Ah+d7fcno27s7pPZsFGxp68/FJOOkGMmwq5jHM0qCR8Pz4+6C0bpeAYzky5kjC9IYNXgeCEyA83nWRSsVJJDlFzNYdZV0mVs2OkgvRWRk0ND0gA6okUTKlfM5usnGzdeN2PQ6QtoYbVTyuyAaJ/T4IMfuffFK+JiSanpF8tcxCwqVICrUhTRsqud0oBg6LuPER2BERuVCFpfSLl1zG0j5bKWj5FlGKtOes2P4Eq57ZFzTM0bG2CaUHi9BE3kgKmmJNLWNO7zs7ZNTDplTW65J0AGszWpLqTi1QcpmlLrBSWX/5+rgTYRpz8S4pWA0U9LMNBNSCxundSxKH9MWc2F2l4WJHOaQ1yE4MUB9cXcMg+wmfH4uJm1PFw+f9HoaJpVuFncZ7pBYoKBkl082L07VfxiFj/Dfd/1rrb21r7DdKGpNvO+SHzHITghILbXuCIDIIvOi5vqUoY0HV5QemHKOkYq91W7+dg1toqMrdKdRX6NQgBck8rHqGvcM/ho1F0FYsikcJ6qV1wLTzRiI34RSwHKnQcxkrttzP0zwcFdWDzFWRLYccinGwrVBhS8yWBfHySVRXJTu8ni3oob38c2tMc69ZEj1+7zOT9PdzjESRSFc32Hng4yJgd//HQxzZ4NF3Bch1HURmbt3n6rnPwzD3BAVrS8Sg4wrY6N839Z2EN4qE6IpzgMLmk6bkd7d4VUSe9exC2Edf+6kPCU6uGhQt3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(376002)(136003)(396003)(6506007)(86362001)(82960400001)(83380400001)(38070700005)(122000001)(38100700002)(9686003)(316002)(54906003)(110136005)(8936002)(5660300002)(66446008)(66556008)(76116006)(66946007)(66476007)(52536014)(4326008)(2906002)(8676002)(64756008)(55016003)(71200400001)(186003)(478600001)(41300700001)(53546011)(7696005)(26005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1cDS8gw9+soorrWlpQMpQ9XQxNnEna4F06ar7tbnXnthxtgtIxQG5L8VjvvK?=
 =?us-ascii?Q?71TuOoms2QHwW/dVSg9sRZY9gcaGhQA+OR/xOUhJ+GrW6WOV4ji59i5fFs9z?=
 =?us-ascii?Q?5MvdtS7mQrlXzC3mHNoaSS7axbVwMBSqMLIjH5JLvIG2UBy5IsYMWl+ei2kG?=
 =?us-ascii?Q?/FOHEdPz7UYZ0MlMldn2nkSnltpSb/A9SasFBu8lwK1NIAZ3+xhqhIklXJqZ?=
 =?us-ascii?Q?my7TlBpj4Imetp0PxtYPiW/pqbwYIXtnNGich+8X0+OfUjHHeHVnjDXg0yMX?=
 =?us-ascii?Q?/3MzcIiDT1kSKn572u8MTA4Nv5oL9O/9ecisabvnd5durifrfn9yl7saX9sF?=
 =?us-ascii?Q?kuR/fU2GS9bfg8B4KGe7dBuOAke2azKOkOuZNrKBSWIgMQ0A77La8qCTquSX?=
 =?us-ascii?Q?dv7/BqMV0ulL7jmp1KTalntRiFffh2cioM+5SlGWZZYlGvXuZlHXk9g+W+WM?=
 =?us-ascii?Q?jo95bqZkFAc/36f9O7TJHA0nep4KdOz8ghfTRduOr8L4Rs37pRpta/oZjeTS?=
 =?us-ascii?Q?Gw9HoxVyZgwo2ADMD2nJyLkQxLqAINOwEZq8U+roQCDXDd9pavJNpAuxC0gn?=
 =?us-ascii?Q?RODbQZFimQnte+11BHMJdsRWU7tggEX8woHwB9Yca+H6uUNjx89E/Dmp7wLk?=
 =?us-ascii?Q?w+OoFgsRs3SKi3n9TD6XS/71cZjaIy2TzaX66SpyxtRIpVzNV2TPqFVEhazS?=
 =?us-ascii?Q?Q+LGhNy8t4zcrY3rz/gun01gSK/zZ6LJ/wh6WtBLaAhtdrTYnazfWNwWhZQC?=
 =?us-ascii?Q?bIbbEnJkuGlFPf/Lz7gRhQFoDe8pnDYTfbeVtsNKszgmH4cDl9IPxBhWdZ1K?=
 =?us-ascii?Q?BKYwNf3loXMB4UUhv5g9Wuyk4Tc5INodl7FpnqMV/dVUq0VdfZ2sXzUoklTh?=
 =?us-ascii?Q?loOHPVrHq7LawGZetkpU9vfw2DWdFMChYTauFzLwhTzv5gaAjlCRfgtjr5IR?=
 =?us-ascii?Q?GKUKwXCOKKkykvI7C97/8IfI1+PDlJiDlnvkkkv4mI1vpWWk52IsMz7O8YO0?=
 =?us-ascii?Q?tVvyI65Bq5YCyQnUGz4CFaJkdjI4wMfIsc8j+HxdBF2yFjn+ivwwEn+noVAo?=
 =?us-ascii?Q?ppVzZopAyfd4ZXYcEdlEG/uFQs2/1GUpm3GwYv8inalDpoSBehWHdMm6f1XS?=
 =?us-ascii?Q?lxOfIpl8vz1GrkXllLnbgjPLTsXppMHqnQiapO6K6OyDISh9hb2oXZdxgXow?=
 =?us-ascii?Q?HidMBM82FDI0uE8B1JOyXwU47Rr4WblRmQOYyxZJAOdaM6G0T4mZUpHvx4vD?=
 =?us-ascii?Q?4itLWpQCllDTv5oli7wQSuRGPREIeHGXw1ftpy7w7Zc/S88A/Q6+biW25H5k?=
 =?us-ascii?Q?5Y+MBVQpKmHSjIIC+PwjEjB5MQYmsTzDqVb87PPTWoJ6ZwQUwNLQYWGMUwc8?=
 =?us-ascii?Q?jpEgHOKQKJoYMIqk8VNrKufD2ToxtwxzzpNE/ZmeSf7bqikVuiYTNAGh4Ku0?=
 =?us-ascii?Q?ENcjgeaTuiDZakOOmNANQTx1Ox9VwZ6OsQLvs8z0Y252iIKDzD91JsRqzTJO?=
 =?us-ascii?Q?cGWKoNsyx8oEPTSwdzS6GcRYCeb8Qtmdflta6qfBJ/7/lY+dTl/jFbj94PkN?=
 =?us-ascii?Q?/deZ4Lf3W1WB3osaTEeL3bFDX2VETEb6YRz1JFEbzQHijJzz9wAhihuwxRKY?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a4174f-4304-45f8-4cd8-08da850563b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 12:45:42.0084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evb7llSX2b/YFL+GbM/WOfUbzFjVgzW5uTKmvd3o+auS2Iz6kWbrjSgRL5BvS7kyyxBfA7MxB591Okz9CtG8jpGj81a378DHJDQqD1wrJxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3570
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Forgot to add Greg

-----Original Message-----
From: Lee, Shawn C <shawn.c.lee@intel.com>=20
Sent: Monday, August 22, 2022 11:10 AM
To: heikki.krogerus@linux.intel.com
Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Khandelwal, Ra=
jat <rajat.khandelwal@intel.com>; Lee, Shawn C <shawn.c.lee@intel.com>
Subject: [PATCH] Enter safe mode only when pins need to be reconfigured

There is no point to enter safe mode during DP/TBT configuration
if the DP/TBT was already configured in mux. This is because safe
mode is only applicable when there is a need to reconfigure the
pins in order to avoid damage within/to port partner.

1. if HPD interrupt arrives and DP mode was already configured,
safe mode is entered again which is not desired.
2. in chrome systems, IOM/mux is already configured before OS
comes up. Thus, when driver is probed, it blindly enters safe
mode due to PD negotiations but only after gfx driver lowers
dp_phy_ownership, will the IOM complete safe mode and send
ack to PMC.
Since, that never happens, we see IPC timeout.

Hence, allow safe mode only when pin reconfiguration is not
required, which makes sense.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
Signed-off-by: Lee Shawn C <shawn.c.lee@intel.com>

---
 drivers/usb/typec/mux/intel_pmc_mux.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/=
intel_pmc_mux.c
index d238913e996a..4bf84466d1ff 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -432,6 +432,25 @@ static int pmc_usb_connect(struct pmc_usb_port *port, =
enum usb_role role)
 	return pmc_usb_command(port, msg, sizeof(msg));
 }
=20
+static bool
+pmc_usb_mux_allow_to_enter_safe_mode(struct pmc_usb_port *port,
+				      struct typec_mux_state *state)
+{
+	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, DP) ||
+	     IOM_PORT_ACTIVITY_IS(port->iom_status, DP_MFD)) &&
+	     state->alt &&
+	     state->alt->svid =3D=3D USB_TYPEC_DP_SID)
+		return false;
+
+	if ((IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
+	     IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB)) &&
+	     state->alt &&
+	     state->alt->svid =3D=3D USB_TYPEC_TBT_SID)
+		return false;
+
+	return true;
+}
+
 static int
 pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
@@ -442,8 +461,13 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mu=
x_state *state)
 	if (port->orientation =3D=3D TYPEC_ORIENTATION_NONE || port->role =3D=3D =
USB_ROLE_NONE)
 		return 0;
=20
-	if (state->mode =3D=3D TYPEC_STATE_SAFE)
+	if (state->mode =3D=3D TYPEC_STATE_SAFE) {
+		if (!pmc_usb_mux_allow_to_enter_safe_mode(port, state))
+			return 0;
+
 		return pmc_usb_mux_safe_state(port);
+	}
+
 	if (state->mode =3D=3D TYPEC_STATE_USB)
 		return pmc_usb_connect(port, port->role);
=20
--=20
2.31.1

