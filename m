Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0F59E741
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244707AbiHWQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbiHWQ1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:27:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572D112C5D;
        Tue, 23 Aug 2022 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661259184; x=1692795184;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=rLN2vmmw2UDCX6NfOf5RaRJ7BAm9IXrUTXo/1pw4YqE=;
  b=V0vltM8tMtThBKszidwVYTRnAJnOFnsinzBqG4lqCSoi38gqBMcP6w4v
   uuJ5bnv/bVYkTV4ydYVvBpN2fi8ed54muHYb1P/5iSHMg65NCulj3kQxL
   pg4MRIb0YDYIACGoM/Ip7rHTLptBwWTH01z+D1b0aKRodsV9g5pG1wQDK
   7hqJsBmAiso9Kr/ypkSNHHRJKVCrJOnS2MMneI8f4bCH5tckwAh11apPj
   0EFM/Ou0b2n6pU4BpD8fKjZKODI0mz562kSufgQgDmms6e3CUtGRqrKgL
   w5cG+sCCrtQMWQdvJ7uag9llo6vYCrh5eZc64Nt/epueVDCsXUa6n7w7m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="355408477"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="355408477"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 05:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="785235924"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 23 Aug 2022 05:53:02 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 05:53:01 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 05:53:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 05:53:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 05:53:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGxkCpTKq7lsS8nxjSqn+9H2Konk9YFoXGy22SmlS4UJyoZOjjfDt1R/+nlejoE9w2WnppLL14CtU63iyjFnkZL/Qh5ZObdWjVPYIZXBXDzdJrd1+UBDI5uqYVPLwdZj/JNFco3+9AoIvMQKGL+acZBHJesspiBlRfMrdf7EdpGiItkJrOpBCsSVn66jEfVag0tW68oFlSsVOGAN2s/j1BBfAI3yj5Wahxt4wnTj3MGrOMYLL5GPwPs/f3eLy6H18p3+IZ3L90jt7Ki4Ersj2/yNNjvaYKf6lgbWt+W4xG1KyiL4q7AgFAfu4TxdPu5m5Juy9A/MtFSBDTRNq+H/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLN2vmmw2UDCX6NfOf5RaRJ7BAm9IXrUTXo/1pw4YqE=;
 b=kMVD/xyu02V19Vl/K4cHgrKWaEx6XndHohNrm1THv3sDPRaI/x04YpjeXcUhqoYAwhZza07FGJgi96cJA96AqARsK2grh7K8RQKxa0Gqiab9Q8nkdZdo+QB5KEPXGyIQaRVkodKuD35z/zJQFg3baLpqZn2n5JkAGQ7zwTQ06QSsr35m9nakK4n0EGTGXZ9i6VYS591QpPRqyKB3EyOIMLZwX7wGmx0Cy5U/S/53+h+eRJnG/QutfTMlAFTo8BDFaAq3zW297v+oVBbO1FJ3Z5ii0CNzFZ51juIHVMEH3bjo0Lj7thkRsA8Ri+Ke7kv4UyG0ApKouDoFRRJpieOO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 12:53:00 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d9d9:ed53:6b0a:e537%9]) with mapi id 15.20.5566.014; Tue, 23 Aug 2022
 12:53:00 +0000
From:   "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
To:     "Lee, Shawn C" <shawn.c.lee@intel.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Recall: [PATCH] Enter safe mode only when pins need to be
 reconfigured
Thread-Topic: [PATCH] Enter safe mode only when pins need to be reconfigured
Thread-Index: AQHYtu9Gb8C2zy+8VkCl0e013+uj4g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 23 Aug 2022 12:53:00 +0000
Message-ID: <CO1PR11MB4835EE4B83895D882EBC80AF96709@CO1PR11MB4835.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5fb3934-f969-47bd-90c5-08da850668eb
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8hqYr2DHaVF8fIruWlJm4D4StQbxj5FKxoUk0u6cq6F0dT6lYl/OIieoiJg/lnYHq7A2Nhvko0RP1gi7+pJ+0478a7kpkxYkw/R0p/ssqerLwohx8DgdTLHBfuNwiSC81m42XOBAaDXZJmZ71dwsMdZBNEnDri/RczJIneouhYKCWin8ie6Ez4PezRjx0pE9a7wt58DgaaCL2GYuWRGEtv2SNKqrzQqEDGUxI+dfQNgGRO80elHt6QKGnD+HNEliDlaIdpmuTqQ4S8FWX3g7s6Gbp9s2eji52h2oGSnBMFA0yPH0Udr9FMDNpTnnxetR3c7KWyANJFQzFihZplOxZ9aPx5evRGxy/4c3f4rt5OgruJ66EI1ckcV1m1QvkrgrDfwW8l4hPzi5H1qI+mzkpD/Y5HD0r3Y3k2nJhR77I0I5mbOdpJqW+AuEI5pohRz5zzbzhkERxrsBY76rqSWLnsQkiVV/rGNvM4KFqTOP8lUGj12RGCgE4unVBQ34wJ2pzeXKpo16LXwpmFthXgqxVXUU1ax8Euf2oSAdY9nzOTjKQONYHqAN2h9biVLG0hZVANm4gXyOz1cur2qnJIKy+Czsc3IPjd0QL7zjelf/VzYjjGpVuzi8pcPAE9pAAyWk13ycKlhny2CZb9SmiJVOqCTHNfA3NWZWeMIBbE7zRRbZkD43qMM9S4j4r9lLOphtyIu0BECn4OOlwJHiFOCqn6/whqV++FXPvRmqqp5jO+XXxjRIHzWNzmHD07GqzctnGLULAIsl1F+AzTAKY1bag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(396003)(39860400002)(376002)(122000001)(38070700005)(82960400001)(86362001)(38100700002)(316002)(54906003)(110136005)(2906002)(4326008)(8676002)(66556008)(66946007)(66476007)(52536014)(8936002)(76116006)(66446008)(55016003)(64756008)(5660300002)(83380400001)(71200400001)(41300700001)(478600001)(6506007)(26005)(186003)(9686003)(558084003)(33656002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nyove7Nuaph75Wpu59SRIOy35XRIzsr9zK8VYNBclFDYW3VT0DePaCMiZGpr?=
 =?us-ascii?Q?Aynq6LpHtGaOu4sLaL7N3zN3QBvGQRk8VuLOcW2l6rqgqwqJbYL7vudBzE1c?=
 =?us-ascii?Q?hLNqSxm60UrUKOuGXVu+3U275QdzGBd5FlNzC4chBhzvkmp605+ieXPDPj81?=
 =?us-ascii?Q?DmZ9mdzKYWb2Hm2OnQRgrYWcIMbNkJTr2EDSWnAHSx62dKC+whox1EbjPt2T?=
 =?us-ascii?Q?WOUMTMN7CtcN9zk4GHlxdBsK4xI5KniVeCjWkdS2wCiOfyDvOk/8aa9WAAlM?=
 =?us-ascii?Q?JjdC/EQIGNgVia6v/SD0yIPSRDGnObVgassf4qFCrvBLRJF5cHYCYJp12BS3?=
 =?us-ascii?Q?poMbi/FmY2Pd6YmcEz8fNHlq5TX74Bqh4P2EYnLxxim8/ijYD1AtDy/J6Et6?=
 =?us-ascii?Q?mTw3H1zoLZejp5ZWGzVEJafMeCfrnFSfzntodtNlt/xvfLzZKzfaONhbc0pw?=
 =?us-ascii?Q?gJD2zGJUubUVWgVW1fWAphub5+nqz3Jw3y4LGEOcxcD2m+zJsTMU/zpFwqkQ?=
 =?us-ascii?Q?FAXa4WOVd8PvTfIz5w9+Vyo959Cg8FePdKSFgihDFxeAVgYk7R0efi3wPt3R?=
 =?us-ascii?Q?66MjbY/11X7gRwm7KsU4xaDj9vaSbCddeXIdZMQdx/Ozkt1fH7KhaaluaTPS?=
 =?us-ascii?Q?z6bLIcdm8RTuj7pI+JVMqcrKcQs7n1BlGORyYz8b0uAQCNyEBVLXQanVXBhp?=
 =?us-ascii?Q?3Bi6OWQAuGKINNX3OH0JmXAVsAbAz4SuF/S6nIF3TSOiTjBfzQyeRzu5HYMi?=
 =?us-ascii?Q?tCDk9H1b4JBC6otv0eZjJImhuMWUPkLbKChTm3/wz9AA1LQqemcXBBsUYziv?=
 =?us-ascii?Q?R+IHn2DD5HSuuiMuQ1Yj0TO9P1z3zYjnIFtxYa7FOpHejEa7msokSStPqAaY?=
 =?us-ascii?Q?fivyWjGyEc7rf/tB4T7O6MRDHQKBkz4E+wFrgqheKHDktOB3873cOsIqi3nD?=
 =?us-ascii?Q?OF4A43DyBxqkrVgLyFjwJu6FvY8uEWWiOwqfeJWTzUy6+AL1Br/qHwfnC1Wv?=
 =?us-ascii?Q?OESraVqGuWlOmRi28N2rh8uVYTUfL7PT/NlPiupLYCXoSMgcMt7kdmloYS6j?=
 =?us-ascii?Q?KdaFt6unykhlrLrVAhAHuQKbxjjIp/UO3BUKCnDeevpvCSwm6iHnhm8+6erB?=
 =?us-ascii?Q?dx4TT1BW2Dth9O5HDR4BGR/vM9ipDIWWmLnDTFXyr1KY1Y77Mw8H6sZnWUHg?=
 =?us-ascii?Q?0nwRR7HhKbAKC5kXoubXEf2J+BXepTu6g91AGctO+I4R6P40QpZhnFvftfRf?=
 =?us-ascii?Q?xiHoFKegZiMTRiIr/LgsQStmLh8kymAO2BXgrVpEWWo0DpXDFEC/hm8FVthR?=
 =?us-ascii?Q?PrWWwsQGnPo6IJrzQ4JaYqwHCKf9BGhrMrS2IHEJRk5zbx5MtAbMNWIg6Ddc?=
 =?us-ascii?Q?okV6JuInLRUnk3hLjAolBECdh0llCxkHJ/YE4QwEWCAzXPLhM3dQv2jRyk6V?=
 =?us-ascii?Q?1A1oMJFFAIN9MMavHAJVFYdbrZT73+xOTtfopRd+uCkcCTg0JwgbnJwlr27t?=
 =?us-ascii?Q?eH9aBR7UlN3efwY4yjqqsjXtpEc4qrIVFwLqnxK6n1Bkxu6mZavLjEAu9u3B?=
 =?us-ascii?Q?oPeiXOHS8cX2MLjiN4oPqFUFEaP37t7Tv+w4ECV9XVw+SksKxsRBEYGPfjL8?=
 =?us-ascii?Q?Fw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb3934-f969-47bd-90c5-08da850668eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 12:53:00.2288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wb1PZoR0VGauWGyZIJhiPNKyELFBNbXrNZ+Oh3gHw/gHOCGpwNn9o1npkH/Dve3rsin7BvvZaJABINcbsjtvnFl/U4epVmD2sKzWBFqoGfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5776
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

Khandelwal, Rajat would like to recall the message, "[PATCH] Enter safe mod=
e only when pins need to be reconfigured".=
