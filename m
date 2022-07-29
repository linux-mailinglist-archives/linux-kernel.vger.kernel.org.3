Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC7584C66
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiG2HJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiG2HJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:09:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F82AC69;
        Fri, 29 Jul 2022 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659078560; x=1690614560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g+0akimvOPKwH60Q7Z0PnMc1YT3qslVr6HnJeQBqEZM=;
  b=DtQuXpAdJuHFLiWfgi3lh9rc9fd/KM6xdZ3KaCaWafZ4M/4Hg+Rz+igf
   ZMQlyFp0Qzxj5iq0r1xVT8/WMPuLvduJhfsVIoQK3xdmbKLZ0j9/VUKgB
   1VRLChzHyJLSnhyrD4lkqU8abtLHX7sD4zCir3oK9b7mS/gZNMR6MR8nN
   dcOTcK15+FExSJ44+Gk1WmrIIOFX/5TG4FsWY9kr+9yBzAei1cXkDojQ8
   L6ZZl9pBsd0r3k6lJ3Ry/ddyanZMJrSJIfKadUfpskX7NJszEsw1qofBg
   fcWzgEt6nFlDrLBMQzdYdUpT+t1Hfg+CFiwUxo1vH47XM6o4H42Tn1uQG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="350415453"
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="xz'?yaml'?scan'208";a="350415453"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 00:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,200,1654585200"; 
   d="xz'?yaml'?scan'208";a="601199228"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2022 00:09:18 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 00:09:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 29 Jul 2022 00:09:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 29 Jul 2022 00:09:17 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 29 Jul 2022 00:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M77U0CLRQXy0aCrwMqGH/cFIHTTW2HpPdh5YIayAOZFNUC0Ry8FYtxvwwdPiT9k31aAc5UJnT4DXQ7YNw5pqo62t8SMfo7rqlTC1tPx/bJLM5hWmaKIBb5Pp/sjD7u20IDDyWrbna4Uujzkk6f+s0jSzDPvDZQwamXgzXCs2pePWDOuUXO3l5g0xfpSORyQ+5EPUOW3hQjuDJWkcWA6jd0i12o7gRe4TdcRFqMvO8TUyx7vSGC97nvuUneVESAiKKH5y2Xfhj4iqi4916lXp1pAr6SGzCu1hWzCVTE3PDgVZfmKSYMc0CgZon2Uyk3iBbs4lGSwS+L6KHuj9qROGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWXyFMENVW4fS2o8D0mE2hxMnGgyPdUmHW2m6Xrf1VI=;
 b=lQTUfbZZbrSVrsyrKWfvklJKgeSzpVp839saMKa/vGv+E0EgF4aHlAlDaM+wr8QESbsB6yr/8z8utLLun27Hc3UNuMSeTxY1qgP8aO+YGYpbBR33/WboG2HJI0xA/Jow+TiSks6zROtzEnWVALk/w76c/U8hzZ5/eGC3EmVrN9aGNyWx9CDUEeDS9hMYD+qfrdN/ZabNZtOgYcQvTOG1LoKNsplcQ0EG8wdFKN3VO8fnXv7ibKtLxujsV+dncpv5S1OhzsFeSJz6xJxvNzZJU6X3KjcJHZrboNtX6l2CWlWi30C6lMxoL9Lh38Z2k6NVtNwQ5k7bs//QtVhBmfQIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 07:09:08 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c%6]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 07:09:08 +0000
Date:   Fri, 29 Jul 2022 15:08:58 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <lkp@lists.01.org>,
        <lkp@intel.com>
Subject: [selftests]  a37ddddd86:
 BUG:KASAN:use-after-free_in_firmware_upload_unregister
Message-ID: <YuOHivPKKyhPBXv2@xsang-OptiPlex-9020>
Content-Type: multipart/mixed; boundary="pn0N0EkwwXOpe2zG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To SJ1PR11MB6297.namprd11.prod.outlook.com
 (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33e3df46-9ccd-49d1-0938-08da71313a7f
X-MS-TrafficTypeDiagnostic: SN7PR11MB6775:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NdW3oTMW2ieHj1xWrz8HH66E3rDQ3B8J8q4u9OBgYtuBQnfjGeyOeHXCKiJK6QiZGjMux3Z1q9ZNq7kzYc6uhnKDPhrLM/b1W9favhRRW+5MaAJWO9yrLGM7ayosCZFZ+wQbmMgp1OC31A5wl44W5kExRze3tl4dpckhG4p8xFLBzPcmMsAB2uQxsplkbJr1VbzU5fBf5b1ohFBkabS7l0smEATymyAsca3n9KsOasJAtx+WbSB7Lf+bGr6g75xnohQejluwtpIZh/cD1GkG2n4ZMarSgcKpGawKdwpAGagk6x5xr+rrfnhYJhGyFIuQ8X6v6SSm93PctbqZ8tEi017SX3oqJcmXvY55QlPmovFe5fzXR7FPI429cqevYbR3ZVpZG386FNcTXf+mD79KZ37SH9/0L3gQvx9ErgbEEL0tVLgoJBIJkyj4i1uvCqL3SiNI0dybYZEoEtlpY7jEVt3WVMX+A3FVDs7m087b+GLRyu24hbzBTqsRawiBpCVpHysdItVBWHjvnWRnG79MnLl1DaGCexXqdS6z/TCMvrSlIk0ZTkRH/xzvIZ9iiRrDe5V0RtHK0hdAJQG54wXn+GGwjQfG9lByHwr7QRUd8ctN4q9UkwARn2/8yHoVCa96cZJtCpxy9M8QQI26gb3y2RqGDcdZb4CKFjxbNSjrL0/+erosfpTgOY1jDXKy4PRHjtUcv4HB8m8Vvoxszq50d+3OlBVrp9StHSC677B3iICZDwhkL0HTxMQavAEXw1TgSZTrP/FJkJG/8id0r3w7tCrBleDz1WfMmM1bzRHWazCfOpTvTjTdyn2oQlG4IwB7sRFe/gVUJ4bD/GNZF0aFOr7GKZZqpT2aOPur7nXCisUcTzGfhFVpaTWxUajVReJZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(39860400002)(396003)(376002)(366004)(186003)(83380400001)(6666004)(6486002)(30864003)(41300700001)(966005)(86362001)(33716001)(21490400003)(6636002)(54906003)(66476007)(66556008)(8676002)(478600001)(6512007)(38100700002)(4326008)(66946007)(6506007)(9686003)(44144004)(235185007)(316002)(2906002)(5660300002)(8936002)(82960400001)(26005)(6862004)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l0Rf31FQi3gT1BmLIykDxM62rVRBqqI+64bacKp8N4uqwHSypvdbs8YwEayY?=
 =?us-ascii?Q?1ifpZONaZaiXOhdnwB38J/2z68fvyTpEkaJIhikW/SnbCaI5TxNg+4BOa26E?=
 =?us-ascii?Q?zWsDfIaKRxgRgEwimrry5mGlI6PBgPRZjgRUm8me07dtltF4Lc0ZeU6zVkSo?=
 =?us-ascii?Q?FhHH47jaKxFzn8ne4tDvr51qkSI/PqxvQY3i65igdOB6y35bn+3YQ1/wFMRI?=
 =?us-ascii?Q?QUKsKrhrxqkxu/VJOrFVCmcarl90xvel1Gh3VNxbVDd+5B7qUpegj6jzKivt?=
 =?us-ascii?Q?ZRdiK+kcr0zyJ9h1A4AhmjAXPnjBluwpghLmzSVmOj2mEw6hUtqQ1uL00kb9?=
 =?us-ascii?Q?KdyCkILQEuJuUp3IHD7bMPiRlZlxN66g251sXk7/inAiHs/f2kVYAYVBxGc0?=
 =?us-ascii?Q?AnClOdJ0dCz5/3OnpZW56XlCV/bgUBwLdsOAx+AKFuNaZ619WAhc0R9L52vb?=
 =?us-ascii?Q?zUXg9MyW0tDXaqGCUj1JJxYZLCFylWUXFeaUoKoxhiXJZN11gfM+1O6wo6Co?=
 =?us-ascii?Q?fa4xix6FlPIt+yyErU6VWvTYty1P5ADyP4NDwjMoINCL6oI480H6mxZHjQHR?=
 =?us-ascii?Q?hCS7luMsEg/ZJyyXebrV1h6wHEPBZflTvAh+fEfSnyGi7vjqeYB8aezb5+b9?=
 =?us-ascii?Q?P7aaAngNzuZ8b7sZZUCkytkLTooHVHHaLLShGeohZPZ9Xr8ASf04KcdNPROK?=
 =?us-ascii?Q?fqu6K2HqKBCeouCiBY1shaLkmXfwYRksXZDk+sVoI1AW7E4t5/YnuSiX+ufx?=
 =?us-ascii?Q?IUrpVejPkfXomSxA6vsu/obhC7QP1jShVD7CHCxLxTz56WHUr3jl+9eGQPjF?=
 =?us-ascii?Q?onKeZWqLYf7/aP/EL3WKfPqUFYgbSmHqDGD2ed6N2acOurBoyn+n1qHiVH1f?=
 =?us-ascii?Q?yJ6NpdJ8Xu6Blu2QPm49WZGHbdu1kwl7RNG499r04FfiYDH1n4Zvily2b85d?=
 =?us-ascii?Q?KWgtcCi3BxiIPJZzqRWzSpiBShtsWBvWnipn6svYyWkp9Ee8hdPlBmFmEz09?=
 =?us-ascii?Q?Xmpg2Gxn7Bvv+WEcRCIsi7sQcLy31znhM4eLa08wug5hHYjjq7MLhePOckdM?=
 =?us-ascii?Q?tKxiUpE9y3Yahg/5kJeFFtB0bDpqAvXz+iO1aVFQBRWV3mMvMi2k84X8ptCq?=
 =?us-ascii?Q?h7HsOaMTcBMIy1JXP7Z88utnqTdyPMJGyK4G0nHkYbddVlLJrlkyW8sf8Pqn?=
 =?us-ascii?Q?VayJQzrHsJXkbcc2cbMZcHQvjhU42JCtLSdZwH8tPr+TAVF8x4BQ5OWQZIG5?=
 =?us-ascii?Q?Bp2Yy2V1h4DhOmhnXzyhJiGD6xW6kzaU4N1uUc8IaoFiOTOyLlDydJoDyK1R?=
 =?us-ascii?Q?7uStP7m6adVsEa7LT2DSWAkG3gnAzWfRlNC7mnZlPViNS9YlcRPUVTFXhFl/?=
 =?us-ascii?Q?RJ9qAol/aX69beQwTAf/2hYUQ3JwJGCWOj0xiZVU+Dwg5oOWfSJNi4bqvayT?=
 =?us-ascii?Q?kFOM99F4TVIwE5UgeLRtpwhKxNQyKErj4xQb72plnoqQjsr3Be5V38oYq99+?=
 =?us-ascii?Q?xB31cNvLCgTtt3XDXReGwpNOFD+t32n1o0T/VddrFhtteZpFf48JIAU1HcU2?=
 =?us-ascii?Q?SLdtSu3BLDca8lUqVT4ksKOLMZ/czWeLuA0ZjsDvDFsAMW9QbTcKVz7lQ3Fi?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e3df46-9ccd-49d1-0938-08da71313a7f
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 07:09:08.4303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEswvEEr7tY/nPdFYURVGO4X169oVJjWSSLLjAilkHbbJawPjzTWNHI/+BHMNqz47q/pnI4QV46XMPuB/ahd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--pn0N0EkwwXOpe2zG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-11):

commit: a37ddddd86037c896c702b4df416bc4e51b2a5a0 ("selftests: firmware: Add firmware upload selftests")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: kernel-selftests
version: kernel-selftests-x86_64-4cb0bec3-1_20220724
with following parameters:

	group: firmware
	ucode: 0xec

test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with 28G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[ 103.520572][ T2443] BUG: KASAN: use-after-free in firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
[  103.520579][ T2443] Read of size 8 at addr ffff8881e186c808 by task fw_upload.sh/2443
[  103.528481][  T395]
[  103.534696][ T2443]
[  103.534698][ T2443] CPU: 7 PID: 2443 Comm: fw_upload.sh Not tainted 5.18.0-rc2-00036-ga37ddddd8603 #1
[  103.534701][ T2443] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
[  103.534703][ T2443] Call Trace:
[  103.534705][ T2443]  <TASK>
[ 103.534707][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
[ 103.534713][ T2443] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 103.588011][ T2443] print_address_description+0x1f/0x200 
[ 103.594406][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
[ 103.600112][ T2443] print_report.cold (mm/kasan/report.c:430) 
[ 103.604782][ T2443] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:202 include/linux/atomic/atomic-instrumented.h:543 include/asm-generic/qspinlock.h:82 kernel/locking/spinlock_debug.c:115) 
[ 103.609624][ T2443] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493) 
[ 103.613861][ T2443] ? firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
[ 103.619561][ T2443] firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
[ 103.625091][ T2443] upload_unregister_store (lib/test_firmware.c:1060 lib/test_firmware.c:1321) 
[ 103.630377][ T2443] ? sysfs_file_ops (fs/sysfs/file.c:129) 
[ 103.635046][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
[ 103.640145][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[ 103.644642][ T2443] ? new_sync_read (fs/read_write.c:494) 
[ 103.649225][ T2443] ? ksys_write (fs/read_write.c:644) 
[ 103.653463][ T2443] ? rcu_read_unlock (include/linux/rcupdate.h:723 (discriminator 5)) 
[ 103.658057][ T2443] ? lock_is_held_type (kernel/locking/lockdep.c:5382 kernel/locking/lockdep.c:5684) 
[ 103.662909][ T2443] vfs_write (fs/read_write.c:591) 
[ 103.666984][ T2443] ksys_write (fs/read_write.c:644) 
[ 103.671057][ T2443] ? __ia32_sys_read (fs/read_write.c:634) 
[ 103.675645][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501) 
[ 103.682051][ T2443] ? syscall_enter_from_user_mode (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 kernel/entry/common.c:109) 
[ 103.687756][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.692010][ T2443] ? pick_file (fs/file.c:660) 
[ 103.696165][ T2443] ? do_raw_spin_unlock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/asm-generic/qspinlock.h:28 kernel/locking/spinlock_debug.c:100 kernel/locking/spinlock_debug.c:140) 
[ 103.701094][ T2443] ? syscall_exit_to_user_mode (kernel/entry/common.c:129 kernel/entry/common.c:296) 
[ 103.706539][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501) 
[ 103.712929][ T2443] ? do_syscall_64 (arch/x86/entry/common.c:87) 
[ 103.717343][ T2443] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4501) 
[ 103.723747][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  103.729451][ T2443] RIP: 0033:0x7f1020308f33
[ 103.733709][ T2443] Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
All code
========
   0:	8b 15 61 ef 0c 00    	mov    0xcef61(%rip),%edx        # 0xcef67
   6:	f7 d8                	neg    %eax
   8:	64 89 02             	mov    %eax,%fs:(%rdx)
   b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  12:	eb b7                	jmp    0xffffffffffffffcb
  14:	0f 1f 00             	nopl   (%rax)
  17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
  1e:	00 
  1f:	85 c0                	test   %eax,%eax
  21:	75 14                	jne    0x37
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall 
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 55                	ja     0x87
  32:	c3                   	retq   
  33:	0f 1f 40 00          	nopl   0x0(%rax)
  37:	48 83 ec 28          	sub    $0x28,%rsp
  3b:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 55                	ja     0x5d
   8:	c3                   	retq   
   9:	0f 1f 40 00          	nopl   0x0(%rax)
   d:	48 83 ec 28          	sub    $0x28,%rsp
  11:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
[  103.753040][ T2443] RSP: 002b:00007fffe4075988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  103.761244][ T2443] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1020308f33
[  103.769013][ T2443] RDX: 0000000000000003 RSI: 00005582df845b80 RDI: 0000000000000001
[  103.776791][ T2443] RBP: 00005582df845b80 R08: 00000000ffffffff R09: 0000000000000003
[  103.784561][ T2443] R10: 00005582df833c80 R11: 0000000000000246 R12: 0000000000000003
[  103.792328][ T2443] R13: 00007f10203d96a0 R14: 0000000000000003 R15: 00007f10203d98a0
[  103.800100][ T2443]  </TASK>
[  103.802957][ T2443]
[  103.805125][ T2443] Allocated by task 2443:
[ 103.809276][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
[ 103.813781][ T2443] __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:515 mm/kasan/common.c:524) 
[ 103.818190][ T2443] firmware_upload_register (drivers/base/firmware_loader/sysfs_upload.c:160) 
[ 103.824150][ T2443] upload_register_store (lib/test_firmware.c:1279) 
[ 103.829250][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
[ 103.834350][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[ 103.838846][ T2443] vfs_write (fs/read_write.c:591) 
[ 103.842910][ T2443] ksys_write (fs/read_write.c:644) 
[ 103.846975][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.851217][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  103.856932][ T2443]
[  103.859100][ T2443] Freed by task 2443:
[ 103.862907][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
[ 103.867415][ T2443] kasan_set_track (mm/kasan/common.c:45) 
[ 103.871822][ T2443] kasan_set_free_info (mm/kasan/generic.c:372) 
[ 103.876579][ T2443] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/common.c:328 mm/kasan/common.c:374) 
[ 103.881331][ T2443] slab_free_freelist_hook (mm/slub.c:1754) 
[ 103.886517][ T2443] kfree (mm/slub.c:3510 mm/slub.c:4552) 
[ 103.890156][ T2443] fw_dev_release (drivers/base/firmware_loader/sysfs.c:102) 
[ 103.894483][ T2443] device_release (drivers/base/core.c:2235) 
[ 103.898902][ T2443] kobject_cleanup (lib/kobject.c:677) 
[ 103.903492][ T2443] firmware_upload_unregister (drivers/base/firmware_loader/sysfs_upload.c:395) 
[ 103.909034][ T2443] upload_unregister_store (lib/test_firmware.c:1060 lib/test_firmware.c:1321) 
[ 103.914311][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
[ 103.919429][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[ 103.923927][ T2443] vfs_write (fs/read_write.c:591) 
[ 103.927990][ T2443] ksys_write (fs/read_write.c:644) 
[ 103.932054][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 103.936290][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  103.941992][ T2443]
[  103.944159][ T2443] Last potentially related work creation:
[ 103.949704][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
[ 103.954216][ T2443] __kasan_record_aux_stack (mm/kasan/generic.c:348) 
[ 103.959400][ T2443] insert_work (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
[ 103.963552][ T2443] __queue_work (kernel/workqueue.c:1520) 
[ 103.967888][ T2443] queue_work_on (kernel/workqueue.c:1546) 
[ 103.972141][ T2443] fw_upload_start (drivers/base/firmware_loader/sysfs_upload.c:263) 
[ 103.976723][ T2443] firmware_loading_store (drivers/base/firmware_loader/sysfs.c:213) 
[ 103.981910][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
[ 103.987022][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[ 103.991537][ T2443] vfs_write (fs/read_write.c:591) 
[ 103.995604][ T2443] ksys_write (fs/read_write.c:644) 
[ 103.999673][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 104.003930][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  104.009631][ T2443]
[  104.011800][ T2443] Second to last potentially related work creation:
[ 104.018219][ T2443] kasan_save_stack (mm/kasan/common.c:39) 
[ 104.022727][ T2443] __kasan_record_aux_stack (mm/kasan/generic.c:348) 
[ 104.027938][ T2443] insert_work (include/linux/instrumented.h:71 include/asm-generic/bitops/instrumented-non-atomic.h:134 kernel/workqueue.c:635 kernel/workqueue.c:642 kernel/workqueue.c:1361) 
[ 104.032101][ T2443] __queue_work (kernel/workqueue.c:1520) 
[ 104.036423][ T2443] queue_work_on (kernel/workqueue.c:1546) 
[ 104.040658][ T2443] fw_upload_start (drivers/base/firmware_loader/sysfs_upload.c:263) 
[ 104.045240][ T2443] firmware_loading_store (drivers/base/firmware_loader/sysfs.c:213) 
[ 104.050423][ T2443] kernfs_fop_write_iter (fs/kernfs/file.c:294) 
[ 104.055522][ T2443] new_sync_write (fs/read_write.c:505 (discriminator 1)) 
[ 104.060016][ T2443] vfs_write (fs/read_write.c:591) 
[ 104.064081][ T2443] ksys_write (fs/read_write.c:644) 
[ 104.068144][ T2443] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
[ 104.072381][ T2443] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:115) 
[  104.078083][ T2443]
[  104.080249][ T2443] The buggy address belongs to the object at ffff8881e186c800
[  104.080249][ T2443]  which belongs to the cache kmalloc-512 of size 512
[  104.094049][ T2443] The buggy address is located 8 bytes inside of
[  104.094049][ T2443]  512-byte region [ffff8881e186c800, ffff8881e186ca00)
[  104.106914][ T2443]
[  104.109084][ T2443] The buggy address belongs to the physical page:
[  104.115315][ T2443] page:0000000037a5888d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e1868
[  104.125336][ T2443] head:0000000037a5888d order:3 compound_mapcount:0 compound_pincount:0
[  104.133454][ T2443] flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[  104.141498][ T2443] raw: 0017ffffc0010200 ffffea0005491e00 dead000000000002 ffff888100042c80
[  104.149885][ T2443] raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
[  104.158274][ T2443] page dumped because: kasan: bad access detected
[  104.164492][ T2443]


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--pn0N0EkwwXOpe2zG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-5.18.0-rc2-00036-ga37ddddd8603"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.18.0-rc2 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.3.0-3) 11.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
CONFIG_SLAB_FREELIST_HARDENED=y
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_X86_SGX_KVM is not set
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
# CONFIG_DAMON_SYSFS is not set
CONFIG_DAMON_DBGFS=y
# CONFIG_DAMON_RECLAIM is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
CONFIG_NET_SCH_FQ_PIE=m
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
# CONFIG_CAN_SJA1000_PLATFORM is not set
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
CONFIG_NFC_NCI=m
# CONFIG_NFC_NCI_SPI is not set
# CONFIG_NFC_NCI_UART is not set
# CONFIG_NFC_HCI is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_VIRTUAL_NCI=m
# CONFIG_NFC_FDP is not set
# CONFIG_NFC_PN533_USB is not set
# CONFIG_NFC_PN533_I2C is not set
# CONFIG_NFC_MRVL_USB is not set
# CONFIG_NFC_ST_NCI_I2C is not set
# CONFIG_NFC_ST_NCI_SPI is not set
# CONFIG_NFC_NXP_NCI is not set
# CONFIG_NFC_S3FWRN5_I2C is not set
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=m
CONFIG_ZRAM_DEF_COMP_LZORLE=y
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP="lzo-rle"
CONFIG_ZRAM_WRITEBACK=y
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
CONFIG_IFB=m
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
CONFIG_BAREUDP=m
# CONFIG_GTP is not set
CONFIG_AMT=m
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
CONFIG_NET_VRF=y
# CONFIG_VSOCKMON is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
# CONFIG_MSE102X is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=y
CONFIG_BPF_LIRC_MODE2=y
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
CONFIG_RC_LOOPBACK=m
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_DP_HELPER=m
CONFIG_DRM_KMS_HELPER=m
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_I915_GVT_KVMGT is not set

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_LIB_RANDOM=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
CONFIG_UDMABUF=y
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
CONFIG_DMABUF_HEAPS_SYSTEM=y
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_RTL8723BS is not set
# CONFIG_R8712U is not set
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_LTE_GDM724X is not set
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
# CONFIG_IMA_DISABLE_HTABLE is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y
# CONFIG_MODULE_ALLOW_BTF_MISMATCH is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_VMLINUX_MAP is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
CONFIG_PROVE_NVDIMM_LOCKING=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_FPROBE=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
# CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_FTRACE_DIRECT_MULTI is not set
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_FPROBE is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_SCANF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--pn0N0EkwwXOpe2zG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export job_origin='kernel-selftests-bm.yaml'
	export queue='validate'
	export testbox='lkp-skl-d01'
	export commit='a37ddddd86037c896c702b4df416bc4e51b2a5a0'
	export branch='linus/master'
	export kconfig='x86_64-rhel-8.3-kselftests'
	export name='/cephfs/tmp/d20220712-22317-1171xyi/kernel-selftests-bm.yaml'
	export kernel_cmdline=
	export tbox_group='lkp-skl-d01'
	export submit_id='62e12efbedfe3c36c75d4cd0'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml'
	export id='912fd586afa13fb8bbdc411d9c13c5f1c3d9b790'
	export queuer_version='/zday/lkp'
	export model='Skylake'
	export nr_cpu=8
	export memory='28G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x50014ee20d26b072-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part1'
	export swap_partitions='/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part3'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part2'
	export brand='Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz'
	export cpu_info='skylake i7-6700'
	export bios_version='1.2.8'
	export need_kconfig_hw='{"E1000E"=>"y"}
SATA_AHCI
DRM_I915'
	export ucode='0xec'
	export bisect_dmesg=true
	export need_kconfig='{"FW_LOADER"=>"y, v4.18-rc1"}
{"FW_LOADER_USER_HELPER"=>"y, v4.18-rc1"}
{"IKCONFIG"=>"y"}
{"IKCONFIG_PROC"=>"y"}
TEST_FIRMWARE'
	export rootfs='debian-11.1-x86_64-20220510.cgz'
	export initrds='linux_headers
linux_selftests'
	export enqueue_time='2022-07-27 20:26:35 +0800'
	export compiler='gcc-11'
	export _id='62e12f13edfe3c36c75d4cd1'
	export _rt='/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3'
	export scheduler_version='/lkp/lkp/.src-20220727-192601'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-11.1-x86_64-20220510.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603
branch=linus/master
job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=a37ddddd86037c896c702b4df416bc4e51b2a5a0
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/modules.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/linux-selftests.cgz'
	export bm_initrd='/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220724.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-4cb0bec3-1_20220724.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.19.0-rc7-01460-gf0f8dcbe1856'
	export queue_cmdline_keys='branch
commit
kbuild_queue_analysis'
	export repeat_to=20
	export schedule_notify_address=
	export stop_repeat_if_found='dmesg.Kernel_panic-not_syncing:Fatal_exception'
	export kbuild_queue_analysis=1
	export kernel='/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603'
	export dequeue_time='2022-07-27 20:40:04 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='firmware' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env group='firmware' $LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--pn0N0EkwwXOpe2zG
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--pn0N0EkwwXOpe2zG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="kernel-selftests"

Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
Linux version 5.18.0-rc2-00036-ga37ddddd8603 (kbuild@6e59e9cc7ac2) (gcc-11 (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #1 SMP Wed Jul 27 18:03:44 CST 2022
Command line:  ip=::::lkp-skl-d01::dhcp root=/dev/ram0 RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603 branch=linus/master job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=a37ddddd86037c896c702b4df416bc4e51b2a5a0 max_uptime=2100 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err igno
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
signal: max sigframe size: 2032
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000100-0x000000000009c7ff] usable
BIOS-e820: [mem 0x000000000009c800-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x000000009916bfff] usable
BIOS-e820: [mem 0x000000009916c000-0x000000009916cfff] ACPI NVS
BIOS-e820: [mem 0x000000009916d000-0x00000000991b6fff] reserved
BIOS-e820: [mem 0x00000000991b7000-0x000000009920afff] usable
BIOS-e820: [mem 0x000000009920b000-0x0000000099a0bfff] reserved
BIOS-e820: [mem 0x0000000099a0c000-0x000000009f19efff] usable
BIOS-e820: [mem 0x000000009f19f000-0x000000009f3f6fff] reserved
BIOS-e820: [mem 0x000000009f3f7000-0x000000009f444fff] ACPI data
BIOS-e820: [mem 0x000000009f445000-0x000000009fabefff] ACPI NVS
BIOS-e820: [mem 0x000000009fabf000-0x000000009fffefff] reserved
BIOS-e820: [mem 0x000000009ffff000-0x000000009fffffff] usable
BIOS-e820: [mem 0x00000000a0000000-0x00000000a00fffff] reserved
BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x0000000759ffffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
SMBIOS 2.8 present.
DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
tsc: Detected 3400.000 MHz processor
tsc: Detected 3399.906 MHz TSC
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x75a000 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
last_pfn = 0xa0000 max_arch_pfn = 0x400000000
Scan for SMP in [mem 0x00000000-0x000003ff]
Scan for SMP in [mem 0x0009fc00-0x0009ffff]
Scan for SMP in [mem 0x000f0000-0x000fffff]
found SMP MP-table at [mem 0x000fcdd0-0x000fcddf]
mpc: fcba0-fcd54
Using GB pages for direct mapping
RAMDISK: [mem 0x721c30000-0x7533fffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
ACPI: XSDT 0x000000009F4170A0 0000BC (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: FACP 0x000000009F439760 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
ACPI: DSDT 0x000000009F4171E8 022574 (v02 DELL   CBX3     01072009 INTL 20120913)
ACPI: FACS 0x000000009FABEF80 000040
ACPI: APIC 0x000000009F439870 0000BC (v03 DELL   CBX3     01072009 AMI  00010013)
ACPI: FPDT 0x000000009F439930 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: FIDT 0x000000009F439978 00009C (v01 DELL   CBX3     01072009 AMI  00010013)
ACPI: MCFG 0x000000009F439A18 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
ACPI: HPET 0x000000009F439A58 000038 (v01 DELL   CBX3     01072009 AMI. 0005000B)
ACPI: SSDT 0x000000009F439A90 00036D (v01 SataRe SataTabl 00001000 INTL 20120913)
ACPI: SSDT 0x000000009F439E00 0053B2 (v02 SaSsdt SaSsdt   00003000 INTL 20120913)
ACPI: UEFI 0x000000009F43F1B8 000042 (v01                 00000000      00000000)
ACPI: LPIT 0x000000009F43F200 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
ACPI: SSDT 0x000000009F43F298 000248 (v02 INTEL  sensrhub 00000000 INTL 20120913)
ACPI: SSDT 0x000000009F43F4E0 002BAE (v02 INTEL  PtidDevc 00001000 INTL 20120913)
ACPI: SSDT 0x000000009F442090 000BE3 (v02 INTEL  Ther_Rvp 00001000 INTL 20120913)
ACPI: DBGP 0x000000009F442C78 000034 (v01 INTEL           00000000 MSFT 0000005F)
ACPI: DBG2 0x000000009F442CB0 000054 (v00 INTEL           00000000 MSFT 0000005F)
ACPI: SSDT 0x000000009F442D08 000613 (v02 INTEL  DELL__MT 00000000 INTL 20120913)
ACPI: SSDT 0x000000009F443320 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20120913)
ACPI: SLIC 0x000000009F444198 000176 (v03 DELL   CBX3     01072009 MSFT 00010013)
ACPI: ASF! 0x000000009F444310 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
ACPI: Reserving FACP table memory at [mem 0x9f439760-0x9f43986b]
ACPI: Reserving DSDT table memory at [mem 0x9f4171e8-0x9f43975b]
ACPI: Reserving FACS table memory at [mem 0x9fabef80-0x9fabefbf]
ACPI: Reserving APIC table memory at [mem 0x9f439870-0x9f43992b]
ACPI: Reserving FPDT table memory at [mem 0x9f439930-0x9f439973]
ACPI: Reserving FIDT table memory at [mem 0x9f439978-0x9f439a13]
ACPI: Reserving MCFG table memory at [mem 0x9f439a18-0x9f439a53]
ACPI: Reserving HPET table memory at [mem 0x9f439a58-0x9f439a8f]
ACPI: Reserving SSDT table memory at [mem 0x9f439a90-0x9f439dfc]
ACPI: Reserving SSDT table memory at [mem 0x9f439e00-0x9f43f1b1]
ACPI: Reserving UEFI table memory at [mem 0x9f43f1b8-0x9f43f1f9]
ACPI: Reserving LPIT table memory at [mem 0x9f43f200-0x9f43f293]
ACPI: Reserving SSDT table memory at [mem 0x9f43f298-0x9f43f4df]
ACPI: Reserving SSDT table memory at [mem 0x9f43f4e0-0x9f44208d]
ACPI: Reserving SSDT table memory at [mem 0x9f442090-0x9f442c72]
ACPI: Reserving DBGP table memory at [mem 0x9f442c78-0x9f442cab]
ACPI: Reserving DBG2 table memory at [mem 0x9f442cb0-0x9f442d03]
ACPI: Reserving SSDT table memory at [mem 0x9f442d08-0x9f44331a]
ACPI: Reserving SSDT table memory at [mem 0x9f443320-0x9f444192]
ACPI: Reserving SLIC table memory at [mem 0x9f444198-0x9f44430d]
ACPI: Reserving ASF! table memory at [mem 0x9f444310-0x9f4443b4]
mapped APIC to ffffffffff5fc000 (        fee00000)
No NUMA configuration found
Faking a node at [mem 0x0000000000000000-0x0000000759ffffff]
NODE_DATA(0) allocated [mem 0x759fd5000-0x759ffffff]
Zone ranges:
DMA      [mem 0x0000000000001000-0x0000000000ffffff]
DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x0000000759ffffff]
Device   empty
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000009bfff]
node   0: [mem 0x0000000000100000-0x000000009916bfff]
node   0: [mem 0x00000000991b7000-0x000000009920afff]
node   0: [mem 0x0000000099a0c000-0x000000009f19efff]
node   0: [mem 0x000000009ffff000-0x000000009fffffff]
node   0: [mem 0x0000000100000000-0x0000000759ffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x0000000759ffffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 100 pages in unavailable ranges
On node 0, zone DMA32: 75 pages in unavailable ranges
On node 0, zone DMA32: 2049 pages in unavailable ranges
On node 0, zone DMA32: 3680 pages in unavailable ranges
On node 0, zone Normal: 24576 pages in unavailable ranges
kasan: KernelAddressSanitizer initialized
Reserving Intel graphics memory at [mem 0xa2000000-0xa3ffffff]
ACPI: PM-Timer IO Port: 0x1808
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a701 base: 0xfed00000
[Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0xb2 (or later)
smpboot: Allowing 8 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fb000 (fec00000)
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009c000-0x0009cfff]
PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
PM: hibernation: Registered nosave memory: [mem 0x9916c000-0x9916cfff]
PM: hibernation: Registered nosave memory: [mem 0x9916d000-0x991b6fff]
PM: hibernation: Registered nosave memory: [mem 0x9920b000-0x99a0bfff]
PM: hibernation: Registered nosave memory: [mem 0x9f19f000-0x9f3f6fff]
PM: hibernation: Registered nosave memory: [mem 0x9f3f7000-0x9f444fff]
PM: hibernation: Registered nosave memory: [mem 0x9f445000-0x9fabefff]
PM: hibernation: Registered nosave memory: [mem 0x9fabf000-0x9fffefff]
PM: hibernation: Registered nosave memory: [mem 0xa0000000-0xa00fffff]
PM: hibernation: Registered nosave memory: [mem 0xa0100000-0xa1ffffff]
PM: hibernation: Registered nosave memory: [mem 0xa2000000-0xa3ffffff]
PM: hibernation: Registered nosave memory: [mem 0xa4000000-0xf7ffffff]
PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfdffffff]
PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[mem 0xa4000000-0xf7ffffff] available for PCI devices
Booting paravirtualized kernel on bare hardware
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
percpu: Embedded 69 pages/cpu s242784 r8192 d31648 u524288
pcpu-alloc: s242784 r8192 d31648 u524288 alloc=1*2097152
pcpu-alloc: [0] 0 1 2 3 [0] 4 5 6 7 
Fallback order for Node 0: 0 
Built 1 zonelists, mobility grouping on.  Total pages: 7195182
Policy zone: Normal
Kernel command line:  ip=::::lkp-skl-d01::dhcp root=/dev/ram0 RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603 branch=linus/master job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=a37ddddd86037c896c702b4df416bc4e51b2a5a0 max_uptime=2100 LKP_SERVER=internal-lkp-server nokaslr selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=e
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "nokaslr RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3 BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603 branch=linus/master job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml user=lkp ARCH=x86_64 kconfig=x86_64-rhel-8.3-kselftests commit=a37ddddd86037c896c702b4df416bc4e51b2a5a0 max_uptime=2100 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 prompt_ramdisk=0 vga=normal", will be passed to user space.
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
mem auto-init: stack:off, heap alloc:on, heap free:off
Stack Depot allocating hash table with memblock_alloc
Memory: 2662480K/29238204K available (47116K kernel code, 16302K rwdata, 15192K rodata, 3236K init, 15032K bss, 5464248K reserved, 0K cma-reserved)
random: get_random_u64 called from kmem_cache_open+0x22/0x3c0 with crng_init=0
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
Kernel/User page tables isolation: enabled
ftrace: allocating 51370 entries in 201 pages
ftrace: allocated 201 pages with 4 groups
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=8.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
NR_IRQS: 524544, nr_irqs: 2048, preallocated irqs: 16
spurious 8259A interrupt: IRQ7.
Console: colour VGA+ 80x25
printk: console [tty0] enabled
printk: console [ttyS0] enabled
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
printk: bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 6365 kB
memory used for stack traces: 4224 kB
per task-struct memory footprint: 1920 bytes
ACPI: Core revision 20211217
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
APIC: Switch to symmetric I/O mode setup
x2apic: IRQ remapping doesn't support X2APIC mode
masked ExtINT on CPU#0
ESR value before enabling vector: 0x00000040  after: 0x00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 2 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 2 pin 16 not connected
apic 2 pin 17 not connected
apic 2 pin 18 not connected
apic 2 pin 19 not connected
apic 2 pin 20 not connected
apic 2 pin 21 not connected
apic 2 pin 22 not connected
apic 2 pin 23 not connected
apic 2 pin 24 not connected
apic 2 pin 25 not connected
apic 2 pin 26 not connected
apic 2 pin 27 not connected
apic 2 pin 28 not connected
apic 2 pin 29 not connected
apic 2 pin 30 not connected
apic 2 pin 31 not connected
apic 2 pin 32 not connected
apic 2 pin 33 not connected
apic 2 pin 34 not connected
apic 2 pin 35 not connected
apic 2 pin 36 not connected
apic 2 pin 37 not connected
apic 2 pin 38 not connected
apic 2 pin 39 not connected
apic 2 pin 40 not connected
apic 2 pin 41 not connected
apic 2 pin 42 not connected
apic 2 pin 43 not connected
apic 2 pin 44 not connected
apic 2 pin 45 not connected
apic 2 pin 46 not connected
apic 2 pin 47 not connected
apic 2 pin 48 not connected
apic 2 pin 49 not connected
apic 2 pin 50 not connected
apic 2 pin 51 not connected
apic 2 pin 52 not connected
apic 2 pin 53 not connected
apic 2 pin 54 not connected
apic 2 pin 55 not connected
apic 2 pin 56 not connected
apic 2 pin 57 not connected
apic 2 pin 58 not connected
apic 2 pin 59 not connected
apic 2 pin 60 not connected
apic 2 pin 61 not connected
apic 2 pin 62 not connected
apic 2 pin 63 not connected
apic 2 pin 64 not connected
apic 2 pin 65 not connected
apic 2 pin 66 not connected
apic 2 pin 67 not connected
apic 2 pin 68 not connected
apic 2 pin 69 not connected
apic 2 pin 70 not connected
apic 2 pin 71 not connected
apic 2 pin 72 not connected
apic 2 pin 73 not connected
apic 2 pin 74 not connected
apic 2 pin 75 not connected
apic 2 pin 76 not connected
apic 2 pin 77 not connected
apic 2 pin 78 not connected
apic 2 pin 79 not connected
apic 2 pin 80 not connected
apic 2 pin 81 not connected
apic 2 pin 82 not connected
apic 2 pin 83 not connected
apic 2 pin 84 not connected
apic 2 pin 85 not connected
apic 2 pin 86 not connected
apic 2 pin 87 not connected
apic 2 pin 88 not connected
apic 2 pin 89 not connected
apic 2 pin 90 not connected
apic 2 pin 91 not connected
apic 2 pin 92 not connected
apic 2 pin 93 not connected
apic 2 pin 94 not connected
apic 2 pin 95 not connected
apic 2 pin 96 not connected
apic 2 pin 97 not connected
apic 2 pin 98 not connected
apic 2 pin 99 not connected
apic 2 pin 100 not connected
apic 2 pin 101 not connected
apic 2 pin 102 not connected
apic 2 pin 103 not connected
apic 2 pin 104 not connected
apic 2 pin 105 not connected
apic 2 pin 106 not connected
apic 2 pin 107 not connected
apic 2 pin 108 not connected
apic 2 pin 109 not connected
apic 2 pin 110 not connected
apic 2 pin 111 not connected
apic 2 pin 112 not connected
apic 2 pin 113 not connected
apic 2 pin 114 not connected
apic 2 pin 115 not connected
apic 2 pin 116 not connected
apic 2 pin 117 not connected
apic 2 pin 118 not connected
apic 2 pin 119 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3101f59f5e6, max_idle_ns: 440795259996 ns
Calibrating delay loop (skipped), value calculated using timer frequency.. 6799.81 BogoMIPS (lpj=3399906)
pid_max: default: 32768 minimum: 301
LSM: Security Framework initializing
landlock: Up and running.
Yama: becoming mindful.
Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
Poking KASLR using RDRAND RDTSC...
CPU0: Thermal monitoring enabled (TM1)
process: using mwait in idle threads
Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: Retpolines
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Speculative Store Bypass: Vulnerable
TAA: Vulnerable: Clear CPU buffers attempted, no microcode
SRBDS: Vulnerable: No microcode
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
Freeing SMP alternatives memory: 44K
smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1114
lapic timer already calibrated 23943
smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (family: 0x6, model: 0x5e, stepping: 0x3)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 3 and lim to 1.
cblist_init_generic: Setting shift to 3 and lim to 1.
Running RCU-tasks wait API self tests
Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
... version:                4
... bit width:              48
... generic registers:      4
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   3
... event mask:             000000070000000f
rcu: Hierarchical SRCU implementation.
NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
Callback from call_rcu_tasks_trace() invoked.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
#2
masked ExtINT on CPU#2
#3
masked ExtINT on CPU#3
#4
masked ExtINT on CPU#4
MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
#5
masked ExtINT on CPU#5
#6
masked ExtINT on CPU#6
#7
masked ExtINT on CPU#7
smp: Brought up 1 node, 8 CPUs
smpboot: Max logical packages: 1
smpboot: Total of 8 processors activated (54398.49 BogoMIPS)
Callback from call_rcu_tasks_rude() invoked.
node 0 deferred pages initialised in 52ms
devtmpfs: initialized
x86/mm: Memory block size: 128MB
ACPI: PM: Registering ACPI NVS region [mem 0x9916c000-0x9916cfff] (4096 bytes)
ACPI: PM: Registering ACPI NVS region [mem 0x9f445000-0x9fabefff] (6791168 bytes)
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
futex hash table entries: 2048 (order: 6, 262144 bytes, linear)
pinctrl core: initialized pinctrl subsystem
NET: Registered PF_NETLINK/PF_ROUTE protocol family
audit: initializing netlink subsys (disabled)
audit: type=2000 audit(1658925098.232:1): state=initialized audit_enabled=0 res=1
thermal_sys: Registered thermal governor 'fair_share'
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor menu
ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
PCI: Using configuration type 1 for base access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 8 ACPI AML tables successfully acquired and loaded
ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888103180000 0006E4 (v02 PmRef  Cpu0Ist  00003000 INTL 20120913)
ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF88810322C800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF8881021E6900 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888102363C00 000130 (v02 PmRef  HwpLvt   00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF88810324C000 0005AA (v02 PmRef  ApIst    00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888102363000 000119 (v02 PmRef  ApHwp    00003000 INTL 20120913)
ACPI: Dynamic OEM Table Load:
ACPI: SSDT 0xFFFF888102360400 000119 (v02 PmRef  ApCst    00003000 INTL 20120913)
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: Enabled 7 GPEs in block 00 to 7F
ACPI: PM: Power Resource [PG00]
ACPI: PM: Power Resource [PG01]
ACPI: PM: Power Resource [PG02]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [WRST]
ACPI: PM: Power Resource [FN00]
ACPI: PM: Power Resource [FN01]
ACPI: PM: Power Resource [FN02]
ACPI: PM: Power Resource [FN03]
ACPI: PM: Power Resource [FN04]
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xa4000000-0xf7ffffff window]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
pci_bus 0000:00: root bus resource [bus 00-3e]
pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit]
pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
pci 0000:00:14.0: reg 0x10: [mem 0xf7030000-0xf703ffff 64bit]
pci 0000:00:14.0: PME# supported from D3hot D3cold
pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
pci 0000:00:14.2: reg 0x10: [mem 0xf704e000-0xf704efff 64bit]
pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
pci 0000:00:16.0: reg 0x10: [mem 0xf704d000-0xf704dfff 64bit]
pci 0000:00:16.0: PME# supported from D3hot
pci 0000:00:17.0: [8086:a102] type 00 class 0x010601
pci 0000:00:17.0: reg 0x10: [mem 0xf7048000-0xf7049fff]
pci 0000:00:17.0: reg 0x14: [mem 0xf704c000-0xf704c0ff]
pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
pci 0000:00:17.0: reg 0x24: [mem 0xf704b000-0xf704b7ff]
pci 0000:00:17.0: PME# supported from D3hot
pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
pci 0000:00:1f.2: reg 0x10: [mem 0xf7044000-0xf7047fff]
pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
pci 0000:00:1f.3: reg 0x10: [mem 0xf7040000-0xf7043fff 64bit]
pci 0000:00:1f.3: reg 0x20: [mem 0xf7020000-0xf702ffff 64bit]
pci 0000:00:1f.3: PME# supported from D3hot D3cold
pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
pci 0000:00:1f.4: reg 0x10: [mem 0xf704a000-0xf704a0ff 64bit]
pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
pci 0000:00:1f.6: reg 0x10: [mem 0xf7000000-0xf701ffff]
pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
pci 0000:02:00.0: supports D1 D2
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci_bus 0000:03: extended config space not accessible
pci 0000:02:00.0: PCI bridge to [bus 03]
ACPI: PCI: Interrupt link LNKA configured for IRQ 7
ACPI: PCI: Interrupt link LNKA disabled
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKB disabled
ACPI: PCI: Interrupt link LNKC configured for IRQ 5
ACPI: PCI: Interrupt link LNKC disabled
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKD disabled
ACPI: PCI: Interrupt link LNKE configured for IRQ 7
ACPI: PCI: Interrupt link LNKE disabled
ACPI: PCI: Interrupt link LNKF configured for IRQ 3
ACPI: PCI: Interrupt link LNKF disabled
ACPI: PCI: Interrupt link LNKG configured for IRQ 4
ACPI: PCI: Interrupt link LNKG disabled
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link LNKH disabled
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009c800-0x0009ffff]
e820: reserve RAM buffer [mem 0x9916c000-0x9bffffff]
e820: reserve RAM buffer [mem 0x9920b000-0x9bffffff]
e820: reserve RAM buffer [mem 0x9f19f000-0x9fffffff]
e820: reserve RAM buffer [mem 0x75a000000-0x75bffffff]
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: bridge control possible
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
vgaarb: loaded
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
hpet0: 8 comparators, 64-bit 24.000000 MHz counter
clocksource: Switched to clocksource tsc-early
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
pnp: PnP ACPI init
system 00:00: [io  0x0a00-0x0a3f] has been reserved
system 00:00: [io  0x0a40-0x0a7f] has been reserved
pnp 00:01: [dma 0 disabled]
system 00:02: [io  0x0680-0x069f] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0xffff] has been reserved
system 00:02: [io  0x1800-0x18fe] has been reserved
system 00:02: [io  0x164e-0x164f] has been reserved
system 00:03: [io  0x0800-0x087f] has been reserved
system 00:05: [io  0x1854-0x1857] has been reserved
system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
system 00:06: [mem 0xfed90000-0xfed93fff] has been reserved
system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
system 00:06: [mem 0xff000000-0xffffffff] has been reserved
system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
system 00:06: [mem 0xf7fe0000-0xf7ffffff] has been reserved
system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
system 00:08: [io  0xff00-0xfffe] has been reserved
system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
pnp: PnP ACPI: found 10 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 16384 (order: 8, 1310720 bytes, linear)
TCP established hash table entries: 262144 (order: 9, 2097152 bytes, linear)
TCP bind hash table entries: 65536 (order: 10, 4718592 bytes, vmalloc hugepage)
TCP: Hash tables configured (established 262144 bind 65536)
MPTCP token hash table entries: 32768 (order: 9, 2883584 bytes, linear)
UDP hash table entries: 16384 (order: 9, 2621440 bytes, linear)
UDP-Lite hash table entries: 16384 (order: 9, 2621440 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
NET: Registered PF_XDP protocol family
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:02:00.0: PCI bridge to [bus 03]
pci 0000:00:1c.0: PCI bridge to [bus 02-03]
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xa4000000-0xf7ffffff window]
pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0x300 took 11991 usecs
PCI: CLS 0 bytes, default 64
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Trying to unpack rootfs image as initramfs...
software IO TLB: mapped [mem 0x000000009b19f000-0x000000009f19f000] (64MB)
Initialise system trusted keyrings
Key type blacklist registered
workingset: timestamp_bits=36 max_order=23 bucket_order=0
zbud: loaded
NET: Registered PF_ALG protocol family
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
test_firmware: interface ready
start plist test
end plist test
IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:1)
pcieport 0000:00:01.0: PME: Signaling with IRQ 120
pcieport 0000:00:1c.0: PME: Signaling with IRQ 121
pcieport 0000:00:1c.0: AER: enabled with IRQ 121
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
ACPI: button: Sleep Button [SLPB]
input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
ACPI: button: Power Button [PWRB]
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
ACPI: button: Power Button [PWRF]
thermal LNXTHERM:00: registered as thermal_zone0
ACPI: thermal: Thermal Zone [TZ00] (28 C)
thermal LNXTHERM:01: registered as thermal_zone1
ACPI: thermal: Thermal Zone [TZ01] (30 C)
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
lkdtm: No crash points registered, enable through debugfs
rdac: device handler registered
hp_sw: device handler registered
emc: device handler registered
alua: device handler registered
MACsec IEEE 802.1AE
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:1)
e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) f4:8e:38:7c:5b:de
e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
igb: Intel(R) Gigabit Ethernet Network Driver
igb: Copyright (c) 2007-2014 Intel Corporation.
Intel(R) 2.5G Ethernet Linux Driver
Copyright(c) 2018 Intel Corporation.
ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
ixgbe: Copyright (c) 1999-2016 Intel Corporation.
i40e: Intel(R) Ethernet Connection XL710 Network Driver
i40e: Copyright (c) 2013 - 2019 Intel Corporation.
usbcore: registered new interface driver r8152
usbcore: registered new interface driver asix
usbcore: registered new interface driver ax88179_178a
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
uhci_hcd: USB Universal Host Controller Interface driver
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.18
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: xHCI Host Controller
usb usb1: Manufacturer: Linux 5.18.0-rc2-00036-ga37ddddd8603 xhci-hcd
usb usb1: SerialNumber: 0000:00:14.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 16 ports detected
xhci_hcd 0000:00:14.0: xHCI Host Controller
xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.18
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: xHCI Host Controller
usb usb2: Manufacturer: Linux 5.18.0-rc2-00036-ga37ddddd8603 xhci-hcd
usb usb2: SerialNumber: 0000:00:14.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
tsc: Refined TSC clocksource calibration: 3408.000 MHz
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fd3cd494, max_idle_ns: 440795223879 ns
clocksource: Switched to clocksource tsc
usb: port power management may be unreliable
i8042: PNP: No PS/2 controller found.
mousedev: PS/2 mouse device common for all mice
rtc_cmos 00:04: RTC can wake from S4
rtc_cmos 00:04: registered as rtc0
rtc_cmos 00:04: setting system clock to 2022-07-27T12:31:43 UTC (1658925103)
rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
iTCO_vendor_support: vendor-support=0
intel_pstate: HWP enabled by BIOS
intel_pstate: Intel P-state driver initializing
intel_pstate: HWP enabled
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
drop_monitor: Initializing network drop monitor service
netem: version 1.3
ipip: IPv4 and MPLS over IPv4 tunneling driver
gre: GRE over IPv4 demultiplexor driver
ip_gre: GRE over IPv4 tunneling driver
Initializing XFRM netlink socket
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
ip6_gre: GRE over IPv6 tunneling driver
NET: Registered PF_PACKET protocol family
bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
8021q: 802.1Q VLAN Support v1.8
9pnet: Installing 9P2000 support
microcode: sig=0x506e3, pf=0x2, revision=0x74
microcode: Microcode Update Driver: v2.2.
IPI shorthand broadcast: enabled
... APIC ID:      00000000 (0)
... APIC VERSION: 01060015
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000008001000

number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 120.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00770020
.......     : max redirection entries: 77
.......     : PRQ implemented: 0
.......     : IO APIC version: 20
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, disabled, edge , high, V(81), IRR(0), S(0), physical, D(000C), M(2)
pin08, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0040), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(2)
pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(2)
pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin26, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0400), M(2)
pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin47, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin48, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin5e, disabled, edge , high, V(00), IRR(0), S(0), remapped, I(4144),  Z(2)
pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin63, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin67, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0288), M(2)
pin6c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin70, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin74, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin76, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ19 -> 0:19
.................................... done.
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
sched_clock: Marking stable (7692418102, 822521882)->(9775459805, -1260519821)
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 7609e72a30757ed9cf6d09ec3e1a09d563b48674'
zswap: loaded using pool lzo/zbud
page_owner is disabled
Key type ._fscrypt registered
Key type .fscrypt registered
Key type fscrypt-provisioning registered
Freeing initrd memory: 810816K
Key type encrypted registered
ima: No TPM chip found, activating TPM-bypass!
ima: Allocated hash algorithm: sha1
ima: No architecture policies found
IP-Config: Failed to open gretap0
IP-Config: Failed to open erspan0
Sending DHCP requests .
e1000e 0000:00:1f.6 eth0: NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
e1000e 0000:00:1f.6 eth0: 10/100 speed: disabling TSO
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
., OK
IP-Config: Got DHCP answer from 192.168.3.2, my address is 192.168.3.76
IP-Config: Complete:
device=eth0, hwaddr=f4:8e:38:7c:5b:de, ipaddr=192.168.3.76, mask=255.255.255.0, gw=192.168.3.200
host=lkp-skl-d01, domain=lkp.intel.com, nis-domain=(none)
bootserver=192.168.3.200, rootserver=192.168.3.200, rootpath=
nameserver0=192.168.3.200
Freeing unused kernel image (initmem) memory: 3236K
Write protecting the kernel read-only data: 65536k
Freeing unused kernel image (text/rodata gap) memory: 2032K
Freeing unused kernel image (rodata/data gap) memory: 1192K
Run /init as init process
with arguments:
/init
nokaslr
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603
branch=linus/master
job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3-kselftests
commit=a37ddddd86037c896c702b4df416bc4e51b2a5a0
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.


random: crng init done
intel_pmc_core INT33A1:00:  initialized
wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:1)
i801_smbus 0000:00:1f.4: SPD Write Disable is set
i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
mei_me 0000:00:16.0: enabling device (0000 -> 0002)
libata version 3.00 loaded.
iTCO_wdt iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
ahci 0000:00:17.0: version 3.0
ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst 
0m] Reached targ[   29.201312][  T266] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
scsi host0: ahci
RAPL PMU: hw unit of domain dram 2^-14 Joules
RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
Startin[   29.277367][  T242] ata1: SATA max UDMA/133 abar m2048@0xf704b000 port 0xf704b100 irq 125
i2c i2c-0: 4/4 memory slots populated (from DMI)
4 Metadata Check[   29.303828][  T252] i2c i2c-0: Successfully instantiated SPD at 0x50
.
i2c i2c-0: Successfully instantiated SPD at 0x51
i2c i2c-0: Successfully instantiated SPD at 0x52
Startin[   29.345894][  T252] i2c i2c-0: Successfully instantiated SPD at 0x53
r to synchronize[   29.364775][  T230] mei_wdt: probe of 0000:00:16.0-05b79a6f-4628-4d7f-899d-a91514cb32ab failed with error -22
IPMI message handler: version 39.2
Startin[   29.637501][  T310] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

ata4: SATA link down (SStatus 4 SControl 300)
ata2.00: ATA-9: INTEL SSDSC2BA800G4, G2010150, max UDMA/133
ata2.00: 1562824368 sectors, multi 1: LBA48 NCQ (depth 32)
ata1.00: ATA-10: WDC WD10EZEX-75WN4A0, 01.01A01, max UDMA/133
microcode: updated to revision 0xec, date = 2021-04-29
Startin[   29.698989][  T380] x86/CPU: CPU features have changed after loading microcode, but might not take effect.
rc.local Compati[   29.710175][  T380] x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
microcode: Reload completed, microcode revision: 0xec
r[   29.736736][  T301] ata1.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
c.local[388]: mk[   29.746367][  T301] ata1.00: Features: NCQ-prio
File exists
Startin[   29.774347][    T8] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2BA80 0150 PQ: 0 ANSI: 5
ipmi device interface
LKP: ttyS0: 380: Kernel tests: Boot OK!
LKP: ttyS0: 380: HOSTNAME lkp-skl-d01, MAC 4e:4a:60:2e:0b:be, kernel 5.18.0-rc2-00036-ga37ddddd8603 1
scsi 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Attached scsi generic sg1 type 0
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
See 'systemctl status openipmi.service' for details.
ata2.00: Enabling discard_zeroes_data
sd 1:0:0:0: [sdb] 1562824368 512-byte logical blocks: (800 GB/745 GiB)
sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
sd 1:0:0:0: [sdb] 4096-byte physical blocks
sd 0:0:0:0: [sda] 4096-byte physical blocks
sd 1:0:0:0: [sdb] Write Protect is off
sd 0:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
ata2.00: Enabling discard_zeroes_data
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sdb: sdb1 sdb2 sdb3
ata2.00: Enabling discard_zeroes_data
sd 1:0:0:0: [sdb] Attached SCSI disk
sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
i915 0000:00:02.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
intel_rapl_common: Found RAPL domain package
i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
intel_rapl_common: Found RAPL domain core
i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
intel_rapl_common: Found RAPL domain uncore
intel_rapl_common: Found RAPL domain dram
i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 1
raid6: avx2x4   gen() 24023 MB/s
raid6: avx2x2   gen() 27273 MB/s
raid6: avx2x1   gen() 14181 MB/s
ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
raid6: using algorithm avx2x2 gen() 27273 MB/s
raid6: .... xor() 11230 MB/s, rmw enabled
raid6: using avx2x2 recovery algorithm
input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
xor: automatically using best checksumming function   avx       
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
Btrfs loaded, crc32c=crc32c-intel, zoned=no, fsverity=no
BTRFS: device fsid c6c28646-50db-4d6e-94de-bb78e6d84814 devid 1 transid 34911 /dev/sdb2 scanned by systemd-udevd (252)
LKP: stdout: 380: Kernel tests: Boot OK!

LKP: stdout: 380: HOSTNAME lkp-skl-d01, MAC 4e:4a:60:2e:0b:be, kernel 5.18.0-rc2-00036-ga37ddddd8603 1

install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb

/opt/deb/fonts-lato_2.0-2.1_all.deb

/opt/deb/libssl1.1_1.1.1n-0+deb11u3_amd64.deb

/opt/deb/uuid-runtime_2.36.1-8+deb11u1_amd64.deb

/opt/deb/traceroute_1%3a2.1.0-2+b1_amd64.deb

/opt/deb/ebtables_2.0.11-4+b1_amd64.deb

/opt/deb/libatomic1_10.2.1-6_amd64.deb

/opt/deb/libquadmath0_10.2.1-6_amd64.deb

/opt/deb/libgcc-10-dev_10.2.1-6_amd64.deb

/opt/deb/gcc-10_10.2.1-6_amd64.deb

/opt/deb/gcc_4%3a10.2.1-1_amd64.deb

/opt/deb/g++-10_10.2.1-6_amd64.deb

/opt/deb/g++_4%3a10.2.1-1_amd64.deb

/opt/deb/lib32gcc-s1_10.2.1-6_amd64.deb

/opt/deb/libx32gcc-s1_10.2.1-6_amd64.deb

/opt/deb/lib32atomic1_10.2.1-6_amd64.deb

/opt/deb/libx32atomic1_10.2.1-6_amd64.deb

/opt/deb/lib32quadmath0_10.2.1-6_amd64.deb

/opt/deb/libx32quadmath0_10.2.1-6_amd64.deb

/opt/deb/lib32gcc-10-dev_10.2.1-6_amd64.deb

/opt/deb/libx32gcc-10-dev_10.2.1-6_amd64.deb

/opt/deb/gcc-10-multilib_10.2.1-6_amd64.deb

/opt/deb/gcc-multilib_4%3a10.2.1-1_amd64.deb

/opt/deb/libasound2-data_1.2.4-1.1_all.deb

/opt/deb/libdeflate0_1.7-1_amd64.deb

/opt/deb/libdpkg-perl_1.20.11_all.deb

/opt/deb/libwireshark-data_3.4.10-0+deb11u1_all.deb

/opt/deb/netcat-openbsd_1.217-3_amd64.deb

/opt/deb/python3-six_1.16.0-2_all.deb

/opt/deb/openvswitch-common_2.15.0+ds1-2+deb11u1_amd64.deb

/opt/deb/openvswitch-switch_2.15.0+ds1-2+deb11u1_amd64.deb

/opt/deb/python3-roman_2.0.0-5_all.deb

/opt/deb/python3-docutils_0.16+dfsg-4_all.deb

/opt/deb/python3-scapy_2.4.4-4_all.deb

/opt/deb/socat_1.7.4.1-3_amd64.deb

Selecting previously unselected package ntpdate.

(Reading database ... 16440 files and directories currently installed.)

Preparing to unpack .../ntpdate_1%3a4.2.8p15+dfsg-1_amd64.deb ...

Unpacking ntpdate (1:4.2.8p15+dfsg-1) ...

Selecting previously unselected package fonts-lato.

Preparing to unpack .../deb/fonts-lato_2.0-2.1_all.deb ...

Unpacking fonts-lato (2.0-2.1) ...

Preparing to unpack .../libssl1.1_1.1.1n-0+deb11u3_amd64.deb ...

Unpacking libssl1.1:amd64 (1.1.1n-0+deb11u3) over (1.1.1n-0+deb11u1) ...

Selecting previously unselected package uuid-runtime.

Preparing to unpack .../uuid-runtime_2.36.1-8+deb11u1_amd64.deb ...

Unpacking uuid-runtime (2.36.1-8+deb11u1) ...

Selecting previously unselected package traceroute.

Preparing to unpack .../traceroute_1%3a2.1.0-2+b1_amd64.deb ...

Unpacking traceroute (1:2.1.0-2+b1) ...

Selecting previously unselected package ebtables.

Preparing to unpack .../ebtables_2.0.11-4+b1_amd64.deb ...

Unpacking ebtables (2.0.11-4+b1) ...

Selecting previously unselected package libatomic1:amd64.

Preparing to unpack .../libatomic1_10.2.1-6_amd64.deb ...

Unpacking libatomic1:amd64 (10.2.1-6) ...

Selecting previously unselected package libquadmath0:amd64.

Preparing to unpack .../libquadmath0_10.2.1-6_amd64.deb ...

Unpacking libquadmath0:amd64 (10.2.1-6) ...

Selecting previously unselected package libgcc-10-dev:amd64.

Preparing to unpack .../libgcc-10-dev_10.2.1-6_amd64.deb ...

Unpacking libgcc-10-dev:amd64 (10.2.1-6) ...

Selecting previously unselected package gcc-10.

Preparing to unpack .../deb/gcc-10_10.2.1-6_amd64.deb ...

Unpacking gcc-10 (10.2.1-6) ...

Selecting previously unselected package gcc.

Preparing to unpack .../deb/gcc_4%3a10.2.1-1_amd64.deb ...

Unpacking gcc (4:10.2.1-1) ...

Selecting previously unselected package g++-10.

Preparing to unpack .../deb/g++-10_10.2.1-6_amd64.deb ...

Unpacking g++-10 (10.2.1-6) ...

Selecting previously unselected package g++.

Preparing to unpack .../deb/g++_4%3a10.2.1-1_amd64.deb ...

Unpacking g++ (4:10.2.1-1) ...

Selecting previously unselected package lib32gcc-s1.

Preparing to unpack .../lib32gcc-s1_10.2.1-6_amd64.deb ...

Unpacking lib32gcc-s1 (10.2.1-6) ...

Selecting previously unselected package libx32gcc-s1.

Preparing to unpack .../libx32gcc-s1_10.2.1-6_amd64.deb ...

Unpacking libx32gcc-s1 (10.2.1-6) ...

Selecting previously unselected package lib32atomic1.

Preparing to unpack .../lib32atomic1_10.2.1-6_amd64.deb ...

Unpacking lib32atomic1 (10.2.1-6) ...

Selecting previously unselected package libx32atomic1.

Preparing to unpack .../libx32atomic1_10.2.1-6_amd64.deb ...

Unpacking libx32atomic1 (10.2.1-6) ...

Selecting previously unselected package lib32quadmath0.

Preparing to unpack .../lib32quadmath0_10.2.1-6_amd64.deb ...

Unpacking lib32quadmath0 (10.2.1-6) ...

Selecting previously unselected package libx32quadmath0.

Preparing to unpack .../libx32quadmath0_10.2.1-6_amd64.deb ...

Unpacking libx32quadmath0 (10.2.1-6) ...

Selecting previously unselected package lib32gcc-10-dev.

Preparing to unpack .../lib32gcc-10-dev_10.2.1-6_amd64.deb ...

Unpacking lib32gcc-10-dev (10.2.1-6) ...

Selecting previously unselected package libx32gcc-10-dev.

0m] Listening on[   39.405726][  T395] 
aemon activation[   39.418047][  T395] 
Selecting previously unselected package gcc-10-multilib.

1;39mSystem Logg[   39.439848][  T395] 


Selecting previously unselected package gcc-multilib.

Preparing to unpack .../gcc-multilib_4%3a10.2.1-1_amd64.deb ...

Unpacking gcc-multilib (4:10.2.1-1) ...

Selecting previously unselected package libasound2-data.

Preparing to unpack .../libasound2-data_1.2.4-1.1_all.deb ...

Unpacking libasound2-data (1.2.4-1.1) ...

Selecting previously unselected package libdeflate0:amd64.

Preparing to unpack .../libdeflate0_1.7-1_amd64.deb ...

Unpacking libdeflate0:amd64 (1.7-1) ...

Selecting previously unselected package libdpkg-perl.

Preparing to unpack .../libdpkg-perl_1.20.11_all.deb ...

Unpacking libdpkg-perl (1.20.11) ...

Selecting previously unselected package libwireshark-data.

Preparing to unpack .../libwireshark-data_3.4.10-0+deb11u1_all.deb ...

Unpacking libwireshark-data (3.4.10-0+deb11u1) ...

Selecting previously unselected package netcat-openbsd.

Preparing to unpack .../netcat-openbsd_1.217-3_amd64.deb ...

Unpacking netcat-openbsd (1.217-3) ...

Selecting previously unselected package python3-six.

Preparing to unpack .../python3-six_1.16.0-2_all.deb ...

Unpacking python3-six (1.16.0-2) ...

Selecting previously unselected package openvswitch-common.

Preparing to unpack .../openvswitch-common_2.15.0+ds1-2+deb11u1_amd64.deb ...

Unpacking openvswitch-common (2.15.0+ds1-2+deb11u1) ...

Selecting previously unselected package openvswitch-switch.

Preparing to unpack .../openvswitch-switch_2.15.0+ds1-2+deb11u1_amd64.deb ...

Unpacking openvswitch-switch (2.15.0+ds1-2+deb11u1) ...

Selecting previously unselected package python3-roman.

Preparing to unpack .../python3-roman_2.0.0-5_all.deb ...

Unpacking python3-roman (2.0.0-5) ...

Selecting previously unselected package python3-docutils.

Preparing to unpack .../python3-docutils_0.16+dfsg-4_all.deb ...

Unpacking python3-docutils (0.16+dfsg-4) ...

Selecting previously unselected package python3-scapy.

Preparing to unpack .../python3-scapy_2.4.4-4_all.deb ...

Unpacking python3-scapy (2.4.4-4) ...

Selecting previously unselected package socat.

Preparing to unpack .../deb/socat_1.7.4.1-3_amd64.deb ...

Unpacking socat (1.7.4.1-3) ...

Setting up fonts-lato (2.0-2.1) ...

Setting up libssl1.1:amd64 (1.1.1n-0+deb11u3) ...

Setting up uuid-runtime (2.36.1-8+deb11u1) ...

Adding group `uuidd' (GID 111) ...

Done.

Warning: The home dir /run/uuidd you specified can't be accessed: No such file or directory

Adding system user `uuidd' (UID 107) ...

Adding new user `uuidd' (UID 107) with group `uuidd' ...

Not creating home directory `/run/uuidd'.

Setting up traceroute (1:2.1.0-2+b1) ...

update-alternatives: using /usr/bin/traceroute.db to provide /usr/bin/traceroute (traceroute) in auto mode

update-alternatives: using /usr/bin/traceroute6.db to provide /usr/bin/traceroute6 (traceroute6) in auto mode

update-alternatives: using /usr/bin/lft.db to provide /usr/bin/lft (lft) in auto mode

update-alternatives: using /usr/bin/traceproto.db to provide /usr/bin/traceproto (traceproto) in auto mode

update-alternatives: using /usr/sbin/tcptraceroute.db to provide /usr/sbin/tcptraceroute (tcptraceroute) in auto mode

Setting up ebtables (2.0.11-4+b1) ...

update-alternatives: using /usr/sbin/ebtables-legacy to provide /usr/sbin/ebtables (ebtables) in auto mode

Setting up libatomic1:amd64 (10.2.1-6) ...

Setting up libquadmath0:amd64 (10.2.1-6) ...

Setting up libasound2-data (1.2.4-1.1) ...

Setting up libdeflate0:amd64 (1.7-1) ...

Setting up libdpkg-perl (1.20.11) ...

Setting up libwireshark-data (3.4.10-0+deb11u1) ...

Setting up netcat-openbsd (1.217-3) ...

update-alternatives: using /bin/nc.openbsd to provide /bin/nc (nc) in auto mode

Setting up python3-six (1.16.0-2) ...

Setting up python3-roman (2.0.0-5) ...

Setting up socat (1.7.4.1-3) ...

Setting up ntpdate (1:4.2.8p15+dfsg-1) ...

Setting up lib32gcc-s1 (10.2.1-6) ...

Setting up libx32gcc-s1 (10.2.1-6) ...

Setting up lib32atomic1 (10.2.1-6) ...

Setting up libx32atomic1 (10.2.1-6) ...

Setting up lib32quadmath0 (10.2.1-6) ...

Setting up libx32quadmath0 (10.2.1-6) ...

Setting up lib32gcc-10-dev (10.2.1-6) ...

Setting up libx32gcc-10-dev (10.2.1-6) ...

Setting up gcc-10-multilib (10.2.1-6) ...

Setting up gcc-multilib (4:10.2.1-1) ...

Setting up openvswitch-common (2.15.0+ds1-2+deb11u1) ...

update-alternatives: using /usr/lib/openvswitch-common/ovs-vswitchd to provide /usr/sbin/ovs-vswitchd (ovs-vswitchd) in auto mode

Setting up openvswitch-switch (2.15.0+ds1-2+deb11u1) ...

openvswitch: Open vSwitch switching datapath
Setting up python3-docutils (0.16+dfsg-4) ...

update-alternatives: using /usr/share/docutils/scripts/python3/rst-buildhtml to provide /usr/bin/rst-buildhtml (rst-buildhtml) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2html to provide /usr/bin/rst2html (rst2html) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2html4 to provide /usr/bin/rst2html4 (rst2html4) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2html5 to provide /usr/bin/rst2html5 (rst2html5) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2latex to provide /usr/bin/rst2latex (rst2latex) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2man to provide /usr/bin/rst2man (rst2man) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2odt to provide /usr/bin/rst2odt (rst2odt) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2odt_prepstyles to provide /usr/bin/rst2odt_prepstyles (rst2odt_prepstyles) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2pseudoxml to provide /usr/bin/rst2pseudoxml (rst2pseudoxml) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2s5 to provide /usr/bin/rst2s5 (rst2s5) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2xetex to provide /usr/bin/rst2xetex (rst2xetex) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rst2xml to provide /usr/bin/rst2xml (rst2xml) in auto mode

update-alternatives: using /usr/share/docutils/scripts/python3/rstpep2html to provide /usr/bin/rstpep2html (rstpep2html) in auto mode

Setting up python3-scapy (2.4.4-4) ...

Setting up libgcc-10-dev:amd64 (10.2.1-6) ...

Setting up gcc-10 (10.2.1-6) ...

Setting up gcc (4:10.2.1-1) ...

Setting up g++-10 (10.2.1-6) ...

Setting up g++ (4:10.2.1-1) ...

update-alternatives: using /usr/bin/g++ to provide /usr/bin/c++ (c++) in auto mode

Processing triggers for libc-bin (2.31-13+deb11u3) ...

27 Jul 12:42:31 ntpdate[1216]: step time server 192.168.1.200 offset +603.165387 sec

BTRFS info (device sdb2): flagging fs with big metadata feature
BTRFS info (device sdb2): disk space caching is enabled
BTRFS info (device sdb2): has skinny extents
BTRFS info (device sdb2): enabling ssd optimizations
LKP: ttyS0: 380:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml
LKP: stdout: 380:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml

RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3

job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml

x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x00000000-0x00000fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
x86/PAT: bmc-watchdog:1308 map pfn expected mapping type uncached-minus for [mem 0x9f417000-0x9f417fff], got write-back
result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/3, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml

test_firmware: loading 'test-firmware.bin'
test_firmware: loaded: 8
test_firmware: loading 'test-firmware.bin'
misc test_firmware: Direct firmware load for test-firmware.bin failed with error -2
test_firmware: load of 'test-firmware.bin' failed: -2
test_firmware: loading ''
test_firmware: load of '' failed: -22
test_firmware: loading ''
test_firmware: failed to async load firmware
test_firmware: loading 'nope-test-firmware.bin'
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
Ignoring firmware sysfs fallback due to sysctl knob
test_firmware: load of 'nope-test-firmware.bin' failed: -2
test_firmware: loading 'test-firmware.bin'
test_firmware: loaded: 9
test_firmware: loading 'test-firmware.bin'
test_firmware: loaded: 9
test_firmware: reset
test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: #0: loaded 9
test_firmware: #1: loaded 9
test_firmware: #2: loaded 9
test_firmware: #3: loaded 9
test_firmware: reset
test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: #0: loaded 9
test_firmware: #1: loaded 9
test_firmware: #2: loaded 9
test_firmware: #3: loaded 9
test_firmware: reset
test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-14023-mz8ozj-3.yaml&job_state=running -O /dev/null

test_firmware: #0: loaded 9
target ucode: 0xec

test_firmware: #1: loaded 9
current_version: ec, target_version: ec

test_firmware: #2: loaded 9
KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-a37ddddd86037c896c702b4df416bc4e51b2a5a0

test_firmware: #3: loaded 9
2022-07-27 12:42:34 ln -sf /usr/bin/clang
test_firmware: reset

test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
2022-07-27 12:42:34 ln -sf /usr/bin/llc
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9

2022-07-27 12:42:34 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
test_firmware: #0: loaded 9

test_firmware: #1: loaded 9
2022-07-27 12:42:34 mv /lib/udev/rules.d/50-firmware.rules .

test_firmware: #2: loaded 9
2022-07-27 12:42:34 /etc/init.d/udev restart

test_firmware: #3: loaded 9
Restarting udev (via systemctl): udev.service.
test_firmware: reset

2022-07-27 12:42:34 make -C firmware
test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times

make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a37ddddd86037c896c702b4df416bc4e51b2a5a0/tools/testing/selftests/firmware'
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9

test_firmware: #0: loaded 9
gcc -Wall -O2    fw_namespace.c  -o /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a37ddddd86037c896c702b4df416bc4e51b2a5a0/tools/testing/selftests/firmware/fw_namespace
test_firmware: #1: loaded 9

test_firmware: #2: loaded 9
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a37ddddd86037c896c702b4df416bc4e51b2a5a0/tools/testing/selftests/firmware'

test_firmware: #3: loaded 9
2022-07-27 12:42:34 make run_tests -C firmware

test_firmware: reset
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-a37ddddd86037c896c702b4df416bc4e51b2a5a0/tools/testing/selftests/firmware'

test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times
TAP version 13
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9

test_firmware: #0: loaded 9
1..1

test_firmware: #1: loaded 9
# selftests: firmware: fw_run_tests.sh

test_firmware: #2: loaded 9
# Running namespace test: 

test_firmware: #3: loaded 9
# Testing with firmware in parent namespace (assumed to be same file system as PID1)

test_firmware: reset
# Testing with firmware in child namespace
test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times

test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
# OK
test_firmware: #0: loaded 9

test_firmware: #1: loaded 9
# -----------------------------------------------------

test_firmware: #2: loaded 9
# Running kernel configuration test 1 -- rare

test_firmware: #3: loaded 9
# Emulates:
test_firmware: reset

# CONFIG_FW_LOADER=y
test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times

# CONFIG_FW_LOADER_USER_HELPER=n
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9

test_firmware: #0: loaded 9
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK=n

test_firmware: #1: loaded 9
# ./fw_filesystem.sh: filesystem loading works

test_firmware: #2: loaded 9
# ./fw_filesystem.sh: async filesystem loading works

test_firmware: #3: loaded 9
# ./fw_filesystem.sh: firmware loading: platform trigger not present, ignoring test
test_firmware: reset

test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times
# 
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9

test_firmware: #0: loaded 9
# Testing with the file present...

test_firmware: #1: loaded 9
# Batched request_firmware() normal try #1: OK

test_firmware: #2: loaded 9
# Batched request_firmware() normal try #2: OK

test_firmware: #3: loaded 9
# Batched request_firmware() normal try #3: OK

test_firmware: reset
# Batched request_firmware() normal try #4: OK
test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times

# Batched request_firmware() normal try #5: OK
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9

# Batched request_firmware_into_buf() normal try #1: OK
test_firmware: #0: loaded 9

test_firmware: #1: loaded 9
# Batched request_firmware_into_buf() normal try #2: OK

test_firmware: #2: loaded 9
# Batched request_firmware_into_buf() normal try #3: OK

test_firmware: #3: loaded 9
# Batched request_firmware_into_buf() normal try #4: OK

test_firmware: reset
# Batched request_firmware_into_buf() normal try #5: OK
test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times

test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: reset
# Batched request_firmware_direct() normal try #1: OK

test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: reset
# Batched request_firmware_direct() normal try #2: OK

test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: reset
# Batched request_firmware_direct() normal try #3: OK

test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: reset
# Batched request_firmware_direct() normal try #4: OK

test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
# Batched request_firmware_direct() normal try #5: OK

test_firmware: reset
test_firmware: batched loading 'test-firmware.bin' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) normal try #1: OK

test_firmware: batched loading 'test-firmware.bin' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) normal try #2: OK

test_firmware: batched loading 'test-firmware.bin' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) normal try #3: OK

test_firmware: batched loading 'test-firmware.bin' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) normal try #4: OK

test_firmware: batched loading 'test-firmware.bin' custom fallback mechanism 4 times
# Batched request_firmware_nowait(uevent=true) normal try #5: OK

test_firmware: reset
test_firmware: batched loading 'tmp.AwMireEwow' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) normal try #1: OK

test_firmware: batched loading 'tmp.RnRIYriUkP' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) normal try #2: OK

test_firmware: batched loading 'tmp.a5O48pGDil' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) normal try #3: OK

test_firmware: batched loading 'tmp.K6HmNg2B67' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) normal try #4: OK

test_firmware: batched loading 'tmp.IiMB46Kvqh' custom fallback mechanism 4 times
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) normal try #5: OK

test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times
test_firmware: #0: batched sync loaded 9
test_firmware: #1: batched sync loaded 9
test_firmware: #2: batched sync loaded 9
test_firmware: #3: batched sync loaded 9
test_firmware: #0: loaded 9
test_firmware: #1: loaded 9
test_firmware: #2: loaded 9
test_firmware: #3: loaded 9
test_firmware: reset
# Test request_partial_firmware_into_buf() off=0 size=10: OK

test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times
test_firmware: #0: batched sync loaded 5
test_firmware: #1: batched sync loaded 5
test_firmware: #2: batched sync loaded 5
test_firmware: #3: batched sync loaded 5
test_firmware: #0: loaded 5
test_firmware: #1: loaded 5
test_firmware: #2: loaded 5
test_firmware: #3: loaded 5
test_firmware: reset
# Test request_partial_firmware_into_buf() off=0 size=5: OK

test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times
test_firmware: #0: batched sync loaded 6
test_firmware: #1: batched sync loaded 6
test_firmware: #2: batched sync loaded 6
test_firmware: #3: batched sync loaded 6
test_firmware: #0: loaded 6
test_firmware: #1: loaded 6
test_firmware: #2: loaded 6
test_firmware: #3: loaded 6
test_firmware: reset
# Test request_partial_firmware_into_buf() off=1 size=6: OK

test_firmware: batched sync firmware loading 'test-firmware-into-buf.bin' 4 times
test_firmware: #0: batched sync loaded 7
test_firmware: #1: batched sync loaded 7
test_firmware: #2: batched sync loaded 7
test_firmware: #3: batched sync loaded 7
test_firmware: #0: loaded 7
test_firmware: #1: loaded 7
test_firmware: #2: loaded 7
test_firmware: #3: loaded 7
# Test request_partial_firmware_into_buf() off=2 size=10: OK

test_firmware: reset
# 
test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times

misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
# Testing with the file missing...
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2

test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware() nofile try #1: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware() nofile try #2: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware() nofile try #3: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware() nofile try #4: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
# Batched request_firmware() nofile try #5: OK

test_firmware: reset
test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware_into_buf() nofile try #1: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware_into_buf() nofile try #2: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware_into_buf() nofile try #3: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Batched request_firmware_into_buf() nofile try #4: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
# Batched request_firmware_into_buf() nofile try #5: OK

test_firmware: reset
test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: reset
# Batched request_firmware_direct() nofile try #1: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: reset
# Batched request_firmware_direct() nofile try #2: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: reset
# Batched request_firmware_direct() nofile try #3: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
test_firmware: reset
# Batched request_firmware_direct() nofile try #4: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #2: batched sync load failed: -2
test_firmware: #3: batched sync load failed: -2
# Batched request_firmware_direct() nofile try #5: OK

test_firmware: reset
test_firmware: batched loading 'nope-test-firmware.bin' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) nofile try #1: OK

test_firmware: batched loading 'nope-test-firmware.bin' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) nofile try #2: OK

test_firmware: batched loading 'nope-test-firmware.bin' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: reset
test_firmware: batched loading 'nope-test-firmware.bin' custom fallback mechanism 4 times
# Batched request_firmware_nowait(uevent=true) nofile try #3: OK

misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=true) nofile try #4: OK

test_firmware: batched loading 'nope-test-firmware.bin' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
# Batched request_firmware_nowait(uevent=true) nofile try #5: OK

test_firmware: reset
test_firmware: batched loading 'tmp.c6zL18xtIF' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for tmp.c6zL18xtIF failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) nofile try #1: OK

test_firmware: batched loading 'tmp.j1y9kUadKz' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for tmp.j1y9kUadKz failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) nofile try #2: OK

test_firmware: batched loading 'tmp.3wC543GX2C' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for tmp.3wC543GX2C failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) nofile try #3: OK

test_firmware: batched loading 'tmp.qFnGH8POVR' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for tmp.qFnGH8POVR failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) nofile try #4: OK

test_firmware: batched loading 'tmp.tIr4H9FesO' custom fallback mechanism 4 times
misc test_firmware: Direct firmware load for tmp.tIr4H9FesO failed with error -2
test_firmware: reset
# Batched request_firmware_nowait(uevent=false) nofile try #5: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Test request_partial_firmware_into_buf() off=0 size=10 nofile: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Test request_partial_firmware_into_buf() off=0 size=5 nofile: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
test_firmware: reset
# Test request_partial_firmware_into_buf() off=1 size=6 nofile: OK

test_firmware: batched sync firmware loading 'nope-test-firmware.bin' 4 times
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #2: batched sync load failed: -2
misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
test_firmware: #3: batched sync load failed: -2
test_firmware: #0: batched sync load failed: -2
test_firmware: #1: batched sync load failed: -2
test_firmware: #0: failed to async load firmware
test_firmware: #1: failed to async load firmware
test_firmware: #2: failed to async load firmware
test_firmware: #3: failed to async load firmware
# Test request_partial_firmware_into_buf() off=2 size=10 nofile: OK

# usermode helper disabled so ignoring test

# ./fw_upload.sh: firmware upload cancellation works

# ./fw_upload.sh: firmware upload error handling works

# ./fw_upload.sh: oversized firmware error handling works

# ./fw_upload.sh: firmware upload for fw1 works

# ./fw_upload.sh: firmware upload for fw2 works

==================================================================
# ./fw_upload.sh: firmware upload for fw3 works
BUG: KASAN: use-after-free in firmware_upload_unregister+0x16e/0x1c0
Read of size 8 at addr ffff8881e186c808 by task fw_upload.sh/2443


CPU: 7 PID: 2443 Comm: fw_upload.sh Not tainted 5.18.0-rc2-00036-ga37ddddd8603 #1
Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
Call Trace:
<TASK>
? firmware_upload_unregister+0x16e/0x1c0
dump_stack_lvl+0x45/0x59
print_address_description+0x1f/0x200
? firmware_upload_unregister+0x16e/0x1c0
print_report.cold+0x55/0x22c
? do_raw_spin_lock+0x12e/0x280
kasan_report+0xbe/0x1c0
? firmware_upload_unregister+0x16e/0x1c0
firmware_upload_unregister+0x16e/0x1c0
upload_unregister_store+0x196/0x2c0
? sysfs_file_ops+0x180/0x180
kernfs_fop_write_iter+0x354/0x540
new_sync_write+0x2ec/0x540
? new_sync_read+0x540/0x540
? ksys_write+0xf3/0x200
? rcu_read_unlock+0x40/0x40
? lock_is_held_type+0x98/0x140
vfs_write+0x5e1/0x900
ksys_write+0xf3/0x200
? __ia32_sys_read+0xc0/0xc0
? lockdep_hardirqs_on_prepare+0x19a/0x380
? syscall_enter_from_user_mode+0x21/0x80
do_syscall_64+0x5c/0x80
? pick_file+0xf2/0x180
? do_raw_spin_unlock+0x55/0x200
? syscall_exit_to_user_mode+0x1e/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x380
? do_syscall_64+0x69/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x380
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1020308f33
Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007fffe4075988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1020308f33
RDX: 0000000000000003 RSI: 00005582df845b80 RDI: 0000000000000001
RBP: 00005582df845b80 R08: 00000000ffffffff R09: 0000000000000003
R10: 00005582df833c80 R11: 0000000000000246 R12: 0000000000000003
R13: 00007f10203d96a0 R14: 0000000000000003 R15: 00007f10203d98a0
</TASK>

Allocated by task 2443:
kasan_save_stack+0x1e/0x40
__kasan_kmalloc+0x81/0xc0
firmware_upload_register+0x1d7/0x680
upload_register_store+0x16a/0x340
kernfs_fop_write_iter+0x354/0x540
new_sync_write+0x2ec/0x540
vfs_write+0x5e1/0x900
ksys_write+0xf3/0x200
do_syscall_64+0x5c/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 2443:
kasan_save_stack+0x1e/0x40
kasan_set_track+0x21/0x40
kasan_set_free_info+0x20/0x40
__kasan_slab_free+0x108/0x180
slab_free_freelist_hook+0xb0/0x180
kfree+0xd6/0x2c0
fw_dev_release+0x85/0xc0
device_release+0x9b/0x240
kobject_cleanup+0x104/0x3c0
firmware_upload_unregister+0x115/0x1c0
upload_unregister_store+0x196/0x2c0
kernfs_fop_write_iter+0x354/0x540
new_sync_write+0x2ec/0x540
vfs_write+0x5e1/0x900
ksys_write+0xf3/0x200
do_syscall_64+0x5c/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
kasan_save_stack+0x1e/0x40
__kasan_record_aux_stack+0x96/0xc0
insert_work+0x48/0x2c0
__queue_work+0x4d4/0xc00
queue_work_on+0x6f/0x80
fw_upload_start+0x265/0x400
firmware_loading_store+0x570/0x740
kernfs_fop_write_iter+0x354/0x540
new_sync_write+0x2ec/0x540
vfs_write+0x5e1/0x900
ksys_write+0xf3/0x200
do_syscall_64+0x5c/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
kasan_save_stack+0x1e/0x40
__kasan_record_aux_stack+0x96/0xc0
insert_work+0x48/0x2c0
__queue_work+0x4d4/0xc00
queue_work_on+0x6f/0x80
fw_upload_start+0x265/0x400
firmware_loading_store+0x570/0x740
kernfs_fop_write_iter+0x354/0x540
new_sync_write+0x2ec/0x540
vfs_write+0x5e1/0x900
ksys_write+0xf3/0x200
do_syscall_64+0x5c/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8881e186c800
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
512-byte region [ffff8881e186c800, ffff8881e186ca00)

The buggy address belongs to the physical page:
page:0000000037a5888d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e1868
head:0000000037a5888d order:3 compound_mapcount:0 compound_pincount:0
flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0010200 ffffea0005491e00 dead000000000002 ffff888100042c80
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff8881e186c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8881e186c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8881e186c800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff8881e186c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff8881e186c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
Disabling lock debugging due to kernel taint
general protection fault, probably for non-canonical address 0xfce7fc2b000001ac: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xe740015800000d60-0xe740015800000d67]
CPU: 7 PID: 2443 Comm: fw_upload.sh Tainted: G    B             5.18.0-rc2-00036-ga37ddddd8603 #1
Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
RIP: 0010:module_put+0x38/0x1c0
Code: 55 48 89 fd 53 48 8d 9f d8 03 00 00 be 04 00 00 00 48 89 df e8 19 cc 52 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 30
RSP: 0018:ffffc9000880fb90 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: e740015800000d63 RCX: ffffffff815ff727
RDX: 1ce8002b000001ac RSI: 0000000000000004 RDI: e740015800000d63
RBP: e74001580000098b R08: 0000000000000001 R09: ffffffff86bd59e7
R10: fffffbfff0d7ab3c R11: 0000000000000001 R12: 0000000000000003
R13: ffff8881200a6788 R14: ffff8881200a6790 R15: ffff8881200a6b08
FS:  00007f1020217740(0000) GS:ffff888614180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005582df8180dc CR3: 00000002413f0006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
<TASK>
upload_unregister_store+0x196/0x2c0
? sysfs_file_ops+0x180/0x180
kernfs_fop_write_iter+0x354/0x540
new_sync_write+0x2ec/0x540
? new_sync_read+0x540/0x540
? ksys_write+0xf3/0x200
? rcu_read_unlock+0x40/0x40
? lock_is_held_type+0x98/0x140
vfs_write+0x5e1/0x900
ksys_write+0xf3/0x200
? __ia32_sys_read+0xc0/0xc0
? lockdep_hardirqs_on_prepare+0x19a/0x380
? syscall_enter_from_user_mode+0x21/0x80
do_syscall_64+0x5c/0x80
? pick_file+0xf2/0x180
? do_raw_spin_unlock+0x55/0x200
? syscall_exit_to_user_mode+0x1e/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x380
? do_syscall_64+0x69/0x80
? lockdep_hardirqs_on_prepare+0x19a/0x380
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1020308f33
Code: 8b 15 61 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007fffe4075988 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1020308f33
RDX: 0000000000000003 RSI: 00005582df845b80 RDI: 0000000000000001
RBP: 00005582df845b80 R08: 00000000ffffffff R09: 0000000000000003
R10: 00005582df833c80 R11: 0000000000000246 R12: 0000000000000003
R13: 00007f10203d96a0 R14: 0000000000000003 R15: 00007f10203d98a0
</TASK>
Modules linked in: openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 btrfs blake2b_generic xor raid6_pq zstd_compress intel_rapl_msr libcrc32c intel_rapl_common sd_mod t10_pi i915 crc64_rocksoft_generic crc64_rocksoft crc64 intel_gtt sg drm_buddy drm_dp_helper ipmi_devintf ipmi_msghandler x86_pkg_temp_thermal intel_powerclamp coretemp crct10dif_pclmul crc32_pclmul crc32c_intel mei_wdt ghash_clmulni_intel ttm rapl wmi_bmof ahci drm_kms_helper libahci intel_cstate syscopyarea intel_uncore sysfillrect libata sysimgblt mei_me i2c_i801 intel_pch_thermal fb_sys_fops mei i2c_smbus wmi video intel_pmc_core acpi_pad fuse ip_tables
---[ end trace 0000000000000000 ]---
RIP: 0010:module_put+0x38/0x1c0
Code: 55 48 89 fd 53 48 8d 9f d8 03 00 00 be 04 00 00 00 48 89 df e8 19 cc 52 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 30
RSP: 0018:ffffc9000880fb90 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: e740015800000d63 RCX: ffffffff815ff727
RDX: 1ce8002b000001ac RSI: 0000000000000004 RDI: e740015800000d63
RBP: e74001580000098b R08: 0000000000000001 R09: ffffffff86bd59e7
R10: fffffbfff0d7ab3c R11: 0000000000000001 R12: 0000000000000003
R13: ffff8881200a6788 R14: ffff8881200a6790 R15: ffff8881200a6b08
FS:  00007f1020217740(0000) GS:ffff888614180000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005582df8180dc CR3: 00000002413f0006 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception
Kernel Offset: disabled

--pn0N0EkwwXOpe2zG
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job.yaml"

---
:#! /cephfs/tmp/d20220712-22317-1171xyi/kernel-selftests-bm.yaml:
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kernel-selftests:
  group: firmware
job_origin: kernel-selftests-bm.yaml
queue: bisect
testbox: lkp-skl-d01
commit: a37ddddd86037c896c702b4df416bc4e51b2a5a0
branch: linus/master
kconfig: x86_64-rhel-8.3-kselftests
name: "/cephfs/tmp/d20220712-22317-1171xyi/kernel-selftests-bm.yaml"
kernel_cmdline:
tbox_group: lkp-skl-d01
submit_id: 62e1020fedfe3c34120101f6
job_file: "/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-13330-11pjq0c-0.yaml"
id: ce0d0f8a1b406768932e2b27772de826d65e7bb5
queuer_version: "/zday/lkp"
:#! hosts/lkp-skl-d01:
model: Skylake
nr_cpu: 8
memory: 28G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x50014ee20d26b072-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part1"
swap_partitions: "/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part3"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e404c39bfc5-part2"
brand: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
cpu_info: skylake i7-6700
bios_version: 1.2.8
:#! include/category/functional:
kmsg:
heartbeat:
meminfo:
:#! include/testbox/lkp-skl-d01:
need_kconfig_hw:
- E1000E: y
- SATA_AHCI
- DRM_I915
ucode: '0xec'
bisect_dmesg: true
:#! include/kernel-selftests:
need_kconfig:
- FW_LOADER: y, v4.18-rc1
- FW_LOADER_USER_HELPER: y, v4.18-rc1
- IKCONFIG: y
- IKCONFIG_PROC: y
- TEST_FIRMWARE
rootfs: debian-11.1-x86_64-20220510.cgz
initrds:
- linux_headers
- linux_selftests
enqueue_time: 2022-07-27 17:14:55.711443666 +08:00
compiler: gcc-11
_id: 62e1020fedfe3c34120101f6
_rt: "/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0"
:#! schedule options:
user: lkp
LKP_SERVER: internal-lkp-server
result_root: "/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/0"
scheduler_version: "/lkp/lkp/.src-20220727-191518"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-11.1-x86_64-20220510.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/kernel-selftests/firmware-ucode=0xec/lkp-skl-d01/debian-11.1-x86_64-20220510.cgz/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603
- branch=linus/master
- job=/lkp/jobs/scheduled/lkp-skl-d01/kernel-selftests-firmware-ucode=0xec-debian-11.1-x86_64-20220510.cgz-a37ddddd86037c896c702b4df416bc4e51b2a5a0-20220727-13330-11pjq0c-0.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3-kselftests
- commit=a37ddddd86037c896c702b4df416bc4e51b2a5a0
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/modules.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/linux-selftests.cgz"
bm_initrd: "/osimage/deps/debian-11.1-x86_64-20220510.cgz/run-ipconfig_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/lkp_20220513.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/rsync-rootfs_20220515.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/kernel-selftests_20220724.cgz,/osimage/pkg/debian-11.1-x86_64-20220510.cgz/kernel-selftests-x86_64-4cb0bec3-1_20220724.cgz,/osimage/deps/debian-11.1-x86_64-20220510.cgz/hw_20220526.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /db/releases/20220712115008/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 4.20.0
:#! queue options:
queue_cmdline_keys:
- branch
- commit
:#! /db/releases/20220717170058/lkp-src/include/site/inn:
:#! /db/releases/20220725114201/lkp-src/include/site/inn:
schedule_notify_address:
:#! user overrides:
kernel: "/pkg/linux/x86_64-rhel-8.3-kselftests/gcc-11/a37ddddd86037c896c702b4df416bc4e51b2a5a0/vmlinuz-5.18.0-rc2-00036-ga37ddddd8603"
dequeue_time: 2022-07-27 19:24:54.384595640 +08:00
:#! /cephfs/db/releases/20220727172411/lkp-src/include/site/inn:
job_state: running

--pn0N0EkwwXOpe2zG--
