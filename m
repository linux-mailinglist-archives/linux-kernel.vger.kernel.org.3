Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC54563DDB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiGBDCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBDCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:02:09 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21937036;
        Fri,  1 Jul 2022 20:02:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r66so4046860pgr.2;
        Fri, 01 Jul 2022 20:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GvgrvexFFdYmKYfW01B8Hx0R3rbDwFFQNYi/YvJTByA=;
        b=F5GxiVKUhBmWQZNQG3H0PiwGxo6kr/h7aqBmEm9IN7//A72Lq2fkr6D+PBVPCP5M22
         VMcfCAYaQiAf+QWfNv0YgInBOQsZ/YCTpIifO1fgcEMr1QcAQZUEFelTamfAgtVCDJNS
         PU6Zx8CYzbxBZefcZBwbRCGHkmAiovLtn4d2orZZYFS70vbv0c9EriJiLhUbcJMNLnAX
         IiJBeT9VkdlFP4E9XAtNwoQaSIpq2Shs8CLacb7okA6f2+85oc6b2p/uMPG4c1XXCM2b
         VfoKYQ8WgCwh6V1IhJnQ7I0ngRC2+HEzYBTFDK3jf8hbV86F2jlN3onJq6Ndup0PTR8k
         mcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GvgrvexFFdYmKYfW01B8Hx0R3rbDwFFQNYi/YvJTByA=;
        b=wdUgWE6tqnecBTshbA/1dSgyDbnrpvNoaumnWk6RelKt3wycMDOSBgQHRT3V8AfuAS
         E89RJDkBY3w0RkwSQE2zAwArAC58WTyhSpYYP1kwvKLjseXk16nVleT9Ak8ZOg7Zu5yW
         0+aNgiacA3dqSGBn93vyiRP2lslWEBCO869zrN6I4QJawx0ILE599MvDNk9NoG0o1LRh
         KHdDVkaUIzCTp0OglZIDvytiCdHGhJQOu7QkSg3r06O8ucBL38AvpR4ysNbAmc0WtI4Y
         z67WfrVOKzFwicee8exRlX7MFD9u1S0S1/vWDfxTye+b9ElO8mfrJwYIO9FqowC+Nk0b
         JO2A==
X-Gm-Message-State: AJIora9iDb++RCvrPe7mqNryXtWjPDVo5HPDe+Tddtr5mdsD0YSMzQ8M
        yp0hdVZWzQgIOFOAxTXMiTM=
X-Google-Smtp-Source: AGRyM1tXTh3yDvTBFdCpy3SORBH6vNzDL9yR9YTRReqYKxOSVsqGSvmt/Hd5fy4806p6gsp77w4shw==
X-Received: by 2002:a63:7519:0:b0:40d:677:b89b with SMTP id q25-20020a637519000000b0040d0677b89bmr14829482pgc.49.1656730927150;
        Fri, 01 Jul 2022 20:02:07 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id s9-20020a62e709000000b00527ab697c6asm10569974pfh.18.2022.07.01.20.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 20:02:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B37E41037E5; Sat,  2 Jul 2022 10:02:01 +0700 (WIB)
Date:   Sat, 2 Jul 2022 10:02:01 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "carsten.haitzler@foss.arm.com" <carsten.haitzler@foss.arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, leo.yan@linaro.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 14/14] perf test: Add relevant documentation about
 CoreSight testing
Message-ID: <Yr+1KZfciYQWdDgK@debian.me>
References: <20220701120804.3226396-1-carsten.haitzler@foss.arm.com>
 <20220701120804.3226396-15-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220701120804.3226396-15-carsten.haitzler@foss.arm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 01:08:03PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 

Hi Carsten,

This doc patch can be improved, see below.

> This adds/improves documentation helping people get started with
> CoreSight and perf as well as describing the testing and how it works.
> 

Use imperative mood instead of descriptive one for patch description.

> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  .../trace/coresight/coresight-perf.rst        | 160 ++++++++++++++++++
>  tools/perf/Documentation/arm-coresight.txt    |   5 +
>  2 files changed, 165 insertions(+)
>  create mode 100644 Documentation/trace/coresight/coresight-perf.rst
>  create mode 100644 tools/perf/Documentation/arm-coresight.txt
> 
> diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
> new file mode 100644
> index 000000000000..de25082447dd
> --- /dev/null
> +++ b/Documentation/trace/coresight/coresight-perf.rst
> @@ -0,0 +1,160 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
> +CoreSight - Perf
> +================
> +
> +    :Author:   Carsten Haitzler <carsten.haitzler@arm.com>
> +    :Date:     June 29th, 2022
> +
> +Perf is able to locally access CoreSight trace data and store it to the
> +output perf data files. This data can then be later decoded to give the
> +instructions that were traced for debugging or profiling purposes. You
> +can log such data with a perf record command like:
> +
> +    perf record -e cs_etm//u testbinary
> +

Use literal code block.

> +This would run some test binary (testbinary) until it exits and record
> +a perf.data trace file. That file would have AUX sections if CoreSight
> +is working correctly. You can dump the content of this file as
> +readable text with a command like:
> +
> +    perf report --stdio --dump -i perf.data
> +

Same as above.

> +You should find some sections of this file have AUX data blocks like:
> +
> +    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
> +
> +    . ... CoreSight ETM Trace data: size 73168 bytes
> +            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
> +              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
> +              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
> +              Idx:26; ID:10;  I_TRACE_ON : Trace On.
> +              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
> +              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> +              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> +              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
> +              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
> +              ...
> +

Here too.

> +If you see these above, then your system is tracing CoreSight data
> +correctly.
> +
> +To compile perf with CoreSight support in the tools/perf directory do
> +
> +    make CORESIGHT=1
> +

Here too again.

> +This requires OpenCSD to build. You may install distribution packages
> +for the support such as libopencsd and libopencsd-dev or download it
> +and build yourself. Upstream OpenCSD is located at:
> +
> +  https://github.com/Linaro/OpenCSD
> +
> +For complete information on building perf with CoreSight support and
> +more extensive usage look at:
> +
> +  https://github.com/Linaro/OpenCSD/blob/master/HOWTO.md
> +
> +
> +Kernel CoreSight Support
> +------------------------
> +
> +You will also want CoreSight support enabled in your kernel config.
> +Ensure it is enabled with:
> +
> +    CONFIG_CORESIGHT=y
> +
> +There are various other CoreSight options you probably also want
> +enabled like:
> +
> +    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
> +    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
> +    CONFIG_CORESIGHT_CATU=y
> +    CONFIG_CORESIGHT_SINK_TPIU=y
> +    CONFIG_CORESIGHT_SINK_ETBV10=y
> +    CONFIG_CORESIGHT_SOURCE_ETM4X=y
> +    CONFIG_CORESIGHT_STM=y
> +    CONFIG_CORESIGHT_CPU_DEBUG=y
> +    CONFIG_CORESIGHT_CTI=y
> +    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
> +

Same as above again.

> +Please refer to the kernel configuration help for more information.
> +
> +Perf test - Verify kernel and userspace perf CoreSight work
> +-----------------------------------------------------------
> +
> +When you run perf test, it will do a lot of self tests. Some of those
> +tests will cover CoreSight (only if enabled and on ARM64). You
> +generally would run perf test from the tools/perf directory in the
> +kernel tree. Some tests will check some internal perf support like:
> +
> +    Check Arm CoreSight trace data recording and synthesized samples
> +    Check Arm SPE trace data recording and synthesized samples
> +

Use bullet lists.

> +Some others will actually use perf record and some test binaries that
> +are in tests/shell/coresight and will collect traces to ensure a
> +minimum level of functionality is met. The scripts that launch these
> +tests are in the same directory. These will all look like:
> +
> +    CoreSight / ASM Pure Loop
> +    CoreSight / Memcpy 16k 10 Threads
> +    CoreSight / Thread Loop 10 Threads - Check TID
> +    ...
> +

Same as above.

> +These perf record tests will not run if the tool binaries do not exist
> +in tests/shell/coresight/*/ and will be skipped. If you do not have
> +CoreSight support in hardware then either do not build perf with
> +CoreSight support or remove these binaries in order to not have these
> +tests fail and have them skip instead.
> +
> +These tests will log historical results in the current working
> +directory (e.g. tools/perf) and will be named stats-*.csv like:
> +
> +    stats-asm_pure_loop-out.csv
> +    stats-memcpy_thread-16k_10.csv
> +    ...
> +

These above causes htmldocs warning (unescaped wildcard), so I have to apply
the fixup:

---- >8 ----

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index de25082447dd50..a25fcda5c37c55 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -102,13 +102,13 @@ tests are in the same directory. These will all look like:
     ...
 
 These perf record tests will not run if the tool binaries do not exist
-in tests/shell/coresight/*/ and will be skipped. If you do not have
+in tests/shell/coresight/\*/ and will be skipped. If you do not have
 CoreSight support in hardware then either do not build perf with
 CoreSight support or remove these binaries in order to not have these
 tests fail and have them skip instead.
 
 These tests will log historical results in the current working
-directory (e.g. tools/perf) and will be named stats-*.csv like:
+directory (e.g. tools/perf) and will be named stats-\*.csv like:
 
     stats-asm_pure_loop-out.csv
     stats-memcpy_thread-16k_10.csv

---- >8 ----

Also, the output list above could be inside code block (since these
are output).

> +These statistic files log some aspects of the AUX data sections in
> +the perf data output counting some numbers of certain encodings (a
> +good way to know that it's working in a very simple way). One problem
> +with CoreSight is that given a large enough amount of data needing to
> +be logged, some of it can be lost due to the processor not waking up
> +in time to read out all the data from buffers etc.. You will notice
> +that the amount of data collected can vary a lot per run of perf test.
> +If you wish to see how this changes over time, simply run perf test
> +multiple times and all these csv files will have more and more data
> +appended to it that you can later examine, graph and otherwise use to
> +figure out if things have become worse or better.
> +
> +This means sometimes these tests fail as they don't capture all the
> +data needed. This is about tracking quality and amount of data
> +produced over time and to see when changes to the Linux kernel improve
> +quality of traces.
> +
> +Be aware that some of these tests take quite a while to run, specifically
> +in processing the perf data file and dumping contents to then examine what
> +is inside.
> +
> +You can change where these csv logs are stored by setting the
> +PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
> +test like:
> +
> +    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
> +    perf test
> +
> +They will also store resulting perf output data in the current
> +directory for later inspection like:
> +
> +    perf-asm_pure_loop-out.data
> +    perf-memcpy_thread-16k_10.data
> +    ...
> +
> +You can alter where the perf data files are stored by setting the
> +PERF_TEST_CORESIGHT_DATADIR environment variable such as:
> +
> +    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
> +    perf test
> +

Use code block.

> +You may wish to set these above environment variables if you whish to
> +keep the output of tests outside of the current working directory for
> +longer term storage and examination.
> diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
> new file mode 100644
> index 000000000000..f94743a4d161
> --- /dev/null
> +++ b/tools/perf/Documentation/arm-coresight.txt
> @@ -0,0 +1,5 @@
> +Arm CoreSight Support
> +=====================
> +
> +Please see docuentation in the central CoreSight location in the
> +kernel tree under Documentation/trace/coresight

s/ducuentation/documentation/

So here's the improv:

---- >8 ----

diff --git a/Documentation/trace/coresight/coresight-perf.rst b/Documentation/trace/coresight/coresight-perf.rst
index a25fcda5c37c55..0dd4689a699ecd 100644
--- a/Documentation/trace/coresight/coresight-perf.rst
+++ b/Documentation/trace/coresight/coresight-perf.rst
@@ -10,37 +10,37 @@ CoreSight - Perf
 Perf is able to locally access CoreSight trace data and store it to the
 output perf data files. This data can then be later decoded to give the
 instructions that were traced for debugging or profiling purposes. You
-can log such data with a perf record command like:
+can log such data with a perf record command like::
 
-    perf record -e cs_etm//u testbinary
+   perf record -e cs_etm//u testbinary
 
 This would run some test binary (testbinary) until it exits and record
 a perf.data trace file. That file would have AUX sections if CoreSight
 is working correctly. You can dump the content of this file as
-readable text with a command like:
+readable text with a command like::
 
-    perf report --stdio --dump -i perf.data
+   perf report --stdio --dump -i perf.data
 
-You should find some sections of this file have AUX data blocks like:
+You should find some sections of this file have AUX data blocks like::
 
-    0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
+   0x1e78 [0x30]: PERF_RECORD_AUXTRACE size: 0x11dd0  offset: 0  ref: 0x1b614fc1061b0ad1  idx: 0  tid: 531230  cpu: -1
 
-    . ... CoreSight ETM Trace data: size 73168 bytes
-            Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
-              Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
-              Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
-              Idx:26; ID:10;  I_TRACE_ON : Trace On.
-              Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
-              Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
-              Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
-              Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
-              Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
-              ...
+   . ... CoreSight ETM Trace data: size 73168 bytes
+           Idx:0; ID:10;   I_ASYNC : Alignment Synchronisation.
+             Idx:12; ID:10;  I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0 }
+             Idx:17; ID:10;  I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.; Addr=0x0000000000000000;
+             Idx:26; ID:10;  I_TRACE_ON : Trace On.
+             Idx:27; ID:10;  I_ADDR_CTXT_L_64IS0 : Address & Context, Long, 64 bit, IS0.; Addr=0x0000FFFFB6069140; Ctxt: AArch64,EL0, NS;
+             Idx:38; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
+             Idx:39; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
+             Idx:40; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEEEEEEEEEEEEEE
+             Idx:41; ID:10;  I_ATOM_F6 : Atom format 6.; EEEEEEEEEEEN
+             ...
 
 If you see these above, then your system is tracing CoreSight data
 correctly.
 
-To compile perf with CoreSight support in the tools/perf directory do
+To compile perf with CoreSight support in the tools/perf directory do::
 
     make CORESIGHT=1
 
@@ -60,23 +60,23 @@ Kernel CoreSight Support
 ------------------------
 
 You will also want CoreSight support enabled in your kernel config.
-Ensure it is enabled with:
+Ensure it is enabled with::
 
-    CONFIG_CORESIGHT=y
+   CONFIG_CORESIGHT=y
 
 There are various other CoreSight options you probably also want
-enabled like:
+enabled like::
 
-    CONFIG_CORESIGHT_LINKS_AND_SINKS=y
-    CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
-    CONFIG_CORESIGHT_CATU=y
-    CONFIG_CORESIGHT_SINK_TPIU=y
-    CONFIG_CORESIGHT_SINK_ETBV10=y
-    CONFIG_CORESIGHT_SOURCE_ETM4X=y
-    CONFIG_CORESIGHT_STM=y
-    CONFIG_CORESIGHT_CPU_DEBUG=y
-    CONFIG_CORESIGHT_CTI=y
-    CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
+   CONFIG_CORESIGHT_LINKS_AND_SINKS=y
+   CONFIG_CORESIGHT_LINK_AND_SINK_TMC=y
+   CONFIG_CORESIGHT_CATU=y
+   CONFIG_CORESIGHT_SINK_TPIU=y
+   CONFIG_CORESIGHT_SINK_ETBV10=y
+   CONFIG_CORESIGHT_SOURCE_ETM4X=y
+   CONFIG_CORESIGHT_STM=y
+   CONFIG_CORESIGHT_CPU_DEBUG=y
+   CONFIG_CORESIGHT_CTI=y
+   CONFIG_CORESIGHT_CTI_INTEGRATION_REGS=y
 
 Please refer to the kernel configuration help for more information.
 
@@ -88,18 +88,18 @@ tests will cover CoreSight (only if enabled and on ARM64). You
 generally would run perf test from the tools/perf directory in the
 kernel tree. Some tests will check some internal perf support like:
 
-    Check Arm CoreSight trace data recording and synthesized samples
-    Check Arm SPE trace data recording and synthesized samples
+* Check Arm CoreSight trace data recording and synthesized samples
+* Check Arm SPE trace data recording and synthesized samples
 
 Some others will actually use perf record and some test binaries that
 are in tests/shell/coresight and will collect traces to ensure a
 minimum level of functionality is met. The scripts that launch these
 tests are in the same directory. These will all look like:
 
-    CoreSight / ASM Pure Loop
-    CoreSight / Memcpy 16k 10 Threads
-    CoreSight / Thread Loop 10 Threads - Check TID
-    ...
+* CoreSight / ASM Pure Loop
+* CoreSight / Memcpy 16k 10 Threads
+* CoreSight / Thread Loop 10 Threads - Check TID
+* etc.
 
 These perf record tests will not run if the tool binaries do not exist
 in tests/shell/coresight/\*/ and will be skipped. If you do not have
@@ -108,11 +108,11 @@ CoreSight support or remove these binaries in order to not have these
 tests fail and have them skip instead.
 
 These tests will log historical results in the current working
-directory (e.g. tools/perf) and will be named stats-\*.csv like:
+directory (e.g. tools/perf) and will be named stats-\*.csv like::
 
-    stats-asm_pure_loop-out.csv
-    stats-memcpy_thread-16k_10.csv
-    ...
+   stats-asm_pure_loop-out.csv
+   stats-memcpy_thread-16k_10.csv
+   ...
 
 These statistic files log some aspects of the AUX data sections in
 the perf data output counting some numbers of certain encodings (a
@@ -137,23 +137,23 @@ is inside.
 
 You can change where these csv logs are stored by setting the
 PERF_TEST_CORESIGHT_STATDIR environment variable before running perf
-test like:
+test like::
 
-    export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
-    perf test
+   export PERF_TEST_CORESIGHT_STATDIR=/var/tmp
+   perf test
 
 They will also store resulting perf output data in the current
-directory for later inspection like:
+directory for later inspection like::
 
-    perf-asm_pure_loop-out.data
-    perf-memcpy_thread-16k_10.data
-    ...
+   perf-asm_pure_loop-out.data
+   perf-memcpy_thread-16k_10.data
+   ...
 
 You can alter where the perf data files are stored by setting the
-PERF_TEST_CORESIGHT_DATADIR environment variable such as:
+PERF_TEST_CORESIGHT_DATADIR environment variable such as::
 
-    PERF_TEST_CORESIGHT_DATADIR=/var/tmp
-    perf test
+   PERF_TEST_CORESIGHT_DATADIR=/var/tmp
+   perf test
 
 You may wish to set these above environment variables if you whish to
 keep the output of tests outside of the current working directory for
diff --git a/tools/perf/Documentation/arm-coresight.txt b/tools/perf/Documentation/arm-coresight.txt
index f94743a4d161f2..c117fc50a2a956 100644
--- a/tools/perf/Documentation/arm-coresight.txt
+++ b/tools/perf/Documentation/arm-coresight.txt
@@ -1,5 +1,5 @@
 Arm CoreSight Support
 =====================
 
-Please see docuentation in the central CoreSight location in the
-kernel tree under Documentation/trace/coresight
+For full documentation, see Documentation/trace/coresight/coresight-perf.rst
+in the kernel tree.

---- >8 ----

Note: since this is documentation patch, don't forget to Cc linux-doc list.
I add it for you.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
