Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255A590B68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiHLFCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiHLFCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:02:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA5978BC8;
        Thu, 11 Aug 2022 22:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660280520; x=1691816520;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/U5ISG9FulfuENBNkP9E6QJfUWpNSdUKSKBfDqcB/t8=;
  b=emeIGUKCIkSBtkw6G8NjV7/7evJkP8k1+h4Tx3/aPX1kMCg9IO8gPoYA
   H5jvCM1sE0soyPChLvnN7574+PpYZmUMJ7qaRJniUF0WQOakiupt8tvi3
   DxfUQorrxpqOE4QKHCXyAY4OwdlI5Q8Z9UFJtkYZ/+AbbdGVXKpqymjdw
   e2xGGJaF1TdW94YaQQ9zLJvTDxFk1z0ekjE1AhLCsbJ0JprHcYkFBxZhj
   N15KrRcAWIvuL1gRQu3IHp3Qh3NDF08l8VGzLj4ExNB6jYKOPrFhYFtuf
   Sk6PCxaETM4MctLDxeu44g9S7DnFBhGtAHq2UJJUveqSDXw11U5kdu95x
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="289092332"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="289092332"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 22:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="695149477"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2022 22:01:57 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 22:01:57 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 22:01:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 22:01:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 22:01:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvOFcQZnF5em/MtKw67o0m5G5ZPiGPQk/1WYH11ncnzA/fz8LNza0osI97PHDAtZyqtrr9iTpC/3V0jGAtYHfVUs31rWg8R6qL2Ac8P5y+T9E9c+BHZ2KXxfm3Ovp67qvZchhyyICLtSAZwtuvDLFOnBGHl6fXmQWigBvQfv0wCF9bBOX/i/ActD4em/wFsUQTzk/OqP2t/FNhR+BYgdqwN9M8AIJVmqGitX+uxhNtSAQ63M6Y3HiRdOtwNQ3WTugADGjViDqwjg/Ls4bfntFojbkx2ID4XaePEo/az7Wa0DUa8/m18Py2c4bTWZRCC958BeQm0v9/7ZfYbIBXkCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2z4eb129Cv45eOWoEcVL9zoLYle30MqhxErfzWhR2A=;
 b=WJ6uzxjZEBKSMWrwd6KTgyefXZALJELwUKkYzwhVWrqqN0GfINB7PyoadXdpLyw3jiBgBlu3k0LEMWDO/6KniV4Zt+ErLVo2cdqLUZf9dNIlVcw0vRzrkM7HsvxJEjPYPt6rr/Q++5WWMq4VUKndnOSp0/jCPCBXci1OJhdovNC+YAj5Evxzviz0DgfCHHgPp95ote+jpttgU09epl6vf1RfZK/U0HYZQPU3e+ruH+h9CzEp9YGElS5DdrOFAXy3CMX7WO5JPE5kcnhyavy4telmbkJS6scZ5VKa6Rw4JxpBiYU6BuaT82vky0Ut35lMBE8GQp6KfuWqrgF64Ehw3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by BYAPR11MB3847.namprd11.prod.outlook.com (2603:10b6:a03:b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 12 Aug
 2022 05:01:54 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::f906:b045:d73e:8e49%9]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 05:01:54 +0000
Date:   Fri, 12 Aug 2022 13:01:44 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-ide@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
Message-ID: <YvXeuCAK780OuJPz@xsang-OptiPlex-9020>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
 <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
 <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4106ffa-3842-45c0-9756-5226cfcfa17d@opensource.wdc.com>
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2001960d-9fb0-4bc3-8337-08da7c1fc68c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3847:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7emhX/gsWj8w5DuBkCttgAsQ1CzYcr7qR+vgb/7L8q/zSr+pA/vuRLD/udbxmNIvi75Q9+K8sN5iPxQxgPMCEF2ZhHwOfDZyJXHXdaVexiD0YHiRr4seYo5rChSwzUgYQ4GtHYpcunJM0bmhVOUpHrfrYFafLvbXENiYAz+wKUO8PMo49WsCR+yWHRHPOcZ5OzA4Yzjc0H61cR9y3qIuaqTYhFxJphYLeT2OrT/CCmyLatOwpJjzRgkt6rKWNBolubDw6Avq6/3Nv9iJie6Y6vWHd0ibr5cVBcYm8jolRgq0m2JY3hT+tv14L+EdNNMxFevimHmsqof/7hDqgQdS7VepyjKU6ycPgzHXtsoc7yGmMVCIXeYzpROxG/4InQEP+CXlG1rf7KYtA05hIY9mvz6wgXhH+I2gVSrFXGFaFEfgV7whvHhN2hOIIqDMEl2wgI137SOaj4rdoqlk3dFoteaYzQZ94CYEkfFz4/5GvTkFqKU8qfqXBH9rE7oriHBivlUINDkOXc7+uS8a0BCFktp1fIBPP+oIQOyoC+5+RfrU8y4qbhamMB159pkrEOsVDHUQi/zfz4NNXZSnFUwY1YKgtDivkxDCcJthpmrcr5UQtLwt9sQ+PqZpyZpDBvnjbY9OipD717VbbJhRGhEZjKj1bogpotgkfa3b22i9AT5lFvCvB85DM6IHCjXmcCYXudjfJTAI+aPcVilB4zAC9qTX/j1nFlGL3U+kt8aJvhqNFeCygWQf6WOa44yHXiEg1svpCv0McR/LNX4VTvzVGh892R9mnJM9qdYrYH5slJ1M7UUQPANBQCis7qM5OdT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(396003)(366004)(376002)(39860400002)(346002)(82960400001)(2906002)(41300700001)(6916009)(316002)(54906003)(4326008)(66476007)(66556008)(478600001)(8676002)(33716001)(966005)(66946007)(44832011)(6486002)(86362001)(38100700002)(8936002)(9686003)(6512007)(83380400001)(53546011)(26005)(5660300002)(6506007)(6666004)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Fghu8DC2aZG8UvmkEO4mR5utBdt3mJUHSmYfv6tDVdt1IwQ+nhOl/WbDtG?=
 =?iso-8859-1?Q?e9+GX+bZHcrIQS5gGuW7DBI41ZohUR4UC1mRW9rSuMTlNfd1+BHVcS6l9Q?=
 =?iso-8859-1?Q?ZI8od4cTeSisA0/YlnUW0eQkjXjN16Clmbeqy4sBf+V9tSArd/zdjG1gp/?=
 =?iso-8859-1?Q?pgWVt52NWG0t8xYLk8Bi9iYWTjxHmVSLifgCz3ZVDz9j9F6ji/aelgq4BM?=
 =?iso-8859-1?Q?/b6A04vJZU/1iOrGCgFRbXr81MIY5l79UsD16GLn0R3rb718pgkF+i/7xL?=
 =?iso-8859-1?Q?/rWcDv8a0EKw4FzHKn9NfYwZ8sdmH6VbCE9NtCYkGASIgOfdS3cJMmZQZl?=
 =?iso-8859-1?Q?MILlIFHqQ1NXX0O/fDRgk/2+ufd0E/9VCluD/bHaWJvcRYZP3bnJ+MPZld?=
 =?iso-8859-1?Q?pTj8fHxZ4eK7Y5ar7Z5C9LFq3Q1D1xcaaAf0lYkrP68x6xYTwAfzvyv9cA?=
 =?iso-8859-1?Q?L5Uv0D0DZaQnIJtZ/zeazqS0qKXMHYXkblgKJg9jeEGAds4vVONBfnaTYY?=
 =?iso-8859-1?Q?B6EJWu03YZsqOX+MeRtAGEyDj66NTfcP4v0WP11iFdVzT1Ow8mEUs6DqKG?=
 =?iso-8859-1?Q?Gel/IabB/odNVOq4AZZDwzDgJGu0OF5SUkZu9RnwzLQH1kXucz9bvF1Res?=
 =?iso-8859-1?Q?OwnfIwVxtlPiGvQimu1P7p+7LiphAGb68Y1W098CK80Y0z/cHu74UmRPtM?=
 =?iso-8859-1?Q?aNyepMiW0krS5ihyZnBuXsVRNYP6MT1N3ir58Qzyl0qJmI4NhsYOm8aPTh?=
 =?iso-8859-1?Q?mcDHmnPPI7KInaUSNtSNyZwHMuNMJjt9mOehwCYgJ8SP0dwcxtwloMr6OD?=
 =?iso-8859-1?Q?//+iIjyjNlIq7yEhjarrSni6cE5oplUQj6L/vWn6YzjW3bf6nAXZT8OzTY?=
 =?iso-8859-1?Q?Q3A44XIQ/T6E/eWzfBKXTNaAB5eCPVBRgHeG3ptBAuceJEnA8lrGV7YeR6?=
 =?iso-8859-1?Q?DyvqMe4lLEValsiG6mJWbzTqWUtZbiGDdCrzeoOSueJr8YY8rntnW59hQw?=
 =?iso-8859-1?Q?E1PZ4F6fSuJj2YmrCyg9uWw/MzFuZflyrUY04jhTWoqDexzPT6v6dYtRIq?=
 =?iso-8859-1?Q?lcjixQswueJKbtyElkLnj6Yima3hNyok6Ry7TGP6Aebiq2jh2beaG2gmbB?=
 =?iso-8859-1?Q?AaYCB1+GSsaaqlQI8FEkzQn6kCHcMlsHjnq1HC6bb/ugG2l7o5NwPAUGnp?=
 =?iso-8859-1?Q?myTVabqJ7VOqtHRCmOMQOz06C+GFh4cC7WjTomktBZGNutm+BXnmnF687Q?=
 =?iso-8859-1?Q?qmbMheLO8MUQa0EZmnxLiBYhcRwwZGPddDh6hP4H25CkmqcGr+EFiF3FNa?=
 =?iso-8859-1?Q?68FDnCvEubopMIxBCi687z1ZXNASa8b2uqVWIvOom3+e6wbwUqHP4XD2MX?=
 =?iso-8859-1?Q?weIO+r5fQ3B3JAwZkwwwBFMvb97VdMRE0ZI9j3DMC3PATkT1U+dlzvsUYV?=
 =?iso-8859-1?Q?LWsDO43yiSgT8mUKey7+UDbwiVZrzDQuttBatYhE29M/WenwBnHN8/lsp6?=
 =?iso-8859-1?Q?eQdKfXylv/wKToYBYeDGABIlzap690auJL74O4NSeJ14Mv5nXizCqa+yUk?=
 =?iso-8859-1?Q?UJA9uxIb+hqHp52VcVJIeeYDbVzaF8b55SU9ehyWwKg4s4vVIYfOlq+2oi?=
 =?iso-8859-1?Q?e2S6LTfMncTCDVD6sHdgqQ7nqFYbytxkxOFsApI37uDFPwuqcsSW3wIg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2001960d-9fb0-4bc3-8337-08da7c1fc68c
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 05:01:54.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU3J+0WDq2pyayfxXWecHSoecdDtNhp5jP9A7b2CNLKjJAmLh5BO5/jEvM5m9js5WYsbJ1LvfMT+0/74zddGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3847
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

hi, Damien Le Moal,

On Tue, Aug 09, 2022 at 07:55:53AM -0700, Damien Le Moal wrote:
> On 2022/08/09 2:58, John Garry wrote:
> > On 08/08/2022 15:52, Damien Le Moal wrote:
> >> On 2022/08/05 1:05, kernel test robot wrote:
> >>>
> >>>
> >>> Greeting,
> >>>
> >>> FYI, we noticed a -15.0% regression of stress-ng.copy-file.ops_per_sec due to commit:
> >>>
> >>>
> >>> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
> >>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >>>
> >>> in testcase: stress-ng
> >>> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
> >>> with following parameters:
> >>>
> >>> 	nr_threads: 10%
> >>> 	disk: 1HDD
> >>> 	testtime: 60s
> >>> 	fs: f2fs
> >>> 	class: filesystem
> >>> 	test: copy-file
> >>> 	cpufreq_governor: performance
> >>> 	ucode: 0xb000280
> >>
> >> Without knowing what the device adapter is, hard to say where the problem is. I
> >> suspect that with the patch applied, we may be ending up with a small default
> >> max_sectors value, causing overhead due to more commands than necessary.
> >>
> >> Will check what I see with my test rig.
> > 
> > As far as I can see, this patch should not make a difference unless the 
> > ATA shost driver is setting the max_sectors value unnecessarily low.
> 
> That is my hunch too, hence my question about which host driver is being used
> for this test... That is not apparent from the problem report.

we noticed the commit is already in mainline now, and in our tests, there is
still similar regression and also on other platforms.
could you guide us how to check "which host driver is being used for this
test"? hope to supply some useful information.

> 
> > 
> >>
> >>>
> >>>
> >>>
> >>>
> >>> If you fix the issue, kindly add following tag
> >>> Reported-by: kernel test robot <oliver.sang@intel.com>
> >>>
> >>>
> >>> Details are as below:
> >>> -------------------------------------------------------------------------------------------------->
> >>>
> >>>
> >>> To reproduce:
> >>>
> >>>          git clone https://github.com/intel/lkp-tests.git
> >>>          cd lkp-tests
> >>>          sudo bin/lkp install job.yaml           # job file is attached in this email
> >>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> >>>          sudo bin/lkp run generated-yaml-file
> >>>
> >>>          # if come across any failure that blocks the test,
> >>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> >>>
> >>> =========================================================================================
> >>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
> >>>    filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/copy-file/stress-ng/60s/0xb000280
> >>>
> >>> commit:
> >>>    4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
> >>>    0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
> >>>
> >>> 4cbfca5f7750520f 0568e6122574dcc1aded2979cd0
> >>> ---------------- ---------------------------
> >>>           %stddev     %change         %stddev
> >>>               \          |                \
> >>>        1627           -14.9%       1385        stress-ng.copy-file.ops
> >>>       27.01           -15.0%      22.96        stress-ng.copy-file.ops_per_sec
> >>>     8935079           -11.9%    7870629        stress-ng.time.file_system_outputs
> >>>       14.88 ±  5%     -31.8%      10.14 ±  3%  stress-ng.time.percent_of_cpu_this_job_got
> >>>       50912           -14.7%      43413        vmstat.io.bo
> >>>       93.78            +1.4%      95.10        iostat.cpu.idle
> >>>        3.89           -31.6%       2.66        iostat.cpu.iowait
> >>>        4.01            -1.3        2.74        mpstat.cpu.all.iowait%
> >>>        0.23 ±  9%      -0.1        0.17 ± 11%  mpstat.cpu.all.sys%
> >>>        1.66 ± 37%      -1.2        0.51 ± 55%  perf-profile.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.f2fs_buffered_write_iter.f2fs_file_write_iter.do_iter_readv_writev
> >>>        1.66 ± 37%      -1.1        0.59 ± 25%  perf-profile.children.cycles-pp.f2fs_write_end
> >>>        1.51 ± 40%      -1.1        0.45 ± 26%  perf-profile.children.cycles-pp.f2fs_dirty_data_folio
> >>>        1.21 ± 49%      -1.0        0.23 ± 33%  perf-profile.children.cycles-pp.f2fs_update_dirty_folio
> >>>        0.88 ± 56%      -0.8        0.04 ±111%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
> >>>        0.14 ± 26%      +0.1        0.25 ± 28%  perf-profile.children.cycles-pp.page_cache_ra_unbounded
> >>>        0.88 ± 56%      -0.8        0.04 ±112%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
> >>>     3164876 ±  9%     -20.2%    2524713 ±  7%  perf-stat.i.cache-misses
> >>>   4.087e+08            -4.6%  3.899e+08        perf-stat.i.dTLB-loads
> >>>      313050 ± 10%     -18.4%     255410 ±  6%  perf-stat.i.node-loads
> >>>      972573 ±  9%     -16.4%     812873 ±  6%  perf-stat.i.node-stores
> >>>     3114748 ±  9%     -20.2%    2484807 ±  7%  perf-stat.ps.cache-misses
> >>>   4.022e+08            -4.6%  3.837e+08        perf-stat.ps.dTLB-loads
> >>>      308178 ± 10%     -18.4%     251418 ±  6%  perf-stat.ps.node-loads
> >>>      956996 ±  9%     -16.4%     799948 ±  6%  perf-stat.ps.node-stores
> >>>      358486            -8.3%     328694        proc-vmstat.nr_active_file
> >>>     1121620           -11.9%     987816        proc-vmstat.nr_dirtied
> >>>      179906            -6.7%     167912        proc-vmstat.nr_dirty
> >>>     1151201            -1.7%    1131322        proc-vmstat.nr_file_pages
> >>>      100181            +9.9%     110078 ±  2%  proc-vmstat.nr_inactive_file
> >>>      846362           -14.6%     722471        proc-vmstat.nr_written
> >>>      358486            -8.3%     328694        proc-vmstat.nr_zone_active_file
> >>>      100181            +9.9%     110078 ±  2%  proc-vmstat.nr_zone_inactive_file
> >>>      180668            -6.8%     168456        proc-vmstat.nr_zone_write_pending
> >>>      556469            -3.5%     536985        proc-vmstat.pgactivate
> >>>     3385454           -14.6%    2889953        proc-vmstat.pgpgout
> >>>
> >>>
> >>>
> >>>
> >>> Disclaimer:
> >>> Results have been estimated based on internal Intel analysis and are provided
> >>> for informational purposes only. Any difference in system hardware or software
> >>> design or configuration may affect actual performance.
> >>>
> >>>
> >>
> >>
> > 
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
