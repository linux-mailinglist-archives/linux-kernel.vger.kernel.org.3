Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694E359F373
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbiHXGLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiHXGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:11:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134572C132
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 23:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661321475; x=1692857475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DGF2ZgVElv9qfDJEQqEXyP5CuvwsgjVx3I0BpEli1PM=;
  b=Tqz3FAyjSA/T7oy1lQq9uS2RZ+fEOrkoI2TKDX8kNoy85XuhuSidKMiS
   PNWfkHbOtr7Um/NTZVuWD4dkd9LSKC4aa9ERYLNNlMFzGu5dujvwhVOfb
   7cKgJwTC5KoL+bVLMEG4mBz4folGgMWQXzB33bF9HuKhC6kgCOwhv9X4j
   h5mjOZckVfwgOpUc/Y9IVeQbqrFf93GSHHFvpSZEvWJNGXEMPjTjkxjA7
   AeI+jDpgFevV/EvYxoO/Fj1VAlNICyZ/rAyazK7cPfXiihjabqmK4CuTA
   f4LB2Zl6WHby1rbzDsh4To4waYfxShpqR67e5Li6/ES6rHommSF/4A67P
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319933931"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="319933931"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 23:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="855141414"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2022 23:10:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 23:10:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 23:10:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 23:10:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 23:10:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYdquxO33ZhYTVeK9eR0b8GQdIVZJ121Q/bcH9aoMins9pICvtnDvXbvljOiuS6pVhz/8MpS52L35r37u2mcT/fCjb9t9UiBzT/fSppjXxPl9aT9cBI5qkuDwh1GAWAs5KabQU9VRKA1HutYZV+ebxxNExBm4DAYrrjSNFXXODLUjGESqkjEhkoG/agXYZNwnKFWYejYo5//8siTPK4qFMT6yh7pzAge7+SGjIfiQBDsGQQ2Vp2B6uoTG0OVWEJkr1nhPhMbgjmlKbHWVTW0tDZ45etH9lwuB8cpELA2bme2Pha9dLclLuhPPKUpLt+DkMywaHuGuoufu9HEEdq1NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGF2ZgVElv9qfDJEQqEXyP5CuvwsgjVx3I0BpEli1PM=;
 b=CopXdEQHtthUO5Ukg0HfFXtNnyAC5VYhCF9b//qdRrN7Uo620iyr0TCE9+X73xG6cKeGQ8SYuW4MKllHlVE+pWK18nuU3gwYD4wJ3kXtj59WK482UQREoYV0dZojGpFC9+gqWIwBc892/ZGG++hGmMUDG5fmqz0uBSqCBiBB6S3psJyHPys8nO7uUOL6pKsvEG7w9Jn2n8PekawMc1yzi0n7t6mk+Oxuh2ZS8Iaaf/XsY0Fr/dLMlf67QOrMQ3KuDtTQvuF7iT139irSw0Sf5UYumJWY3oGtOxRMNtaEvE2/Pc8wFydaiT3inbqJp1lbtD9ndaZ0CX4J5bDcFVN5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11)
 by DM5PR1101MB2122.namprd11.prod.outlook.com (2603:10b6:4:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 06:10:57 +0000
Received: from PH0PR11MB5045.namprd11.prod.outlook.com
 ([fe80::4473:d15a:3836:fed1]) by PH0PR11MB5045.namprd11.prod.outlook.com
 ([fe80::4473:d15a:3836:fed1%6]) with mapi id 15.20.5566.014; Wed, 24 Aug 2022
 06:10:57 +0000
From:   "Xue, Zhan" <zhan.xue@intel.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "florian@mickler.org" <florian@mickler.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: Regarding WQ_MEM_RECLAIM
Thread-Topic: Regarding WQ_MEM_RECLAIM
Thread-Index: Adi20TVWwQYki1ZlTMmpLUbjHR8rhQATLfuAAA7oLRAACaYz8A==
Date:   Wed, 24 Aug 2022 06:10:56 +0000
Message-ID: <PH0PR11MB50456E21C95359B57223F23994739@PH0PR11MB5045.namprd11.prod.outlook.com>
References: <PH0PR11MB50451B7F2F155AD8A893E9E894709@PH0PR11MB5045.namprd11.prod.outlook.com>
 <YwUb8UmXvKNHgSrP@slm.duckdns.org>
 <PH0PR11MB5045D2FF3C98EAE995F7897194739@PH0PR11MB5045.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5045D2FF3C98EAE995F7897194739@PH0PR11MB5045.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 761b5005-520b-4539-4aef-08da859768b9
x-ms-traffictypediagnostic: DM5PR1101MB2122:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOmCha1KiMezBOQF+PmEQDT61oOP4OrtxaS5P/c+4XArBZx4b2js9yoXdAtOrskuHMPclF+7au6LSkmTcNRNSLxswTcmZpxQW9khJ7bzni32fC2xCBt2JaZNmF0xKzPNQSl6/PK0Pt9J1RzBqYmn4kHm0lb/ryTeY0TJ1hVyDvoZMDzhdQm0XrLvp+8uP+wuk/G8fWRoIeBurxmyPJnyd/VrarVmHOXfyw9C7MFpaHb7FntzrFdTUPjgXbyHyWQwUiLvQV6zVh0pHlX+3lx9BRNYX/Bb3wd4zZMhDmQ+/qZ61+cXLtYpCJBlRTvhKou4Pv/t6QUibDQK374roMUYMEVSu3OxWFgLkEdsSCGMo5Pt0JFOnaQXXpPjU0180zM5dKtkMY12s1VS/JekVTXd+ZO9ygZt26L2h4IYiPDBAEEWQ3j42cReXzaLAiheJTwBh6mJWH5tL/3/hgsNcGv8642QVO3FjcOXdzhXEd97EEs5aFs9mo4yPfQuNlC8gBDPvdLiTGe3jawnaGEaea1UCDVRbeQv5gzp3jD1H0rciWIEa0ueFKX3B0LU4pTiTF7msIPcVdKiLZRQ+YUpl0U1TPo16tCOmMT3jD5T1RZYJkt33Awsl+JI+r41bAfBvDLZtUSPLSmRAm3RPwbXjsl53xYWwaNeyCGMIufFkURFgkJ+kYX+Q8AccCpjHqkGUKi8RpyYZgKr1vqZbu+fTQmXZ8uO/k92p2nLON/ZjcORW0xmso0zBNLDHqkSlkmTTcJ70MAV3P1+RbjeT3TxD75Io1susyEeaB7lCa9LVZ2Fhg8BYwFzngxFI3ZKWZFfuTf0hS+S9STQ5S9i/5fbhz3ndg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(39860400002)(366004)(55016003)(966005)(186003)(5660300002)(66946007)(4326008)(64756008)(66446008)(83380400001)(52536014)(66556008)(76116006)(66476007)(8936002)(6506007)(41300700001)(26005)(2940100002)(478600001)(7116003)(33656002)(9686003)(7696005)(8676002)(53546011)(71200400001)(86362001)(82960400001)(122000001)(316002)(6916009)(2906002)(54906003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kpBo+2Jph4NPcu6zteE8sDicaTqbqtUGnuzQrOU5ffZa4K19lje8r7ow+e?=
 =?iso-8859-1?Q?N+AY2IcZ7hGSlj6yQHazKRxHJkzfas8w5zTQedIq0DVfVOg+1KaZziWOTC?=
 =?iso-8859-1?Q?jtzOTqfYCghg4mztiEczTq0CThs1KXzl2LwOMwy6JCDS09W7oEsEAxVfJi?=
 =?iso-8859-1?Q?HlNg4e7K5sNzOJsN53PjVjpA8mksGJXYqugdoIh33Hcp7ca/vhLb9aGprO?=
 =?iso-8859-1?Q?MztQhN4R9e49Aj0YtTcSJqurikz6yfgeqhCMcXXHVjOAXYTQ+xabtKTjh+?=
 =?iso-8859-1?Q?iOypvkjYfe6wTngkDgzMArCe1hb0uh2b3knrOw5KA6lrWelEaa2OTjR0gE?=
 =?iso-8859-1?Q?MpvWXLoEDOTgsJamaBWOZ2s1sBa4slgeykU7rVRcIj8h8rjPzYXrOL/uk0?=
 =?iso-8859-1?Q?uDoYjoVLXDEJ+HpGEK2xDro0njI1pTI71NDAf5zEo52AJcQpocTUlzphV9?=
 =?iso-8859-1?Q?iEMhO6vpmTFg9ff4UU0y5mPQWQPDbTEDL1zgPFx0ZHHz3cDP2t2xYAbtD5?=
 =?iso-8859-1?Q?X6TRvKUrhWJwr3G6se1FOuvyupAurNeDdGshuujDbDtXV/1kvzvWV3Blz+?=
 =?iso-8859-1?Q?7NYM0/e6TMt0IDRyAVfccj5OmXfIQNO7xLdBXdwbVLo3th43ibpcHCy8Ii?=
 =?iso-8859-1?Q?344CIc2asajytsmeiB8sbf9jX4v2FlQAy0VvC4M+mH3yZHPpfh2I6K/W88?=
 =?iso-8859-1?Q?hQFP+6nvBHjfrM8jqWCRC91n0B7l1tfxkB7la1hyjxK2Jtv/JMJsI8sWPE?=
 =?iso-8859-1?Q?/K7Fg7/lDQt9ImgHRAGJm4CMGLrWj9xFmztnEHO7drdrGVFahtlAVbZqNg?=
 =?iso-8859-1?Q?UNyPLX1YBqQF/3WK0HxuFdlbG/e3EpdEj9QtjRMqdG737rOij9GxAW5oaD?=
 =?iso-8859-1?Q?yU5cCt0F0+zJGz8yzSLbl/IM0kumcMQ8UNuIwlv7dbOdFIJR6MXQL4kkWO?=
 =?iso-8859-1?Q?Tix9BxTETsJKQPvikT12XawVbyjuMVFZFpwRguaFxdV59QlbYtz+iEqn0V?=
 =?iso-8859-1?Q?E8T9y1fhgxvtwSglTIQrF86j2N3kjYSC0wp3HYQuoHR6g4sf+tUTB8G7e+?=
 =?iso-8859-1?Q?+0jUVgjmxT2fk93CVa8sAvmXOGwz+1AkuLaek0o3yccLLR+q3Tf71CLNLA?=
 =?iso-8859-1?Q?G8+QT5ga+nUeAtt2CMjB3VarTueKOQO3I1waPhH6k8ZcG0XxfT+nA/V0QL?=
 =?iso-8859-1?Q?7B1+ZbpcCkO2f3YWB9mL1fKGan4pcwdApeL8EM56JxJVQH/TruDU7bodij?=
 =?iso-8859-1?Q?lj4TiePPXr8pVFXU6k/mQ/nJDqJFFrHGbtfL2GCQbaj2N0vP9Nd8bPbi+4?=
 =?iso-8859-1?Q?igrLqfZSTgmQ7if8vXbFktCNL3cRRW81KcT/9BAVredyIy7oQRTahl5j3O?=
 =?iso-8859-1?Q?aam+5VEN73qolaculjTG09S1q4O4s+IqEXhVrFWDaPA/K4YquIHiaK8kpp?=
 =?iso-8859-1?Q?n83RZKgjjhJVagcdmU77QHTN2d/JsCWd/OxwxFmrsWaON0nqdmlq9Z5k/x?=
 =?iso-8859-1?Q?7Cor6qLrOmfS93vjP1t51UAre89YYmcRn5nGvqi42vnzLZUw6Kr5F59Qbu?=
 =?iso-8859-1?Q?JzbmRkUW/5UqLrrcTtY6qqNGLYVBeR3LPw9aJ3FwXJOaZXnBxSWkCGecFt?=
 =?iso-8859-1?Q?hluH3tefIQEAbHpnFMX4+qVNpcc52q8n0S?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761b5005-520b-4539-4aef-08da859768b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 06:10:56.9720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYzzkkNQYR0xbQdUKhuhzFZL8ymYNgq/iCGEHnsQ4jOcK/8aEhG8IbA8ElTuiTee2czm62EgtDqEAvsCLZdEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to plain text..

From: Xue, Zhan=20
Sent: Wednesday, August 24, 2022 1:47 PM
To: tj@kernel.org
Cc: florian@mickler.org; LKML <linux-kernel@vger.kernel.org>
Subject: RE: Regarding WQ_MEM_RECLAIM

Hi Tejun,
=A0=A0=A0=A0=A0=A0=A0=A0=A0 Please refer my inline comments infra. Thx.


BR
XueZhan

-----Original Message-----
From: Tejun Heo <mailto:htejun@gmail.com> On Behalf Of mailto:tj@kernel.org
Sent: Wednesday, August 24, 2022 2:27 AM
To: Xue, Zhan <mailto:zhan.xue@intel.com>
Cc: mailto:florian@mickler.org
Subject: Re: Regarding WQ_MEM_RECLAIM

Hello,

On Tue, Aug 23, 2022 at 09:29:07AM +0000, Xue, Zhan wrote:
> Hi Tejun Heo, Florian Mickler,
>=A0=A0=A0=A0=A0=A0=A0 I see a few patches and discussions regarding WQ_MEM=
_RECLAIM.=A0 Could you pls confirm the explicit rules?=A0=A0 e.g.=A0 Is=A0 =
devm_kzalloc with GFP_KERNEL allowed in the work queued to wq marked with W=
Q_MEM_RECLAIM?=A0 Thx

Yeah, for sure. The only thing WQ_MEM_RECLAIM does is guaranteeing forward =
progress to work items on the workqueue under memory shortage. The workqueu=
e can be used for whatever. The thing to be careful about is that the forwa=
rd progress guarantee is good for one concurrent excecution instance for a =
workqueue.

[XZ]: =A0We could also say WQ_MEM_RECLAIM can benefit memory pressure mitig=
ation for the whole system (not only to the current wq or other work items =
on it)=A0 if some work items are with memory reclaim? =A0=A0=A0

Let's say you have two work items queued on the workqueue and the system is=
 under severe memory pressure, so the rescuer thread is running the first w=
ork item. If that first work item does a GFP_KERNEL allocation and gets stu=
ck and the second work item won't be able to run until somebody releases th=
e memory pressure. If the second work item is actually needed to make forwa=
rd progress in memory reclaim, the situation isn't great. The second work i=
tem probably shouldn't have shared the workqueue with the first work item.

[XZ]: =A0if the rescuer thread could distinguish the work items for memory =
reclaim and choose to execute them first, would it be possible to mitigate =
such situation?=A0 It needs to =A0add specific tag to indicate if the work =
item is with memory reclaim or not ( or other mechanism to indicate the dep=
endency relationship between work items on that wq for execution sequence/p=
riority).

[XZ]: =A0Also would like to confirm the understanding of check_flush_depend=
ency (https://docs.kernel.org/core-api/workqueue.html). =A0=A0=A0If the cur=
rent wq is without WQ_MEM_RECLAIM ( memory reclaim),=A0 there will be no WQ=
_MEM_RECLAIM requirement for the target wq and it's up to target wq to set =
WQ_MEM_RECLAIM or not per its need ?

One use case is that the current wq may be with the WQ_MEM_RECLAIM =A0for m=
emory reclaim (e.g. the work item on current wq may free quite a few pages)=
=A0 but the target wq (work items on it)=A0 is irrelevant to memory reclaim=
. =A0=A0There will be a warning " workqueue: WQ_MEM_RECLAIM (current wq) is=
 flushing !WQ_MEM_RECLAIM events:(target wq)" =A0due to the requirement of =
flush dependency sanity.=A0 To address it there may be several options as b=
elow. =A0It seems opt1 is preferred? =A0

Opt1: =A0=A0The target wq can be marked with WQ_MEM_RECLAIM as well even it=
 isn't really in any memory reclaim path.=A0=A0 It's to ensure the work ite=
m on target wq can get flushed (e.g. by its rescuer thread) =A0then the wor=
k item on current wq can continue the memory reclaim.=20
Opt2: =A0=A0Having neither current wq nor target wq marked with WQ_MEM_RECL=
AIM can also pass the check_flush_dependency. =A0

Actually in practice the scenario may be more complicated, e.g. the work it=
em on current wq may free a big chunk of memory, but before that it may nee=
d to =A0devm_kzalloc a small piece of memory with GFP_KERNEL for specific p=
urpose, etc. =A0=A0Sometimes it seems more like a trade-off and needs to me=
asure the Pros/Cons case by case.


> If there are indeed some principles it's good to update them into doc lik=
e https://www.kernel.org/doc/html/v4.10/core-api/workqueue.html .

Ah yeah, that'd be great. I don't have the bw right now but if anyone wanna=
 take a stab at it, please be my guest.

[XZ]: I feel it's good to have use cases(e.g. if above case mentioned is ap=
propriate) =A0listed for guidance.

Thanks.

--
tejun
