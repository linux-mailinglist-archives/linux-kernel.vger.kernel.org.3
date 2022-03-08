Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3256F4D0D2C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbiCHBDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbiCHBDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:03:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF95513CE6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:02:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s18so2380309plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 17:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IQhQfdyAYX0hi+PVQadBhMRNa+RqPQDnBvDh+DXAqhM=;
        b=HSfkVz9Q6Pa2zrc+4YcAi2KqtAzvzGmgBcSN2wKP5SnCQkYC9QUUIV0HyHnZhtEwQE
         Foj27M9l6QUFm2WpJusLFG2SN1w6D40VilTdXf8Qb+YHvJoUTbRpsmbocsXymYlVbcVG
         kw7Gswp2cPEyORz3FM1f4BfkW1uTkjRzIbJI4wP4W5+hMIjQMGs9K/OUBSokunYqrFtm
         xxa/Zn5FbnTgB3J01SktScNAG7AZMcDdoAwK9b0gkSZLEajTH7E6U3j4zXmEjaNBFGvl
         njHCqzI9vzfioDA3orK9TxE4gqd2XZqp1Hv4POAxZEcQs7mWkSmY3ThZngtEcVJgcMe2
         MsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IQhQfdyAYX0hi+PVQadBhMRNa+RqPQDnBvDh+DXAqhM=;
        b=2CMSkTPVYGermiiGHHrAcMKAWC8iNbjn2nRJczXVjk3XPg+9XjV7dPJ0CwOS0dM2R6
         XibEJ7s6l3Jp2UdhMzUgP1AHynDWBwtVoH7gFxVWUkLS1lIkldSjX9HZ8WmUsS/iKHRA
         IkVWZMWgUJLnSuCRvOBMmIkG6rY1Ov/OdoKFrflu7UGMJjzmTMZUVYjkLUu/b8ToRUdk
         TiT/OkwIvWkQ667a0iPFzlaHcEXldZYyqWsnteDdBuxzCQs5Xi9YeNyBZ5/aQCPFMnml
         jaKQKUHiZ585vhrtUJ0ziyBnk+PAF9/hR9xCks3lqxfV0uQkLHPnnynP/YFIkyPgGFM4
         agMw==
X-Gm-Message-State: AOAM531qZ56iv5ubuUcwheR/97/VRfDemcz96GRxdnraHzaM/4bzhVlo
        buFwQHtJdhpYB5aSfMr7bqGlJAXXIPs=
X-Google-Smtp-Source: ABdhPJwZnDQ1F4ifgdx+Dtyw0yyGpDrMRX0V5AAKdHjC4bDgwm72gBJVW8xM5BZ3M3ZQkEXqija3hw==
X-Received: by 2002:a17:902:ce0d:b0:151:c3fa:1044 with SMTP id k13-20020a170902ce0d00b00151c3fa1044mr14713505plg.27.1646701357317;
        Mon, 07 Mar 2022 17:02:37 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8200:33:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d202-20020a621dd3000000b004f6f21593cesm6574832pfd.220.2022.03.07.17.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 17:02:36 -0800 (PST)
Date:   Mon, 7 Mar 2022 17:02:34 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Min Li <min.li.xe@renesas.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ptp: idt82p33: use rsmu driver to access i2c/spi bus
Message-ID: <20220308010234.GD6994@hoboy.vegasvil.org>
References: <1646694972-15133-1-git-send-email-min.li.xe@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646694972-15133-1-git-send-email-min.li.xe@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:16:12PM -0500, Min Li wrote:
> rsmu (Renesas Synchronization Management Unit ) driver is located in
> drivers/mfd and responsible for creating multiple devices including
> idt82p33 phc, which will then use the exposed regmap and mutex
> handle to access i2c/spi bus.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

This patch should be sent to the netdev list to be merged.

Acked-by: Richard Cochran <richardcochran@gmail.com>
