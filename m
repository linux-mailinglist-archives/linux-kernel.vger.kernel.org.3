Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDE557FCA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiGYJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiGYJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:42:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F11B13F6B;
        Mon, 25 Jul 2022 02:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C780AB80E2A;
        Mon, 25 Jul 2022 09:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA9FC341C6;
        Mon, 25 Jul 2022 09:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658742150;
        bh=AOVJfz8iOpRtJFPH2uylODBCXW5yf6/ulPstOlyOdR0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=iapRzK7dsddUQFhqDxzgYQ4cVXSSkjWFDhtVCopZg8KAmDqT8w1KWCou8/hDsE8F1
         tn20NRQ8jbp8G28ryvsPKGraxsbTuOaLvg4Lrs+ejsyLrpZMairUvyPhuZhzgXkRor
         5fz84vUvZeQRJ0HJYN/Yac0BVCT8OGypQG3f5Jmy4jMj5z3srlHGvv0asL2d+Upe/e
         zKyC69ALbZ5VhuVNd1ocdvf8oIOCxDxhtIVaPc/9AaY+cnmB9YG74eYX1Fbv5L5BU4
         J8pWm2o0+ump7wsTNsHcBqB7/oD2gwp5MGkA7h5OWkbGLrtF49Y6xmtuoR70Qw3+dU
         xKICmvtKOWjKQ==
Date:   Mon, 25 Jul 2022 11:42:26 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Aashish Sharma <shraash@google.com>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the hid tree
In-Reply-To: <20220725104035.15c2e506@canb.auug.org.au>
Message-ID: <nycvar.YFH.7.76.2207251142040.19850@cbobk.fhfr.pm>
References: <20220725104035.15c2e506@canb.auug.org.au>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/hid/hid-nintendo.c:1514:29: error: redefinition of 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
>  1514 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/hid/hid-nintendo.c:295:29: note: previous definition of 'JC_RUMBLE_ZERO_AMP_PKT_CNT' with type 'short unsigned int'
>   295 | static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   669abca7b767 ("HID: nintendo: Fix unused-const-variable compiler warning")
> 
> interacting with commit
> 
>   92cdfba40155 ("HID: nintendo: fix unused const warning")
> 
> I have used the hid tree from next-20220722 for today.

My fault, I forgot that this was actually already fixed before by Daniel.

Dropped for now from for-next. Thanks,

-- 
Jiri Kosina
SUSE Labs

