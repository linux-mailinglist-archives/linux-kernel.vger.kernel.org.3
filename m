Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2DC562322
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiF3T3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiF3T3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:29:31 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2439433B7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:29:30 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t189so576283oie.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fhTlI95dhMQbdEg/ufyk+UwC70ISSv1cQXARFGMlr9w=;
        b=uNEpkb+duVeG68QoyxqUVOuYFKeM8jvvXhZpnf0CVl9+N7LvKt2TXIwLnNz4N2f/Hk
         bODPNzb5TiFPtcVrYJv1DOSL/uI0KmLXaUOl91KwOzCWY1Q2J7BNlawzG3dtbPfX9Fj3
         IsTSaVvG2Li1vLAYH0gW4YMV9XrCgosYWe++ejitpn+4sYldz+vMPh+tu1udWKRrfv9m
         kQp4T3rv1pFQ8xGZRSZfjLvgBmq96R3lOd9xdE2s/pL6XRUDDqdwKMxUFqDPuaFR/NzV
         GGISO9HAXQs7VOO/NnrFQMoKOsG/M8ItJ8ldiJwe+WhStMwe98Siak+zYD7ixqUqKlk8
         kzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fhTlI95dhMQbdEg/ufyk+UwC70ISSv1cQXARFGMlr9w=;
        b=Kqg/UyJI6FqIb0ymFVjRCep92/FXQkPFk6dO0k0/iNlZX0EGu5QVKfH2ZRlG/PmShU
         A/GXxDRlSszz02z4sp0OooKbmp6VgPJEUvEtSCJkwDR46wW0bD5rJXyW+2iM3shwKssk
         hLiCz4/0pdjIjreKceuteR9aQzv7h1NLDgnBZSgaSZwEfn0Bq+0E2ER6BTdPUnzjGAi+
         v0hKPw8+zI9aEkuhccIfxLP2TST0J1IW+hYIzQ01ChgGOhwR2MWFoSs207OGyVhOipl4
         k+N4By7fg+VDv+s1l8ZxK4ugSjg/3cMjszx7n1mE0Do4zsF+9Y0v+neEzUKsGy2Jhk8c
         rSmw==
X-Gm-Message-State: AJIora80vnia1ClEqpoJU8yTSuPaUN+5CUlFx0SgEUrcqtKXu9qz66jz
        a8keB744JXlQCG/knGDDbdZlKQ==
X-Google-Smtp-Source: AGRyM1vKCHlTcfruP18DhjDQDCsUTzTvsVJBE7ndA2a+KgvmK0GRID9hZwZWTKcgcJ0zFL6R2xWyRw==
X-Received: by 2002:aca:a913:0:b0:335:1bd8:2d03 with SMTP id s19-20020acaa913000000b003351bd82d03mr6405481oie.56.1656617370187;
        Thu, 30 Jun 2022 12:29:30 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t2-20020a4ad0a2000000b0042599b92c21sm8721746oor.47.2022.06.30.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:29:29 -0700 (PDT)
Date:   Thu, 30 Jun 2022 14:29:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     dmitry.baryshkov@linaro.org, agross@kernel.org,
        mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: pas: Add decrypt shutdown support for
 modem
Message-ID: <Yr35lyyX+u76m/Tu@builder.lan>
References: <1653031684-14771-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653031684-14771-1-git-send-email-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 May 02:28 CDT 2022, Sibi Sankar wrote:
> +static int adsp_decrypt_shutdown(struct qcom_adsp *adsp)

Forgot to write down one comment, how about naming this
adsp_shutdown_poll_decrypt() to make it slightly more clear from the
name what's going on here?

Thanks,
Bjorn

> +{
> +	int retry_num = 50;
> +	int ret = -EINVAL;
> +
> +	while (retry_num && ret) {
> +		msleep(ADSP_DECRYPT_SHUTDOWN_DELAY_MS);
> +		ret = qcom_scm_pas_shutdown(adsp->pas_id);
> +		retry_num--;
> +	}
> +
> +	return ret;
> +}
> +
