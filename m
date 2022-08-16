Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC312595B47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiHPMHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiHPMG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07C32BA7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 04:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC7E06124E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 11:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACE5C433D6;
        Tue, 16 Aug 2022 11:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660650995;
        bh=FVUSKZvyxeYHla7DAI1S7uQ9b45W1lFMmWt54ll5JlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v8PP2Y7zNU+FVQizPga9MODb0WFzHKVad+1VohxTjTDc+95kRo6+FlTlwZiET+gOj
         rI3kpk1WipL/kLv/6gv0XXNK+NrFFcDJFwt2vngBa+mVLRX7m5i+DafP+blpINyKqM
         iF0Qnt+XnOywNTiwwOBU918gkxWz6UVgzOTVIBMA=
Date:   Tue, 16 Aug 2022 13:56:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] Make place for common balloon code
Message-ID: <YvuF8CsP0M1TAK1a@kroah.com>
References: <20220816094117.3144881-1-alexander.atanasov@virtuozzo.com>
 <20220816094117.3144881-2-alexander.atanasov@virtuozzo.com>
 <YvtoDxvefWUJBfAS@kroah.com>
 <f88fe469-d4a4-3240-b325-a745255bf01c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f88fe469-d4a4-3240-b325-a745255bf01c@virtuozzo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 02:47:22PM +0300, Alexander Atanasov wrote:
> Hello,
> 
> On 16.08.22 12:49, Greg Kroah-Hartman wrote:
> > On Tue, Aug 16, 2022 at 12:41:14PM +0300, Alexander Atanasov wrote:
> 
> > >   rename include/linux/{balloon_compaction.h => balloon_common.h} (99%)
> > 
> > Why rename the .h file?  It still handles the "balloon compaction"
> > logic.
> 
> File contains code that is common to balloon drivers,
> compaction is only part of it. Series add more code to it.
> Since it was suggested to use it for such common code.
> I find that common becomes a better name for it so the rename.
> I can drop the rename easy on next iteration if you suggest to.

"balloon_common.h" is very vague, you should only need one balloon.h
file in the include/linux/ directory, right, so of course it is "common"
:)

thanks,

greg "naming is hard" k-h
