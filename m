Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCC5250A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355619AbiELOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351927AbiELOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:52:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C963389
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:52:28 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id m6-20020a05683023a600b0060612720715so2863790ots.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bb5erSJHP1iwPKC6T9LjpPBBOxxIiwttxQXC8w5mYu8=;
        b=etm0lobu5FolOOIbbRC1gTjRukAyx739a0QZbGNCdAlgTDwqWf0SJUbw4uV+RUcWeb
         /7vI6bBAroHt/coUhfGvKGw18uuzbC5dql3qtN2ta1MXhCFr3Cw1oGV3x1ari4hRu45D
         k5p9EsNepdDsv3xa1oU6VUgGVWTGpK5uPOICRnwejFpxKLIhywErASFF85PV1IWOJlzs
         1pAfDDP9yCSQLCqoayX9wvQ8lb/nMmbvI3cXPay+XtL4s1oCCLGJxX2cgokE3gq5oSkW
         Esfc/jpA0/FZwCMOtI6IaNfQogY6t5UGdNhm5EBcPR+JQNY13bPGTgODSlvqmaEkmx5k
         LSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=Bb5erSJHP1iwPKC6T9LjpPBBOxxIiwttxQXC8w5mYu8=;
        b=mQQ4K6hZy1Zu01AduynnqWZuuuJXmVZfxeYTr2yx0WaL3EnMAwGgrx44ngm7CkdvQm
         HFs2dMJSf73tHTZ2z9X8DLcwsY13qCU6gXV3UVmSVONjOc/CBO39tus2YhFAoNoyeQsn
         ftAGBUqsUhF2DTqKidK3vWCcctvvLPqUFh2O823/rLCfASy7UDQAA14H+GEHL4KsTOBP
         rRT7XzQtrltGc18r/sgr2usB5pibpcn3YqOuM44jf5UUz2JkP+tAMjTfcWY0U5VAyFtL
         DH5I9X4hCFPRK2m3ry6rRzmrLy4WO9BAx9sM8FJ2ZhwMbVFWLl0KWqFZCtmvQ3MI3W7A
         Oa1Q==
X-Gm-Message-State: AOAM5313yifKOF0VeRaohlOYXK0ydfZXSFanS12W5LwXtdZ92c8MzNce
        L+GCFxXYWRJxWWsVHTTdmWk3mFsfOg==
X-Google-Smtp-Source: ABdhPJxCBEdr43lYPd9Wth40t85my61ye9hP04vwSZVH7Eyf+aN5aOh0uUmmQFZBFz4RDn+3SkrH7A==
X-Received: by 2002:a05:6830:1d3:b0:606:4067:3b65 with SMTP id r19-20020a05683001d300b0060640673b65mr132675ota.142.1652367147471;
        Thu, 12 May 2022 07:52:27 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 3-20020a9d0d83000000b00606a6f74748sm2001994ots.25.2022.05.12.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:52:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:6cc1:236c:b6d0:edc9])
        by serve.minyard.net (Postfix) with ESMTPSA id CF8431800B7;
        Thu, 12 May 2022 14:52:25 +0000 (UTC)
Date:   Thu, 12 May 2022 09:52:24 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe
Message-ID: <20220512145224.GM3767252@minyard.net>
Reply-To: minyard@acm.org
References: <20220512044445.3102-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512044445.3102-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:44:45AM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.

Thanks, applied and backport requested for 5.17.

-corey

> 
> Fixes: 00d93611f002 ("ipmi:ipmb: Add the ability to have a separate slave and master device")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_ipmb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
> index b81b862532fb..a8bfe0ade082 100644
> --- a/drivers/char/ipmi/ipmi_ipmb.c
> +++ b/drivers/char/ipmi/ipmi_ipmb.c
> @@ -476,6 +476,7 @@ static int ipmi_ipmb_probe(struct i2c_client *client,
>  	slave_np = of_parse_phandle(dev->of_node, "slave-dev", 0);
>  	if (slave_np) {
>  		slave_adap = of_get_i2c_adapter_by_node(slave_np);
> +		of_node_put(slave_np);
>  		if (!slave_adap) {
>  			dev_notice(&client->dev,
>  				   "Could not find slave adapter\n");
> -- 
> 2.25.1
> 
