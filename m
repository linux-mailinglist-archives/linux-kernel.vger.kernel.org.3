Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1D4A9BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359571AbiBDPL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBDPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:11:56 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855E0C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:11:56 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id v186so19735566ybg.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGiij85XESKLGYtHB2QwMag22hitD2nYvlyTI/Fp3Eg=;
        b=QFqVjlid6D7zUlaqsEUQdYoPgZMSsX4p5nTs6jeho8vaRLwWAKfvWd/ePLG7zr3dFE
         mDeczqd/KBEqzrEZWqjh85AnFbowkU7ublaXo5cbRTt8QegMQs3ZY3dYY1WY36urzEiO
         hmWxVXC12IeuOCxtOEZDE8y9pTR4IKvCSgyQ9SKDLBVlqEQLORdMbTWXlnbTMOwg456U
         KiCZcvnEuBL7Nj2BfUPPG2Bx4B5gTGBw5t3c1knKQ22RE6yhXls7tEZDK7ztuQxdH2xP
         wxz3wbmEBOKz8Y8mLQehtyxI2z2sC2hPN95dDPpviCJW0bu43ewU1A+lIkBtxaU4ba8O
         wkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGiij85XESKLGYtHB2QwMag22hitD2nYvlyTI/Fp3Eg=;
        b=4PqsBvrBrGm0ONnak/8dASa33acF+aN2lmGrjphpwzBRfYe7fq3bNvHS/uYG6wayt+
         tIH04W70b+cg2aWN/GzcgxlBmh2jqwdAD3v1Q66em6mCfRCisnicJZIo5xd8o909fwaO
         raiKkF/7yYmYg/F24Am85Vrk5TFfj7Iv2gLzXbwN1dLDprziJ+Gzs0NkPwRfP6U5beM7
         s3j0blTWpJ7rUZcrrGxWZ3pXQpkv4GXm0EYpLXu4fJqzSfBJI275vwf/SX1y1WKLPONO
         OhyEfZbAFXvQcH9jLwe4tlTQFKZEqS1sXDOExELHWQhFbpxdTw9I2/+dmxDUThUaXNj9
         ukww==
X-Gm-Message-State: AOAM533ZmIQ3loltT3q2Eb9AxkOzDxbx/sPJ0S7Xj+wMUC0vgBg4X/UI
        OyZGLfOVIndpx4WYQyH7wP5TSPrkW10x66bNX6ZeOv+VPtzv3A==
X-Google-Smtp-Source: ABdhPJw1P6Mob4RR17orG9LkRVRc2iVXVTP8zYN4s50wkTkEINzjL/pztzbty+jvSxBl+OUZFFeZqVCM2Fp4GTjtDeE=
X-Received: by 2002:a25:c647:: with SMTP id k68mr3014174ybf.690.1643987515501;
 Fri, 04 Feb 2022 07:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20220203131237.298090-1-pedrodemargomes@gmail.com> <20220203133938.1696-1-sj@kernel.org>
In-Reply-To: <20220203133938.1696-1-sj@kernel.org>
From:   Pedro Gomes <pedrodemargomes@gmail.com>
Date:   Fri, 4 Feb 2022 12:11:44 -0300
Message-ID: <CACpbsfZN2fExaTReJG1anDQjCd3i24_0wG-oU42dSHD5bAon7A@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
To:     SeongJae Park <sj@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 10:39 AM SeongJae Park <sj@kernel.org> wrote:

> I think this would be better to be implemented as another monitoring primitive
> based on the virtual address space monitoring primitives, e.g., vaddr-writes?
> Then the implementation would be simpler and changes to other files will be
> minimized.  For the user space interface, we could use a prefix to target_ids
> debugfs file.  For example,
>
>     # echo "vaddr-writes $(pidof workload)" > $debugfs/damon/target_ids

I will do that.

> > This patch also adds the actions mergeable and unmergeable to damos schemes.
> > These actions are used by KSM as explained in [1].
>
> Please do that in a separate patch, and also update the document
> (Documentation/admin-guide/mm/damon/usage.rst).  And, what's the expected usage
> of the action and benefits?

The idea is to use this action to all areas that are not written too frequently,
this way KSM can save more memory without too much overhead.
But I have to test it better and collect some data to see if it really
makes sense,
perhaps it is better to leave this patch for later.
I would like to know your opinion on this, do you think it makes sense?


-- 
Atenciosamente,
Pedro Demarchi Gomes.
