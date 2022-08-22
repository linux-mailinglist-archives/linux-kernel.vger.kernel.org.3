Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECB59C513
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbiHVRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbiHVRey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:34:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04872ED7C;
        Mon, 22 Aug 2022 10:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661189693; x=1692725693;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7xx4Oat/LuIo278szEak+SbMam+HPKl00DIYjDgVi3A=;
  b=GyGmy72L9TCgu0iuWb3fRdHLhysDC2T9U4dr8k7+mhKAoHjFmv6WnDkR
   gK5E3Da0xH3BlgOROPdJDyXwpz6dApGnOBd92lg5vtLzp3ebE3fJElDyq
   PhqYqhc0UrdzL4GkYnoD3mOjdBE2xhcBTgN3fK1uP/PilSRIWpa3pcRDl
   Ln1xM8K3Gh9aheI5XfcMgUlhO+1epVtwrKGi9ycOfkzkhTDzRXKHasp9Q
   pUbOjACAJQZiMIEkHwprYWt/eH6WyhJ8RE8ySl9H+O3Ftc2NZasp1L4Sg
   2/VCVo4nDietqeF8jQm+cHTSkuGKI8oivCpXnyRBxS53RVUyIsOfl6gqE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357459539"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="357459539"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 10:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="669644352"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2022 10:34:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 10:34:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 10:34:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 10:34:51 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 10:34:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5vL+BtJH7vxLt5v0wmG0ADX7LetvHcqaaa2qiezWz/9pucFshDMUjNH0s/fomLEZ4F1iZsJB5BaXloDdZEVerexzssAsd4lfTxKkaKCDO4YMRvUT0gUfipCPlXw5PcedLNYukVV6upVDcKvuzY6qX60uLD2p0FMIVV6DJFY6QP9MWNTd8ZxiZgWvpNKCj6n/DTOpL8TFj5DzMbapcaYVkw2IStFLsmkNGzEddEOVkVzu4CNeQJaCVP/xhAYhie1yMCJJfhepDf8Ah2KrtFkRDVjXgwTlzL51YkFNWOEiVSweq9Idg2vub0X767rj5JXUz1jbvH8ZcrB+edR+KU/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xx4Oat/LuIo278szEak+SbMam+HPKl00DIYjDgVi3A=;
 b=DeFOhDVu+6ulO/yXkhNJQchbORFHjuUNokQQ23fS0FT5Tiqi6ljPO4I8yBHk9xaPQfYCU0yXNrOIFZWrLOAGWT4nB/qGbP7yIG2HkXjdXhNg2cmy8zp0LPVlO3Cg7trkTaFHRfYbMIDwdiEGJ51VzJstWeHGPM8rdgzExwXvZrdRGRhfBT1l0LYuz+N3YMhXnShEzT8n89NdgR87A5jrmO+z+QRiKUion2IDk+mIZrftzFj+0l1UUcNKTgnHkJPYug/VfvRz0rjR9xr8rYiIK+kL11cpPy0NkHitqusdXBrVxEnYVFCIVsIQQXQudVCHIS26unPMfugGP7RmV80omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB2959.namprd11.prod.outlook.com
 (2603:10b6:805:db::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 17:34:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 17:34:49 +0000
Date:   Mon, 22 Aug 2022 10:34:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Adam Manzanares <a.manzanares@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "widawsk@kernel.org" <widawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: RE: [PATCH] cxl: Replace HDM decoder granularity magic numbers
Message-ID: <6303be366cd5b_1b3229487@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20220822170552uscas1p1b1ee530bf38a14806010d65d1b593ab0@uscas1p1.samsung.com>
 <20220822170510.125082-1-a.manzanares@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220822170510.125082-1-a.manzanares@samsung.com>
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efe0c19d-6968-46e9-e1cc-08da84649d19
X-MS-TrafficTypeDiagnostic: SN6PR11MB2959:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nl65mGDEdhe8HYkX24AWUnODFImc87rWShU8kPJh10/9TIEV6uVq1uxdzK/MEff1L8SH+aRYQtxLSUN1wggpQ/zVLHEFySdQ3jFcL8/HjzrWcOTXTh3rkD8NPaXmiFVq31UBLz33h5TOvOivh+OPVdy3qZwL6/9mGWPHO+RTz6yenD+RHTyQg1j+mMC9hcPf3MRkAPoVwwhQJyidxp2dP7hmOEanM07uHXpqRbNXtNxkKG5pWogZMogRYhAP27giZE9CvJ+OYDjYqKB+CB7HnNQcPi6GIonXmbYqqQOF6YNqRGdhXKFcMHe6xFBWq18lCXZ70shqLU8ySFTXdUIiBlDLrM1JL1pnwyKWiZM91ZrmvxWtRjvUwnWlGakKTjs6Tvb01VWoqPwHvOyn9YITWFoCZJ01fR1lne7Sebqu4Ui5ryDtw1BT8AI+Ew4ZAShaqnYYbpg4DoM7YfsqHL4gNTTVrSDbzoXbuXNLh9GzGHLgU3ALlLULJhdUIhN/HUx7OT+N+lfC2VErBruQqqp6XGTjyNg8jH03VVx6ok6rPVP+UXB8EmGBG/MxSGF4QPMo6ZW+QAgK69957JYkiEn/UZOUO2xvWT0R7JdKoAyqcxJoMwQ0viULrHvAyeUIKXuZCkZg4VLeQAyEd56LDG59y3UyUOHNC19a500aVTGeuLV4Hhs9Ycbvy0an9bQBYsixE8+4ZWPEvsInkhlV/diKvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(136003)(346002)(376002)(396003)(83380400001)(2906002)(4744005)(8936002)(4326008)(66476007)(66556008)(8676002)(66946007)(5660300002)(9686003)(6512007)(6506007)(41300700001)(26005)(6666004)(186003)(6486002)(478600001)(82960400001)(86362001)(316002)(110136005)(54906003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ir2+PaouHALk9cBXb0Af6G2sOElWpl9FlcIojQzj7UbSTxZ5PngG3rutz5pJ?=
 =?us-ascii?Q?HSKsrph9YQvieO4HOIOCHQum4DEFg7Of6oHgB24D2GHBzvNsr8+VeszOh+33?=
 =?us-ascii?Q?PXrd2ZRLPT+Qyi0WJgSUBj+dKKg23LOxE1aRlz+80+38c5EfZezYiFTz84sa?=
 =?us-ascii?Q?Qd+ArVspB/+oz78IyC7aZ6CHOEqqs4/itDaSy1el7O5QJ6LWOLmufEPht3hJ?=
 =?us-ascii?Q?g3ZwfMhOZxLj+Phazbpsu1AN87wmEt2g7G1D2XElUmcpNL2RMJpNpjxfoSgq?=
 =?us-ascii?Q?aMkGzXx3trANHOJC2RkMdqVJZOAGQdEWALpR4WdTAC7IxUPz0xHmYFrQ0B2g?=
 =?us-ascii?Q?boOEzS9dh/sV4v9/IXClo/mv4D3KhBq21f6kxh9+OLFl/1hqjTLZQvPtKnW4?=
 =?us-ascii?Q?mL7tzOGNB50HJ1IL6u0SM80tPExI7LR916AW2RlmIaEscWCbMMRyptkdT+yw?=
 =?us-ascii?Q?8PD+5Z3ZsaLlDOa4RTmpd9DE/ibZtpqGFMdkiriQvuoIgVhQ08Ri+MI4Ow68?=
 =?us-ascii?Q?JN5bjEbPh/hLhgBLGAEe/zyJmx4l81XpJU8S5PFXUnbEAAIBtYrYOVQERSWs?=
 =?us-ascii?Q?ImfKM8TZNY+n0fVTVVKozVVp6rkRi4Ms94LzK2lI3xqdn4QcCzxHPheXU6O5?=
 =?us-ascii?Q?VVcW9U6cBEhEyGVFSDgOCJZf3dGNs7mL7Y98gkZAJtN2pryAxg2DbxGazWNw?=
 =?us-ascii?Q?cSRXJ+I1DQRu7oyIN+sSGt3+RQ+LPYnHF+KgJdjD1EdaUtU94fVNbWKAimDi?=
 =?us-ascii?Q?TQSgIIIJRsr9pPm8hrf4MI6oJiBnpUWaRky0VAfshK8nwNmfGQxu5FyBveG8?=
 =?us-ascii?Q?2ez1vNlLTfSCw37n3OJKlZPSZJj7j8uy0vJYZULJL+T3plEYiANyt6wx6Wre?=
 =?us-ascii?Q?lvxMxnBO4HgzkGAdZe/AgPQ2fFBWBwNvwWBj89o7V91FaTAIoRb3OoDbeAZr?=
 =?us-ascii?Q?W7w0mFRS8UFax3kKs2Rk8atvut8cy9y5WTfIKCFoEHsEiUOpSSVGb4wUZ2My?=
 =?us-ascii?Q?DoNA744s/xHeF1Y9vdZFZ10X73GS5IE7mZCBdeBQ46/fnXfeIasBjx123ZUW?=
 =?us-ascii?Q?xYGOvrNrH/CWiD7z4ziyvKjXCP93eOYbKCPRYksZi60fPbvkcF5rqcQACfyj?=
 =?us-ascii?Q?fK8VJX244N/mGTwAkD2TBjLk+OxK9OqGC1NJYyKDtD+rohxZC+fEwcuc7DX/?=
 =?us-ascii?Q?Ax6JXD0bGYZyt/HP5KXs/sx4ySGUTGiMfOSBHg/Yb69PIIYr7tcyy3Nk4bFC?=
 =?us-ascii?Q?U1ExY2m/bLnND271JP0XuDUuJaonuwl6raceKm8yHhwdsZH425s4Ba3Isboy?=
 =?us-ascii?Q?P3o8PD32/4JiUoPYDysWF3gCNwqOtQAJrhXanjF0smWgcnS8x2LAueeQsMta?=
 =?us-ascii?Q?CbJBB+1hjM5YbbNV4by7I70nto3ja2zYVyx0czGcVpw6+5RkaNaQlHpstZ9g?=
 =?us-ascii?Q?r0CYJ84Cwfii9fZurtmrU954C/PaHxPjeDp1Yrm0ztxKjNbt/9GdjDafRxua?=
 =?us-ascii?Q?0ygLxEwrErnRfEGUHDSEkenYfsewpZhFUiOMr8ByAqIvYlkzNiT3TuIGlKeW?=
 =?us-ascii?Q?gONNUB0JFAMOURFiHD56PNz+v4mZIyYky59P7DIhZ1+0DMPvZ8TvJINndQ6S?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: efe0c19d-6968-46e9-e1cc-08da84649d19
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 17:34:49.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1YBLUjwE3Y3WW15f2mfNQ2fS6nzM5y3woJaO3rbbqmZ9oxzQlOKaCccwRM6pSu3u4N6XNvbRZC2+qzkZcYyQ+7TEwKDq4hxAsLxWnzyrPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2959
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

Adam Manzanares wrote:
> When reviewing the CFMWS parsing code that deals with the HDM decoders,
> I noticed a couple of magic numbers. This commit replaces these magic numbers
> with constants defined by the CXL 2.0 specification.

I have a small quibble with CXL_DECODER_MAX_GRANULARITY_ORDER. How about
CXL_DECODER_MAX_ENCODED_IG? Because the value is not the 'power of 2
order' it's the 'power of 2 order - 8'.
