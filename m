Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE758F1A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiHJRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiHJRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:37:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C981832FA;
        Wed, 10 Aug 2022 10:37:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73DEB11FB;
        Wed, 10 Aug 2022 10:37:09 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BBE43F67D;
        Wed, 10 Aug 2022 10:37:07 -0700 (PDT)
Message-ID: <3e2ffc6b-a9d8-3ebd-92d0-799bea2203ca@foss.arm.com>
Date:   Wed, 10 Aug 2022 18:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 03/14] perf test: Add build infra for perf test tools
 for CoreSight tests
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-4-carsten.haitzler@foss.arm.com>
 <20220807035928.GA34254@leoy-ThinkPad-X240s>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <20220807035928.GA34254@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/22 04:59, Leo Yan wrote:
> On Thu, Jul 28, 2022 at 03:52:45PM +0100, carsten.haitzler@foss.arm.com wrote:
>> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
>>
>> This adds the initial build infrastructure (makefiles maintainers
>> information) for adding follow-on tests for CoreSight.
>>
>> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
>> ---
>>   MAINTAINERS                                   |  1 +
>>   tools/perf/Makefile.perf                      | 18 ++++++++++---
>>   tools/perf/tests/shell/coresight/Makefile     | 26 +++++++++++++++++++
>>   .../tests/shell/coresight/Makefile.miniconfig | 24 +++++++++++++++++
>>   4 files changed, 66 insertions(+), 3 deletions(-)
>>   create mode 100644 tools/perf/tests/shell/coresight/Makefile
>>   create mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 171563d8dc14..87e4ac463429 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1989,6 +1989,7 @@ F:	drivers/hwtracing/coresight/*
>>   F:	include/dt-bindings/arm/coresight-cti-dt.h
>>   F:	include/linux/coresight*
>>   F:	samples/coresight/*
>> +F:	tools/perf/tests/shell/coresight/*
>>   F:	tools/perf/arch/arm/util/auxtrace.c
>>   F:	tools/perf/arch/arm/util/cs-etm.c
>>   F:	tools/perf/arch/arm/util/cs-etm.h
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 8f738e11356d..edb621ace2e2 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -629,7 +629,15 @@ sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
>>   $(sync_file_range_arrays): $(linux_uapi_dir)/fs.h $(sync_file_range_tbls)
>>   	$(Q)$(SHELL) '$(sync_file_range_tbls)' $(linux_uapi_dir) > $@
>>   
>> -all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
>> +TESTS_CORESIGHT_DIR := $(srctree)/tools/perf/tests/shell/coresight
>> +
>> +tests-coresight-targets: FORCE
>> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR)
>> +
>> +tests-coresight-targets-clean:
>> +	$(Q)$(MAKE) -C $(TESTS_CORESIGHT_DIR) clean
>> +
>> +all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS) tests-coresight-targets
>>   
>>   # Create python binding output directory if not already present
>>   _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
>> @@ -1015,7 +1023,10 @@ install-tests: all install-gtk
>>   		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>   		$(INSTALL) tests/shell/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
>>   		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>> -		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'
>> +		$(INSTALL) tests/shell/lib/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/lib'; \
>> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'; \
>> +		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
>> +	$(Q)$(MAKE) -C tests/shell/coresight install-tests
>>   
>>   install-bin: install-tools install-tests install-traceevent-plugins
>>   
>> @@ -1085,7 +1096,7 @@ endif # BUILD_BPF_SKEL
>>   bpf-skel-clean:
>>   	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
>>   
>> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean
>> +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
>>   	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
>>   	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
>>   	$(Q)$(RM) $(OUTPUT).config-detected
>> @@ -1143,5 +1154,6 @@ FORCE:
>>   .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
>>   .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
>>   .PHONY: libtraceevent_plugins archheaders
>> +.PHONY: $(TESTS_CORESIGHT_TARGETS)
> 
> TESTS_CORESIGHT_TARGETS is not used anywhere else, should remove it?

I think this was left over from a previous iteration of this work and I 
removed it later on and forgot about this.

>>   endif # force_fixdep
>> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
>> new file mode 100644
>> index 000000000000..3b816bb4ced3
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/Makefile
>> @@ -0,0 +1,26 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +include ../../../../../tools/scripts/Makefile.include
>> +include ../../../../../tools/scripts/Makefile.arch
>> +include ../../../../../tools/scripts/utilities.mak
>> +
>> +SUBDIRS =
>> +
>> +all: $(SUBDIRS)
>> +$(SUBDIRS):
>> +	$(Q)$(MAKE) -C $@
>> +
>> +INSTALLDIRS = $(SUBDIRS:%=install-%)
>> +
>> +install-tests: $(INSTALLDIRS)
>> +$(INSTALLDIRS):
>> +	$(Q)$(MAKE) -C $(@:install-%=%) install-tests
> 
> I can see here you add a prefix "install-" for every sub directory
> string, and then removed this prefix when invoke "make -C" command.

install-tests is a target to install the tests on the host in a known 
location. it was already there. i added handling of this. there are 
other install- taregts like install-doc, install-bin and so on. i passed 
that through so *IF* there is a doc: or similar rule to generate docs 
then it runs the doc rule first to ensure docs are built before doing 
the install. this isn't actually used but it's passing along rules. i.e. 
make install-doc -> make doc etc.

> I know you have reason for doing this way, could you explain why not
> directly use $(SUBDIRS) for INSTALLDIRS?
> 
>> +
>> +CLEANDIRS = $(SUBDIRS:%=clean-%)
>> +
>> +clean: $(CLEANDIRS)
>> +$(CLEANDIRS):
>> +	$(Q)$(MAKE) -C $(@:clean-%=%) clean >/dev/null
> 
> Same question of using prefix "clean-" for variable CLEANDIRS.

Same answer as above.

>> +
>> +.PHONY: all clean $(SUBDIRS) $(CLEANDIRS) $(INSTALLDIRS)
>> +
>> diff --git a/tools/perf/tests/shell/coresight/Makefile.miniconfig b/tools/perf/tests/shell/coresight/Makefile.miniconfig
>> new file mode 100644
>> index 000000000000..a65482d769ab
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/coresight/Makefile.miniconfig
>> @@ -0,0 +1,24 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>> +
>> +ifndef DESTDIR
>> +prefix ?= $(HOME)
>> +endif
>> +
>> +DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
>> +perfexecdir = libexec/perf-core
>> +perfexec_instdir = $(perfexecdir)
>> +
>> +ifneq ($(filter /%,$(firstword $(perfexecdir))),)
>> +perfexec_instdir = $(perfexecdir)
>> +else
>> +perfexec_instdir = $(prefix)/$(perfexecdir)
>> +endif
>> +
>> +perfexec_instdir_SQ = $(subst ','\'',$(perfexec_instdir))
> 
> I know these variables are copied from Makefile.config, just wandering
> if we can directly export these variables from high level makefile, so
> the sub-make can inherit the variables.
> 
> E.g. we can add below line in Makefile.config:
> 
>    export perfexec_instdir_SQ
> 
> Please let me know if you observe any issue for this.

I can indeed simplify that a bit and remove a few lines.

> Thanks,
> Leo
> 
>> +INSTALL = install
>> +INSTDIR_SUB = tests/shell/coresight
>> +
>> +include ../../../../../scripts/Makefile.include
>> +include ../../../../../scripts/Makefile.arch
>> +include ../../../../../scripts/utilities.mak
>> -- 
>> 2.32.0
>>
