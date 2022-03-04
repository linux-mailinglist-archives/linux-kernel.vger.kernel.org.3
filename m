Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75954CD3C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiCDLtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiCDLtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:49:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F818CC29;
        Fri,  4 Mar 2022 03:48:52 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A43951C;
        Fri,  4 Mar 2022 12:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646394530;
        bh=Tpmci2229+d69SIklAmDsEQusgFyc/vp2PTOJIMLm2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mn7A7sk9koDrV8kFK7nOrLrJz4m5dHtM1/DeQzlt/y3cqkV0pcKzwQO18olJzNJbt
         AnjrfaRVlWXsDgZJCGTBtWG1wnIbPv+tA4png3K5nU6+BNuwX0wMXH/76ehXTptVHq
         5kLuAQW656aszJpVgIgsLGLK7dcVyltzcjHN71m8=
Date:   Fri, 4 Mar 2022 13:48:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to
 dt-validate
Message-ID: <YiH8lWq8gOnaQ+7G@pendragon.ideasonboard.com>
References: <20220303224237.2497570-1-robh@kernel.org>
 <20220303224237.2497570-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303224237.2497570-2-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 04:42:36PM -0600, Rob Herring wrote:
> In preparation for supporting validation of DTB files, the full
> processed schema will always be needed in order to extract type
> information from it. Therefore, the processed schema containing only
> what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> gained an option, -l or --limit, to specify which schema(s) to use for
> validation.
> 
> As the command line option is new, we the minimum dtschema version must be
> updated.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 28 +++-------------------
>  scripts/Makefile.lib                       |  3 +--
>  2 files changed, 4 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 61ec18ecc931..246ba0ecab64 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
>  DT_SCHEMA_LINT := $(shell which yamllint || \
>    echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
>  
> -DT_SCHEMA_MIN_VERSION = 2021.2.1
> +DT_SCHEMA_MIN_VERSION = 2022.3
>  
>  PHONY += check_dtschema_version
>  check_dtschema_version:
> @@ -25,9 +25,6 @@ quiet_cmd_extract_ex = DTEX    $@
>  $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
>  	$(call if_changed,extract_ex)
>  
> -# Use full schemas when checking %.example.dts
> -DT_TMP_SCHEMA := $(obj)/processed-schema-examples.json
> -
>  find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
>  		-name 'processed-schema*' ! \
>  		-name '*.example.dt.yaml' \)
> @@ -70,29 +67,10 @@ override DTC_FLAGS := \
>  # Disable undocumented compatible checks until warning free
>  override DT_CHECKER_FLAGS ?=
>  
> -$(obj)/processed-schema-examples.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
> +$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema_version FORCE
>  	$(call if_changed_rule,chkdt)
>  
> -ifeq ($(DT_SCHEMA_FILES),)
> -
> -# Unless DT_SCHEMA_FILES is specified, use the full schema for dtbs_check too.
> -# Just copy processed-schema-examples.json
> -
> -$(obj)/processed-schema.json: $(obj)/processed-schema-examples.json FORCE
> -	$(call if_changed,copy)
> -
> -else
> -
> -# If DT_SCHEMA_FILES is specified, use it for processed-schema.json
> -
> -$(obj)/processed-schema.json: DT_MK_SCHEMA_FLAGS := -u
> -$(obj)/processed-schema.json: $(CHK_DT_DOCS) check_dtschema_version FORCE
> -	$(call if_changed,mk_schema)
> -
> -endif
> -
> -always-$(CHECK_DT_BINDING) += processed-schema-examples.json
> -always-$(CHECK_DTBS)       += processed-schema.json
> +always-y += processed-schema.json
>  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dts, $(CHK_DT_DOCS))
>  always-$(CHECK_DT_BINDING) += $(patsubst $(srctree)/$(src)/%.yaml,%.example.dt.yaml, $(CHK_DT_DOCS))
>  
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 79be57fdd32a..9f1e8442564e 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -361,9 +361,8 @@ $(multi-dtb-y): FORCE
>  $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
>  
>  DT_CHECKER ?= dt-validate
> -DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),,-m)
> +DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
>  DT_BINDING_DIR := Documentation/devicetree/bindings
> -# DT_TMP_SCHEMA may be overridden from Documentation/devicetree/bindings/Makefile
>  DT_TMP_SCHEMA ?= $(objtree)/$(DT_BINDING_DIR)/processed-schema.json

This could now use := instead of ?=

Apart from the fact that 2022.3 hasn't been tagged yet as pointed out by
Geert, this looks fine to me (but I'm no expert in this area).

>  
>  quiet_cmd_dtb_check =	CHECK   $@

-- 
Regards,

Laurent Pinchart
