Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8267A5AF560
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiIFUFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIFUF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:05:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F83FBD174
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:00:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s23so7450819wmj.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=VrcGAAHAFPBkHhppiEmlpx+VdwyrqvH6/RbOsQratUo=;
        b=M5h3saQs6F1UBXdjXnvlynP0tALp22uVJtMAUE8iSwB+bkrHqEOrpeStA2fQe0HZLG
         YdZDuD8LI9dc62w8cGcwf2yNtMGV2kRoFK6GdKfUXRceSGpRnCR0rRV3DTzNfjVFjuJU
         dg17JdrVDQJfVv8mYhJu6NQhnD6rI1ItsBHd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VrcGAAHAFPBkHhppiEmlpx+VdwyrqvH6/RbOsQratUo=;
        b=hKwT8bJBOM8k5i2umbGTE54XejhIpnwaLqbpcXVREnL3prvPz09LIzFqb5kmuI7146
         b4i/mHQGxW9KTWXNvPY7xFpWV9fZTVmmpa839V9n8jssF8QloPOlNAMW0iOm4CDBqk5+
         tywFUL5UUpqZwohPiJ9SXlz109O+B2NU8hftTLLFxSKh4Wii6uQCVzc5m+TTEYYy5u/V
         QYe16MiTAS01+Er3E9wkK4QsgXi7H3XdUM1BJJxmqxrN4dhumffOYgPXP4VuczJbxmfk
         PYtujBNfblIcUCkzuW7R1oLa26CoRf3rH0yl3nJYrv7XUQkFkge5rrwnCpYBcTYGTqDe
         Yg7w==
X-Gm-Message-State: ACgBeo1znZj+JgyXZdKArWtQJTVUl0YTCibcOxVCl96VBHzH1DY+jkzx
        yVfvXYU5Hhh3I9zf+f3gpQ/J5Q==
X-Google-Smtp-Source: AA6agR70xNvhnTUF/14KkJLm8rVw//b90FT680b1H6RZc3w8FRaOhwakoWInvlm1LH/O+Z8Yz4H0qw==
X-Received: by 2002:a05:600c:34c2:b0:3a5:d2f5:9d02 with SMTP id d2-20020a05600c34c200b003a5d2f59d02mr37123wmq.153.1662494364404;
        Tue, 06 Sep 2022 12:59:24 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l9-20020adfe9c9000000b00228d94931dcsm4199922wrn.116.2022.09.06.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:59:23 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:59:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Olivier Masse <olivier.masse@nxp.com>, clement.faure@nxp.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jens.wiklander@linaro.org, linaro-mm-sig@lists.linaro.org,
        op-tee@lists.trustedfirmware.org, etienne.carriere@linaro.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2 0/1] tee: Add tee_shm_register_fd
Message-ID: <YxemmVxh5F0fXEPJ@phenom.ffwll.local>
Mail-Followup-To: Sumit Garg <sumit.garg@linaro.org>,
        Olivier Masse <olivier.masse@nxp.com>, clement.faure@nxp.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jens.wiklander@linaro.org, linaro-mm-sig@lists.linaro.org,
        op-tee@lists.trustedfirmware.org, etienne.carriere@linaro.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-media@vger.kernel.org
References: <20220812143055.12938-1-olivier.masse@nxp.com>
 <CAFA6WYM89+SrW2Br-fnFke4djt4GgGHXn7JS3=rxvAa7dAAY7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYM89+SrW2Br-fnFke4djt4GgGHXn7JS3=rxvAa7dAAY7w@mail.gmail.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 01:54:31PM +0530, Sumit Garg wrote:
> Hi Olivier,
> 
> On Fri, 12 Aug 2022 at 20:01, Olivier Masse <olivier.masse@nxp.com> wrote:
> >
> > Add a new ioctl called TEE_IOC_SHM_REGISTER_FD to register a
> > shared memory from a dmabuf file descriptor.
> > This new ioctl will allow the Linux Kernel to register a buffer
> > to be used by the Secure Data Path OPTEE OS feature.
> >
> > Please find more information here:
> > https://static.linaro.org/connect/san19/presentations/san19-107.pdf
> >
> > Patch tested on Hikey 6220.
> >
> 
> AFAIU, for the OP-TEE SDP feature to work you need to have a DMA-BUF
> heap driver for allocating secure buffers through exposed chardev:
> "/dev/dma_heap/sdp". Have you tested it with some out-of-tree driver
> as I can't find it upstream? Also, do you plan to push that upstream
> as well?
> 
> BTW, please add a changelog while sending newer patch-set versions.

Also after the huge discussion last year dma-buf are agreed to be under
the "you need an open source userspace for any new uapi using them" rule
that all gpu drivers are under.

Does this exist here?
-Daniel

> 
> -Sumit
> 
> > Etienne Carriere (1):
> >   tee: new ioctl to a register tee_shm from a dmabuf file descriptor
> >
> >  drivers/tee/tee_core.c   | 38 +++++++++++++++
> >  drivers/tee/tee_shm.c    | 99 +++++++++++++++++++++++++++++++++++++++-
> >  include/linux/tee_drv.h  | 11 +++++
> >  include/uapi/linux/tee.h | 29 ++++++++++++
> >  4 files changed, 175 insertions(+), 2 deletions(-)
> >
> > --
> > 2.25.0
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
