Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A94E23B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346016AbiCUJ6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346064AbiCUJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:57:44 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B600D137F5D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:56:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r22so8627773ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eI81Cj2MzQaMOBuzQ4GEFQs/9QyzMW3B2HHtrtblKg8=;
        b=YJPfZoOkdyk0Tw+7qRPh58EnUzvFx/fTdWHKqFyZmi3tjW/JAmH3VGGB6hObEkNF0f
         X0RBZ4rFRZjCkceuK4AvtYTZ0Uf/x6DyBNOVb41hXmyMNV+utHkwvIHDTIgqgqbftgdd
         5tfiuGzD/H+vzXqPKSHeWCUgJyX0iF+wfruDFv3yDaTNPficgmjOQwYiJ2mzRqvMBanK
         Sc12hG92iiqKORIdhiqE/vH6cKhFY81FHUJGNeEmPi/hKJjFCZRsmi1FmX8Awapf2jl+
         A/8jlPesJR25JMWH2giDPCUb73DyLoEa2UqWyTzzRdAhzUQQyQDJmJg62cUHcy5Zfw4T
         HndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eI81Cj2MzQaMOBuzQ4GEFQs/9QyzMW3B2HHtrtblKg8=;
        b=4BulkFeoRgaURTy5ffgv3PR73bKWs9b+yJP7z5LdH0dHHH9mnzy1ILOldMV/3RZwW/
         ZJHwBPdozpdBk5GjhXWJUTLeDls+HFypryhwh6eqGRTOL//rZa1taLtmUcorj3OMDukr
         zqDnCOkzNAT4EZqG1n7Rn3QSSsDcxe+s4DG0XXLsK6jmKGFwmXPJuNJHn9bidn+hDUAB
         /FeLl3xE/OsSJFpHpXDF27cNWAWsaOEnOb1vGF1cVTQfSe5nR3vJe48JPpOQ5TzVofYa
         Ixhpedm/X59mSkokiF8EwDdUnpo/ZQhkSuofyrcJdTuF7yrAWHNXbLsinYIddF6LVxYH
         6uQQ==
X-Gm-Message-State: AOAM533+jqXE4q723HigE7GFBRf3oZkITSSRgVWXdG71zLeHpNePNx77
        iuEcXpS2H2eCt3vUP6LjXKlE6g==
X-Google-Smtp-Source: ABdhPJy0UT1aElj4+q/uZ+QoYpSKFRtuFmYPQhlHb8WqNQdNafN1f0TRcyUfBcsRmw4yj14/DLBiFw==
X-Received: by 2002:a17:907:971f:b0:6df:a42d:7b00 with SMTP id jg31-20020a170907971f00b006dfa42d7b00mr17609349ejc.159.1647856577608;
        Mon, 21 Mar 2022 02:56:17 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b006df78d85eabsm1898054ejl.111.2022.03.21.02.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:56:17 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:56:16 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
Cc:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, oliver@neukum.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyd12@chinatelecom.cn
Subject: Re: [PATCH v5 4/4] net:bonding:Add support for IPV6 RLB to
 balance-alb mode
Message-ID: <YjhLwNoTbg1UU2qH@nanopsycho>
References: <20220321084704.36370-1-sunshouxin@chinatelecom.cn>
 <20220321084704.36370-5-sunshouxin@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321084704.36370-5-sunshouxin@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 21, 2022 at 09:47:04AM CET, sunshouxin@chinatelecom.cn wrote:
>This patch is implementing IPV6 RLB for balance-alb mode.

As I stated in the other thread, I strongly believe it is bad idea to
add this code. It is not needed. User should use LACP and not obscure
ALB/RLB mode. It should not be extented. On contrary, I would like to
see this going opposite direction and eventually remove ALB/RLB mode
from bonding.
