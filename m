Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282165B142A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 07:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIHFoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 01:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIHFoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 01:44:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C086BCE3;
        Wed,  7 Sep 2022 22:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662615847; x=1694151847;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0VjSKthE+AuLyNefztzQuUd+CT+vfpEUSuqP3/DlPBo=;
  b=CGKZmqIecBQS1zgLg73aL0QUKNSo5O1mzGKiibsH3wVDOKPbFUpjsUjA
   Y7nesokKQzb7miIHOsUJHORgrr8PBdAgPJYGxcq07zkQzLzVNkFiOAuvr
   eO1EcDb5zy5kWZ6EixkAvBHV7sIBpunmK4LiOQKXjDsiqXaWL9PKdT8fI
   sMXQDAcO1Qy9cFeut22bj9/J9KAmifA/4OBBqaDKjhXKmG9ZTwnDNJ233
   cIrrf/yjYXEXF6BeW1CI6BhZ9ACq+/kyDmFWsPjC4RSJzHnEgXx6jxJm6
   4EoPV25U5f1w39+Rk3rtfpjNZhUQXQE452khXKUUUDfyUgy8+sVyvSY6f
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="295808470"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="295808470"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 22:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="683097224"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 07 Sep 2022 22:44:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:44:06 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 22:44:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 22:44:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 22:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcGMEgkdbhT5i3LLLtlrYJTEbU/Dqmwyn01GJ97EDlYhgFAb+G6IoTqeU266JirZcu1Mxp570I99TZfXtMG6xdyDm/yjKW7oPMbEyldyxwhIYqq556bD5suP7WVOAcdpd9QHw9EzeaaXAVirf5tvtVX3qCRLBcR6d4c56gwxux9XhCIWXgiqLTPas1KCsyTPYAcj89uBVe84tE44DCn9ExbqDii4G7YxAUgoiogbbTs+pXS1ZEjCDgMGQCzBx1d/tFdywg/zU7RGRAIJpmWrrSy96bzk8GQlsJpSq13YVo76O61lZt5mJqL8/A1M51axcSGSjS8BiHkxU3uBMKMMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Y69Yog0s5e1ABEzgbdxGaBGyFUAFj87jusoUPmHcWU=;
 b=J4djtbl38sREFwQ9PtKlKukBqZGy29/udJWXJ/0Vm9jRXVSJq/j+MPMbsEJ3LzyixVdOy7hfGfSsED2IhY2FQNeNNE1y0FenwMYUTwTzIKJMxxjGHMjPXVQZe9hsKaSH3kuzYMwlLap+e8jswucaD6onRU/GS4frwoJdepo3hSuVmm4RAL0On/SzLpO43m3Ho1AWcXrDiP9LNY3MDZiWuqGg+k4fpQQI8ixZOO1iuFFeGdn7BBmTLmV5QC8Y6ihIJURxpTOSUsnhsKFsfOefYfhNo6mbSPY3j3dAxCOZ3K0/9BUpFkEBEjAJhqSi81fB1PEAxNFewKT5ilsOyV2f0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7032.namprd11.prod.outlook.com
 (2603:10b6:303:227::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 8 Sep
 2022 05:44:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 05:44:03 +0000
Date:   Wed, 7 Sep 2022 22:44:01 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 01/15] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <63198120f143a_58016294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-2-rrichter@amd.com>
X-ClientProxiedBy: BYAPR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d624f94c-8e3a-4606-8564-08da915d2324
X-MS-TrafficTypeDiagnostic: MW4PR11MB7032:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zL0JwPRVBMcdKJP1EX5FliLNpBcl5pQ4k+YaCNwf/l3xrdQpCpcf606RchVxHxOAcK6300Gnuf1cowpIolmHABdunrItfMKy8jBXfIniErx74eVNFYT36GmNHCLafVkaeeKe6G0Wwsq1Gd+o7eWMMoVxNSYuH15EMkA6Tdw7zpysl2r54ONO5bSsRkDE0FJp08a4Ae+LKKlHYxtYNAVARH9dQ4IWSm3LJHgOvdJ0pQxBuZNrooj+RShpeg5oNZW53ckJQakKNl4gsCd3zGlkOoWkiUBoy1wGl9T5eJZgdPDBtcCCebZRMVMs/G5wMj/FrQtwyyLZeD0vY1xgphwyUuo2EdBFVgdSWqPBMi6f12GhL9WwDWq49CwvViobxisOvnJOl4hKnoSJQGhdPg1vlentHORDRwq9mBtbbFMDM/jiJFmMqBZ6InzygvWnkronEEuZ5oe3LhdFQD+v7yrtA1Zr+/75FAFS3424t4yR65ZVD2Ln/d9hsU2vI34okwPZSew1sNOTMg2IOgWM9r1ez8KClm9zSegtxXCWsqIWM60qREfQErCPBjaiyomdvn2yMVoeiWGy/kY4UluLFjsJSESELooLZiY+golWJRHQd09KngDyWiesXy5KQ6KQibvEn+tC0mBI6xV+ad/kOjKEUcuL04XinM7Ne70r/oQCSsiyNYjvRVjDfQq3ceFrCplh9lPFlQwe2DBzj+M4PhAbPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(6486002)(6512007)(8936002)(66946007)(66556008)(66476007)(6506007)(41300700001)(86362001)(5660300002)(9686003)(478600001)(8676002)(186003)(26005)(4744005)(4326008)(2906002)(54906003)(110136005)(83380400001)(38100700002)(316002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TE/fMYyV5PN7wZq6JNleLAo4chCKa/oQmd4xsAjTPtDyPV79cQo3xhrauKmP?=
 =?us-ascii?Q?ELEu1zJg9v2IRIDE6jHSkOSipZ1UvivBIjs2KisYleyu25Ona74tOhPofsLe?=
 =?us-ascii?Q?fseRl+O7O+qTEeMcNUnwSriXpdjwfPxvOJLupJJjMCXsymoS41dUf5BqXFBX?=
 =?us-ascii?Q?+0mBZRfaVP6qLL12b/OPf1fnn1UN8GiUbqO7tKOk9uhD92SKhDH67rTg8M0z?=
 =?us-ascii?Q?x/U8jaMnWDcua6c+68wuea3mXIHECuKKDW+XkFhwaUA9sweO6stZK5+EVJSS?=
 =?us-ascii?Q?fhZ/7lNWXFkZH+l+FWZOeVENdMew/MsRBGb3UowBvZAj4aedi4Y9oj3Xmh4h?=
 =?us-ascii?Q?tPTN8f6PySmT4wFZ5U8DjNtcLUmBuUbTmrCJDw/1D1MeEGRGaF/v4wBgOQnj?=
 =?us-ascii?Q?nv2LyoTnl4mEIkEfbfiVCsnF3yTPzmwuwAdDcv3x5OEOs/g+HNKC2XHax5jQ?=
 =?us-ascii?Q?R2v2ogUjaaOinOHyUo0PZqFyjDsbjgvne74D0gr8ozrzypq0nCQT+Z+2+GR8?=
 =?us-ascii?Q?fJr8g8Owm/Ad6mQFa0/KeSihgMG/QgUl5r506vPIGkGeRUn1gEcF95t1vSy9?=
 =?us-ascii?Q?5xtDhuxmmCBwIYoG4gLtm78s51CJSAah6vzUvtivDZv6Prl3BfxgLkSsQnfe?=
 =?us-ascii?Q?CufNtDdaPAMGP7l0F94U0NwFcPoB6Y/LHREHYPdgatW7TWpCdyxwAxKgmUmq?=
 =?us-ascii?Q?tupkwhOu0H/amdscBWa03suRfp7zv0+58bVAlOMZ73dCQvutoPRl3zQckp2u?=
 =?us-ascii?Q?lVJnUg/iRLt3UpLYq/Cm4e4m4KStcrkDFDdFqVZQ4ZX6tM/d42VENo+EJcqF?=
 =?us-ascii?Q?uokHZW5mSeEZLN+iqi9XHach8KeRSp9RfpZUgtpNjjHfThUvunqyJ8a6LLJL?=
 =?us-ascii?Q?wdPGLF3co/HszhBWbLWW/ZwZb9/xs3wA7pUHKTKi0La2Rg0cGa26UtIIMxcO?=
 =?us-ascii?Q?qcKlt0R1y4c5okaEZjFT/6iqnFrOAuR4ssGe57c9Niui4oFDPoywC+U+D+BZ?=
 =?us-ascii?Q?87BOTEiKfNBjf0q2jpa07wfUWfU8sv68N21xMxfWcPNIuC/O8ppsIbw1TxjA?=
 =?us-ascii?Q?hnDrzsnE7S2UMjmnYxHlRWIrxUB9y1m90KKE4kVS4rNab3aWdS9Wm/gY0waj?=
 =?us-ascii?Q?1BVXAHXMihC08oFjYBrwBQT0dy7eH2zRZDPWMutVUEleOvhmgutTTXWKmGfk?=
 =?us-ascii?Q?7SHpujQU+EkOv89IAdJvZtP2G6+fCH7YPKKZa8E01wKdfcrDZBaYHP9e1g3H?=
 =?us-ascii?Q?bZN3QpHnUutyegMQ/67/7oWFrjkh+kyZL572PkMXMWP0xolb0UqkNLcTobwA?=
 =?us-ascii?Q?Ri+tgJR55JUeg0lxdRoE0SYWF6AJjl0VEtpSVZoPLCjVf6bB6VUsjTGnobdD?=
 =?us-ascii?Q?MnrEdRk5XY/a17DhYDP4hZDal+c6QwzTsPUNuUIW1p9jcryeTGL2KKxcebrX?=
 =?us-ascii?Q?UZ0T4PteRxKOsJ9hkvDjiqKqsua/CXb7mVbo3YkBYzsRf2NfVbYFX1Fmu/jw?=
 =?us-ascii?Q?zQX5qtMTwnBEBLAtcQ7p0ET38JTnvguAkTL/A6/Fidu8AzvLeGv5AIwKrdMC?=
 =?us-ascii?Q?/M3LBihVVjSsW5+pI4rh1hZyoK5OmAkLwH+t8/gO98/rdK8uIBdEjlizFHP0?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d624f94c-8e3a-4606-8564-08da915d2324
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 05:44:03.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWlwqt3j+Ozjp2SVJ0KqhR7u25DqY6P88D/dn/aO22xxgRsH0dBDY4ziBa/ThZM3qFW8zSEthMLJjDSd1UOhWeP3nhQpZh3YwnExsSODGyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
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

Robert Richter wrote:
> The function devm_cxl_iomap_block() is only used in the core
> code. There are two declarations in header files of it, in
> drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> declaration in drivers/cxl/cxl.h.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
