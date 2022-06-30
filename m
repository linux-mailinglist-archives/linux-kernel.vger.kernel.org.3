Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D91561509
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiF3I3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiF3I33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:29:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD962DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656577768; x=1688113768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DfM1tgxYBdRLGAY9dRjjjCPU5hStb1EFvId534m1BSM=;
  b=IYecYkM9jVaH9uaCzkEVnbkh8HKyof7uCQM+aQnkGDixjYBWp+D5Rjlz
   1LhXzZNbGTPbsVem5iNPSkCIb8i7zI5ISD/XIdsIT36nTZU1CvGWjdvP7
   aDyqNebMrugFfUIvx60+3sbidyZPOpJLTdvPf3qRZpi2PzW5DWohco48v
   lMCyr50+nv9WtFF38xBxiGD/HVLwE2rE9836Lf7n1HF+jOlmOWUIxdwgE
   eS13JribT1AYFSXViEG6xdWXASx1falNUb/R6z4qCZMN/2DDZZPVn5g+X
   VYrGYO/k7PxNDWnMAtXvVz8PnT4/v7dKQxQmAyE2KQ3ky5CxBTWmuWG6Z
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="346275842"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="346275842"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 01:29:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="837513022"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 01:29:27 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 01:29:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 01:29:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 01:29:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgLqAApNproSjYXXnzm6PeEDuK2fdQPEMP74dMI54oOnfAwdy+WIb/ZVJ67blFyb/DYj6brBiWSOoAQmqpNbsdDy0PfgUHCsCKoFu3QXkO/eOfgV5zK1idU2gb98jiPd6FlvanerN8NoTUv+MIBpfCG6lWc1PF15n87EPRDi3k7tM8HC6inVesQLHqnHKWHm7m3v58BbrOVQdrnxQ98kv5/4Lc8z+IIJcO/+1vSJwzhuB/+sqvlVRLat0aTwCGaSABSycAIP1o4MeeoaqeZTIeym/m7dMhzleJUsyOrH2Slypb9+FQLWXTxAMQiRkXqkAmjfTtEHlC1QbjwIFrqFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DfM1tgxYBdRLGAY9dRjjjCPU5hStb1EFvId534m1BSM=;
 b=jaHVzDVcT+WEEbNcQmYksRkzJ/ixgZSn2EyWfzbblBpTlabMBv5bTZLoEBNdv7JFBp8Ov8thaIg70GId99urKsa9AsagU2QnkzNOqprBM/vukH95vKnRwi5pbZZHku3MRGclK9NZntUJl4ZmQ94/7Xk79P8FNPTfA3c+4P40QtgzPPqKUSe+k+f+aAPRYu9fiGSehDcRPoL4y2LQPOT1Bg4bB809pKGgtO1Liz/G6aS9yhRcoeXFIpDgz+wVCzpXZI9kA+xu8PEZDv9XOpzVn0Qekd76yWouMNMD+zrfBb/HMtbtzdyVkhNzhE+tFwq8y5+evS7bLXM4m/IIO/MhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3413.namprd11.prod.outlook.com (2603:10b6:a03:8c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 08:29:24 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.025; Thu, 30 Jun 2022
 08:29:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>
CC:     David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Thread-Topic: [PATCH v1 4/6] iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
Thread-Index: AQHYiJMJkSfp+Ms7gkCsHugg52JWua1npWyg
Date:   Thu, 30 Jun 2022 08:29:24 +0000
Message-ID: <BN9PR11MB5276F90888CE86824251E5FC8CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-5-baolu.lu@linux.intel.com>
In-Reply-To: <20220625125204.2199437-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58d513d9-4604-4783-82c2-08da5a72a3b1
x-ms-traffictypediagnostic: BYAPR11MB3413:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BQ3YaFYCe+V3Hhiym860VXzReYxZeRSL2CeJ3QtAdvTVcV5T8vB5aQ8xbwCtdNoBxheKWX+UUume49Z4tq2fgNDGLymF8cumCl4tQtCe6IadyCcRZD765pAlhSgXgIl9kv9sY8AM9T0lvQvM289d4O1HS73ylxBHpwdAFZ8nBOaZ26aACrWeI1bDloKdK+UOoXH/oE/7i7mvh2rvOJ/aZvXhIMSb29xS3iMH62B2jHU6kTnlAlxqYgseNui74OZOwzbd6F5mJOuo4o9u3c3Nz1wBgMgUzwg30bILoh4QJ6pGvUTQNi00AWJ+w1jS7/9v3JDzgB2/DDtj7g5Wf6xzjYayer10HiAP0nkIN42BDQgSKNh5MEaGnexl+Vk9S16/qbQ8PHTShxyv7rhlG6qe+18auU3M6tb9XCFPShdVknHEssmNasykBOb+0OCHuO/n1ffGmeYVXc0cXgUwSVZ8iIBnff1L+6EBjzP8aMoAc/9INyxBXJ61HEefa0ZUAMdZpbuRrBWKt7gV2mN0NZ/tQG0LclT5dn+Uqw+E+cBPksFVj/HYT2DxWYC0uyILUwZt0hCfbyvpFacZmiWkaVIwtaFUrphcN18PE+SbPyy4qjiacu0q4FoQmqQjny+U9j7gLQA0h9hSfNk+1XAenYlWQBftZLqs/BbAsFilvFw5WXYt3as9Kg7ruSh8e1dJaXmRZ82NWOutBaikav3/t2dnlrU+GsRd4xatggjBcCgVvPdic9wSFvaDAg2xlXq3RjxB5YLS2okE9TsVsP2JpNxMy5YY3LZsg7r0rxuKqhlSP/UkjcBK4OV0d7vA2b79S/Q2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(396003)(136003)(366004)(7696005)(33656002)(7416002)(2906002)(5660300002)(4744005)(55016003)(52536014)(54906003)(38070700005)(186003)(64756008)(122000001)(66446008)(8676002)(66946007)(8936002)(26005)(66476007)(38100700002)(9686003)(76116006)(41300700001)(316002)(6506007)(86362001)(110136005)(71200400001)(4326008)(82960400001)(66556008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?okOScv2GfZtPnk2x1PwCBYDxT4K9Wlw7CrL+2vukaNCfQyEfO7mQVCW78+WE?=
 =?us-ascii?Q?Qq8kGRKOQLuZDD9HM1dh/wwtOnLV2prUV+sv48ujNegNyXjShNavQs7csRm2?=
 =?us-ascii?Q?GR3RA+AOeIvuNCDBoYtEsnNMNvHPZ+BWSPSMkfU4yOQqOU/c9Ll9Olxj6XPq?=
 =?us-ascii?Q?tkK9ldRIAQpilNAIWj0jiVOervcA4bqyMCrCW/+GYfJDeIpAgFXu1p/FC1Md?=
 =?us-ascii?Q?eTOenT4aBwvNipVcq0f1kwhEw4SfjAUxJ/+kG5pWhfgqEyrkhz/+eLjod4DU?=
 =?us-ascii?Q?rsfneHsRCzbBMOHJ5WQD+LEdoUJkBD8grzf+MoyOIIXMryq/O9hAzioHzn2Y?=
 =?us-ascii?Q?hTPeDa7m1BXwujsXVqfJfYtcUylfB6kKntt2qynC3hAWwT2nRyAvFVzeCe1S?=
 =?us-ascii?Q?gjzTWZyDl9uRt96s2D6aleU98wdJY/iv5EkKybon8ndAu/Zx0beJ6wkyjwWC?=
 =?us-ascii?Q?82A8deEvBdRuFS5hJgSeGwh3htoK8EEz9bvawQUpN620N4RF1EGsRHiOulzM?=
 =?us-ascii?Q?xSRW/nsH+e6YKjjRTxuwLHm4sjsP3GyB0Uz7rPTuuW4zIeiZ79yYuZn9BHgu?=
 =?us-ascii?Q?QNg5HsweQRnmMoenIRY5ZZaoqFdL3Argtt3vY3R294B2kNL60yuVJByR55VZ?=
 =?us-ascii?Q?m4mAUnilAvYCY1LJmVlfOw+Rq4k4cUVr2JvO4h4YZcwKWdqUAH2WOKdcF1X9?=
 =?us-ascii?Q?0xyQXm0V3C21OIkb7NiYu6PQPJZe6iElN6inXanFkHaDfGjDZvBTPUyEpVFe?=
 =?us-ascii?Q?VHk5Mp6ZjAjDjEmClXOVUDxK85VI0gD+YZdOdS7ltcD1BMrV3C8GS+7pwTVd?=
 =?us-ascii?Q?8l5dipQ1PlI+6uCvMCIhF0datkRVNskC64sufX3+FBf3K51P5cYTqVpucN9x?=
 =?us-ascii?Q?Erg3wRR2Rwqp0E9rbXL/Ukkbz1TGhoKT2745QFYtPkKaY+JMoflA/m54CnVj?=
 =?us-ascii?Q?fvKjCi/MYqBSjhaU5Xrw9bUD7QhbnvjGqbgBpeGppYgGffS+aogTC6Q8sphE?=
 =?us-ascii?Q?daQy5+A+fgdvTaEYbJ4FKjznD3wUE89HINQqcArCh0CBA0jFHWGagGoHlCqj?=
 =?us-ascii?Q?K0IyUxXTRD5EEKdwnLpPptovLxGr8ACdApDVbXqp+6t9V22NF6dWIrKImIQn?=
 =?us-ascii?Q?OaKKVs6iC6LeRzPzrQHrEBVN7DBAYusoyRzkZNSUSD4Uu1SCu+ch/NKSbCFR?=
 =?us-ascii?Q?2+ryL5IK5oAngtxNztN6FF7wq0rx6ZdbMrdK56FxBGF8J3mIRfs3kOZL0VzB?=
 =?us-ascii?Q?0ozb9JMZ3atCH38TKhjcCbVtvgV7GmoFUWTqMYbB76v8ad6FeLtMa5wyRUbK?=
 =?us-ascii?Q?xGzxOwfkjsByE0IgZEWeGvUApodux7EWAgf6Wom5S1Wd1q+VEpmENDVJECqH?=
 =?us-ascii?Q?cxWDGDwCGq+MP0q+H30G7meE4bXHHed3HAi8NmX3IXkTwSGMD7xbVre5htyS?=
 =?us-ascii?Q?r3VMv+26YAs0POxutqvuo+xOu03iYPLK2sxZKFsmi3gkgcUHukw826rKf6Jg?=
 =?us-ascii?Q?mNHFVNY5oynYyqRrxCsX3ecuFY9KXlxgoD4FPFD9qVe4ogrYJPklVysny/T5?=
 =?us-ascii?Q?ElNzALZXMP/a0liSTbivgI3ukIn2JKAL2zWXHkWe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d513d9-4604-4783-82c2-08da5a72a3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 08:29:24.5125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROM0VUNnYH+fLympc9ZX6c/QIQoqA21cnItFHf/7u0tnan2hhH12EiIWQbdWl1jCPEF4mbfBoDguLPQRVliAcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, June 25, 2022 8:52 PM
>=20
> In the IOMMU hot-add path, there's a need to check whether an IOMMU
> has been probed. Instead of checking the IOMMU pointer in the global
> list, it's better to allocate a flag bit in iommu->flags for this
> purpose.

Sorry I didn't get the point of original check. This is the hotplug path
hence the caller of this function should already figure out it's a new
iommu before reaching this point?

