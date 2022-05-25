Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF82A53449D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiEYT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346533AbiEYT4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:56:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DEE2CDD4
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 538C4B81EA1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 19:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CD6C34117;
        Wed, 25 May 2022 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653508589;
        bh=X7C0hmbhpTB3GvF0P9XEj7WCHI8xPxoJdQtXCB0lpQE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vkuk7I4YJwHwtgvQIjGGD67euU0yYsX+7dtU16FLwEvLwi8PlinTP7bamF/qsXX/R
         IemM4F1pZ/EVFJHycMBf5kl0RU9XRXgUsO0QL9o39JffkmNZtp/VWKGSmqu7oh8ZQC
         UU4QOnoINatpfxKdNgO8djo5bg0LXrduj8PpsVzg=
Date:   Wed, 25 May 2022 12:56:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Baoquan He <bhe@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
Message-Id: <20220525125627.acf27b28bb67417a6683a1d9@linux-foundation.org>
In-Reply-To: <877d6g0zxq.fsf@email.froward.int.ebiederm.org>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
        <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
        <YoWySwbszfdZS9LU@MiWiFi-R3L-srv>
        <87bkvt4d56.fsf@email.froward.int.ebiederm.org>
        <20220520104641.GB194232@MiWiFi-R3L-srv>
        <877d6g0zxq.fsf@email.froward.int.ebiederm.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:25:05 -0500 "Eric W. Biederman" <ebiederm@xmission.com> wrote:

> > I am not strongly against taking off __weak, just wondering if there's
> > chance to fix it in recordmcount, and the cost comparing with kernel fix;
> > except of this issue, any other weakness of __weak. Noticed Andrew has
> > picked this patch, as a witness of this moment, raise a tiny concern.
> 
> I just don't see what else we can realistically do.

I think converting all of the kexec __weaks to use the ifdef approach
makes sense, if only because kexec is now using two different styles.

But for now, I'll send Naveen's v2 patch in to Linus to get us out of
trouble.

I'm thinking that we should add cc:stable to that patch as well, to
reduce the amount of problems which people experience when using newer
binutils on older kernels?

