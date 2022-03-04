Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE24CD3DA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiCDL5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiCDL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:57:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2341B2AE9;
        Fri,  4 Mar 2022 03:56:13 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9070C51C;
        Fri,  4 Mar 2022 12:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646394971;
        bh=aikwex64ir9+SyeBADAG8bXnsYfh3gLwVEtpIrRhbag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=irx608CWGgaEGJYgGK9OMgxrSNwHmXSYvgZSIBBvD6pN0ETCuWdTK5eODGjCbVAOO
         tkruRRYlzou/kVrUORfuVTtj+O2162Vdh2Tlw0WFL+Vl6nxdAtM61FAB53ss7n5Bx5
         bMaXqIz7V3HCPXSx8CeYXBdjQtrjModkT1HFEQdI=
Date:   Fri, 4 Mar 2022 13:55:59 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: kbuild: Use DTB files for validation
Message-ID: <YiH+Twl8JnwKPv3a@pendragon.ideasonboard.com>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303224237.2497570-3-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Thu, Mar 03, 2022 at 04:42:37PM -0600, Rob Herring wrote:
> Switch the DT validation to use DTB files directly instead of a DTS to
> YAML conversion.
> 
> The original motivation for supporting validation on DTB files was to
> enable running validation on a running system (e.g. 'dt-validate
> /sys/firmware/fdt') or other cases where the original source DTS is not
> available.
> 
> The YAML format was not without issues. Using DTBs with the schema type
> information solves some of those problems. The YAML format relies on the
> DTS source level information including bracketing of properties, size
> directives, and phandle tags all of which are lost in a DTB file. While
> standardizing the bracketing is a good thing, it does cause a lot of
> extra warnings and churn to fix them.

It does indeed, but it's a bit sad to let that feature go :-S

It's nice to drop the dependency on libyaml though, and the ability to
validate a DTB is nice too, so I think it's worth it.

> Another issue has been signed types are not validated correctly as sign
> information is not propagated to YAML. Using the schema type information
> allows for proper handling of signed types. YAML also can't represent
> the full range of 64-bit integers as numbers are stored as floats by
> most/all parsers.
> 
> The DTB validation works by decoding property values using the type
> information in the schemas themselves. The main corner case this does
> not work for is matrix types where neither dimension is fixed. For
> now, checking the dimensions in these cases are skipped.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile    |  7 +++----
>  .../devicetree/bindings/writing-schema.rst    | 12 -----------
>  scripts/Makefile.lib                          | 20 +++++++------------
>  scripts/dtc/Makefile                          | 13 ------------
>  scripts/dtc/update-dtc-source.sh              |  2 +-
>  5 files changed, 11 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 246ba0ecab64..b8bd6a8ec43a 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -26,8 +26,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>  	$(call if_changed,extract_ex)
>  
>  find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
> -		-name 'processed-schema*' ! \
> -		-name '*.example.dt.yaml' \)
> +		-name 'processed-schema*' \)
>  
>  find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
>  CHK_DT_DOCS := $(shell $(find_cmd))
> @@ -72,9 +71,9 @@ $(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version
>  
>  always-y += processed-schema.json
>  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
> -always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
> +always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dtb, $(CHK_DT_DOCS))
>  
>  # Hack: avoid 'Argument list too long' error for 'make clean'. Remove most of
>  # build artifacts here before they are processed by scripts/Makefile.clean
>  clean-files = $(shell find $(obj) \( -name '*.example.dts' -o \
> -			-name '*.example.dt.yaml' \) -delete 2>/dev/null)
> +			-name '*.example.dtb' \) -delete 2>/dev/null)
> diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> index 3b00fe981494..b4258bf81be5 100644
> --- a/Documentation/devicetree/bindings/writing-schema.rst
> +++ b/Documentation/devicetree/bindings/writing-schema.rst
> @@ -123,18 +123,6 @@ project can be installed with pip::
>  Several executables (dt-doc-validate, dt-mk-schema, dt-validate) will be
>  installed. Ensure they are in your PATH (~/.local/bin by default).
>  
> -dtc must also be built with YAML output support enabled. This requires that
> -libyaml and its headers be installed on the host system. For some distributions
> -that involves installing the development package, such as:
> -
> -Debian::
> -
> -  apt-get install libyaml-dev
> -
> -Fedora::
> -
> -  dnf -y install libyaml-devel
> -
>  Running checks
>  ~~~~~~~~~~~~~~
>  
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 9f1e8442564e..4629af60160b 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -87,11 +87,6 @@ base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m,
>  
>  always-y			+= $(dtb-y)
>  
> -ifneq ($(CHECK_DTBS),)
> -always-y += $(patsubst %.dtb,%.dt.yaml, $(real-dtb-y))
> -always-y += $(patsubst %.dtbo,%.dt.yaml, $(real-dtb-y))
> -endif
> -
>  # Add subdir path
>  
>  extra-y		:= $(addprefix $(obj)/,$(extra-y))
> @@ -347,12 +342,6 @@ cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ;
>  		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
>  	cat $(depfile).pre.tmp $(depfile).dtc.tmp > $(depfile)
>  
> -$(obj)/%.dtb: $(src)/%.dts $(DTC) FORCE
> -	$(call if_changed_dep,dtc)
> -
> -$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> -	$(call if_changed_dep,dtc)
> -
>  quiet_cmd_fdtoverlay = DTOVL   $@
>        cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)
>  
> @@ -365,17 +354,22 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
>  DT_BINDING_DIR := Documentation/devicetree/bindings
>  DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
>  
> +ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
>  quiet_cmd_dtb_check =	CHECK   $@
> -      cmd_dtb_check =	$(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@
> +      cmd_dtb_check =	$(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> +endif
>  
>  define rule_dtc
>  	$(call cmd_and_fixdep,dtc)
>  	$(call cmd,dtb_check)
>  endef
>  
> -$(obj)/%.dt.yaml: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> +$(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>  	$(call if_changed_rule,dtc)
>  
> +$(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
> +	$(call if_changed_dep,dtc)
> +
>  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>  
>  # Bzip2
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 1cba78e1dce6..4d32b9497da9 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -17,20 +17,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
>  
>  # Source files need to get at the userspace version of libfdt_env.h to compile
>  HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt
> -
> -ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
> -ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
> -$(error dtc needs libyaml for DT schema validation support. \
> -	Install the necessary libyaml development package.)
> -endif
>  HOST_EXTRACFLAGS += -DNO_YAML
> -else
> -dtc-objs	+= yamltree.o
> -# To include <yaml.h> installed in a non-default path
> -HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
> -# To link libyaml installed in a non-default path
> -HOSTLDLIBS_dtc	:= $(shell pkg-config --libs yaml-0.1)
> -endif
>  
>  # Generated files need one more search path to include headers in source tree
>  HOSTCFLAGS_dtc-lexer.lex.o := -I $(srctree)/$(src)
> diff --git a/scripts/dtc/update-dtc-source.sh b/scripts/dtc/update-dtc-source.sh
> index 32ff17ffd089..94627541533e 100755
> --- a/scripts/dtc/update-dtc-source.sh
> +++ b/scripts/dtc/update-dtc-source.sh
> @@ -32,7 +32,7 @@ DTC_UPSTREAM_PATH=`pwd`/../dtc
>  DTC_LINUX_PATH=`pwd`/scripts/dtc
>  
>  DTC_SOURCE="checks.c data.c dtc.c dtc.h flattree.c fstree.c livetree.c srcpos.c \
> -		srcpos.h treesource.c util.c util.h version_gen.h yamltree.c \
> +		srcpos.h treesource.c util.c util.h version_gen.h \
>  		dtc-lexer.l dtc-parser.y"
>  LIBFDT_SOURCE="fdt.c fdt.h fdt_addresses.c fdt_empty_tree.c \
>  		fdt_overlay.c fdt_ro.c fdt_rw.c fdt_strerror.c fdt_sw.c \

-- 
Regards,

Laurent Pinchart
