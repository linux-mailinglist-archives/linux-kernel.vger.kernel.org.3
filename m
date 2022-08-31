Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDA5A83FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiHaRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaRI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:08:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4334C740E;
        Wed, 31 Aug 2022 10:08:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0380CCE2213;
        Wed, 31 Aug 2022 17:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE5BC433D6;
        Wed, 31 Aug 2022 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661965703;
        bh=UgczS3CJgouUMMsWYePVZ/hPuMBwGBtTIr3bjSAh0Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWJyW3sh7T1cOTQqwZqkWiji5c1It00lZmPr0kflwtbxXUkkfAk0Nn8YLulEyUs8t
         iWSD0pOPwEvreZ6d5mxLeBmjEuzTFEczMKbtP+g/r2wQx4f1oSLMNGiQokJ0l1dPRd
         PzibDTtdduuGVrjdn4t8vyHqQ3qwLu/CgGy8SlNEKjupJSjRRAPAQp6XSYCUQ6Ez9s
         yY3XZvFFNTpktOnv/RKrfupktmijgAJQnItX2geXMFMlNgo6rbFUNZQixWpqL6/F8J
         57bkOX4qNkfrbMTdbQ0IxkhZdAinzhTWTZjay8rFMMnuXt3uMZlreXshNETmXqzNCV
         bIawp3fAwmZtg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     jgross@suse.com, roger.pau@citrix.com,
        marmarek@invisiblethingslab.com, mheyne@amazon.de,
        xen-devel@lists.xenproject.org, axboe@kernel.dk, ptyadav@amazon.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] xen-blk{front,back}: Fix the broken semantic and flow of feature-persistent
Date:   Wed, 31 Aug 2022 17:08:17 +0000
Message-Id: <20220831170817.94903-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831165824.94815-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2022 16:58:21 +0000 SeongJae Park <sj@kernel.org> wrote:

> Changes from v1
> (https://lore.kernel.org/xen-devel/20220825161511.94922-1-sj@kernel.org/)
> - Fix the wrong feature_persistent caching position of blkfront
> - Set blkfront's feature_persistent field setting with simple '&&'
>   instead of 'if' (Pratyush Yadav)
> 
> This patchset fixes misuse of the 'feature-persistent' advertisement
> semantic (patches 1 and 2), and the wrong timing of the
> 'feature_persistent' value caching, which made persistent grants feature
> always disabled.

Please note that I have some problem in my test setup and therefore was unable
to fully test this patchset.  I am posting this though, as the impact of the
bug is not trivial (always disabling persistent grants), and to make testing of
my proposed fix from others easier.  Hope to get someone's test results or code
review of this patchset even before I fix my test setup problem.

Juergen, I didn't add your 'Reviewed-by:'s to the first two patches of this
series because I changed some of the description for making it clear which bug
and commit it is really fixing.  Specifically, I wordsmithed the working and
changed 'Fixed:' tag.  Code change is almost same, though.


Thanks,
SJ

> 
> SeongJae Park (3):
>   xen-blkback: Advertise feature-persistent as user requested
>   xen-blkfront: Advertise feature-persistent as user requested
>   xen-blkfront: Cache feature_persistent value before advertisement
> 
>  drivers/block/xen-blkback/common.h |  3 +++
>  drivers/block/xen-blkback/xenbus.c |  6 ++++--
>  drivers/block/xen-blkfront.c       | 20 ++++++++++++--------
>  3 files changed, 19 insertions(+), 10 deletions(-)
> 
> -- 
> 2.25.1
> 
