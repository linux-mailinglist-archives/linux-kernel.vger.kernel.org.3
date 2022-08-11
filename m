Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B66590654
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiHKSba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiHKSb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:31:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1F66D9FD;
        Thu, 11 Aug 2022 11:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AEC45B82187;
        Thu, 11 Aug 2022 18:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093F3C433C1;
        Thu, 11 Aug 2022 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660242683;
        bh=lkARARzWQLa6i9JTMh4hY0BpWadzELasXTHngRGpmZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOYlUH6L6VBnX9tFgi/D9JA2iIOR42RuG5uUtrrlKIi4K2ig3qvZJJyII63BeTLox
         AHqS4BoEKCw7YfZk8HTG6l+1WvjiAARWkwjEqL1Hg+TsEoE4XKYXzWPtXW17Yr5n3Q
         YmBNczlFmivLLHXI1lbIfoE9/FxKquCvXa2kTYWCkackrJIfhFBCoQyejF8WlAY/wA
         ogZAErqbROEmHfeRC9kdjRuyGXUJ9fvCkREpOxywcCnAF9lhSb5i4pGJLA3IWgEH/h
         q+Iysee8LcypbRgziymGoRHPnK3tVgdBiD4G9iIIyFvQvOCPK31bo4C32AMFn9IbGP
         NHwK2aF+YcLpw==
Date:   Thu, 11 Aug 2022 11:31:21 -0700
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
Message-ID: <YvVK+ZqO75QAYYnB@dev-arch.thelio-3990X>
References: <YvU67iF4z5gB4ZYk@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvU67iF4z5gB4ZYk@debian>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 06:22:54PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> Not sure if it has been reported, builds of arm64 with clang failed to
> build next-20220811 with the error:
> 
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
>                 struct virtio_blk_discard_write_zeroes range;
>                 ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
>                 if (to_pull != sizeof(range)) {
>                                       ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
>                                 to_pull, sizeof(range));
>                                                 ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
>                 bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
>                                                                          ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
>                 sector = vdpasim64_to_cpu(vdpasim, range.sector);
>                                                    ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
>                 num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
>                                                         ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
>                 flags = vdpasim32_to_cpu(vdpasim, range.flags);
>                                                   ^
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
>                 u32 num_sectors, flags;
>                     ^
> 8 errors generated.
> 
> 
> git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
> And, reverting that commit has fixed the build failure.
> 
> I will be happy to test any patch or provide any extra log if needed.

I am very surprised GCC does not error out in the same way, since as far
as I understand it, labeled statements have to be followed by a
statement and a declaration is not a statement in C so braces are
needed. In fact, it seems like something changed (regressed?) between
GCC 10.x and 11.x?

https://godbolt.org/z/EYaGa1eE3

I am going to bisect GCC to find out whether or not that was
intentional. At any rate, isn't this the proper fix? I can send it as a
formal patch if desired.

Cheers,
Nathan

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index db85df1d5073..067d4c2f7bf4 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -197,7 +197,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		break;
 
 	case VIRTIO_BLK_T_DISCARD:
-	case VIRTIO_BLK_T_WRITE_ZEROES:
+	case VIRTIO_BLK_T_WRITE_ZEROES: {
 		struct virtio_blk_discard_write_zeroes range;
 		u32 num_sectors, flags;
 
@@ -253,6 +253,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 
 		break;
+	}
 
 	default:
 		dev_dbg(&vdpasim->vdpa.dev,
