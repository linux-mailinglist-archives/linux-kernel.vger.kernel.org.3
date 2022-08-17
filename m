Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327385969D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238197AbiHQGtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHQGtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:49:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8465B3A4A9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660718939; x=1692254939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5ZWCsgmy05RQGpmWmtzAZkMSwE6/KttSR4iu3VXsMg=;
  b=OglYX0kaQ2+MCHfiETVhMpo6olDzTFUsHJNqroK/UPNQIaq7RdOSfJ6D
   QWEAIdU5m609xEEYdUjQLBumvUZ5at3hWlhKuSro+NpYUQIMtmspZYC8+
   UeGjUKmBXkRzUIuVk+4Kim9NFo4YqPJlnKjK30BP/jTMQsDNAF/ddXOHR
   jRul4fcHGlivG+8po3przcjK4zaMb/UrKyf6O3iIYbqseMOCLmcOAvGXT
   AN+DAtaf5Tk2gvH0xHRavLCeEgBkSQV1JWkBIwrF++0dfN3UX3lP2PA/v
   5BIOzF+egPkZjhtwfk4rCoV9q6cL0jlCjM646K1BHNvfCYZQ9z+nWsdAR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="291172198"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="291172198"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 23:48:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935235085"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 23:48:59 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 23:48:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 23:48:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 23:48:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 23:48:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCodb6ynucW8jLACwjM3LXLETLxQRYeVAxP1af05xVOEiaoWxYu+RQaRnT667SmSFjuzQu41pcAnHq/kmNHBl3Msg2rom56836bcPRXGGZUEl45bn93d2ZQBXva767KxeimJXTn+TcJjeMFotO2G+S1jxkgiJS6zGctOJnkv+01GL0+4LW7MRS+r1UMreWGOq5gCPbNWaRhpcEYMvqqpBuD8RWChAwFBxuFbJwiJ4Hmh++4CI4h9VLkfNScGPaUOe72+p6t9D0JYU/Cz5ieNdB1pqTktotyhT2RxYBIE3hdTbM5yb0VoCnCmVDIHYyl3P2Bydnc7I1Zi4X1n+ir9IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqpqUu/lAUxBxlcb4rMVXh+kpe9i4OHg2EywejnMhz8=;
 b=cz1u/tR9MpILIEftcrKMw1/oWUxfkr2oNNSNvIjIonjrLUXCFCOsZBA7R8oIOLDdQkvpGXreucB5k6SFSXyf9SZxSMwlJ3qn4wBV2pZ8kVSxGLPaoeIwbWvC2cBb6E0C8LgDLFHZSDBA5Cshrx1K6kpRWjWN4Md9AsoxeJXkg5E1i1VULKUuBBI4u/qV4dlkaJTUEuweI13r/kH+W7Iu+M4RlmXQjvvqDoLPYS0gor5dS0a85wXZ7tlnPstGaMfqOFznYgjH4D2jJGqE38SuMIW/cENVsKwwGiXgm/xW7AR79Xyp9d+FmQ8+t7EY7U4GBusx21cpMVgErP3hzPhu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4074.namprd11.prod.outlook.com (2603:10b6:5:5::11) by
 BL1PR11MB5461.namprd11.prod.outlook.com (2603:10b6:208:30b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 06:48:57 +0000
Received: from DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::5987:7ae3:a096:3e49]) by DM6PR11MB4074.namprd11.prod.outlook.com
 ([fe80::5987:7ae3:a096:3e49%4]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 06:48:57 +0000
From:   "Liao, Bard" <bard.liao@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>
Subject: RE: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume
 issues
Thread-Topic: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume
 issues
Thread-Index: AQHYlx6d/CKOWCWhzkKJXwmOkvg+9q2DpNmAgC82tPA=
Date:   Wed, 17 Aug 2022 06:48:56 +0000
Message-ID: <DM6PR11MB40745C1283CFCC3F5D41FAC9FF6A9@DM6PR11MB4074.namprd11.prod.outlook.com>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
 <YtTzZ4iA0xt68euH@matsya>
In-Reply-To: <YtTzZ4iA0xt68euH@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38300286-141c-4759-aaec-08da801c8ed6
x-ms-traffictypediagnostic: BL1PR11MB5461:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Hdqv6TLW+TbprpXqe329rDuraMFGtWhDUegPO7+9STYUvVzkLQWD/iPmkJ+F4aWFoxC7ey2AgtqBqCnU5Q4HrgoUcUIS+bLFC5VbWtBk2BdHq3pyH4PY4l8EzlPmCnw3rZ55IK/naTwVbEZal1EkV2+yTwgQ3kEoAxduvBpV0qGKhfuE9vw1Oz9rnpgY7JTZCi2nyewHU7zDR/PKMOuhMaaujQSeIH7ec4Q2aUv/iO8XxWavAIiwK60M4VxWuo9qQY+b1PDUh1+UbxDbUHLnXDvTYZCfbk856pMZfmvS03ITPDRVeIFcZN7siOEoUY5Zgxav1IJj7Ue9zWUSaTWLTjwwfJdIgQgs55Kihbt100a/lZhElErf5ow+BvfS0LOG13bbMQZPtrgJH8JOp5QloiDY8/lV+CQb7zaomlzyHbQJi+ZGcSeXj48Y+g9l8UuJLhyIiZoMlHYsXLgJVC/hcW1J6xdHIk9MQkNYg0+IqDqZfWElCFca2nHKYogHWQuPvCXMNy7Ds9Z7DBvUGQMzLlDsxyKGtAsys4Fh5SGIOSUiNoABHW7cDa6TjjL9UBHuu///H9/sUriRHmXWmIM4/6Kf8E1qkNMJYcf3WffrqWrncRT9WXT6uFJdrm6KzbntOC6DHZBRM588MMpvS5glk3cthxRHpLC7vw4ghWuq7fZSUdXzWXXn3fwC1r7IoxQ4Ddmcgp9RLMluLMKbt7UC9N4x6/LFDPlRGMiZMrv3dUdekJo/PjfOgTKJQT/afckBt200oUBsNDuBBM5N7jIW9I+CX6sicAiXnhjLuEN9G8XsKlBv9HNPN+w6A+tNKI8X9wdqpk0rVEimrlgpldkuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4074.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(39860400002)(136003)(376002)(7696005)(76116006)(66446008)(66556008)(66476007)(64756008)(8676002)(4326008)(66946007)(122000001)(38100700002)(2906002)(38070700005)(82960400001)(5660300002)(52536014)(8936002)(186003)(966005)(478600001)(83380400001)(71200400001)(53546011)(6506007)(26005)(41300700001)(9686003)(316002)(54906003)(110136005)(33656002)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IZNth/V+gSKuWF9h5wLhv/1V2gdvNqCXmyVEXCeG1v1eT6jPTKDmNVYSWk4Y?=
 =?us-ascii?Q?EOw1KJiM4zPUM7TCHsVMdh78cUJcnmNERVcokrYGIX2aRVGL6Pnb/STmLWgI?=
 =?us-ascii?Q?/yj00vFDdumsXSedz19FbYaQ2JI45pydiUkOVLh5lvG2AoG3FmITHREBL1im?=
 =?us-ascii?Q?GyMpmf1nY45DAL3fHKxo+dcFrec1CiAk5g/Rz85w/NDgmOT3CmRm6hkabUBf?=
 =?us-ascii?Q?INv2mAmhsALI8Ol19tFSLNCc/yPQFPkf+P0p2S3s/4Ll8MZuR32hKKFWWl5S?=
 =?us-ascii?Q?v+BdkG4XIiFufbjldfMRioY4vxUAnqKY9ZeT01Uv5jEoJTJk+KHWriYUgycQ?=
 =?us-ascii?Q?axCvGgHv7ZE9YiPg199bxGN8KUJJfabYGrqfFcjj4L05oYcEwFIdpUvlKX6D?=
 =?us-ascii?Q?N0CmW9vroG7n3lPhejX4dREwAA4BnUn8fHjNW2BvU9vjir6utY4M8YiLFyEB?=
 =?us-ascii?Q?ZrtJhaiNzdu97vWvg7EZ9hOr/AId9L+6gTgsG46V74/ZrnpDY5iwPzNHWjLu?=
 =?us-ascii?Q?7cHNFvlcQ1vjaHhxc10H9wJEpbT4iaCgqW8FHrBtuEVmsUmGtlGj15ogmaIh?=
 =?us-ascii?Q?1QM+uzkj27GnSUvwYmQ1heqA/zTG+3oxJbDPxUwyaezj0a/rwS1cuLx5wT7G?=
 =?us-ascii?Q?YFdLul+zOokY7JVH782csdlufut1tpDlKTw+3Z898/JDPKGi/VsfORwSNJjI?=
 =?us-ascii?Q?BKXldM3Vik72phgPV0crDPFQf9hWZ6zctuALz5bPKo2Ss87q+tVP6PgIAm4l?=
 =?us-ascii?Q?HVHMuusBoKCYyQtV9o6wOONKUlBVB5g+w6Y4Q3RX/oXDog7AWtWERVcLEmUf?=
 =?us-ascii?Q?+s4nzjscuce+16e4SD0ru2rYRWVBYQWks8dZm8cvyPk9+6XIUdK28suFSY3q?=
 =?us-ascii?Q?R1u6AWhjUR2PIpJhOv5D7UfNoATN9m8HDFwASslzMAw0L3tu0KBPDyppmDew?=
 =?us-ascii?Q?Ivk6MBaqCpJ5kY24V9UGZqnKIVxw/8XOQK1oWPNpNuHLtb/lIGdS+yz4/iX9?=
 =?us-ascii?Q?EBcBiFJnUWWUut75w9j5UU83hhhvi4l5T0sgjhvpP1F6TCl5kkx8ut+AdS6P?=
 =?us-ascii?Q?lM72fqJzPgXpi8IyzkrYTG6ECpzbWL/6CX37OD50C0nfFOpKa209QOzdPPCV?=
 =?us-ascii?Q?ganBLT7AUY5T8fPY2EptAbooLT0qDkD+/p1oi4bCa+uAtBQVScSNuX4DRNu1?=
 =?us-ascii?Q?ubIixWaOLl+9IslK+6wXq/6uyWRFY2xUJBFUZ30bIRB1+OP1hXiW6S8cTLXt?=
 =?us-ascii?Q?n1+gdf+iQponDq9uoTwMZmDkqhj59XNIg7rRfujm0Wz73aPW3eFCrp7DD4rX?=
 =?us-ascii?Q?fQ4B5CxkI8ew0X7aEcBTQY6k+a24ZxFeoWYkluiaMCrIzquGUM5CKkKLWo8f?=
 =?us-ascii?Q?Xhyn3Frqixt9U5WBJbANqB9TijF7uQv+9pMIARrKuZRwW246QnZoFbWNNay8?=
 =?us-ascii?Q?ISsAUb57rxyPt+PshLKhvsxV93f4ESkUlwQemviDRkK7BRVLxC/O97cCJ//f?=
 =?us-ascii?Q?V1c/BAy8GYV2IAKz+nFL7F0y+LB/XuptyBKTwAAynD9ml4toMHAcsr7E4X2c?=
 =?us-ascii?Q?t1T9K9nuo7A5xKcD/sPGNfweCAg3qtumicy0LuWk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4074.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38300286-141c-4759-aaec-08da801c8ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2022 06:48:56.9906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDIZuf9nnVtik3S/n+sxVYQfSjQ67tnTU7XyQrf+Oi/V942p8qiQ+PiA+F8FawzBirnAsOx6w18n05/oMc6gDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, July 18, 2022 1:45 PM
> To: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org;
> tiwai@suse.de; broonie@kernel.org; pierre-louis.bossart@linux.intel.com;
> Liao, Bard <bard.liao@intel.com>
> Subject: Re: [PATCH 0/4] ASoC/soundwire: log actual PING status on resume
> issues
>=20
> On 14-07-22, 09:10, Bard Liao wrote:
> > we've been stuck with problems in the dual-amplifier configurations whe=
re
> > one of the two devices seems to become UNATTACHED and never regains
> sync,
> > see https://github.com/thesofproject/linux/issues/3638.
> >
> > This is a rather infrequent issue that may happen once or twice per mon=
th,
> > but still it remains a concern.
> >
> > One possibility is that the device does lose sync but somehow our
> hardware
> > detection fails to see it resync.
> >
> > This series just adds a basic read directly from the PING frames to hel=
p
> > confirm if yes/no the device regain sync.
> >
> > The change is mainly on soundwire. @Mark, Could you ack the ASoC patch
> > if it looks good to you?
>=20
> Mark,
>=20
> The series lgtm, feel free to merge thru ASoC tree with:
>=20
> Acked-By: Vinod Koul <vkoul@kernel.org>

Hi Mark/Vinod,

Both of you are acked.
Can this series be merged now?

Thanks.

>=20
> >
> > Pierre-Louis Bossart (4):
> >   soundwire: add read_ping_status helper definition in manager ops
> >   soundwire: intel/cadence: expose PING status in manager ops
> >   soundwire: add sdw_show_ping_status() helper
> >   ASoC: codecs: show PING status on resume failures
> >
> >  drivers/soundwire/bus.c            | 32 ++++++++++++++++++++++++++++++
> >  drivers/soundwire/cadence_master.c |  8 ++++++++
> >  drivers/soundwire/cadence_master.h |  2 ++
> >  drivers/soundwire/intel.c          |  1 +
> >  include/linux/soundwire/sdw.h      |  5 +++++
> >  sound/soc/codecs/max98373-sdw.c    |  2 ++
> >  sound/soc/codecs/rt1308-sdw.c      |  2 ++
> >  sound/soc/codecs/rt1316-sdw.c      |  2 ++
> >  sound/soc/codecs/rt5682-sdw.c      |  2 ++
> >  sound/soc/codecs/rt700-sdw.c       |  2 ++
> >  sound/soc/codecs/rt711-sdca-sdw.c  |  2 ++
> >  sound/soc/codecs/rt715-sdca-sdw.c  |  2 ++
> >  sound/soc/codecs/rt715-sdw.c       |  2 ++
> >  13 files changed, 64 insertions(+)
> >
> > --
> > 2.25.1
>=20
> --
> ~Vinod
