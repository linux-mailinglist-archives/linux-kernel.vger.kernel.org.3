Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92681561F75
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiF3PiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiF3PiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:38:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B98517E04;
        Thu, 30 Jun 2022 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656603479; x=1688139479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xddijHi6+72DF1QA8GwHls/3m1l1KigUq2mgomNL6/I=;
  b=GuZncNuD4145bvkJfJ0fk7xa8eQDECSGXgGWWF6tGzzNiIJzhl/XBAFj
   t4KIEw3AFpbd20klzL2wI1NKQ1jghoAZtRlMsq3prlYWN3rpa9ZUXU+rt
   SHdJc2DYxxhJL80h5B8Wxeok2YPvzGP3+AMXHyzn0ViwWHM6CrV+m8brn
   i+6AA7mzp0oZjRGgra03+jQhsyO2CTmimJSy4OuBcnH3sjz9IDmsk+Nn9
   1pUixBqLv8CA2jdHqDaVmgugDElTbCLmbfb3W5TMIA4auF+g5c7kmIYFi
   MjtXTu1qxV0w+f3svx6+F8xYSoXnx/Qp5Gix5Viuzt1M1ULid+tTcezLG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262179812"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262179812"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 08:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="588801728"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 08:37:39 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 30 Jun 2022 08:36:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 30 Jun 2022 08:36:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 30 Jun 2022 08:36:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+FmdocJj0a2A0wJWW4RRzi/JpNM73N31JLak3LfNY63ZHBOx4AlECUHySVVb7ECmyzJEP6NbUt9eH/dQrUeXK4n+LROd/C1Q57e+3x+cMfroeL7rauyW1MQ660felFOFtTO0waFWASsOD0rYi/9vkPgdeEOA/VXBZWbIzRD78d0pyOlooW9Ai96cqs0Be+pwF2X1uGGIphFy5leeJ+SjvLekHTsBFV31XfNlHyXeZaMB0mMUls0PNLeLEqobNqvB59akjj+WXKsCWthUBN3uf2Q58RdvRV+dTJKco0DaufM+39k//RNmjkMVkSZY5l1dPO1bGwPM+GSBVeQ6LUDBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXuUQW2/hXlk+kQ4YkL3bO7FNyRiYf8tZzpWXRn50fg=;
 b=AAjk0E6H5pk6cAaPLwaiMXn8et5uCoLAspJiAb1F1iQlmEB23/9c7x7QrNocvXTqa3kgVj+GmOAoMYpoVw7lJUTSKBctp9LlD3yx+/QyxOxzZGy5b28M+bt8qZao8b+5zjh1tVglpfXvZyXsXTZ+nHEmezmSin4cLD7CLUcpZEgyY3+JAH8hkzUWSJGoFL/7rw2DfituioIQHU60Fs3W32wUEikxcd7bSq9oL9Jensp2htPmpFBzhnZrOeG6EQob/eIkaKl1gsJ25HHsOSxuagmHH0iZBErJlYcn8+EGBZrpa2IWXRrnreXo3xCW7RUZVS9+spW1aGVyZsI+ffeRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM5PR11MB1658.namprd11.prod.outlook.com (2603:10b6:4:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 15:36:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%7]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 15:36:22 +0000
Date:   Thu, 30 Jun 2022 08:36:21 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-modules <linux-modules@vger.kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [ANNOUNCE] kmod 30
Message-ID: <20220630153621.3fggpqrbyvunhwfu@ldmartin-desk2>
X-Patchwork-Hint: comment
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
X-ClientProxiedBy: MWHPR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:300:116::17) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27d007fa-c96b-4b87-98d1-08da5aae4952
X-MS-TrafficTypeDiagnostic: DM5PR11MB1658:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Se3O9Pe7IpK06RSfHHISOqlq2T5/nY3E+GyI5FEaxgT4I7tnU7EOc41w9SWbNBK5abQSaX6May7B2VnBj+lDcT2kafwkOc5wedmWjUJxX88+ksf9bvrKgw9MoHgIhC2RTy/l0+xqw43XdwqvolWhYZfFYicsHzk2QAZHPAPt8MFJoWOmV9Yb49pnlxsI5qxstmUl90UlW83A/jk0BN/53NjVp7N6SOwEZGWYouM2DIFIeVK+hkiNr9NY4j9T3qvRec+rwThXfW1Ks3SMlXEGVg2WLJyMFJtfbQJN6KtIcZ0IZPnElehKB157XQiIN/tOC7rX4mTrF0C7C0b741rUQ1sEVA+VCwUoipROUrmgfnGDrmuhLRCBRfGnQuAr5yliPFXav+6/I20VKGQtuWkUURzLzQjTmH1Pr7Ou403d8HkAf3QEf9XCx8cGvA7roQkEy+HCwKEnK6VbfczMF2WgRM7PbXKjtDWJ71R+OoSxI0TLqrhwSaXJwVjAsdk3Xje2a4HZYmPlIY3VDtENucUIeNs+qlX6MHkGYVNgg7yzSAYOWoe1wkhFxl2KiQJEeYLkdHm/kRfiSdYfowRuSBZvZtlzCnl0ptRufwCLy7oIotjQnXwMkGbwoo4bApFIGiRoj6NgzzWMqKw+SPLCu3bcac3aqj5aDxtbBiihZ2B4rW8VN2c0JPgogx2hOtG//tbFzSQAQnt+djQh3/fnNfFIVdRZQpMeKq4ZUho5CXz4puAewHD+lInw7cOYWBk8NXJr21w69DGReJ7QygueBrll9EDZU1qFPUEzEPpjAAhNo8YMe52UDzdpIKeigeXU//Qtb5jpH84UFu0SPlDVrfatUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(6486002)(66556008)(66946007)(82960400001)(4326008)(8676002)(1076003)(966005)(26005)(9686003)(66476007)(86362001)(478600001)(6506007)(6512007)(41300700001)(83380400001)(8936002)(2906002)(38100700002)(33716001)(54906003)(316002)(5660300002)(186003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOndaUCwenyAiwP45yQaowU9DscpDpYC0b4ZDlcad72TfpKeIh0v51UYkax4?=
 =?us-ascii?Q?dU8efOY1p47YBA1gf15S7/U/qrjrIIoTPxX/x29F+5i2fPwNJ8FaVE36Fl80?=
 =?us-ascii?Q?1Lm0I7U380+TNSBxDKwobGhkIMDHdLeJ6olAWBmHiWV8fBOjULJ08bhjbzmr?=
 =?us-ascii?Q?5F2xOlQQ4r67Dsj/36Os20dnKhC4dzpfgR+ry/nNDHVdTnncpF9H3jaC00Vk?=
 =?us-ascii?Q?Yd6ujEeN1Rz0X09hRoqIfAPKcZnpZWdtyNJg/dLX+XcTnGRCbhQIq+T92xxO?=
 =?us-ascii?Q?xYe9tpB+2xu+Kt7MaceKGWMH0blGi5jVX3mPupdVFgAXbKA6zAV61LHTk4Yb?=
 =?us-ascii?Q?VLtEwti28VsLMjqYhzTX8xTZa3PpScAKx0FxsWtMrKiXxepYtNhR+QvoHBE5?=
 =?us-ascii?Q?lo+/5k4NPHqiKcDfmRWy+sopn6bLqpXNkajb8QfBK75bLMtf1/HT1LVnJV5p?=
 =?us-ascii?Q?tK0353ePTPji0DeViwti7mGOzOQjxDlAAa0MPZqi28Aw0GHpYljpenELP2gd?=
 =?us-ascii?Q?hW3S3pW68ATTpvqXAYU70lDLle/1Ndjctj0tXGUyN8HuvZLODwUcSwFO9O5k?=
 =?us-ascii?Q?aTGVMZaov/NURpoTWnNOWXRX/KQQznOahjrCqWY0110uuhLBFw1cyUldRYL7?=
 =?us-ascii?Q?V9qckjkXbfwXWm0tgp7lge/K7SU3lu8MT8+oe2sOOzEneB6kIpNWgcxJQSAu?=
 =?us-ascii?Q?Doe6/SiMsgTlPZeUmmfAF9t840Y+4nKSdKF291lHKr7grg4CQLSJJmPAabYi?=
 =?us-ascii?Q?S7HcPwmxH/ueD5j/ngNXNjW6+PDhieG7NDLDOciv58FAY3SC0qf4X3m9VWTf?=
 =?us-ascii?Q?lgXeE8ZfhMX4xLovDJmgwOlyGsIelQDA0Hr1+or2JtaNrfoOf6S69CiXnW5t?=
 =?us-ascii?Q?C8t5kIEeLin/RArJ94D6PcZJRbMoItNn8ajFDGHtNjS4Xsya9awUS1W1wG4I?=
 =?us-ascii?Q?XCLmx/pszWGR0oVo+6XmuQHQEdtbEdRUxeR7/QVTVLoClQNyqEcjx4XxOqO7?=
 =?us-ascii?Q?05Lyo86Y+6a9GpWHxFI5A51ssBy52aDHrEVWL08FHvs+gJpD3SYoj9uk3VTg?=
 =?us-ascii?Q?irmvmIKCAx5IoTMasNyudqNQYK+PfqvjLWTi96beLEn7y4sw2fHm8ie1diep?=
 =?us-ascii?Q?cvtyNPvfYKrmjfvKR+rtAePQpMO+Oh+oHeHnPBHYty0dUT9FpsOLFceulMcz?=
 =?us-ascii?Q?LsFC1vWFc7UNEVQt/5p39xzdyDkd8Zo/4UkRF5ogmEadBhIiyphFyiinALJ2?=
 =?us-ascii?Q?79pLWTmCBjDWD8y5drdsldK3p/gxVoURmxofugwTk99mXZwnJb1d9gXS471j?=
 =?us-ascii?Q?YEQXRBwgklg3SUVXV0bqXMJ+tBA+uJlrf2DxrGy3lrBfUuJF6FmpmnGPzhVK?=
 =?us-ascii?Q?D/3fRyA8J3RVZVhBSgDGgOajthBl1ieNkzGk6izWV1GljjRy1shmp3A4Xhng?=
 =?us-ascii?Q?JISd3/Se0+hZjW/Nq4g2mSJw4NIr+g/zvJS+lkQJpwtkyFB9Id7ml8ybFesy?=
 =?us-ascii?Q?Dh60vTRGUX5ZYZYq00Ia7OCgfGTiDgibxqx8qprLkrsQgACh4AVjVSeTJAEG?=
 =?us-ascii?Q?LmNTbW0F3t+P9ofjXKFUvGWQm6dxvJs0eImsSv4a593LqtN15VVumRQ6019a?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d007fa-c96b-4b87-98d1-08da5aae4952
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 15:36:22.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0xtsLWeatiMxs1SmwxmsxGUnxWRPgKsDcZ6aCYirQidA0Xv8t7gG32CoQHiJ2Qb0IWV9ge9SpFDfTeMkhwh43bc2kMoa8ztzSciaLn00FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmod 30 is out:

           https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-30.tar.xz
           https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-30.tar.sign

- Improvements
         - Stop adding duplicate information on modules.builtin.alias.bin, just use
           the modules.builtin.bin index

         - Speedup depmod, particularly under qemu with emulated arch, by
           avoiding a lot of open/read/close of modules.alias.bin. On an
           emulated ARM rootfs, depmod with only 2 modules was taking ~32s
           vs ~0.07s now.

         - Add kmod_module_new_from_name_lookup() which allows doing a lookup by
           module name, without considering the aliases. Other than that search
           order is similar to kmod_module_new_from_lookup().

         - modinfo learned the --modname option to explicitely show information
           about the module, even if there is an alias with the same name. This
           allows showing information about e.g. kernel/lib/crc32.ko, even if
           kernel also exports a crc32 alias in modules.alias:

                 alias crc32 crc32_pclmul
                 alias crc32 crc32_generic

           Same behavior will be used to other modules and to aliases provided
           by user/distro.

         - depmod.conf learned a new "excludedir" directive so distro/user can
           configure more directories to be excluded from its search, besides
           the hardcoded values "build" and "source".

         - Better group modprobe options on help output under "Management, Query and General".

         - modprobe learned a --wait <MSEC> option to be used together with -r
           when removing a module. This allows modprobe to keep trying the
           removal if it fails because the module is still in use. An exponential backoff
           time is used for further retries.

           The wait behavior provided by the kernel when not passing O_NONBLOCK
           to delete_module() was removed in v3.13 due to not be used and the
           consequences of having to support it in the kernel. However there may
           be some users, particularly on testsuites for individual susbsystems, that
           would want that. So provide a userspace implementation inside modprobe for
           such users. "rmmod" doesn't have a --wait as it remains a bare minimal over
           the API provided by the kernel. In future the --wait behavior can be added
           to libkmod for testsuites not exec'ing modprobe for module removal.

         - kmod_module_remove_module() learned a new flag to silence output when
           caller wants to handle them - this is particularly important for the
           --wait flag to modprobe, as it's not desired to keep seeing error messages
           while waiting for the module to be unused.

         - Add SM3 hash algo support to modinfo output, as already available in the kernel.

- Bug Fixes
         - Fix modinfo output when showing information for a .ko module when running
           on a kernel that has that module as builtin.

         - Fix kmod_module_new_from_lookup() returning > 0 rather than 0
           when it matches an alias.

         - Fix modinfo segfault when module doesn't exist.

         - Add missing function in the html documentation: kmod_get_dirname().

         - Fix modprobe incorrectly handling number of arguments when prepending values from
           MODPROBE_OPTIONS environment variable.

         - Fix modprobe -r --remove-dependencies and since "dependencies" was a
           misnomer, add the preferred argument option: "--remove-holders". This
           is the same name used by the kernel. It allows users to also remove
           other modules holding the one that is being removed.

         - Fix off-by-one in max module name length in depmod.

- Infra/internal
         - Start some changes in the out-of-tree test modules in kmod so they are useful
           for being really inserted in the kernel rather than relying on kmod's mock
           interface. This helps manual testing and may be used to exercise to test
           changes in the kernel.

Shortlog is below:

HuaxinLu (1):
       libkmod: Support SM3 hash algorithm

Lucas De Marchi (30):
       libkmod: Prefer builtin index over builtin.alias
       depmod: Do not duplicate builtin index
       depmod: Stop opening modules.modinfo once per module
       test-initstate: Check for negative value on error
       libkmod-module: Fix return code for kmod_module_new_from_lookup()
       gitignore: ignore gtk-doc.make
       libkmod: Add helper function to iterate lookup options
       libkmod: Update docs about indexes order
       libkmod: Add lookup from module name
       modinfo: Update help message with "modulename"
       modinfo: Allow to force arg as module name
       libkmod: Fix use of sizeof instead of ARRAY_SIZE
       docs: Add missing functions to documentation
       modprobe: Rename rmmod_do_deps_list
       modprobe: Fix holders removal
       modprobe: move check for remove_holders to caller
       modprobe: Make rmmod_do_module() contain all the removal sequence
       depmod: Fix writing over array length
       modprobe: re-use modname variable
       modprobe: Move -R to "Query options"
       libkmod: Allow to ignore log message on module removal
       module-playground: Add debugfs entry in mod-simple
       util: Add time-related functions from testsuite
       util: Add msec variants for time-related functions
       util: Add exponential backoff sleep
       testsuite: Add tests for sleep calculation
       modprobe: Add --wait
       Keep only one readme
       README: Update optional dependencies
       kmod 30

Luis Chamberlain (1):
       libkmod: add a library notice log level print

Masahiro Yamada (2):
       modprobe: fix the NULL-termination of new_argv
       modprobe: remove unneeded variable str_start

Michal Suchanek (1):
       libkmod: Set builtin to no when module is created from path.

Saul Wold (1):
       depmod: Add support for excluding a directory

Yauheni Kaliuta (1):
       libkmod-module: check "new_from_name" return value in get_builtin


Thank you all for the contributions.


Lucas De Marchi
