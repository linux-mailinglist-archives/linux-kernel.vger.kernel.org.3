Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071CD4E61AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349478AbiCXKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbiCXKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:24:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E10225C40
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:23:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so9033639pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6hR2jbQSg4CSVD3f4OWHAyVNhhJ8Mh8GIYUAWVOX8mI=;
        b=lDRfzFWKN+5QH11AqFkY+X0pvWQbEiGu6cKjWqwqTw1H/Ust18pn80OYh+WDRmxqiU
         oOkEV1BTuW9pjT9LGHs6Z7H6LCFIuGQ2PqHzLqmOIrQKVI/8Ir1D6J0s2dntoNargGnd
         IaD1eOS/3kr5X44JQDlm4bMfFE/QvjHEexKs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hR2jbQSg4CSVD3f4OWHAyVNhhJ8Mh8GIYUAWVOX8mI=;
        b=rnXo/qndmpIi0UlXZHCgyCSradiJdLDhcwtc/NI3FtcBIHmR4Z8pCETFvq8QX0eQ1E
         7MHBt0SWdGRgkLl9fLDJC0OIBZfqW4rLbAOpINlCd59awtaUvheYnMmLPBywYb8mzeiR
         mBO+UxcfUN1MkFslWA/DO9Cvs86YIHw+AT7Nz+DYX5cOGSIaovKcw6KnvQItksBkKDA1
         qLOPThsJgFXiLp/0VwiSTYCsesfGavTk9M9XycF0h/V9n5FpqOJwWugx0hGKsmvvnD4z
         OVoUKIz81Df47nm9/PNL/Gj6vIA6JoD2WIjGCalKoJT/hw185hMQ15iOVMuqxhhIGU4f
         x4Lw==
X-Gm-Message-State: AOAM531JHXY67FSPo/aX5oyK5KIB5j4m7Z5DTRB2alqrerUM7tHc7fp8
        Ivyt+MySPjMCwiNX6PuUSSyQtA==
X-Google-Smtp-Source: ABdhPJxq+/6bheF0HDrYCcPoo4W5reCHHq/NFJ/3QA9yOmyTPlanPgLY0yPNXRyzPODHB0KRBx8MhQ==
X-Received: by 2002:a17:902:c652:b0:154:2920:df6d with SMTP id s18-20020a170902c65200b001542920df6dmr4906472pls.146.1648117401888;
        Thu, 24 Mar 2022 03:23:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f22a:8f8e:aca1:9b8c])
        by smtp.gmail.com with ESMTPSA id rm5-20020a17090b3ec500b001c7559762e9sm9066552pjb.20.2022.03.24.03.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 03:23:21 -0700 (PDT)
Date:   Thu, 24 Mar 2022 19:23:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     mchehab@kernel.org, senozhatsky@chromium.org, caihuoqing@baidu.com,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dvb_vb2: fix possible out of bound access
Message-ID: <YjxGlIyYiULyAXy6@google.com>
References: <20220324080119.40133-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324080119.40133-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/03/24 16:01), Hangyu Hua wrote:
> vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
> controlled by the user.
> 
> Fix this by adding range checking code before using them.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
