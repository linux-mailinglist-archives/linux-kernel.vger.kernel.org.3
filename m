Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C421559EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiFXQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiFXQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3A0450E2A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656088832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8dnSmLnMjgwT5vMe64j54S8t18apFExaSS8ijTHrlc=;
        b=gzOjHfXkIT3di6ezYgrW3bN57fPLp1rPdPebCQ83nuj0ALDYI522W8/lS3HsH+w93/0p7t
        19U7e+aT30czODIix3qDKttViqhlCex9sQ+SsNfPvgX/uAVX88c1QqjkNAETVXYNR6CI0Y
        j63ij4tObE4WRJcdlzdEb+XJCviIOhg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-qn0zNnkUPrawWugD4QH3mw-1; Fri, 24 Jun 2022 12:40:29 -0400
X-MC-Unique: qn0zNnkUPrawWugD4QH3mw-1
Received: by mail-qk1-f199.google.com with SMTP id w16-20020a376210000000b006af059b17b7so2304946qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8dnSmLnMjgwT5vMe64j54S8t18apFExaSS8ijTHrlc=;
        b=jyp7FwmkyIyf1O+KK8/8OLC3/B9nJWu0mrjS0nF21Udu0ofBCT0WQ5b9XqIZyzTPgw
         03+kOLYx683f3UNkTvUD2looa/uEjJPj017tJWSQQRUqftUVXUIvEIwdNbImLHgXQHGU
         ZroXXUnEGEpOGgjgQ8AdmX11Inq9ElmbpCd7/V3b4dDtPR2mu0smn9zXqZYsUN/vljVT
         88Vyl52DXqLi6RNh+Mj+4wy2Svj6YDloCjfjj7zqM3c2T1gOcDUkTCucZmrkgkpyVzl6
         JZjVK+Jg6CbTbGEIcXhVW/7jWuJNt8cIgMEomkYW2rNUSVpRjYw8o8AvRwQIiQyzTuMG
         pnBw==
X-Gm-Message-State: AJIora9WdtQz1ZdERsQdCi4yHiqZCScOs92YgAIWRsMXBHJPH8vzRfXK
        YfiFu/BvAA9arv/02J4BDuAInLfEhEKwnQjsF3PhH9OdJJSROQY21rzB7jHS7cdrIFJo568fb6l
        o7dPp+ybDP20Xkhxh4hLy61T7
X-Received: by 2002:a05:620a:570:b0:6ab:91fc:59c6 with SMTP id p16-20020a05620a057000b006ab91fc59c6mr11437616qkp.707.1656088828951;
        Fri, 24 Jun 2022 09:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqIV6HjcrEOXeE3hIpiQoSxjY9PaPqQRY3anfHa/xGyouZ9QZhIZc62/U1nlcbovrv0ARCZQ==
X-Received: by 2002:a05:620a:570:b0:6ab:91fc:59c6 with SMTP id p16-20020a05620a057000b006ab91fc59c6mr11437579qkp.707.1656088828311;
        Fri, 24 Jun 2022 09:40:28 -0700 (PDT)
Received: from xps13 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a2a0100b006a79479657fsm2408131qkp.108.2022.06.24.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:40:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 12:40:26 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH] clk: qcom: sc8280xp: add parent to gcc_ufs_phy_axi_clk
 for sa8540p
Message-ID: <YrXo+i3wwl2ERKIj@xps13>
References: <20220623142837.3140680-1-bmasney@redhat.com>
 <20220624002055.58BCFC341C0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624002055.58BCFC341C0@smtp.kernel.org>
User-Agent: Mutt/2.2.5 (2022-05-16)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 05:20:53PM -0700, Stephen Boyd wrote:
> Quoting Brian Masney (2022-06-23 07:28:37)
> > diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> > index 4b894442fdf5..4639b50da418 100644
> > --- a/drivers/clk/qcom/gcc-sc8280xp.c
> > +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> > @@ -5696,6 +5709,7 @@ static struct clk_branch gcc_ufs_phy_axi_clk = {
> >                 .hw.init = &(const struct clk_init_data) {
> >                         .name = "gcc_ufs_phy_axi_clk",
> >                         .parent_hws = (const struct clk_hw*[]){
> > +                               &gcc_ufs_ref_clkref_clk.clkr.hw,
> >                                 &gcc_ufs_phy_axi_clk_src.clkr.hw,
> >                         },
> >                         .num_parents = 1,
> 
> num_parents needs an update. 

Oops!

> But this is a branch, not a mux, so it can't have more than one
> parent.

Would a mux be represented with 'struct clk_rcg2'?

Brian

