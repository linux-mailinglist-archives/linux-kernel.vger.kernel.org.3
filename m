Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE1578441
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiGRNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiGRNtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:49:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F62194
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:48:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b26so17153783wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=El7sp1W0MCofqFTW5MHb7+/RiOIu+D9bm0RdW8FlGUo=;
        b=b0zbas7Zeo3H6WCCy76FRkL0rWuVodhYp8VH+Xa1URY9nle+Az0C7WQPaCmckwi0eu
         p8Fnl3kk6joD0zHHzE787IbZdv58Ly0alYRsLkrWz64xtSM2LYM1TDQFYDiPeOGYhwz9
         UwD1cIHfLBJpgGIGTp/+yWEytFmvZmut42bqHampc8ldfSBtoc3Bdw4wjOL42zwX9HUp
         Zs1kMJ0ed74jk3wzHZqmGmWweCl3Kt5uvfk7PVi8nBvYUdSnVD0V/O3SYe2XiRJE1zJf
         IgiarKQ46b3HpEIUeoi2vIZtAAUAX6ynnlp1buAXQshAvOYsTxHDm7zOVpKRXeZ+259p
         grNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=El7sp1W0MCofqFTW5MHb7+/RiOIu+D9bm0RdW8FlGUo=;
        b=7ukTvqEuLMt/7gBfNPdt8DRHBZl9eBWSoWtKchsct2ifR9/ZCI7x2HOKQGzdEJJgqk
         9sGH3mKF/U3VXSCf8CmF2l2qbGmvIUDUFgmHITgqGQpygtIiMIxJ1qOu3qdTpYK3LF2u
         qYfpMU9s9s7mnSZ8wltodp8VRNSoJtCSkx9RXezOLNpntm7KUeKxtNnpawRmDmmhjYJW
         L15QQsnqZVDAULQJZfvtiYxqSEjFIjC3r4+KBi22ZDLbjNkPt6m4phBhJBJqxlh69Pg1
         1hZbLCT0qKRaJBE8fjY45L+fI5z4hy26GZRbd61yym8f/ScyG9Mq9/s5Fel6WPuoSkXb
         S1Ow==
X-Gm-Message-State: AJIora96iTBhenVxqESzGryMjqGHPnCK78gCrbW5Pcx5j1PKZ3Eq86np
        sDwkvU6HHxw6QeqqaMDxtcR7SmaY1g8=
X-Google-Smtp-Source: AGRyM1tj9r1T9VFlBni7FNi1doaoJImro7VxVjqljPSP/VhvtxN+P0GTn/tj92obBIrq+QMcRVe1UA==
X-Received: by 2002:a5d:5985:0:b0:21d:b6aa:23f5 with SMTP id n5-20020a5d5985000000b0021db6aa23f5mr23520070wri.18.1658152135379;
        Mon, 18 Jul 2022 06:48:55 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id h26-20020a05600c2cba00b003a2e5f536b3sm20932973wmc.24.2022.07.18.06.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:48:55 -0700 (PDT)
Message-ID: <62d564c7.1c69fb81.9010e.da70@mx.google.com>
X-Google-Original-Message-ID: <YtVkxC+vMUgZ5172@Ansuel-xps.>
Date:   Mon, 18 Jul 2022 15:48:52 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] regmap: permit to set reg_update_bits with bulk
 implementation
References: <20220715201032.19507-1-ansuelsmth@gmail.com>
 <165815182610.53791.17547202213321860152.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165815182610.53791.17547202213321860152.b4-ty@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:43:46PM +0100, Mark Brown wrote:
> On Fri, 15 Jul 2022 22:10:32 +0200, Christian Marangi wrote:
> > A regmap may still require to set a custom reg_update_bits instead of
> > relying to the regmap_bus_read/write general function.
> > 
> > Permit to set it in the map if provided by the regmap config.
> > 
> > 
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
> 
> Thanks!
> 
> [1/1] regmap: permit to set reg_update_bits with bulk implementation
>       commit: 739f872e48d47c97fa17a86a7b3356771b75240c
> 

Hi,
thanks, assuming everything went smooth with the merge to linux-next and
no problems arise, can you provide a signed tag?

This is needed for a net-next series that is currently in RFC state as
it does depends on this.

(I had this problem before and it was said that in this kind of
situation I had to ask for a signed tag to merge the related patch in
net-next branch)

Thanks for the help!

-- 
	Ansuel
