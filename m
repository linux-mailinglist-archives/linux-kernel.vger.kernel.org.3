Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8995095A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 06:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbiDUECx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 00:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiDUECg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 00:02:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68120BCB9;
        Wed, 20 Apr 2022 20:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650513587; x=1682049587;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X8xETJA2toTNhkNCch0WwO6orzXxhH9nFUDl7VCrAdI=;
  b=O7qYw7SkVMKH63v8nt906Tbm3lv6vmSc3tWc/O/Lf0x5yRSmzkEBQKNb
   8SP4Re4VOqDNcpTyx6hmbPd2yRvI7y/exH5SlOHNaFMFOeEN8XtVjntgc
   YV9zly5r8N+UDwk6eNcHqf27xbGVw9erzpT/HGzKcglYo7KMaWX6cwn8n
   gUjffCO14v6Q1lHMZyWSb/vHdWs10xixOXsJkJG3Tu5mvlISV2YkqJ0aT
   Pn7bO+B5sHOtGRNET5+7OKJNFKQSxDnuAkjKSbwoqEc/NU3CTR0mDB2xN
   uyBIi85KSufAgNg2ErSlNPDP2NgrThSz1syC+CXP3va6fv5cHIr9qKC2s
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263992034"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="263992034"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 20:59:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="702919211"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 20:59:46 -0700
Message-ID: <8610206dac7bf538eaf8fa81569741a91e4b8dc7.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/4] tools/thermal: thermal library and tools
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Date:   Wed, 20 Apr 2022 20:59:45 -0700
In-Reply-To: <20220420160933.347088-1-daniel.lezcano@linaro.org>
References: <20220420160933.347088-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 18:09 +0200, Daniel Lezcano wrote:
> These changes are providing the following tools and library:
> 
>  - A thermal library doing the netlink abstraction from the kernel in
>    order to make the userspace thermal implementation easier. Having
>    the library integrated with the kernel tree is also a guarantee to
>    keep the message format and their encoding/decoding aligned
>                                                                        
>                                                                        
>                                                                        
>                                                          
>  - A thermal tools library providing a set of functions to deal with
>    usual features like the log, the mainloop and the time. This
>    library is used by the provided tools below
> 
>  - An data acquisition program to capture the temperature of the
>    different thermal zone during an amount of time or during the
>    execution of an application. The output is formated to be easily
>    parsed by gnuplot, a spreadsheet program or a statistical command
>    line utility. The timestamp is based on the system uptime, thus
>    giving an indication of when a thermal event happened, that can
>    help to spot or reproduce thermal issue in the long run
> 
>  - A thermal monitoring program based on the thermal library. It gives
>    a skeleton to build any logic on top of it and shows how to use the
>    thermal library. It does nothing except discovering the thermal
>    zones, their trip points and listening for events like cooling
>    devices state changes or trip point crossed
> 

Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


But I still see these errors in applying patches:

Applying: tools/lib/thermal: Add a thermal library
Applying: tools/thermal: Add util library
Applying: tools/thermal: Add a temperature capture tool
.git/rebase-apply/patch:809: space before tab in indent.
	      	polling = 100; }
.git/rebase-apply/patch:90: new blank line at EOF.
+
.git/rebase-apply/patch:221: new blank line at EOF.
+
warning: 3 lines add whitespace errors.
Applying: tools/thermal: Add thermal daemon skeleton
.git/rebase-apply/patch:86: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Thanks,
Srinivas



>  Changelog:
> 
>  v3:
> 
>   - Fixed NULL pointer reference when there is no thermal zones, trip
>     points or cooling device
>   - Kill the child process when the duration ends or if there is an
>     interruption in the thermometer
>   - Add error messages in the main body for the thermal-engine
> 
>  v2:
> 
>   - Fixed all trailing whitespaces and some other checkpatch
>     warnings. Some warnings remain but they can be considered as false
>     positive
> 
>   - Added in the thermometer tool:
>     - Usage/help option as well as a man page
>     - The ability to execute a program
>     - The capture duration
>     - Create the output directory if it does not exist
> 
>   - Add in the thermal-engine tool:
>     - A usage/help option
>     - A message telling the userspace it is waiting for events
>     - A daemonize option
> 
>   - Minor bug fixes here and there, as well as typos
> 
>  v1: Initial post after a RFC
> 
> Daniel Lezcano (4):
>   tools/lib/thermal: Add a thermal library
>   tools/thermal: Add util library
>   tools/thermal: Add a temperature capture tool
>   tools/thermal: Add thermal daemon skeleton
> 
>  MAINTAINERS                                   |   1 +
>  tools/Makefile                                |  36 +-
>  tools/lib/thermal/.gitignore                  |   2 +
>  tools/lib/thermal/Build                       |   5 +
>  tools/lib/thermal/Makefile                    | 165 +++++
>  tools/lib/thermal/commands.c                  | 349 +++++++++++
>  tools/lib/thermal/events.c                    | 164 +++++
>  tools/lib/thermal/include/thermal.h           | 142 +++++
>  tools/lib/thermal/libthermal.map              |  25 +
>  tools/lib/thermal/libthermal.pc.template      |  12 +
>  tools/lib/thermal/sampling.c                  |  75 +++
>  tools/lib/thermal/thermal.c                   | 135 +++++
>  tools/lib/thermal/thermal_nl.c                | 215 +++++++
>  tools/lib/thermal/thermal_nl.h                |  46 ++
>  tools/thermal/lib/Build                       |   3 +
>  tools/thermal/lib/Makefile                    | 158 +++++
>  .../thermal/lib/libthermal_tools.pc.template  |  12 +
>  tools/thermal/lib/log.c                       |  77 +++
>  tools/thermal/lib/log.h                       |  31 +
>  tools/thermal/lib/mainloop.c                  | 120 ++++
>  tools/thermal/lib/mainloop.h                  |  15 +
>  tools/thermal/lib/thermal-tools.h             |  10 +
>  tools/thermal/lib/uptimeofday.c               |  40 ++
>  tools/thermal/lib/uptimeofday.h               |  12 +
>  tools/thermal/thermal-engine/Build            |   2 +
>  tools/thermal/thermal-engine/Makefile         |  28 +
>  tools/thermal/thermal-engine/thermal-engine.c | 341 +++++++++++
>  tools/thermal/thermometer/Build               |   2 +
>  tools/thermal/thermometer/Makefile            |  26 +
>  tools/thermal/thermometer/thermometer.8       |  93 +++
>  tools/thermal/thermometer/thermometer.c       | 573 ++++++++++++++++++
>  tools/thermal/thermometer/thermometer.conf    |   5 +
>  32 files changed, 2917 insertions(+), 3 deletions(-)
>  create mode 100644 tools/lib/thermal/.gitignore
>  create mode 100644 tools/lib/thermal/Build
>  create mode 100644 tools/lib/thermal/Makefile
>  create mode 100644 tools/lib/thermal/commands.c
>  create mode 100644 tools/lib/thermal/events.c
>  create mode 100644 tools/lib/thermal/include/thermal.h
>  create mode 100644 tools/lib/thermal/libthermal.map
>  create mode 100644 tools/lib/thermal/libthermal.pc.template
>  create mode 100644 tools/lib/thermal/sampling.c
>  create mode 100644 tools/lib/thermal/thermal.c
>  create mode 100644 tools/lib/thermal/thermal_nl.c
>  create mode 100644 tools/lib/thermal/thermal_nl.h
>  create mode 100644 tools/thermal/lib/Build
>  create mode 100644 tools/thermal/lib/Makefile
>  create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
>  create mode 100644 tools/thermal/lib/log.c
>  create mode 100644 tools/thermal/lib/log.h
>  create mode 100644 tools/thermal/lib/mainloop.c
>  create mode 100644 tools/thermal/lib/mainloop.h
>  create mode 100644 tools/thermal/lib/thermal-tools.h
>  create mode 100644 tools/thermal/lib/uptimeofday.c
>  create mode 100644 tools/thermal/lib/uptimeofday.h
>  create mode 100644 tools/thermal/thermal-engine/Build
>  create mode 100644 tools/thermal/thermal-engine/Makefile
>  create mode 100644 tools/thermal/thermal-engine/thermal-engine.c
>  create mode 100644 tools/thermal/thermometer/Build
>  create mode 100644 tools/thermal/thermometer/Makefile
>  create mode 100644 tools/thermal/thermometer/thermometer.8
>  create mode 100644 tools/thermal/thermometer/thermometer.c
>  create mode 100644 tools/thermal/thermometer/thermometer.conf
> 


