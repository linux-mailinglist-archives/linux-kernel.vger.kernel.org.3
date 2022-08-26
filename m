Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691D65A308E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344954AbiHZUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344914AbiHZUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:39:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD4CC33E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:39:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r10so3388626oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dddmhs6+o4Xh9+N13zA/oRm8MafN5+Bs+QATExsKyJY=;
        b=hKBtKzMs03S28uiZi6W8K8XZgK75JXvAxKo69eY/sQekyRhp1YDNE92qlzZ1RrAq3M
         QsDsiQB7qxj8u5WGLGJHEZN07uqx4uc0DTtu5I/rzwTBshwnXs6bsC5fraE+DzBgABfq
         lJf137qOxIx2CcV4CeSlhGUTvJUGsGWMiR+hC4BwUa4b2NwK/oVTNO2xok8F82P7n4Ep
         RxPpF7+nfDHOA1DhvwWcT2s2Vm11G62IR+Bl5ajoBGVZxYxGlU+DLmQ61DOgfjg35AOy
         zGeumYcJWLrbLg4asbyORIc7ded9kdzu0zs+lFpE60Shh652rk31pj+32mP95lMFUTfH
         idkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dddmhs6+o4Xh9+N13zA/oRm8MafN5+Bs+QATExsKyJY=;
        b=otal6CPKzJaZWVwBa4heCwwZUJOml1e/ySs4H4qz2pm/55AIsaowQCz8dnD4tdjJlm
         zkL5wGsLtYZkBSmES9AHnW7ty5s6QQem6zc/zqqmw2p7UUAuLOnb5Cl5V4dMPO2oegIA
         B165SM2idL3RcuMjSubH3DjnDDbL0C1cXX3gMPu9aw/dMzf5QDsqgyOL+W6HvJM801WE
         GqCtJt7EaQhPh/F9W03n5ZljpoktnIIUDBdu6XE8lEtotn/5V1Yll8U0UDrhgP0QqKs7
         P9sDoEpYQpCY53Exnpec7d1Q+SHA6SDymS7djJ4tMx5KZwvETmRI17Vova/7GY7hXNL0
         wwKw==
X-Gm-Message-State: ACgBeo3oZwbftI1mvTJvERbCTD2V7vNEC2uN7qzV98o0NsansYIDl/ER
        rOJK1rFlzFgDWqaC2iT7vc2kSIihhonxBzyttsA=
X-Google-Smtp-Source: AA6agR5YV12hxD8EP5woASxrumAqZLtWB2nIX2ZgJ6CEQXi1v32YpdrloQb1NynuwLMpljxfEtaSTgJaT+IXUD3ZTbs=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr2542948oib.46.1661546372683; Fri, 26
 Aug 2022 13:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220826084121.94319-1-sunliming@kylinos.cn>
In-Reply-To: <20220826084121.94319-1-sunliming@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 26 Aug 2022 16:39:21 -0400
Message-ID: <CADnq5_O2WoDxCJG0rx_x1VhqVHxDT8Aa-X1h+5XwPALiO=8qOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix variable dereferenced before check
To:     sunliming <sunliming@kylinos.cn>
Cc:     Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch,
        kernel test robot <lkp@intel.com>, kelulanainsley@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Aug 26, 2022 at 4:41 AM sunliming <sunliming@kylinos.cn> wrote:
>
> Fixes the following smatch warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dc_dmub_srv.c:311 dc_dmub_srv_p_state_delegate()
> warn: variable dereferenced before check 'dc' (see line 309)
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> index 09b304507bad..ebf99e8f93e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -323,11 +323,13 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
>         struct dmub_cmd_fw_assisted_mclk_switch_config *config_data = &cmd.fw_assisted_mclk_switch.config_data;
>         int i = 0;
>         int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
> -       uint8_t visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
> +       uint8_t visual_confirm_enabled;
>
>         if (dc == NULL)
>                 return false;
>
> +       visual_confirm_enabled = dc->debug.visual_confirm == VISUAL_CONFIRM_FAMS;
> +
>         // Format command.
>         cmd.fw_assisted_mclk_switch.header.type = DMUB_CMD__FW_ASSISTED_MCLK_SWITCH;
>         cmd.fw_assisted_mclk_switch.header.sub_type = DMUB_CMD__FAMS_SETUP_FW_CTRL;
> --
> 2.25.1
>
