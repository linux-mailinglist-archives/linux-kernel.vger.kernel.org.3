Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9116646D54A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhLHOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:14:47 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:54516 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229550AbhLHOOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638972672;
        bh=LBc4gpSYAc1p0ve8zOKgnub9ICw3kW2zeiC0VG7Rg4U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LLndYwNjSHwaXZhLO4QMAZ/CFZfXYbeIPfFsL+GodMQQY6+fgoYbwVHZR/4tPrO/g
         sgXktFiH3P+soQjboUQ0tSoKj92b1hMStqBz0jRHDRKZo03oHgrCYlcwqigAiQoGxt
         giKt0rO6sqpnb22DlOS1JAtsv3eCc3oYZScqFWpo=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A84BD12802F2;
        Wed,  8 Dec 2021 09:11:12 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ArFS9qlh7XCj; Wed,  8 Dec 2021 09:11:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1638972672;
        bh=LBc4gpSYAc1p0ve8zOKgnub9ICw3kW2zeiC0VG7Rg4U=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=LLndYwNjSHwaXZhLO4QMAZ/CFZfXYbeIPfFsL+GodMQQY6+fgoYbwVHZR/4tPrO/g
         sgXktFiH3P+soQjboUQ0tSoKj92b1hMStqBz0jRHDRKZo03oHgrCYlcwqigAiQoGxt
         giKt0rO6sqpnb22DlOS1JAtsv3eCc3oYZScqFWpo=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 201C9128007C;
        Wed,  8 Dec 2021 09:11:11 -0500 (EST)
Message-ID: <dd43783ae76ad3238d99f75d8aaf95e20ad28b79.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 08 Dec 2021 09:11:09 -0500
In-Reply-To: <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
         <20211207202127.1508689-17-stefanb@linux.ibm.com>
         <20211208125814.hdaghdq7yk5wvvor@wittgenstein>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-08 at 13:58 +0100, Christian Brauner wrote:
> On Tue, Dec 07, 2021 at 03:21:27PM -0500, Stefan Berger wrote:
[...]
> > @@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct
> > fs_context *fc)
> >  
> >  static void securityfs_kill_super(struct super_block *sb)
> >  {
> > +	struct user_namespace *ns = sb->s_fs_info;
> > +
> > +	if (ns != &init_user_ns)
> > +		ima_fs_ns_free_dentries(ns);
> 
> Say securityfs is unmounted. Then all the inodes and dentries become
> invalid. It's not allowed to hold on to any dentries or inodes after
> the super_block is shut down. So I just want to be sure that nothing
> in ima can access these dentries after securityfs is unmounted.
> 
> To put it another way: why are they stored in struct ima_namespace in
> the first place? If you don't pin a filesystem when creating files or
> directories like you do for securityfs in init_ima_ns then you don't
> need to hold on to them as they will be automatically be wiped during
> umount.

For IMA this is true because IMA can't be a module.  However, a modular
consumer, like the TPM, must be able to remove its entries from a
mounted securityfs because the code that serves the operations is going
away.  In order to do this removal, it needs the dentries somewhere. 
The current convention seems to be everything has a directory in the
top level, so we could call d_genocide() on this directory and not have
to worry about storing the dentries underneath, but I think we can't
avoid storing the dentry for the top level directory.

James


