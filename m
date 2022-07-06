Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88CE568F78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbiGFQor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiGFQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24124F33
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E35D61DA9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EE8C3411C;
        Wed,  6 Jul 2022 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657125883;
        bh=ETQIfKZ04DBpBTgbtjCsfZym+4EgvwaHflYjwEazCCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a74zkiUKuyq/dPmCUK9FEAfat7L9V4nkJmMHDcG04XZv1OCevAd/TOWHcu3ScUEI9
         XYjssuU+EkcGFRsV98+R6BRrlaHiUwLtxN8+i8GJdkKMlJl7AHrW5yNYfuW49ZPMab
         JxykKrwdbqEvxh6sGkdxhxQbloeWyWWuLC+wSmiNPow54vY+7OuewxziiGpZF/HeiP
         z40s1HJReRpWl/Gl+CCGp/TM+ARjySJIBk3jmt7uD3cHUQHql4JjddJLOMDkwppk5h
         efEDqiRu/gdTbA58Q3mTWHAGTEwKsEI7DLCVlkuO3YxpoZ+TLln/a1iqMvtZPbKl26
         QgKvg8NeXsWjg==
Date:   Wed, 6 Jul 2022 10:44:40 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     John Garry <john.garry@huawei.com>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <YsW7+Lsy0ENSA/il@kbusch-mbp.dhcp.thefacebook.com>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
 <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
 <20220706161825.GA1962@lst.de>
 <YsW3oXcCe6/y6iRb@kbusch-mbp.dhcp.thefacebook.com>
 <20220706163434.GA2222@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706163434.GA2222@lst.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 06:34:34PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 06, 2022 at 10:26:09AM -0600, Keith Busch wrote:
> > On Wed, Jul 06, 2022 at 06:18:25PM +0200, Christoph Hellwig wrote:
> > > On Wed, Jul 06, 2022 at 10:13:22AM -0600, Keith Busch wrote:
> > > > Did you test what the trace looks like afte this? We're losing valuable trace
> > > > data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
> > > > don't know why it cares that the address of the field being read is only 4
> > > > bytes; we want everything that comes after it too.
> > > 
> > > Because accesses should not spawn boundaries of members in structs unless
> > > copying the entire struct.  If we want to trace the various fields we
> > > need to individually assign them.
> > > 
> > > Anyway, I'm dropping this patch from nvme-5.19 for now to let the
> > > discussion conclude.
> > 
> > How about this instead?
> 
> Maybe a better option would be to use struct_group().

Good call, I'd never used that macro before. The result produces anonymous
unions like I just proposed, so yes, I like that option.
