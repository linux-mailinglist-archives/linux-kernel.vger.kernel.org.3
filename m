Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A42F5975D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbiHQSmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 14:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHQSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 14:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CFA00C6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660761729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGxwI/HJK8YvsL38NfBt47qZQNhHEBbbdeHKaJUV0vE=;
        b=L2LPWzrGerol0IQHBxA5dmJZJKHFZeAY/jDYzTuxhFqf3ewmrjvxbNel50IU0QCDqEBb+F
        KvN5T7VhMe2WNf/Y4pJalJdLmfQhueLQ93fTulK0P9uX3n3gR5DWRQu2+cxJn/9/6lnyS2
        vu0Pk85E66QIfgM/0dVYVaBiE6MHuBA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-IhJ676m1OGGgI4p6W7EdZA-1; Wed, 17 Aug 2022 14:42:05 -0400
X-MC-Unique: IhJ676m1OGGgI4p6W7EdZA-1
Received: by mail-qv1-f69.google.com with SMTP id ly9-20020a0562145c0900b00495bcb17d9cso2790049qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 11:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zGxwI/HJK8YvsL38NfBt47qZQNhHEBbbdeHKaJUV0vE=;
        b=toWEWoYa2qtya6VLk53z8kvD8IDWO/AXxRlV8e10F8R4ZhdU5gkbDVo5zTXzlzOziQ
         01vEv0mqomk20GZ0b7EYhQZNs+tcAG5O/Jv3mJcy4lVGVlrEol6Xx3IA1VUAdeZ/bCtC
         e1KKmUg3eUtY7IRyc4sfgt4Ts+HjAy40OOxnvFlSdSEqgstuICFQ84JIj832N9zVVr+/
         OzEheFUL4gd0rusF0hDmmVRTfTnPsepI7fQoKhK93QvGlfZZu4p/QlMHJei3iPobI99V
         AbM4OcnJ7vpvty0uWGQaWUFgNbHvc3G3O8BYEvBWuXZl4HRbyXpZeH6NRFxcMz3cqSYs
         YKXA==
X-Gm-Message-State: ACgBeo025lLlG+aHndX9bd9LMcHMp/w5tmYgg5Zs2ZpB+/U6RLHITW93
        gUI/66DF2JrgsKxb1eTR6CmyFBJAHExQWZNVsBu3axmKafuV8RNk5fDU7uo/m5fBhvQ1wYB2lwQ
        9can1GtgLX9a68MgsKFUmTmPB
X-Received: by 2002:ad4:4a73:0:b0:474:6e80:e1cb with SMTP id cn19-20020ad44a73000000b004746e80e1cbmr22951892qvb.127.1660761724871;
        Wed, 17 Aug 2022 11:42:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6glVEO9fSvKAq1HJGMpFnpPZlbXHRAm3M0HzZs/KuTWZEFuL9lo4h5V4gSz7ZZrHoWpJppyw==
X-Received: by 2002:ad4:4a73:0:b0:474:6e80:e1cb with SMTP id cn19-20020ad44a73000000b004746e80e1cbmr22951879qvb.127.1660761724629;
        Wed, 17 Aug 2022 11:42:04 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id b21-20020ae9eb15000000b006bb6c63114fsm3797780qkg.110.2022.08.17.11.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 11:42:04 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:42:02 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: save LOC in vsyscall test
Message-ID: <Yv02eoqPehWoDEVM@bfoster>
References: <YvoWzAn5dlhF75xa@localhost.localdomain>
 <YvuDMGHcNtjhhMuq@bfoster>
 <20220817112802.29b92729e25313eeec2d44d3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817112802.29b92729e25313eeec2d44d3@linux-foundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:28:02AM -0700, Andrew Morton wrote:
> On Tue, 16 Aug 2022 07:44:48 -0400 Brian Foster <bfoster@redhat.com> wrote:
> 
> > On Mon, Aug 15, 2022 at 12:50:04PM +0300, Alexey Dobriyan wrote:
> > > From: Brian Foster <bfoster@redhat.com>
> > > 
> > > Do one fork in vsyscall detection code and let SIGSEGV handler exit and
> > > carry information to the parent saving LOC.
> > > 
> > > 	[
> > > 		redo original patch,
> > > 		delete unnecessary variables,
> > > 		minimise code changes.
> > > 					--adobriyan
> > > 	]
> > > 
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > > ---
> > 
> > LGTM and passes my quick tests, thanks!
> > 
> > FWIW:
> > 
> > Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
> It would be appropriate for us to include your Signed-off-by.  Please
> send one along?
> 

Sure, feel free to use whichever tags make the most sense:

Signed-off-by: Brian Foster <bfoster@redhat.com>

