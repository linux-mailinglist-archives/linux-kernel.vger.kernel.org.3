Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A248D235
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 07:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiAMGEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 01:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiAMGEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 01:04:45 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1708EC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:04:45 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t66so6133211qkb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 22:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Tgq8vnBLaqoGtVnAIFn+qw1j/rzB5eIxYzxKDw0gVo=;
        b=W0ySxSkyeJF9JAq4q09//RzzelwHreCVB1NcvLZOL2YWFSv2afey/QkMI8iagRZWgg
         sG+NTKq6NxNuYnAfVuOQUGNKyIy8Xc+ifAXUvRzaBU5NQDcYAwrikObbhFzHNy7i/q76
         AcOkgmwN9miG/RDxeNt2HWRReQpNJDqatBRsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Tgq8vnBLaqoGtVnAIFn+qw1j/rzB5eIxYzxKDw0gVo=;
        b=NW01slXnnlV/rHulK5f/jQ8S057vW+YaIYlJFcFqX21QEQunE8j8jaeTSLv6pk6brx
         3POyPONBJf6hcw5/4kWusUDPPAFwcUq8KLfa+CPkUw7gLAisRa6XflGp30HOXmo2kZH9
         Fazt40X4YPCwrkqxdi409ZCfzpZcQecMFC6NTwGM22JGo9sS+SfnZGP7AFhzvGRJ7sYH
         b4pbxVBeWhRXxE9cA6gKTIgurcb+5BmYVlzh0zvPgRjpItk2Wp3e4exSVBKIrkeYEYvI
         JwkBPfdBBgIP0SACH0AOnIw3LG5z4p3B/JGd+MCbWy1dbXvG4G8KtkbmqwFsviT6gflk
         wJtQ==
X-Gm-Message-State: AOAM533JGgxhfXRrt03QH5pkzHvLluoGdrg+WbF+LSS72ExGuMVTmLis
        KAsGdpZsc01TmWYJKHP8Q8r3XN9Tyja4OyMwlAU=
X-Google-Smtp-Source: ABdhPJxEguI+wRJO1BoxhzYw20IedIttWTnkBc/KK+Rr5R4cqC4R49HmKReWXHfctQ4l9hLQxS7Tzy0931B7g9DQjYw=
X-Received: by 2002:a05:620a:f0b:: with SMTP id v11mr2143338qkl.243.1642053883592;
 Wed, 12 Jan 2022 22:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20211216062405.415888-1-amitay@ozlabs.org> <20211216062405.415888-3-amitay@ozlabs.org>
 <YbrzHf+wRKzTFxEm@kroah.com>
In-Reply-To: <YbrzHf+wRKzTFxEm@kroah.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Jan 2022 06:04:31 +0000
Message-ID: <CACPK8XeBArKre_-Sg+m+FaB9ALy++hBJUE+KQx-2qgxrB384cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT ioctl
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Amitay Isaacs <amitay@ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, 16 Dec 2021 at 08:04, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 16, 2021 at 05:24:05PM +1100, Amitay Isaacs wrote:
> > FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
> > the response received by sbefifo device from sbe.  The timeout affects
> > only the read operation on sbefifo device fd.
> >
> > Certain SBE operations can take long time to complete and the default
> > timeout of 10 seconds might not be sufficient to start receiving
> > response from SBE.  In such cases, allow the timeout to be set to the
> > maximum of 120 seconds.
> >
> > Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> > ---
> >  drivers/fsi/fsi-sbefifo.c | 44 +++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fsi.h  | 14 +++++++++++++
> >  2 files changed, 58 insertions(+)

I'm taking over this patch series on behalf of Amitay.

> Where is the userspace tool that uses this new ioctl?

The userspace is a library called 'libpdbg'. Amitay has some patches
prepared that use this new ioctl here:

 https://github.com/amitay/pdbg/commits/ioctl

> And again, why does it have to be an ioctl?  Where is this now
> documented?  What are the units of the value?

We need a way for userspace to tell the driver that subsequent
operations (writes to the chardev, that cause the driver to send data
to a microcontroller over a fsi link) are expected to take a longer
time, so the kernel should wait longer before declaring the operation
timed out.

The kernel driver doesn't know about the specific operation, and we
don't want to have that policy in the kernel, so userspace will set
the timeout appropriately.

I'll send a new version, as Amitay wants to remove the one-shot nature
of the configuration, and instead have it persist. I'll update the
patch to make it clear what the units are.

Where do we usually stick documentation for ioctls such as this one?

Cheers,

Joel
