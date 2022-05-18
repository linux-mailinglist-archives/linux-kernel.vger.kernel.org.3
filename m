Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB552C341
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiERTXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiERTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:23:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525BE230225
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:23:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so6569545pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=azN0WpbB56teBoeHRiX8ZF8theRa9wuUdenPzDm2W0A=;
        b=Rn4CYF1ACF2cOUsSFeF5ggKBSZkleVil0ZiQ9WxVlhUOV+db6WXvI9Zi6EGX8zOZZq
         58JBNUW6nh58qGonn1ZzSL+Rw3U7Y8oYTpnAZAyS8ri/tz45+BP4VpH/V1BYQVobDRCc
         IB4ZRG892jsRkd1WR7/H+ZAt+ibPl6VGuvX4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azN0WpbB56teBoeHRiX8ZF8theRa9wuUdenPzDm2W0A=;
        b=EWzyJWSA0EYXKUQ6k9f/NhTBtcLBUaNASHXk7xE76MvBjrbYOxnNVNmbe/hVv0Dxp9
         ttIuaob075N4Z9WwduSKMoLCwJbbMXhcIwH6HPwFCgOGBa72dGchL4PZ4aD6HEg1ncNI
         NolAKkUOa8NM2toM4KmTPYQOdu4tS2Gf7iPBFXDQy1rIpKbWo5vfZd0U8wHnVwCjt1x9
         G/+SK8pIx0FyubmjtKd3Osr7+UPAVcQJ+gE6rybgpH4bY+rSlVnvOx+Sl/999WdRP7al
         nvIX3QNuSSl3Bl1mf0bms+JyknQTCkI6m+aSu4fswnHFhmiBIlCf91sBF1lLfpYU6V0a
         LDNg==
X-Gm-Message-State: AOAM531cxtHqaBI0tU97b8kkl10a9sMgeoIuzyqlxtuyNbE+MSpa4nJJ
        gDLYSRFhcyJAZypV9Dmru+WmTA==
X-Google-Smtp-Source: ABdhPJxxZN/NR10p8Wr/541BkyIcKrJcnoJoUiHqQDum/hfEMTs1nrTf898+1jlCrtMSQOkhw1YXoA==
X-Received: by 2002:a17:90b:4f86:b0:1df:28c5:e89a with SMTP id qe6-20020a17090b4f8600b001df28c5e89amr1016434pjb.66.1652901791534;
        Wed, 18 May 2022 12:23:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b0016168e90f2dsm2055410pll.219.2022.05.18.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:23:11 -0700 (PDT)
Date:   Wed, 18 May 2022 12:23:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v4 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <202205181221.F02CF5A9D2@keescook>
References: <20220517233457.1123309-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517233457.1123309-1-mka@chromium.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 04:34:54PM -0700, Matthias Kaehlcke wrote:
> As of now LoadPin restricts loading of kernel files to a single pinned
> filesystem, typically the rootfs. This works for many systems, however it
> can result in a bloated rootfs (and OTA updates) on platforms where
> multiple boards with different hardware configurations use the same rootfs
> image. Especially when 'optional' files are large it may be preferable to
> download/install them only when they are actually needed by a given board.
> Chrome OS uses Downloadable Content (DLC) [1] to deploy certain 'packages'
> at runtime. As an example a DLC package could contain firmware for a
> peripheral that is not present on all boards. DLCs use dm-verity [2] to
> verify the integrity of the DLC content.

For the coming v5 (which will fix the 0-day reports), if I can get some
Acks from the dm folks, I can carry this with other loadpin changes in
my tree. Though I'm fine with this going via the dm tree, too:

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
