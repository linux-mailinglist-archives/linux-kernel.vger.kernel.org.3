Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A652B19D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiERErQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiERErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:47:14 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548028E16;
        Tue, 17 May 2022 21:47:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so4521552pjr.1;
        Tue, 17 May 2022 21:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I/ZxnolaAfKtvr5QsuelnELvi0uEaylPxvANAlsCccY=;
        b=muu0W3tKBN4mGUXbGQiTbv0DR674MVAEsfUs3sMliHKeizEJJBaDCFZBNYCz7jrUTe
         uV3bAssH3PEPK2xbxfGDececUj2WzUwUXnxQidLKZQQn7QoxKQfnk/9UtFgS0Ftik32H
         5Wt3Z9gJvCyOplM7EX4eQX5jnch43IKDLgi8L4b3lUtskYS8b4RtgPNo71B86XEzj8cH
         MWBrktFRdWVSoaSbF7UM2PG7WhlA9jPcGhe4SDYMhUfibGpO31kFd3F2jdqkhXy08ofC
         ODf+jaVEEtpK7RiwjZAvKWtJMwxJTiV6YeCzekFdEqXlgZ1Mix0sJIsSaNPmdT6b++bB
         Zx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I/ZxnolaAfKtvr5QsuelnELvi0uEaylPxvANAlsCccY=;
        b=1WLipWGpJz/mBPqDHdEzWM/XywDTIsFj+TE9ZgW1xs8ctwRd5oMBwJ+V7ISvhkSKa3
         QCXxGrgKXV0Y7you/d+TDX3eVXO0Oo2UpZ3SjaBTfneqerEt/ocKSTXFRCOgGKILKhm4
         Kl5cBT0iLdJDH3nqN5ztAQ4Mo5psxZT9iEriH464Y6M3SXW6c7D/1ZIuai2AJMT38VyU
         2GheiojtBw2McCiZPLtweHa8oWco3RdzHHfAvCJMQ5gjrev00+3+/Hxrce6rjYxJfgFY
         4U+phpvQ81NIkPDB/MRQ5idY1Osn6s7i//hFczKNuLTSeB+HgZMoQug9CAslp6k0kxHn
         0P7A==
X-Gm-Message-State: AOAM531e10qAeR9rq90Y52wfI4qoD3HwrstSRoSWHdk7sEvXrrPaS78n
        2T1P+lhmvv6GXIv/Tjy5GUk=
X-Google-Smtp-Source: ABdhPJxOebzAJIx1jkjk1FEgvrpx7971sh9Ep3y/IrvgOWJpMod6q+fEJylcr7/kpwMbGJHweJa5bw==
X-Received: by 2002:a17:902:e80d:b0:15e:b27b:931c with SMTP id u13-20020a170902e80d00b0015eb27b931cmr25651571plg.5.1652849232068;
        Tue, 17 May 2022 21:47:12 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:556b:348:b181:320f])
        by smtp.gmail.com with ESMTPSA id t128-20020a628186000000b0050dc7628179sm654671pfd.83.2022.05.17.21.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 21:47:11 -0700 (PDT)
Date:   Tue, 17 May 2022 21:47:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: Remove unneeded NULL check before
 clk_disable_unprepare
Message-ID: <YoR6TTviLrUoOJ+i@google.com>
References: <20220516085511.10679-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516085511.10679-1-wanjiabing@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 04:55:09PM +0800, Wan Jiabing wrote:
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
> Remove unneeded NULL check for kp->clk.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Applied, thank you.

-- 
Dmitry
