Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BED5992D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiHSBwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiHSBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:52:04 -0400
Received: from mail.thepaulodoom.com (www.thepaulodoom.com [45.77.108.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6841DD7D19
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thepaulodoom.com;
        s=mail; t=1660873920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjpgMNnmDq2/MSBZfMNVxTC/VbXPi9TeVCkKsr+LkB4=;
        b=gAVgxHvY4HCYUqqRG6DeA01/WNcQW9A+7olP7jPyDAK0MMU1+PHwrEE5+I/DZZx7dW7StY
        y8faSL7QokA68IUXpfr+VQZ+5FXJYDDIjZRPGKY0u64FiVreT9h1wKWcNUPY+UishoDBZD
        zniU1sbEOeF/8obSxt5S7T7Tg++rq9o1h0NHXqmV7PW2rG5p6265x8vynL/QLiVFrrywEY
        K1pWHlsuQSfjTk1GzIZ70VwpRnB3dD1xcNrYt/RsN7MpFKYpIfDHHqzuJmoJDVtz/rWb4J
        Do3UnYW9+SwUpVdi2Q/vCHNOze9dE5PTW00xwse+RlT20kcS2JWxUph/0ZbCZapWrdc4j4
        CgaGU4h3O0l3uTCJqnnXMOHEPfRSECMXJVmegEcBL7RARAQkdST2zK0ioeBWCw+vQYvX0r
        h3C9qEXQO2HPjzHAur2YEsLJpV3XYVp0w18u2rdUE6Ay9f3ZBeGZRyEOXyozy8bqT4cN5i
        wphpi5740iv7uzQq5RWaHqOBTrhA7k6C0vY45VtGOoj4YlDxHIA86xqZksULZByAgO5Aw2
        r3h0gpNKhHSvlpZJpxrmbj8LdgdmiEzBjBQ7+vAYBRYsR+goNf8Dag8vRG7rq5TQEdw77V
        FEy7Kn5DaQFoLpCs6BJZVuGOIpz5ttpFjY9/ApoZAkGzZdElcMzi4=
Received: from gus-fring.localdomain (c-98-240-189-147.hsd1.mn.comcast.net [98.240.189.147])
        by vultr.guest (OpenSMTPD) with ESMTPSA id 3c7cd58b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 19 Aug 2022 01:52:00 +0000 (UTC)
Date:   Thu, 18 Aug 2022 20:52:37 -0500
From:   Paul Lemmermann <thepaulodoom@thepaulodoom.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: char: mem: changed 'unsigned' to 'unsigned int'
Message-ID: <Yv7s5dedhRaDlsAC@gus-fring.localdomain>
References: <YvxF0yn07ztg9r4A@gus-fring.localdomain>
 <Yv5SG8XMR2mZGAqG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv5SG8XMR2mZGAqG@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 04:52:11PM +0200, Greg KH wrote:
> On Tue, Aug 16, 2022 at 08:35:31PM -0500, Paul Lemmermann wrote:
> > found with checkpatch.pl
> 
> That is a very sparse changelog text.
> 
> Why make this change?  Please be descriptive.
> 
I wanted to make this change to be more fitting with the kernel coding
guidelines, and to reduce a WARNING made with checkpatch preferring the
use of 'unsigned int' over 'unsigned'. With NOMMU_MAP_COPY defined in
'include/linux/fs.h' as an unsigned integer, I felt like the change was
fitting. I was quickly reminded that the changelog was not properly done, 
and I now understand that, and will learn from my mistake in the future.
As I am a new kernel contributor, and looking to hone my skills, what are 
my next steps? 

Should I:

o Drop the patch and resubmit it,
o Simply drop the patch,
o Could I change it somehow?,
o Or something else?

Thank you very much for your time and effort,
- Paul

P.S. Resending this as reply all, as I quickly relized I forgot to do
after I send the email to Greg.
