Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4890590795
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbiHKUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiHKUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 16:54:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C014090;
        Thu, 11 Aug 2022 13:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66178B82293;
        Thu, 11 Aug 2022 20:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77796C433C1;
        Thu, 11 Aug 2022 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660251280;
        bh=oebE/ZPJ9Yj7bSNVEycbEf7rL+LPEK7fxBeOLpOj3Tk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnQJdahlCu9k6pVqo6O4Gq2KQcO6YKiDsub1ObEWjOeNSLYhRSdfoMW7WC26+hZtk
         2Xnl+eZIbfkX3UoSr67jx+HZc1P31U0UD+ZEcXJkqQ2n7TTr74t4PDkvht6L8BP1XI
         o19hxOMfdoZSrNZuez9F1qGYc+u6baPQGgth/ZaEwdy10bb/9lclxg+KwNog9Muvgu
         nke1UNVIQC0AIAtBlKs/Aa2KhMs0MxZOvUXqJxJOm9YujHkc9yBCMmOw+RgxHJ33+/
         9vpiGopWM931Ye7ovS3H7DXJDaH5eKFuDUpTEnG9YoBg57pHyTDcpNbsbfjWtg3Fcd
         HoRmKKSaNvz4g==
Date:   Thu, 11 Aug 2022 13:54:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-next@vger.kernel.org
Subject: Re: build failure of next-20220811 due to d79b32c2e4a4
 ("vdpa_sim_blk: add support for discard and write-zeroes")
Message-ID: <YvVsjWAWRyJzQ2V7@dev-arch.thelio-3990X>
References: <YvU67iF4z5gB4ZYk@debian>
 <YvVK+ZqO75QAYYnB@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvVK+ZqO75QAYYnB@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 11:31:21AM -0700, Nathan Chancellor wrote:
> On Thu, Aug 11, 2022 at 06:22:54PM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi All,
> > 
> > Not sure if it has been reported, builds of arm64 with clang failed to
> > build next-20220811 with the error:
> > 
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
> >                 struct virtio_blk_discard_write_zeroes range;
> >                 ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
> >                 if (to_pull != sizeof(range)) {
> >                                       ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
> >                                 to_pull, sizeof(range));
> >                                                 ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
> >                 bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
> >                                                                          ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
> >                 sector = vdpasim64_to_cpu(vdpasim, range.sector);
> >                                                    ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
> >                 num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
> >                                                         ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
> >                 flags = vdpasim32_to_cpu(vdpasim, range.flags);
> >                                                   ^
> > drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
> >                 u32 num_sectors, flags;
> >                     ^
> > 8 errors generated.
> > 
> > 
> > git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
> > And, reverting that commit has fixed the build failure.
> > 
> > I will be happy to test any patch or provide any extra log if needed.
> 
> I am very surprised GCC does not error out in the same way, since as far
> as I understand it, labeled statements have to be followed by a
> statement and a declaration is not a statement in C so braces are
> needed. In fact, it seems like something changed (regressed?) between
> GCC 10.x and 11.x?
> 
> https://godbolt.org/z/EYaGa1eE3
> 
> I am going to bisect GCC to find out whether or not that was
> intentional.

Just for the record, it was:

https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=8b7a9a249a63e066cff6e95db05a3158b4cc56cc

The clang developers are aware, it seems it will get implemented at some
point:

https://github.com/llvm/llvm-project/issues/56040

Cheers,
Nathan
