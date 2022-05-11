Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4FD523118
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiEKLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiEKLFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:05:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8102969CDC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652267131; x=1683803131;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LPv4CLVpqU2aUFvcfABSI3VgCT1jLwDQ+6qYhPnkpOc=;
  b=Mda2+2H9QphwWe/zsMzaG7PksmYOccS5GNQMCxw2nIy0w7PEsccv4azq
   /oAj6u/lMiJss+gjkiHOc3geCOvDAJk64Wq2C94aK7GMg8H9SsdmprMvB
   UURXgpRr8/s6dWoV8suKiB1FJirxo1bhx7KImvsJ+1Z5hFGmeITbe81op
   0/xRT+HOgdXwt6aYi1FhQToLCUbVpd1uea1O8YQzEQAe2la6boydFWXVN
   u32z+DAsNUHuWwA0r7hjO2j8OK/uv9kbspghIrQDnHZcrLKs8jjaVH65d
   l+ylE02+P2a/IyPRCwxSfPw+QP9f1kxgnYCIPQ7HkbKXsAwhV3Fl329ze
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269601953"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269601953"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 04:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="602898445"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2022 04:05:22 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 11 May 2022 04:05:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 11 May 2022 04:05:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 11 May 2022 04:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCZ089ogeGL5hpUeuoWdsIspVALzfnDWyVKI3lImFZ07P5MfX1/WDwU2/CCM3zuulM4OHRp0BnVzyOsQ4Nn2R4KSjdGh2WxeXPIcegqoPwRxy/LeVS9TSWnK6xigb8gPoULUnCzxUZfXS3fCdSXcbMZfad2srbwVJoiJr5B5ah5G4YoziFoqD65J1omj9G22vnI8t74xBMKk0GldDHm057cKO8gY14K5ZzRvhAUHCwDOGx8yMj71LQa1TJzPvbkRaBp5EcKfJbp1nz1IKioVpIihOAX0/MPPp3ufgxOxU7/jmZ4ShO5ZlDpCDf9Q7W7Lws+JTYyIisvR4Kk0OJBHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd8DHDGjN2BlwzzcMPxDL93Mv7rajCFEba11hcBYhDo=;
 b=PSYibhUTs7K0N2skeQLh4aWaSEY8m0nVkF71uhAYsrXl4n47dQueo6pHnUsNujEJXeSjgrQ0z3ISsLZWCuJCVAp41I/srbHq4sO1w1oh4h5ouZpOVhgkNXjAzfPbAYND1G/MW3NpE69CTkia6olkFHBI6jbyIVKDJzl6Azk/Yvlts69wmI0hpaVbbe61abVvNUkkS05tmkr4drv1f/Ln3EOTBn2KCg/UeQFMN91b7bJfkp8bsgCfBqskzG2OwgAl0GVPpO/gLtxKXpPX/KO03RxZibmnwpOh3vPu3ftDO79CrXrzWj9j7v2+HVJGdXuSlYYyX1wrvAFeW4A3JFtbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by SN6PR11MB3024.namprd11.prod.outlook.com (2603:10b6:805:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Wed, 11 May
 2022 11:05:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::90eb:f194:6b40:c4ff%5]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 11:05:17 +0000
Date:   Wed, 11 May 2022 19:04:55 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        "kernel test robot" <oliver.sang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [mm/page_alloc] f26b3fa046: netperf.Throughput_Mbps -18.0%
 regression
Message-ID: <YnuYV3J2ljY88DyQ@ziqianlu-desk1>
References: <YnURx04+hE0sQ3v3@ziqianlu-desk1>
 <7d20a9543f69523cfda280e3f5ab17d68db037ab.camel@intel.com>
 <YnXnLuYjmEWdVyBP@ziqianlu-desk1>
 <ae763d63e50d14650c5762103d113934412bef57.camel@intel.com>
 <ba83270a-4f37-7d5a-b37a-0b7a6df5f5b4@intel.com>
 <d13688d1483e9d87ec477292893f2916832b3bdc.camel@intel.com>
 <c11ae803-cea7-8b7f-9992-2f640c90f104@intel.com>
 <37dac785a08e3a341bf05d9ee35f19718ce83d26.camel@intel.com>
 <CAHk-=wjguW5nxjagV99GHvc_-E_7mSg+LMvGtFjJ9LUSx4Skig@mail.gmail.com>
 <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41c08a5371957acac5310a2e608b2e42bd231558.camel@intel.com>
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e250ee4b-0486-465b-5238-08da333e2158
X-MS-TrafficTypeDiagnostic: SN6PR11MB3024:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB302429671754D4DAFE8A815C8BC89@SN6PR11MB3024.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vfbZgTLPLyHTRT6+eDTwLRduI+OtS6j7ArGh/4cPWWsFjA1zr4i+bhhKynF5auoQ+4JTYF2ercc1tb97b9Q3L6NLuvu48my4Jrlpept87cUy/fpUoGdvhHlTWWgp+m2MFvD8zs8NELVwQnm+MunrcNyP1bDT1ueiiEZjbzLVcdC5+Q0Esupxkv0SYUwNrjk4kWKqW48eMJG4IVFcn+WRe9uX+NMBG0BzxmbKTupiksy6ffO8+eZ8B9c79DP+qlxzQYVSXcgdbsjGepqRQgg8fbB5kfS5hDRGo6/5rGELxFjObjK660qop1bxLZa/uC795BWnkGYx0GWmjfMAQz7pAT7qDEAsyHG4N25lf4+UBz0zXanRi6VtjWJ1fNGi+QBFrvCVpArvcnmkrDRSW6U9/xwzJ2wi+xEVe+Cvo5Y61VN0eiV3hY75qX9WFX7Iz9Q/5xMMaA2cvQlB5Bffgs6nSkwgQuRyFCOkNdz6DCee2LZPv1w75NeCugMOKghDgol9h3a4kdrZ9eW2hiENVL7BJV7++f27r1YOEav1IiblWt/JeaDmkwURFRYNaPCPxNUJUkxcrA+cNbB1/268zSB4IKHVTIE7iNgF2EML9XriEFChN00lwq2288o739VPJfYJq/3PoL0ydW4E/wbfDpLu8KVFAbQ5H8/YgRGsL7pjoDPes6qSADHbERazxMvnKwn0iSLYbUp61CIzdOJ5ISfS8MuDkHx2qQu6zuTX5RWt/z4ritpyMXBIwvByX3i7QUJnnEvatfwDEmrjC0fL6Q7wHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(6666004)(86362001)(53546011)(8936002)(33716001)(38100700002)(66946007)(19627235002)(66556008)(66476007)(54906003)(316002)(6636002)(8676002)(4326008)(6862004)(2906002)(508600001)(83380400001)(82960400001)(966005)(6486002)(44832011)(5660300002)(30864003)(7416002)(9686003)(6512007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ufO4M4OlMl2nvCoE6U5Ea7mgPnhpRguJwqq3t8/NNVK5gyPt76929AIpF9?=
 =?iso-8859-1?Q?158JX6W0kPJ1LrNL0z+hNHjsHecxNMZq1pRio/KdF5+xJFKwprldclesH9?=
 =?iso-8859-1?Q?MEPrzLs+IC6WxxQFOo7I9S+f8reS/R1+/U3VZVyk0XXe9yTyU/qCYkWxxt?=
 =?iso-8859-1?Q?uLEaWghY9A/Dz/XbP3V3tC+Gzh3crmLXPs53C4phXeF+HHppwHH/smvypU?=
 =?iso-8859-1?Q?GqNZTAz/k10OsImnMDEHxlpl1vwqtNBGKuXty27nUjhLzDpUoKe/WG8XwZ?=
 =?iso-8859-1?Q?rT3BKxJgVbr1UJLVfvMDkvoM6vjPif+9bOpOPw2avLI/SK3Hdgdh7bpgjA?=
 =?iso-8859-1?Q?W2U1oBE1p6FUgqI88bKpa6OA1mr9Bz+6m8um96RBTTlnI/prZ5sCc20aaV?=
 =?iso-8859-1?Q?2I2QFG5GJYz76eoyLQZq8Gttj9bU+ybojmzUPrgIqM/pI/SWQDd+oBZ3Iv?=
 =?iso-8859-1?Q?bASXrIAI2zXU7/nBwfzPKdJpzhv7inPQY/rhQI/uuJv5eqrsle6qCbV3hp?=
 =?iso-8859-1?Q?WFifES3L+AJgO18svV1yp2pJ8/+cDuLi0l4ZMuMzlMF9o9TR8DJdyDFuEp?=
 =?iso-8859-1?Q?i06zyE7WR4QDUQWDTVhdWeCyq63bWmimrba2Xkix3PIgN3fX9IL5q40ZBa?=
 =?iso-8859-1?Q?WGTAB72qtJcdActoqXu7Afe2RfYoDoptVa91R8kb8DogsgHod1JkegQ0EZ?=
 =?iso-8859-1?Q?KoiVwQjr+hiV36i2lWvaDSXOQ3uOZnukdmc5Uo66O18Rk+ess6zfZi0wtP?=
 =?iso-8859-1?Q?aR8zWG7CO4VipTSrQViTzza+fv1G9Va2Ua13dTIH9dnbp3EJuDYjM1UB2c?=
 =?iso-8859-1?Q?5NA2LKtAHudzrNPJYxXCsndN0IfzMdx4RB/SCJdC3uxX7okUUNgRurbx09?=
 =?iso-8859-1?Q?jjqVdsFlUGDlTtzOW9Cv+xrLJwcEDsmaHRlzhKHoThAC4dy8YIuowlg5C/?=
 =?iso-8859-1?Q?4GP+Rh8n/dvGG93uOwwMyQY93ifdWSGA4WrB8I4IT6CBpU1dUnNZm5w69s?=
 =?iso-8859-1?Q?09dq9G9b/cRWOrqmyomhKEGFR7iVCQAoVrf9JVQFwAA14L11TEU3PK9GBZ?=
 =?iso-8859-1?Q?KBCrkrvEervEJYZq+KKjfFK1ylkf1bxYtMpe69pX//8hocwxpvklREfVfS?=
 =?iso-8859-1?Q?DycO5QGJRdlzpUYTwxuJDXniaPtkngAfQLfr0PjZ/bSx4BYs7QYqueCKuQ?=
 =?iso-8859-1?Q?avAZIOhh9KNx8F72Fb1zN61V4zd0h9o5q4ep91K41BCIoVtHgPKnzC1kRE?=
 =?iso-8859-1?Q?lHLv61zGBwgBs2VNbR1P2L7lftSBtctEOH2g6Phz7Chmc787T7bknSbZoe?=
 =?iso-8859-1?Q?Q8HOQeKLFOzIG4y42Z2l1V6eBc/wGI969LOpE8ICALOUWLEHUKTI/0n54E?=
 =?iso-8859-1?Q?u+UHv05lz6YQyA20nOGqQYtzfhZ1LVo4kksy/OQyN0u6EEewvCokMbWkmf?=
 =?iso-8859-1?Q?zvfv6qI3fBlnMJwDCCQ1QCJi2PezCqIaFZJtaax7ushXIFowwE2XydUx7N?=
 =?iso-8859-1?Q?ijWQ8EsRQrkDIP8U95a8NRJEA/bG/zAXCEuAklcztBK78pkRTYzOFanttG?=
 =?iso-8859-1?Q?joN9gcZcWAyUeHikHGJVsMVlhfEYx8nugh1uUjH7URr2q44xM0Ytf1VDWP?=
 =?iso-8859-1?Q?XWFk9xFS3b4+V87okq3s9lRZzsARMUSzB0DaeXBkAoJ3LdOYFizWYQiRFX?=
 =?iso-8859-1?Q?1Qq+2EMwa7H6/p/cTZMLCNvfetw445W0cyZoTku5hnTGHaH1Z362VtIzBp?=
 =?iso-8859-1?Q?B3sut+oHFVSUhmuI8SrXz61Z9YXNOwn5vI2wewwasOz08y1RYWWqQL5Vhy?=
 =?iso-8859-1?Q?IaqyRIbIOQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e250ee4b-0486-465b-5238-08da333e2158
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 11:05:17.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YhQaO8XRUYFH4cdzCxX0o65ej8tblRGzmejcSCJYSBg3qOd76UmLZCVO9ugzll/OFcC8CXZz/dy4s1z27pIlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 09:58:23AM +0800, ying.huang@intel.com wrote:
> On Tue, 2022-05-10 at 11:05 -0700, Linus Torvalds wrote:
> > [ Adding locking people in case they have any input ]
> > 
> > On Mon, May 9, 2022 at 11:23 PM ying.huang@intel.com
> > <ying.huang@intel.com> wrote:
> > > 
> > > > 
> > > > Can you point me to the regression report? I would like to take a look,
> > > > thanks.
> > > 
> > > https://lore.kernel.org/all/1425108604.10337.84.camel@linux.intel.com/
> > 
> > Hmm.
> > 
> > That explanation looks believable, except that our qspinlocks
> > shouldn't be spinning on the lock itself, but spinning on the mcs node
> > it inserts into the lock.
> 
> The referenced regression report is very old (in Feb 2015 for 3.16-
> 3.17).  The ticket spinlock was still used at that time.  I believe that
> things become much better after we used qspinlock.  We can test that.

'will-it-scale/page_fault1 process mode' can greatly stress both zone
lock and LRU lock when nr_process = nr_cpu with thp disabled. So I run
it to see if it still makes a difference with qspinlock.
https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault1.c

The result on an Icelake 2 sockets server with a total of 48cores/96cpus:

tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/thp_enabled/cpufreq_governor/ucode:
  lkp-icl-2sp4/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/100%/process/page_fault1/never/performance/0xd000331

commit:
  v5.18-rc4
  731a704c0d8760cfd641af4bf57167d8c68f9b99

       v5.18-rc4 731a704c0d8760cfd641af4bf57
---------------- ---------------------------
         %stddev     %change         %stddev
	     \          |                \
  12323894           -26.0%    9125299        will-it-scale.128.processes

     22.33 ±  4%     -22.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu
      9.80            -9.2        0.57 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
     36.25            +6.7       42.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
      4.28 ± 10%     +34.6       38.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages
     75.05            +7.8       82.83        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath

commit 731a704c0d8760cfd641af4bf57 moves zone's lock back to above
free_area by reverting commit a368ab67aa55("mm: move zone lock to a
different cache line than order-0 free page lists") on top of v5.18-rc4.

The interpretation of the above result is: after the revert, performance
dropped 26%, zone lock increased 41% from 40% to 81%, the overall lock
contention increased 7.8% from 75% to 82.83%. So it appears it still
makes a difference with qspinlock.

------
Commit 731a704c0d8760cfd641af4bf57:

From 731a704c0d8760cfd641af4bf57167d8c68f9b99 Mon Sep 17 00:00:00 2001
From: Aaron Lu <aaron.lu@intel.com>
Date: Wed, 11 May 2022 10:32:53 +0800
Subject: [PATCH] Revert "mm: move zone lock to a different cache line than
 order-0 free page lists"

This reverts commit a368ab67aa55615a03b2c9c00fb965bee3ebeaa4.
---
 include/linux/mmzone.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 46ffab808f03..f5534f42c693 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -628,15 +628,15 @@ struct zone {
 	/* Write-intensive fields used from the page allocator */
 	ZONE_PADDING(_pad1_)
 
+	/* Primarily protects free_area */
+	spinlock_t		lock;
+
 	/* free areas of different sizes */
 	struct free_area	free_area[MAX_ORDER];
 
 	/* zone flags, see below */
 	unsigned long		flags;
 
-	/* Primarily protects free_area */
-	spinlock_t		lock;
-
 	/* Write-intensive fields used by compaction and vmstats. */
 	ZONE_PADDING(_pad2_)
 
-- 
2.35.3

The entire diff between the two kernels:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/thp_enabled/cpufreq_governor/ucode:
  lkp-icl-2sp4/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/100%/process/page_fault1/never/performance/0xd000331

commit: 
  v5.18-rc4
  731a704c0d8760cfd641af4bf57167d8c68f9b99

       v5.18-rc4 731a704c0d8760cfd641af4bf57 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  12323894           -26.0%    9125299        will-it-scale.128.processes
      0.05 ±  8%     +37.5%       0.07 ± 17%  will-it-scale.128.processes_idle
     96279           -26.0%      71290        will-it-scale.per_process_ops
  12323894           -26.0%    9125299        will-it-scale.workload
      0.33 ±141%    +800.0%       3.00 ± 54%  time.major_page_faults
      0.66            -0.1        0.60        mpstat.cpu.all.irq%
      1.49            -0.3        1.23        mpstat.cpu.all.usr%
    747.00 ± 54%     -83.8%     121.33 ± 62%  numa-meminfo.node0.Active(file)
   4063469           -11.0%    3617426 ±  2%  numa-meminfo.node0.AnonPages
      1634            -3.9%       1571        vmstat.system.cs
    250770 ±  5%     -24.4%     189542        vmstat.system.in
   7234686 ±  2%     +13.9%    8241057        meminfo.Inactive
   7231508 ±  2%     +13.9%    8239382        meminfo.Inactive(anon)
    101436           -19.5%      81700        meminfo.Mapped
    592.33 ±141%    +201.2%       1784        meminfo.Mlocked
 1.873e+09           -23.7%  1.429e+09        numa-numastat.node0.local_node
 1.872e+09           -23.7%  1.429e+09        numa-numastat.node0.numa_hit
 1.853e+09           -28.2%   1.33e+09        numa-numastat.node1.local_node
 1.852e+09           -28.2%  1.329e+09        numa-numastat.node1.numa_hit
     52056 ± 65%     +53.8%      80068 ± 34%  numa-numastat.node1.other_node
      0.06           -16.7%       0.05        turbostat.IPC
  75911699 ±  4%     -24.2%   57562839        turbostat.IRQ
     27.73           -23.4        4.29 ±  6%  turbostat.PKG_%
     77.67            -1.7%      76.33        turbostat.PkgTmp
    486.01            -2.8%     472.42        turbostat.PkgWatt
     94.08           -13.3%      81.55        turbostat.RAMWatt
    186.67 ± 54%     -84.1%      29.67 ± 63%  numa-vmstat.node0.nr_active_file
   1031719           -10.8%     920591 ±  2%  numa-vmstat.node0.nr_anon_pages
    186.67 ± 54%     -84.1%      29.67 ± 63%  numa-vmstat.node0.nr_zone_active_file
 1.872e+09           -23.7%  1.429e+09        numa-vmstat.node0.numa_hit
 1.873e+09           -23.7%  1.429e+09        numa-vmstat.node0.numa_local
   1030546 ±  2%      -9.2%     935582        numa-vmstat.node1.nr_anon_pages
 1.852e+09           -28.2%  1.329e+09        numa-vmstat.node1.numa_hit
 1.853e+09           -28.2%   1.33e+09        numa-vmstat.node1.numa_local
     52056 ± 65%     +53.8%      80068 ± 34%  numa-vmstat.node1.numa_other
     34.48 ± 33%     +59.4%      54.95 ± 16%  sched_debug.cfs_rq:/.load_avg.avg
    227417           +10.5%     251193 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
     59485 ± 84%    -144.1%     -26247        sched_debug.cfs_rq:/.spread0.avg
  -1687153            +8.2%   -1825127        sched_debug.cfs_rq:/.spread0.min
    227479           +10.4%     251123 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
      8.05 ± 21%     +59.2%      12.82 ± 27%  sched_debug.cpu.clock.stddev
      0.55 ±  7%     +61.5%       0.88 ± 14%  sched_debug.rt_rq:/.rt_time.avg
     68.39 ± 10%     +65.2%     113.01 ± 14%  sched_debug.rt_rq:/.rt_time.max
      6.02 ± 10%     +65.3%       9.95 ± 14%  sched_debug.rt_rq:/.rt_time.stddev
     51614            +6.2%      54828 ±  2%  proc-vmstat.nr_active_anon
   1762215 ±  3%      +5.3%    1855523        proc-vmstat.nr_anon_pages
   1855872 ±  3%      +9.5%    2032582        proc-vmstat.nr_inactive_anon
     25600           -19.4%      20637        proc-vmstat.nr_mapped
      8779            +3.6%       9100        proc-vmstat.nr_page_table_pages
     51614            +6.2%      54828 ±  2%  proc-vmstat.nr_zone_active_anon
   1855870 ±  3%      +9.5%    2032581        proc-vmstat.nr_zone_inactive_anon
 3.725e+09           -26.0%  2.758e+09        proc-vmstat.numa_hit
 3.726e+09           -25.9%  2.759e+09        proc-vmstat.numa_local
    140034 ±  3%     -15.7%     118073 ±  4%  proc-vmstat.numa_pte_updates
    164530            -6.5%     153823 ±  2%  proc-vmstat.pgactivate
 3.722e+09           -25.9%  2.756e+09        proc-vmstat.pgalloc_normal
 3.712e+09           -25.9%  2.749e+09        proc-vmstat.pgfault
 3.722e+09           -25.9%  2.756e+09        proc-vmstat.pgfree
     92383            -2.0%      90497        proc-vmstat.pgreuse
     14.36           -11.1%      12.77        perf-stat.i.MPKI
 1.493e+10           -11.2%  1.326e+10        perf-stat.i.branch-instructions
      0.12            -0.0        0.09        perf-stat.i.branch-miss-rate%
  16850271           -30.3%   11746955        perf-stat.i.branch-misses
     53.64            -9.1       44.57        perf-stat.i.cache-miss-rate%
  5.43e+08           -36.0%  3.473e+08        perf-stat.i.cache-misses
 1.012e+09           -23.1%  7.788e+08        perf-stat.i.cache-references
      1550            -3.2%       1500        perf-stat.i.context-switches
      5.92           +16.4%       6.89        perf-stat.i.cpi
 4.178e+11            +1.0%  4.219e+11        perf-stat.i.cpu-cycles
    150.89            -2.3%     147.36        perf-stat.i.cpu-migrations
    769.17           +57.8%       1213        perf-stat.i.cycles-between-cache-misses
      0.01            -0.0        0.01 ±  3%  perf-stat.i.dTLB-load-miss-rate%
   1363413 ±  3%     -41.4%     799244 ±  4%  perf-stat.i.dTLB-load-misses
 1.855e+10           -13.9%  1.597e+10        perf-stat.i.dTLB-loads
      1.87            -0.0        1.83        perf-stat.i.dTLB-store-miss-rate%
  1.45e+08           -27.1%  1.057e+08        perf-stat.i.dTLB-store-misses
 7.586e+09           -25.1%  5.682e+09        perf-stat.i.dTLB-stores
 7.051e+10           -13.3%  6.114e+10        perf-stat.i.instructions
      0.17           -14.0%       0.15        perf-stat.i.ipc
    333.69          +209.4%       1032        perf-stat.i.metric.K/sec
    332.10           -16.3%     278.07        perf-stat.i.metric.M/sec
  12265683           -25.6%    9119612        perf-stat.i.minor-faults
      8.89            +4.2       13.06        perf-stat.i.node-load-miss-rate%
   1327995           -33.6%     882417        perf-stat.i.node-load-misses
  14189574           -57.0%    6101421        perf-stat.i.node-loads
      0.63            +0.0        0.68        perf-stat.i.node-store-miss-rate%
   2654944           -33.3%    1769896        perf-stat.i.node-store-misses
 4.223e+08           -38.3%  2.606e+08        perf-stat.i.node-stores
  12265684           -25.6%    9119613        perf-stat.i.page-faults
     14.35           -11.1%      12.76        perf-stat.overall.MPKI
      0.11            -0.0        0.09        perf-stat.overall.branch-miss-rate%
     53.62            -9.0       44.59        perf-stat.overall.cache-miss-rate%
      5.93           +16.4%       6.90        perf-stat.overall.cpi
    770.18           +57.5%       1213        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  2%      -0.0        0.01 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      1.87            -0.0        1.83        perf-stat.overall.dTLB-store-miss-rate%
      0.17           -14.1%       0.14        perf-stat.overall.ipc
      8.47            +3.9       12.38        perf-stat.overall.node-load-miss-rate%
      0.62            +0.0        0.67        perf-stat.overall.node-store-miss-rate%
   1728530           +16.5%    2012907        perf-stat.overall.path-length
 1.483e+10           -11.8%  1.309e+10        perf-stat.ps.branch-instructions
  16689442           -30.9%   11532682        perf-stat.ps.branch-misses
 5.392e+08           -36.3%  3.433e+08        perf-stat.ps.cache-misses
 1.006e+09           -23.4%  7.698e+08        perf-stat.ps.cache-references
      1534            -4.1%       1472        perf-stat.ps.context-switches
    148.92            -2.9%     144.56        perf-stat.ps.cpu-migrations
   1379865 ±  2%     -39.8%     830956 ±  4%  perf-stat.ps.dTLB-load-misses
 1.843e+10           -14.5%  1.576e+10        perf-stat.ps.dTLB-loads
  1.44e+08           -27.5%  1.045e+08        perf-stat.ps.dTLB-store-misses
 7.537e+09           -25.6%  5.611e+09        perf-stat.ps.dTLB-stores
 7.006e+10           -13.9%  6.035e+10        perf-stat.ps.instructions
      0.97            -7.8%       0.89        perf-stat.ps.major-faults
  12184666           -26.0%    9015678        perf-stat.ps.minor-faults
   1314901           -34.3%     864119        perf-stat.ps.node-load-misses
  14202713           -56.9%    6114798        perf-stat.ps.node-loads
   2633146           -34.0%    1737950        perf-stat.ps.node-store-misses
 4.191e+08           -38.6%  2.575e+08        perf-stat.ps.node-stores
  12184667           -26.0%    9015679        perf-stat.ps.page-faults
  2.13e+13           -13.8%  1.837e+13        perf-stat.total.instructions
     22.34 ±  4%     -22.3        0.00        perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
     22.34 ±  4%     -22.3        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu.zap_pte_range
     22.33 ±  4%     -22.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.release_pages.tlb_flush_mmu
     10.82            -9.6        1.26        perf-profile.calltrace.cycles-pp.folio_add_lru.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     10.74            -9.5        1.20 ±  2%  perf-profile.calltrace.cycles-pp.__pagevec_lru_add.folio_add_lru.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     67.12            -9.3       57.77        perf-profile.calltrace.cycles-pp.testcase
     67.39            -9.3       58.05        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      9.85            -9.3        0.60 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.do_anonymous_page
      9.85            -9.2        0.61 ±  3%  perf-profile.calltrace.cycles-pp.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru.do_anonymous_page.__handle_mm_fault
      9.80            -9.2        0.57 ±  3%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.folio_lruvec_lock_irqsave.__pagevec_lru_add.folio_add_lru
     63.37            -8.3       55.10        perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.testcase
     63.30            -8.3       55.04        perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     62.65            -8.1       54.57        perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.testcase
     62.18            -7.9       54.23        perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     61.61            -7.8       53.84        perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      6.69            -2.5        4.15 ±  2%  perf-profile.calltrace.cycles-pp.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      5.36            -2.0        3.35 ±  2%  perf-profile.calltrace.cycles-pp.charge_memcg.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault.handle_mm_fault
      4.76            -1.7        3.05        perf-profile.calltrace.cycles-pp.clear_page_erms.get_page_from_freelist.__alloc_pages.alloc_pages_vma.do_anonymous_page
      2.25            -0.8        1.41 ±  2%  perf-profile.calltrace.cycles-pp.try_charge_memcg.charge_memcg.__mem_cgroup_charge.do_anonymous_page.__handle_mm_fault
      1.16            -0.3        0.84        perf-profile.calltrace.cycles-pp.error_entry.testcase
      1.08            -0.3        0.78        perf-profile.calltrace.cycles-pp.sync_regs.error_entry.testcase
      0.00            +0.6        0.58        perf-profile.calltrace.cycles-pp.__free_one_page.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_flush_mmu
      3.31            +0.8        4.16        perf-profile.calltrace.cycles-pp.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
      3.29            +0.8        4.14        perf-profile.calltrace.cycles-pp.release_pages.tlb_finish_mmu.unmap_region.__do_munmap.__vm_munmap
      0.87 ±  7%      +3.1        3.96        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_finish_mmu
      0.98 ±  6%      +3.1        4.08        perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_finish_mmu.unmap_region.__do_munmap
      0.95 ±  7%      +3.1        4.05        perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_finish_mmu.unmap_region
     43.13            +4.6       47.75        perf-profile.calltrace.cycles-pp.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     42.94            +4.7       47.60        perf-profile.calltrace.cycles-pp.__alloc_pages.alloc_pages_vma.do_anonymous_page.__handle_mm_fault.handle_mm_fault
     42.69            +4.7       47.42        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.alloc_pages_vma.do_anonymous_page.__handle_mm_fault
     37.53            +6.6       44.09        perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_pages.alloc_pages_vma.do_anonymous_page
     37.08            +6.7       43.76        perf-profile.calltrace.cycles-pp.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages.alloc_pages_vma
     36.25            +6.7       42.94        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist
     36.26            +6.7       42.96        perf-profile.calltrace.cycles-pp._raw_spin_lock.rmqueue_bulk.rmqueue.get_page_from_freelist.__alloc_pages
     28.37            +8.7       37.04        perf-profile.calltrace.cycles-pp.unmap_vmas.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap
     28.37            +8.7       37.04        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.unmap_region.__do_munmap.__vm_munmap
     28.37            +8.7       37.04        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region.__do_munmap
     28.35            +8.7       37.03        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.unmap_region
     27.31            +9.1       36.40        perf-profile.calltrace.cycles-pp.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
     27.16            +9.2       36.32        perf-profile.calltrace.cycles-pp.release_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range.unmap_page_range
     31.70            +9.5       41.20        perf-profile.calltrace.cycles-pp.unmap_region.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     31.70            +9.5       41.20        perf-profile.calltrace.cycles-pp.__do_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
     31.70            +9.5       41.20        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     31.70            +9.5       41.20        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     31.70            +9.5       41.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
     31.70            +9.5       41.21        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
     31.70            +9.5       41.21        perf-profile.calltrace.cycles-pp.__munmap
      3.40 ± 14%     +31.6       34.97        perf-profile.calltrace.cycles-pp._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_flush_mmu
      4.15 ± 12%     +31.7       35.82        perf-profile.calltrace.cycles-pp.free_unref_page_list.release_pages.tlb_flush_mmu.zap_pte_range.zap_pmd_range
      3.94 ± 12%     +31.7       35.61        perf-profile.calltrace.cycles-pp.free_pcppages_bulk.free_unref_page_list.release_pages.tlb_flush_mmu.zap_pte_range
      4.28 ± 10%     +34.6       38.93        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.free_pcppages_bulk.free_unref_page_list.release_pages
     34.49 ±  2%     -33.7        0.74 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
     34.49 ±  2%     -33.7        0.74 ±  5%  perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
     10.86            -9.6        1.27        perf-profile.children.cycles-pp.folio_add_lru
     10.80            -9.6        1.21 ±  2%  perf-profile.children.cycles-pp.__pagevec_lru_add
     68.04            -9.6       58.47        perf-profile.children.cycles-pp.testcase
     65.56            -8.9       56.70        perf-profile.children.cycles-pp.asm_exc_page_fault
     63.41            -8.3       55.13        perf-profile.children.cycles-pp.exc_page_fault
     63.35            -8.3       55.09        perf-profile.children.cycles-pp.do_user_addr_fault
     62.69            -8.1       54.60        perf-profile.children.cycles-pp.handle_mm_fault
     62.20            -7.9       54.26        perf-profile.children.cycles-pp.__handle_mm_fault
     61.84            -7.8       54.00        perf-profile.children.cycles-pp.do_anonymous_page
      6.74            -2.6        4.18 ±  2%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      5.56            -2.1        3.47 ±  2%  perf-profile.children.cycles-pp.charge_memcg
      4.82            -1.7        3.09        perf-profile.children.cycles-pp.clear_page_erms
      2.26            -0.8        1.42 ±  2%  perf-profile.children.cycles-pp.try_charge_memcg
      1.21            -0.3        0.88        perf-profile.children.cycles-pp.error_entry
      1.08            -0.3        0.79        perf-profile.children.cycles-pp.sync_regs
      1.01            -0.3        0.73        perf-profile.children.cycles-pp.native_irq_return_iret
      0.66            -0.3        0.39 ±  3%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.68            -0.2        0.44        perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.66            -0.2        0.48        perf-profile.children.cycles-pp.__pagevec_lru_add_fn
      0.50            -0.2        0.32 ±  2%  perf-profile.children.cycles-pp.page_add_new_anon_rmap
      0.53            -0.2        0.37        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.47            -0.1        0.32        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.41            -0.1        0.27        perf-profile.children.cycles-pp.page_remove_rmap
      0.39            -0.1        0.28 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.38            -0.1        0.26        perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.37            -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.37            -0.1        0.26 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.26 ±  5%      -0.1        0.15 ±  3%  perf-profile.children.cycles-pp.page_counter_try_charge
      0.32            -0.1        0.21        perf-profile.children.cycles-pp.__mod_lruvec_state
      0.33            -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.32            -0.1        0.23 ±  2%  perf-profile.children.cycles-pp.__perf_sw_event
      0.30            -0.1        0.21 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
      0.29            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.tick_sched_handle
      0.29            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.update_process_times
      0.23 ±  2%      -0.1        0.15        perf-profile.children.cycles-pp.__mod_node_page_state
      0.27            -0.1        0.19 ±  2%  perf-profile.children.cycles-pp.scheduler_tick
      0.14 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.25            -0.1        0.17 ±  2%  perf-profile.children.cycles-pp.task_tick_fair
      0.13 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.free_swap_cache
      0.22            -0.1        0.15 ±  5%  perf-profile.children.cycles-pp.update_curr
      0.24            -0.1        0.17        perf-profile.children.cycles-pp.___perf_sw_event
      0.16 ±  3%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      0.12 ±  3%      -0.1        0.06        perf-profile.children.cycles-pp.task_numa_work
      0.15 ±  5%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      0.20            -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.13 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.12 ±  3%      -0.1        0.06 ±  7%  perf-profile.children.cycles-pp.task_work_run
      0.12 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.change_prot_numa
      0.12 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.change_protection_range
      0.12 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.change_pmd_range
      0.12 ±  6%      -0.1        0.06        perf-profile.children.cycles-pp.change_pte_range
      0.20 ±  2%      -0.1        0.14 ±  5%  perf-profile.children.cycles-pp.perf_tp_event
      0.19 ±  2%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.__perf_event_overflow
      0.19 ±  2%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.perf_event_output_forward
      0.16            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.perf_callchain
      0.16 ±  3%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.get_perf_callchain
      0.16            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.perf_prepare_sample
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.09            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.09 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__cgroup_throttle_swaprate
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.perf_callchain_kernel
      0.11 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.free_unref_page_commit
      0.11 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.__count_memcg_events
      0.09            -0.0        0.06        perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.12 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.mem_cgroup_charge_statistics
      0.09 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.mem_cgroup_update_lru_size
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.handle_pte_fault
      0.12 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.__might_resched
      0.08            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.up_read
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.__mod_zone_page_state
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.down_read_trylock
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.folio_mapping
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.find_vma
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.unwind_next_frame
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.__cond_resched
      0.16            +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.06 ±  8%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.06 ±  7%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_page
      0.06 ±  7%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.shmem_alloc_page
      0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.__get_free_pages
      0.55 ±  3%      +0.1        0.68        perf-profile.children.cycles-pp.__free_one_page
      3.31            +0.8        4.16        perf-profile.children.cycles-pp.tlb_finish_mmu
     43.22            +4.7       47.91        perf-profile.children.cycles-pp.alloc_pages_vma
     43.13            +4.8       47.90        perf-profile.children.cycles-pp.__alloc_pages
     42.83            +4.9       47.69        perf-profile.children.cycles-pp.get_page_from_freelist
     37.68            +6.7       44.37        perf-profile.children.cycles-pp.rmqueue
     37.20            +6.8       44.02        perf-profile.children.cycles-pp.rmqueue_bulk
     75.05            +7.8       82.83        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     28.37            +8.7       37.04        perf-profile.children.cycles-pp.unmap_vmas
     28.37            +8.7       37.04        perf-profile.children.cycles-pp.unmap_page_range
     28.37            +8.7       37.04        perf-profile.children.cycles-pp.zap_pmd_range
     28.37            +8.7       37.04        perf-profile.children.cycles-pp.zap_pte_range
     27.31            +9.1       36.40        perf-profile.children.cycles-pp.tlb_flush_mmu
     31.70            +9.5       41.20        perf-profile.children.cycles-pp.__do_munmap
     31.70            +9.5       41.20        perf-profile.children.cycles-pp.__vm_munmap
     31.70            +9.5       41.20        perf-profile.children.cycles-pp.__x64_sys_munmap
     31.70            +9.5       41.20        perf-profile.children.cycles-pp.unmap_region
     31.70            +9.5       41.21        perf-profile.children.cycles-pp.__munmap
     31.91            +9.5       41.44        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     31.91            +9.5       41.44        perf-profile.children.cycles-pp.do_syscall_64
     30.60           +10.0       40.57        perf-profile.children.cycles-pp.release_pages
      5.15 ±  8%     +34.8       39.91        perf-profile.children.cycles-pp.free_unref_page_list
      4.90 ±  9%     +34.8       39.69        perf-profile.children.cycles-pp.free_pcppages_bulk
     40.73 ±  2%     +41.5       82.22        perf-profile.children.cycles-pp._raw_spin_lock
      4.79            -1.7        3.08 ±  2%  perf-profile.self.cycles-pp.clear_page_erms
      3.27            -1.2        2.02 ±  2%  perf-profile.self.cycles-pp.charge_memcg
      1.80            -0.7        1.15 ±  2%  perf-profile.self.cycles-pp.try_charge_memcg
      2.15            -0.6        1.59        perf-profile.self.cycles-pp.testcase
      0.57 ±  3%      -0.3        0.27 ±  3%  perf-profile.self.cycles-pp.zap_pte_range
      1.06            -0.3        0.77        perf-profile.self.cycles-pp.sync_regs
      1.01            -0.3        0.73        perf-profile.self.cycles-pp.native_irq_return_iret
      0.63            -0.3        0.38 ±  3%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      0.51            -0.2        0.34        perf-profile.self.cycles-pp.__list_del_entry_valid
      0.55 ±  2%      -0.2        0.39        perf-profile.self.cycles-pp.do_anonymous_page
      0.39 ±  2%      -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.__mem_cgroup_charge
      0.30 ±  2%      -0.1        0.18 ±  4%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.38            -0.1        0.27        perf-profile.self.cycles-pp.release_pages
      0.34            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.25            -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.30            -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.22 ±  6%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.page_counter_try_charge
      0.33            -0.1        0.24        perf-profile.self.cycles-pp.__pagevec_lru_add_fn
      0.22 ±  2%      -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.28            -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.13 ±  3%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.free_swap_cache
      0.11 ±  4%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.change_pte_range
      0.19 ±  2%      -0.1        0.14        perf-profile.self.cycles-pp.handle_mm_fault
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__alloc_pages
      0.17 ±  2%      -0.0        0.12        perf-profile.self.cycles-pp.___perf_sw_event
      0.14 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.page_remove_rmap
      0.16            -0.0        0.12        perf-profile.self.cycles-pp.do_user_addr_fault
      0.07            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.09            -0.0        0.06        perf-profile.self.cycles-pp.__perf_sw_event
      0.09            -0.0        0.06        perf-profile.self.cycles-pp.__count_memcg_events
      0.11            -0.0        0.08        perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.11            -0.0        0.08        perf-profile.self.cycles-pp.__might_resched
      0.08            -0.0        0.05        perf-profile.self.cycles-pp.__irqentry_text_end
      0.13            -0.0        0.10        perf-profile.self.cycles-pp.error_entry
      0.12            -0.0        0.09        perf-profile.self.cycles-pp.alloc_pages_vma
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.free_unref_page_commit
      0.08            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.folio_add_lru
      0.07 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.mem_cgroup_update_lru_size
      0.10 ±  4%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.mem_cgroup_charge_statistics
      0.10            -0.0        0.08        perf-profile.self.cycles-pp._raw_spin_lock
      0.07 ±  6%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.down_read_trylock
      0.09            -0.0        0.07        perf-profile.self.cycles-pp.__mod_zone_page_state
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.__mod_lruvec_state
      0.07 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.07            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.up_read
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.folio_mapping
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.free_unref_page_list
      0.13            +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.__list_add_valid
      0.48            +0.1        0.58        perf-profile.self.cycles-pp.rmqueue_bulk
      0.46 ±  3%      +0.1        0.56        perf-profile.self.cycles-pp.__free_one_page
     75.05            +7.8       82.83        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath

