Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7DC4AD12E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbiBHFkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbiBHFhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:37:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E0C03FEF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:33:14 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qe15so5684906pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 21:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VGd6HWV0yqMQeeGM8GVnBobXYQMdfcC12IoRPz2yYaw=;
        b=oP2byjRZAi5hESJPONGrGc2WSkRkCT6bDoBZ+TLZKcK6dM0DtVYhdV7QeWI4psiPfo
         CsBBTWCpSt93N7U+YkE+PUY3osuPKCxDapOXQvtRMtGQhWVpaGcz5/IKKm/j6E9On2po
         PpcTrDx7MvE3U8wF1USqzf0jhcUzGEdBvQA1aw/x31MvVpSPqKMmm7+VyaoNorJNdqgl
         bc0rCF+KWWlSKMduQ9gvYEDxs/XdHokDMUoHLOzV1W4cUnI2pcauGVpSbAATOgFG185D
         62zBwGOAO7dUK7Ib+AWN2SQHqc7sT263q29OTcB/B/n/pyC7qYDudqPkUnrErOzunf5s
         vTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VGd6HWV0yqMQeeGM8GVnBobXYQMdfcC12IoRPz2yYaw=;
        b=6XjDqRzgvJbstJDkyuNPdFY++2G6fNdxYYIZ1oo5iSOxbFqImsognxt/qhONMUEG/Y
         f+Kq89k6gZJvhexEx+uczs2Vv1/9EKSJx6ApQFniG8PaUYBTwkfTFwtmc72ALbC7BNij
         Y/0ekenN/AOg4TKdaOretntYsTQ3V+ZCm1vFxO3MAO6z+RjuZkwrpS4hnbAToi+ShCWb
         GFHTVg9/sw42h87o2vJjzSNXpQEVBNSxCGd6cLYxF+lCJQ9WKNFf03p88XzqS5LM7pki
         4bzd44B3jBuKuRBKPWVOn7TtJ469107nSFCk9biwRvYlIlqN+AgTrb0wA+JpzcpPmaON
         x29w==
X-Gm-Message-State: AOAM532qm5j/KYwLHMPJEsWVmhItgQfLDa2Rca627teSq/U4Sd2ekY4U
        hcgbyoceEtQFT24JQEtHnTXm3w==
X-Google-Smtp-Source: ABdhPJx+ZX3FQoFvCoRWstQ5b1GqhHj7gcqWkX68TI0XRke0VrZStlxNEMKUGTCHUcqJNFkafXh8gg==
X-Received: by 2002:a17:90b:1c83:: with SMTP id oo3mr2642964pjb.6.1644298393853;
        Mon, 07 Feb 2022 21:33:13 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:4b6f:f14d:be50:86a])
        by smtp.gmail.com with ESMTPSA id m14sm14470811pfc.170.2022.02.07.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 21:33:13 -0800 (PST)
Date:   Tue, 8 Feb 2022 13:33:11 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/4] platform/chrome: cros_ec_typec: Move mux flag checks
Message-ID: <YgIAl8do1/b1Dru9@google.com>
References: <20220207214026.1526151-1-pmalani@chromium.org>
 <20220207214026.1526151-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207214026.1526151-2-pmalani@chromium.org>
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

On Mon, Feb 07, 2022 at 09:40:24PM +0000, Prashant Malani wrote:
> Move mux and role flag checks inside of cros_typec_configure_mux(),
> which is a more logical location for them.

nit: s/Move/Moves/.

> @@ -519,7 +519,14 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	struct ec_params_usb_pd_mux_ack mux_ack;
>  	enum typec_orientation orientation;
> -	int ret;
> +	int ret = 0;

The change looks irrelevant to the patch.
