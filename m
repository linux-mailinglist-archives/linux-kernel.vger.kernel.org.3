Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B654EDF46
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiCaRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240405AbiCaRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:00:55 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4132F4F453
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:59:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso2090335wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vrgHRAcGFYBW5//Px3FPaIXJFM+ziIQctDRECHM/5Yc=;
        b=L5mcU8fek7ltwjMyOO8VtBdjLOs6rCjrIcH1SxftOcNUCue44IkMbLx0FutOlIy9Gy
         678tQasKLTf8JXDUXlAw+pdCKki/CSbvtJcQYLW9o4sZs9wlmwzgAzh99PpGut4nG4Nr
         RdmGICjFxuXuEu/eaCSkEN2vfeWihguDKUEgDseKIZ2x+ENnyf4eFeJCik5OZYUGB0O0
         ihJudIy+wwooJad80VmxU4sXePSaQ2LDxtDBF6lQ5poJNMC77F7VM3VH+0TdzQsdAhFO
         LYXb2xvRsHAsnQudaJJNKBXt6HIXmpgu8aKngWU32vZwTEpwWepfIbmNH7s8IdlBe1v5
         0ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vrgHRAcGFYBW5//Px3FPaIXJFM+ziIQctDRECHM/5Yc=;
        b=OZQBP//E0Z8vvtF3eI0V7p8H7zrpvLJYhbyushh+RzEoE1RwtSMBTqpIAlYKxadNeM
         wWMz/mEMB9fmM6tdJfOutzDpZLtteO10ZM6ufmdFIuNaHGem0hC6hvJDV1YoCObGbK14
         eF25uwUw8KQmQsopxmEaYsj11dmevNGtbnfssBlr4lapj6vaIA/Z4CVGLDDJoxNNHEJA
         d/aeH9tJ5LOJ3NOz4Y78jhsive8EPeZf310cRLX+IiegNOirpoAWtAuA9XYvh8d9Bjvs
         AzZO0/dOjrRZuaMCZAkjw3Ua+hPcIIrhZPeV3HPgwCgnniEQRXKw9gkGoePvKn/kUpNn
         OJ/g==
X-Gm-Message-State: AOAM533/0r01qE/d5VAH8qjeF3cZg8nY4qMp2CE0wA6tCyM7GSJpNMZK
        tNuoL463kroJx1CFUfnzH/Q=
X-Google-Smtp-Source: ABdhPJyY9VFEb1OxfOzeK9H/V3w75Pxss7kmhEAc3nqyEsc2M5BH0HyOboimDEnBmqGNI8ZTgrH3CA==
X-Received: by 2002:a1c:4e18:0:b0:38c:bd8d:6bd9 with SMTP id g24-20020a1c4e18000000b0038cbd8d6bd9mr5410289wmh.94.1648745941467;
        Thu, 31 Mar 2022 09:59:01 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id d5-20020adfef85000000b00205b3945fdasm13858693wro.92.2022.03.31.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:59:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: unisys: Remove "struct dentry *eth_debugfs_dir"
Date:   Thu, 31 Mar 2022 18:58:58 +0200
Message-ID: <5558288.DvuYhMxLoT@leap>
In-Reply-To: <20220331082202.GZ12805@kadam>
References: <20220331064751.29634-1-fmdefrancesco@gmail.com> <20220331082202.GZ12805@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved? 31 marzo 2022 10:22:02 CEST Dan Carpenter wrote:
> On Thu, Mar 31, 2022 at 08:47:51AM +0200, Fabio M. De Francesco wrote:
> > There is no need for "struct dentry *eth_debugfs_dir" which is used for
> > debug / sysfs directories. Therefore, remove this "struct dentry" and
> > everything related (i.e., creation and removal).
> > 
> > As a side effect of this change, the code has no more need of the
> > "cleanup_register_netdev" label, which can also be removed.
> > 
> > Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > v1 - v2: Add a couple of "Suggested-by" tags which were forgotten. 
> > Thanks to Dan Carpenter and Greg Kroah-Hartman.
> > 
> 
> Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
I've just noticed that visornic and visorhba do other calls to 
debugfs_create_dir() and debugfs_create_file() functions.

I'm not sure whether or not this driver still needs those other calls.

Do you think that they should be removed as well as it has been done 
in the patch above?

Thanks,

Fabio M. De Francesco



