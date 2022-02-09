Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF39F4AF092
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiBIMCa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 07:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiBIMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:01:27 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E633C03324A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:52:36 -0800 (PST)
Date:   Wed, 09 Feb 2022 11:52:21 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v13 0/9] MIPS: JZ4780 and CI20 HDMI
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org
Message-Id: <9ZC17R.T1L0TBAW7MJA3@crapouillou.net>
In-Reply-To: <cover.1643819482.git.hns@goldelico.com>
References: <cover.1643819482.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

I tried applying patches 1-2, but they don't apply cleanly on top of 
drm-misc/drm-misc-next.

Could you rebase on top of that tree?

Cheers,
-Paul


Le mer., févr. 2 2022 at 17:31:14 +0100, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> PATCH V13 2022-02-02 17:31:22:
> * 7/9: remove call to gpiod_set_value() because of GPIOD_OUT_HIGH (by 
> paul@crapouillou.net)
> * 4/9: replace ".." by "." (by paul@crapouillou.net)
> * 3/9: remove old hdmi-5v-power in the example (by 
> paul@crapouillou.net)
> * 2/9: disable handling of plane f0 only for jz4780 (by 
> paul@crapouillou.net)
> 
> PATCH V12 2022-01-31 13:26:54:
> This version reworks how hdmi ddc power is controlled by connector 
> and not
> by ddc/hdmi bridge driver.
> 
> Also some patches of the previous version of this series have been 
> removed
> since they are already applied to mips-next/linux/next/v5.17-rc1.
> 
> Fixes and changes:
> 
> - repair interworking of dw-hdmi with connector-hdmi (by 
> hns@goldelico.com)
> - fix JZ_REG_LCD_OSDC setup for jz4780 (by hns@goldelico.com and 
> paul@crapouillou.net)
> - adjustments for ci20.dts to use connector gpio for +5v (suggested 
> by several)
> - to add control of "ddc-en-gpios" to hdmi-connector driver (by 
> hns@goldelico.com)
> - regulator code removed because we now use the "ddc-en-gpios" of the 
> connector
>   driver (suggested by paul@crapouillou.net)
> - bindings: addition of "ddc-i2c-bus" and "hdmi-5v-supply" removed 
> (suggested by robh+dt@kernel.org)
> - rebase on v5.17-rc2
> 
> PATCH V11 2021-12-02 19:39:52:
> - patch 4/8: change devm_regulator_get_optional to devm_regulator_get 
> and
>              remove NULL check (requested by broonie@kernel.org)
> - patch 3/8: make hdmi-5v-supply required (requested by 
> broonie@kernel.org)
> 
> PATCH V10 2021-11-30 22:26:41:
> - patch 3/8: fix $id and $ref paths (found by robh@kernel.org)
> 
> PATCH V9 2021-11-24 22:29:14:
> - patch 6/8: remove optional <0> for assigned-clocks and 
> unintentionally included "unwedge" setup (found by 
> paul@crapouillou.net)
> - patch 4/8: some cosmetics
>              make regulator enable/disable only if not NULL (found by 
> paul@crapouillou.net)
>              simplify/fix error handling and driver cleanup on remove 
> (proposed by paul@crapouillou.net)
> - patch 3/8: fix #include path in example (found by 
> paul@crapouillou.net)
>              fix missing "i" in unevaluatedProperties (found by 
> robh@kernel.org)
>              fix 4 spaces indentation for required: property (found 
> by robh@kernel.org)
> 
> PATCH V8 2021-11-23 19:14:00:
> - fix a bad editing result from patch 2/8 (found by 
> paul@crapouillou.net)
> 
> PATCH V7 2021-11-23 18:46:23:
> - changed gpio polarity of hdmi_power to 0 (suggested by 
> paul@crapouillou.net)
> - fixed LCD1 irq number (bug found by paul@crapouillou.net)
> - removed "- 4" for calculating max_register (suggested by 
> paul@crapouillou.net)
> - use unevaluatedPropertes instead of additionalProperties (suggested 
> by robh@kernel.org)
> - moved and renamed ingenic,jz4780-hdmi.yaml (suggested by 
> robh@kernel.org)
> - adjusted assigned-clocks changes to upstream which added some for 
> SSI (by hns@goldelico.com)
> - rebased and tested with v5.16-rc2 + patch set drm/ingenic by 
> paul@crapouillou.net (by hns@goldelico.com)
> 
> PATCH V6 2021-11-10 20:43:33:
> - changed CONFIG_DRM_INGENIC_DW_HDMI to "m" (by hns@goldelico.com)
> - made ingenic-dw-hdmi an independent platform driver which can be 
> compiled as module
>   and removed error patch fixes for IPU (suggested by 
> paul@crapouillou.net)
> - moved assigned-clocks from jz4780.dtsi to ci20.dts (suggested by 
> paul@crapouillou.net)
> - fixed reg property in jz4780.dtsi to cover all registers incl. 
> gamma and vee (by hns@goldelico.com)
> - added a base patch to calculate regmap size from DTS reg property 
> (requested by paul@crapouillou.net)
> - restored resetting all bits except one in LCDOSDC (requested by 
> paul@crapouillou.net)
> - clarified setting of cpos (suggested by paul@crapouillou.net)
> - moved bindings definition for ddc-i2c-bus (suggested by 
> paul@crapouillou.net)
> - simplified mask definitions for JZ_LCD_DESSIZE (requested by 
> paul@crapouillou.net)
> - removed setting alpha premultiplication (suggested by 
> paul@crapouillou.net)
> - removed some comments (suggested by paul@crapouillou.net)
> 
> PATCH V5 2021-10-05 14:28:44:
> - dropped mode_fixup and timings support in dw-hdmi as it is no 
> longer needed in this V5 (by hns@goldelico.com)
> - dropped "drm/ingenic: add some jz4780 specific features" 
> (stimulated by paul@crapouillou.net)
> - fixed typo in commit subject: "synopsis" -> "synopsys" (by 
> hns@goldelico.com)
> - swapped clocks in jz4780.dtsi to match synopsys,dw-hdmi.yaml (by 
> hns@goldelico.com)
> - improved, simplified, fixed, dtbschecked ingenic-jz4780-hdmi.yaml 
> and made dependent of bridge/synopsys,dw-hdmi.yaml (based on 
> suggestions by maxime@cerno.tech)
> - fixed binding vs. driver&DTS use of hdmi-5v regulator (suggested by 
> maxime@cerno.tech)
> - dropped "drm/bridge: synopsis: Fix to properly handle HPD" - was a 
> no longer needed workaround for a previous version
>   (suggested by maxime@cerno.tech)
> 
> PATCH V4 2021-09-27 18:44:38:
> - fix setting output_port = 1 (issue found by paul@crapouillou.net)
> - ci20.dts: convert to use hdmi-connector (by hns@goldelico.com)
> - add a hdmi-regulator to control +5V power (by hns@goldelico.com)
> - added a fix to dw-hdmi to call drm_kms_helper_hotplug_event on 
> plugin event detection (by hns@goldelico.com)
> - always allocate extended descriptor but initialize only for jz4780 
> (by hns@goldelico.com)
> - updated to work on top of "[PATCH v3 0/6] drm/ingenic: Various 
> improvements v3" (by paul@crapouillou.net)
> - rebased to v5.13-rc3
> 
> PATCH V3 2021-08-08 07:10:50:
> This series adds HDMI support for JZ4780 and CI20 board (and fixes 
> one IPU related issue in registration error path)
> - [patch 1/8] switched from mode_fixup to atomic_check (suggested by 
> robert.foss@linaro.org)
>   - the call to the dw-hdmi specialization is still called mode_fixup
> - [patch 3/8] diverse fixes for ingenic-drm-drv (suggested by 
> paul@crapouillou.net)
>   - factor out some non-HDMI features of the jz4780 into a separate 
> patch
>   - multiple fixes around max height
>   - do not change regmap config but a copy on stack
>   - define some constants
>   - factor out fixing of drm_init error path for IPU into separate 
> patch
>   - use FIELD_PREP()
> - [patch 8/8] conversion to component framework dropped (suggested by 
> Laurent.pinchart@ideasonboard.com and paul@crapouillou.net)
> 
> PATCH V2 2021-08-05 16:08:05:
> - code and commit messages revisited for checkpatch warnings
> - rebased on v5.14-rc4
> - include (failed, hence RFC 8/8) attempt to convert to component 
> framework
>   (was suggested by Paul Cercueil <paul@crapouillou.net> a while ago)
> 
> This series adds HDMI support for JZ4780 and CI20 board
> 
> 
> 
> H. Nikolaus Schaller (5):
>   drm/ingenic: prepare ingenic drm for later addition of JZ4780
>   drm/synopsys+ingenic: repair hot plug detection
>   dw-hdmi/ingenic-dw-hdmi: repair interworking with hdmi-connector
>   drm/bridge: display-connector: add ddc-en gpio support
>   MIPS: DTS: CI20: fix how ddc power is enabled
> 
> Paul Boddie (3):
>   drm/ingenic: Add support for JZ4780 and HDMI output
>   drm/ingenic: Add dw-hdmi driver specialization for jz4780
>   [RFC] drm/ingenic: add some more features specific to jz4780
> 
> Sam Ravnborg (1):
>   dt-bindings: display: Add ingenic,jz4780-dw-hdmi DT Schema
> 
>  .../display/bridge/ingenic,jz4780-hdmi.yaml   |  82 ++++++++++++++
>  arch/mips/boot/dts/ingenic/ci20.dts           |  15 +--
>  drivers/gpu/drm/bridge/display-connector.c    |  15 +++
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     |  13 ++-
>  drivers/gpu/drm/ingenic/Kconfig               |   9 ++
>  drivers/gpu/drm/ingenic/Makefile              |   1 +
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     | 106 
> +++++++++++++++++-
>  drivers/gpu/drm/ingenic/ingenic-drm.h         |  38 +++++++
>  drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c     | 106 
> ++++++++++++++++++
>  include/drm/bridge/dw_hdmi.h                  |   1 +
>  10 files changed, 367 insertions(+), 19 deletions(-)
>  create mode 100644 
> Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
>  create mode 100644 drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
> 
> --
> 2.33.0
> 


