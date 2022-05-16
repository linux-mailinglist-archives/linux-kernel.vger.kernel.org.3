Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C42528D96
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 20:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiEPS7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbiEPS7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 14:59:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862E3EB9D;
        Mon, 16 May 2022 11:59:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652727557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bk6aAOMGXkpTA7bxdXvA2u7my35PykkS8vmgE62yIIg=;
        b=YW/wI8S1ilWxdav/qldIAI1+xm8jljKSdGMgKWB447TQEgdq1ZnnCgTrLNgOWqR+4JloJf
        2iOvsNOe1iYIS1LeU1ubMtf/N7LE/69zLFZ3qT9E2qu4Cy8b8DvppzATamANaU3YIAQb90
        W9g3XeDMXF5YaHy1XsgOmIKipCLzQECK9R817dX5IyBdadPnMYxGcr6RzDoBEx/WlTuWG8
        9PitS2mZkuORaHDoB7dgCoS3ojeJLH0WSf0wLCU0rqmXd/EP7K6CNJm/dLmJxf71+f8Kwx
        LVS32ikvJpli17vDjh4pqyyY9e1gswKUA8SG3HAf+vq7X+RbhEqihk8Un9q9+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652727557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bk6aAOMGXkpTA7bxdXvA2u7my35PykkS8vmgE62yIIg=;
        b=BNVWYtXohtuR9SnP8sqhfaX9c0M30W8eKYbQ+zUKJrWSVZqHV5QzDMeJKOBGte6qZw01et
        jEAn7i4G6gTHaxDA==
To:     Max Mehl <max.mehl@fsfe.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org
Subject: Re: [patch 0/9] scripts/spdxcheck: Better statistics and exclude
 handling
In-Reply-To: <87zgjhpawr.ffs@tglx>
References: <20220516101901.475557433@linutronix.de>
 <1652706350.kh41opdwg4.2220@fsfe.org> <87zgjhpawr.ffs@tglx>
Date:   Mon, 16 May 2022 20:59:16 +0200
Message-ID: <87wnelpam3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16 2022 at 20:52, Thomas Gleixner wrote:

> On Mon, May 16 2022 at 15:14, Max Mehl wrote:
>> Thank you for picking up the effort to add license (and perhaps also
>> copyright) info to all files in the Kernel.
>
> Adding copyright notices retroactively is not going to happen
> ever. That's just impossible.
>
>>> The exclude of files and directories is hardcoded in the script which makes
>>> it hard to maintain and the information cannot be accessed by external tools.
>>
>> Unfortunately, excluding files (i.e. not adding machine-readable
>> license/copyright information to it) would also block reaching full
>> compliance with the REUSE best practices. Have you considered making
>> them available under GPL-2.0-only or a license similar to public domain
>> [^2]?
>
> The LICENSE directory is already handled by spdxcheck as the license
> information is read from there. And no, we cannot add a GPL-2.0-only
> identifier to all of the files under the LICENSE directory for obvious
> reasons.
>
> license-rules.rst is not longer a problem as all incarnations have a
> proper SPDX identifier today.

There is also an argument to be made whether we really need to have SPDX
identifiers on trivial files:

#include <someheader.h>
<EOF>

Such files are not copyrightable by any means. So what's the value of
doubling the line count to add an SPDX identifier? Just to make nice
statistics?

Thanks,

        tglx
