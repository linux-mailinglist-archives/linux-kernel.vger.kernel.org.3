Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0657BC35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiGTRCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiGTRCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AE06A9DA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7446661DED
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A541BC3411E;
        Wed, 20 Jul 2022 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658336564;
        bh=52lTckpRZrto7Ccgi9tfUPOBSAxEYFGGTHBhTO2lVFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sc7RGARjYFsjLIuxO4/fqiAIwKxCbpp5sConPvBw95J0VYcrylP82SF4q76rgZh03
         3ySTAfLm8o4da4UiKQ6xh0CtuMoWVFOnV5qO7xE/R1PQ7R2JpjzVm2t1/DuOCX9x0W
         Xkr4hw4sy15RZUpg5uSmDYKhri0qy+P6u04KOu9g=
Date:   Wed, 20 Jul 2022 10:02:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Kassey Li (QUIC)" <quic_yingangl@quicinc.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/cma_debug.c: align the name buffer length as struct
 cma
Message-Id: <20220720100243.7c1151a71ae8400b81d46130@linux-foundation.org>
In-Reply-To: <CO6PR02MB8753B9C4BAA3ABF34508DBABEF8E9@CO6PR02MB8753.namprd02.prod.outlook.com>
References: <20220719091554.27864-1-quic_yingangl@quicinc.com>
        <20220719161836.b0ad5cdfb0aec0c04a862122@linux-foundation.org>
        <CO6PR02MB8753B9C4BAA3ABF34508DBABEF8E9@CO6PR02MB8753.namprd02.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 10:45:33 +0000 "Kassey Li (QUIC)" <quic_yingangl@quicinc.com> wrote:

> Hi, Andrew: 
> 
> Is it the case that the output is never >16 chars anyway?  If so, we'll be OK.    
> >> Yes.  I verified on my device by giving cma.name length l< 16 and >16 both. Result is OK.   I mean > 16 showed correctly with this patch. 
> >> without this patch, cma.name > 16, only showed 16 characters. 
> 

Well that's my point.  With this patch the output is changed and this
might break userspace code which expects the truncation.

That should be OK as there are no guarantees with debugfs interfaces. 
I added this as the patch's changelog:


: Avoids truncating the debugfs output to 16 chars.  Potentially alters
: the userspace output, but this is a debugfs interface and there are no
: stability guarantees.


