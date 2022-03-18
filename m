Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC294DD68A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiCRIzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbiCRIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8321F1D3063
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647593649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Zb6QBd56zzeTvjztSna+nrWQNFaTfAaR5NapeEZA0o=;
        b=ZGStNvMmj1Pgv8D+q7vhJ3Cusny3kC0oeobfPqQJYbM1xGlujMWL1ROXhv9ss0tAtYrAYq
        Laa0Vuj+u0fkZuoyXrBIV+9UR8t1EdE7o1VokciXN4V+HpZ8pF5scr+CaSzdWowW3BR8hq
        v+l2p5FEB5ZhsoYvhIT5QfoLe06jwKk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-ICezWsw6P0-QOFkzyJ4WuQ-1; Fri, 18 Mar 2022 04:54:06 -0400
X-MC-Unique: ICezWsw6P0-QOFkzyJ4WuQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1032E296A617;
        Fri, 18 Mar 2022 08:54:06 +0000 (UTC)
Received: from localhost (ovpn-13-174.pek2.redhat.com [10.72.13.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39B9543E917;
        Fri, 18 Mar 2022 08:54:04 +0000 (UTC)
Date:   Fri, 18 Mar 2022 16:54:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     Coiby Xu <coiby.xu@gmail.com>, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 1/3] kexec: clean up
 arch_kexec_kernel_verify_sig
Message-ID: <YjRIqdAH2nV+DRgW@MiWiFi-R3L-srv>
References: <20220304020341.85583-1-coiby.xu@gmail.com>
 <20220304020341.85583-2-coiby.xu@gmail.com>
 <YjMtb7u3/sAWG0/7@MiWiFi-R3L-srv>
 <20220318024803.pkkwgknwur2y75mt@Rk>
 <YjP8DTnAZbq646rF@MiWiFi-R3L-srv>
 <20220318071824.yq3idr5eoogvtslb@Rk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318071824.yq3idr5eoogvtslb@Rk>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/18/22 at 03:18pm, Coiby Xu wrote:
> On Fri, Mar 18, 2022 at 11:27:09AM +0800, Baoquan He wrote:
> > On 03/18/22 at 10:48am, Coiby Xu wrote:
> > > On Thu, Mar 17, 2022 at 08:45:35PM +0800, Baoquan He wrote:
> > > > On 03/04/22 at 10:03am, Coiby Xu wrote:
> > > > > From: Coiby Xu <coxu@redhat.com>
> > > > >
> > > > > commit 9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,
> > > > > powerpc: factor out kexec_file_ops functions" allows implementing
> > > > > the arch-specific implementation of kernel image verification
> > > > > in kexec_file_ops->verify_sig. Currently, there is no arch-specific
> > > > > implementation of arch_kexec_kernel_verify_sig. So clean it up.
> > > >
> > > > This is a nice cleanup, while the log may need to be improved. You
> > > > should run ./scripts/checkpatch.pl on your patch before sending out.
> > > > When we refer to a commit in log, please refer to
> > > > Documentation/process/submitting-patches.rst.
> > > 
> > > Thanks for the reminder! I've used git pre-commit hook to run
> > > scripts/checkpatch.pl automatically but obviously this hook doesn't
> > > apply to "git rebase --continue" and currently this no git hook that
> > > for this situation. I'll use the following trick [1] to avoid this
> > > mistake in the future,
> > >  $ git rebase -i HEAD~3 --reschedule-failed-exec --exec "git show | perl ./scripts/checkpatch.pl"
> > 
> > Sorry, Coiby. It could be late yesterday so I was dizzy when writing
> > down the comment, I didn't make my concern clear. What I meant is
> > the referenced commit in log should be taken in a standard format.
> > Abstracted one paragraph of Documentation/process/submitting-patches.rst
> > here. We usually take the first 12 characters of the commit SHA-1 ID
> > in log, but not the whole of them.
> > 
> > =====
> > If you want to refer to a specific commit, don't just refer to the
> > SHA-1 ID of the commit. Please also include the oneline summary of
> > the commit, to make it easier for reviewers to know what it is about.
> > Example::
> > 
> >        Commit e21d2170f36602ae2708 ("video: remove unnecessary
> >        platform_set_drvdata()") removed the unnecessary
> >        platform_set_drvdata(), but left the variable "dev" unused,
> >        delete it.
> > =====
> > 
> > And the right parenthesis enclousing the commit subject is missing.
> 
> Thanks for the detailed explanation! Your message has got across to me
> successfully:) I have ran scripts/checkpatch.pl manually after seeing your
> first reply and checkpatch.pl reported the exact same issues as explained
> by you today. My approach of avoiding making mistakes on format is to run
> checkpatch.pl automatically in the git precommit hook so I don't need to
> remember the details about format. I had expected the git precommit hook
> could help me find the issues pointed out by you but obviously it failed.
> So I tried to find out what's wrong. I think the format issues were
> introduced when doing rebase to improve the old version and the precommit
> hook wasn't triggered in this case. Another thing I still missed is I used
> "git diff --cached | scripts/checkpatch.pl" in the pre-commit hook which
> obviously won't check the format issue in the commit message (it only
> check the format issue in the code). With the two problems resolved, I
> shall not make format mistakes in the future:)
> 
> Btw, checkpatch.pl seems to requires referring to a specific commit on
> the same line,
> 
>     ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops functions")'
>     #6:     commit 9ec4ecef0af7 ("kexec_file,x86, powerpc: factor out
> kexec_file_ops
>     functions") allows implementing the arch-specific implementation of kernel
>     total: 1 errors, 0 warnings, 61 lines checked
>     NOTE: For some of the reported defects, checkpatch may be able to
>           mechanically convert to the typical style using --fix or --fix-inplace.
>     "[PATCH] kexec: clean up arch_kexec_kernel_verify_sig" has style problems, please review.
>     NOTE: If any of the errors are false positives, please report
>           them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> Is this a false positive?

No, it's not. Youp probably copied the commit subject and modified it.
Please copy below two lines into your patch to replace and try again.

commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
functions")

> 
> > 
> > > 
> > > [1] https://stackoverflow.com/a/70568833/1203522
> > > 
> > > 
> > > --
> > > Best regards,
> > > Coiby
> > > 
> > 
> 
> -- 
> Best regards,
> Coiby
> 

