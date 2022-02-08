Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077864AD130
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346692AbiBHFjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347074AbiBHFjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:39:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89636C03FEE2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:35:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id v74so17002163pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5++rdI0ZCWNhcJF9Ilqv0aOk35l2OcJh7Wbsyuqc6/E=;
        b=tcDzdm4a9mAzCZ2Y5FVfN7nHkgGzltgu/EMIfTzbrvddMVPWn/x84T/ysCG9mEZnGm
         BvNGlDvtRLYesNb+tVqpanRwatqOymYxEzChcUKNgrnAWX5FmfmLvwARnvJePwWkK7Cs
         xFk2lp92gZJ84ZKQQh3+0t46g8V9DLia9mj6W82NtDDqiTHTTJi1fzI1uj50QFlWQh5A
         5nhuJs2NMJ1EquCy5B2kU6iK/ixMoiLl8WKX/ERWAlsLcR2abBpUNUrf9yM8VDMIQLtb
         i7xq1PB8oc2NSdD+yUnTTDBHO9XOtY7urxFxKu20yAgSQcJ4d2fS1EpQKluyNPnN76fc
         ct8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5++rdI0ZCWNhcJF9Ilqv0aOk35l2OcJh7Wbsyuqc6/E=;
        b=kXGLefTmJjmU5+ioRBtJNa1V0beJelaxC1PufnF+EE2JnTwIvW6MfPlFhKVd6Px1U+
         TSpMhErZvKes6OcdeVPUVVWFAcnTC/75gbE5Emx1Kf2n2VRmGnjKinLILjnm7rvtVZY/
         k0RqkpoiB9Sh8zqjYiVG37oFJfxx5G+ocJuSMFK9qiMUAi+4q6+m4ROgsWmvQxPpL5x+
         uv1/ZZYgI4IN/u1UxziWpicZCN0XbWOCLGYhK2EXALcOtKoRAUGooFuE59039ZDnWeMl
         READdk54WjahLwq96MTQXEM0H4Gjd1Fhm3EC66YlWyWbPyJxV05ifgaqJ0crGgxee9q+
         gXrg==
X-Gm-Message-State: AOAM532LnN3miY5o95R/dJG/CA47cTKuzvlm6STgVDbF1kMNC18TGumS
        46baEyjs/G0fmhirrJ2TOkyx+A==
X-Google-Smtp-Source: ABdhPJxWfuxerOV2oKsf9gfNCpBlp6s/F+hNb9jAcsXRiXhxoWf2TUqLBnsdWoFORWvLI4irmmjtUg==
X-Received: by 2002:aa7:828c:: with SMTP id s12mr453619pfm.6.1644298533822;
        Mon, 07 Feb 2022 21:35:33 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id d22sm13850182pfl.71.2022.02.07.21.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:35:33 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:35:30 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/4] platform/chrome: cros_ec_typec: Get mux state inside
 configure_mux
Message-ID: <YgIBIlnLPiV+49HI@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-3-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207214026.1526151-3-pmalani@chromium.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:40:26PM +0000, Prashant Malani wrote:
> Move the function which gets current mux state inside the
> cros_typec_configure_mux() function. It is better to group those
> bits of functionality together, and it makes it easier to move around
> cros_typec_configure_mux() later.

nit: s/Move/Moves/.

>  static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> -				uint8_t mux_flags,
>  				struct ec_response_usb_pd_control_v2 *pd_ctrl)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
> +	struct ec_response_usb_pd_mux_info mux_resp;
> +	struct ec_params_usb_pd_mux_info req = {
> +		.port = port_num,
> +	};
>  	struct ec_params_usb_pd_mux_ack mux_ack;
>  	enum typec_orientation orientation;
>  	int ret = 0;
>  
> +	ret = cros_ec_command(typec->ec, 0, EC_CMD_USB_PD_MUX_INFO,
> +			      &req, sizeof(req), &mux_resp, sizeof(mux_resp));

It was `req` and `resp` in cros_typec_get_mux_info().  However, `mux_resp` for
separating from `struct ec_response_usb_pd_control_v2 resp` in
cros_typec_port_update().

It would be neat to be either {`req`, `resp`} or {`mux_req`, `mux_resp`} in
cros_typec_configure_mux().
