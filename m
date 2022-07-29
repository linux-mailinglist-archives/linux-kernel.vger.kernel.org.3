Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B1584ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiG2EwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2EwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:52:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A6A54C95
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:52:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so4168382pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nih3CQ3bvbr3caRHPwLofzDk9DoHwlUp15C4DMS5PBo=;
        b=bYfPignOi/MJPMQdVA/EDZTpDmKF3LvDAsd4Fr7HsUJTIoRn+/bz86QDgO7OfGBmm1
         /Eg3uORkuQT3yF+ysMYvDC7VhVQQuT9l9+eMm8cyWdIxuRIia5S28G/ms1A6hytHKlKJ
         NkjI/sPYggb67XCLFSpJE1AVxLnxqzShpbWtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nih3CQ3bvbr3caRHPwLofzDk9DoHwlUp15C4DMS5PBo=;
        b=VgLjPd0ejxKXSiGJ9/vEkAbMebeBoj5DjstY6xqRVfGNJc1d+q4f163dB0lg01XgFS
         K04JrzHghDGUaSU/MjC/guD7e7pNCmAHed5IiaEVW3nnVM7BlBEl+Yl6qPUzqfo9AO73
         BtbC5mPCZPVFSBhn6zyhBDQw4Qjzv9gw51Mz3SgkFyaxrwYiFWtVVq7yI9ygY4QiZBYt
         OQl6RqvlYuYx3FdAyWRK94n4Nl0rTjrvoPlFhhu1kVhD3y/ne5DCdvfw03Xql+AkLSog
         P9QsTL31rv18Oyvf0qEkurrUHD5fMQQTKHAuQ0rMHMEF5EInUwiG9DvXofnpU7/b/9La
         tuZg==
X-Gm-Message-State: ACgBeo1fCIng4jvtigOv5IA5fyzL4sQ4MLnCfljPB/X+iyD0qa+RWBON
        jg8O/wNiAbYdeZ4lEqFUUjCgAu433FV8Ag==
X-Google-Smtp-Source: AA6agR5FJP+NYrdW/k3FkoK3eSp4f0Ik9rJBgd0bR1FQThkmO9kyKATOXvMgiQu4Mti2542araL9Iw==
X-Received: by 2002:a17:90b:3c42:b0:1f3:2e03:d9dc with SMTP id pm2-20020a17090b3c4200b001f32e03d9dcmr2228881pjb.8.1659070323606;
        Thu, 28 Jul 2022 21:52:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 200-20020a6304d1000000b004126fc7c986sm1808648pge.13.2022.07.28.21.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 21:52:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mka@chromium.org, jmorris@namei.org, agk@redhat.com,
        serge@hallyn.com, snitzer@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, gmazyland@gmail.com,
        sfr@canb.auug.org.au, song@kernel.org, dianders@chromium.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
Date:   Thu, 28 Jul 2022 21:51:55 -0700
Message-Id: <165907031305.2130609.16869003416171682751.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
References: <20220728085412.1.I242d21b378410eb6f9897a3160efb56e5608c59d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 08:54:41 -0700, Matthias Kaehlcke wrote:
> Commit 2aec377a2925 ("dm table: remove dm_table_get_num_targets()
> wrapper") in linux-dm/for-next removed the function
> dm_table_get_num_targets() which is used by verity-loadpin. Access
> table->num_targets directly instead of using the defunct wrapper.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] dm: verity-loadpin: Drop use of dm_table_get_num_targets()
      https://git.kernel.org/kees/c/27603a606fda

-- 
Kees Cook

