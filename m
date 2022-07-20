Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB057B6BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiGTMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiGTMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:49:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2535F33353
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:49:51 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e132so16304229pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+8Qki0HVufDaKzMLo0NKMo8j+UvpS8c1/KtUoIeE8vk=;
        b=7zy1gUMe3KGqvcPlYRoA7bdFW5xfhxkMC4zdcLTxML1mAFglVSHW24gB1OtcGQGOP4
         CIbeZ9TZKev2+ELSWsO1fIT94WtnQqPTD6p+DZsGpKJcpBl4OKGMUGmXlqiucKBu2b3h
         hVsdW+JtVdhWyH44l55jPHn5KlrutboTUMHrrKCwnmAz6O4lPnJuNwGDq+CSXy52srNA
         VQFH/2LNVKjYVivrdyDKrlw+LTLuB1ZCcMeI5nWJckaAexXgMGxuIEQ8iEihKFhF+W1B
         +DhMof2yGmfJNA6fSd0rwk5eojhDqjBCSgVZMWq6/ZfUw6f7ZxLgayj5x/yRdShn9HwL
         BOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+8Qki0HVufDaKzMLo0NKMo8j+UvpS8c1/KtUoIeE8vk=;
        b=qQ+KLMmkHwahMvs/v3l37LwLI4WYPVx9ahI5nWHXzqWWh3TR+TiZMZh7U0OQqiToxq
         rDspJpAX+J7E1FS2botZ7WDAvJ9E/n7yEWAwBrRKJVkyEVxdfm1xyxPwrcH6tW6ZDUmh
         uFz/h2mctGGeDK5+/6DssH7AVyfT68mzAV30WA2yVcZT4NKZzUY7ioAYjp+P8qbYpROW
         vYT1XZk1HjRLoF0vSqgoptpXNjt+bIisoA+n36MNRH+WUo4PVj7/rOLa9uZg/0alZdZs
         aJ3myuy18r5b+ASx91kHJ0+plMobBZUJxj+5LL13rlgnGHROUs+xjFD7LL2pj2kdrlVJ
         SYJQ==
X-Gm-Message-State: AJIora9rJepV19uSsUqy7bej8qXQnFEdTQH8Li/qf7Nt5mfiQ6+xe6fn
        gFDPwe+5WGfXoQzj3XPQM+ju0j2GWa3qevWYXpQdl47evwQumw==
X-Google-Smtp-Source: AGRyM1sJ0IRtAfVjzOEuE80nepn5SCDyj8LDLMHR3JuatXrCaXXV8Al7iww6kh4xv9Bn0EgO/UxrWdKUPkhG5yR1nmQ=
X-Received: by 2002:a05:6a00:b55:b0:52a:db7b:2880 with SMTP id
 p21-20020a056a000b5500b0052adb7b2880mr38284317pfo.22.1658321390471; Wed, 20
 Jul 2022 05:49:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:d06f:0:b0:535:c52f:e1cf with HTTP; Wed, 20 Jul 2022
 05:49:49 -0700 (PDT)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <20220720042726.GA5574@lst.de>
References: <20220720015538.15838-1-nbowler@draconx.ca> <20220720042726.GA5574@lst.de>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 20 Jul 2022 08:49:49 -0400
Message-ID: <CADyTPEyp4WXYW63gBCST+4J3nTYdV8XkyF5YFwZrMz0TcG=Qng@mail.gmail.com>
Subject: Re: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit userspace.
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-20, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jul 19, 2022 at 09:55:38PM -0400, Nick Bowler wrote:
>> Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
>> the initialization of compat_ioctl from the nvme block_device_operations
>> structures.
>>
>> Presumably the expectation was that 32-bit ioctls would be directed
>> through the regular handler but this is not the case: failing to assign
>> .compat_ioctl actually means that the compat case is disabled entirely,
>> and any attempt to submit nvme ioctls from 32-bit userspace fails
>> outright with -ENOTTY.
>
> I don't think wiring up the native version is the right thing to do,
> this needs to be blkdev_compat_ptr_ioctl, just like we use
> compat_ptr_ioctl for the character device nodes.

OK, I will try that.

Thanks,
  Nick
