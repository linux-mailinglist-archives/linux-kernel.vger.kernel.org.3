Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C104510B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355418AbiDZVaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355398AbiDZV36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:29:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938A532EDB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:26:49 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id x12so2856149pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PEo4D4bdSYpeDMz9JZm7KkOWj6DXC/CIJId7e4HzmSk=;
        b=b3Gu0eY7U5IQHGKcfdYMdQxoneUyHYN6t0ILw1/E5N15QRMokh322X81jWZmTc+9IN
         o7obfkEb//U9xX33jM5h/00zEKC1nWBwDuzxk34hDB+b5CvdIcheHOPjrbZXY+Ff0uCJ
         wubvdiaCoFgqVsbUy9/tOxBs9sPae45FmhO58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PEo4D4bdSYpeDMz9JZm7KkOWj6DXC/CIJId7e4HzmSk=;
        b=2uowisXPy2xdLqdff02efC5SUOOa9GC+6ffYZdjVaeelYCZEqz0qgVgL5r6pavqRe8
         Y/CVa7FIkBeprRCz7VFEUUC8DTC83DBsoWqbelmRokZxyK74Rjytycra+4RLzh92NoXM
         UQ7qIzCR/RcIvVpZwun+OyrmwA+N49KX7+QhKatAP7L6GbuBGDnwextoZb/ZA2yjxg3n
         1y1+xHn3ybaPUL1fSSQYWzIgTny39/Xkzre5jBDZhIeOSjqLYH+JzuG1FxxA6LITBj6U
         WEeZJW4K7tNOJlxAbZ/70jeYLN7K8PCbBVrJZl5T5bP6hx+zQ1QEBJ7wGRtbILUrHK9i
         gRcQ==
X-Gm-Message-State: AOAM5305msOowHVcraHOvGctoQj/iH/X0g1ML5c4CIHZ7mx7V6v3pr9h
        KQcMJXIMHtu6OuonziiK+5Nv/4tf8ZwQ9A==
X-Google-Smtp-Source: ABdhPJyipjluNCoM0gz1DLluPHYgiDyFHbU5+ZOL4Ij2kGeYbGdD4umggWfLSOZvVh+t4WM1cEIAIw==
X-Received: by 2002:a05:6a00:15d2:b0:50c:e283:f701 with SMTP id o18-20020a056a0015d200b0050ce283f701mr26396606pfu.23.1651008409110;
        Tue, 26 Apr 2022 14:26:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b249000000b003aae4f10d86sm11358167pgo.94.2022.04.26.14.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 14:26:48 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:26:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: replace snprintf with sysfs_emit
Message-ID: <202204261426.FC012A74C7@keescook>
References: <20220426125902.681258-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426125902.681258-1-wanjiabing@vivo.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 08:58:59PM +0800, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/bus/mhi/host/init.c:89:8-16: WARNING: use scnprintf or sprintf
> 
> Use sysfs_emit and sysfs_emit_at instead of snprintf.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
