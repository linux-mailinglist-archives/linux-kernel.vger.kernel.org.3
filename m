Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5446C4A73A8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbiBBOvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345133AbiBBOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:51:38 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46367C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 06:51:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 133so18518835pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 06:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=86/HaWRp2y/SbuutjnhnFgYLOj+BcaVRE8VVajIjfRc=;
        b=R/anZ7UkMnqaF3CW4Ump0dqYVUYUgaS4M/yiDIxTx2Cjcq+Qyd6YocKBZ8mPdRpPW+
         17FNI88k1C/BmVXl825aLA0miu2S5PPr8PsT0fMqN4dVJU17+9S6pjmTH6QbSeNecx9r
         0xP8jPO9Nw198zDO00TZswt+Ah25ZHBq+6KVkMYCNAEWgsPPHMXcAtmG4VsW3F3UiWKJ
         rSIzxvJZQrspkqWsoTGnJsSlKKFTTNT/fSLrJ2tAT5TU1bpU2aG1AoRBu+acTX1dmWiy
         dtFz/L7xjwsZ+s+MvP2INbmL3Bpln/WoZpGWMhz5gWzjqWyuCyzkWYcHCGIQZ7JI1y6B
         ls9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=86/HaWRp2y/SbuutjnhnFgYLOj+BcaVRE8VVajIjfRc=;
        b=5s6yO+ZwuH9aXm2Jz7ku5sR1n12BrIIXJHEyJcEXRndhCCxafxpyZaynyaF5HGFkpb
         3qvmbUpnt8Sxvti2utaYdy/ZymsozFbU05YdJmkv4JVaTTkmV2Mpz7GKM6DstJMakiwb
         GFsgxsGMD/+QtTktC64fTUpq88lbQEtd/eu9nQEnCLWaOBRpO3rSfke3IOfHU7FVjIQf
         xuuvCxXJ5fNbfl8sDXh4qexpf7oCbyOL+pPs+MFcn1pa9jZora+4tjyzCE3p9NMy+9Vf
         wQZm5DWeGw34zTF62+C2yZNBjRGDgvFXuEdV2jlsJkmmruQ4O6f+SA7u4Y8FLWJhPAsH
         mU5w==
X-Gm-Message-State: AOAM533lw3bfUXdInuKl/feYVS2b4Psi8jHrtYF9DKVWnyzCgYKEKqkv
        EMw6E2opG8+N1Yalx4dX1NU5kg==
X-Google-Smtp-Source: ABdhPJwHqMALF/wOLDrSj4nmDW1I8tHyhaX9IDucrRtcOQAvGP0sRohPCEugxsJxmQaoZ0g8bCyDQg==
X-Received: by 2002:a63:e206:: with SMTP id q6mr25071054pgh.165.1643813497682;
        Wed, 02 Feb 2022 06:51:37 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id 76sm28639747pge.93.2022.02.02.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:51:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20220128140922.GA29766@kili>
References: <20220128140922.GA29766@kili>
Subject: Re: [PATCH] fs/ntfs3: remove unnecessary NULL check
Message-Id: <164381349664.170858.13226820250070489302.b4-ty@kernel.dk>
Date:   Wed, 02 Feb 2022 07:51:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 17:09:22 +0300, Dan Carpenter wrote:
> This code triggers a Smatch warning:
> 
>     fs/ntfs3/fsntfs.c:1606 ntfs_bio_fill_1()
>     warn: variable dereferenced before check 'bio' (see line 1591)
> 
> The "bio" pointer cannot be NULL so there is no need to check.
> Originally there was more extensive NULL checking but it was removed
> because bio_alloc() will never fail if it is allowed to sleep.
> 
> [...]

Applied, thanks!

[1/1] fs/ntfs3: remove unnecessary NULL check
      commit: 365ab499153cdb2007d54e7e62bcbf2c67f7ab8f

Best regards,
-- 
Jens Axboe


