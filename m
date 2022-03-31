Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B474EDB59
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiCaOJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbiCaOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:09:26 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FEF2128C2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:07:38 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id b18so21442223qtk.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RUo5kwiJz1bXcAqbqhS7EP1tVYXGo0oDgLG0Vt1y+Yw=;
        b=piasVfJJs0bqvNJ4PSZRAVyjHcXIX+f20OEUWIVbZrN66k1VJSR4dx7gqLu3aayp7Q
         270fgEB5o1cj86OnfA4+P3m/Lfik2iBL74oA9pmDfPB358bkLsO6KS1/yi5MrnrxLpqP
         2/PmwBHugQKp8Jg+9/HpgKLnulHPVq56TNbJAUJz66lV6aXiI8v31Ors3hXoU1tLa7Vr
         +vvKGo31JwJiNS8dfwtiBJbipCXMugjSYuBMb3blJcywsgXzbvPlmuO1/KMFZoshZgzN
         o43bkTuDeIplUupMKNaxvm2swmnVZJnb/pd27kwSPyjYbWW4hlXTR5xvlW+lRYXKQEJn
         /9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RUo5kwiJz1bXcAqbqhS7EP1tVYXGo0oDgLG0Vt1y+Yw=;
        b=YhHMf909iHpObTmI4fTZlFMIv+4piuvTAYFqVRFpwSPE6t1eEAObd6Yc6WWGi4Jc3a
         YTMDrNJQu56ue4LOH3wT2R0hmWsR+BBuDTNVFDF3bl2re/vwvdlpFLyUhI95xaijhzpA
         LY8py21i0IUlqwIYg9bkKpyGfjzB5pzPLDmp7FD7ibOSvpGNqIDKzFFkai00UGsD6dtQ
         Gq9up2piFqGlgmWeO2n81FMuwW5bDSWwmelVn/B5W+5Wi0l8BfdiBNJfsVQ7+K8io6zI
         pEf2qom7pus8gzBZMaf5y1EXcNfw9y0SoK65S39VDpPau/WYQ8otXY7JDEx4c/RQ7NXH
         6BeA==
X-Gm-Message-State: AOAM533aG8j96DBIz7VQtWlublR0Q/TOHectfRHgmCK/oGYEFAIEASjG
        AEWYywu8iHMPZkY/0sS+FzxhuA==
X-Google-Smtp-Source: ABdhPJy7PzQlsoFAhL/5nP5uePzyN9D+3lTBYWt8xfk4DVXO5W6tcsmGikWZnPr0rN62xnxYhv+yfQ==
X-Received: by 2002:ac8:5fd2:0:b0:2e1:b346:7505 with SMTP id k18-20020ac85fd2000000b002e1b3467505mr4464103qta.94.1648735657640;
        Thu, 31 Mar 2022 07:07:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85948000000b002e1cd3fa142sm20349064qtz.92.2022.03.31.07.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:07:36 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:07:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zhang Wensheng <zhangwensheng5@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in
 nbd_dev_add()
Message-ID: <YkW1p4oP9mmcuwK9@localhost.localdomain>
References: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310093224.4002895-1-zhangwensheng5@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:32:24PM +0800, Zhang Wensheng wrote:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.
> 
> Fixes: b0d9111a2d53 ("nbd: use an idr to keep track of nbd devices")
> Fixes: 940c264984fd ("nbd: fix possible overflow for 'first_minor' in nbd_dev_add()")
> Signed-off-by: Zhang Wensheng <zhangwensheng5@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
