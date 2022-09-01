Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498945A8F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiIAHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiIAHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:04:31 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FDF12269C;
        Thu,  1 Sep 2022 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662015867;
  x=1693551867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B35oMFhDMKzvzRhhioWCKHFgJQhO941LvgwXlwMswl4=;
  b=S64KEHFY8uXZGYa4rWPIsqintFKOpy4F+JgI6U5q9OGODldjXEKst40+
   jmaNNt8tUQRThnU4XitjffmsImioz2PPi/tTLal35MXN31NOLyGytMHfG
   3nZKKmjhmX8E49Pbg2LIp1v6CxeT5CDWFer/hfUUA/Uh1XK9oRulAaBrv
   4urDJ3CfWqleE90iEt2ATv6rts2UEuLZ9RR+8lZSG/k/adjBOYjdZFZdf
   aMI+VVrzvfpgsSG4alTKWfS/pdnv7ifgCnxXvgEFpGyDhDa6F+8k+LYbN
   d1OFsNDCEHQDYSz9gbEuPglLFDv3qAsPx4g1DJBySno2bdZftQFkc7WkC
   Q==;
Date:   Thu, 1 Sep 2022 09:04:23 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel <kernel@axis.com>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Message-ID: <YxBZd9Ivg5+zGUEb@axis.com>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
 <CAHp75VebQfdHrfYTmF0w9M556ZV8fG5jJ2rAN5a3mrB1mbvOQw@mail.gmail.com>
 <20220820120800.519b5eb5@jic23-huawei>
 <YwSLhWFbGb26B3mx@axis.com>
 <20220828163247.3d6417d9@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220828163247.3d6417d9@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 05:32:47PM +0200, Jonathan Cameron wrote:
> Any plans to post updated roadtest soon?  I'm keen to add more test cases
> and use it to cleanup the remaining staging drivers.  Very helpful tool,
> but I don't want to be developing test sets against an old version if
> it's going to be costly to forward port it.

I don't think it's ready for a new posting, but I pushed the version I
currently have here:

 https://github.com/vwax/linux/commits/roadtest/devel

The tests only pass on v5.19 since there are a couple of regressions
(which affect real hardware too) in mainline:

 https://lore.kernel.org/all/a48011b9-a551-3547-34b6-98b10e7ff2eb@redhat.com/
 https://lore.kernel.org/all/YxBX4bXG02E4lSUW@axis.com/
