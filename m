Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7A50D6A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiDYBji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiDYBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C80855FA1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650850586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b1Yt74DVXPhNomPVzc0lUIN5qi3D0ZNj5fxGBACg4jQ=;
        b=AamYGr3gyKidLY2YtRALRN20VDCeWImq/sd6XEFMrFOEsPNNHExKX1pvDU5c6TWU1caTyN
        nrhuHObmqFBhPjxPJ839UfKWjZTTvYUPJvPVv3aGdrWaqS1BZH5DTy68KxJimfCroP8+X6
        ZqElF4fOYl7AnzSIt/kx0gj7kcwErQw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-jVL4p91QMbuEWIJqzyD-WQ-1; Sun, 24 Apr 2022 21:36:23 -0400
X-MC-Unique: jVL4p91QMbuEWIJqzyD-WQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE8AE38337E0;
        Mon, 25 Apr 2022 01:36:22 +0000 (UTC)
Received: from localhost (ovpn-12-73.pek2.redhat.com [10.72.12.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E5E8C27EA1;
        Mon, 25 Apr 2022 01:36:21 +0000 (UTC)
Date:   Mon, 25 Apr 2022 09:36:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     lizhe <sensor1010@163.com>, dyoung@redhat.com, vgoyal@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/crash_core.c: No judgment required
Message-ID: <YmX7EW4Gs+c1ZueQ@MiWiFi-R3L-srv>
References: <20211210032003.16278-1-sensor1010@163.com>
 <20211214173242.192f47e8@rhtmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214173242.192f47e8@rhtmp>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/21 at 05:32pm, Philipp Rudo wrote:
> Hi lizhe,
> 
> On Thu,  9 Dec 2021 19:20:03 -0800
> lizhe <sensor1010@163.com> wrote:
> 
> > No judgment required ck_cmdline is NULL
> > its caller has alreadly judged, see __parse_crashkernel
> > function
> > 
> > Signed-off-by: lizhe <sensor1010@163.com>
> > ---
> >  kernel/crash_core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index eb53f5ec62c9..9981cf9b9fe4 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -221,9 +221,6 @@ static __init char *get_last_crashkernel(char *cmdline,
> >  		p = strstr(p+1, name);
> >  	}
> >  
> > -	if (!ck_cmdline)
> > -		return NULL;
> > -
> >  	return ck_cmdline;
> >  }
> >  
> 
> I agree that the if-block is not needed and can be removed. However, I
> cannot follow your reasoning in the commit message. Could you please
> explain it in more detail.
> 
> The reason why I think that the 'if' can be removed is that the
> expression can only be true when ck_cmdline = NULL. But with that the
> last three lines are equivalent to
> 
> 	if (!ck_cmdline)
> 		return ck_cmdline;
> 
> 	return ck_cmdline;
> 
> Which simply doesn't make any sense.

Right, the judgement actually introduces redundant codes. As Zhe
replied, maybe you can rewrite the log and repost with your
Signed-off-by, Philipp. As for Author, you two can discuss in private
mail.

