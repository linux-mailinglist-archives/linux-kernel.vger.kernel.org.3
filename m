Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E877F588CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiHCN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHCN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:28:23 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE71DEFC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:28:22 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id ct13so9201063qvb.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=l1+ReZVsy/Zcurp2LBAdNEnjUAZDeBVBQCSKwElpoHA=;
        b=IJR9r4ZEJjJUnPG965qhC0VKQvDBH0yM3l6doIUqvPl7zXv5UEqVv+VfILs7nN7ocu
         e5jDWTAu5km8uvKGd+leIaPbWV7M4LAJQqlucsBeFpOImJ9bZbbVZ4EGNYpaFTciIn6U
         WdYH8ozSGG7fv48a465UVpd8HfUjdtQoEkrUVIus8//VFQ/wlNO0T3h6XdxUyRgARejI
         aL7I8J1nPdHCgA640YB/LHb7Y7/uTsy29RDcg3dkeSR+kl2Z9I6OxBxVxLpol1eGGFYh
         xEgAqupGbBMk4RbLutYpM2G2jPyEredCLcnKN9O4Kse2i9ZabQd83xwFFbk6aKsqq4/k
         O8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=l1+ReZVsy/Zcurp2LBAdNEnjUAZDeBVBQCSKwElpoHA=;
        b=RonZz1X51rOYFlF3YcTH3P4EDB6glajhSph9QENuiMQya/tMUhJAjhbkoe62ocqCgM
         pJX81Tmc1Sxun1I/mntIRSx/N93kHNlZl3NN8BoKJx7KEYj5AQy4bjTn5tW7eHjRzQ3Z
         TNJ+jDHVvKTevArvE0os+CLik6A4S45mm4hIVkB9biKMnv2J24SdmAAEsdnssJqeQJUm
         /oAKiKTZi6yteF0cIUdJnPNVH2y79+cl0VvPkMlgoa0lRr5TQlzTnv3Ys4NKCJmj21G5
         BcJqkRRNXrkvfMOzhJSs761MjuGw2jnvZ4XZquXSQdBIJdZ4NKtjohxx/EKF1JpvFbCd
         grWg==
X-Gm-Message-State: ACgBeo2J3verx+JFy5SFtH2Kuo4Ukr4dtZwQ9pEN6yvnRHOIibBhUTJN
        Kj9HLIm49gQPiFoZ07342SEJuQ==
X-Google-Smtp-Source: AA6agR4DEAiwhB2lCAnu3LaEohloPb2G3Wpp2+C7glrjShJCrOyz8r1FN2sCA8pNkHOibWtuXx7KBg==
X-Received: by 2002:a0c:8bd2:0:b0:474:7d1a:eb5b with SMTP id a18-20020a0c8bd2000000b004747d1aeb5bmr21858640qvc.18.1659533300175;
        Wed, 03 Aug 2022 06:28:20 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a241500b006b249cc505fsm13434291qkn.82.2022.08.03.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 06:28:19 -0700 (PDT)
Date:   Wed, 3 Aug 2022 09:28:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
Message-ID: <Yup386Bq8Ek1VHJq@cmpxchg.org>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
 <20220802170619.250e1a0b475222a82e7077b3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802170619.250e1a0b475222a82e7077b3@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:06:19PM -0700, Andrew Morton wrote:
> On Tue,  2 Aug 2022 12:28:11 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Change the code such that only one SWAP_CLUSTER_MAX-sized nudge toward
> > the larger LRU lists is made before bailing out on a met reclaim goal.
> 
> It seems rash to jam this into 5.20-rc1 at this stage.  I'm thinking
> 5.21-rc1 with a cc:stable?

Yeah, 5.20-rc1 sounds fast. Let's wait for reviews first and see how
much confidence we get on that change. I can't help but feel, reading
logs and comments (commit 1a501907bbea8e6ebb0b16cf6db9e9cbf1d2c813),
that my fix is how the code was intended to work from the start.

5.21 does sound a biiiit on the long side for fixing such extreme
misbehavior, IMO, once it's proven to affect production workloads in
the wild. I was hoping -rc2 or so...
