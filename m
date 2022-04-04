Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023264F190A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378219AbiDDQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350761AbiDDQBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EB4B1E3C5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649087943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z1niaxx1tk5iaYOpyUwKb+7ihoIBIoE+g3zT8abXH64=;
        b=LHfLNfuzn/czJWhFEjlFCj8TiA/b1cmUxdp8gUqx4en7Ia6h+P7FVqLynAA/lrjrjPBiNP
        w+JBPfl/lUSOQhWkKjVx9rYM8M6zpcYBb/SnssGdqmSAQOB5hSni1TC1BfjIf9mxAYBJ70
        m4QtIsmhXLYRaKGXqvBq0XEmsbktZvg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-eIAxkngwN7uHJSKc0iO7bA-1; Mon, 04 Apr 2022 11:59:02 -0400
X-MC-Unique: eIAxkngwN7uHJSKc0iO7bA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 731E71C068C4;
        Mon,  4 Apr 2022 15:59:00 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EF141457F04;
        Mon,  4 Apr 2022 15:58:53 +0000 (UTC)
Date:   Mon, 4 Apr 2022 11:58:50 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, kbuild-all@lists.01.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        eparis@redhat.com, dai.shixin@zte.com.cn,
        Yang Yang <yang.yang29@zte.com.cn>, linux-audit@redhat.com,
        ink@jurassic.park.msu.ru, huang.junhua@zte.com.cn,
        guo.xiaofeng@zte.com.cn, mattst88@gmail.com
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
Message-ID: <YksVuhfv8weLCxX/@madcap2.tricolour.ca>
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
 <62465bf3.1c69fb81.d5424.365e@mx.google.com>
 <2777189.mvXUDI8C0e@x2>
 <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com>
 <624803f7.1c69fb81.972da.2dd0@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624803f7.1c69fb81.972da.2dd0@mx.google.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-02 08:06, CGEL wrote:
> On Fri, Apr 01, 2022 at 10:16:45AM -0400, Paul Moore wrote:
> > On Fri, Apr 1, 2022 at 9:39 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> > > > On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > > > > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > > > > syscalls, I would consider that a bug which should be fixed.
> > > > > >
> > > > > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > > > > be forcible or be a rule that can be configure? I think configure is
> > > > > > better.
> > > > >
> > > > > It isn't clear to me exactly what you are asking, but I would expect
> > > > > the existing audit syscall filtering mechanism to work regardless if
> > > > > the syscall is valid or not.
> > > >
> > > > Thanks, I try to make it more clear. We found that auditctl would only
> > > > set rule with syscall number (>=0 && <2047) ...
> > 
> > That is exactly why I wrote the warning below in my response ...
> >
> I think the question is more clear now.
> 
> 1) libaudit.c wants to forbid setting invalid syscall, but inconsistent
> Currently way(>=0 && <2047) is inconsistent, syscall with number 2000 and
> syscall with number 3000 are both invalid syscall. But 2000 can be set by
> auditctl, and 3000 cannot be set by auditctl.
> A better way to do this forbidden is to use __NR_syscalls(asm-generic/unistd.h).
> 
> 2) if libaudit.c do the right forbidden, kernel better ignore invalid syscall
> See this patch.
> 
> If we want audit invalid syscall as you said before. libaudit.c should not
> do the forbidden, auditctl should allow setting syscall rule with 'any' number.
> So do you think we should fix libaudit.c?

I'm having a bit of trouble understanding what you've said above.

The kernel ultimately must protect itself from malice and mistakes, so
it must verify all data sent to it.

Userspace can help by knowing what that kernel policy is so it can avoid
violating that policy or provide useful feedback if it can't.  Userspace
can be used to make things more efficient, but the kernel is the last
step for security.

If userspace and the kernel are mismatched or out of sync, then the
kernel enforces policy to protect itself.

> > > > > Beware that there are some limitations
> > > > > to the audit syscall filter, which are unfortunately baked into the
> > > > > current design/implementation, which may affect this to some extent.
> > 
> > -- 
> > paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

